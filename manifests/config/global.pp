# timekeeper::config::global
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include timekeeper::config::global
class timekeeper::config::global {
  concat::fragment { 'timekeeper::config::global::about':
    target  => $timekeeper::config_file,
    content => ("# This file is managed by puppet.\n\n"),
    order   => '01',
  }

  concat::fragment { 'timekeeper::config::global' :
    target  => $timekeeper::config_file,
    content => epp('timekeeper/timekeeper.conf.epp'),
    order   => '02',
  }
}
