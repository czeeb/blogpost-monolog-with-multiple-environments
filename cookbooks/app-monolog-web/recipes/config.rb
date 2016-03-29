#
# Cookbook Name:: app-monolog-web
# Recipe:: config
#
# Copyright 2016, Chris Zeeb <chris.zeeb@gmail.com>
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

template 'nginx-monolog' do
  source 'nginx-monolog.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  path '/etc/nginx/sites-available/monolog'
end

package 'git'

include_recipe 'php-wrapper'
include_recipe 'composer'
include_recipe 'nginx-wrapper'

nginx_site 'monolog' do
  enable true
end

directory node['app-monolog-web']['log_dir'] do
  owner node['nginx']['user']
  group node['nginx']['group']
  mode  '0755'
  action :create
end

template 'logger.yml' do
  source 'logger.yml.erb'
  owner 'vagrant'
  group 'vagrant'
  mode '0644'
  path node['app-monolog-web']['conf_dir'] + '/logger.yml'
  action :create
end