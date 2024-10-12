# 定义下载 URL 和路径变量
$CacheDir = "$PSScriptRoot\cache"
$UrlWitchCachePath = @{
  "https://github.com/AdguardTeam/AdGuardHome/releases/latest/download/AdGuardHome_linux_arm64.tar.gz" = "$CacheDir\AdGuardHome_linux_arm64.tar.gz"
  "https://github.com/AdguardTeam/AdGuardHome/releases/latest/download/AdGuardHome_linux_armv7.tar.gz" = "$CacheDir\AdGuardHome_linux_armv7.tar.gz"
}

# 创建缓存目录
if (-Not (Test-Path -Path $CacheDir)) {
  Write-Host "Creating cache directory..."
  New-Item -Path $CacheDir -ItemType Directory
}

# 下载文件，有缓存时不再下载
Write-Host "Downloading AdGuardHome..."
foreach ($url in $UrlWitchCachePath.Keys) {
  $CachePath = $UrlWitchCachePath[$url]
  if (-Not (Test-Path -Path $CachePath)) {
    Write-Host "Downloading $url..."
    Invoke-WebRequest -Uri $url -OutFile $CachePath
    if ($?) {
      Write-Host "Download completed successfully."
    }
    else {
      Write-Host "Download failed. Exiting..."
      exit 1
    }
  }
  else {
    Write-Host "File already exists in cache. Skipping download."
  }
}

# 使用 tar 解压文件
Write-Host "Extracting AdGuardHome..."
foreach ($url in $UrlWitchCachePath.Keys) {
  $CachePath = $UrlWitchCachePath[$url]
  if ($CachePath -match 'AdGuardHome_linux_(arm64|armv7)\.tar\.gz$') {
    $ExtractDir = "./cache/" + $matches[1]
  }
  else {
    throw "Invalid file path: $CachePath"
  }
  if (-Not (Test-Path -Path $ExtractDir)) {
    New-Item -Path $ExtractDir -ItemType Directory
    Write-Host "Extracting $CachePath..."
    tar -xzf $CachePath -C $ExtractDir
    if ($?) {
      Write-Host "Extraction completed successfully."
    }
    else {
      Write-Host "Extraction failed"
      exit 1
    }
  }
}

# 给项目打包，使用 7-Zip 压缩 zip
Write-Host "Packing AdGuardHome..."
$7z = "C:\Program Files\7-Zip\7z.exe"
$OutputPathArm64 = "$CacheDir\AdGuardHomeForMagisk_arm64.zip"
$OutputPathArmv7 = "$CacheDir\AdGuardHomeForMagisk_armv7.zip"
if (Test-Path -Path $OutputPathArm64) {
  Remove-Item -Path $OutputPathArm64
}
if (Test-Path -Path $OutputPathArmv7) {
  Remove-Item -Path $OutputPathArmv7
}
# pack arm64
& $7z a -tzip $OutputPathArm64 ".\*.sh"
& $7z a -tzip $OutputPathArm64 ".\module.prop"
& $7z a -tzip $OutputPathArm64 ".\META-INF"
& $7z a -tzip $OutputPathArm64 ".\scripts"
& $7z a -tzip $OutputPathArm64 ".\bin\data"
& $7z rn $OutputPathArm64 "data" "bin\data"
& $7z a -tzip $OutputPathArm64 ".\bin\AdGuardHome.yaml"
& $7z rn $OutputPathArm64 "AdGuardHome.yaml" "bin\AdGuardHome.yaml"
& $7z a -tzip $OutputPathArm64 ".\cache\arm64\AdGuardHome\AdGuardHome"
& $7z rn $OutputPathArm64 "AdGuardHome" "bin\AdGuardHome"
# pack armv7
& $7z a -tzip $OutputPathArmv7 ".\*.sh"
& $7z a -tzip $OutputPathArmv7 ".\module.prop"
& $7z a -tzip $OutputPathArmv7 ".\META-INF"
& $7z a -tzip $OutputPathArmv7 ".\scripts"
& $7z a -tzip $OutputPathArmv7 ".\bin\data"
& $7z rn $OutputPathArmv7 "data" "bin\data"
& $7z a -tzip $OutputPathArmv7 ".\bin\AdGuardHome.yaml"
& $7z rn $OutputPathArmv7 "AdGuardHome.yaml" "bin\AdGuardHome.yaml"
& $7z a -tzip $OutputPathArmv7 ".\cache\armv7\AdGuardHome\AdGuardHome"
& $7z rn $OutputPathArmv7 "AdGuardHome" "bin\AdGuardHome"
Write-Host "Packing completed successfully."