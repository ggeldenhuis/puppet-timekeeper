# timekeeper::config::sources_pps_bus
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include timekeeper::config::sources_pps_bus
class timekeeper::config::sources_pps_bus {
  $timekeeper::sources_pps_bus.each | $name, $source_data| {
    timekeeper::component::source::pps_bus { $name:
      * => {} + $source_data
    }
  }
}
