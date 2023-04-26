all: sqlcmdline.exe

sqlcmdline.exe : sqlcmdline.py sqlcmdline.spec sqlcmdline.ico
	pyinstaller sqlcmdline.spec --distpath bin
	rd /S /Q build
	checksum bin\$@ -t sha256 > bin\$*.sha256
