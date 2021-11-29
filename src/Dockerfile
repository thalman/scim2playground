FROM centos:8 as BASE

# install required packages, enable services
RUN dnf -y install sssd httpd python3 python3-mod_wsgi && \
    dnf clean all && \
    systemctl enable httpd && \
    systemctl enable sssd && \
    mkdir -p /var/www/django

COPY --chown=0:0 --chmod=600 sssd.conf /etc/sssd/
COPY app.conf /etc/httpd/conf.d/

FROM BASE as TAR
#---------------

COPY requirements.txt /var/www/django/

# prepare django, venv with scim2
RUN cd /var/www/django && \
    python3 -m venv venv && \
    . ./venv/bin/activate && \
    pip install -r requirements.txt && \
    django-admin startproject app

FROM BASE as FINAL
#-----------------

ADD scim2playground.tgz /var/www/

ENTRYPOINT [ "/sbin/init" ]
