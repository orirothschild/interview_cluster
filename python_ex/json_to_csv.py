
from multiprocessing.dummy import Pool as ThreadPool
from pathlib import Path
import pandas as pd

def json_to_csv(path_to_file):
    json_file = Path(path_to_file)
    if json_file.exists() and json_file.is_file():
        df = pd.read_json (path_to_file)
        df.to_csv(r'csv.csv', index = None)
def execute(file):
    pool = ThreadPool(4)
    results = pool.map(json_to_csv, file)
    pool.close()
    pool.join()
if __name__ == "__main__":
   execute([txt.json])
