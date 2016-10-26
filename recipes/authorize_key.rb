bash 'authorize_key' do
  user 'vagrant'
  cwd '/var/tmp'
  code <<-EOH
  cat /mnt/share/.ssh/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
  EOH
end
