Return-Path: <linux-ext4+bounces-3722-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 588D5950D8E
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Aug 2024 22:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 120B0287159
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Aug 2024 20:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B791A4F2B;
	Tue, 13 Aug 2024 20:05:34 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143BAA953
	for <linux-ext4@vger.kernel.org>; Tue, 13 Aug 2024 20:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723579533; cv=none; b=sOSFGTb6PAAI0EqaGzXNLSMedhe0EfyJ0Qafki8kkAoc/+VV2fLO5c06A0uXSBgrWzDgfU6cpuZlUXDrsZO0wAqLP86iIzIYF8HBv+lVllZ2ySzRqHRl0QJM1w79bnYD0TgNM0VGQ+2RacPAZxIbVw4nBSpY32WOeO4jaqWZql8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723579533; c=relaxed/simple;
	bh=I6KwcpM6Y8DRIcGSbPchhTfdkTfQ37eZ1jQhX7yTa/k=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=iih9SDaeydk6co9xvfn5Qm7GdLKARwf3IlZRxVGImqS99cnpW35M3h4jKcCFI01QxgZv7V1Rcy7ESyrERyu5U+iuDNXOsARkirjGchNEqXPrz6ljDXXfBQWOsbE3Dl+/BSDd5YjF2hOxbA2YLXxfw6guvx3qbfFgs0D4VEIo8VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-81f8e43f0c1so723434639f.3
        for <linux-ext4@vger.kernel.org>; Tue, 13 Aug 2024 13:05:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723579531; x=1724184331;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NefdGqxMuJwAbyUAoYcgGnRpHLr4ojz2P9HUr90xHy0=;
        b=dW3wMzE56JCYx53wh/wtmQuqCbQCuhT8vJ26R47+0q5lS1cQbzSHN3aKwNAcjbv7tg
         ys5bWdND8Ps28zp4fQvh/0TGY8eTMrKDvb5j9Zm6g/25IdEDdY02xpmklunB0SDSN8no
         xFDx7a2SOQl28vMSk5/ihOhxK9VNPNtjHShmWm2eiprNhF0Faz8wdBBJ6gRpDceIi/OD
         QYpXBa4hIfhWvOdOUEJNu2gUJL5n59Z3pLvCXF06Tc32ZbT3SxteCDdu8Wt/oBBVVkKI
         jrg8aXCvdWivYpwNRgz9sVVR2UwHLZ2Pwanrv9ZvZU0jYHjHt0nildg7b6U7jVzBoG+k
         dfrg==
X-Forwarded-Encrypted: i=1; AJvYcCVLoZmfR/ZBdIw1oa8sJAc3fnV4YfhguOqhSYay++A96eFbM3H5FjGYmy3cAzGYn7O2D8i/ktN7cW82fmVlqYrMqCCLs5ZQGZsL5A==
X-Gm-Message-State: AOJu0YzsCjWHW6INFa+/lqO6ZkfLx1EeKnpL3dhneR+inIUl74eE7PKe
	vrEcSv6ZPIygUVjOrflOgsN+gadgp8UNfLvzET8Rr1uyhnQL9G44DWAAmkS34oSeRgmzls+w+y4
	XY69seyuoltzE91Aij3pYZJy4tS1nsNhGf/b7E+9oiQOihAbWhMpTy9o=
X-Google-Smtp-Source: AGHT+IFngvkaje5JeHTAeg2y9Use1ldCLVQScaZXGJLwjmezHiN2GxvCov4F/G1+zWS9pchwHIC++BnUyyLQrK361NKT147KatNn
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:138c:b0:396:1fc1:7034 with SMTP id
 e9e14a558f8ab-39d123ca3cbmr591335ab.0.1723579531106; Tue, 13 Aug 2024
 13:05:31 -0700 (PDT)
Date: Tue, 13 Aug 2024 13:05:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b1b164061f96213d@google.com>
Subject: [syzbot] [ext4?] divide error in ext4_mb_regular_allocator
From: syzbot <syzbot+1ad8bac5af24d01e2cbd@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, jack@suse.cz, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ee9a43b7cfe2 Merge tag 'net-6.11-rc3' of git://git.kernel...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1655c15d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9358cc4a2e37fd30
dashboard link: https://syzkaller.appspot.com/bug?extid=1ad8bac5af24d01e2cbd
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15a8fbc9980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17bc726d980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e6062f24de48/disk-ee9a43b7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5d3ec6153dbd/vmlinux-ee9a43b7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/98dbabb91d02/bzImage-ee9a43b7.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/4dd4c0acf870/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/ca52271baf46/mount_1.gz

The issue was bisected to:

commit 1f6bc02f18489b9c9ea39b068d0695fb0e4567e9
Author: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Date:   Fri Dec 15 11:19:50 2023 +0000

    ext4: fallback to complex scan if aligned scan doesn't work

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=118a3d11980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=138a3d11980000
console output: https://syzkaller.appspot.com/x/log.txt?x=158a3d11980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1ad8bac5af24d01e2cbd@syzkaller.appspotmail.com
Fixes: 1f6bc02f1848 ("ext4: fallback to complex scan if aligned scan doesn't work")

EXT4-fs: Ignoring removed oldalloc option
EXT4-fs (loop0): re-mounted 00000000-0000-0000-0000-000000000000 r/w. Quota mode: none.
Oops: divide error: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 UID: 0 PID: 5224 Comm: syz-executor196 Not tainted 6.11.0-rc2-syzkaller-00111-gee9a43b7cfe2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:ext4_mb_regular_allocator+0x1687/0x3b80 fs/ext4/mballoc.c:2932
Code: 16 00 00 8b 1a bf 40 00 00 00 89 de e8 e2 ab 38 ff 48 83 fb 3f 0f 87 9f 19 00 00 e8 93 a7 38 ff 89 d9 49 d3 ec 4c 89 f8 31 d2 <49> f7 f4 48 89 d3 31 ff 48 89 d6 e8 59 ac 38 ff 83 bc 24 64 01 00
RSP: 0018:ffffc9000341e740 EFLAGS: 00010246
RAX: 0000000000000001 RBX: 0000000000000004 RCX: 0000000000000004
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000040
RBP: ffffc9000341e9f0 R08: ffffffff825acf3e R09: ffffffff825bea62
R10: 0000000000000005 R11: ffff8880282b1e00 R12: 0000000000000000
R13: 0000000000000003 R14: ffff8880663270e0 R15: 0000000000000001
FS:  0000555592670380(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe13f0d000 CR3: 0000000025072000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ext4_mb_new_blocks+0x10a8/0x4e30 fs/ext4/mballoc.c:6219
 ext4_ext_map_blocks+0x1c74/0x77b0 fs/ext4/extents.c:4318
 ext4_map_blocks+0xa5e/0x1d20 fs/ext4/inode.c:652
 _ext4_get_block+0x239/0x6b0 fs/ext4/inode.c:794
 ext4_get_block_unwritten+0x2f/0x100 fs/ext4/inode.c:827
 __block_write_begin_int+0x50c/0x1a70 fs/buffer.c:2125
 ext4_try_to_write_inline_data+0x7ed/0x1360 fs/ext4/inline.c:739
 ext4_write_begin+0x2a0/0x10e0 fs/ext4/inode.c:1172
 ext4_da_write_begin+0x300/0xa70 fs/ext4/inode.c:2943
 generic_perform_write+0x399/0x840 mm/filemap.c:4019
 ext4_buffered_write_iter+0xc6/0x350 fs/ext4/file.c:299
 ext4_file_write_iter+0x1de/0x1a10
 do_iter_readv_writev+0x60a/0x890
 vfs_writev+0x37c/0xbb0 fs/read_write.c:971
 do_pwritev fs/read_write.c:1072 [inline]
 __do_sys_pwritev2 fs/read_write.c:1131 [inline]
 __se_sys_pwritev2+0x1ca/0x2d0 fs/read_write.c:1122
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb9c91a61d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe13f0c6c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000148
RAX: ffffffffffffffda RBX: 00007fb9c91ef095 RCX: 00007fb9c91a61d9
RDX: 000000000000000f RSI: 00000000200002c0 RDI: 0000000000000004
RBP: 0031656c69662f2e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000a12 R11: 0000000000000246 R12: 70756f7267647362
R13: 7461785f72657375 R14: 431bde82d7b634db R15: 00007fb9c91ef03b
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ext4_mb_regular_allocator+0x1687/0x3b80 fs/ext4/mballoc.c:2932
Code: 16 00 00 8b 1a bf 40 00 00 00 89 de e8 e2 ab 38 ff 48 83 fb 3f 0f 87 9f 19 00 00 e8 93 a7 38 ff 89 d9 49 d3 ec 4c 89 f8 31 d2 <49> f7 f4 48 89 d3 31 ff 48 89 d6 e8 59 ac 38 ff 83 bc 24 64 01 00
RSP: 0018:ffffc9000341e740 EFLAGS: 00010246
RAX: 0000000000000001 RBX: 0000000000000004 RCX: 0000000000000004
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000040
RBP: ffffc9000341e9f0 R08: ffffffff825acf3e R09: ffffffff825bea62
R10: 0000000000000005 R11: ffff8880282b1e00 R12: 0000000000000000
R13: 0000000000000003 R14: ffff8880663270e0 R15: 0000000000000001
FS:  0000555592670380(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe13f0d000 CR3: 0000000025072000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	00 00                	add    %al,(%rax)
   2:	8b 1a                	mov    (%rdx),%ebx
   4:	bf 40 00 00 00       	mov    $0x40,%edi
   9:	89 de                	mov    %ebx,%esi
   b:	e8 e2 ab 38 ff       	call   0xff38abf2
  10:	48 83 fb 3f          	cmp    $0x3f,%rbx
  14:	0f 87 9f 19 00 00    	ja     0x19b9
  1a:	e8 93 a7 38 ff       	call   0xff38a7b2
  1f:	89 d9                	mov    %ebx,%ecx
  21:	49 d3 ec             	shr    %cl,%r12
  24:	4c 89 f8             	mov    %r15,%rax
  27:	31 d2                	xor    %edx,%edx
* 29:	49 f7 f4             	div    %r12 <-- trapping instruction
  2c:	48 89 d3             	mov    %rdx,%rbx
  2f:	31 ff                	xor    %edi,%edi
  31:	48 89 d6             	mov    %rdx,%rsi
  34:	e8 59 ac 38 ff       	call   0xff38ac92
  39:	83                   	.byte 0x83
  3a:	bc 24 64 01 00       	mov    $0x16424,%esp


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

