# timekeeper::component::source::ntp
#
# A description of what this defined type does
#
# @summary A short summary of the purpose of this defined type.
#
# @example
#   timekeeper::component::source::ntp { 'namevar': }
define timekeeper::component::source::ntp(
  String               $ntpserver,
  Integer              $priority,
  Boolean              $lowquality = false,              # Set by default in Web UI
  Boolean              $enable_reresolve = false,        # Set by default in Web UI
  Boolean              $enable_detect_asymmetry = false, # Set by default in Web UI
  Boolean              $enable_hwtstamps = true,         # Set by default in Web UI
  Boolean              $monitoronly = false,             # Set by default in Web UI
  Optional[Float]      $myfloat = undef,
  Optional[Float]      $syncerrorthreshold = undef,
  Optional[Float]      $cabledelay = undef,
  Optional[Float]      $ntpsyncrate = undef,
  Optional[String]     $ntpkeyid = undef,
  Optional[Integer[1]] $majortime = undef,
) {
  include timekeeper
  concat::fragment { "timekeeper::component::source::ntp::${priority}":
    target  => $timekeeper::config_file,
    content => epp('timekeeper/source.ntp.epp',
    {
      'ntpserver'               => $ntpserver,
      'priority'                => $priority,
      'lowquality'              => $lowquality,
      'enable_reresolve'        => $enable_reresolve,
      'enable_detect_asymmetry' => $enable_detect_asymmetry,
      'enable_hwtstamps'        => $enable_hwtstamps,
      'monitoronly'             => $monitoronly,
      'syncerrorthreshold'      => $syncerrorthreshold,
      'cabledelay'              => $cabledelay,
      'ntpsyncrate'             => $ntpsyncrate,
      'ntpkeyid'                => $ntpkeyid,
      'majortime'               => $majortime,
    }),
    order   => $priority + 100, # Ensure 10 is sorted after 9
  }
}
