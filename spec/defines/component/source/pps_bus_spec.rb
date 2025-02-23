require 'spec_helper'

describe 'timekeeper::component::source::pps_bus' do
  let(:title) { 'namevar' }
  let(:params) do
    {}
  end

  on_supported_os(facterversion: '2.4').each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }
    end
  end
end
