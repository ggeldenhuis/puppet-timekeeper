# timekeeper::config
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include timekeeper::config
class timekeeper::config {
  concat { $timekeeper::config_file: }

  include timekeeper::config::global
  include timekeeper::config::sources_ntp
  include timekeeper::config::sources_ptp
  include timekeeper::config::sources_pps_bus
  include timekeeper::config::sources_pps_card
  include timekeeper::config::servers_ptp
  include timekeeper::config::compliance_reports
}
