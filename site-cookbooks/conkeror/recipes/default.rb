#
# Cookbook Name:: conkeror
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

package "conkeror"
package "conkeror-spawn-process-helper"

update_alternative "x-www-browser" do
  value "/usr/bin/conkeror"
end

execute "update-alternatives --install /usr/bin/gnome-www-browser gnome-www-browser /usr/bin/conkeror 40"

update_alternative "gnome-www-browser" do
  value "/usr/bin/conkeror"
end
