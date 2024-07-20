#!/bin/bash

echo "### Module For QUANT HD USER FACING BY @Prabhat_Proxy ###"
echo "     Special Thanks to Giuliano69 for the driver :)"
echo ""

echo "building"
echo ""
cd src/uvc
COMPILER_VERSION=$(grep -o 'x86_64-linux-gnu-gcc-[0-9]*' /proc/version | head -n 1)
if [[ -z $COMPILER_VERSION ]]; then
    make -C /lib/modules/$(uname -r)/build M=$(pwd)
else
    echo "$COMPILER_VERSION"
    echo ""
    make -C /lib/modules/$(uname -r)/build M=$(pwd) CC="$COMPILER_VERSION"
fi

if [ -e uvcvideo.ko ]
then
    echo "Compiled Successfully"
    echo "copying module to root."
    echo ""

    sudo cp -r uvcvideo.ko /usr/lib/modules/uvcvideo.ko
    cd ../..
    sudo cp loaduvc.sh /usr/bin/loaduvc.sh
    echo ""
    echo "2) copying service to systemd."
    sudo cp loaduvc.service /etc/systemd/system/loaduvc.service
    echo ""
    echo "3) enabling service."
    sudo systemctl enable loaduvc.service
    sudo systemctl start loaduvc.service

    echo ""
    echo "If their are no errors then your camera will start working!"
else
    echo "failed to compile module! check docs and report any error"
fi

echo ""
echo "report any issue on github repo https://github.com/PrabhatProxy/Quanta-HD-User-Facing-0x0408-0x4035_linux/issues "
