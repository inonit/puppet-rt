# == Class: rt
#
# Class basically configure database connection. The rest is
# configured manually with Debian packages.
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*rt_server*]
#   URL for the actual server. This is used to build URLs
#     You should probably have this SSL'ed, as
#     https://rt.example.com
#
#     May also be set as environment variable RTSERVER  
#
#   Default: http://localhost/rt
#
# [*rt_user*]
#   User to use for login for rt-client to log into
#   via web ( so REMOTE_USER)
#
#     May also be set as environment variable RTUSER
#
#   Default: root
#
# [*rt_passwd*]
#     Password to use for web login for
#
#     May also be set as environment variable RTPASSWD
#
# [*database_type*]
#   Specify type of database:
#     - mysql
#     - pgsql
#     - sqlite3
#
#   Default: pgsql
#
#
# [*database_host*]
#     database host to connect to
#
#
# [*database_port*]
#     port on database_host to connect to
#
#   Default: 5234
#
#
# [*database_user*]
#     username for conneting to database
#
#   default: rt4
#
#
# [*database_password*]
#   secret password to use for db connetion
#   remember to use eyaml for encryption of secret
#
# [*email_domain*]
#   Fuzzy var. Probably hostname, probably email domain
#   Used to generate email domains, when not declared
#
#   Default: localhost
#
# === Authors
#
# Lars Bahner <lars.bahner@gmail.com>
#
# === Copyright
#
# Copyright © 2017 Inonit AS

class rt {

##  $database_host      = $rt::params::database_host,
##  $database_password  = $rt::params::database_password,
##  $database_port      = $rt::params::database_port,
##  $database_type      = $rt::params::database_type,
##  $database_user      = $rt::params::database_user,
##  $email_domain       = $rt::params::email_domain,
##  $rt_passwd          = $rt::params::rt_passwd,
##  $rt_server          = $rt::params::rt_server,
##  $rt_user            = $rt::params::rt_user,

  include rt::config
  include rt::queues

  Class['rt::config'] -> Class['rt::queues']

}
