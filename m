Return-Path: <linux-ext4+bounces-6993-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9325CA736D2
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Mar 2025 17:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B1F77A56E1
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Mar 2025 16:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2151A3159;
	Thu, 27 Mar 2025 16:27:27 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162BB19F111
	for <linux-ext4@vger.kernel.org>; Thu, 27 Mar 2025 16:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743092847; cv=none; b=AxCpaUH9sxsBxgcsrUEex+fG/MG61VE+BONsE22yWGZeB33bmCIsHIwPh9g7nDCHNWrJj6nS7BelebUIM3jDatNic0eJlxg+zRJgkN2noZdl/SgmrwcBOWU9CEge4G2IsCNn93VKMy7gkkhVu3Kd5fzYkSPWPXH3VlRmeSWykKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743092847; c=relaxed/simple;
	bh=gxcp3C3RjkXJaaC/Gq4nuv6aUM+LeFK+geRX1psd+wc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nXCD/u+Q3gUd4elYD68QUjevsmuX9wrT9hgFc8DDU2/MeNIzcvam4wEW/Uvr25NkG0+hagioeBdYPcpQpOXZS00fJFMTHG4jDTUmVLDlRJWXMCXGaSbWFwCx9hxWpq2j+RnpATcDijir4B1IPeo6YoMheNDJlVhkp2uJnVOkzJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3d2a63dc62aso10973625ab.2
        for <linux-ext4@vger.kernel.org>; Thu, 27 Mar 2025 09:27:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743092845; x=1743697645;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OD7xtORABi7RIXnIds+9tXzGC7tz09BXcSsAmRi5wqI=;
        b=fq70N1VbQdeSDyrBwWXJQgFONjwULEiRnoJRLp/fNPQJARuIj8IWxLtYBPVlRCML06
         TxqwmMmbDaYy5XS08tHMZ60ZNcAqSk/HhqM9nXhixdwjAqY5ny9MrpxT2bxxpsbwqRwZ
         rRVH0MzL9v1918zngczsdyoSFW6qv33MYYl8OyvcdotOUeTKzV/m+ci/Jfv4kltNsONw
         TGMCgr1fdc1JnCpsPs54d09KhsD+mxw1FjcK+FxvtgLNZTmNPZqJBAFVRg0l1XZ2UZYP
         PaRGZDL0ph2rZZwX6mu49czpeM7FIKx2NQcAMzfWWbkUhui4oLQQ9Pz661jR0lryQKrF
         myFw==
X-Forwarded-Encrypted: i=1; AJvYcCUMjyKmMQbITjYoVlrpyOGZk6pL8sR2vJ9OfrbHZVl4SuujXm/iXTn/79X1NHJGqfx68RbS8yaQqr1J@vger.kernel.org
X-Gm-Message-State: AOJu0YziSVTefu6JX9vrLKr76UpviMajddI2mkG/HK5cDzWJtlYflJgB
	0rSZv0t2WC9gHIb0UGS4SFizav4l0l41aWuYLgZcVGl3sQVHt8EZxrF0G7P3tvb8rmotm1HSfqL
	EXnvGtUhNbp7DsvK+31iesYCpssGr6xeRKyxML+84phUwIrcB7qE4gTY=
X-Google-Smtp-Source: AGHT+IEJfI9e1HRFH+GUnqGFLUYoPPiiOTxANSYwe6DrVEIn2Z8ZWFqD/KyHs3EjRcofJ4xmsCy3keGV8QHX4ytxg+LX3fIzOFr1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2192:b0:3d3:ddb3:fe4e with SMTP id
 e9e14a558f8ab-3d5ccdd7400mr46355105ab.13.1743092844997; Thu, 27 Mar 2025
 09:27:24 -0700 (PDT)
Date: Thu, 27 Mar 2025 09:27:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e57c6c.050a0220.2f068f.0037.GAE@google.com>
Subject: [syzbot] [ext4?] kernel BUG in ext4_alloc_file_blocks
From: syzbot <syzbot+d14b2bea87fe2aaffa3b@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    38fec10eb60d Linux 6.14
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14e2c804580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d09c42ff97b8ce6d
dashboard link: https://syzkaller.appspot.com/bug?extid=d14b2bea87fe2aaffa3b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12e2c804580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16548bb0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cbcaba398075/disk-38fec10e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7fb19649d944/vmlinux-38fec10e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3481a0b0218e/bzImage-38fec10e.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/47937005d435/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=13d1a43f980000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d14b2bea87fe2aaffa3b@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/ext4/extents.c:4487!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 UID: 0 PID: 5851 Comm: syz-executor285 Not tainted 6.14.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
RIP: 0010:ext4_alloc_file_blocks+0xeb5/0xec0 fs/ext4/extents.c:4487
Code: b0 ff e9 86 f3 ff ff 44 89 e9 80 e1 07 fe c1 38 c1 0f 8c d3 f3 ff ff 4c 89 ef e8 96 16 b0 ff e9 c6 f3 ff ff e8 6c 5e 4b ff 90 <0f> 0b e8 14 ac 8a 09 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc9000409fae0 EFLAGS: 00010293
RAX: ffffffff82768104 RBX: 0000000000000000 RCX: ffff888034465a00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000409fca0 R08: ffffffff827673ea R09: 1ffff1100f07400a
R10: dffffc0000000000 R11: ffffed100f07400b R12: ffff8880783a02b0
R13: 0000000000000003 R14: 0000000000000011 R15: 0000004210000000
FS:  00007f6218e926c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055db3ed07680 CR3: 000000007c366000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ext4_zero_range+0x48a/0xd70 fs/ext4/extents.c:4637
 ext4_fallocate+0x54a/0x1ea0 fs/ext4/extents.c:4787
 vfs_fallocate+0x623/0x7a0 fs/open.c:338
 ksys_fallocate fs/open.c:362 [inline]
 __do_sys_fallocate fs/open.c:367 [inline]
 __se_sys_fallocate fs/open.c:365 [inline]
 __x64_sys_fallocate+0xbc/0x110 fs/open.c:365
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6218efc939
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 81 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6218e92218 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffda RBX: 00007f6218f836d8 RCX: 00007f6218efc939
RDX: 0000000000000002 RSI: 0000000000000010 RDI: 0000000000000004
RBP: 00007f6218f836d0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000007fff R11: 0000000000000246 R12: 00007f6218f5089c
R13: 0000200000001000 R14: 0000200000000000 R15: 0000200000000f80
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ext4_alloc_file_blocks+0xeb5/0xec0 fs/ext4/extents.c:4487
Code: b0 ff e9 86 f3 ff ff 44 89 e9 80 e1 07 fe c1 38 c1 0f 8c d3 f3 ff ff 4c 89 ef e8 96 16 b0 ff e9 c6 f3 ff ff e8 6c 5e 4b ff 90 <0f> 0b e8 14 ac 8a 09 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc9000409fae0 EFLAGS: 00010293
RAX: ffffffff82768104 RBX: 0000000000000000 RCX: ffff888034465a00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000409fca0 R08: ffffffff827673ea R09: 1ffff1100f07400a
R10: dffffc0000000000 R11: ffffed100f07400b R12: ffff8880783a02b0
R13: 0000000000000003 R14: 0000000000000011 R15: 0000004210000000
FS:  00007f6218e926c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6210aff000 CR3: 000000007c366000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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

