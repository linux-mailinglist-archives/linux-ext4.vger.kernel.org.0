Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C67DD326100
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Feb 2021 11:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbhBZKKB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 26 Feb 2021 05:10:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:34584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231248AbhBZKHz (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 26 Feb 2021 05:07:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id C524764EF3
        for <linux-ext4@vger.kernel.org>; Fri, 26 Feb 2021 10:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614334033;
        bh=3/0ysBfhwJu/2srKV3Povw6dvjWXH2t1fCWJdiGA+ko=;
        h=From:To:Subject:Date:From;
        b=O37aQEq3raPwo45Xjf+e3N43ct0ogRvFKCL4zcqZhI52fft6zi2JTcbkgxJUuzwQh
         qX8joNXW/azY3RbWT6CuzwoUkQ1FTDP5kNO6R8KlDov/CsaTCCK8OpZ0V8DpyvQ8dx
         VFVNXo7lbuJo23YQMjJYNva+LvWh0NVPM1IewQRUlLkEOYRmS8msJgzsxqsw9vcQbt
         vY0hnlpV+1CDKNBc6tReO9dmbplQieHaJjgcooA5lzBWVfGBbyLNiTti8Lx2aebevE
         LmBeDfTBVIVKM9krmivFPj+Bqgz8nTSP1mp9qtM8o4U1AaehxT85/WX+cojkIte8uH
         craVCgxqY1OLw==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id B3DCE61479; Fri, 26 Feb 2021 10:07:13 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 211951] New: WARNING: CPU: 1 PID: 304 at fs/ext4/xattr.c:1643
 ext4_xattr_set_entry+0x30e2/0x3830
Date:   Fri, 26 Feb 2021 10:07:13 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ieatmuttonchuan@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-211951-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D211951

            Bug ID: 211951
           Summary: WARNING: CPU: 1 PID: 304 at fs/ext4/xattr.c:1643
                    ext4_xattr_set_entry+0x30e2/0x3830
           Product: File System
           Version: 2.5
    Kernel Version: 5.11.0-rc7+
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: ieatmuttonchuan@gmail.com
        Regression: No

Created attachment 295469
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D295469&action=3Dedit
poc C file

Hello,
I found a bug in kernel version 5.11.0-rc7+.
This is the POC.
1.Git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
2.Build kernel with CONFIG_KASAN
3.Run kernel with qemu
```
qemu-system-x86_64 \
        -m 1G \
        -smp 2 \
        -kernel bzImage \
        -append "console=3DttyS0 root=3D/dev/sda earlyprintk=3Dserial net.i=
fnames=3D0"
\
        -drive file=3Dstretch.img,format=3Draw \
        -net user,host=3D10.0.2.10,hostfwd=3Dtcp:127.0.0.1:1569-:22 \
        -net nic,model=3De1000 \
        -nographic \
        -enable-kvm
```
4.Compile POC and scp into qemu.
```
gcc ext4_xattr_set_entry.c -static -lpthread
scp -P 1569 a.out root@localhost:~
```
5.Run a.out you will see the dump log.
```

root@syzkaller:~# ./a.out=20
[  486.694922] audit: type=3D1400 audit(1614070631.830:8): avc:  denied  {
execmem } for  pid=3D304 comm=3D"a.out" scontext=3Dsystem_u:system_r:kernel=
_t:s0
tcontext=3Dsystem_u:system_r:kernel_t:s0 tclass=3Dprocess permissive=3D1
[  486.722208] loop0: detected capacity change from 264192 to 0
[  486.843227] EXT4-fs (loop0): mounted filesystem without journal. Opts:
,errors=3Dcontinue. Quota mode: writeback.
[  486.861494] ext4 filesystem being mounted at /root/file0 supports timest=
amps
until 2038 (0x7fffffff)
[  486.913838] EXT4-fs error (device loop0): ext4_mb_generate_buddy:805: gr=
oup
0, block bitmap and bg descriptor inconsistent: 16384 vs 96 free clusters
[  486.943689] ------------[ cut here ]------------
[  486.945105] WARNING: CPU: 1 PID: 304 at fs/ext4/xattr.c:1643
ext4_xattr_set_entry+0x30e2/0x3830
[  486.947416] Modules linked in:
[  486.947843] CPU: 1 PID: 304 Comm: a.out Not tainted 5.11.0-rc7+ #1
[  486.949327] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.10.2-1ubuntu1 04/01/2014
[  486.949759] RIP: 0010:ext4_xattr_set_entry+0x30e2/0x3830
[  486.951395] Code: 41 bf e4 ff ff ff eb 05 e8 6b 05 9a ff 49 be 00 00 00 =
00
00 fc ff df 48 8b 2c 24 48 8b 5c 24 68 e9 ae fd ff ff e8 4e 05 9a ff <0f> 0=
b e9
9a d6 ff ff 4c 89 ff 4c 89 e6 e8 2c 33 df ff 49 8d 7c 24
[  486.953382] RSP: 0018:ffff88800391f718 EFLAGS: 00000293
[  486.953738] RAX: ffffffff86437212 RBX: 0000000000000000 RCX:
ffff888005cb3800
[  486.955205] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
0000000000000000
[  486.955575] RBP: 1ffff11000723f5e R08: ffffffff864348a5 R09:
ffff88800391f650
[  486.955887] R10: ffffffff88a00000 R11: ffffffff88a00539 R12:
ffff88800391faf0
[  486.957305] R13: ffff88800648d020 R14: dffffc0000000000 R15:
ffff8880063c46d0
[  486.957623] FS:  0000000001b34880(0000) GS:ffff888036100000(0000)
knlGS:0000000000000000
[  486.959148] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  486.959438] CR2: 000055d6a8190d50 CR3: 00000000018f2000 CR4:
00000000000006e0
[  486.959806] Call Trace:
[  486.961343]  ? __kmalloc+0x144/0x250
[  486.961686]  ? ext4_xattr_block_set+0x77/0x3c50
[  486.963081]  ext4_xattr_block_set+0x38b/0x3c50
[  486.963448]  ? ext4_xattr_ibody_find+0x21b/0x9a0
[  486.963788]  ext4_xattr_set_handle+0xfc9/0x2160
[  486.965249]  ext4_xattr_set+0x1d8/0x310
[  486.965548]  ? ext4_xattr_user_get+0xf0/0xf0
[  486.965851]  __vfs_setxattr+0x3ac/0x3f0
[  486.967224]  __vfs_setxattr_noperm+0x11e/0x4c0
[  486.967594]  vfs_setxattr+0x17e/0x310
[  486.967879]  setxattr+0x122/0x230
[  486.969245]  ? finish_task_switch+0x2b7/0x620
[  486.969539]  ? __schedule+0xbfb/0x1180
[  486.969818]  ? _cond_resched+0x59/0x80
[  486.971180]  ? mnt_want_write+0x226/0x3c0
[  486.971476]  path_setxattr+0x109/0x1c0
[  486.971765]  __x64_sys_setxattr+0xb7/0xd0
[  486.973147]  do_syscall_64+0x33/0x40
[  486.973430]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  486.973801] RIP: 0033:0x453029
[  486.975399] Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 =
89
f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3=
d 01
f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
[  486.977118] RSP: 002b:00007ffc5aaa2ea8 EFLAGS: 00000283 ORIG_RAX:
00000000000000bc
[  486.977512] RAX: ffffffffffffffda RBX: 0000000000400418 RCX:
0000000000453029
[  486.977809] RDX: 0000000000000000 RSI: 0000000020000180 RDI:
00000000200000c0
[  486.979180] RBP: 00007ffc5aaa2eb0 R08: 0000000000000000 R09:
0000000000407390
[  486.979487] R10: 0000000000000000 R11: 0000000000000283 R12:
0000000000407430
[  486.979778] R13: 0000000000000000 R14: 00000000006be018 R15:
0000000000000000
[  486.981281] ---[ end trace 7f5c731c1068f005 ]---
*/
```

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
