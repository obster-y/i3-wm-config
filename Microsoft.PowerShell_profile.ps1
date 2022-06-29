#Import-Module posh-git
Import-Module "%ProgramFiles%\PowerShell\posh-git-master\src\posh-git.psd1"

Import-Module "%ProgramFiles%\PowerShell\oh-my-posh\oh-my-posh.psd1"
oh-my-posh init pwsh --config %LOCALAPPDATA%\oh-my-posh\themes/powerlevel10k_rainbow.omp.json | Invoke-Expression

Import-Module "%ProgramFiles%\PowerShell\PSReadLine\SamplePSReadlineProfile.ps1"


$env:Path += ";?:\Git\usr\bin"
$env:Path += ";%USERPROFILE%\Anaconda3"
$env:Path += ";%USERPROFILE%\Anaconda3\Scripts"
$env:Path += ";%USERPROFILE%\Anaconda3\Library\bin"
$env:Path += ";?:\texlive\2022\bin\win32"

$env:PATHEXT += ";.py"
$env:LESSCHARSET = 'utf-8'

Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineKeyHandler -Key "Tab" -Function MenuComplete
Set-PSReadlineKeyHandler -Key "Ctrl+d" -Function ViExit
Set-PSReadLineKeyHandler -Key "Ctrl+z" -Function Undo
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward




# for editing your PowerShell profile
Function Edit-Profile
{
    vim $profile
}

# for editing your Vim settings
Function Edit-Vimrc
{
    vim $home\_vimrc
}



#-------------------------------   Set Network BEGIN    -------------------------------
function Get-AllNic {
	Get-NetAdapter | Sort-Object -Property MacAddress
}
Set-Alias -Name getnic -Value Get-AllNic

function Get-IPv4Routes {
	Get-NetRoute -AddressFamily IPv4 | Where-Object -FilterScript {$_.NextHop -ne '0.0.0.0'}
}
Set-Alias -Name getip -Value Get-IPv4Routes

function Get-IPv6Routes {
	Get-NetRoute -AddressFamily IPv6 | Where-Object -FilterScript {$_.NextHop -ne '::'}
}
Set-Alias -Name getip6 -Value Get-IPv6Routes
#-------------------------------    Set Network END     -------------------------------


#-------------------------------   Set Alias BEGIN    -------------------------------
Import-Module "%ProgramFiles%\PowerShell\powershell-git-aliases\src\git-aliases.psd1" -DisableNameChecking

function MakeThings {
	nmake.exe $args -nologo
}
Set-Alias -Name make -Value MakeThings

function PythonRun {
	%USERPROFILE%/Anaconda3/python.exe $args
}
Set-Alias -Name python -Value PythonRun 

function VScodeOpen {
	%USERPROFILE%\?\bin\VSCode $args
}
Set-Alias -Name code -Value VScodeOpen 


function ListDirectory {
	(Get-ChildItem).Name
	Write-Host("")
}
Set-Alias -Name ls -Value ListDirectory
Set-Alias -Name ll -Value Get-ChildItem

function OpenCurrentFolder {
	param
	(
		$Path = '.'
	)
	Invoke-Item $Path
}
Set-Alias -Name open -Value OpenCurrentFolder

function GoParentDirectory {
	cd ./..
}
function GoPParentDirectory {
	cd ./../..
}
function GoHomeDirectory {
	cd ~
}
Set-Alias -Name ".." -Value GoParentDirectory 
Set-Alias -Name "..." -Value GoPParentDirectory 
Set-Alias -Name "~" -Value GoHomeDirectory
Set-Alias -Name os-update -Value Update-Packages
#-------------------------------    Set Alias END     -------------------------------


Set-Location ~
[System.Console]::OutputEncoding=[System.Text.Encoding]::GetEncoding(65001)
