# == Class: rt::config
#

class rt::config {

  File {
    owner   => 'root',
    mode    => '0640'
  }

  file {
    '/etc/request-tracker4/rt.conf':
      ensure  => file,
      content => template('rt/rt.conf.erb'),
      group   => 'root',
      notify => Exec['update-siteconfig'],
      ;
    '/etc/request-tracker4/RT_SiteConfig.d/51-dbconfig-common':
      ensure  => file,
      content => template('rt/dbconfig-common.erb'),
      group   => 'www-data',
      ;
  }

  exec {
    'update-siteconfig':
      command => '/usr/sbin/update-rt-siteconfig-4';
  }
}
