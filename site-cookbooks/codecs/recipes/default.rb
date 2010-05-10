#
# Cookbook Name:: codecs
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

package "gstreamer0.10-ffmpeg"
package "gstreamer0.10-fluendo-mp3"
package "gstreamer0.10-plugins-bad"

remote_file "/tmp/codecs.sh.gpg" do
  source "codecs.sh.gpg"
end

execute "unencrypt-codecs" do
  command "gpg -o /tmp/codecs.sh /tmp/codecs.sh.gpg && chmod +x /tmp/codecs.sh"
  not_if "test -e /tmp/codecs.sh"
end

execute "/tmp/codecs.sh"
