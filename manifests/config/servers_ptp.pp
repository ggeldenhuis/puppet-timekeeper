# timekeeper::config::servers_ptp
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include timekeeper::config::servers_ptp
class timekeeper::config::servers_ptp {
  $timekeeper::servers_ptp.each | $name, $server_data| {
    timekeeper::component::server::ptp { $name:
      * => {} + $server_data
    }
  }
}
