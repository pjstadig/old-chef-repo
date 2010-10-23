#
# Cookbook Name:: git
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

define :git_project do
  params[:path] ||= params[:name]
  params[:user] ||= "root"
  params[:group] ||= "root"
  params[:action] ||= :clone
  params[:branch] ||= "master"

  # make sure the project is cloned
  if !File.exists?(params[:path])
    parent = File.dirname(params[:path])
    directory parent do
      owner params[:user]
      group params[:group]
      recursive true
    end

    execute "git clone #{params[:source]} #{params[:path]}" do
      user params[:user]
      group params[:group]
      cwd parent
    end
  end

  # make sure the right branch is checked out
  if !`cd #{params[:path]} && git rev-parse --git-dir 2> /dev/null`.empty?
    execute "git checkout #{params[:branch]}" do
      user params[:user]
      group params[:group]
      cwd params[:path]
    end
  else
    raise "'#{params[:path]}' exists and is not a git repo"
  end

  # perform the action if it is not :clone
  if params[:action] == :pull
    execute "git pull #{params[:remote]} #{params[:branch]}" do
      user params[:user]
      group params[:group]
      cwd params[:path]
    end
  elsif params[:action] != :clone
    raise "Unknown action #{params[:action]}"
  end
end
