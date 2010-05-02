#
# Cookbook Name:: gobi_loader
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

gobi_loader = "gobi_loader-0.5"
remote_file "/tmp/#{gobi_loader}.tar.gz" do
  source "#{gobi_loader}.tar.gz"
end

execute "extract-gobi-loader" do
  command <<-ENDL
    cd /tmp &&
    tar xzf #{gobi_loader}.tar.gz &&
    cd #{gobi_loader} &&
    make &&
    make install &&
    mkdir -p /lib/firmware/gobi
  ENDL
end
