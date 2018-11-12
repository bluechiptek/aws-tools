ACTIVATE=. venv/bin/activate &&
PIP_INSTALL := $(ACTIVATE) pip install --disable-pip-version-check
DATE:=$(shell date +"%d-%m-%y.%H-%M")

build:
	@virtualenv --python=python2.7 venv
	$(PIP_INSTALL) -r requirements.txt
	rm -rf build && mkdir -p build/lib
	zip -q -r "build/graffiti-monkey-${DATE}.zip" . -x build\*
	$(PIP_INSTALL) -q -Ur requirements.txt -t build/lib/
	cd build/lib/ && \
		zip -r ../graffiti-monkey.zip .
	aws s3 --profile ${PROFILE} cp "build/graffiti-monkey-${DATE}.zip" \
		"s3://${BUCKET}/graffiti-monkey/"
	make clean

clean:
	rm -rf build/ venv/

.PHONY: build
