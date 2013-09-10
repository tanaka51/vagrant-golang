#
# Cookbook Name:: golang
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

current_working_direcotry = '/home/vagrant/src'

directory current_working_direcotry do
  user 'vagrant'
  group 'vagrant'
  action :create
end

filename = "go1.1.2.linux-amd64.tar.gz"

bash 'download golang binary' do
  user 'vagrant'
  group 'vagrant'
  cwd current_working_direcotry

  code <<-EOC
    wget http://go.googlecode.com/files/#{filename}
  EOC
  not_if { File.exists?(current_working_direcotry + '/' + filename) }
end

bash 'install golang' do
  cwd current_working_direcotry

  code <<-EOC
    sudo rm -rf /usr/local/go
    tar -C /usr/local -xzf #{filename}
    sudo sh -c 'echo "export PATH=$PATH:/usr/local/go/bin" >> /etc/profile'
  EOC
  not_if 'which go'
end
