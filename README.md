# scim2playground
This is my testing image for scim2/djago/apache/sssd integration.

This container runs apache httpd and sssd.

Django3 and scim2 module are installed empty django project is created

## Playing with container
There is a Makefile to make it a bit easier.

* make build - Just remove image and build it again
* make prep - Extracts folders from container to local file system for modifications
* make fun - starts the container in foreground, mounts folders created with make prep
* make attach - attach to the running container and start bash
* make look - run the container in foreground but start shell instead of supervisord

The container is allways started with `--rm`.

Container (started with `make fun`) exposes apache httpd on port 8000
