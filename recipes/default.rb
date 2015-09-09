#
# Cookbook Name:: docker-registry2-docker
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
docker_service 'default' do
  action [:create, :start]
end

docker_image 'distribution/registry' do
  tag node['docker-registry2']['version']
  action :pull
  notifies :restart, 'service[docker-registry]', :delayed
end

case node['docker-registry2']['init']
when 'systemd'
  execute 'systemctl daemon-reload' do
    command 'systemctl daemon-reload'
    action :nothing
  end
  template '/etc/systemd/system/docker-registry.service' do
    source 'systemd.erb'
    owner 'root'
    group 'root'
    mode '0655'
    variables(
      image: "distribution/registry:#{node['docker-registry2']['version']}"
    )
    notifies :run, 'execute[systemctl daemon-reload]', :immediately
  end
  service 'docker-registry' do
    action :enable
  end
end
