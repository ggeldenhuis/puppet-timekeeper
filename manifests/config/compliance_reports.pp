# timekeeper::config::compliance_reports
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include timekeeper::config::compliance_reports
class timekeeper::config::compliance_reports {
  $timekeeper::compliance_reports.each | $name, $compliance_data| {
    timekeeper::component::compliance::report { $name:
      * => {} + $compliance_data
    }
  }
}
