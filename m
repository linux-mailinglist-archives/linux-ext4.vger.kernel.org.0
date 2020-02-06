Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E044154BC7
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Feb 2020 20:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgBFTQi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Thu, 6 Feb 2020 14:16:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:56314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbgBFTQi (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 6 Feb 2020 14:16:38 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 206443] New: general protection fault in ext4 during
 simultaneous online resize and write operations
Date:   Thu, 06 Feb 2020 19:16:37 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: surajjs@amazon.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-206443-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=206443

            Bug ID: 206443
           Summary: general protection fault in ext4 during simultaneous
                    online resize and write operations
           Product: File System
           Version: 2.5
    Kernel Version: 5.5
          Hardware: x86-64
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: surajjs@amazon.com
        Regression: No

Created attachment 287189
  --> https://bugzilla.kernel.org/attachment.cgi?id=287189&action=edit
proposed_fix.patch

While writing to an ext4 file system partition during simultaneous online
resize a general protection fault was encountered.

Reproducer:

truncate -s 100G /tmp/foo
sudo bash -c 'while true; do dd if=/dev/zero of=/mnt/xxx bs=1M count=1; sync;
rm /mnt/xxx; done' &
while true; do mkfs.ext4 -b 1024 -E resize=26213883 /tmp/foo 2096635 -F; sudo
mount -o loop /tmp/foo /mnt; sudo resize2fs /dev/loop0 26213883; sudo umount
/mnt; done

The following call trace was observed:

[  886.837106] RIP: 0010:ext4_get_group_desc+0x46/0xa0 [ext4]
[  886.844922] Code: 41 8b 8a a8 00 00 00 41 89 f1 41 8b 42 38 41 d3 e9 49 8b
4a 70 83 e8 01 45 89 c8 21 f0 4a 8b 0c c1 48 85 c9 74 30 49 0f af 02 <48> 03 41
28 48 85 d2 74 03 48 89 0a f3 c3 41 89 f0 48 c7 c1 b8 47
[  886.857215] RSP: 0018:ffffc9000018f7d0 EFLAGS: 00010202
[  886.860998] RAX: 0000000000000040 RBX: ffff8887d634a000 RCX:
6f26075a7d3c6d9e
[  886.865578] RDX: 0000000000000000 RSI: 0000000000000001 RDI:
ffff8887d634a000
[  886.870148] RBP: ffff8887d634c000 R08: 0000000000000000 R09:
0000000000000000
[  886.874731] R10: ffff8887d634c000 R11: 0000000000000000 R12:
0000000000000001
[  886.879306] R13: 0000000000000000 R14: ffff8887d634c000 R15:
ffff8887d0b32000
[  886.883881] FS:  0000000000000000(0000) GS:ffff8887dfa00000(0000)
knlGS:0000000000000000
[  886.890293] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  886.894293] CR2: 00007fc03aa34f30 CR3: 000000000200a006 CR4:
00000000007606e0
[  886.898875] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[  886.903522] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[  886.908267] PKRU: 55555554
[  886.911046] Call Trace:
[  886.913708]  ext4_read_block_bitmap_nowait+0x2a/0x600 [ext4]
[  886.917718]  ext4_read_block_bitmap+0x14/0x50 [ext4]
[  886.921408]  ext4_mb_mark_diskspace_used+0x58/0x380 [ext4]
[  886.925317]  ext4_mb_new_blocks+0x2a4/0x720 [ext4]
[  886.928928]  ? ext4_find_extent+0x295/0x2e0 [ext4]
[  886.932543]  ext4_ext_map_blocks+0xa60/0xd70 [ext4]
[  886.936191]  ? __lock_page_killable+0x240/0x260
[  886.939698]  ext4_map_blocks+0x3ae/0x5d0 [ext4]
[  886.943205]  ext4_writepages+0x7bc/0xe70 [ext4]
[  886.946712]  ? nvme_queue_rq+0x4d8/0xa90 [nvme]
[  886.950207]  ? __update_load_avg_cfs_rq+0x12b/0x2b0
[  886.953846]  ? __update_load_avg_cfs_rq+0x12b/0x2b0
[  886.957491]  ? do_writepages+0x4b/0xe0
[  886.960673]  ? ext4_mark_inode_dirty+0x1d0/0x1d0 [ext4]
[  886.964458]  do_writepages+0x4b/0xe0
[  886.967566]  ? enqueue_task_fair+0xa8/0xa40
[  886.970914]  ? __writeback_single_inode+0x3d/0x320
[  886.974521]  __writeback_single_inode+0x3d/0x320
[  886.978052]  ? ttwu_do_wakeup+0x19/0x140
[  886.981288]  writeback_sb_inodes+0x1b5/0x490
[  886.984675]  __writeback_inodes_wb+0x5d/0xb0
[  886.988069]  wb_writeback+0x265/0x2f0
[  886.991208]  ? wb_workfn+0x33f/0x400
[  886.994315]  wb_workfn+0x33f/0x400
[  886.997341]  process_one_work+0x195/0x380
[  887.000623]  worker_thread+0x30/0x390
[  887.003759]  ? process_one_work+0x380/0x380
[  887.007112]  kthread+0x113/0x130
[  887.010065]  ? kthread_park+0x90/0x90
[  887.013199]  ret_from_fork+0x35/0x40
[  887.016305] Modules linked in: loop ext4 crc16 mbcache jbd2 sunrpc mousedev
evdev psmouse button ena ip_tables x_tables xfs libcrc32c crc32_pclmul
crc32c_intel ghash_clmulni_intel aesni_intel crypto_simd nvme cryptd
glue_helper nvme_core dm_mirror dm_region_hash dm_log dm_mod dax ipv6 crc_ccitt
nf_defrag_ipv6 autofs4
[  887.035407] ---[ end trace dc25e57808972176 ]---
[  887.038960] RIP: 0010:ext4_get_group_desc+0x46/0xa0 [ext4]
[  887.042867] Code: 41 8b 8a a8 00 00 00 41 89 f1 41 8b 42 38 41 d3 e9 49 8b
4a 70 83 e8 01 45 89 c8 21 f0 4a 8b 0c c1 48 85 c9 74 30 49 0f af 02 <48> 03 41
28 48 85 d2 74 03 48 89 0a f3 c3 41 89 f0 48 c7 c1 b8 47
[  887.055189] RSP: 0018:ffffc9000018f7d0 EFLAGS: 00010202
[  887.058992] RAX: 0000000000000040 RBX: ffff8887d634a000 RCX:
6f26075a7d3c6d9e
[  887.063592] RDX: 0000000000000000 RSI: 0000000000000001 RDI:
ffff8887d634a000
[  887.068197] RBP: ffff8887d634c000 R08: 0000000000000000 R09:
0000000000000000
[  887.072795] R10: ffff8887d634c000 R11: 0000000000000000 R12:
0000000000000001
[  887.077399] R13: 0000000000000000 R14: ffff8887d634c000 R15:
ffff8887d0b32000
[  887.081996] FS:  0000000000000000(0000) GS:ffff8887dfa00000(0000)
knlGS:0000000000000000
[  887.088436] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  887.092447] CR2: 00007fc03aa34f30 CR3: 000000000200a006 CR4:
00000000007606e0
[  887.097060] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[  887.101651] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[  887.106252] PKRU: 55555554

Progress:

This looked likely to be a use after free in ext4_get_group_desc() of
EXT4_SB(sb)->s_group_desc while it was being resized in add_new_gdb():
o_group_desc = EXT4_SB(sb)->s_group_desc;
{snip}
EXT4_SB(sb)->s_group_desc = n_group_desc;
EXT4_SB(sb)->s_gdb_count++;
kvfree(o_group_desc);

Proposed fix:

The attached patch was proposed as a fix to use rcu locking around the access
to s_group_desc.
A test run with this patch was done and while the initial problem was no longer
encountered. New call traces (attached) were encountered this time.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
