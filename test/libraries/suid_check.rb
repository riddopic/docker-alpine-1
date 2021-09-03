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

class SUIDCheck < Inspec.resource(1)
  name 'suid_check'
  desc 'Use the suid_check resource to verify the current SUID/SGID against a blacklist'
  example "
     describe suid_check(blacklist) do
       its('diff') { should be_empty }
     end
   "

  def initialize(blacklist = nil)
    super()
    blacklist = default if blacklist.nil?
    @blacklist = blacklist
  end

  def permissions
    output = inspec.command('find / -perm -4000 -o -perm -2000 -type f ! -path \'/proc/*\' ! -path \'/var/lib/lxd/containers/*\' -print 2>/dev/null | grep -v \'^find:\'')
    output.stdout.split(/\r?\n/)
  end

  def diff
    permissions & @blacklist
  end
end
