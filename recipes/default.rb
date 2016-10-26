#
# Cookbook Name:: delivery_compliance
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# install the chef package(s)


node['delivery_compliance']['packages'].each do |name, versioned_name|
  unless node['delivery_compliance']['use_package_manager']
    remote_file "/var/tmp/#{versioned_name}" do
      source "#{node['delivery_compliance']['base_package_url']}/#{versioned_name}"
    end
  end
  package name do
    unless node['delivery_compliance']['use_package_manager']
      source "/var/tmp/#{versioned_name}"
    end
    action :install
  end
end # Loop

# start all the services

# start all the services

bash 'start the compliance services' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
  chef-compliance-ctl reconfigure --accept-license
  EOH
end

# add a user to compliance, called admin
# with password chef

bash 'add a user admin to compliance' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
  chef-compliance-ctl user-create admin chef
  EOH
end

# add a user to compliance, called chef
# with password chef

bash 'add a user chef to compliance' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
  chef-compliance-ctl user-create chef chef
  EOH
end

# connect compliance server to chef server

bash 'add a user chef to compliance' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
  chef-compliance-ctl connect chef-server  --non-interactive true --chef-app-id 'compliance_server'--auth-id 'CHef Server' --insecure true --compliance-url 'https://compliance.myorg.chefdemo.net' > /etc/chef-compliance/compliancechefintegration.txt
  EOH
end

# place a copy of the command to run on the chef server
# in the common share

remote_file '/mnt/share/chef/compliancechefintegration.txt' do
  source 'file:///etc/chef-compliance/compliancechefintegration.txt'
  owner 'root'
  group 'root'
  mode 00755
  only_if { ::File.directory?("#{node['delivery_compliance']['kitchen_shared_folder']}") }
  # checksum 'abc123'
end

# start all the services

bash 'start the compliance services' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
  chef-compliance-ctl reconfigure --accept-license
  EOH
end


# restart theh Chef Compliance core service

bash 'restart the compliance core service' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
  chef-compliance-ctl restart core
  EOH
end
