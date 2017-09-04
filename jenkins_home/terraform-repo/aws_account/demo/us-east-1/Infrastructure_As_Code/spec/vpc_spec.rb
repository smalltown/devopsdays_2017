require 'spec_helper'

describe vpc('devopsdays-demo') do
  it { should exist }
end

describe route_table('devopsdays-demo-default') do
  it { should exist }
  it { should have_route('172.20.0.0/16').target(gateway: 'local') }
end

describe security_group('devopsdays-demo') do
  its(:outbound) { should be_opened }
  its(:inbound) { should be_opened.for('172.20.0.0/16') }
end

describe internet_gateway('devopsdays-demo-igw') do
  it { should exist }
end

describe subnet('devopsdays-demo-a') do
  it { should exist }
end

describe subnet('devopsdays-demo-b') do
  it { should exist }
end

describe subnet('devopsdays-demo-c') do
  it { should exist }
end
