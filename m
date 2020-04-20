Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0422E1B1A4C
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Apr 2020 01:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgDTXvF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Mon, 20 Apr 2020 19:51:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:35542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725550AbgDTXvF (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 20 Apr 2020 19:51:05 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 207367] Accraid / aptec / Microsemi / ext4 / larger then 16TB
Date:   Mon, 20 Apr 2020 23:51:04 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: lists@nerdbynature.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-207367-13602-zdl9QZH6DN@https.bugzilla.kernel.org/>
In-Reply-To: <bug-207367-13602@https.bugzilla.kernel.org/>
References: <bug-207367-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=207367

--- Comment #3 from Christian Kujau (lists@nerdbynature.de) ---
On Mon, 20 Apr 2020, bugzilla-daemon@bugzilla.kernel.org wrote:
> with kernel 5.7 only volumes under 16TB can be mount.

While this bug report is still missing details, I was able to reproduce 
this issue. Contrary to the subject line, it is not hardware related at 
all.

Linux 5.5 (Debian), creating a 17 TB sparse device (4 GB backing device):

 $ echo "0 36507222016 zero" | dmsetup create zero0
 $ echo "0 36507222016 snapshot /dev/mapper/zero0 /dev/vdb p 128" | \
   dmsetup create sparse0

 $ mkfs.ext4 -F /dev/mapper/sparse0
 Creating filesystem with 4563402752 4k blocks and 285212672 inodes
 Creating journal (262144 blocks): done

 $ mount -t ext4 /dev/mapper/sparse0 /mnt/disk/
 $ df -h /mnt/disk/
 Filesystem      Size  Used Avail Use% Mounted on
 /dev/mapper/sparse0   17T   24K   17T   1% /mnt/disk


The same fails on 5.7-rc2 (vanilla) with:


------------[ cut here ]------------
would truncate bmap result
WARNING: CPU: 0 PID: 640 at fs/iomap/fiemap.c:121 
iomap_bmap_actor+0x3a/0x40
Modules linked in: dm_zero 9p xhci_pci xhci_hcd virtio_balloon 
9pnet_virtio loop fuse sunrpc
CPU: 0 PID: 640 Comm: mount Not tainted 5.7.0-rc2 #3
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 
?-20190727_073836-buildvm-ppc64le-16.ppc.fedoraproject.org-3.fc31 
04/01/2014
RIP: 0010:iomap_bmap_actor+0x3a/0x40
Code: 70 08 0f b6 8f 86 00 00 00 49 03 30 48 d3 ee 48 81 fe ff ff ff 7f 77 
06 48 89 30 31 c0 c3 48 c7 c7 fa 71 56 a9 e8 04 f7 ea ff <0f> 0b 31 c0 c3 
cc 41 54 55 53 48 83 ec 08 48 8b 47 48 48 89 34 24
RSP: 0018:ffffb8fd8090bb80 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffffffffa9424bb0 RCX: 0000000000000000
RDX: ffff996abbc1ed40 RSI: ffff996abbc180c8 RDI: ffff996abbc180c8
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000277
R10: 0000000000000774 R11: ffffb8fd8090ba35 R12: 0000000000000000
R13: ffff996aafc6e9b8 R14: ffffb8fd8090bc70 R15: 0000000000001000
FS:  00007efc34fafc80(0000) GS:ffff996abbc00000(0000) 
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007efc352f29a0 CR3: 000000016e074003 CR4: 0000000000360eb0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 iomap_apply+0xf4/0x1a0
 ? iomap_fiemap_actor+0x90/0x90
 iomap_bmap+0x70/0x90
 ? iomap_fiemap_actor+0x90/0x90
 bmap+0x1d/0x30
 jbd2_journal_init_inode+0x2b/0xe0
 ext4_fill_super+0x29c4/0x3300
 ? mount_bdev+0x171/0x1a0
 ? ext4_calculate_overhead+0x480/0x480
 mount_bdev+0x171/0x1a0
 ? ext4_calculate_overhead+0x480/0x480
 legacy_get_tree+0x22/0x40
 vfs_get_tree+0x1b/0x80
 ? ns_capable_common+0x29/0x50
 do_mount+0x713/0x9f0
 ? memdup_user+0x49/0x90
 __x64_sys_mount+0x89/0xc0
 do_syscall_64+0x60/0x3b0
 ? do_page_fault+0x243/0x4bb
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7efc351c7e1a
Code: 48 8b 0d 79 e0 0b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 
00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff 
ff 73 01 c3 48 8b 0d 46 e0 0b 00 f7 d8 64 89 01 48
RSP: 002b:00007ffe6e5bce18 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 000055d888f5cb00 RCX: 00007efc351c7e1a
RDX: 000055d888f5cd10 RSI: 000055d888f5ea30 RDI: 000055d888f5cd30
RBP: 00007efc35318204 R08: 0000000000000000 R09: 000055d888f5ee00
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 000055d888f5cd30 R15: 000055d888f5cd10
---[ end trace 513dea1cc94aa289 ]---
jbd2_journal_init_inode: Cannot locate journal superblock
EXT4-fs (dm-1): Could not load journal inode


HTH,
Christian.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
