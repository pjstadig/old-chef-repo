#
# Cookbook Name:: gobi_loader
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

package "gobi-loader"

directory "/lib/firmware/gobi" do
  owner "root"
  group "root"
  mode "0755"
end

execute "install-firmware" do
  action :nothing
  command <<-END
    tar xzf gobi_2000.tar.gz;
    if lsmod | grep -q qcserial; then
      rmmod qcserial
    fi && modprobe qcserial;
    /bin/true
  END
  cwd "/lib/firmware/gobi"
end

encrypted_file "gobi_2000.tar.gz" do
  path "/lib/firmware/gobi/gobi_2000.tar.gz"
  notifies :run, resources(:execute => "install-firmware"), :immediately
end

execute "install-firmware" do
  action :run
  not_if do
    File.exists?("/lib/firmware/gobi/amss.mbn") &&
    File.exists?("/lib/firmware/gobi/apps.mbn") &&
    File.exists?("/lib/firmware/gobi/UQCN.mbn")
  end
end
