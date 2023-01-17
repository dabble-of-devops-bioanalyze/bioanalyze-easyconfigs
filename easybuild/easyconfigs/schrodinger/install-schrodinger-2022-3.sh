#!/usr/bin/env bash

CURDIR=$(pwd)

cd ~/Schrodinger_Suites_2022-3_Advanced_Linux-x86_64/
./INSTALL -d . -s ${INSTALLDIR} -k /usr/tmp -t ${INSTALLDIR}/thirdparty -b *

exit 0
