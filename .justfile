# Cross platform shebang:
shebang := if os() == 'windows' {
  'powershell.exe'
} else {
  '/usr/bin/env pwsh'
}

# Set shell for non-Windows OSs:
set shell := ["powershell", "-c"]

# Set shell for Windows OSs:
set windows-shell := ["powershell.exe", "-NoLogo", "-Command"]

# If you have PowerShell Core installed and want to use it,
# use `pwsh.exe` instead of `powershell.exe`


alias list := default

default:
  just --list

setup:
  uv venv
  uv sync

build:
  uv run pyinstaller --noconfirm --onefile --console --name kf1-mods-installer src/kf1_mods_installer/__main__.py --icon=assets/images/icons/project_main_icon.ico

clean:
  if (Test-Path ".venv") { Remove-Item ".venv" -Recurse -Force }
  git clean -d -X --force

refresh_deps:
  uv lock --upgrade
  uv sync
