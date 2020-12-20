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
PWD:=$(shell pwd)

all: clean
	mkdir --parents $(PWD)/build/Boilerplate.AppDir/leafpad
	apprepo --destination=$(PWD)/build appdir boilerplate libatk1.0-0 libatk-bridge2.0-0 libgtk-3-0

	wget --output-document="$(PWD)/build/build.deb" http://ftp.de.debian.org/debian/pool/main/l/leafpad/leafpad_0.8.18.1-5_amd64.deb
	dpkg -x $(PWD)/build/build.deb $(PWD)/build

	cp --force --recursive $(PWD)/build/usr/bin/* $(PWD)/build/Boilerplate.AppDir/bin
	cp --force --recursive $(PWD)/build/usr/share/* $(PWD)/build/Boilerplate.AppDir/share

	echo "exec \$${APPDIR}/bin/leafpad \"\$${@}\"" >> $(PWD)/build/Boilerplate.AppDir/AppRun


	rm -f $(PWD)/build/Boilerplate.AppDir/*.desktop | true
	rm -f $(PWD)/build/Boilerplate.AppDir/*.png | true
	rm -f $(PWD)/build/Boilerplate.AppDir/*.svg | true	

	cp --force $(PWD)/AppDir/*.svg $(PWD)/build/Boilerplate.AppDir
	cp --force $(PWD)/AppDir/*.desktop $(PWD)/build/Boilerplate.AppDir
	
	export ARCH=x86_64 && bin/appimagetool.AppImage $(PWD)/build/Boilerplate.AppDir $(PWD)/Leafpad.AppImage
	chmod +x $(PWD)/Leafpad.AppImage

clean:
	rm -rf $(PWD)/build
