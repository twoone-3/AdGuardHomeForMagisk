#!/system/bin/sh

AGH_DIR="/data/adb/agh" 

if [ ! -d "${AGH_DIR}" ]; then
  exit 1
else
  rm -rf "${AGH_DIR}"
fi

if [ -f "/data/adb/service.d/agh_service.sh" ]; then
  rm "/data/adb/service.d/agh_service.sh"
fi
