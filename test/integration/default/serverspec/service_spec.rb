require 'serverspec'

set :backend, :exec

describe service('docker-registry') do
  it { should be_enabled }
end

describe docker_image('distribution/registry:2.1') do
  it { should exist }
end
