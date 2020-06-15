SOURCE="https://dl.bintray.com/probono/AppImages/Leafpad-0.8.18.1.glibc2.4-x86_64.AppImage"
OUTPUT="Leafpad.AppImage"

all:
	echo "Building: $(OUTPUT)"
	rm -f ./$(OUTPUT)
	wget --output-document=$(OUTPUT) --continue $(SOURCE)
	chmod +x $(OUTPUT)

