# timekeeper
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include timekeeper

class timekeeper (
  String                               $package_ensure,
  Array[String]                        $package_name,
  String                               $config_file,
  String                               $service_name,
  Boolean                              $service_enable,
  Enum['running', 'stopped']           $service_ensure,
  Optional[Stdlib::Absolutepath]       $licence_file,
  Optional[String]                     $licence_content = undef,
  Optional[String]                     $licence_source = undef,
# Time serving options
  Optional[Boolean]                    $serventp = undef,
  Optional[Boolean]                    $enable_ntp_followup = undef,
  Optional[String]                     $serventp_iface = undef,
  Optional[Array]                      $serventp_ntpkeyids = undef,
  Optional[Float]                      $ntpsyncerrorthreshold = undef,
  Optional[Boolean]                    $servetime = undef,
  Optional[Float]                      $initial_serve_accuracy = undef,
# Management/Monitoring Settings
  Optional[Boolean]                    $enable_map = undef,
  Optional[Boolean]                    $enable_managment_query = undef,
  Optional[Boolean]                    $enable_managment_response = undef,
  Optional[Integer]                    $management_query_interval = undef,
  Optional[Integer]                    $sync_error_threshold_throttle = undef,
  Optional[Stdlib::Compat::Ip_address] $web_management_ip = undef,
  Optional[Boolean]                    $enable_webmanagement = undef,
  Optional[Integer]                    $webmanagementport = 8080,
# General Timekeeper Settings
  Optional[Boolean]                    $enable_satellitedata = undef,
  Optional[Boolean]                    $enable_tkgps_detail = undef,
  Optional[Array[String]]              $avoid_ifaces = undef,
  Optional[Boolean]                    $set_time_on_startup = undef,
  Optional[Boolean]                    $allow_set_time_after_startup = undef,
  Optional[Boolean]                    $step_on_leapsecond = undef,
  Optional[Boolean]                    $sourcecheck = undef,
  Optional[Integer]                    $sourcecheck_autovalidate_threshold = undef,
  Optional[Integer]                    $cpu = undef,
  Optional[Boolean]                    $enable_sfc_uuid_filter = undef,
  Optional[Stdlib::Absolutepath]       $logdir = undef,
  Optional[Boolean]                    $donotrotatelogsonstartup = undef,
  Optional[Integer]                    $iptos = undef,
  Optional[Boolean]                    $enable_compliance = undef,
  Optional[Boolean]                    $enable_hwstamps = undef,
# External alerting/notification
  Optional[Array[Stdlib::Compat::Ip_address]] $snmptraphost = undef,
  Optional[String]                     $snmptrapid = undef,
  Optional[String]                     $snmptrapusername = undef,
  Optional[String]                     $snmptrappassphrase = undef,
  Optional[String]                     $snmptrapoid = undef,
  Optional[Array[String]]              $emailnotification = undef,
  Optional[Integer]                    $emailnotification_throttle = undef,
# Verbose logging options
  Optional[Boolean]                    $verbose_tcpdump = undef,
  Optional[Boolean]                    $verbose_ptp = undef,
  Optional[Boolean]                    $verbose_ntp = undef,
  Optional[Boolean]                    $verbose_server = undef,
  Optional[Boolean]                    $verbose_sourcecheck = undef,
  Optional[Boolean]                    $verbose_socket = undef,
  Optional[Boolean]                    $verbose_timestamps = undef,
  Optional[Boolean]                    $verbose_nmea = undef,
  Optional[Boolean]                    $verbose_pps = undef,
  Optional[Boolean]                    $verbose_management = undef,
  Optional[Boolean]                    $verbose_map = undef,
  Optional[Boolean]                    $verbose_bmc = undef,
  Optional[Boolean]                    $verbose_compliance = undef,
# Module specific
  Optional[Hash]                       $sources_ntp = {},
  Optional[Hash]                       $sources_ptp = {},
  Optional[Hash]                       $sources_pps_bus = {},
  Optional[Hash]                       $sources_pps_card = {},
  Optional[Hash]                       $servers_ptp = {},
  Optional[Boolean]                    $verify_interface_name = true,
  Optional[Hash]                       $compliance_reports = {},
){
  # Contains the classes to ensure correct behaviour for external ordering
  # dependencies against the class.
  contain timekeeper::install
  contain timekeeper::config
  contain timekeeper::service

# TODO: if set in UI to ALL then this setting is not set in the config file
# provide the option to the user to set ALL which should result in not setting
# the value in the config file.
  if $serventp_iface and $verify_interface_name and !($serventp_iface in $facts['networking']['interfaces']) {
    fail("${serventp_iface} is not present on this machine.")
  }

# Validate interface names
  if $avoid_ifaces and $verify_interface_name {
    $avoid_ifaces.each | $iface | {
      if !($iface in $facts['networking']['interfaces']) {
        fail("${iface} from avoid_ifaces is not present on this machine.")
      }
    }
  }

# Validate CPU number against actual number of CPUs
  if $cpu {
    if $cpu > $facts['processors']['physicalcount'] {
      fail("CPU(Bind TimeKeeper to CPU) specified a higher value(${cpu}) than is available on this machine.")
    }
  }

# License parameter validation
  if !$licence_content and !$licence_source {
    fail('Must provide license_content or license_source.')
    }
  if $licence_content and $licence_source {
    fail('Must provide only license_content or license_source')
  }


  # Setting class ordering and notification
  Class['timekeeper::install']
  -> Class['timekeeper::config']
  ~> Class['timekeeper::service']

}

# TODO

## Write documentation

## Write rspec tests
