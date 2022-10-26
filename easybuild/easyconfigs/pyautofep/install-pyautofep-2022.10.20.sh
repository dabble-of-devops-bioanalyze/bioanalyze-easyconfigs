#!/usr/bin/env bash


export PATH=${INSTALLDIR}/bin:$PATH
cd /tmp 
wget https://github.com/luancarvalhomartins/PyAutoFEP/archive/9de6a9f93214ece37e5d8808a716234b4c0960d1.zip
unzip 9de6a9f93214ece37e5d8808a716234b4c0960d1.zip
cd PyAutoFEP-9de6a9f93214ece37e5d8808a716234b4c0960d1/

cp -rf * ${INSTALLDIR}/bin/

