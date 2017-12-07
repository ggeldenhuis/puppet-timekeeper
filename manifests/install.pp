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
}
