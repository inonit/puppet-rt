# == Class: rt
#
# Class basically configure database connection. The rest is
# configured manually with Debian packages.
#
# === Variables
#
# Here you should define a list of variables that this module would require.
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
# === Authors
#
# Lars Bahner <lars.bahner@gmail.com>
#
# === Copyright
#
# Copyright © 2017 Inonit AS

class rt (

  $database_type      = $rt::params::database_type
  $database_host      = $rt::params::database_host
  $database_port      = $rt::params::database_port
  $database_user      = $rt::params::database_user
  $database_password  = $rt::params::database_password

) inherits rt::params {

  File {
    notify => Exec['update-siteconfig'],
    owner   => 'root',
    mode    => '0640'
  }

  file {
    '/etc/request-tracker4/RT_SiteConfig.d/51-dbconfig-common':
      ensure  => file,
      content => template('dbconfig-common'),
      group   => 'www-data',
      ;
  }

  exec {
    'update-siteconfig':
      command => '/usr/sbin/update-rt-siteconfig-4';
  }
}
