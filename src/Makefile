all:
	echo "use make build|fun|attach"

build:
	podman rmi scim2playground || true
	podman build -f ./Dockerfile -t scim2playground .

fun:
	podman run --rm -i -t -p 8000:80 -v `pwd`/django:/var/www/django:Z -v `pwd`/conf.d:/etc/httpd/conf.d:Z --name scim2playground scim2playground

attach:
	podman exec -i -t scim2playground /bin/bash

prep:
	podman run --rm scim2playground tar -C /etc/httpd -cf - conf.d | tar -xf -
	podman run --rm scim2playground tar -C /var/www -cf - django | tar -xf -

look:
	podman run --rm -i -t -p 8000:80 scim2playground /bin/bash
