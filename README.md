# dotfiles

- Different configuration files

<br />

## Installation

### Powershell

- If you don't want to download the repo you can run the code, see below
- Open pws as administator
- Copy and paste the code below into your PowerShell terminal to get your Windows machine ready

```powershell
Invoke-Expression (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/tomasvn/dotfiles/main/full-script-install.ps1").Content
```
- It will run scripts from folder `powershell\scripts`
1. Run `setup-pkg-manager.ps1`
2. Run `setup-pkgs.ps1`
3. Run `setup-pws.ps1`
4. Run `setup-profile.ps1`
5. Run `setup-localhost.ps1`

### Shell

- Copy and paste the code below into your bash terminal to prepare vscode, and shell profile
```shell
bash <(curl -s https://raw.githubusercontent.com/tomasvn/dotfiles/main/full-script-install.sh)
```
- make sure that you adjust path for `web` alias in `powershell/profile.ps1` file, or it will default to `$HOME` folder, unless you specify a string after alias

<details open>
<summary><strong>Chocolatey packages</strong></summary>

* Google Chrome
* Git
* VSCode
* Spotify
* PowerToys
* DevToys
* PowerShell Core
* Visual Studio 2022
* Lazygit
* ~~Chezmoi~~
* Cmder

</details>

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

## DEV Tasks

- Open `task scheduler` > `Import task...` > locate `dev-tasks.xml`
- Set up apps that auto-open on start up
