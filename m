Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4488C4FD
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Aug 2019 02:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfHNAOC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Tue, 13 Aug 2019 20:14:02 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:39544 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726316AbfHNAOC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 13 Aug 2019 20:14:02 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 0CD072876C
        for <linux-ext4@vger.kernel.org>; Wed, 14 Aug 2019 00:14:01 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 018F828722; Wed, 14 Aug 2019 00:14:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
        pdx-wl-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=2.0 tests=BAYES_00,NO_RECEIVED,
        NO_RELAYS autolearn=unavailable version=3.3.1
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 203317] WARNING: CPU: 2 PID: 925 at fs/ext4/inode.c:3897
 ext4_set_page_dirty+0x39/0x50
Date:   Wed, 14 Aug 2019 00:13:59 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: howaboutsynergy@pm.me
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-203317-13602-ISTW3vyo4Y@https.bugzilla.kernel.org/>
In-Reply-To: <bug-203317-13602@https.bugzilla.kernel.org/>
References: <bug-203317-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=203317

howaboutsynergy is abandoned account everywhere (howaboutsynergy@pm.me) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |jani.nikula@intel.com

--- Comment #4 from howaboutsynergy is abandoned account everywhere (howaboutsynergy@pm.me) ---
The commit that attempts to fix this(and thus links to this issue) is causing a
system freeze (where sysctl+s,u,b still works though) when attempting to cause
a memory pressure via script `memfreeze`(ran as variant 1) which I used in
order to test
[le9g.patch](https://www.phoronix.com/forums/forum/phoronix/general-discussion/1118164-yes-linux-does-bad-in-low-ram-memory-pressure-situations-on-the-desktop?p=1119440#post1119440)
that prevents disk thrashing, but this system freeze happens without that patch
also.

```
commit aa56a292ce623734ddd30f52d73f527d1f3529b5
    drm/i915/userptr: Acquire the page lock around set_page_dirty()
```

The freeze seems to be happening right before OOM-killer is about to kill
something, apparently.

I double checked that v5.3-rc4 with this commit reverted does indeed get rid of
the system freeze.

`memfreeze` script is this:

```

#!/bin/bash

#run this multiple times consecutively, but not at once.

#this should freeze i87k for about 1-2 seconds(actually 5 seconds - try running
top of watch -n1 -d cat /proc/meminfo) while running out of memory temporarily
just before OOM triggers and kills one of the threads:
#^ old comments

#Ensure watchers are running:
ensure_this_runs_already() {
  local cmdtorun="$*"
  if ! pgrep --full "^${cmdtorun}$" >/dev/null; then
    #shellcheck disable=SC2086
    xfce4-terminal -x $cmdtorun  #XXX: unquoted! else it will fail to launch!
  fi
}
ensure_this_runs_already "watch -n.1 -d cat /proc/meminfo"
#ensure_this_runs_already watch -n.1 -d cat /proc/meminfo #yes this works too!
I even tested it.
ensure_this_runs_already "top -d 0.5"
ensure_this_runs_already "sudo iotop -d 5 -o -b"
#exit 1


#XXX tested on i87k host
systemctl --user stop psd #otherwise have to manually rename 2+1 profile dirs
from *-backup to * after the system crashes(and it does with
5.3.0-rc4-gd45331b00ddb kernel, not with 5.2.0 (git) though, or 5.2.4 (stable)
)
if test "${0##*/}" == "memfreeze2"; then
  variant=2
elif test "${0##*/}" == "memfreeze3"; then
  variant=3
else
  variant=1
fi
echo "!! Using memfreeze variant '$variant'"

if test "$1" != "keepswap"; then
  echo "! swapoff first"
  sudo swapoff -a
  threads=2
  timeout=10s
else
  threads=6
  timeout=30s
fi
sync #because possibly crash! in fact guaranteed crash in
5.3.0-rc4-gd45331b00ddb even without any le*.patch-es

if test "$variant" == "1"; then
  #this is a remnant from when I've tested this on QubesOS
  alloc="$(awk '/MemAvailable/{printf "%d\n", $2 + 4000;}' < /proc/meminfo)"
  echo "Will alloc: $alloc kB for each of the $threads concurrent threads."
  echo "MemTotal before: $(awk '/MemTotal/{printf "%d kB\n", $2;}' <
/proc/meminfo)"
  time stress --vm-bytes "${alloc}k" --vm-keep -m $threads --timeout $timeout
  echo "exit code: $?"
  awk '/MemTotal/{printf "MemTotal afterwards: %d kB\n", $2;}' < /proc/meminfo
elif test "$variant" == "2"; then
  time stress -m 220 --vm-bytes 10000000000 --timeout 20
elif test "$variant" == "3"; then
  #XXX say bye bye to Xorg, courtesy of kernel's OOM-killer FIXME: somehow
disable oom-killer or what?!
  time stress -m 3000 --vm-bytes 10M --timeout 50
else
  echo "!! memfreeze variant not implemented"
fi
```

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
