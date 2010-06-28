#
# Cookbook Name:: rabbitmq
# Recipe:: default
#
# Copyright 2009, Benjamin Black
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

if node[:instance_role] == "solo" || node[:name] =~ /rabbit/
  
  package "sys-apps/ey-monit-scripts" do
    action :install
    version "0.17"
  end

  package "net-misc/rabbitmq-server" do
    action :install
  end

  # service "rabbitmq-server" do
  #   supports :status => true, :restart => true, :reload => true
  #   action [ :enable, :start ]
  # end
  
  directory "/etc/rabbitmq" do
    owner "root"
    group "root"
    mode 0755
    recursive true
  end  

  template "/etc/rabbitmq/rabbitmq.config" do
    source "rabbitmq.config.erb"
    owner "root"
    group "root"
    mode 0644
    # notifies :restart, resources(:service => "rabbitmq-server")
  end
end
