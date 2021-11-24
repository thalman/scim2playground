FROM centos:8

# enable EPEL repo and install required packages
RUN dnf -y install epel-release && \
    dnf -y install supervisor sssd httpd python3-django3 python3-mod_wsgi && \
    dnf clean all

COPY sssd.conf /etc/sssd/
COPY sssd.ini httpd.ini /etc/supervisord.d/
COPY supervisord.conf /etc/
COPY app.conf /etc/httpd/conf.d/
COPY entrypoint /usr/bin/

# prepare sssd
RUN chmod 600 /etc/sssd/sssd.conf && \
    chown root:root /etc/sssd/sssd.conf

# prepare django, venv with scim2
RUN mkdir -p /var/www/django && \
    cd /var/www/django && \
    python3 -m venv venv && \
    . ./venv/bin/activate && \
    pip install django-scim2 && \
    django-admin startproject app

ENTRYPOINT [ "/usr/bin/entrypoint" ]
