# timekeeper
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include timekeeper

#SERVENTP - 0 or 1. A value of 1 will cause TimeKeeper to respond to NTP requests on all interfaces.
#ENABLE_NTP_FOLLOWUP - 0 or 1. A value of 1 will cause the TimeKeeper NTP server (if enabled) to also respond to NTP requests with a followup NTP packet. On TimeKeeper clients, this allows processing of the followup to improve timing accuracy.
#SERVENTP_IFACE - A string naming the network interface that TimeKeeper should respond to NTP queries on. If TimeKeeper receives a request via that named interface, it will respond, but only on that interface. If the value of this setting is empty or unspecified, TimeKeeper listens and responds on all interfaces.
#SERVENTP_NTPKEYIDS - A comma separated list of MD5 key IDs (read from /etc/ntp/keys) to use for authenticating client requests
#NTPSYNCERRORTHRESHOLD - A numeric field. If management queries and SNMP traps or email alerts are enabled, any NTP clients reporting a sync exceeding this threshold will cause an alarm to be triggered. (e.g., NTPSYNCERRORTHRESHOLD=0.000010 sends alarms if any client sync quality exceeds +-10us)

class timekeeper (
  String $package_ensure,
  Array[String] $package_name,
  String $config_file,
  String $service_name,
  Boolean $service_enable,
  Enum['running', 'stopped'] $service_ensure,
  Optional[Enum['0','1']] $serventp = undef,
  Optional[Enum['0,','1']] $enable_ntp_followup = undef,
  Optional[String] $serventp_iface = undef,
  Optional[Array] $serventp_ntpkeyids = undef,
  Optional[Float] $ntpsyncerrorthreshold = undef,
  Optional[Enum['0,','1']] $enable_webmanagement = undef,
  Optional[Integer] $webmanagementport = 8080,
  Optional[Hash] $sources_ntp = {},
  Optional[Hash] $sources_ptp = {},
  Optional[Hash] $sources_pps = {},
  Optional[Hash] $sources_pps_card = {},
  Optional[Hash] $servers_ptp = {},
){
  # Contains the classes to ensure correct behaviour for external ordering
  # dependencies against the class.
  contain timekeeper::install
  contain timekeeper::config
  contain timekeeper::service

  # Setting class ordering and notification
  Class['timekeeper::install'] ->
  Class['timekeeper::config'] ~>
  Class['timekeeper::service']

}

# TODO
## Add concat as dependency
## Add stdlib as dependency
## Add ipaddress as datatype
