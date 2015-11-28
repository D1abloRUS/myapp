#!/bin/bash

./gradlew clean && ./gradlew build

cp -f build/libs/*.jar package/opt/myapp/
fpm -s dir -t rpm -n myapp -v 0.1 -d java-1.6.0-openjdk --post-install package/postinstall --pre-uninstall package/preuninstall -C package/
