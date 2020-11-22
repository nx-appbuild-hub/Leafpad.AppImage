# Copyright 2020 Alex Woroschilow (alex.woroschilow@gmail.com)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

SOURCE="https://dl.bintray.com/probono/AppImages/Leafpad-0.8.18.1.glibc2.4-x86_64.AppImage"
OUTPUT="Leafpad.AppImage"

all: clean
	mkdir --parents $(PWD)/build

	wget --output-document="$(PWD)/build/Leafpad.AppImage" "https://dl.bintray.com/probono/AppImages/Leafpad-0.8.18.1.glibc2.4-x86_64.AppImage"
	chmod +x $(PWD)/build/Leafpad.AppImage

	wget --no-check-certificate --output-document=$(PWD)/build/build.rpm http://mirror.centos.org/centos/8/AppStream/x86_64/os/Packages/gtk2-2.24.32-4.el8.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..


	cd $(PWD)/build && $(PWD)/build/Leafpad.AppImage --appimage-extract
	cp --force --recursive $(PWD)/build/usr/lib64/* $(PWD)/build/squashfs-root/usr/lib


	rm -f $(PWD)/build/squashfs-root/leafpad.png
	rm -f $(PWD)/build/squashfs-root/leafpad.desktop
	cp --force $(PWD)/leafpad.svg $(PWD)/build/squashfs-root/
	cp --force $(PWD)/leafpad.desktop $(PWD)/build/squashfs-root/

	export ARCH=x86_64 && bin/appimagetool.AppImage $(PWD)/build/squashfs-root $(PWD)/Leafpad.AppImage
	chmod +x $(PWD)/Leafpad.AppImage

clean:
	rm -rf $(PWD)/build
