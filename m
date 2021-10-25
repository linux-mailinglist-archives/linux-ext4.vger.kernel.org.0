Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C850643A563
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Oct 2021 23:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbhJYVF6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 25 Oct 2021 17:05:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:38310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231339AbhJYVF5 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 25 Oct 2021 17:05:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id DCBA46105A
        for <linux-ext4@vger.kernel.org>; Mon, 25 Oct 2021 21:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635195814;
        bh=07Rjq/W2Fs6PDC6Z1JdAA7+ooTRh3T3USKA4xelgKB4=;
        h=From:To:Subject:Date:From;
        b=t6UX16fcP5M4nnHbq85/KKmcKnXgGA9xaLaUC0Jqs8ZiNjbfsUGXQv2xDEtwSiyW4
         2qV3um6qL3zHwmwiY/yjGYF4L4WowimB9u0A7zFtp8g4WmKL4NqwnDEGnIzFwmAQvJ
         MXRKUkbDZmi+Sl+8UDOfa9F11BiLU5id/TlD95uTNbGZRZoD4hmLDNrONf26O5xeA/
         WRtsKDvOpJgj4RQvFm92UGbMJ5BeQPr7VdQFqUo7C6En1SLVsZOxZaA6Dt2kGL5OMa
         slg45ps9sjHAAN1xdP88JloIArUk3lttdOs90aExm5c4rG127WcP+5zgtbk5XlfuXD
         WC+SCtDySJ4Rg==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id D870C60FC2; Mon, 25 Oct 2021 21:03:34 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 214813] New: out-of-bounds read in ext4_search_dir when
 mounting and operating on a crafted ext4 image
Date:   Mon, 25 Oct 2021 21:03:34 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: wenqingliu0120@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-214813-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D214813

            Bug ID: 214813
           Summary: out-of-bounds read in ext4_search_dir when mounting
                    and operating on a crafted ext4 image
           Product: File System
           Version: 2.5
    Kernel Version: 4.19.x
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: wenqingliu0120@gmail.com
        Regression: No

Created attachment 299313
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D299313&action=3Dedit
crafted image and poc

- Overview=20
An out-of-bounds read occurs when a crafted image is mounted and operated.=
=20

- Reproduce=20
tested on kernel 4.19.198 and 4.19.212, maybe need to run several times to
trigger the KASAN report.=20

$ mkdir mnt
$ sudo mount -t ext4 tmp725.img mnt
$ ls

or=20

$ mkdir mnt
$ sudo mount -t ext4 tmp725.img mnt
$ gcc -o poc tmp725.c
$ ./poc ./mnt

- Reason
https://elixir.bootlin.com/linux/v4.19.212/source/fs/ext4/namei.c#L1308
While loop does not check if the structure is in the range, de->name_len co=
uld
be out of bound.

- Kernel dump
[   43.949948] EXT4-fs (loop0): warning: mounting fs with errors, running
e2fsck is recommended
[   43.955000] EXT4-fs (loop0): mounted filesystem without journal. Opts:
(null)
[   46.042435] EXT4-fs error (device loop0): ext4_readdir:243: inode #2: bl=
ock
1120: comm ls: path /mnt: bad entry in directory: rec_len % 4 !=3D 0 -
offset=3D160, inode=3D724708139, rec_len=3D11051, name_len=3D43, size=3D1024
[   46.051219] EXT4-fs error (device loop0): ext4_readdir:243: inode #2: bl=
ock
1659: comm ls: path /mnt: bad entry in directory: rec_len is smaller than
minimal - offset=3D1012, inode=3D3758096384, rec_len=3D11, name_len=3D0, si=
ze=3D1024
[   46.057050]
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   46.057120] BUG: KASAN: use-after-free in ext4_search_dir+0x632/0x840
[   46.057155] Read of size 1 at addr ffff8882896db005 by task ls/905

[   46.057199] CPU: 3 PID: 905 Comm: ls Not tainted 4.19.212 #1
[   46.057200] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
1.13.0-1ubuntu1.1 04/01/2014
[   46.057203] Call Trace:
[   46.057211]  dump_stack+0x11d/0x1a9
[   46.057212]  ? switchdev_obj_size.part.3+0x13/0x13
[   46.057214]  ? printk+0x9c/0xc3
[   46.057215]  ? pm_qos_get_value.part.4+0xe/0xe
[   46.057217]  ? __find_get_block+0xb70/0xb70
[   46.057223]  print_address_description+0x70/0x360
[   46.057225]  kasan_report+0x18e/0x2e0
[   46.057226]  ? ext4_search_dir+0x632/0x840
[   46.057227]  ext4_search_dir+0x632/0x840
[   46.057229]  ? ext4_htree_fill_tree+0xb90/0xb90
[   46.057231]  ? ext4_bread_batch+0x5f/0x2c0
[   46.057232]  __ext4_find_entry+0x72f/0xfe0
[   46.057238]  ? deref_stack_reg+0xb4/0x120
[   46.057240]  ? ext4_dx_find_entry+0x3f0/0x3f0
[   46.057241]  ? memset+0x1f/0x40
[   46.057242]  ? ext4_fname_prepare_lookup+0x1a3/0x490
[   46.057245]  ? lockref_get_not_dead+0x1b6/0x340
[   46.057247]  ext4_lookup+0x3ac/0x5d0
[   46.057248]  ? ext4_resetent+0x370/0x370
[   46.057250]  ? unwind_next_frame+0x14d1/0x2330
[   46.057254]  __lookup_slow+0x1df/0x390
[   46.057255]  ? vfs_rmdir+0x380/0x380
[   46.057256]  ? link_path_walk.part.20+0x1a8/0x15d0
[   46.057258]  ? __nd_alloc_stack+0xf0/0xf0
[   46.057259]  lookup_slow+0x50/0x70
[   46.057260]  walk_component+0x7ad/0x1400
[   46.057262]  ? pick_link+0xb60/0xb60
[   46.057265]  ? __kernel_text_address+0xe/0x30
[   46.057266]  ? unwind_get_return_address+0x56/0xa0
[   46.057268]  path_lookupat+0x190/0xcf0
[   46.057269]  ? kmem_cache_alloc+0xc0/0x1c0
[   46.057271]  ? getname_flags+0xba/0x510
[   46.057272]  ? user_path_at_empty+0x1d/0x40
[   46.057273]  ? vfs_statx+0xb9/0x140
[   46.057275]  ? path_mountpoint+0xe40/0xe40
[   46.057278]  ? __check_object_size+0x28b/0x4e0
[   46.057279]  ? usercopy_abort+0x90/0x90
[   46.057280]  ? lockref_put_return+0x1b2/0x2c0
[   46.057282]  filename_lookup+0x23d/0x5c0
[   46.057283]  ? filename_parentat+0x770/0x770
[   46.057288]  ? digsig_verify+0x11b0/0x11b0
[   46.057289]  ? getname_flags+0xba/0x510
[   46.057290]  ? getname_flags+0xf8/0x510
[   46.057292]  ? vfs_statx+0xb9/0x140
[   46.057293]  vfs_statx+0xb9/0x140
[   46.057295]  ? vfs_statx_fd+0x80/0x80
[   46.057296]  ? handle_mm_fault+0x244/0x7d0
[   46.057298]  __do_sys_newlstat+0x77/0xd0
[   46.057299]  ? __do_sys_newstat+0xd0/0xd0
[   46.057301]  ? mm_fault_error+0x2e0/0x2e0
[   46.057304]  do_syscall_64+0x146/0x450
[   46.057305]  ? syscall_return_slowpath+0x2e0/0x2e0
[   46.057307]  ? do_page_fault+0x90/0x360
[   46.057308]  ? __do_page_fault+0xad0/0xad0
[   46.057309]  ? prepare_exit_to_usermode+0x210/0x210
[   46.057311]  ? recalc_sigpending+0xb2/0x1a0
[   46.057312]  ? perf_trace_sys_enter+0x1050/0x1050
[   46.057314]  ? __put_user_4+0x1c/0x30
[   46.057317]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   46.057320] RIP: 0033:0x7f4521ccf8e5
[   46.057322] Code: a9 b5 2d 00 64 c7 00 16 00 00 00 b8 ff ff ff ff c3 0f =
1f
40 00 83 ff 01 48 89 f0 77 30 48 89 c7 48 89 d6 b8 06 00 00 00 0f 05 <48> 3=
d 00
f0 ff ff 77 03 f3 c3 90 48 8b 15 71 b5 2d 00 f7 d8 64 89
[   46.057322] RSP: 002b:00007fff79570ed8 EFLAGS: 00000246 ORIG_RAX:
0000000000000006
[   46.057324] RAX: ffffffffffffffda RBX: 000055e028223130 RCX:
00007f4521ccf8e5
[   46.057325] RDX: 000055e028223148 RSI: 000055e028223148 RDI:
00007fff79570ee0
[   46.057325] RBP: 00007fff79571310 R08: 0000000000000000 R09:
0000000000000000
[   46.057326] R10: 0000000000000000 R11: 0000000000000246 R12:
00007fff79570ee0
[   46.057327] R13: 0000000000000000 R14: 0000000000000005 R15:
000055e028223148


[   46.057338] The buggy address belongs to the page:
[   46.057364] page:ffffea000a25b6c0 count:0 mapcount:0
mapping:0000000000000000 index:0x0
[   46.057465] flags: 0x17ffffc0000000()
[   46.057488] raw: 0017ffffc0000000 ffffea000a4293c8 ffffea000a487408
0000000000000000
[   46.057575] raw: 0000000000000000 0000000000000000 00000000ffffffff
0000000000000000
[   46.057628] page dumped because: kasan: bad access detected

[   46.057698] Memory state around the buggy address:
[   46.057755]  ffff8882896daf00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00=
 00
00
[   46.057826]  ffff8882896daf80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00=
 00
00
[   46.057864] >ffff8882896db000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff=
 ff
ff
[   46.057903]                    ^
[   46.057922]  ffff8882896db080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff=
 ff
ff
[   46.057961]  ffff8882896db100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff=
 ff
ff
[   46.057999]
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   46.058038] Disabling lock debugging due to kernel taint

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
