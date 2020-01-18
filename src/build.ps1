param (
	[switch]$IncludeHelp
)

$BuildFolder = $PSScriptRoot

$powerShellGet = Import-Module PowerShellGet  -PassThru -ErrorAction Ignore
if ($powerShellGet.Version -lt ([Version]'1.6.0')) {
	Install-Module PowerShellGet -Scope CurrentUser -Force -AllowClobber
	Import-Module PowerShellGet -Force
}

Set-Location $BuildFolder

$OutputPath = "$BuildFolder\output\UniversalDashboard.UD-WindowModal"

Remove-Item -Path $OutputPath -Force -ErrorAction SilentlyContinue -Recurse
Remove-Item -Path "$BuildFolder\public" -Force -ErrorAction SilentlyContinue -Recurse

New-Item -Path $OutputPath -ItemType Directory

npm install
npm run build

Copy-Item $BuildFolder\public\*.bundle.js $OutputPath
Copy-Item $BuildFolder\public\*.map $OutputPath
Copy-Item $BuildFolder\UniversalDashboard.UD-WindowModal.psm1 $OutputPath
Copy-Item $BuildFolder\Scripts $OutputPath\Scripts -Recurse -Force

if ($IncludeHelp.IsPresent) {
	$platyPS = Import-Module PlatyPS -PassThru -ErrorAction Ignore
	if ($platyPS.Version -lt ([Version]'0.14.0')) {
		Install-Module PlatyPS -Scope CurrentUser -Force -AllowClobber
		Import-Module PlatyPS -Force
	}
	New-ExternalHelp -Path $BuildFolder\Help -OutputPath $OutputPath\en-US -Force -ShowProgress
}

$Version = "1.0.0"

$manifestParameters = @{
	Path = "$OutputPath\UniversalDashboard.UD-WindowModal.psd1"
	Author = "BoSen29"
	CompanyName = "Ironman Software, LLC"
	Copyright = "2019 Ironman Software, LLC"
	RootModule = "UniversalDashboard.UD-WindowModal.psm1"
	Description = "Fancy modals for fancy people using Universal Dashboard."
	ModuleVersion = $Version
	Tags = @("universaldashboard", "ud-control", "modal")
	ReleaseNotes = "First edition, someone actually reads these?"
	FunctionsToExport = @(
		"Add-UDwindowModal"
	)
	AliasesToExport = @(
		"Show-UDWindowModal"
	)
}

New-ModuleManifest @manifestParameters

