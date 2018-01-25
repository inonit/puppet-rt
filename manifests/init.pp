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

class rt (
  $database_host,
  $database_password,
  $database_port,
  $database_type,
  $database_user,
  $rt_passwd,
  $rt_server,
  $rt_user,
  $queues,
) {

  File {
    owner   => 'root',
    mode    => '0640'
  }

  file {
    '/etc/request-tracker4/rt.conf':
      ensure  => file,
      content => template('rt/rt.conf.erb'),
      group   => 'root',
      notify  => Exec['update-siteconfig'],
      ;
    '/etc/request-tracker4/RT_SiteConfig.d/51-dbconfig-common':
      ensure  => file,
      content => template('rt/dbconfig-common.erb'),
      group   => 'www-data',
      ;
  }

  exec {
    'update-siteconfig':
      command     => '/usr/sbin/update-rt-siteconfig-4',
      subscribe   => File['/etc/request-tracker4/rt.conf'],
      refreshonly => true,
      ;
  }

  # create_resources('rt::queue', $queues)

}
