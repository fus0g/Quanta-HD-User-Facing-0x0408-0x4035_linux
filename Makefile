all: clean install

clean:
	sudo rm  /usr/lib/modules/uvcvideo.ko
	sudo rm  /usr/bin/loaduvc.sh

install:
	sh install_driver.sh
