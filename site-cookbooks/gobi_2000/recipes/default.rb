#
# Cookbook Name:: gobi_2000
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

package "patch"
package "linux-source"

kernel_version = node.kernel.release.split("-").first
linux_source = "linux-source-#{kernel_version}"
base_dir = "/usr/src/#{linux_source}"

execute("extract-linux-source") do
  command "cd /usr/src && tar xjf #{linux_source}.tar.bz2"
  not_if "test -d #{base_dir}"
end

patch_file = "usb-wwan-#{kernel_version}.diff"
remote_file "#{base_dir}/#{patch_file}" do
  source patch_file
end

build_dir = "/tmp/gobi-build-#{kernel_version}"
execute "patch-and-build" do
  command <<-ENDL
    mkdir #{build_dir}
    cd #{base_dir} &&
    patch -p1 < #{patch_file} &&
    cp /lib/modules/#{node.kernel.release}/build/.config #{build_dir} &&
    cp /lib/modules/#{node.kernel.release}/build/Module.symvers #{build_dir} &&
    cp /lib/modules/#{node.kernel.release}/build/Makefile . &&

    make O=#{build_dir} outputmakefile &&
    make O=#{build_dir} archprepare &&
    make O=#{build_dir} prepare &&
    make O=#{build_dir} modules SUBDIRS=scripts &&
    make O=#{build_dir} modules SUBDIRS=drivers/usb/serial/ &&

    cp #{build_dir}/drivers/usb/serial/usb_wwan.ko /lib/modules/#{node.kernel.release}/kernel/drivers/usb/serial/ &&
    cp #{build_dir}/drivers/usb/serial/qcserial.ko /lib/modules/#{node.kernel.release}/kernel/drivers/usb/serial/ &&
    cp #{build_dir}/drivers/usb/serial/option.ko /lib/modules/#{node.kernel.release}/kernel/drivers/usb/serial/ &&
    /sbin/depmod -a
  ENDL
  not_if "test /lib/modules/#{node.kernel.release}/kernel/drivers/usb/serial/qcserial.ko -nt " +
    "/lib/modules/#{node.kernel.release}/kernel/drivers/usb/serial/safe_serial.ko"
end

include_recipe "gobi_loader"

remote_file "/tmp/gobi_2000.tar.gz.gpg" do
  source "gobi_2000.tar.gz.gpg"
end

execute "install-firmware" do
  command <<-END
    cd /lib/firmware/gobi/ && gpg -d /tmp/gobi_2000.tar.gz.gpg | tar xz &&
    if lsmod | grep -q qcserial; then
      rmmod qcserial
    fi &&

    modprobe qcserial
  END
  not_if "test -e /lib/firmware/gobi/UQCN.mbn"
end
