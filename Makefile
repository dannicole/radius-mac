MIPSEL_IMAGE=radius-mac-builder-mipsel
MIPS_IMAGE=radius-mac-builder-mips

all:
	@$(MAKE) -C src

clean:
	$(MAKE) -C src clean

mipsel:
	docker build -t $(MIPSEL_IMAGE) --build-arg BUILD_ARCH=mipsel \
		-f docker/Dockerfile.stretch docker
	docker run --rm -v $(shell pwd)/src:/src -w /src $(MIPSEL_IMAGE) \
		make CC=mipsel-linux-gnu-gcc clean radius-mac

mips:
	docker build -t $(MIPS_IMAGE) --build-arg BUILD_ARCH=mips \
		-f docker/Dockerfile.stretch docker
	docker run --rm -v $(shell pwd)/src:/src -w /src $(MIPS_IMAGE) \
		make CC=mips-linux-gnu-gcc clean radius-mac


.PHONY: all clean mipsel mips
