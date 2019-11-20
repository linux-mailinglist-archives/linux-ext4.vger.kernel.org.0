Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A03410421F
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Nov 2019 18:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbfKTRbo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Wed, 20 Nov 2019 12:31:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:53792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726872AbfKTRbo (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 20 Nov 2019 12:31:44 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 205609] Multiple bugs in __ext4_expand_extra_isize (OOB write
 and UAF write)
Date:   Wed, 20 Nov 2019 17:31:42 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tristmd@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-205609-13602-qt6SjpMqMw@https.bugzilla.kernel.org/>
In-Reply-To: <bug-205609-13602@https.bugzilla.kernel.org/>
References: <bug-205609-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=205609

--- Comment #1 from Tristan (tristmd@gmail.com) ---
BUG 1 - UAF write in __ext4_expand_extra_isize
===

KASAN: use-after-free in __ext4_expand_extra_isize+0x182/0x250
fs/ext4/inode.c:5924
Write of size 189

Details:

BUG: KASAN: use-after-free in __ext4_expand_extra_isize+0x182/0x250
fs/ext4/inode.c:5924
Write of size 189 at addr ffff88802232ffa0 by task syz-executor.1/2654

CPU: 0 PID: 2654 Comm: syz-executor.1 Not tainted 5.4.0-rc2 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x75/0xae lib/dump_stack.c:113
 print_address_description.constprop.6+0x16/0x220 mm/kasan/report.c:374
 __kasan_report.cold.9+0x1a/0x40 mm/kasan/report.c:506
 kasan_report+0xe/0x20 mm/kasan/common.c:634
 check_memory_region_inline mm/kasan/generic.c:185 [inline]
 check_memory_region+0x144/0x1c0 mm/kasan/generic.c:192
 memset+0x1f/0x40 mm/kasan/common.c:105
 __ext4_expand_extra_isize+0x182/0x250 fs/ext4/inode.c:5924
 ext4_try_to_expand_extra_isize fs/ext4/inode.c:5976 [inline]
 ext4_mark_inode_dirty+0x586/0x6c0 fs/ext4/inode.c:6052
 ext4_ext_truncate+0x8b/0x1d0 fs/ext4/extents.c:4583
 ext4_truncate+0x974/0xf30 fs/ext4/inode.c:4511
 ext4_evict_inode+0x73f/0xf80 fs/ext4/inode.c:289
 evict+0x2d3/0x640 fs/inode.c:574
 iput_final fs/inode.c:1563 [inline]

../..

NB: Full report attached


BUG 2 - OOB write
===

EXT4-fs error (device sda): htree_dirblock_to_tree:1025: inode #15297: block
10531: comm syz-fuzzer: bad entry in directory: rec_len is smaller than minimal
- offset=0, inode=0, rec_len=0, name_len=0, size=4096
BUG: KASAN: out-of-bounds in __ext4_expand_extra_isize+0x182/0x250
fs/ext4/inode.c:5924
Write of size 991 at addr ffff8880177a1fa0 by task syz-executor.3/443

CPU: 1 PID: 443 Comm: syz-executor.3 Not tainted 5.4.0-rc2 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x75/0xae lib/dump_stack.c:113
 print_address_description.constprop.6+0x16/0x220 mm/kasan/report.c:374
 __kasan_report.cold.9+0x1a/0x40 mm/kasan/report.c:506
 kasan_report+0xe/0x20 mm/kasan/common.c:634
 check_memory_region_inline mm/kasan/generic.c:185 [inline]
 check_memory_region+0x144/0x1c0 mm/kasan/generic.c:192
 memset+0x1f/0x40 mm/kasan/common.c:105
 __ext4_expand_extra_isize+0x182/0x250 fs/ext4/inode.c:5924
 ext4_try_to_expand_extra_isize fs/ext4/inode.c:5976 [inline]
 ext4_mark_inode_dirty+0x586/0x6c0 fs/ext4/inode.c:6052
 ext4_dirty_inode+0x71/0xa0 fs/ext4/inode.c:6086
 __mark_inode_dirty+0x3d4/0xd30 fs/fs-writeback.c:2255
 generic_update_time+0x1b4/0x2d0 fs/inode.c:1667
 update_time fs/inode.c:1683 [inline]
 touch_atime+0x20e/0x270 fs/inode.c:1754
 file_accessed include/linux/fs.h:2202 [inline]
 iterate_dir+0x2e5/0x540 fs/readdir.c:70
 ksys_getdents64+0x11a/0x230 fs/readdir.c:372
 __do_sys_getdents64 fs/readdir.c:391 [inline]
 __se_sys_getdents64 fs/readdir.c:388 [inline]
 __x64_sys_getdents64+0x6f/0xb0 fs/readdir.c:388
 do_syscall_64+0x9a/0x330 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x483157
Code: 04 48 81 ec 80 00 00 00 e8 b6 12 f9 ff 48 81 c4 80 00 00 00 5b c3 66 2e
0f 1f 84 00 00 00 00 00 0f 1f 00 b8 d9 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01
c3 48 c7 c2 bc ff ff ff f7 d8 64 89 02 48
RSP: 002b:00007ffd2d74f558 EFLAGS: 00000246 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 0000000001dcdc30 RCX: 0000000000483157
RDX: 0000000000008000 RSI: 0000000001dcdc60 RDI: 0000000000000004
RBP: 0000000001dcdc60 R08: 0000000000000003 R09: 0000000000000076
R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffbc
R13: 0000000000000016 R14: 00000000004a54ec R15: 00000000ffffffff

The buggy address belongs to the page:
page:ffffea00005de840 refcount:2 mapcount:0 mapping:ffff888035848d78
index:0x4de
0xffffffff8aeb2e20 
flags: 0x100000000002032(referenced|lru|active|private)
raw: 0100000000002032 ffffea00005df188 ffffea0000d81d48 ffff888035848d78
raw: 00000000000004de ffff888023614000 00000002ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8880177a1f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff8880177a1f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff8880177a2000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
                   ^
 ffff8880177a2080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff8880177a2100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


NB: Full report attached

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
