""" Run from root python src/02_ingest_olap.py
"""

import duckdb
from pathlib import Path
from tqdm import tqdm

###############################################################
# 01 - LOADING ENVIRONMENT AND CONSTANT VARIABLES
###############################################################
CSV_FILE_PATH = "data"
SQL_FILE_PATH = "src/sql/olap"
DUCKDB_OLTP_CONNECTION = "asb_oltp.duckdb"
DUCKDB_OLAP_CONNECTION = "asb_olap.duckdb"

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

if __name__=="__main__":

    # Get generic DuckDB connection to be used for all databases processes
    duckdb_conn = get_duckdb_conn(DUCKDB_OLTP_CONNECTION)
    # run_sql(duckdb_conn_oltp, "DETACH asb_olap;")
    run_sql(duckdb_conn, "ATTACH 'asb_olap.duckdb' AS asb_olap;")

    # Read all SQL files for Wide World Importers ingestion
    print("Creating tables for Wide World Importers OLAP tables...")
    sql_files = get_all_files(SQL_FILE_PATH, "*.sql")
    for sql_file in tqdm(sql_files):

        try:
            with open(sql_file) as f:
                sql = f.read().format(folder_path=CSV_FILE_PATH)
                sql = sql.replace("CREATE OR REPLACE TABLE ", "CREATE OR REPLACE TABLE asb_olap.")

            # Create tables on DuckDB generic connection
            run_sql(duckdb_conn, sql)
        except Exception as e:
            raise Exception(f"Error in SQL execution {sql_file.name}: {e}")