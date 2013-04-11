::: $Id: install-info.bat,v 1.3 2002/11/17 09:49:47 kose Exp $
:::
::: Copyright (C) 2002 The Meadow Team
::: Author: KOSEKI Yoshinori <kose@meadowy.org>
:::
::: install-info.bat
::: install-info.bat --delete
:::
cd ..\..\1.15\info
..\bin\install-info.exe autoconf-ja.info dir %1
..\bin\install-info.exe automake-ja.info dir %1
..\bin\install-info.exe binutils-ja.info dir %1
..\bin\install-info.exe bison-ja.info dir %1
..\bin\install-info.exe cvs-ja.info dir %1
..\bin\install-info.exe diff-ja.info dir %1
..\bin\install-info.exe fileutils-ja.info dir %1
..\bin\install-info.exe find-ja.info dir %1
..\bin\install-info.exe flex-ja.info dir %1
..\bin\install-info.exe gdb-ja.info dir %1
..\bin\install-info.exe grep-ja.info dir %1
..\bin\install-info.exe gzip-ja.info dir %1
..\bin\install-info.exe --entry="* Elisp-ja: (elisp-ja).	The Emacs Lisp Reference Manual." --section="Editors" elisp-ja.info dir %1
..\bin\install-info.exe --entry="* Emacs-ja: (emacs-ja).	The extensible self-documenting text editor." --section="Editors" emacs-ja.info dir %1
..\bin\install-info.exe hurd-ja.info dir %1
..\bin\install-info.exe libtool-ja.info dir %1
..\bin\install-info.exe m4-ja.info dir %1
..\bin\install-info.exe sed-ja.info dir %1
..\bin\install-info.exe sh-utils-ja.info dir %1
..\bin\install-info.exe --entry="* Standards: (standards-ja).     GNU coding standards." standards-ja.info dir %1
..\bin\install-info.exe texinfo-ja.info dir %1
..\bin\install-info.exe textutils-ja.info dir %1
..\bin\install-info.exe wget-ja.info dir %1
::: end
