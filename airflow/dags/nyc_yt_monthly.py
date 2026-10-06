from datetime import timedelta
import logging
import pendulum
import docker
from airflow import DAG
from airflow.exceptions import AirflowException
from airflow.operators.bash import BashOperator
from airflow.operators.python import PythonOperator


def spark_submit(file_path, parameters=None):
    """Run a Python file using spark-submit inside the Spark container."""

    parameters = parameters or []

    client = docker.from_env(timeout=3600)

    try:
        container = client.containers.get("asb-spark-iceberg")

        if container.status != "running":
            raise AirflowException("asb-spark-iceberg must be running")

        command = [
            "spark-submit",
            "--master",
            "local[*]",

            # Keep this commented if hadoop-aws is already installed or
            # configured through spark-defaults.conf.
            # "--packages",
            # "org.apache.hadoop:hadoop-aws:3.3.4",

            file_path,
        ]

        command.extend(parameters)

        logging.info("Executing Spark command: %s", " ".join(command))

        execution = client.api.exec_create(
            container.id,
            command,
            stdout=True,
            stderr=True,
        )

        for chunk in client.api.exec_start(
            execution["Id"],
            stream=True,
        ):
            logging.info(
                chunk.decode("utf-8", errors="replace").rstrip()
            )

        result = client.api.exec_inspect(execution["Id"])
        exit_code = result.get("ExitCode")

        if result.get("Running"):
            raise AirflowException(
                "Spark process is unexpectedly still running"
            )

        if exit_code != 0:
            raise AirflowException(
                f"Spark ingestion failed with exit code {exit_code}"
            )

    finally:
        client.close()

with DAG(
    dag_id="nyc_yellow_taxi_pipeline",
    description="Monthly Yellow Taxi ingestion: SeaweedFS raw to Iceberg bronze",
    start_date=pendulum.datetime(2026, 5, 1, tz="UTC"),
    schedule='@monthly',
    catchup=True,
    max_active_runs=1,
    default_args={
        "owner": "lakehouse",
        "depends_on_past": False,
        "retries": 1,
        "retry_delay": timedelta(seconds=10),
    },
    tags=["nyc-tlc", "yellow-taxi", "lakehouse"],
) as dag:

    create_namespaces = PythonOperator(
        task_id="create_namespaces",
        python_callable=spark_submit,
        op_kwargs={
            "file_path": "/opt/spark/scripts/00_create_namespaces.py",
            "parameters": [],
        },
    )

    ingest_raw_taxi_zone = BashOperator(
        task_id="ingest_raw_taxi_zone",
        bash_command="""
        python -u /opt/airflow/scripts/01_ingest_raw_taxi_zone.py
        """,
    )

    ingest_raw_yellow_trips = BashOperator(
        task_id="ingest_raw_yellow_trips",
        bash_command="""
        python -u /opt/airflow/scripts/01_ingest_raw_yellow_trips.py \
            --year {{ data_interval_start.year }} \
            --month {{ data_interval_start.month }}
        """,
    )

    ingest_bronze_nyc_zones = PythonOperator(
        task_id="ingest_bronze_nyc_zones",
        python_callable=spark_submit,
        op_kwargs={
            "file_path": "/opt/spark/scripts/02_ingest_bronze_nyc_zones.py",
            "parameters": [],
        },
    ),

    ingest_bronze_yellow_trips = PythonOperator(
        task_id="ingest_bronze_yellow_trips",
        python_callable=spark_submit,
        op_kwargs={
            "file_path": "/opt/spark/scripts/02_ingest_bronze_yellow_trips.py",
            "parameters": [
                "--month",
                "{{ data_interval_start.strftime('%Y-%m') }}"
            ],
        },
    )

    create_namespaces >> ingest_raw_taxi_zone >> ingest_bronze_nyc_zones
    create_namespaces >> ingest_raw_yellow_trips >> ingest_bronze_yellow_trips