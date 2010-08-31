#
# Cookbook Name:: codecs
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

package "gstreamer0.10-ffmpeg"
package "gstreamer0.10-fluendo-mp3"
package "gstreamer0.10-plugins-bad"

execute "install-codecs" do
  command "/usr/local/bin/codecs.sh"
  action :nothing
end

encrypted_file "codecs.sh" do
  path "/usr/local/bin/codecs.sh"
  owner "paul"
  group "users"
  mode 00755
  notifies :run, resources(:execute => "install-codecs"), :immediately
end
