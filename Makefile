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

all:
	rm -rf $(PWD)/build
	mkdir -p $(PWD)/build
	mkdir -p $(PWD)/build/AppDir


	wget --output-document=$(PWD)/build/build.rpm  https://download-ib01.fedoraproject.org/pub/epel/8/Everything/x86_64/Packages/s/simple-scan-3.36.2.1-1.el8.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	wget --output-document=$(PWD)/build/build.rpm  http://mirror.centos.org/centos/8/AppStream/x86_64/os/Packages/cairo-1.15.12-3.el8.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	wget --output-document=$(PWD)/build/build.rpm  http://mirror.centos.org/centos/8/AppStream/x86_64/os/Packages/libwebp-1.0.0-1.el8.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..


	glib-compile-schemas $(PWD)/build/usr/share/glib-2.0/schemas
	cp -r $(PWD)/build/usr/* $(PWD)/build/AppDir
	cp -r $(PWD)/AppDir/* $(PWD)/build/AppDir

	export ARCH=x86_64 && $(PWD)/bin/appimagetool-x86_64.AppImage $(PWD)/build/AppDir $(PWD)/SimpleScan.AppImage
	@echo "done: SimpleScan.AppImage"
	make clean


clean:
	rm -rf ${PWD}/build
