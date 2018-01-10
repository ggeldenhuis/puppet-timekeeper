# timekeeper::component::server::ptp
#
# A description of what this defined type does
#
# @summary A short summary of the purpose of this defined type.
#
# @example
#   timekeeper::component::server::ptp { 'namevar': }
define timekeeper::component::server::ptp(
  Integer           $priority,
  Integer           $ptpserverversion = 2, # Set by default in Web UI
  Integer           $ptpserverdomain = 0,  # Set by default in Web UI
  Integer           $ptppriority1 = 128,   # Set by default in Web UI
  Integer           $ptppriority2 = 128,   # Set by default in Web UI
  Boolean           $unicast = false,      # Set by default in Web UI
  Optional[Float]   $syncerrorthreshold = undef,
  Optional[Integer] $ptpserversyncrate = undef,
  Optional[Integer] $ptpserverttl = undef,
  Optional[String]  $iface = undef,
  Optional[Boolean] $verify_interface_name = true,
  Optional[Integer] $iptos = undef,
  Optional[Integer] $minclockaccuracy = undef,
) {
  include timekeeper

  if $iface and $verify_interface_name and !($iface in $facts['networking']['interfaces']) {
    fail("${iface} is not present on this machine.")
  }

  concat::fragment { "timekeeper::component::server::ntp::${priority}":
    target  => $timekeeper::config_file,
    content => epp('timekeeper/server.ptp.epp',
    {
      'priority'           => $priority,
      'ptpserverversion'   => $ptpserverversion,
      'ptpserverdomain'    => $ptpserverdomain,
      'ptppriority1'       => $ptppriority1,
      'ptppriority2'       => $ptppriority2,
      'unicast'            => $unicast,
      'syncerrorthreshold' => $syncerrorthreshold,
      'ptpserversyncrate'  => $ptpserversyncrate,
      'ptpserverttl'       => $ptpserverttl,
      'iface'              => $iface,
      'iptos'              => $iptos,
      'minclockaccuracy'   => $minclockaccuracy,
    }),
    order   => $priority + 200, # Ensure 10 is sorted after 9, and after other config
  }
}
