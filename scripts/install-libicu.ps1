$ErrorActionPreference = "Stop"

$ICU_PLAT = $env:ICU_PLAT
$ICU_LIB_SUFFIX = $env:ICU_LIB_SUFFIX
$ICU_URL = "https://github.com/unicode-org/icu/releases/download/release-77-1/icu4c-77_1-${ICU_PLAT}.zip"
$TMP_DIR = Join-Path $env:TEMP "icu-download"
$ICU_ZIP = Join-Path $TMP_DIR "icu.zip"

New-Item -ItemType Directory -Force -Path $TMP_DIR | Out-Null

Write-Host "Downloading ICU from $ICU_URL"
Invoke-WebRequest -Uri $ICU_URL -OutFile $ICU_ZIP

Write-Host "Extracting ICU"
Expand-Archive -Path $ICU_ZIP -DestinationPath $TMP_DIR -Force

New-Item -ItemType Directory -Force -Path $env:_LIBICU_DIR | Out-Null
Copy-Item -Path (Join-Path $TMP_DIR "include") -Destination $env:_LIBICU_DIR -Recurse -Force
Copy-Item -Path (Join-Path $TMP_DIR "lib${ICU_LIB_SUFFIX}") -Destination (Join-Path $env:_LIBICU_DIR "lib") -Recurse -Force
Copy-Item -Path (Join-Path $TMP_DIR "bin${ICU_LIB_SUFFIX}") -Destination (Join-Path $env:_LIBICU_DIR "bin") -Recurse -Force

Remove-Item -Recurse -Force $TMP_DIR

Write-Host "ICU installed to $env:_LIBICU_DIR"
