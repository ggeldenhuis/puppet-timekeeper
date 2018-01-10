# timekeeper::component::source::ptp
#
# A description of what this defined type does
#
# @summary A short summary of the purpose of this defined type.
#
# @example
#   timekeeper::component::source::ptp { 'namevar': }
define timekeeper::component::source::ptp(
  Integer                               $priority,
  Boolean                               $lowquality = false,               # Set by default in Web UI
  Boolean                               $enable_correction = true,         # Set by default in Web UI
  Boolean                               $allow_dropped_followup = true,    # Set by default in Web UI
  Boolean                               $enable_detect_asymmetry = false,  # Set by default in Web UI
  Integer                               $ptpdomain = 0,                    # Set by default in Web UI
  Integer[1,2]                          $ptpclientversion = 2,             # Set by default in Web UI
  Integer                               $unicast = 0,                      # Set by default in Web UI
  Boolean                               $enable_hwtstamps = true,          # Set by default in Web UI
  Boolean                               $monitoronly = false,              # Set by default in Web UI
  Boolean                               $allow_unreasonable_utc = false,   # Set by default in Web UI
  Optional[Float]                       $syncerrorthreshold = undef,
  Optional[Float]                       $cabledelay = undef,
  Optional[String]                      $iface = undef,
  Optional[Integer]                     $majortime = undef,
  Optional[Stdlib::Compat::Ip_address]  $ptpserver = undef,
  Optional[Integer]                     $ttl = undef,
  Optional[Integer]                     $iptos = undef,
  Optional[Boolean]                     $verify_interface_name = true,

) {
  include timekeeper

  if $iface and $verify_interface_name and !($iface in $facts['networking']['interfaces']) {
    fail("${iface} is not present on this machine.")
  }

  concat::fragment { "timekeeper::component::source::ptp::${priority}":
    target  => $timekeeper::config_file,
    content => epp('timekeeper/source.ptp.epp',
    {
      'priority'                => $priority,
      'lowquality'              => $lowquality,
      'enable_correction'       => $enable_correction,
      'allow_dropped_followup'  => $allow_dropped_followup,
      'enable_detect_asymmetry' => $enable_detect_asymmetry,
      'ptpdomain'               => $ptpdomain,
      'ptpclientversion'        => $ptpclientversion,
      'unicast'                 => $unicast,
      'enable_hwtstamps'        => $enable_hwtstamps,
      'monitoronly'             => $monitoronly,
      'allow_unreasonable_utc'  => $allow_unreasonable_utc,
      'syncerrorthreshold'      => $syncerrorthreshold,
      'cabledelay'              => $cabledelay,
      'iface'                   => $iface,
      'majortime'               => $majortime,
      'ptpserver'               => $ptpserver,
      'ttl'                     => $ttl,
      'iptos'                   => $iptos,
    }),
    order   => $priority + 100, # Ensure 10 is sorted after 9
  }
}
