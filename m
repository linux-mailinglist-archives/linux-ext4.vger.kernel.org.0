Return-Path: <linux-ext4+bounces-2223-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E968B481D
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Apr 2024 22:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EE65281F46
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Apr 2024 20:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E753B145352;
	Sat, 27 Apr 2024 20:56:32 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3534F3BB47
	for <linux-ext4@vger.kernel.org>; Sat, 27 Apr 2024 20:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714251392; cv=none; b=cJwy0O4UJAdFXFgNW8GftBjQcGUvyOXU2BMS1oSUEpQiAlzy7W6vp81UqkVBd3Ga1kimJDuJXBKG4qgvRR01beI7WEtMIwn/1x3gxCkfFQvWXoAXOR8v2uoF8spPlIcZISFZcfZTL4aoDXL2/KcSQPpsZ6S/CsiNm/dNDluzX8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714251392; c=relaxed/simple;
	bh=SXBDt/tXhe8yHeCZSNhUdbtsnbLRFiv+J8g8wxqfyms=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HQB3e1Llre0q1hzR3sbavBQQk1WMLqgvv3dXjHDKx3aD5MAI2V1npWhHxqBN16hRmj/NQorX6hEWgjZ7K2KTmJPm6OnLYwjjuF5/h3ec9d3oeZgs7DQrJ2D5DWVAs0DJOsa+aVgA8UDtwLty4kXjC+BgheykYKJpqO/t4ZADBBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7dda529a35cso370217039f.3
        for <linux-ext4@vger.kernel.org>; Sat, 27 Apr 2024 13:56:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714251390; x=1714856190;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aph8BzeaCP77y4YkYzRI5C4FzA/l0mFEaM4HbBnRcJ4=;
        b=PARgvZvTrrUVLXD/6Y0daTavsiOtmyeYKkdR6RNkI43NOWn//BA4kTRmViqKwKBiXr
         1Y5mpFREFupG7/7EssspWOnlxdM8iHbrkC36Em1pXU/KcnIeNXfelyTBNH6p7+WdNKRt
         s++hvXI67TUNW+O7POW82zsglyjVs+rWKZsEuxkTyE93Nt+6u1+QKoIc22sNeIALJQFe
         8/rJ1MXPcuBD5fFvBsJrZ4PVz/ZRdPDtzZsuYDcRxBhLmxQCWpI2Pno1kP7sWKdE/gXg
         81gdwO6UqrygAYMj+7YZRABh/J+XSNmZbARhh87QGUsOrU3PSAa8zS8/ltyyANqBXWcO
         hjxg==
X-Forwarded-Encrypted: i=1; AJvYcCXBBbvQ2ZuKiAZWceIgIwVmICU9kpU99u++hqy6DNKauMHMIsy/RJLH6zIB58Gu3EDBk4JnHn9U1L9TggZP2GlKsRYIwZIlDw//tg==
X-Gm-Message-State: AOJu0YwLbYH1PZV2hZnPmIgMz+WdhLZnA8OCBaeBwK0GXUQ6earqsqBo
	5j2vaG6SX5CtfhYxkuvBCjiMSliVGuY0kGci1iBciGg0V8dMC0sjYvK3nYarElWEyFRYvqZDYvj
	N+7BnaqhMJOp2ETV1Cxnnj8UuOY/fEo96uOJune2m9qZ6F8EBsRcjO/Y=
X-Google-Smtp-Source: AGHT+IFli9g1nJXLITboKUO/l0E1EGDb6Ejedwh95f+Oq5z5H24DKD4rSlGEpQ2SWzqzqt8PGsCiNWpkp2Alyn4j9jGZ7a4Jkqu0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1683:b0:487:2616:534b with SMTP id
 f3-20020a056638168300b004872616534bmr512517jat.6.1714251390520; Sat, 27 Apr
 2024 13:56:30 -0700 (PDT)
Date: Sat, 27 Apr 2024 13:56:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000301d7b06171a41e3@google.com>
Subject: [syzbot] [ext4?] WARNING in __ext4_journal_start_sb
From: syzbot <syzbot+85d8bf8b2759214b194b@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6a71d2909427 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=125b5ae7180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fca646cf17cc616b
dashboard link: https://syzkaller.appspot.com/bug?extid=85d8bf8b2759214b194b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13d1eb73180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=171c9a80980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c77d21fa1405/disk-6a71d290.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/429fcd369816/vmlinux-6a71d290.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d3d8a4b85112/Image-6a71d290.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/19eeb68a57c8/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+85d8bf8b2759214b194b@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 9973 at fs/ext4/ext4_jbd2.c:73 __ext4_journal_start_sb+0x444/0x92c fs/ext4/ext4_jbd2.c:105
Modules linked in:
CPU: 0 PID: 9973 Comm: syz-executor391 Not tainted 6.9.0-rc4-syzkaller-g6a71d2909427 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
pstate: 80401005 (Nzcv daif +PAN -UAO -TCO -DIT +SSBS BTYPE=--)
pc : __ext4_journal_start_sb+0x444/0x92c fs/ext4/ext4_jbd2.c:105
lr : ext4_journal_check_start fs/ext4/ext4_jbd2.c:73 [inline]
lr : __ext4_journal_start_sb+0x440/0x92c fs/ext4/ext4_jbd2.c:105
sp : ffff80009c0474b0
x29: ffff80009c0474c0 x28: 1fffe00018de8cc7 x27: dfff800000000000
x26: 0000000070818001 x25: ffff0000c6f46638 x24: ffff0000c6f46000
x23: 0000000000000001 x22: 0000000000000000 x21: 0000000000000000
x20: ffffffffffffffe2 x19: ffff0000d9ac6280 x18: 1fffe000367b9596
x17: ffff80008ee7d000 x16: ffff800080332544 x15: 0000000000000001
x14: 1fffe0001b750b2b x13: 0000000000000000 x12: 0000000000000000
x11: ffff60001b750b2c x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000dbfe8000 x7 : ffff800080c13aac x6 : 0000000000000008
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000001 x0 : 0000000000000000
Call trace:
 __ext4_journal_start_sb+0x444/0x92c fs/ext4/ext4_jbd2.c:105
 ext4_sample_last_mounted fs/ext4/file.c:837 [inline]
 ext4_file_open+0x3c8/0x590 fs/ext4/file.c:866
 do_dentry_open+0x778/0x12b4 fs/open.c:955
 vfs_open+0x7c/0x90 fs/open.c:1089
 do_open fs/namei.c:3642 [inline]
 path_openat+0x1f6c/0x2830 fs/namei.c:3799
 do_filp_open+0x1bc/0x3cc fs/namei.c:3826
 do_sys_openat2+0x124/0x1b8 fs/open.c:1406
 do_sys_open fs/open.c:1421 [inline]
 __do_sys_openat fs/open.c:1437 [inline]
 __se_sys_openat fs/open.c:1432 [inline]
 __arm64_sys_openat+0x1f0/0x240 fs/open.c:1432
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
irq event stamp: 186
hardirqs last  enabled at (185): [<ffff800080c164c4>] seqcount_lockdep_reader_access+0x80/0x100 include/linux/seqlock.h:74
hardirqs last disabled at (186): [<ffff80008ae6da08>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:470
softirqs last  enabled at (8): [<ffff800080031848>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (6): [<ffff800080031814>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---


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

