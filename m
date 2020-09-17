Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3A2026E5D8
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Sep 2020 21:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbgIQOoA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Thu, 17 Sep 2020 10:44:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:42292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727650AbgIQOmR (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 17 Sep 2020 10:42:17 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 209275] Graphics freeze after WARNING: CPU: 2 PID: 156207 at
 fs/ext4/inode.c:3599 ext4_set_page_dirty+0x3e/0x50
Date:   Thu, 17 Sep 2020 14:42:15 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: rhmcruiser@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-209275-13602-xcH0a90UhH@https.bugzilla.kernel.org/>
In-Reply-To: <bug-209275-13602@https.bugzilla.kernel.org/>
References: <bug-209275-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=209275

Monthero (rhmcruiser@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |rhmcruiser@gmail.com

--- Comment #2 from Monthero (rhmcruiser@gmail.com) ---

Checking the log messages file attachment in Comment #1 

The freeze like slowness that you seem to describe is probably caused by the
gnome-shell dumping core often as seen in the messages log. 

I observe that the gnome-shell seems to be dumping core often in your
environment. 

Sep 15 08:23:46 styx journal[67420]: clutter_actor_has_effects: assertion
'CLUTTER_IS_ACTOR (self)' failed
Sep 15 08:23:46 styx journal[67420]: Object .Gjs_GameModeIndicator
(0x55a8b041c530), has been already deallocated — impossible to set any property
on it. This might be caused by the object having been destroyed from C code
using something such as destroy(), dispose(), or remove() vfuncs.
Sep 15 08:23:46 styx gnome-shell[67420]: == Stack trace for context
0x55a8ac63e3a0 ==
Sep 15 08:23:46 styx gnome-shell[67420]: #0   55a8b19fc6d8 i  
/usr/share/gnome-shell/extensions/gamemode@christian.kellner.me/extension.js:223
(7fba10824820 @ 164)
Sep 15 08:23:46 styx gnome-shell[67420]: #1   7ffe62146c90 

...
...

ep 15 08:23:46 styx gnome-shell[67420]: #9   55a8b19fc420 i  
resource:///org/gnome/gjs/modules/overrides/Gio.js:169 (7fba6c0d3e50 @ 39)
Sep 15 08:23:46 styx gnome-shell[67420]: == Stack trace for context
0x55a8ac63e3a0 ==
Sep 15 08:23:46 styx gnome-shell[67420]: #0   55a8b19fc6d8 i  
/usr/share/gnome-shell/extensions/gamemode@christian.kellner.me/extension.js:231
(7fba10824820 @ 287)
Sep 15 08:23:46 styx gnome-shell[67420]: #1   7ffe62146c90 b   self-hosted:977
(7fba45130a60 @ 413)
Sep 15 08:23:46 styx gnome-shell[67420]: #2   7ffe62146d70 b  
resource:///org/gnome/gjs/modules/signals.js:135 (7fba6c0c6040 @ 376)
Sep 15 08:23:46 styx journal[67420]: Object St.Icon (0x55a8ad298110), has been
already deallocated — impossible to access it. This might be caused by the
object having been destroyed from C code using something such as destroy(),
dispose(), or remove() vfuncs.

...

Further on there has been a bad page error as well for the gnome-shell process: 


40837 Sep 15 08:51:36 styx kernel: file:(null) fault:0x0 mmap:0x0 readpage:0x0
40838 Sep 15 08:51:36 styx kernel: CPU: 2 PID: 156207 Comm: gnome-shell
Tainted: G        W  OE     5.8.6-101.f      c31.x86_64 #1
40839 Sep 15 08:51:36 styx kernel: Hardware name: System manufacturer System
Product Name/PRIME B350M-A, BIOS 5      603 07/28/2020
40840 Sep 15 08:51:36 styx kernel: Call Trace:
40841 Sep 15 08:51:36 styx kernel: dump_stack+0x6d/0x90
40842 Sep 15 08:51:36 styx kernel: print_bad_pte.cold+0x6a/0xd2
40843 Sep 15 08:51:36 styx kernel: unmap_page_range+0x919/0xee0
40844 Sep 15 08:51:36 styx kernel: unmap_vmas+0x6a/0xd0
40845 Sep 15 08:51:36 styx kernel: exit_mmap+0x97/0x170
40846 Sep 15 08:51:36 styx kernel: mmput+0x61/0x140
40847 Sep 15 08:51:36 styx kernel: begin_new_exec+0x377/0x98c
40848 Sep 15 08:51:36 styx kernel: load_elf_binary+0x13e/0x16f0
40849 Sep 15 08:51:36 styx kernel: __do_execve_file.isra.0+0x5d7/0xb90
40850 Sep 15 08:51:36 styx kernel: __x64_sys_execve+0x35/0x40
40851 Sep 15 08:51:36 styx kernel: do_syscall_64+0x52/0x90
40852 Sep 15 08:51:36 styx kernel: entry_SYSCALL_64_after_hwframe+0x44/0xa9
40853 Sep 15 08:51:36 styx kernel: RIP: 0033:0x7fbaa9d104db
40854 Sep 15 08:51:36 styx kernel: Code: Bad RIP value.
.. 

40828 Sep 15 08:51:36 styx kernel: BUG: Bad page map in process gnome-shell 
pte:80000007e2e09845 pmd:7e54a5067
40829 Sep 15 08:51:36 styx kernel: page:ffffdf579f8b8240 refcount:1 mapcount:-1
mapping:000000009b19d3d2 index:      0x61aa
40830 Sep 15 08:51:36 styx kernel: mapping->aops:ext4_da_aops dentry
name:"system@afae2c84506c4614bd5df0c7f65c5     
045-0000000001d0a0ab-0005a448a7d41f69.journal"
40831 Sep 15 08:51:36 styx kernel: flags:
0x17ffffc002001e(referenced|uptodate|dirty|lru|mappedtodisk)
40832 Sep 15 08:51:36 styx kernel: raw: 0017ffffc002001e ffffdf579efb8208
ffffdf579f907148 ffff9c81ae253178
40833 Sep 15 08:51:36 styx kernel: raw: 00000000000061aa 0000000000000000
00000001fffffffe ffff9c81954d4000
40834 Sep 15 08:51:36 styx kernel: page dumped because: bad pte
40835 Sep 15 08:51:36 styx kernel: page->mem_cgroup:ffff9c81954d4000
40836 Sep 15 08:51:36 styx kernel: addr:000055a8b037a000 vm_flags:08100073
anon_vma:ffff9c8151ad0ec8 mapping:00      00000000000000 index:55a8b037a


bash-5.0$ grep -Ri "Bad Page" messages
Sep 15 08:51:36 styx kernel: BUG: Bad page map in process gnome-shell 
pte:80000007e2e09845 pmd:7e54a5067
Sep 15 08:51:36 styx kernel: BUG: Bad page state in process gnome-shell 
pfn:7e2e09

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
