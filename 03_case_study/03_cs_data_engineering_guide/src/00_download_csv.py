import shutil
import kagglehub
from pathlib import Path

def download_kaggle_data(kaggle_link: str, target_dir: str = "data"):

    # Ensures that there is a directory to store the downloaded files
    Path(target_dir).mkdir(parents=True, exist_ok=True)

    # Download latest version
    path = kagglehub.dataset_download(kaggle_link)
    csv_files = Path(path).rglob("*csv")

    # Copy the files from the source directory
    for f in csv_files:
        # f.copy(f"{target_dir}/{f.name}")
        # Switch to shutil.copy2 for backward compatibility with older Python versions
        shutil.copy2(f, f"{target_dir}/{f.name}")

    print(f"Successfully downloaded Kaggle data files to {target_dir}.")

if __name__=="__main__":
    download_kaggle_data(kaggle_link="pauloviniciusornelas/wwimporters")