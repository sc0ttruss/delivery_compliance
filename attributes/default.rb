# the default location for files for our kitchen setup is in a local share
# ~/chef-kits/chef.  This is mounted to /mnt/share/chef on the target vm
# if you alreddy have these in an rpm repo, set source_files to false
# You can also replae file:// with https:// for remote repos.
default['delivery_compliance']['use_package_manager'] = false
default['delivery_compliance']['base_package_url'] = 'file:///mnt/share/chef'
default['delivery_compliance']['supermarket_server_fqdn'] = 'https://supermarket.myorg.chefdemo.net'
default['delivery-chef']['api_fqdn'] = 'chef.myorg.chefdemo.net'
default['delivery_compliance']['kitchen_shared_folder'] = '/mnt/share/chef'
# default['delivery-chef']['api_fqdn'] = node['fqdn']

# note the package "name" must match the name used by yum/rpm etc.
# get your package list here https://packages.chef.io/stable/el/7/
default['delivery_compliance']['organisation'] = 'myorg'
default['delivery_compliance']['packages']['compliance'] = 'chef-compliance-1.6.8-1.el7.x86_64.rpm'
