# timekeeper::config::sources_ntp
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include timekeeper::config::sources_ntp
class timekeeper::config::sources_ntp {
  $timekeeper::sources_ntp.each | $name, $source_data| {
    timekeeper::component::source::ntp { $name:
      * => {} + $source_data
    }
  }
}
