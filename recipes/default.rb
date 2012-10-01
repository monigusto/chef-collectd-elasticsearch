#
# Cookbook Name:: alal
# Recipe:: default
#
# Copyright 2011, Blank Pad Development
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

include_recipe "git"
include_recipe "collectd::server"

git "/opt/collectd-elasticsearch" do
  repository "git://github.com/phobos182/collectd-elasticsearch.git"
  reference "2da36b96d4a8ac5581ec95f3bd8e8da360c726e2"
  action :sync
#  notifies :run, "execute[build debian package]"
end

collectd_python_plugin "elasticsearch" do
    options  'Verbose' => false,
        :cluster => "elasticsearch"
end

link "#{node[:collectd][:plugin_dir]}/elasticsearch.py" do
    to "/opt/collectd-elasticsearch/elasticsearch.py"
end
