.PHONY: build build-debug lint

build:
	packer build template.pkr.hcl

build-debug:
	PACKER_LOG=1 packer build -color=false template.pkr.hcl 2>&1 | tee build.log

lint:
	packer fmt template.pkr.hcl && packer validate template.pkr.hcl
