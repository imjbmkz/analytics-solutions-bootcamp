import kagglehub
from pathlib import Path

def download_kaggle_data(kaggle_link: str, target_dir: str = "data"):

    # Download latest version
    path = kagglehub.dataset_download(kaggle_link)
    csv_files = Path(path).rglob("*csv")

    # Copy the files from the source directory
    for f in csv_files:
        f.copy(f"{target_dir}/{f.name}")

    print(f"Successfully downloaded Kaggle data files to {target_dir}.")

if __name__=="__main__":
    download_kaggle_data(kaggle_link="pauloviniciusornelas/wwimporters")