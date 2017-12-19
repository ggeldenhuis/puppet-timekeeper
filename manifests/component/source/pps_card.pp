# timekeeper::component::source::pps_card
#
# A description of what this defined type does
#
# @summary A short summary of the purpose of this defined type.
#
# @example
#   timekeeper::component::source::pps_card { 'namevar': }
define timekeeper::component::source::pps_card(
#  Boolean              $tkpps = true, # This is required to have this source
#                                        type, so no point really.
  Integer           $priority,
  Boolean           $ppsout = false,
  Boolean           $monitoronly = false,
  Optional[Float]   $syncerrorthreshold = undef,
  Optional[Float]   $cabledelay = undef,
  Optional[Integer] $holdover_limit = undef,
  Optional[String]  $iface = undef,
  Optional[Integer] $pin = undef,
  Optional[Integer] $majortime = undef,
  Optional[Boolean] $verify_interface_name = true,
) {

  include timekeeper

  if $iface and $verify_interface_name and !($iface in $facts['networking']['interfaces']) {
    fail("${iface} is not present on this machine.")
  }

  concat::fragment { "timekeeper::component::source::pps_card::${priority}":
    target  => $timekeeper::config_file,
    content => epp('timekeeper/source.pps_card.epp',
    {
      'tkpps'              => true,
      'priority'           => $priority,
      'ppsout'             => $ppsout,
      'monitoronly'        => $monitoronly,
      'syncerrorthreshold' => $syncerrorthreshold,
      'cabledelay'         => $cabledelay,
      'holdover_limit'     => $holdover_limit,
      'iface'              => $iface,
      'pin'                => $pin,
      'majortime'          => $majortime,
    }),
    order   => $priority + 100, # Ensure 10 is sorted after 9
  }
}

#SOURCE13 () {
#  PPSOUT='0';
#  TKPPS='1';
#  MONITORONLY='0';
#}

#SOURCE14 () {
#  SYNCERRORTHRESHOLD='0.009';
#  CABLEDELAY='0.008';
#  HOLDOVER_LIMIT='5';
#  IFACE='ens33';
#  PIN='2';
#  PPSOUT='1';
#  MAJORTIME='9';
#  TKPPS='1'; # Must always be 1.
#  MONITORONLY='1';
#}
