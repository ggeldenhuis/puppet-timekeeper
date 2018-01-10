# timekeeper::install
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include timekeeper::install
class timekeeper::install {
  package { $timekeeper::package_name:
    ensure => $timekeeper::package_ensure,
  }

  if $timekeeper::logdir != undef {
    file { $timekeeper::logdir:
      ensure  => directory,
      require => Package[$timekeeper::package_name],
    }
  }

  file { $timekeeper::licence_file:
    ensure  => file,
    content => $timekeeper::licence_content,
    source  => $timekeeper::licence_source,
    require => Package[$timekeeper::package_name],
  }
}

## Consider implementing check on licence with warning if your license does not
##    support the necessary functionality.

## Investigate whether you can split out various licenses in a file and
##   implement as seperate licensing functionality. This should give more
##   flexibility to manage licensing intelligently.
