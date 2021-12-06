PODMAN := $(shell if ! which podman 2>/dev/null; then which docker; fi)
BASEIMAGE := $(shell if [ "${BASEIMAGE}" = "" ] ; then echo "centos:8" ; else echo "${BASEIMAGE}"; fi)

all:
	@echo "use make build|fun|attach|run|prep|tar|base"

base:
	if $(PODMAN) image exists "scim2playground:base"; then $(PODMAN) rmi "scim2playground:base"; else true; fi
	$(PODMAN) build -f Dockerfile --build-arg from=$(BASEIMAGE) --target BASE -t scim2playground:base .

tar:
	if $(PODMAN) image exists "scim2playground:tar"; then $(PODMAN) rmi "scim2playground:tar"; else true; fi
	$(PODMAN) build -f Dockerfile --build-arg from=$(BASEIMAGE) --target TAR -t scim2playground:tar .
	$(PODMAN) run --rm scim2playground:tar tar -C /var/www -cf - django/app django/venv | gzip > scim2playground.tgz

build:
	if $(PODMAN) image exists "scim2playground:latest"; then $(PODMAN) rmi "scim2playground:latest"; else true; fi
	$(PODMAN) build -f Dockerfile --build-arg from=$(BASEIMAGE) --target FINAL -t scim2playground:latest .

fun:
	$(PODMAN) run --rm -i -t -p 8000:80 -v `pwd`/django:/var/www/django:Z -v `pwd`/conf.d:/etc/httpd/conf.d:Z --name scim2playground scim2playground

run:
	$(PODMAN) run --rm -i -t -p 8000:80 -v `pwd`/django:/var/www/django:Z -v `pwd`/conf.d:/etc/httpd/conf.d:Z --detach --name scim2playground scim2playground

attach:
	$(PODMAN) exec -i -t scim2playground /bin/bash

prep:
	$(PODMAN) run --rm scim2playground:tar tar -C /etc/httpd -cf - conf.d | tar -xf -
	$(PODMAN) run --rm scim2playground:tar tar -C /var/www -cf - django | tar -xf -

clean:
	$(PODMAN) rmi "scim2playground:tar" "scim2playground:latest" "scim2playground:base"
