# timekeeper::component::compliance::report
#
# A description of what this defined type does
#
# @summary A short summary of the purpose of this defined type.
#
# @example
#   timekeeper::component::compliance::report { 'namevar': }
define timekeeper::component::compliance::report(
  Integer       $priority,
  String        $report_title,
  Array[String] $clientset,
  Float         $warningthreshold,
  Float         $alerthreshold,
) {
  include timekeeper

  concat::fragment { "timekeeper::component::compliance::report::${priority}":
    target  => $timekeeper::config_file,
    content => epp('timekeeper/compliance.epp',
    {
      'priority'         => $priority,
      'report_title'     => $report_title,
      'clientset'        => $clientset,
      'warningthreshold' => $warningthreshold,
      'alerthreshold'    => $alerthreshold,
    }),
    order   => $priority + 150, # Ensure 10 is sorted after 9, and after other config
  }
}
