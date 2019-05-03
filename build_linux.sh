#!/bin/bash

#
# SHOULD BUILD IMAGE BEFORE
# docker build -t lambdanative:2.2 .
#

rm -f $(pwd)/bootstrap
rm -f $(pwd)/package.zip
docker run -it --rm -v $(pwd):/app lambdanative:3.0
cp bin/Release/netcoreapp3.0/linux-x64/native/corert-db bootstrap
zip package.zip bootstrap
aws s3 cp package.zip s3://backend-layer --profile sansiri