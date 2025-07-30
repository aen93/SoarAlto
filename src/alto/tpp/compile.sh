#!/bin/bash
LOGF=log
cd linux
git checkout v5.15
echo "Checking tpp.patch ..."
[[ -e tpp.patch ]] || exit
git apply tpp.patch
echo "Checking tpp-alto.patch ..."
[[ -e tpp-alto.patch ]] || exit
git apply tpp-alto.patch

echo "make oldconfig ...";
yes "" | make oldconfig > $LOGF 2>&1 || exit ;
echo "make ...";
make -j 21 >> $LOGF 2>&1 || exit ;
echo "make INSTALL_MOD_STRIP=1 modules_install ...";
make INSTALL_MOD_STRIP=1 modules_install >> $LOGF 2>&1 || exit ;
echo "make install ...";
make install >> $LOGF 2>&1 || exit;
echo "update-grub ...";
update-grub || exit;

rm $LOGF
cd -;
