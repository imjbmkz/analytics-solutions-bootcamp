import re
import duckdb 
import kagglehub
from os import getenv
from pathlib import Path
from dotenv import load_dotenv
from tqdm import tqdm

###############################################################
# 01 - LOADING ENVIRONMENT AND CONSTANT VARIABLES
###############################################################

# Load environment variables from .env file
load_dotenv()

# Read database connection settings from .env file
DUCKDB_OLTP_CONNECTION = getenv("DUCKDB_OLTP_CONNECTION")
DUCKDB_OLAP_CONNECTION = getenv("DUCKDB_OLAP_CONNECTION")
POSTGRES_HOST = getenv("POSTGRES_HOST")
POSTGRES_PORT = getenv("POSTGRES_PORT")
POSTGRES_DB_OLTP = getenv("POSTGRES_DB_OLTP")
POSTGRES_DB_OLAP = getenv("POSTGRES_DB_OLAP")
POSTGRES_USER = getenv("POSTGRES_USER")
POSTGRES_PASSWORD = getenv("POSTGRES_PASSWORD")

# AdventureWorks OLTP schema
AW_SCHEMA_NAMES = [
    "person",
    "sales",
    "human_resources",
    "production",
    "purchasing",
]

# Kaggle datasets: Note that sometimes Kaggle datasets have multiple files
KAGGLE_DATASETS = [
    "yashch05/direct-to-consumer-e-commerce-funnel-dataset"
]
    
###############################################################
# 02 - DEFINING HELPER FUNCTIONS
###############################################################

def clean_file_name(file_name: str) -> str:
    # Get only the file name without extension 
    cleaned_file_name = file_name.lower().split(".")[0]

    # Replace all whitespaces and special characters with underscores
    cleaned_file_name = re.sub(r"[^\w]+", "_", cleaned_file_name)

    # Strip leading and trailing underscores and collapse consecutive underscores 
    return re.sub(r"_+", "_", cleaned_file_name).strip("_")

def get_all_files(file_path: str, file_pattern: str):
    return list(Path(file_path).glob(file_pattern))

def get_duckdb_conn(dbname: str = "asb_oltp.duckdb") -> duckdb.DuckDBPyConnection:
    """Return DuckDB generic connection. We will use this for all ingestion processes.
    """
    return duckdb.connect(dbname)

def run_sql(conn: duckdb.DuckDBPyConnection, sql: str, run_alias: int = 0,
            text_to_replace: str = None, text_replacement: str = None): 
    """Run SQL scripts in DuckDB"""
    conn.sql(sql)

    # Run the same script on attached database via alias
    if all(t is not None for t in (text_to_replace, text_replacement)):
        if run_alias==1:
            sql_new = sql.replace(text_to_replace, f"{text_replacement}")
            conn.sql(sql_new)

def create_schema(conn: duckdb.DuckDBPyConnection, schema_name: str):
    """Create schema_name on DuckDB connection
    """
    run_sql(conn, f"CREATE SCHEMA IF NOT EXISTS {schema_name};")

def attach_postgres(
    conn: duckdb.DuckDBPyConnection, 
    pg_host: str, 
    pg_port: int, 
    pg_db: str, 
    pg_user: str, 
    pg_password: str,
    pg_alias: str
) -> tuple:
    """Attach PostgreSQL to DuckDB. Returns (success_status, pg_alias)
        success_status = 1 means successful, 0 means failed
    """
    try:
        # Install and load postgres library
        run_sql(conn, "INSTALL postgres;")
        run_sql(conn, "LOAD postgres;")

        # Construct SQL ATTACH statement 
        attach_stmt = f"ATTACH 'host={pg_host} port={pg_port} dbname={pg_db} user={pg_user} password={pg_password}' AS {pg_alias} (TYPE POSTGRES)"

        # Attach postgres
        run_sql(conn, attach_stmt)

        # Handling nulls
        run_sql(conn, "SET pg_null_byte_replacement = '?';")

        return (1, pg_alias)

    except Exception as e:
        print(f"Attaching Postgre connection to database is not successful. {e}")
        print("Skipping Postgre table creation.")
        return (0, )

def get_kaggle_data_path(kaggle_dataset: str, file_type: str = "csv"):
    # Returns a list of paths containing the download Kaggle datasets 
    data_path = kagglehub.dataset_download(kaggle_dataset)
    files = list(Path(data_path).glob(f"*.{file_type}"))
 
    return files

###############################################################
# 02 - EXECUTING PROCESS
###############################################################

if __name__=="__main__":
    # Get generic DuckDB connection to be used for all databases processes
    duckdb_conn = get_duckdb_conn(DUCKDB_OLTP_CONNECTION)

    # Create all schema required for AdventureWorks OLTP
    print("Creating schemas for AdventureWorks dataset...")
    for schema_name in tqdm(AW_SCHEMA_NAMES):
        create_schema(duckdb_conn, schema_name)

    # Attach PostgreSQL database to DuckDB
    pg_alias_attach_success, pg_alias = attach_postgres(
        duckdb_conn, 
        POSTGRES_HOST,
        POSTGRES_PORT,
        POSTGRES_DB_OLTP,
        POSTGRES_USER,
        POSTGRES_PASSWORD,
        "pg_oltp"
    )

    # Read all SQL files for AdventureWorks ingestion
    print("Creating tables for AdventureWorks dataset...")
    sql_files = get_all_files("00_setup/02_sql_duckdb", "*.sql")
    for sql_file in tqdm(sql_files):
        with open(sql_file) as f:
            sql = f.read().format(folder_path="00_setup/01_data_files")

        # Create tables on DuckDB generic connection; Run the same script on Postgre if attachment is successful
        run_sql(duckdb_conn, sql, pg_alias_attach_success, 
                "CREATE OR REPLACE TABLE ", f"CREATE OR REPLACE TABLE {pg_alias}.")

    # Read all downloaded data files from Kaggle; Note that this only accommodates CSV files
    print("Create tables for Kaggle datasets...")
    for kaggle_dataset in tqdm(KAGGLE_DATASETS):
        dataset_files = get_kaggle_data_path(kaggle_dataset)
        for f in tqdm(dataset_files, leave=False):
            cleaned_f = clean_file_name(f.name)
            sql = f"""
                CREATE OR REPLACE TABLE {cleaned_f} AS 
                SELECT * 
                FROM read_csv('{f.as_posix()}');
            """

            # Create tables on DuckDB generic connection
            run_sql(duckdb_conn, sql, pg_alias_attach_success, 
                    "CREATE OR REPLACE TABLE ", f"CREATE OR REPLACE TABLE {pg_alias}.")