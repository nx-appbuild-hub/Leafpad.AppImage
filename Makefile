SOURCE="https://dl.bintray.com/probono/AppImages/Leafpad-0.8.18.1.glibc2.4-x86_64.AppImage"
OUTPUT="Leafpad.AppImage"

all:
	echo "Building: $(OUTPUT)"
	rm -f ./$(OUTPUT)
	wget --output-document=$(OUTPUT) --continue $(SOURCE)
	chmod +x $(OUTPUT)

	./Leafpad.AppImage --appimage-extract
	rm -f squashfs-root/leafpad.png
	rm -f squashfs-root/leafpad.desktop
	cp ./leafpad.svg squashfs-root/
	cp ./leafpad.desktop squashfs-root/
	export ARCH=x86_64 && bin/appimagetool.AppImage squashfs-root $(OUTPUT)
	rm -rf squashfs-root/
	chmod +x $(OUTPUT)
