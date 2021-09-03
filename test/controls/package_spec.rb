# encoding: UTF-8
#
# Author: Stefano Harding <riddopic@gmail.com>
# Copyright (C) 2016 Stefano Harding
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

container_execution = begin
  virtualization.role == 'guest' && virtualization.system =~ /^(lxc|docker)$/
rescue NoMethodError
  false
end

control 'package-01' do
  impact 1.0
  title 'Do not run deprecated inetd or xinetd'
  desc 'http://www.nsa.gov/ia/_files/os/redhat/rhel5-guide-i731.pdf, Chapter 3.2.1'

  describe package('inetd') do
    it { should_not be_installed }
  end

  describe package('xinetd') do
    it { should_not be_installed }
  end
end

control 'package-02' do
  impact 1.0
  title 'Do not install Telnet server'
  desc 'Telnet protocol uses unencrypted communication, that means the password and other sensitive data are unencrypted. http://www.nsa.gov/ia/_files/os/redhat/rhel5-guide-i731.pdf, Chapter 3.2.2'

  describe package('telnetd') do
    it { should_not be_installed }
  end
end

control 'package-03' do
  impact 1.0
  title 'Do not install rsh server'
  desc 'The r-commands suffers same problem as telnet. http://www.nsa.gov/ia/_files/os/redhat/rhel5-guide-i731.pdf, Chapter 3.2.3'

  describe package('rsh-server') do
    it { should_not be_installed }
  end
end

# package-04 is reserved, because we forgot to use it in the first-place :-)

control 'package-05' do
  impact 1.0
  title 'Do not install ypserv server (NIS)'
  desc 'Network Information Service (NIS) has some security design weaknesses like inadequate protection of important authentication information. http://www.nsa.gov/ia/_files/os/redhat/rhel5-guide-i731.pdf, Chapter 3.2.4'

  describe package('ypserv') do
    it { should_not be_installed }
  end
end

control 'package-06' do
  impact 1.0
  title 'Do not install tftp server'
  desc 'tftp-server provides little security http://www.nsa.gov/ia/_files/os/redhat/rhel5-guide-i731.pdf, Chapter 3.2.5'

  describe package('tftp-server') do
    it { should_not be_installed }
  end
end

control 'package-08' do
  impact 1.0
  title 'CIS: Additional process hardening'
  desc '1.5.4 Ensure prelink is disabled'

  describe package('prelink') do
    it { should_not be_installed }
  end
end
