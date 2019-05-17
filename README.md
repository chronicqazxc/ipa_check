# ipa_check
`ipa_check` is a tool which will inspect risks of your ipa files.

## Usage
```
sh ipa_check.sh $path_to_ipa -[optionas]
```

## Parameters
* `-b`: Whether check private APIs.
* `-e`: Whether to export inspect report.

## Example
Examine ipa which include private APIs as well as export the report.
```
sh ipa_check.sh $path_to_ipa -b -e
```

There are what the tool will examine for your ipas.
1. Whether `NSLog` was used in your code.
2. Whether flag `fobjc-arc` be used.
3. Whether flag `fstack-protector-all` be used.
4. Whether binary called `_ptrace`.
5. Examine following APIs.
```
_alloca
_gets
_memcpy
_printf
_scanf
_sprintf
_sscanf
_strcat
StrCat
_strcpy
StrCpy
_strlen
StrLen
_strncat
StrNCat
_strncpy
StrNCpy
_strtok
_swprintf
_vsnprintf
_vsprintf
_vswprintf
_wcscat
_wcscpy
_wcslen
_wcsncat
_wcsncpy
_wcstok
_wmemcpy
_fopen
_chmod
_chown
_stat
_mktemp
```

Example of exported report:
```
sh ipa_check.sh $path_to_ipa -e
```
```
***Start validate _NSLog stack_chk_guard _objc_release _ptrace _alloca _gets _memcpy _printf _scanf _sprintf _sscanf _strcat StrCat _strcpy StrCpy _strlen StrLen _strncat StrNCat _strncpy StrNCpy _strtok _swprintf _vsnprintf _vsprintf _vswprintf _wcscat _wcscpy _wcslen _wcsncat _wcsncpy _wcstok _wmemcpy _fopen _chmod _chown _stat _mktemp***
App info
 1.0(1)
com.xxx.vvv.xxxKit.xxxKitExample
------------------------------------------
xxxKitExample.app
    xxxKitExample.app: _NSLog: NSLog be used
    xxxKitExample.app: stack_chk_guard: fstack-protector-all flag was not found
    xxxKitExample.app: _ptrace: Binary does not call ptrace
------------------------------------------
AFNetworking.framework
    AFNetworking.framework: _NSLog: NSLog be used
    AFNetworking.framework: _ptrace: Binary does not call ptrace
------------------------------------------
vvv.framework
    vvv.framework: stack_chk_guard: fstack-protector-all flag was not found
    vvv.framework: _ptrace: Binary does not call ptrace
    vvv.framework: _memcpy: This API should be avoided.
------------------------------------------
CocoaLumberjack.framework
    CocoaLumberjack.framework: _NSLog: NSLog be used
    CocoaLumberjack.framework: _ptrace: Binary does not call ptrace
    CocoaLumberjack.framework: _alloca: This API should be avoided.
    CocoaLumberjack.framework: _memcpy: This API should be avoided.
    CocoaLumberjack.framework: _strlen: This API should be avoided.
------------------------------------------
CocoaLumberjackSwift.framework
    CocoaLumberjackSwift.framework: _ptrace: Binary does not call ptrace
    CocoaLumberjackSwift.framework: _alloca: This API should be avoided.
    CocoaLumberjackSwift.framework: _memcpy: This API should be avoided.
    CocoaLumberjackSwift.framework: _strlen: This API should be avoided.
------------------------------------------
CommonCrypto.framework
    CommonCrypto.framework: _ptrace: Binary does not call ptrace
    CommonCrypto.framework: _alloca: This API should be avoided.
    CommonCrypto.framework: _memcpy: This API should be avoided.
    CommonCrypto.framework: _strlen: This API should be avoided.
------------------------------------------
xxxContext.framework
    xxxContext.framework: stack_chk_guard: fstack-protector-all flag was not found
    xxxContext.framework: _ptrace: Binary does not call ptrace
    xxxContext.framework: _memcpy: This API should be avoided.
------------------------------------------
Lottie.framework
    Lottie.framework: _NSLog: NSLog be used
    Lottie.framework: _ptrace: Binary does not call ptrace
    Lottie.framework: _alloca: This API should be avoided.
    Lottie.framework: _memcpy: This API should be avoided.
    Lottie.framework: _sscanf: This API should be avoided.
    Lottie.framework: _strlen: This API should be avoided.
------------------------------------------
SDWebImage.framework
    SDWebImage.framework: _ptrace: Binary does not call ptrace
    SDWebImage.framework: _alloca: This API should be avoided.
    SDWebImage.framework: _memcpy: This API should be avoided.
    SDWebImage.framework: _strlen: This API should be avoided.
------------------------------------------
xxxsKit.framework
    xxxsKit.framework: stack_chk_guard: fstack-protector-all flag was not found
    xxxsKit.framework: _ptrace: Binary does not call ptrace
------------------------------------------
xxxCommonProtocols.framework
    xxxCommonProtocols.framework: stack_chk_guard: fstack-protector-all flag was not found
    xxxCommonProtocols.framework: _objc_release: fobjc-arc flag was not found
    xxxCommonProtocols.framework: _ptrace: Binary does not call ptrace
    xxxCommonProtocols.framework: _memcpy: This API should be avoided.
------------------------------------------
xxx.framework
    xxx.framework: _ptrace: Binary does not call ptrace
    xxx.framework: _memcpy: This API should be avoided.
    xxx.framework: _sscanf: This API should be avoided.
    xxx.framework: _fopen: This API should be avoided.
------------------------------------------
xxxServices.framework
    xxxServices.framework: _ptrace: Binary does not call ptrace
------------------------------------------
xxxReachability.framework
    xxxReachability.framework: _ptrace: Binary does not call ptrace
------------------------------------------
WebImage.framework
    WebImage.framework: _ptrace: Binary does not call ptrace
    WebImage.framework: _alloca: This API should be avoided.
    WebImage.framework: _memcpy: This API should be avoided.
    WebImage.framework: _strlen: This API should be avoided.
------------------------------------------
***Result***

Invalid results:50 - 
    xxxKitExample.app: _NSLog: NSLog be used 
    xxxKitExample.app: stack_chk_guard: fstack-protector-all flag was not found 
    xxxKitExample.app: _ptrace: Binary does not call ptrace 
    AFNetworking.framework: _NSLog: NSLog be used 
    AFNetworking.framework: _ptrace: Binary does not call ptrace 
    vvv.framework: stack_chk_guard: fstack-protector-all flag was not found 
    vvv.framework: _ptrace: Binary does not call ptrace 
    vvv.framework: _memcpy: This API should be avoided. 
    CocoaLumberjack.framework: _NSLog: NSLog be used 
    CocoaLumberjack.framework: _ptrace: Binary does not call ptrace 
    CocoaLumberjack.framework: _alloca: This API should be avoided. 
    CocoaLumberjack.framework: _memcpy: This API should be avoided. 
    CocoaLumberjack.framework: _strlen: This API should be avoided. 
    CocoaLumberjackSwift.framework: _ptrace: Binary does not call ptrace 
    CocoaLumberjackSwift.framework: _alloca: This API should be avoided. 
    CocoaLumberjackSwift.framework: _memcpy: This API should be avoided. 
    CocoaLumberjackSwift.framework: _strlen: This API should be avoided. 
    CommonCrypto.framework: _ptrace: Binary does not call ptrace 
    CommonCrypto.framework: _alloca: This API should be avoided. 
    CommonCrypto.framework: _memcpy: This API should be avoided. 
    CommonCrypto.framework: _strlen: This API should be avoided. 
    xxxContext.framework: stack_chk_guard: fstack-protector-all flag was not found 
    xxxContext.framework: _ptrace: Binary does not call ptrace 
    xxxContext.framework: _memcpy: This API should be avoided. 
    Lottie.framework: _NSLog: NSLog be used 
    Lottie.framework: _ptrace: Binary does not call ptrace 
    Lottie.framework: _alloca: This API should be avoided. 
    Lottie.framework: _memcpy: This API should be avoided. 
    Lottie.framework: _sscanf: This API should be avoided. 
    Lottie.framework: _strlen: This API should be avoided. 
    SDWebImage.framework: _ptrace: Binary does not call ptrace 
    SDWebImage.framework: _alloca: This API should be avoided. 
    SDWebImage.framework: _memcpy: This API should be avoided. 
    SDWebImage.framework: _strlen: This API should be avoided. 
    xxxPassKit.framework: stack_chk_guard: fstack-protector-all flag was not found 
    xxxPassKit.framework: _ptrace: Binary does not call ptrace 
    xxxCommonProtocols.framework: stack_chk_guard: fstack-protector-all flag was not found 
    xxxCommonProtocols.framework: _objc_release: fobjc-arc flag was not found 
    xxxCommonProtocols.framework: _ptrace: Binary does not call ptrace 
    xxxCommonProtocols.framework: _memcpy: This API should be avoided. 
    xxx.framework: _ptrace: Binary does not call ptrace 
    xxx.framework: _memcpy: This API should be avoided. 
    xxx.framework: _sscanf: This API should be avoided. 
    xxx.framework: _fopen: This API should be avoided. 
    xxxServices.framework: _ptrace: Binary does not call ptrace 
    xxxReachability.framework: _ptrace: Binary does not call ptrace 
    WebImage.framework: _ptrace: Binary does not call ptrace 
    WebImage.framework: _alloca: This API should be avoided. 
    WebImage.framework: _memcpy: This API should be avoided. 
    WebImage.framework: _strlen: This API should be avoided.
2019-05-17_10.50.04
ipa checke(v0.1.1)
Author: Wayne Hsiao chronicqazxc@gmail.com
https://github.com/chronicqazxc/ipa_check/
```

Author: Wayne Hsiao chronicqazxc@gmail.com
