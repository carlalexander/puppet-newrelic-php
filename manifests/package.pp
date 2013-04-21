# Class: newrelic_php::package
#
# This module manages New Relic PHP application monitoring package installation
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
class newrelic::package {
  Exec {
    path => '/bin:/sbin:/usr/bin:/usr/sbin',
  }

  exec { 'newrelic-php-newrelic.gpg':
    command => 'wget -O- http://download.newrelic.com/548C16BF.gpg | apt-key add -',
    unless  => 'apt-key list | grep -c 548C16BF',
  }

  exec { 'newrelic-php-newrelic.list':
    command => "echo 'deb http://apt.newrelic.com/debian/ newrelic non-free' >> /etc/apt/sources.list.d/newrelic.list && apt-get update",
    creates => '/etc/apt/sources.list.d/newrelic.list',
    require => Exec['newrelic-php-newrelic.gpg']
  }

  package { 'newrelic-php5':
    ensure  => latest,
    require => Exec['newrelic-php-newrelic.list'],
  }
}