require 'chefspec'
require 'chefspec/berkshelf'

describe 'docker-registry2-docker::default' do
  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }

  it 'enables service[docker-registry]' do
    expect(chef_run).to enable_service('docker-registry')
  end
end
