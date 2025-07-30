#!/bin/bash
LOGF=log
cd linux
git checkout v5.18
echo "Checking nbt.patch ..."
[[ -e nbt.patch ]] || exit
git apply nbt.patch

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
