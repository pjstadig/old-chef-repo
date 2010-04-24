#
# Cookbook Name:: apt_source
# Recipe:: default
#
# Copyright 2010, Paul J. Stadig
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

define :apt_source, :enable => true, :source => nil, :key => nil, :variables => {} do
  template_source = params[:source] ? params[:source] : "#{params[:name]}.list.erb"
  template "/etc/apt/sources.list.d/#{params[:name]}.list" do
    source template_source
    owner "root"
    group "root"
    mode 0644
    variables params[:variables]
    if params[:enable]
      action :create
    else
      action :delete
    end
  end

  execute(if params[:key]
            "wget -q -O - '#{params[:key]}' | sudo apt-key add - && "
          else
            ""
          end + "sudo apt-get update")
end
