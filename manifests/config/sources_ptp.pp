# timekeeper::config::sources_ptp
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include timekeeper::config::sources_ptp
class timekeeper::config::sources_ptp {
  $timekeeper::sources_ptp.each | $name, $source_data| {
    timekeeper::component::source::ptp { $name:
      * => {} + $source_data
    }
  }
}
