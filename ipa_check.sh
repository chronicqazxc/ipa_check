# ipa checke
# A simple ipa security check tool.
# Wayne Hsiao chronicqazxc@gmail.com Apr 8, 2019
appName="ipa checke"
version="v0.1.1"
#!/bin/sh

RCol='\033[0m'
Bla='\033[33;30m';
Red='\033[33;31m';
Gre='\033[33;32m';
Yel='\033[33;33m';
Blu='\033[33;34m';
Pur='\033[33;35m';
Cya='\033[33;36m';
Whi='\033[33;37m';

#Constents
frameworks=$1
CFBundleShortVersionString="CFBundleShortVersionString"
CFBundleVersion="CFBundleVersion"
validateReg='((^|, )(\d+|\d+\.\d+|\d+\.\d+\.\d+))+$'
printWithColorSettingReg='^\-+c{1}'
exportToFileSettingReg='^\-+e{1}'
examineBannedApiSettingReg='^\-+b{1}'
settingReg='^\-'
tmpFile=tmp
now="$(date '+%Y-%m-%d_%H.%M.%S')"
validResults=()
invalidResults=()

# Reference: https://github.com/MobSF/Mobile-Security-Framework-MobSF/blob/bbaec066344f486c96a3d57be3287a74ea18e2a0/StaticAnalyzer/views/ios/binary_analysis.py#L141
function bannedApis() {
  if [[ $isExamineBannedApi == 1 ]];then
    apis="_alloca;_gets;_memcpy;_printf;_scanf;_sprintf;_sscanf;_strcat;StrCat;_strcpy;StrCpy;_strlen;StrLen;_strncat;StrNCat;_strncpy;StrNCpy;_strtok;_swprintf;_vsnprintf;_vsprintf;_vswprintf;_wcscat;_wcscpy;_wcslen;_wcsncat;_wcsncpy;_wcstok;_wmemcpy;_fopen;_chmod;_chown;_stat;_mktemp"
    echo ${apis//;/ }
  else
    apis=""
    echo ${apis//;/ }
  fi
}

function clearTemp() {
  if [[ -f $tmpFile ]];then
    rm $tmpFile
  fi
}

function setValueToTmp() {
  clearTemp
  echo $1 > $tmpFile
}

function getFileExtension() {
  fullfile=$1
  # filename=$(basename -- "$fullfile")
  filename="${fullfile##*/}"
  extension="${filename##*.}"
  echo $extension
}

function getFileName() {
  fullfile=$1
  # filename=$(basename -- "$fullfile")
  filename="${fullfile##*/}"
  filename="${filename%.*}"
  echo $filename
}

#Setup isPrintWithColor variable
for key in "$@"
do
setValueToTmp $key
isPrintWithColor=$(egrep -c "${printWithColorSettingReg}" $tmpFile)
if [[ $isPrintWithColor == 1 ]];then
  break
fi
done

#Setup isExportToFile variable
for key in "$@"
do
setValueToTmp $key
isExportToFile=$(egrep -c "${exportToFileSettingReg}" $tmpFile)
if [[ $isExportToFile == 1 ]];then
  break
fi
done

#Setup isExamineBannedApi variable
for key in "$@"
do
setValueToTmp $key
isExamineBannedApi=$(egrep -c "${examineBannedApiSettingReg}" $tmpFile)
if [[ $isExamineBannedApi == 1 ]];then
  break
fi
done

function printDirectoryName() {
  directory=$1
  filename=$(basename "$directory")
  if [[ $isPrintWithColor == 1 ]];then
    echo $Yel $filename $RCol
  else
    echo $filename
  fi
}

function printKeyValidValue() {
  key=$1
  value=$2
  if [[ $isPrintWithColor == 1 ]];then
    printContnet="    $RCol $key:$Gre$value"
  else
    printContnet="    $key:$value"
  fi

  echo $printContnet
  validResults+=("$printContnet")
}

function printKeyInvalidValue() {
  key=$1
  value=$2
  if [[ $isPrintWithColor == 1 ]];then
    printContnet="    $RCol $key:$Red$value"
  else
    printContnet="    $key:$value"
  fi

  echo "$printContnet"
  invalidResults+=("\n$printContnet")
}

function printResultByKeyValue() {
  key=$1
  value=$2

  if [[ $key == $CFBundleShortVersionString ]] || [[ $key == $CFBundleVersion ]];then
    setValueToTmp $value
    validateResult=$(egrep -c "${validateReg}" $tmpFile)

    if [[ $validateResult == 1 ]];then
      printKeyValidValue $key $value
    else
      printKeyInvalidValue $key $value
    fi
  else
    printKeyValidValue $key $value
  fi
}

function printContentsByFrameworkPathBinaryPathAndKey() {
  framework=$1
  binaryPath=$2
  key=$3

  setValueToTmp $key
  isSettingValue=$(egrep -c "${settingReg}" $tmpFile)

  if [[ $key != $frameworks ]] && [[ $key != $framework ]] && [[ $isSettingValue == 0 ]];then
    value=$(/usr/bin/otool -Iv $binaryPath | /usr/bin/grep $key)
    if [[ ${value//[$'\t\r\n ']} != "" ]]; then
      if [[ $key == "_NSLog" ]]; then
        # if [[ $isPrintWithColor == 1 ]];then
        #   echo $Red "Warning!!! NSLog be used" $RCol
        # else
        #   echo "Warning!!! NSLog be used"
        # fi
        # echo "${value}"
        printKeyInvalidValue "$(getFileName $framework).$(getFileExtension $framework): ${key}" " NSLog be used"
      elif [[ 0 == $(containsElement ${key} $(bannedApis)) ]]; then
        # if [[ $isPrintWithColor == 1 ]];then
        #   echo $Red "Warning!!! Banned api was used ${key}" $RCol
        # else
        #   echo "Warning!!! Banned api was used ${key}"
        # fi
        # echo "${value}"
        printKeyInvalidValue "$(getFileName $framework).$(getFileExtension $framework): ${key}" " This API should be avoided."
      else
        # printKeyValidValue $key $value
        a="a"
      fi
    else
      if [[ $key == "_objc_release" ]]; then
        # if [[ $isPrintWithColor == 1 ]];then
        #   echo $Red "Warning!!! fobjc-arc flag was not found" $RCol
        # else
        #   echo "Warning!!! fobjc-arc flag was not found"
        # fi
        printKeyInvalidValue "$(getFileName $framework).$(getFileExtension $framework): ${key}" " fobjc-arc flag was not found"
      elif [[ $key == "stack_chk_guard" ]]; then
        # if [[ $isPrintWithColor == 1 ]];then
        #   echo $Red "Warning!!! fstack-protector-all flag was not found" $RCol
        # else
        #   echo "Warning!!! fstack-protector-all flag was not found"
        # fi
        printKeyInvalidValue "$(getFileName $framework).$(getFileExtension $framework): ${key}" " fstack-protector-all flag was not found"
      elif [[ $key == "_ptrace" ]]; then
        # if [[ $isPrintWithColor == 1 ]];then
        #   echo $Red "Warning!!! Binary does not call ptrace" $RCol
        # else
        #   echo "Warning!!! Binary does not call ptrace"
        # fi
        printKeyInvalidValue "$(getFileName $framework).$(getFileExtension $framework): ${key}" " Binary does not call ptrace"
      else
        # printKeyValidValue $key $value
        a="a"
      fi
    fi
  fi
}

function containsElement () {
  local e match="$1"
  shift
  for e;
  do
    if [[ "$e" == "$match" ]]; then
      echo 0
      return
    fi
  done
  echo 1
}

function printBundleByFramework() {
  framework=$1

  for file in "$framework"/*
  do
    filename=$(basename "$file")
    extension="${filename##*.}"

    if [[ $extension == "bundle" ]];then
      bundleFile=$file
      bundleFileName=${bundleFile##*/}
      bundleFileNameWithoutExtension=${bundleFileName%.*}
      bundlePath="${bundleFile}/$bundleFileNameWithoutExtension"

      if [ -d "$bundlePath" ]; then
        printDirectoryName $filename
        for key in "$@"
        do
          printContentsByFrameworkPathBinaryPathAndKey $framework $bundlePath $key
        done #bundle loop
      fi
    fi
  done #Framework loop
}

function printFramework() {
  framework=$1
  printDirectoryName $framework

  for key in "$@"
  do
    # binaryName=${framework##*/}
    binaryName=${framework##*/}
    binaryNameWithoutExtension=${binaryName%.*}
    binaryPath="${framework}/$binaryNameWithoutExtension"
    printContentsByFrameworkPathBinaryPathAndKey $framework $binaryPath $key
  done
}

function printHeaderByArgs() {
  ARGS=()
  ARGS+=(_NSLog)
  ARGS+=(stack_chk_guard)
  ARGS+=(_objc_release)
  ARGS+=(_ptrace)

  for bannedApi in $(bannedApis)
  do
    ARGS+=($bannedApi)
  done

  for key in $@
  do
    setValueToTmp $key
    isSettingValue=$(egrep -c "${settingReg}" $tmpFile)

    if [[ $key != $frameworks ]] && [[ $isSettingValue == 0 ]];then
      ARGS+=("$key")
    fi
  done
  echo "***Start validate ${ARGS[@]}***"
}

function printResult() {
  echo "***Result***"
  if [[ "${#validResults[@]}" == 0 ]];then
    echo ""
  elif [[ "${#validResults[@]}" == 1 ]];then
    echo "Valid result:${#validResults[@]}"
  else
    echo "Valid results:${#validResults[@]}"
  fi

  if [[ "${#invalidResults[@]}" == 0 ]];then
    echo "No invalid result"
  elif [[ "${#invalidResults[@]}" == 1 ]];then
    echo "Invalid result:${#invalidResults[@]} - ${invalidResults[@]}"
  else
    echo "Invalid results:${#invalidResults[@]} - ${invalidResults[@]}"
  fi
}

function printFooter() {
  if [[ $isPrintWithColor == 1 ]];then
    echo "$Pur$now"
  else
    echo "$now"
  fi

  echo "${appName}(${version})"
  echo "Author: Wayne Hsiao chronicqazxc@gmail.com"
  echo "https://github.com/chronicqazxc/ipa_check/"
}

function printIntroduction() {
  echo "${Blu}*** ${Yel}Command: ./ipa_check"
  echo "${Blu}*** ${Yel}Arg1: ipa path"
  echo "${Blu}*** ${Yel}Options: -c (Enable text with color) / -e (Export to file) / -b (Inspect bannedApi - Enable this option will take a while to run the job.)"
  echo "${Blu}*** ${Yel}Example1(print text with color): ./binary_check /xxx/xxx/xxx.ipa -c"
  echo "${Blu}*** ${Yel}Example2(export to file): ./binary_check /xxx/xxx/xxx.ipa -e"
  echo "${Blu}"
}

function printXCArchive() {
  filePath=$1
  ARGS=()
  ARGS+=(_NSLog)
  ARGS+=(stack_chk_guard)
  ARGS+=(_objc_release)
  ARGS+=(_ptrace)

  for bannedApi in $(bannedApis)
  do
    ARGS+=($bannedApi)
  done

  for key in "$@"
  do
    setValueToTmp $key
    isSettingValue=$(egrep -c "${settingReg}" $tmpFile)
    if [[ $key != $frameworks ]] && [[ $isSettingValue == 0 ]];then
      ARGS+=("$key")
    fi
  done

  destination=$(getFileName $filePath)
  unzip -q $filePath -d $destination
  framework=$(ls "$PWD/$destination/Payload/" | grep .app)
  framework="$PWD/$destination/Payload/$framework"

  plistPath="${framework}/info.plist"
  bundleDisplayName=$(/usr/libexec/PlistBuddy -c Print:"CFBundleDisplayName" $plistPath 2>/dev/null)
  bundleIdentifier=$(/usr/libexec/PlistBuddy -c Print:"CFBundleIdentifier" $plistPath 2>/dev/null)
  bundleVersion=$(/usr/libexec/PlistBuddy -c Print:"CFBundleVersion" $plistPath 2>/dev/null)
  bundeVersionString=$(/usr/libexec/PlistBuddy -c Print:"CFBundleShortVersionString" $plistPath 2>/dev/null)
  if [[ $isPrintWithColor == 1 ]];then
    echo $Red "App info\n$bundleDisplayName ${bundeVersionString}(${bundleVersion})\n$bundleIdentifier" $RCol
    echo "------------------------------------------"
  else
    echo "App info\n$bundleDisplayName ${bundeVersionString}(${bundleVersion})\n$bundleIdentifier"
    echo "------------------------------------------"
  fi

  printFramework $framework "${ARGS[@]}"
  echo "------------------------------------------"

  frameworks="${framework}/Frameworks"
  for framework in "$frameworks"/*
  do
    if [[ $(getFileExtension $framework) != "dylib" ]];then
      printFramework $framework "${ARGS[@]}"
      printBundleByFramework $framework "${ARGS[@]}"
      echo "------------------------------------------"
    fi
  done
}

function main() {
    printHeaderByArgs $@
    printXCArchive $@
    printResult
    printFooter
    clearTemp
    filePath=$1
    destination=$(getFileName $filePath)
    rm -rf $destination
}

if [ "$#" == 0 ]; then
  printIntroduction
  printFooter
else
  if [ $isExportToFile == 1 ];then
    main $@ | pbcopy
    result="binary_check_result_${now}.txt"
    echo "$(pbpaste)" >> $result
    echo "Please find report at ${PWD}/$result"
  else
    main $@
  fi
fi
