import duckdb 
import kagglehub
from pathlib import Path

AW_SCHEMA_NAMES = [
    "person",
    "sales",
    "human_resources",
    "production",
    "purchasing",
]

def get_all_files(file_path: str, file_pattern: str):
    return Path(file_path).glob(file_pattern)

def get_duckdb_conn(dbname: str = "asb_oltp.duckdb") -> duckdb.DuckDBPyConnection:
    """Return DuckDB generic connection. We will use this for all ingestion processes.
    """
    return duckdb.connect(dbname)

def create_schema(conn: duckdb.DuckDBPyConnection, schema_name: str):
    """Create schema_name on DuckDB connection
    """
    conn.sql(f"CREATE SCHEMA IF NOT EXISTS {schema_name};")

if __name__=="__main__":
    # Get generic DuckDB connection to be used for all databases processes
    duckdb_conn = get_duckdb_conn()

    # Create all schema required for AdventureWorks OLTP
    for schema_name in AW_SCHEMA_NAMES:
        create_schema(duckdb_conn, schema_name)

    # Read all SQL files
    sql_files = get_all_files("00_setup/02_sql_duckdb", "*.sql")
    for sql_file in sql_files:
        with open(sql_file) as f:
            sql_str = f.read().format(folder_path="00_setup/01_data_files")

        # Create tables on DuckDB generic connection
        duckdb_conn.sql(sql_str)