# dotfiles
Different configuration files

## Installation

- Open pws as administator
- Run `install.ps1`
    - It will run scripts from folder `powershell`
        1. Run `install-pkg-manager.ps1`
        2. Run `install-pkg.ps1`
        3. Run `setup-localhost.ps1`
- Go to folder `powershell`
    - Copy `profile.ps1`

<details open>
<summary><strong>Packages</strong></summary>

* Google Chrome
* Git
* VSCode
* Spotify
* PowerToys
* DevToys
* PowerShell Core
* Visual Studio 2022
* Lazygit
* Chezmoi

</details>

## Pws

- Get current profile of pws and open config in vscode
- 1. Run this in pws -> `code $PROFILE.CurrentUserAllHosts`
- 2. Load config from folder
    - `. $env:USERPROFILE\<config_folder_path>\<file>.ps1`
- 3. Or create your profile by going into folder we get from `$PROFILE.CurrentUserAllHosts`
and create profile.ps1 file by running `NewItem -ItemType File -Path $PROFILE -Force`
- 4. To run scripts - you need to execute `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser`, or it will error out

### Pws plugins
- https://github.com/PowerShell/PSReadLine - follow install guide
- `Set-PSReadLineOption -PredictionSource History`
- `Set-PSReadLineOption -PredictionViewStyle ListView`
- [PSReadLine Options](https://learn.microsoft.com/en-us/powershell/module/psreadline/get-psreadlineoption?view=powershell-7.4)

## Bash

- If you want to load config from custom folder,
- make sure that config dir is set up

## VSCode

- Stores custom keybindings and editor settings

## Gitconfig

- Custom diffing tool - make sure that `diff-so-fancy` is globally installed
- Stores git related configs
- branch color, push, pager, alias