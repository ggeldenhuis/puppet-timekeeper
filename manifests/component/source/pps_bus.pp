# timekeeper::component::source::pps_bus
#
# A description of what this defined type does
#
# @summary A short summary of the purpose of this defined type.
#
# @example
#   timekeeper::component::source::pps_bus { 'namevar': }
define timekeeper::component::source::pps_bus(
  Integer                        $priority,
  String                         $ppsdev,
  Boolean                        $lowquality = false,   # Set by default in Web UI
  Boolean                        $disable_gps = false,  # Set by default in Web UI
  Boolean                        $tkgps = false,        # Set by default in Web UI
  Boolean                        $tkjs = false,         # Set by default in Web UI
  Boolean                        $hoptroff = false,     # Set by default in Web UI
  Boolean                        $ublox = false,        # Set by default in Web UI
  Boolean                        $gnss_gps = false,     # Set by default in Web UI
  Boolean                        $gnss_galileo = false, # Set by default in Web UI
  Boolean                        $gnss_beidou = false,  # Set by default in Web UI
  Boolean                        $gnss_glonass = false, # Set by default in Web UI
  Boolean                        $monitoronly = false,  # Set by default in Web UI
  Optional[Float]                $syncerrorthreshold = undef,
  Optional[Float]                $cabledelay = undef,
  Optional[String]               $ppssource = undef,
  Optional[Timekeeper::Baudrate] $baud = undef,
  Optional[Integer]              $holdover_limit = undef,
  Optional[String]               $iface = undef,
  Optional[Integer]              $majortime = undef,
  Optional[Boolean]              $verify_interface_name = true,
) {
  include timekeeper

  if $iface and $verify_interface_name and !($iface in $facts['networking']['interfaces']) {
    fail("${iface} is not present on this machine.")
  }

  concat::fragment { "timekeeper::component::source::pps_bus::${priority}":
    target  => $timekeeper::config_file,
    content => epp('timekeeper/source.pps_bus.epp',
    {
      'priority'           => $priority,
      'ppsdev'             => $ppsdev,
      'lowquality'         => $lowquality,
      'disable_gps'        => $disable_gps,
      'tkgps'              => $tkgps,
      'tkjs'               => $tkjs,
      'hoptroff'           => $hoptroff,
      'ublox'              => $ublox,
      'gnss_gps'           => $gnss_gps,
      'gnss_galileo'       => $gnss_galileo,
      'gnss_beidou'        => $gnss_beidou,
      'gnss_glonass'       => $gnss_glonass,
      'monitoronly'        => $monitoronly,
      'syncerrorthreshold' => $syncerrorthreshold,
      'cabledelay'         => $cabledelay,
      'ppssource'          => $ppssource,
      'baud'               => $baud,
      'holdover_limit'     => $holdover_limit,
      'iface'              => $iface,
      'majortime'          => $majortime,
    }),
    order   => $priority + 100, # Ensure 10 is sorted after 9
  }
}
