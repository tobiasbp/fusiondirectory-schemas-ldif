# fusiondirectory-database-init
A utility Docker image for preparing schema and ldif files to initialize an
LDAP database for use with [FusionDirectory](https://www.fusiondirectory.org/) version [1.3](https://fusiondirectory-user-manual.readthedocs.io/en/1.3/index.html).

# Usage
The schema files are stored in _/var/fd/schema/core_ and _/var/fd/schema/plugins_.
The .ldif file(s) are in in _/var/fd/ldif_.

This image has been tested with Docker image [osixia/docker-openldap](https://github.com/osixia/docker-openldap)
which is able to read schema and ldif files when the container is run the first time.

Make your schema files available to _osixia/docker-openldap_ by mounting them here: 
`/container/service/slapd/assets/config/bootstrap/schema/core`
`/container/service/slapd/assets/config/bootstrap/schema/plugins`

Make your ldif file(s) available to _osixia/docker-openldap_ by mounting them here: 
`/container/service/slapd/assets/config/bootstrap/ldif/fd-ldif`

If you are using Kubernetes, you can run this image as an [Init Container](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/)
together with [osixia/docker-openldap](https://github.com/osixia/docker-openldap) when configuring an LDAP backend for FusionDirectory.

[osixia/docker-openldap](https://github.com/osixia/docker-openldap) will fail if it can not remove the dirs
holding your files to import. To remedy this, you have to configure the image so it will not delete the
imported files: *LDAP_REMOVE_CONFIG_AFTER_SETUP = false*

FIXME: What about copying the files in stead of mounting on start?

# Configuration
Configure the generated ldif file(s) by setting the following environment variables.
The following shows the defaults for the variables.

* FD_VERSION="1.3"
* FD_ADMIN_UID="fd-admin"
* FD_ADMIN_PASSWORD="fd-admin"
* FD_BASE_DN="dc=example,dc=org"
* FD_PASSWORD_MIN_LENGTH="16"
* FD_TIMEZONE="Europe/Berlin"
* FD_INCLUDE_RFC2307BIS="false"

The only supported version of FusionDirectory is 1.3.

The root of the FusionDirectory data will be ou=fd,FD_BASE_DN. FD_BASE_DN must exist on the LDAP server
in to which you import the ldif file.
