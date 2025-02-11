Return-Path: <linux-ext4+bounces-6414-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E674A3110D
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Feb 2025 17:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98C283A7A33
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Feb 2025 16:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FD225D532;
	Tue, 11 Feb 2025 16:15:26 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E2B25C714
	for <linux-ext4@vger.kernel.org>; Tue, 11 Feb 2025 16:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739290526; cv=none; b=khBL80jRzi4iEHxanL0XF2JTqF8e5Vj89bf/09YvkFDCCq1dgotZdT2qyl7FksipP9mgghwWTrsHHR2SPA2j2DITs4QCwpvTvmPzDrLS08+qVI+wbRHJ27yp/dimrnYaFseqUur5kcZPgEgp2Lqob/soVsRysMaEtMZrKS6Lnvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739290526; c=relaxed/simple;
	bh=e1pk72SxKOhapoX8qJ+Uk/spfCY696+SmOkoPWZo678=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=K/m5SlPy76a/Ynf4W1+MuActnPgxGBr+oMyXfDkTAMxeScw++dV43zQXbS8lInC0YPhu6J+IZdaZvrLLtyY3uFxujz5gMtuiTDsEANffN2hGR8QnPGQL3ixK6IbGzVQ72b0QaA+y91tF8FnwLAgTH3zkksJezbF3EmSXTbbJ66o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3d145b7ba54so29924795ab.2
        for <linux-ext4@vger.kernel.org>; Tue, 11 Feb 2025 08:15:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739290523; x=1739895323;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gPRawepaneW3X1fdtYnCTmIOgGgCVUpC1k1hSEscb48=;
        b=jVeQgsfJkrOSQtlAM2VwLIRhAQvRT4qff4AE0qzHqMZvnIIh8qT44vBgUsyaT7KEFz
         pruQXGhOqOb0f4L4JAAoZ+10y7AXHH3u5RZ3JQuQdBbf4juhm5TPX36XBcHA8TLnhE+O
         UPutpKvSZimkMdqO8QiFE0JkTXqHWIOp/tSoQCOuEawb0BLKs3eWEi1p6Rl2HtrORyTk
         X+Na10kRgAx1LTRCQuIgBwqacWXf3OnKIHZzScGyLRKPL1ewOjg6N59ymqvR05wYlQ1m
         G5dfJZwjrg1iBpK9UhHlNI2R0mVou2GUWOxdUqZl363Pbcx7LlPYXR7qpxB9dLWwUjhR
         byZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGBTA+3YaJB7LU+dNcSq0oeizavw3E2bPPg2Knhek5DJj+pdcs4Liwwu6vXE5/J5HXajXYj2iEXdUP@vger.kernel.org
X-Gm-Message-State: AOJu0YwHGID+oSxlSOf7un1jXRWlbufcvKshjCd14diZvIM6fMlP1gPk
	NWvcYqAoDGjY3HUFALwLqAHAFpJLUQ0Q9vxVVy0aEXQTs2ukdZPOIPQraoxG69qDE06kNPmez9g
	SQ0/YiLo+lX/IqDdGdMJrd5X10QiCZyj+J/e8AmWCperJJLkwDS6h63Q=
X-Google-Smtp-Source: AGHT+IGNOcLK1hiNTmGN9BF7BHdWpcIdWRdXMMQQjqLZ1fThahAXIofvpivf1mYHPwMvzMLubNxt7G5FocZqfPW5k417h4Gxs3we
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:214a:b0:3d0:124d:99e8 with SMTP id
 e9e14a558f8ab-3d13dd5ebaamr131887695ab.13.1739290523341; Tue, 11 Feb 2025
 08:15:23 -0800 (PST)
Date: Tue, 11 Feb 2025 08:15:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67ab779b.050a0220.3d72c.0064.GAE@google.com>
Subject: [syzbot] [ext4?] WARNING in __ext4_iget
From: syzbot <syzbot+2ff67872645e5b5ebdd5@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, brauner@kernel.org, jack@suse.cz, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mjguzik@gmail.com, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot found the following issue on:

HEAD commit:    7ee983c850b4 Merge tag 'drm-fixes-2025-02-08' of https://g.=
.
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D107e4bdf980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dec3c160c5cabe70=
b
dashboard link: https://syzkaller.appspot.com/bug?extid=3D2ff67872645e5b5eb=
dd5
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Deb=
ian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D12d1e1b058000=
0
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D14f1ddf8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/52091eb5b16c/disk-=
7ee983c8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4aa605b3aa80/vmlinux-=
7ee983c8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/af16dc4bb19a/bzI=
mage-7ee983c8.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/115f05fb40e2=
/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=3D10=
f1ddf8580000)

The issue was bisected to:

commit 37d11cfc63604b3886308e2111d845d148ced8bc
Author: Mateusz Guzik <mjguzik@gmail.com>
Date:   Tue Feb 4 21:32:07 2025 +0000

    vfs: sanity check the length passed to inode_set_cached_link()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D12073df85800=
00
final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D11073df85800=
00
console output: https://syzkaller.appspot.com/x/log.txt?x=3D16073df8580000

IMPORTANT: if you fix the issue, please add the following tag to the commit=
:
Reported-by: syzbot+2ff67872645e5b5ebdd5@syzkaller.appspotmail.com
Fixes: 37d11cfc6360 ("vfs: sanity check the length passed to inode_set_cach=
ed_link()")

------------[ cut here ]------------
bad length passed for symlink [/tmp/syz-imagegen2884317625/=08] (got 39, ex=
pected 29)
WARNING: CPU: 0 PID: 5828 at ./include/linux/fs.h:802 inode_set_cached_link=
 include/linux/fs.h:802 [inline]
WARNING: CPU: 0 PID: 5828 at ./include/linux/fs.h:802 __ext4_iget+0x3aa2/0x=
4310 fs/ext4/inode.c:5012
Modules linked in:
CPU: 0 UID: 0 PID: 5828 Comm: syz-executor385 Not tainted 6.14.0-rc1-syzkal=
ler-00181-g7ee983c850b4 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 12/27/2024
RIP: 0010:inode_set_cached_link include/linux/fs.h:802 [inline]
RIP: 0010:__ext4_iget+0x3aa2/0x4310 fs/ext4/inode.c:5012
Code: e8 63 19 49 ff c6 05 e9 1a da 0d 01 90 8b 95 10 ff ff ff 44 89 e1 48 =
c7 c7 40 4b 85 8b 48 8b b5 f8 fe ff ff e8 8f 57 09 ff 90 <0f> 0b 90 90 e9 2=
d fd ff ff e8 30 57 ab ff e9 f6 e6 ff ff e8 06 56
RSP: 0018:ffffc90003ca7810 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff888077bd8ca4 RCX: ffffffff817a1159
RDX: ffff888034e01e00 RSI: ffffffff817a1166 RDI: 0000000000000001
RBP: ffffc90003ca7960 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: 000000000000001d
R13: 0000000000000000 R14: 0000000000002000 R15: ffff888077bd8c98
FS:  00005555696a5380(0000) GS:ffff8880b8600000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555696be778 CR3: 00000000743ae000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 ext4_lookup+0x37e/0x730 fs/ext4/namei.c:1813
 __lookup_slow+0x252/0x470 fs/namei.c:1793
 lookup_slow fs/namei.c:1810 [inline]
 walk_component+0x350/0x5b0 fs/namei.c:2114
 lookup_last fs/namei.c:2612 [inline]
 path_lookupat+0x17f/0x770 fs/namei.c:2636
 filename_lookup+0x221/0x5f0 fs/namei.c:2665
 user_path_at+0x3a/0x60 fs/namei.c:3072
 ksys_umount fs/namespace.c:2071 [inline]
 __do_sys_umount fs/namespace.c:2079 [inline]
 __se_sys_umount fs/namespace.c:2077 [inline]
 __x64_sys_umount+0x10b/0x1a0 fs/namespace.c:2077
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd6ca0f8487
Code: 07 00 48 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f =
1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff f=
f 77 01 c3 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffd3ce25b68 EFLAGS: 00000202 ORIG_RAX: 00000000000000a6
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fd6ca0f8487
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffd3ce25c20
RBP: 00007ffd3ce25c20 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000202 R12: 00007ffd3ce26d10
R13: 00005555696b6740 R14: 0000000000000001 R15: 431bde82d7b634db
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisectio=
n

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

