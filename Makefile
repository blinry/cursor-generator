default:
	rm -rf tmp/export/
	mkdir tmp/export/
	cp emoji/output -ar tmp/export/default
	cd tmp/export/ && tar -czvf ../emoji.tar.gz .
