require 'spec_helper'
require 'json'

terraform_output = './spec/terraform.output.json'
tfvars = JSON.parse(File.read(terraform_output))

describe elb('lamp') do
  it { should exist }
  it { should have_listener(protocol: 'HTTP', port: 80, instance_protocol: 'HTTP', instance_port: 80) }
  it { should have_security_group('devopsdays_demo') }
  it { should have_subnet('devopsdays-demo-a') }
  it { should have_subnet('devopsdays-demo-b') }
  it { should have_subnet('devopsdays-demo-c') }
  it { should belong_to_vpc('devopsdays-demo') }
end

describe autoscaling_group("devopsdays_demo-#{tfvars["image_id"]["value"]}") do
  it { should exist }
  it { should have_elb('lamp') }
  it { should have_launch_configuration("devopsdays_demo-#{tfvars["image_id"]["value"]}") }
  its(:min_size) { should eq 2 }
  its(:desired_capacity) { should eq 2 }
end
