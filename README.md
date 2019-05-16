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

Author: Wayne Hsiao chronicqazxc@gmail.com
