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
5. Examine following private APIs.
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
***Start validate _NSLog stack_chk_guard _objc_release _ptrace***
App info
 1.0(1)
com.xxx.xxxKitExample
------------------------------------------
xxxKitExample.app
Warning!!! NSLog be used
0x0000a4a4    41 _NSLog
0x0000c0a0    41 _NSLog
0x00000001000063b8    41 _NSLog
0x0000000100008110    41 _NSLog
Warning!!! fstack-protector-all flag was not found
0x0000a514    75 _objc_release
0x0000c0bc    75 _objc_release
0x000000010000640c    75 _objc_release
0x0000000100008148    75 _objc_release
Warning!!! Binary does not call ptrace
------------------------------------------
AFNetworking.framework
Warning!!! NSLog be used
0x00022418  5814 _NSLog
0x0002c0f8  5814 _NSLog
0x0000000000028fa4  5791 _NSLog
0x00000000000341c0  5791 _NSLog
0x0002c010  5923 ___stack_chk_guard
0x0000000000034098  5897 ___stack_chk_guard
0x00022858  5970 _objc_release
0x0002c208  5970 _objc_release
0x00000000000292a4  5943 _objc_release
0x00000000000343c0  5943 _objc_release
Warning!!! Binary does not call ptrace
------------------------------------------
xxx.framework
Warning!!! fstack-protector-all flag was not found
0x0001f988  5853 _objc_release
0x000282b0  5853 _objc_release
0x000000000002306c  5640 _objc_release
0x000000000002c3c0  5640 _objc_release
Warning!!! Binary does not call ptrace
------------------------------------------
CocoaLumberjack.framework
Warning!!! NSLog be used
0x00017794  3681 _NSLog
0x0001c0d8  3681 _NSLog
0x000000000001af48  3545 _NSLog
0x0000000000020140  3545 _NSLog
0x0001c0b0  3727 ___stack_chk_guard
0x0000000000020078  3587 ___stack_chk_guard
0x00017e94  3830 _objc_release
0x0001c298  3830 _objc_release
0x000000000001b3f8  3682 _objc_release
0x0000000000020460  3682 _objc_release
Warning!!! Binary does not call ptrace
------------------------------------------
CocoaLumberjackSwift.framework
0x00008088  1186 ___stack_chk_guard
0x00000000000080e8  1041 ___stack_chk_guard
0x000070bc  1240 _objc_release
0x00008190  1240 _objc_release
0x0000000000007244  1089 _objc_release
0x00000000000082a8  1089 _objc_release
Warning!!! Binary does not call ptrace
------------------------------------------
CommonCrypto.framework
0x0000c010   835 ___stack_chk_guard
0x000000000000c018   706 ___stack_chk_guard
0x0000a968   884 _objc_release
0x0000c138   884 _objc_release
0x000000000000aafc   749 _objc_release
0x000000000000c230   749 _objc_release
Warning!!! Binary does not call ptrace
------------------------------------------
xxx.framework
Warning!!! fstack-protector-all flag was not found
0x0002c02c  5102 _objc_release
0x00030514  5102 _objc_release
0x000000000002f844  4531 _objc_release
0x00000000000344e8  4531 _objc_release
Warning!!! Binary does not call ptrace
------------------------------------------
Lottie.framework
Warning!!! NSLog be used
0x00024ac0  4603 _NSLog
0x0002c118  4603 _NSLog
0x0000000000028740  4467 _NSLog
0x0000000000030218  4467 _NSLog
0x0002c080  4646 ___stack_chk_guard
0x0000000000030048  4507 ___stack_chk_guard
0x00024e60  4711 _objc_release
0x0002c200  4711 _objc_release
0x000000000002898c  4565 _objc_release
0x00000000000303a0  4565 _objc_release
Warning!!! Binary does not call ptrace
------------------------------------------
SDWebImage.framework
0x0007001c 11003 ___stack_chk_guard
0x00000000000800a8 10861 ___stack_chk_guard
0x0005ad80 11094 _objc_release
0x00070500 11094 _objc_release
0x0000000000068ef0 10941 _objc_release
0x0000000000080540 10941 _objc_release
Warning!!! Binary does not call ptrace
------------------------------------------
xxxKit.framework
Warning!!! fstack-protector-all flag was not found
0x00007ac0    64 _objc_release
0x00008048    64 _objc_release
0x0000000000007a8c    57 _objc_release
0x0000000000008090    57 _objc_release
Warning!!! Binary does not call ptrace
------------------------------------------
xxx.framework
Warning!!! fstack-protector-all flag was not found
Warning!!! fobjc-arc flag was not found
Warning!!! Binary does not call ptrace
------------------------------------------
xxx.framework
0x000cc184 24634 ___stack_chk_guard
0x00000000000e03e8 24507 ___stack_chk_guard
0x000a44dc 24706 _objc_release
0x000cc648 24706 _objc_release
0x00000000000af488 24571 _objc_release
0x00000000000e0a48 24571 _objc_release
Warning!!! Binary does not call ptrace
------------------------------------------
xxx.framework
0x00024044  4185 ___stack_chk_guard
0x000000000002c020  4166 ___stack_chk_guard
0x0001c934  4224 _objc_release
0x00024104  4224 _objc_release
0x00000000000233c8  4204 _objc_release
0x000000000002c1e0  4204 _objc_release
Warning!!! Binary does not call ptrace
------------------------------------------
xxx.framework
0x00008018   419 ___stack_chk_guard
0x0000000000008020   408 ___stack_chk_guard
0x000073b8   433 _objc_release
0x00008080   433 _objc_release
0x00000000000071f8   422 _objc_release
0x00000000000080e8   422 _objc_release
Warning!!! Binary does not call ptrace
------------------------------------------
WebImage.framework
0x00020008  4382 ___stack_chk_guard
0x0000000000024090  4242 ___stack_chk_guard
0x0001a794  4451 _objc_release
0x00020220  4451 _objc_release
0x000000000001d57c  4305 _objc_release
0x00000000000243d0  4305 _objc_release
Warning!!! Binary does not call ptrace
------------------------------------------
libswiftAVFoundation.dylib
Warning!!! fstack-protector-all flag was not found
Warning!!! fobjc-arc flag was not found
Warning!!! Binary does not call ptrace
------------------------------------------
libswiftCore.dylib
Warning!!! fstack-protector-all flag was not found
Warning!!! fobjc-arc flag was not found
Warning!!! Binary does not call ptrace
------------------------------------------
libswiftCoreAudio.dylib
Warning!!! fstack-protector-all flag was not found
Warning!!! fobjc-arc flag was not found
Warning!!! Binary does not call ptrace
------------------------------------------
libswiftCoreFoundation.dylib
Warning!!! fstack-protector-all flag was not found
Warning!!! fobjc-arc flag was not found
Warning!!! Binary does not call ptrace
------------------------------------------
libswiftCoreGraphics.dylib
Warning!!! fstack-protector-all flag was not found
Warning!!! fobjc-arc flag was not found
Warning!!! Binary does not call ptrace
------------------------------------------
libswiftCoreImage.dylib
Warning!!! fstack-protector-all flag was not found
Warning!!! fobjc-arc flag was not found
Warning!!! Binary does not call ptrace
------------------------------------------
libswiftCoreLocation.dylib
Warning!!! fstack-protector-all flag was not found
Warning!!! fobjc-arc flag was not found
Warning!!! Binary does not call ptrace
------------------------------------------
libswiftCoreMedia.dylib
Warning!!! fstack-protector-all flag was not found
Warning!!! fobjc-arc flag was not found
Warning!!! Binary does not call ptrace
------------------------------------------
libswiftDarwin.dylib
Warning!!! fstack-protector-all flag was not found
Warning!!! fobjc-arc flag was not found
Warning!!! Binary does not call ptrace
------------------------------------------
libswiftDispatch.dylib
Warning!!! fstack-protector-all flag was not found
Warning!!! fobjc-arc flag was not found
Warning!!! Binary does not call ptrace
------------------------------------------
libswiftFoundation.dylib
Warning!!! fstack-protector-all flag was not found
Warning!!! fobjc-arc flag was not found
Warning!!! Binary does not call ptrace
------------------------------------------
libswiftMapKit.dylib
Warning!!! fstack-protector-all flag was not found
Warning!!! fobjc-arc flag was not found
Warning!!! Binary does not call ptrace
------------------------------------------
libswiftMetal.dylib
Warning!!! fstack-protector-all flag was not found
Warning!!! fobjc-arc flag was not found
Warning!!! Binary does not call ptrace
------------------------------------------
libswiftObjectiveC.dylib
Warning!!! fstack-protector-all flag was not found
Warning!!! fobjc-arc flag was not found
Warning!!! Binary does not call ptrace
------------------------------------------
libswiftQuartzCore.dylib
Warning!!! fstack-protector-all flag was not found
Warning!!! fobjc-arc flag was not found
Warning!!! Binary does not call ptrace
------------------------------------------
libswiftUIKit.dylib
Warning!!! fstack-protector-all flag was not found
Warning!!! fobjc-arc flag was not found
Warning!!! Binary does not call ptrace
------------------------------------------
libswiftos.dylib
Warning!!! fstack-protector-all flag was not found
Warning!!! fobjc-arc flag was not found
Warning!!! Binary does not call ptrace
------------------------------------------
libswiftsimd.dylib
Warning!!! fstack-protector-all flag was not found
Warning!!! fobjc-arc flag was not found
Warning!!! Binary does not call ptrace
------------------------------------------
***Result***
No valid result
No invalid result
2019-05-16_18.17.27
ipa checke(v0.1.0)
Author: Wayne Hsiao chronicqazxc@gmail.com
https://github.com/chronicqazxc/ipa_check/
```

Author: Wayne Hsiao chronicqazxc@gmail.com
