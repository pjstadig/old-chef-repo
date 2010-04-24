#
# Cookbook Name:: google_chrome
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

#include_recipe "apt_source"

apt_source "google" do
  key "https://dl-ssl.google.com/linux/linux_signing_key.pub"
end

package "google-chrome-beta"
execute "update-alternatives --set x-www-browser /usr/bin/google-chrome"
execute "update-alternatives --set gnome-www-browser /usr/bin/google-chrome"
