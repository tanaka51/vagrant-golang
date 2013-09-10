#
# Cookbook Name:: emacs
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

filename = "emacs-24.3.tar.gz"
dirname = "emacs-24.3"

bash 'download emacs source' do
  user 'vagrant'
  group 'vagrant'
  cwd current_working_direcotry

  code <<-EOC
    wget http://core.ring.gr.jp/pub/GNU/emacs/#{filename}
  EOC
  not_if { File.exists?(current_working_direcotry + '/' + filename) }
end

%w{libXpm-dev libjpeg-dev libgif-dev libpng12-dev libtiff4-dev}.each do |pkg|
  package pkg
end

bash 'install emacs' do
  cwd current_working_direcotry

  code <<-EOC
    tar xzf #{filename}
    cd #{dirname}
    ./configure --x-libraries=no --with-x-toolkit=no
    make
    make install
  EOC
  not_if 'which emacs'
end
