# Quant HD User Facing Driver Module for Webcam Found in Acer Laptops.

this module fixes camera 📷 on bunch of acer laptops 💻 like Acer Nitro 5 running linux.

> Special Thanks to [@Giuliano69](https://github.com/Giuliano69) for the driver reference 🥰
***
## USAGE

### check if its present in your laptop or not.
```
lsusb | grep "Quanta Computer"
```
if it shows something like this
>Bus 003 Device 003: ID 0408:4035 Quanta Computer, Inc.

then you can go ahead.

### Disable Secure boot as the module is not signed and it will give error
>insmod: ERROR: could not insert module /usr/lib/modules/uvcvideo.ko: key was rejected by service

### Install Required Packages

ubuntu 
```
sudo apt install build-essential
```
Fedora/Nobara
```
sudo dnf install kernel-devel
```
### clone the repo
```
git clone git@github.com:PrabhatProxy/Quanta-HD-User-Facing-0x0408-0x4035_linux.git && cd Quanta-HD-User-Facing-0x0408-0x4035_linux
```
### Method 1: build and install 
```
chmod +x install_driver.sh
./install_driver.sh
```
### Method 2: Makefile method
```
$ make                   // previously installed modules remove and install again
$ make clean            // clean previous installed modules
$ make install         // install the module
```

Now your camera should be working most probably!
***
### if this dont work then try doing it manually by the following steps.
1. Get Your Kernel Source
2. Navigate to drivers/media/usb/uvc
3. Add [This](https://github.com/PrabhatProxy/Quanta-HD-User-Facing-0x0408-0x4035_linux/commit/a6d73da23375a367787d748454443513455cd6aa) code to uvc_driver.c
4. compile the module only in the same directory using the command
   ```
   make -C /lib/modules/$(uname -r)/build M=$(pwd)  
   ```
   on ubuntu based distros 
   ```
   COMPILER_VERSION=$(grep -o 'x86_64-linux-gnu-gcc-[0-9]*' /proc/version | head -n 1)
   make -C /lib/modules/$(uname -r)/build M=$(pwd) CC="$COMPILER_VERSION"
   ```
5. If it compiles fine you would get a uvcvideo.ko module in the folder.
6. Unload previous version from kernel using
   ```
   sudo rmmod uvcvideo
   ```
7. Load new module
   ```
   sudo insmod uvcvideo.ko
   ```
   Now it should work but change will be removed on reboot:)
## Tested On
| Distro | version |
| ------------- | ------------- |
| Nobara  | 38  |
| Fedora  |  39  |
| Ubuntu  |  23.10  |
| Pop_OS!  |  22.04  |

Tell me if it works for you! i will update the readme!

### Dont forget to star ⭐ the repo and follow me on github 😉
***
## BuyMeACoffee if you want
<a href="https://www.buymeacoffee.com/PrabhatProxy" target="_blank"><img src="https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png" alt="Buy Me A Coffee" style="height: 41px !important;width: 174px !important;box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;-webkit-box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;" ></a>
***
## you can reach me out for any issues and help on ⬇️
   [![Static Badge](https://img.shields.io/badge/Discord-%235865F2?style=for-the-badge&logo=Discord&logoColor=white&link=https%3A%2F%2Fdiscord.com%2Finvite%2F5Rpa6RT4)](https://discord.com/invite/5Rpa6RT4)
   [![Static Badge](https://img.shields.io/badge/Telegram-%230088CC?style=for-the-badge&logo=Telegram&logoColor=white)](https://t.me/prabhat_proxy)

