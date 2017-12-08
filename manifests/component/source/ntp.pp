# timekeeper::component::source::ntp
#
# A description of what this defined type does
#
# @summary A short summary of the purpose of this defined type.
#
# @example
#   timekeeper::component::source::ntp { 'namevar': }
define timekeeper::component::source::ntp(
  String            $ntpserver,
  Integer           $priority,
  Enum['0','1']     $lowquality = '0',              # Set by default in Web UI
  Enum['0','1']     $enable_reresolve = '0',        # Set by default in Web UI
  Enum['0','1']     $enable_detect_asymmetry = '0', # Set by default in Web UI
  Enum['0','1']     $enable_hwstamps = '1',         # Set by default in Web UI
  Enum['0','1']     $monitoronly = '0',             # Set by default in Web UI
  Optional[Float]   $myfloat = undef,
  Optional[Float]   $syncerrorthreshold = undef,
  Optional[Float]   $cabledelay = undef,
  Optional[Float]   $ntpsyncrate = undef,
  Optional[String]  $ntpkeyid = undef,
  Optional[Integer] $majortime = undef,
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
      'enable_hwstamps'         => $enable_hwstamps,
      'monitoronly'             => $monitoronly,
      'syncerrorthreshold'      => $syncerrorthreshold,
      'cabledelay'              => $cabledelay,
      'ntpsyncrate'             => $ntpsyncrate,
      'ntpkeyid'                => $ntpkeyid,
      'majortime'               => $majortime,
    }),
    order   => $priority,
  }
}
