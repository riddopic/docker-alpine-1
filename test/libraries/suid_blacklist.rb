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

class SUIDBlacklist < Inspec.resource(1)
  name 'suid_blacklist'
  desc 'The suid_blacklist resoruce returns the default suid blacklist'

  def default
    [
      # blacklist as provided by NSA
      '/usr/bin/rcp', '/usr/bin/rlogin', '/usr/bin/rsh',
      # sshd must not use host-based authentication (see ssh cookbook)
      '/usr/libexec/openssh/ssh-keysign',
      '/usr/lib/openssh/ssh-keysign',
      # misc others
      '/sbin/netreport', # not normally required for user
      '/usr/sbin/usernetctl', # modify interfaces via functional accounts
      # connecting to ...
      '/usr/sbin/userisdnctl', # no isdn...
      '/usr/sbin/pppd', # no ppp / dsl ...
      # lockfile
      '/usr/bin/lockfile',
      '/usr/bin/mail-lock',
      '/usr/bin/mail-unlock',
      '/usr/bin/mail-touchlock',
      '/usr/bin/dotlockfile',
      # need more investigation, blacklist for now
      '/usr/bin/arping',
      '/usr/sbin/arping',
      '/usr/sbin/uuidd',
      '/usr/bin/mtr', # investigate current state...
      '/usr/lib/evolution/camel-lock-helper-1.2', # investigate current state...
      '/usr/lib/pt_chown', # pseudo-tty, needed?
      '/usr/lib/eject/dmcrypt-get-device',
      '/usr/lib/mc/cons.saver' # midnight commander screensaver
      # from Ubuntu xenial, need to investigate
      # '/sbin/unix_chkpwd',
      # '/sbin/pam_extrausers_chkpwd',
      # '/usr/lib/x86_64-linux-gnu/utempter/utempter',
      # '/usr/sbin/postdrop',
      # '/usr/sbin/postqueue',
      # '/usr/bin/ssh-agent',
      # '/usr/bin/mlocate',
      # '/usr/bin/crontab',
      # '/usr/bin/screen',
      # '/usr/bin/expiry',
      # '/usr/bin/wall',
      # '/usr/bin/chage',
      # '/usr/bin/bsd-write'
    ]
  end
end
