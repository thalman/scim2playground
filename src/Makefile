all:
	echo "use make build|fun|attach|run|prep|tar|base"

base:
	if podman rmi "scim2playground:base"; then podman rmi "scim2playground:base"; else true; fi
	podman build -f ./Dockerfile --target BASE -t scim2playground:base .

tar:
	if podman rmi "scim2playground:tar"; then podman rmi "scim2playground:tar"; else true; fi
	podman build -f ./Dockerfile --target TAR -t scim2playground:tar .
	podman run --rm scim2playground:tar tar -C /var/www -cf - django/app django/venv | gzip > scim2playground.tgz

build:
	if podman image exists "scim2playground:latest"; then podman rmi "scim2playground:latest"; else true; fi
	podman build -f ./Dockerfile --target FINAL -t scim2playground:latest .

fun:
	podman run --rm -i -t -p 8000:80 -v `pwd`/django:/var/www/django:Z -v `pwd`/conf.d:/etc/httpd/conf.d:Z --name scim2playground scim2playground

run:
	podman run --rm -i -t -p 8000:80 -v `pwd`/django:/var/www/django:Z -v `pwd`/conf.d:/etc/httpd/conf.d:Z --detach --name scim2playground scim2playground

attach:
	podman exec -i -t scim2playground /bin/bash

prep:
	podman run --rm scim2playground:tar tar -C /etc/httpd -cf - conf.d | tar -xf -
	podman run --rm scim2playground:tar tar -C /var/www -cf - django | tar -xf -

clean:
	podman rmi "scim2playground:tar" "scim2playground:latest" "scim2playground:base"
