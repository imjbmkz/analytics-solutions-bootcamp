""" Run from root python src/01_ingest_csv.py
"""

import duckdb
from pathlib import Path
from tqdm import tqdm

###############################################################
# 01 - LOADING ENVIRONMENT AND CONSTANT VARIABLES
###############################################################
CSV_FILE_PATH = "data"
SQL_FILE_PATH = "src/sql/oltp"
DUCKDB_OLTP_CONNECTION = "asb_oltp.duckdb"
WWI_SCHEMAS = [
    "application"
    ,"purchasing"
    ,"sales"
    ,"warehouse"
    ,"purchasing"
]

###############################################################
# 02 - DEFINING HELPER FUNCTIONS
###############################################################
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

if __name__=="__main__":

    # Get generic DuckDB connection to be used for all databases processes
    duckdb_conn = get_duckdb_conn(DUCKDB_OLTP_CONNECTION)
    print(f"Connected to DuckDB database: {DUCKDB_OLTP_CONNECTION}")

    # Create all schema required for Wide World Importers OLTP
    print("Creating schemas for Wide World Importers dataset...")
    for schema_name in tqdm(WWI_SCHEMAS):
        create_schema(duckdb_conn, schema_name)
    print("Done creating schemas for Wide World Importers dataset...")

    # Read all SQL files for Wide World Importers ingestion
    print("Creating tables for Wide World Importers dataset...")
    sql_files = get_all_files(SQL_FILE_PATH, "*.sql")
    for sql_file in tqdm(sql_files):

        try:
            with open(sql_file) as f:
                sql = f.read().format(folder_path=CSV_FILE_PATH)

            # Create tables on DuckDB generic connection
            run_sql(duckdb_conn, sql)
        except Exception as e:
            raise Exception(f"Error in SQL execution {sql_file.name}: {e}")

    print("Done creating tables for World Wide Importers OLTP.")