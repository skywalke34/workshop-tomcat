name 'tomcat'
maintainer 'Tracy Walker'
maintainer_email 'tracyfwalker@gmail.com'
license 'All Rights Reserved'
description 'Installs/Configures tomcat'
long_description 'Installs/Configures tomcat'
version '0.2.0'
chef_version '>= 12.14' if respond_to?(:chef_version)

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
# issues_url 'https://github.com/<insert_org_here>/tomcat/issues'

# The `source_url` points to the development repository for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
# source_url 'https://github.com/<insert_org_here>/tomcat'

# depends 'ark', '~> 0.9.0'
# depends 'java', '~> 1.31.0'
# depends 'apt', '~> 2.4.0'
recipe 'tomcat', 'Installs tomcat'
recipe 'tomcat::install_tomcat', 'Install and configure tomcat'

supports 'centos', '>= 6.4'
supports 'redhat', '>= 6.4'
