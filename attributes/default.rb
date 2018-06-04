# O.S. related settings
default['tomcat']['user'] = 'tomcat'
default['tomcat']['group'] = 'tomcat'

# Tomcat related settings
## installation
default['tomcat']['version'] = '8.5.31'
default['tomcat']['tomcat_home'] = '/opt/tomcat'
default['tomcat']['set_etc_environment'] = false
default['tomcat']['download_server'] = 'http://apache.mirrors.ionfish.org'

## configuration
default['tomcat']['shutdown_port'] = '8005'
default['tomcat']['port'] = '8080'
default['tomcat']['max_threads'] = '100'
default['tomcat']['min_spare_threads'] = '10'
default['tomcat']['java_opts'] = '-d64 -server -Djava.awt.headless=true'
default['tomcat']['catalina_opts'] = ''

# SSL Connector
default['tomcat']['ssl_enabled'] = false
default['tomcat']['ssl_port'] = ''
default['tomcat']['keystore_file'] = ''
default['tomcat']['keystore_pass'] = ''
default['tomcat']['keystore_type'] = ''

# Lockout Realm
default['tomcat']['lockout_realm_enabled'] = true
default['tomcat']['lockout_realm_classname'] = 'org.apache.catalina.realm.UserDatabaseRealm'
default['tomcat']['lockout_realm_resourcename'] = 'UserDatabase'
default['tomcat']['lockout_realm_datasourcename'] = ''
default['tomcat']['lockout_realm_usertable'] = ''
default['tomcat']['lockout_realm_usernamecol'] = ''
default['tomcat']['lockout_realm_usercredcol'] = ''
default['tomcat']['lockout_realm_userroletable'] = ''
default['tomcat']['lockout_realm_roleNameCol'] = ''
default['tomcat']['lockout_realm_localdatasource'] = ''
default['tomcat']['lockout_realm_digest'] = ''

# SSO
default['tomcat']['SSO_enabled'] = false

# Cluster
default['tomcat']['cluster_class'] = '' # Must be set to non-blank for Farm Deployment to work

# Farm Deployment
default['tomcat']['farm_deploy_enabled'] = false
default['tomcat']['farm_deploy_classname'] = ''
default['tomcat']['farm_deploy_tempdir'] = ''
default['tomcat']['farm_deploy_deploydir'] = ''
default['tomcat']['farm_deploy_watchdir'] = ''
default['tomcat']['farm_deploy_watchenabled'] = ''
