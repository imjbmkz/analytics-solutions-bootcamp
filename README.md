# Analytics Solutions Bootcamp

## Tools Setup Guide

Install the tools in the order presented. You may choose to install Docker to run Postgre, DuckDB, or configure your own database. Google Colab may be used for most Python and R activities when local installation is not possible.

---

# 1. Windows Subsystem for Linux

WSL allows Windows users to run Linux. Docker Desktop uses WSL 2 as its recommended Windows backend.

## 1. System requirements

**Windows:** Windows 10 version 2004 or later, or Windows 11; 64-bit processor; virtualization enabled; administrator access.

**macOS:** Not applicable. Skip to Docker Desktop.

## 2. Install instructions

1. Open **PowerShell as Administrator**.
2. Run `wsl --install`.
3. Restart the computer.
4. Open **Ubuntu** and create a Linux username and password.
5. Run `wsl --update` in PowerShell.

## 3. Basic commands and examples

```powershell
wsl --status           # Check WSL status
wsl --list --verbose   # List distributions and WSL versions
wsl                    # Open Linux
wsl --shutdown         # Stop WSL
```

The installed distribution should show version `2`.

## 4. Troubleshooting

- **Distribution shows version 1:** Run `wsl --set-version Ubuntu 2`.
- **Update required:** Run `wsl --update` as Administrator.
- **Virtualization error:** Enable Intel VT-x, AMD-V, or SVM in BIOS/UEFI.
- **Ubuntu does not open:** Restart Windows and try again.

## 5. References

- [Install WSL](https://learn.microsoft.com/windows/wsl/install)
- [Basic WSL commands](https://learn.microsoft.com/windows/wsl/basic-commands)

---

# 2. Docker Desktop and Docker Compose

Docker runs applications in containers. Docker Compose defines related containers in a YAML file.

## 1. System requirements

**Windows:** Windows 10/11, 64-bit; WSL 2; virtualization; 4 GB RAM minimum, 8 GB recommended; administrator access.

**macOS:** Supported macOS version; Apple silicon or Intel processor; 4 GB RAM minimum, 8 GB recommended; administrator access.

## 2. Install instructions

### Windows

1. Complete the WSL setup above.
2. Download [Docker Desktop](https://www.docker.com/products/docker-desktop/).
3. Run the installer and keep **Use WSL 2 instead of Hyper-V** selected.
4. Restart if prompted, then open Docker Desktop.

### macOS

1. Check the processor under **About This Mac**.
2. Download the matching Docker Desktop installer.
3. Open the `.dmg` and drag Docker into **Applications**.
4. Open Docker and complete the permissions.

Verify:

```bash
docker --version
docker compose version
docker run hello-world
```

## 3. Basic commands and examples

```bash
docker pull postgres:16
docker images
docker run --name bootcamp-postgres -e POSTGRES_PASSWORD=bootcamp -p 5432:5432 -d postgres:16
docker ps
docker logs bootcamp-postgres
docker stop bootcamp-postgres
docker start bootcamp-postgres
docker rm bootcamp-postgres
```

The sample password is for local practice only.

Create `compose.yaml`:

```yaml
services:
  database:
    image: postgres:16
    environment:
      POSTGRES_USER: bootcamp
      POSTGRES_PASSWORD: bootcamp
      POSTGRES_DB: analytics
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data

volumes:
  postgres_data:
```

Run Compose from the same folder:

```bash
docker compose up -d     # Start
docker compose ps        # Check status
docker compose logs      # View logs
docker compose down      # Stop and remove containers
```

## 4. Troubleshooting

- **Docker daemon is not running:** Open Docker Desktop and wait for it to start.
- **WSL error:** Run `wsl --update`, restart Windows, and reopen Docker.
- **Port already in use:** Change `"5432:5432"` to `"5433:5432"`.
- **Container exits:** Run `docker logs CONTAINER_NAME`.
- **Low disk space:** Run `docker system df` to inspect usage.

## 5. References

- [Docker Desktop](https://docs.docker.com/desktop/)
- [Docker commands](https://docs.docker.com/reference/cli/docker/)
- [Docker Compose](https://docs.docker.com/compose/)

---

# 3. Git and GitHub

Git tracks file changes. GitHub stores Git repositories online for collaboration and sharing.

## 1. System requirements

**Windows:** Windows 10/11, internet connection, and administrator access.

**macOS:** Supported macOS version, internet connection, and administrator access.

## 2. Install instructions

1. Create and verify an account at [GitHub](https://github.com/). Enable two-factor authentication.
2. **Windows:** Download [Git for Windows](https://git-scm.com/download/win), run the installer, and keep the recommended settings.
3. **macOS:** Run `git --version` in Terminal. Install the Apple Command Line Tools if prompted. Homebrew users may run `brew install git`.
4. Configure Git:

   ```bash
   git config --global user.name "Your Name"
   git config --global user.email "your-email@example.com"
   git config --global init.defaultBranch main
   ```

For bootcamp activities, GitHub authentication through the browser or VS Code is sufficient. SSH setup is optional.

## 3. Basic commands and examples

```bash
git --version
git clone https://github.com/USERNAME/REPOSITORY.git
git status
git add .
git commit -m "Add project files"
git push
git pull
```

Never commit passwords, API keys, `.env` files, or confidential data.

## 4. Troubleshooting

- **Git not recognized:** Reopen the terminal or reinstall Git.
- **Author identity unknown:** Configure `user.name` and `user.email`.
- **GitHub asks you to sign in:** Complete browser authentication; GitHub does not accept account passwords for Git commands.
- **Push rejected:** Run `git pull`, resolve conflicts, commit, and push again.

## 5. References

- [Install Git](https://git-scm.com/downloads)
- [Create a GitHub account](https://docs.github.com/get-started/onboarding/getting-started-with-your-github-account)
- [Set up Git](https://docs.github.com/get-started/git-basics/set-up-git)
- [Optional SSH setup](https://docs.github.com/authentication/connecting-to-github-with-ssh)

---

# 4. Visual Studio Code

VS Code is the recommended editor for Python, R, Markdown, Docker files, and Git projects.

## 1. System requirements

**Windows:** Windows 10/11, 64-bit; about 1 GB available storage; internet for extensions.

**macOS:** Supported macOS version; Apple silicon or Intel; about 1 GB available storage; internet for extensions.

## 2. Install instructions

### Windows

1. Download the **User Installer** from [VS Code](https://code.visualstudio.com/Download).
2. Run it and select **Add to PATH** and **Open with Code**.
3. Finish installation and reopen the terminal.

### macOS

1. Download VS Code.
2. Open the archive and drag the application into **Applications**.
3. Open VS Code.

Install these extensions from the Extensions panel:

- Python by Microsoft
- Pylance by Microsoft
- R by REditorSupport
- Docker by Microsoft
- WSL by Microsoft, for Windows users

## 3. Basic commands and examples

Open a project using **File > Open Folder**, or run:

```bash
code .
```

| Action | Windows | macOS |
| --- | --- | --- |
| Command Palette | `Ctrl+Shift+P` | `Cmd+Shift+P` |
| Open terminal | `` Ctrl+` `` | `` Ctrl+` `` |
| Save | `Ctrl+S` | `Cmd+S` |
| Extensions | `Ctrl+Shift+X` | `Cmd+Shift+X` |

For Python, run **Python: Select Interpreter** from the Command Palette and choose the interpreter inside `.venv`.

## 4. Troubleshooting

- **`code` not recognized:** Restart the terminal. On macOS, run **Shell Command: Install 'code' command in PATH**.
- **Wrong Python interpreter:** Select the interpreter inside `.venv`.
- **Git changes missing:** Open the whole repository folder.
- **WSL folder opens in Windows mode:** Run **WSL: Reopen Folder in WSL**.

## 5. References

- [Download VS Code](https://code.visualstudio.com/Download)
- [VS Code documentation](https://code.visualstudio.com/docs)
- [VS Code with WSL](https://code.visualstudio.com/docs/remote/wsl)

---

# 5. Python and Virtual Environments

Python is used for data processing, analysis, automation, and machine learning. A virtual environment keeps each project's packages separate.

## 1. System requirements

**Windows:** Windows 10/11, 64-bit; administrator access; about 1 GB available storage.

**macOS:** Supported macOS version; Apple silicon or Intel; about 1 GB available storage.

## 2. Install instructions

### Windows

1. Download Python 3 from [python.org](https://www.python.org/downloads/).
2. Run the installer and select **Add python.exe to PATH**.
3. Select **Install Now**, then reopen PowerShell.
4. Verify with `py --version` and `py -m pip --version`.

### macOS

Download Python 3 from python.org, or run `brew install python` if Homebrew is installed. Verify with `python3 --version` and `python3 -m pip --version`.

## 3. Basic commands and examples

Windows PowerShell:

```powershell
mkdir analytics-project
cd analytics-project
py -m venv .venv
.venv\Scripts\Activate.ps1
```

macOS:

```bash
mkdir analytics-project
cd analytics-project
python3 -m venv .venv
source .venv/bin/activate
```

With the environment active:

```bash
python -m pip install --upgrade pip
python -m pip install pandas numpy matplotlib seaborn scikit-learn
python -m pip list
python -m pip freeze > requirements.txt
python -m pip install -r requirements.txt
deactivate
```

## 4. Troubleshooting

- **Python not recognized:** Reinstall it and select **Add python.exe to PATH**.
- **PowerShell blocks activation:** Run `Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass` and activate again.
- **Package missing:** Activate `.venv`, then run `python -m pip install PACKAGE_NAME`.
- **Wrong interpreter in VS Code:** Select the interpreter inside `.venv`.
- Avoid `sudo pip install`; use a virtual environment.

## 5. References

- [Download Python](https://www.python.org/downloads/)
- [Python `venv`](https://docs.python.org/3/library/venv.html)
- [Installing packages](https://packaging.python.org/tutorials/installing-packages/)

---

# 6. R and RStudio

R is used for statistics, analysis, and visualization. RStudio makes it easier to write and run R code. Install R before RStudio.

## 1. System requirements

**Windows:** Windows 10/11, 64-bit; administrator access; about 1 GB available storage.

**macOS:** Supported macOS version; matching Apple silicon or Intel installer; about 1 GB available storage.

## 2. Install instructions

1. Visit [CRAN](https://cran.r-project.org/), choose Windows or macOS, and install the current version of R.
2. Download the free [RStudio Desktop](https://posit.co/download/rstudio-desktop/) installer for your system.
3. Install and open RStudio.
4. Run `R.version.string` in the RStudio Console to verify.

## 3. Basic commands and examples

```r
# Install packages once
install.packages(c("tidyverse", "readxl", "janitor"))

# Load a package in each new session
library(tidyverse)

# Explore sample data
summary(mtcars)

# Create a chart
ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point()

# Check the R session
sessionInfo()
```

## 4. Troubleshooting

- **RStudio cannot find R:** Install R first and reopen RStudio.
- **Package unavailable:** Check its spelling and update R if required.
- **Function not found:** Load its package with `library(packageName)`.
- **Permission error:** Choose a personal package library when prompted.
- **Installation fails:** Install the build tools recommended by CRAN.

## 5. References

- [Download R](https://cran.r-project.org/)
- [Download RStudio](https://posit.co/download/rstudio-desktop/)
- [Install R packages](https://cloud.r-project.org/doc/manuals/r-release/R-admin.html#Installing-packages)

---

# 7. Google Colab

Google Colab is an online notebook environment for Python and R. It is an alternative when local installation is not possible.

## 1. System requirements

**Windows and macOS:** Modern web browser, Google account, stable internet connection, and Google Drive storage. Local Python or R is not required.

## 2. Install instructions

Colab does not need installation.

1. Visit [Google Colab](https://colab.research.google.com/).
2. Sign in and select **New notebook**.
3. Rename the notebook.

For R, select **Runtime > Change runtime type > R > Save**. If R is unavailable in the menu, open:

```text
https://colab.research.google.com/#create=true&language=r
```

## 3. Basic commands and examples

Python example:

```python
import pandas as pd

df = pd.DataFrame({"product": ["A", "B"], "sales": [100, 150]})
df
```

```python
%pip install duckdb
```

Upload a file or connect Drive:

```python
from google.colab import files, drive

uploaded = files.upload()
drive.mount("/content/drive")
```

R example in an R-runtime notebook:

```r
R.version.string
install.packages("tidyverse")
library(tidyverse)
summary(mtcars)

ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point()
```

Python and R normally use separate notebooks because each notebook has one runtime type.

## 4. Troubleshooting

- **Runtime disconnected:** Reconnect and rerun the cells.
- **Variables or files disappeared:** Reload the data or remount Drive; runtime storage is temporary.
- **Package disappeared:** Reinstall it after the runtime restarts.
- **R code produces Python errors:** Change the runtime to R.
- **Out of memory:** Restart the runtime or use a smaller data sample.
- Never put passwords, tokens, or confidential data in shared notebooks.

## 5. References

- [Google Colab](https://colab.research.google.com/)
- [Google Colab FAQ](https://research.google.com/colaboratory/faq.html)
- [Introduction to Colab](https://colab.research.google.com/notebooks/intro.ipynb)

---

## Final Setup Checklist

- [ ] WSL 2 is installed on Windows.
- [ ] Docker and Docker Compose work.
- [ ] Git is installed and a GitHub account is ready.
- [ ] VS Code and the recommended extensions are installed.
- [ ] A Python virtual environment can import `pandas`.
- [ ] RStudio can load `tidyverse`.
- [ ] Colab can run Python and R notebooks.

*Analytics Solutions Bootcamp — Tools Setup Guide*
