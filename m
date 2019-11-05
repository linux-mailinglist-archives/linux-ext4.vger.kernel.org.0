Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 434A0EF5AA
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Nov 2019 07:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387561AbfKEGry convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Tue, 5 Nov 2019 01:47:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:51708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387590AbfKEGry (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 5 Nov 2019 01:47:54 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 205433] New: BUG: KASAN: use-after-free in
 ext4_put_super+0xb1d/0xd80
Date:   Tue, 05 Nov 2019 06:47:52 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bobfuzzer@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-205433-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=205433

            Bug ID: 205433
           Summary: BUG: KASAN: use-after-free in
                    ext4_put_super+0xb1d/0xd80
           Product: File System
           Version: 2.5
    Kernel Version: 5.0.21
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: bobfuzzer@gmail.com
        Regression: No

Created attachment 285795
  --> https://bugzilla.kernel.org/attachment.cgi?id=285795&action=edit
(Compressed)crafted img

- Overview
call some syscalls after mount crafted ext4 image, I got use-after-free KASan
msg.

- Reproduce
mount -t ext4 ./292.img ./mnt
gcc -o ./poc ./292.c
mv ./poc ./mnt
cd ./mnt
./poc
cd ..
umount ./mnt

- KASAN Message
[  198.471317] EXT4-fs (loop0): Inode 16 (000000009852d438): orphan list check
failed!
[  198.474979] 000000009852d438: 0002f30a 00000004 00000000 00000000 
................
[  198.475319] 0000000047033746: 00000001 00002602 00000005 00000005 
.....&..........
[  198.478208] 0000000016f25860: 0000041c 00000000 00000000 00000000 
................
[  198.480295] 00000000f9293e75: 00000000 00000000 00000000 00000000 
................
[  198.482744] 000000006065c7b0: 00000000 00000000 00000000 00000000 
................
[  198.486117] 000000004980aa77: 00080000 00000081 00000000 00000000 
................
[  198.487914] 00000000a3af2c7d: 667e3c18 ffff8880 667e3c18 ffff8880 
.<~f.....<~f....
[  198.488306] 000000006df13492: 00000000 00000000 6aa9b303 ffff8880 
...........j....
[  198.489962] 000000004910ca25: 66addf78 ffff8880 66addf78 ffff8880 
x..f....x..f....
[  198.490301] 0000000065895055: 000026a2 00000000 00000000 00000000 
.&..............
[  198.492004] 000000008bdab0da: 667e3c58 ffff8880 667e3c58 ffff8880 
X<~f....X<~f....
[  198.492597] 00000000b00e7ad8: 00000000 00000000 00000000 00000000 
................
[  198.492766] 00000000b0012fbd: 00000000 00000000 667e3c80 ffff8880 
.........<~f....
[  198.494826] 000000005c2758ff: 667e3c80 ffff8880 00000000 00000000 
.<~f............
[  198.495309] 00000000789f4920: 00000000 00000000 000d81a4 00000000 
................
[  198.497712] 00000000ae8f88db: 00000000 00001000 ffffffff ffffffff 
................
[  198.498478] 00000000388b5da4: ffffffff ffffffff 844cb880 ffffffff 
..........L.....
[  198.500961] 0000000020b19b0f: 66ade600 ffff8880 667e3e00 ffff8880 
...f.....>~f....
[  198.504109] 000000004adb407e: 6747b428 ffff8880 00000010 00000000 
(.Gg............
[  198.504927] 000000009fdea92e: 00000001 00000000 000026a2 00000000 
.........&......
[  198.508505] 000000003c3f85bf: 5b437ccf 00000000 00000000 00000000 
.|C[............
[  198.513806] 00000000b11bd59f: 5dc118cc 00000000 00000000 00000000 
...]............
[  198.514215] 00000000394d6a13: 5dc118cc 00000000 00000000 00000000 
...]............
[  198.516825] 00000000de6321c0: 00000000 000a0000 0000000c 00000000 
................
[  198.517249] 000000001cbb31a4: 00000060 00000000 00000000 00000000 
`...............
[  198.519913] 000000003b17e3c9: 667e3d48 ffff8880 667e3d48 ffff8880 
H=~f....H=~f....
[  198.520514] 000000002b972dca: 00000000 00000000 00000000 00000000 
................
[  198.520718] 00000000b36a51c4: fffe44da 00000000 00000000 00000000 
.D..............
[  198.525877] 00000000cbd72834: 00000000 00000000 00000000 00000000 
................
[  198.526155] 00000000fe88dff4: 667e3d88 ffff8880 667e3d88 ffff8880 
.=~f.....=~f....
[  198.529023] 00000000a4d58956: 667e3d98 ffff8880 667e3d98 ffff8880 
.=~f.....=~f....
[  198.529695] 00000000008045a4: 667e3da8 ffff8880 667e3da8 ffff8880 
.=~f.....=~f....
[  198.532944] 000000009d661512: 667e3db8 ffff8880 667e3db8 ffff8880 
.=~f.....=~f....
[  198.534759] 000000005cd395c7: 00000000 00000000 00000000 00000000 
................
[  198.535017] 00000000877d23a7: 00000003 00000000 00000000 00000000 
................
[  198.535441] 000000007c5221f9: 00000000 00000000 844cb960 ffffffff 
........`.L.....
[  198.539833] 000000007712b560: 00000000 00000000 667e3ca0 ffff8880 
.........<~f....
[  198.540138] 000000001d6ac576: 00000000 00000001 00000000 00000000 
................
[  198.542743] 00000000fe5e5556: 006200ca 00000000 00000000 00000000 
..b.............
[  198.543189] 0000000013ecc936: 00000000 00000000 00000000 00000000 
................
[  198.545151] 0000000059a6d2b7: 667e3e38 ffff8880 667e3e38 ffff8880 
8>~f....8>~f....
[  198.547827] 0000000052373a5c: 00000000 00000000 00000000 00000000 
................
[  198.548428] 00000000e13fb470: 00000000 00000000 00000000 00000000 
................
[  198.550851] 00000000f4393e17: 00000002 00000000 844ce540 ffffffff 
........@.L.....
[  198.551285] 000000007af205c5: 00000010 00000000 00000000 00000000 
................
[  198.551522] 00000000f9657e75: 667e3e88 ffff8880 667e3e88 ffff8880 
.>~f.....>~f....
[  198.555576] 00000000763ccf23: 00000000 00000000 667e3ea0 ffff8880 
.........>~f....
[  198.555823] 00000000e1069248: 667e3ea0 ffff8880 00000000 00000000 
.>~f............
[  198.556063] 00000000ae66627f: 709b874b 00000000 00000000 00000000 
K..p............
[  198.558737] 0000000063479309: 00000000 00000000 00000000 00000000 
................
[  198.559044] 0000000055103b8e: 00000000 00000000 00000000 00000000 
................
[  198.559262] 00000000e2660410: 00000000 00000000 667e3ef0 ffff8880 
.........>~f....
[  198.559534] 0000000044c520ff: 667e3ef0 ffff8880 00000000 00000000 
.>~f............
[  198.561654] 00000000017f7e31: 00000000 00000000 00000000 00000000 
................
[  198.564920] 000000004ccfbf34: 00000000 00000000 667e3f20 ffff8880  ........
?~f....
[  198.565688] 0000000046047d23: 667e3f20 ffff8880 00000000 00000000  
?~f............
[  198.567019] 00000000aab9badb: 00000000 ffffffff 00000000 00000000 
................
[  198.567505] 0000000095d70825: 00000000 00000000 00000000 00000000 
................
[  198.570019] 00000000b95b1178: 00000000 00000000 00000000 00000000 
................
[  198.572681] 00000000d5f15436: 00000000 00000000 667e3f70 ffff8880 
........p?~f....
[  198.573042] 00000000aa068789: 667e3f70 ffff8880 ffffffe0 0000000f 
p?~f............
[  198.575744] 000000003bec8c67: 667e3f88 ffff8880 667e3f88 ffff8880 
.?~f.....?~f....
[  198.576434] 0000000037aee2e3: 8199dc00 ffffffff 00000000 00000000 
................
[  198.578653] 00000000d3702206: 00000020 0000001b 00000000 00000000  
...............
[  198.578979] 00000000f8b64ef4: 00000000 00000000 00000000 00000000 
................
[  198.579305] 0000000083ff53a5: 00000000 00000000                    ........
[  198.582097] CPU: 1 PID: 1971 Comm: umount Not tainted 5.0.21 #1
[  198.582553] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.10.2-1ubuntu1 04/01/2014
[  198.582553] Call Trace:
[  198.582553]  dump_stack+0xae/0x14b
[  198.582553]  ? show_regs_print_info+0x5/0x5
[  198.582553]  ? block_write_end+0x1c0/0x1c0
[  198.582553]  ext4_destroy_inode+0x18c/0x1c0
[  198.582553]  ? ext4_put_super+0xd80/0xd80
[  198.582553]  ? generic_update_time+0x390/0x390
[  198.582553]  ? __insert_inode_hash+0x2f0/0x2f0
[  198.582553]  destroy_inode+0x133/0x1c0
[  198.582553]  ? __destroy_inode+0x2d0/0x2d0
[  198.582553]  evict+0x5b7/0x910
[  198.582553]  ? destroy_inode+0x1c0/0x1c0
[  198.582553]  ? rcu_sync_dtor+0x300/0x300
[  198.582553]  ? __lock_page_killable+0x140/0x140
[  198.582553]  ? fsnotify_grab_connector+0x114/0x1f0
[  198.582553]  ? fsnotify_detach_connector_from_object+0x440/0x440
[  198.582553]  ? inode_add_lru+0x220/0x220
[  198.582553]  ? _raw_spin_lock+0x99/0x130
[  198.582553]  ? _raw_read_lock_irq+0x30/0x30
[  198.582553]  ? rcu_qs+0x2f0/0x2f0
[  198.582553]  ? list_lru_del+0x11e/0x4d0
[  198.582553]  dispose_list+0x1e8/0x390
[  198.582553]  ? mempool_alloc+0x119/0x380
[  198.582553]  ? evict+0x910/0x910
[  198.582553]  ? _raw_read_lock_irq+0x30/0x30
[  198.582553]  ? __bio_clone_fast+0x480/0x480
[  198.582553]  ? _raw_spin_lock+0x99/0x130
[  198.582553]  ? _raw_read_lock_irq+0x30/0x30
[  198.582553]  ? __fsnotify_vfsmount_delete+0x10/0x10
[  198.582553]  evict_inodes+0x521/0x6b0
[  198.582553]  ? dispose_list+0x390/0x390
[  198.582553]  ? do_writepages+0xba/0x110
[  198.582553]  ? blkdev_write_end+0xd0/0x140
[  198.582553]  ? do_writepages+0xba/0x110
[  198.582553]  ? __filemap_fdatawrite_range+0x266/0x3b0
[  198.582553]  ? delete_from_page_cache_batch+0xc30/0xc30
[  198.582553]  ? filemap_write_and_wait+0x63/0x90
[  198.582553]  ? sync_filesystem+0x22f/0x2b0
[  198.582553]  ? lockref_put_return+0x1a4/0x280
[  198.582553]  generic_shutdown_super+0x114/0x4f0
[  198.582553]  ? destroy_super_rcu+0x1f0/0x1f0
[  198.582553]  ? __kasan_slab_free+0x143/0x180
[  198.582553]  ? unregister_shrinker+0x1c1/0x2f0
[  198.582553]  ? kfree+0x8d/0x1a0
[  198.582553]  ? unregister_shrinker+0x1c1/0x2f0
[  198.582553]  ? kswapd_cpu_online+0x180/0x180
[  198.582553]  kill_block_super+0x8f/0xd0
[  198.582553]  deactivate_locked_super+0x80/0xc0
[  198.582553]  deactivate_super+0x225/0x280
[  198.582553]  ? super_setup_bdi+0xa0/0xa0
[  198.582553]  ? ida_free+0x2e6/0x3b0
[  198.582553]  ? idr_replace+0x200/0x200
[  198.582553]  ? cpumask_next+0x16/0x20
[  198.582553]  ? mnt_get_writers.isra.25+0xb3/0x140
[  198.582553]  cleanup_mnt+0x9a/0x130
[  198.582553]  task_work_run+0x1db/0x290
[  198.582553]  ? task_work_cancel+0x200/0x200
[  198.582553]  ? __do_sys_newstat+0x88/0xd0
[  198.582553]  ? __ia32_sys_newfstat+0x70/0x70
[  198.582553]  ? __schedule+0x1af0/0x1af0
[  198.582553]  exit_to_usermode_loop+0x194/0x1d0
[  198.582553]  ? trace_raw_output_sys_exit+0xe0/0xe0
[  198.582553]  do_syscall_64+0x37b/0x440
[  198.582553]  ? syscall_return_slowpath+0x2e0/0x2e0
[  198.582553]  ? prepare_exit_to_usermode+0x1be/0x210
[  198.582553]  ? perf_trace_sys_enter+0x1050/0x1050
[  198.582553]  ? __x64_sys_sigaltstack+0x270/0x270
[  198.582553]  ? __put_user_4+0x1c/0x30
[  198.582553]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  198.582553] RIP: 0033:0x7f59a11f3d77
[  198.582553] Code: 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00
31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d f1 00 2b 00 f7 d8 64 89 01 48
[  198.582553] RSP: 002b:00007fffdce21358 EFLAGS: 00000246 ORIG_RAX:
00000000000000a6
[  198.582553] RAX: 0000000000000000 RBX: 000055ba6e498080 RCX:
00007f59a11f3d77
[  198.582553] RDX: 0000000000000001 RSI: 0000000000000000 RDI:
000055ba6e49c590
[  198.582553] RBP: 000055ba6e49c590 R08: 000055ba6e49c1d0 R09:
0000000000000014
[  198.582553] R10: 00000000000006b4 R11: 0000000000000246 R12:
00007f59a16f5e64
[  198.582553] R13: 0000000000000000 R14: 000055ba6e498260 R15:
00007fffdce215e0
[  198.965080] EXT4-fs (loop0): sb orphan head is 16
[  198.965394] sb_info orphan list:
[  198.967928]
==================================================================
[  198.968387] BUG: KASAN: use-after-free in ext4_put_super+0xb1d/0xd80
[  198.968624] Read of size 4 at addr ffff8880667e3bf4 by task umount/1971
[  198.968624]
[  198.968624] CPU: 1 PID: 1971 Comm: umount Not tainted 5.0.21 #1
[  198.968624] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.10.2-1ubuntu1 04/01/2014
[  198.968624] Call Trace:
[  198.968624]  dump_stack+0xae/0x14b
[  198.968624]  ? show_regs_print_info+0x5/0x5
[  198.968624]  ? kmsg_dump_rewind_nolock+0xd4/0xd4
[  198.968624]  ? _raw_spin_lock_irqsave+0x9f/0x130
[  198.968624]  ? _raw_write_lock_irqsave+0x130/0x130
[  198.968624]  ? ext4_put_super+0xb1d/0xd80
[  198.968624]  print_address_description+0x6e/0x280
[  198.968624]  ? ext4_put_super+0xb1d/0xd80
[  198.968624]  ? ext4_put_super+0xb1d/0xd80
[  198.968624]  kasan_report+0x149/0x18d
[  198.968624]  ? ext4_put_super+0xb1d/0xd80
[  198.968624]  ext4_put_super+0xb1d/0xd80
[  198.968624]  ? ext4_quota_write+0x520/0x520
[  198.968624]  ? filemap_write_and_wait+0x63/0x90
[  198.968624]  ? sync_filesystem+0x22f/0x2b0
[  198.968624]  ? lockref_put_return+0x1a4/0x280
[  198.968624]  generic_shutdown_super+0x198/0x4f0
[  198.968624]  ? destroy_super_rcu+0x1f0/0x1f0
[  198.968624]  ? __kasan_slab_free+0x143/0x180
[  198.968624]  ? unregister_shrinker+0x1c1/0x2f0
[  198.968624]  ? kfree+0x8d/0x1a0
[  198.968624]  ? unregister_shrinker+0x1c1/0x2f0
[  198.968624]  ? kswapd_cpu_online+0x180/0x180
[  198.968624]  kill_block_super+0x8f/0xd0
[  198.968624]  deactivate_locked_super+0x80/0xc0
[  198.968624]  deactivate_super+0x225/0x280
[  198.968624]  ? super_setup_bdi+0xa0/0xa0
[  198.968624]  ? ida_free+0x2e6/0x3b0
[  198.968624]  ? idr_replace+0x200/0x200
[  198.968624]  ? cpumask_next+0x16/0x20
[  198.968624]  ? mnt_get_writers.isra.25+0xb3/0x140
[  198.968624]  cleanup_mnt+0x9a/0x130
[  198.968624]  task_work_run+0x1db/0x290
[  198.968624]  ? task_work_cancel+0x200/0x200
[  198.968624]  ? __do_sys_newstat+0x88/0xd0
[  198.968624]  ? __ia32_sys_newfstat+0x70/0x70
[  198.968624]  ? __schedule+0x1af0/0x1af0
[  198.968624]  exit_to_usermode_loop+0x194/0x1d0
[  198.968624]  ? trace_raw_output_sys_exit+0xe0/0xe0
[  198.968624]  do_syscall_64+0x37b/0x440
[  198.968624]  ? syscall_return_slowpath+0x2e0/0x2e0
[  198.968624]  ? prepare_exit_to_usermode+0x1be/0x210
[  198.968624]  ? perf_trace_sys_enter+0x1050/0x1050
[  198.968624]  ? __x64_sys_sigaltstack+0x270/0x270
[  198.968624]  ? __put_user_4+0x1c/0x30
[  198.968624]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  198.968624] RIP: 0033:0x7f59a11f3d77
[  198.968624] Code: 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00
31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d f1 00 2b 00 f7 d8 64 89 01 48
[  198.968624] RSP: 002b:00007fffdce21358 EFLAGS: 00000246 ORIG_RAX:
00000000000000a6
[  198.968624] RAX: 0000000000000000 RBX: 000055ba6e498080 RCX:
00007f59a11f3d77
[  198.968624] RDX: 0000000000000001 RSI: 0000000000000000 RDI:
000055ba6e49c590
[  198.968624] RBP: 000055ba6e49c590 R08: 000055ba6e49c1d0 R09:
0000000000000014
[  198.968624] R10: 00000000000006b4 R11: 0000000000000246 R12:
00007f59a16f5e64
[  198.968624] R13: 0000000000000000 R14: 000055ba6e498260 R15:
00007fffdce215e0
[  198.968624]
[  198.968624] Allocated by task 1970:
[  198.968624]  __kasan_kmalloc.constprop.4+0xa0/0xd0
[  198.968624]  kmem_cache_alloc+0xa7/0x170
[  198.968624]  ext4_alloc_inode+0xb8/0x8e0
[  198.968624]  alloc_inode+0x58/0x150
[  198.968624]  iget_locked+0x20b/0x5b0
[  198.968624]  __ext4_iget+0x27c/0x49d0
[  198.968624]  ext4_lookup+0x2b2/0x590
[  198.968624]  __lookup_slow+0x1f7/0x450
[  198.968624]  lookup_slow+0x4b/0x70
[  198.968624]  walk_component+0x7bb/0x1410
[  198.968624]  path_lookupat+0x18b/0xd00
[  198.968624]  filename_lookup+0x238/0x5b0
[  198.968624]  do_sys_truncate+0x87/0x110
[  198.968624]  do_syscall_64+0x12b/0x440
[  198.968624]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  198.968624]
[  198.968624] Freed by task 1240:
[  198.968624]  __kasan_slab_free+0x12e/0x180
[  198.968624]  kmem_cache_free+0x70/0x1a0
[  198.968624]  rcu_process_callbacks+0x75b/0x1b80
[  198.968624]  __do_softirq+0x1fb/0x701
[  198.968624] The buggy address belongs to the object at ffff8880667e3bb8
[  198.968624]  which belongs to the cache ext4_inode_cache of size 1048
[  198.968624] The buggy address is located 60 bytes inside of
[  198.968624]  1048-byte region [ffff8880667e3bb8, ffff8880667e3fd0)
[  198.968624] The buggy address belongs to the page:
[  198.968624] page:ffffea000199f800 count:1 mapcount:0
mapping:ffff88806ab02c80 index:0x0 compound_mapcount: 0
[  198.968624] flags: 0x100000000010200(slab|head)
[  198.968624] raw: 0100000000010200 dead000000000100 dead000000000200
ffff88806ab02c80
[  198.968624] raw: 0000000000000000 00000000801b001b 00000001ffffffff
0000000000000000
[  198.968624] page dumped because: kasan: bad access detected
[  198.968624]
[  198.968624] Memory state around the buggy address:
[  198.968624]  ffff8880667e3a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
fb
[  198.968624]  ffff8880667e3b00: fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
fc
[  198.968624] >ffff8880667e3b80: fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
fb
[  198.968624]                                                              ^
[  198.968624]  ffff8880667e3c00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
fb
[  198.968624]  ffff8880667e3c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
fb
[  198.968624]
==================================================================
[  198.968624] Disabling lock debugging due to kernel taint
[  199.000128]   inode loop0:16 at 00000000bd0a4bd5: mode 100644, nlink 1, next
0
[  199.001786] ------------[ cut here ]------------

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
