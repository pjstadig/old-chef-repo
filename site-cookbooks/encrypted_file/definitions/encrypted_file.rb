#
# Cookbook Name:: encrypted_file
# Recipe:: default
#
# Copyright 2010, Paul Stadig
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

define :encrypted_file do
  raise ArgumentError, "You must supply a name when declaring an encrypted_file resource" if params[:name].to_s.strip.length == 0
  params[:source] ||= "#{params[:name]}.gpg"
  params[:path] ||= params[:name]
  params[:action] ||= :create
  unless [:nothing, :create, :delete].include?(params[:action])
    raise Chef::Exceptions::ValidationFailed, "Option action must be equal to one of: nothing, create, delete!  You passed #{params[:action].inspect}."
  end
  
  if params[:action] == :delete
    execute "delete-#{params[:name]}" do
      command "rm -f #{params[:path]} #{params[:path]}.gpg"
      only_if {
        File.exists?(params[:path]) ||
        File.exists?("#{params[:path]}.gpg")
      }
      notifies(params[:notifies][0], resources(params[:notifies][1]), params[:notifies][2]) if params[:notifies]
    end
  elsif params[:action] == :create
    tmp_id = rand(1000)

    file params[:name] do
      action :nothing
      group params[:group]
      mode params[:mode]
      owner params[:owner]
      path params[:path]
      notifies(params[:notifies][0], resources(params[:notifies][1]), params[:notifies][2]) if params[:notifies]
    end

    execute "decrypt-#{tmp_id}" do
      action :nothing
      command "gpg --yes --output #{params[:path]} -d #{params[:path]}.gpg"
      notifies(:touch, resources(:file => params[:name]), :immediately)
    end
    
    cookbook_file("#{params[:path]}.gpg") do
      source params[:source]
      group params[:group]
      mode params[:mode]
      owner params[:owner]
      notifies(:run, resources(:execute => "decrypt-#{tmp_id}"), :immediately)
    end
    
    execute "decrypt-#{tmp_id}" do
      action :run
      not_if { File.exists?("#{params[:path]}") }
      only_if { File.exists?("#{params[:path]}.gpg") }
    end
  end
end
