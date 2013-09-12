NW    := node-webkit-v0.7.2
NWWIN := $(NW)-win-ia32
NWMAC := $(NW)-osx-ia32

deps:
	touch tmp
	rm -rf tmp node_modules
	mkdir tmp
	rm -rf tmp
	npm install ejs
	cp ejs.js node_modules/ejs/lib/

# I downloaded zip.exe & unzip.exe from http://stahlworks.com/dev/?tool=zipunzip
win:
	if exist appName.nw del appName.nw /q
	if exist dist\win rmdir dist\win /s /q
	if exist tmp rmdir tmp /s /q
	zip -r appName.nw appdir package.json node_modules
	mkdir dist\win tmp
	unzip -d tmp -o src\$(NWWIN).zip
	copy /b tmp\nw.exe+appName.nw dist\win\appName.exe
	copy tmp\icudt.dll dist\win
	copy tmp\nw.pak dist\win
	if exist appName.nw del appName.nw /q
	if exist tmp rmdir tmp /q /s

# winico reshacker isn't quite working. should be combined with "win" target
winico:
	"C:\Program Files (x86)\Resource Hacker\ResHacker.exe" -addoverwrite dist\win\appName.exe new.exe resources\appName.ico, ico, 1033

mac:
	[ ! -f appName.nw ] || rm appName.nw
	zip -r appName.nw appdir package.json resources/appName72x72.png node_modules
	touch node-webkit.app
	rm -rf node-webkit.app dist/appName.app dist/mac
	mkdir dist/mac
	unzip -o src/$(NWMAC).zip
	mv node-webkit.app dist/mac/appName.app
	mv appName.nw dist/mac/appName.app/Contents/Resources/app.nw
	rm dist/mac/appName.app/Contents/Resources/nw.icns
	sips -s format icns resources/appName512x512.png --out dist/mac/appName.app/Contents/Resources/appName.icns
	perl -i -pe 's{nw[.]icns}{appName.icns}smxg' dist/mac/appName.app/Contents/Info.plist
	perl -i -pe 's{node[-]webkit[ ]App}{appName}smxg' dist/mac/appName.app/Contents/Info.plist
