Return-Path: <linux-ext4+bounces-9848-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B73BEB4988D
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Sep 2025 20:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A20617A3262
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Sep 2025 18:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F85131C575;
	Mon,  8 Sep 2025 18:45:33 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28132E1746
	for <linux-ext4@vger.kernel.org>; Mon,  8 Sep 2025 18:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757357133; cv=none; b=dBOi/a4Rn6Jv5TMGFEbhdw7y0TUivILpDm2y+IBHIu80h07KS82OlAsY7GP5OdHe/BzbpA15KTxxm4+rmq3xsCIB2/wlq9C3WpLRnh+JQBmUtBT5ubocYspIyYn/LzlHKdl82w/i5SjAIf5oAfyGqVEx3O4eqva/KmrxrbFCNro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757357133; c=relaxed/simple;
	bh=75f6wh5I0VzGYY0aHRtlH9tSHeadLrguK0DZmTzOgVc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HNxVkvfSMZn2l/+pXRxzEl3GB4EftFCrzxSNC3pjNRtswMcHxZJ0tX5QZqjm88rGPKW8qWfSQv1kvO0MapNxoaN4kW8uaaOipuhb9mN9xg6IianP3kKbLeqoGjBr/z03Fn2pJu7pGA0d0fLMfIB1PcM3JbZo+PBGUilc7+8FbaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-4048726387fso52216555ab.1
        for <linux-ext4@vger.kernel.org>; Mon, 08 Sep 2025 11:45:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757357131; x=1757961931;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0BYpbNj94Ojs8b5h4+Yv8Gr1eSotCP4HbUumdYPAAoY=;
        b=Zd5G01Q+n92TYRlVOpbh0yy8f2rEKIa5LudrRmvycmpnqbcdNXEcxq2ZaZ62LLXLDF
         7uQoU2gnPVVwLVKV/l8/QbHIRENm/3WKrNMRTzRLdJrugFum8qyY22dLQuYPm74isCYH
         sUKMywN1/lLPNKX8C5zBMfIVSu6q2VwNP7bBm1ktGOQgSk88AnwwCKzbvyzwmHc5rYgb
         bFIrSXDI2+aAKSoBfUIUZJNR96QrCLZRdNgMdwUCPJ0nOs9V04YNe8ZlZJw/Yz2nAjcU
         meayY973Jy2CwbVYKCgqEhncv2e2Cxq6ZzWIUnKEawc0uhpBUpFVwwkUkTabnhr7+eej
         6/pA==
X-Forwarded-Encrypted: i=1; AJvYcCWbBaPWLOcZ9etRUh5DCTqnGsHgnBmExbAd34sFvPo4Aaj5xoOjc3vdtpgRWVtQ2BcpVrKeg5mdJ0I6@vger.kernel.org
X-Gm-Message-State: AOJu0YzwQs1F4oqV03sky/qoo2E7bFzde5n7O7IJttF8CjkXTa761BOi
	/1PSEmQQLQmY4DcbGqLBTqhYca+TBRy2yTFamLNNVaOhtt4wfUn2N4LXGci/LvldaX/OOzkHQWC
	RzCMigyDCv12uMzY0ZB9s/H7undvJOrjqDIm1mWNW4c+rPClTElxU2vWgX2Q=
X-Google-Smtp-Source: AGHT+IEK42zR8SiAURm5964soSiT50Cu6mxHG3e2DKnwf8R1xNwacwNFbovAXCL3TNOYUMvwm1EmQrN6AEqDV3VpCHYgYLTSy7aX
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1487:b0:3f6:609d:1855 with SMTP id
 e9e14a558f8ab-3fd8925cb22mr129479185ab.31.1757357130805; Mon, 08 Sep 2025
 11:45:30 -0700 (PDT)
Date: Mon, 08 Sep 2025 11:45:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68bf244a.050a0220.192772.0883.GAE@google.com>
Subject: [syzbot] [mm?] [ext4?] WARNING in ext4_init_orphan_info
From: syzbot <syzbot+0b92850d68d9b12934f5@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, apopple@nvidia.com, byungchul@sk.com, 
	david@redhat.com, gourry@gourry.net, joshua.hahnjy@gmail.com, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	matthew.brost@intel.com, rakie.kim@sk.com, syzkaller-bugs@googlegroups.com, 
	ying.huang@linux.alibaba.com, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    76eeb9b8de98 Linux 6.17-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12ca0934580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=429771c55b615e85
dashboard link: https://syzkaller.appspot.com/bug?extid=0b92850d68d9b12934f5
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=168d2562580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15869562580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/eee687cc7d76/disk-76eeb9b8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4062cd7a7107/vmlinux-76eeb9b8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3bcb5a03c247/bzImage-76eeb9b8.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/7e09a33c999c/mount_0.gz
  fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=140df312580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0b92850d68d9b12934f5@syzkaller.appspotmail.com

EXT4-fs: Warning: mounting with data=journal disables delayed allocation, dioread_nolock, O_DIRECT and fast_commit support!
EXT4-fs (loop0): encrypted files will use data=ordered instead of data journaling mode
------------[ cut here ]------------
WARNING: CPU: 0 PID: 6103 at mm/page_alloc.c:5124 __alloc_frozen_pages_noprof+0x2c8/0x370 mm/page_alloc.c:5124
Modules linked in:
CPU: 0 UID: 0 PID: 6103 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:__alloc_frozen_pages_noprof+0x2c8/0x370 mm/page_alloc.c:5124
Code: 74 10 4c 89 e7 89 54 24 0c e8 24 e2 0c 00 8b 54 24 0c 49 83 3c 24 00 0f 85 a5 fe ff ff e9 a6 fe ff ff c6 05 a6 ac f6 0c 01 90 <0f> 0b 90 e9 18 ff ff ff a9 00 00 08 00 48 8b 4c 24 10 4c 8d 44 24
RSP: 0018:ffffc900047676a0 EFLAGS: 00010246
RAX: ffffc90004767600 RBX: 000000000000000e RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffc90004767708
RBP: ffffc900047677a0 R08: ffffc90004767707 R09: 0000000000000000
R10: ffffc900047676e0 R11: fffff520008ecee1 R12: 0000000000000000
R13: 1ffff920008eced8 R14: 0000000000040cc0 R15: dffffc0000000000
FS:  000055556bfce500(0000) GS:ffff8881268bf000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f54f6aba6b0 CR3: 000000003b292000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 alloc_pages_mpol+0xd1/0x380 mm/mempolicy.c:2416
 ___kmalloc_large_node+0x5f/0x1b0 mm/slub.c:4317
 __kmalloc_large_node_noprof+0x18/0x90 mm/slub.c:4348
 __do_kmalloc_node mm/slub.c:4364 [inline]
 __kmalloc_noprof+0x27a/0x430 mm/slub.c:4388
 kmalloc_noprof include/linux/slab.h:909 [inline]
 kmalloc_array_noprof include/linux/slab.h:948 [inline]
 ext4_init_orphan_info+0x2b7/0xc70 fs/ext4/orphan.c:592
 __ext4_fill_super fs/ext4/super.c:5590 [inline]
 ext4_fill_super+0x55ef/0x60b0 fs/ext4/super.c:5728
 get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1692
 vfs_get_tree+0x8f/0x2b0 fs/super.c:1815
 do_new_mount+0x2a2/0x9e0 fs/namespace.c:3808
 do_mount fs/namespace.c:4136 [inline]
 __do_sys_mount fs/namespace.c:4347 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4324
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbc7ab6038a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffed38a5318 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffed38a53a0 RCX: 00007fbc7ab6038a
RDX: 0000200000000040 RSI: 00002000000001c0 RDI: 00007ffed38a5360
RBP: 0000200000000040 R08: 00007ffed38a53a0 R09: 0000000000000c04
R10: 0000000000000c04 R11: 0000000000000246 R12: 00002000000001c0
R13: 00007ffed38a5360 R14: 0000000000000448 R15: 0000200000000580
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

