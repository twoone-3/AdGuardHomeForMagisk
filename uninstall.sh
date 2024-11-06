#!/system/bin/sh

AGH_DIR="/data/adb/agh" 

if [ -d "${AGH_DIR}" ]; then
  rm -rf "${AGH_DIR}"
fi