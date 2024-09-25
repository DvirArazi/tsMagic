# Define the location where tsMagic will be installed (could be anywhere, but using Program Files as an example)
$installDir = "C:\Program Files\tsMagic"

# Step 1: Install Bun if not already installed
if (-not (Get-Command "bun" -ErrorAction SilentlyContinue)) {
    Write-Host "Bun is not installed. Installing bun..."
    powershell -c "irm bun.sh/install.ps1 | iex"
} else {
    Write-Host "Bun is already installed."
}

# Step 2: Install TypeScript globally using Bun if not already installed
if (-not (bun list | Select-String -Pattern "typescript")) {
    Write-Host "TypeScript is not installed. Installing TypeScript globally using bun..."
    bun add -g typescript
} else {
    Write-Host "TypeScript is already installed."
}

# Step 3: Modify the PATH if tsMagic is not already added
$path = [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::Machine)
if (-not ($path -like "*$installDir*")) {
    Write-Host "Adding tsMagic to system PATH..."
    [System.Environment]::SetEnvironmentVariable("Path", "$path;$installDir", [System.EnvironmentVariableTarget]::Machine)
} else {
    Write-Host "tsMagic is already in the system PATH."
}

# Step 4: Create tsconfig.json and .vscode/settings.json in the current working directory
$currentDir = Get-Location

# Create tsconfig.json
$tsconfigPath = Join-Path $currentDir "tsconfig.json"
$tsconfigContent = @'
{
  "compilerOptions": {
    "target": "es2016", 
    "module": "commonjs", 
    "sourceMap": true, 
    "esModuleInterop": true,
    "forceConsistentCasingInFileNames": true, 
    "strict": true,
    "skipLibCheck": true
  }
}
'@

if (-not (Test-Path -Path $tsconfigPath)) {
    Write-Host "Creating tsconfig.json file in $currentDir"
    $tsconfigContent | Out-File -Encoding UTF8 -FilePath $tsconfigPath
} else {
    Write-Host "tsconfig.json already exists in $currentDir"
}

# Create .vscode/settings.json
$vscodePath = Join-Path $currentDir ".vscode"
$settingsPath = Join-Path $vscodePath "settings.json"

$vscodeSettingsContent = @'
{
  "files.exclude": {
    "**/*js": true,
    "**/*js.map": true,
    ".vscode": true,
    "tsconfig.json": true
  }
}
'@

if (-not (Test-Path -Path $vscodePath)) {
    Write-Host "Creating .vscode folder in $currentDir"
    New-Item -ItemType Directory -Path $vscodePath
}

if (-not (Test-Path -Path $settingsPath)) {
    Write-Host "Creating settings.json in $currentDir\.vscode"
    $vscodeSettingsContent | Out-File -Encoding UTF8 -FilePath $settingsPath
} else {
    Write-Host "settings.json already exists in $currentDir\.vscode"
}