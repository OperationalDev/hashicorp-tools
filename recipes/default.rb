#
# Cookbook:: hashicorp-tools
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

directory "#{ENV['HOME']}/bin"

node['hashicorp-tools']['package'].each do |k,v|
  remote_file "#{ENV['HOME']}/Downloads/#{k}.gz" do
    source "#{v['url']}"
    notifies :run, "execute[unzip #{k}]", :immediately
  end

  execute "unzip #{k}" do
    command "unzip #{ENV['HOME']}/Downloads/#{k}.gz -d #{ENV['HOME']}/bin/;chmod +x #{ENV['HOME']}/bin/#{k}"
    action :nothing
  end
end
