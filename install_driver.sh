#!/bin/bash

echo "### Module For QUANT HD USER FACING BY @Prabhat_Proxy ###"
echo "     Special Thanks to Giuliano69 for the driver :)"
echo ""

echo "building"
echo ""
cd src/uvc
rm -rf *.o *.ko *.mod* *.symvers *.order
COMPILER_VERSION=$(grep -o 'x86_64-linux-gnu-gcc-[0-9]*' /proc/version | head -n 1)
if [[ -z $COMPILER_VERSION ]]; the#!/bin/bash

echo "### Module For QUANT HD USER FACING BY @Prabhat_Proxy ###"
echo "     Special Thanks to Giuliano69 for the driver :)"
echo ""

# Step 1: Generate MOK key pair if they don't exist
if [ ! -f /root/MOK.key ] || [ ! -f /root/MOK.crt ]; then
    echo "Generating MOK key pair..."
    openssl req -new -x509 -newkey rsa:2048 -keyout /root/MOK.key -out /root/MOK.crt -nodes -days 36500 -subj "/CN=Quanta Webcam Driver/"
    echo "MOK key pair generated."
fi

echo "Building"
echo ""
cd src/uvc
rm -rf *.o *.ko *.mod* *.symvers *.order
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
    
    # Step 2: Sign the module
    echo "Signing the module..."
    sudo /usr/src/linux-headers-$(uname -r)/scripts/sign-file sha256 /root/MOK.key /root/MOK.crt uvcvideo.ko
    echo "Module signed successfully."

    # Step 3: Convert the certificate to DER format and enroll the MOK
    echo "Converting MOK certificate to DER format..."
    openssl x509 -in /root/MOK.crt -outform DER -out /root/MOK.der
    echo "Enrolling MOK key..."
    sudo mokutil --import /root/MOK.der
    echo "Reboot and follow the instructions to enroll the MOK key."

    echo "Copying module to root."
    sudo rm -rf /usr/lib/modules/uvcvideo.ko
    sudo rm -rf /usr/bin/loaduvc.sh
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
    echo "If there are no errors, your camera will start working!"
else
    echo "Failed to compile module! Check docs and report any error"
fi

echo ""
echo "Report any issues on GitHub repo: https://github.com/PrabhatProxy/Quanta-HD-User-Facing-0x0408-0x4035_linux/issues"
n
    make -C /lib/modules/$(uname -r)/build M=$(pwd)
then
    echo "$COMPILER_VERSION"
    echo ""
    make -C /lib/modules/$(uname -r)/build M=$(pwd) CC="$COMPILER_VERSION"
fi

if [ -e uvcvideo.ko ]
then
    echo "Compiled Successfully"
    echo "copying module to root."
    echo ""

    sudo rm -rf /usr/lib/modules/uvcvideo.ko
    sudo rm -rf /usr/bin/loaduvc.sh
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
