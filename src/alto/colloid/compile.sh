#!/bin/bash
LOGF=log
cd linux
git checkout v6.3
echo "Checking colloid-skx.patch ..."
[[ -e colloid-skx.patch ]] || exit
git apply colloid-skx.patch
echo "Checking colloid-skx-alto.patch ..."
[[ -e colloid-skx-alto.patch ]] || exit
git apply colloid-skx-alto.patch

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
