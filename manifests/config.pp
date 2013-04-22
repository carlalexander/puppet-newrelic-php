# Class: newrelic_php::config
#
# This module manages New Relic PHP application monitoring module configuration.
#
# Parameters:
#
# There are no default parameters for this class.
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# This class file is not called directly
class newrelic_php::config (
  $license_key = undef
) {
  Exec {
    path => '/bin:/sbin:/usr/bin:/usr/sbin',
  }
  File {
    owner => 'root',
    group => 'root',
    mode  => '0644'
  }

  if ($license_key == undef) {
    fail('You must specify a license key')
  }

  exec { 'newrelic-install':
    command     => 'newrelic-install install',
    creates     => "/etc/newrelic/newrelic.cfg",
    environment => ['NR_INSTALL_SILENT=yes', "NR_INSTALL_KEY=${license_key}"],
  }

  file { '/etc/newrelic/newrelic.cfg':
    ensure  => absent,
    require => Exec['newrelic-install']
  }

  file { '/etc/php5/cli/conf.d/newrelic.ini':
    ensure  => file,
    content => template('newrelic_php/newrelic.ini.erb'),
    require => Exec['newrelic-install']
  }

  file { '/var/log/newrelic/newrelic-daemon.log':
    owner => 'www-data',
    group => 'www-data'
  }
}