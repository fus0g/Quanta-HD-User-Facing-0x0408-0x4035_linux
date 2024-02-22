#!/bin/bash

echo "### Module For QUANT HD USER FACING BY @Prabhat_Proxy ###"
echo "     Special Thanks to Giuliano69 for the driver :)"
echo ""

echo "installing..."

echo ""
echo "1) copying module to root."
sudo cp -r modules /root/
echo ""
echo "2) copying service to systemd."
sudo cp loaduvc.service /etc/systemd/system/loaduvc.service
echo ""
echo "3) enabling service."
sudo systemctl enable loaduvc.service

echo ""
echo "If their are no errors then you can reboot and your camera will start working!"