# timekeeper::config::sources_pps_card
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include timekeeper::config::sources_pps_card
class timekeeper::config::sources_pps_card {
  $timekeeper::sources_pps_card.each | $name, $source_data| {
    timekeeper::component::source::pps_card { $name:
      * => {} + $source_data
    }
  }
}
