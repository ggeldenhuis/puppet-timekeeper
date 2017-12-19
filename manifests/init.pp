# timekeeper
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include timekeeper

class timekeeper (
  String $package_ensure,
  Array[String] $package_name,
  String $config_file,
  String $service_name,
  Boolean $service_enable,
  Enum['running', 'stopped'] $service_ensure,
  Optional[Boolean]          $serventp = undef,
  Optional[Boolean]          $enable_ntp_followup = undef,
  Optional[String]           $serventp_iface = undef,
  Optional[Array]            $serventp_ntpkeyids = undef,
  Optional[Float]            $ntpsyncerrorthreshold = undef,
  Optional[Boolean]          $enable_webmanagement = undef,
  Optional[Integer]          $webmanagementport = 8080,
  Optional[Hash]             $sources_ntp = {},
  Optional[Hash]             $sources_ptp = {},
  Optional[Hash]             $sources_pps_bus = {},
  Optional[Hash]             $sources_pps_card = {},
  Optional[Hash]             $servers_ptp = {},
  Optional[Boolean]          $verify_interface_name = true,
){
  # Contains the classes to ensure correct behaviour for external ordering
  # dependencies against the class.
  contain timekeeper::install
  contain timekeeper::config
  contain timekeeper::service

  if $serventp_iface and $verify_interface_name and !($serventp_iface in $facts['networking']['interfaces']) {
    fail("${serventp_iface} is not present on this machine.")
  }

  # Setting class ordering and notification
  Class['timekeeper::install'] ->
  Class['timekeeper::config'] ~>
  Class['timekeeper::service']

}

# TODO
## Add concat as dependency
## Add stdlib as dependency
## Add ipaddress as datatype
## Majortime must be within range of the max priority value of the sources
## 
