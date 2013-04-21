# Class: newrelic_php
#
# This module manages New Relic PHP application monitoring.
#
# Parameters:
#
#   [*license_key*] - New relic license key to use
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# The module works with sensible defaults:
#
# node default {
#   include newrelic_php
# }
class newrelic_php (
  $license_key = undef
) {
  class { 'newrelic_php::package': }

  class { 'newrelic_php::config':
    license_key => $license_key,
    require     => Class['newrelic_php::package'],
  }
}