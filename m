Return-Path: <linux-ext4+bounces-4073-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 533DF96E8BB
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Sep 2024 06:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D78F51F24DB6
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Sep 2024 04:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC3F481B7;
	Fri,  6 Sep 2024 04:42:24 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC68288D1
	for <linux-ext4@vger.kernel.org>; Fri,  6 Sep 2024 04:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725597744; cv=none; b=shHrqgA2QtqLuogsyXXf5cKWS3Nvr81Dw1YK3kuHu5Tq4YjBDvRQ4seGumVnAot9SaLzOxdHXxcrFWUdAMSXuPJ4XFoCVyUVifeD3zJHUQB3JJVzRqBADJ/S4sy7v8XPWHKR8gyeU4SlVcl8XJPQ7pjTwhibc/yEHtirz34XsGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725597744; c=relaxed/simple;
	bh=8s+oOxx5ssUWHxVXDokW4RWXHhacBXeahdPj6QskBaA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=saJcIXnnPL1LHPpftePk2Dcasoj2/e3NBFVH1MPGOwSBGPLgrKarD+ewySTD4U7XE+MCVNczDLe2SJ0WAYwiLxefQd4NDfdYEGTTskWzWa7MT+kXx0dIBIZfEII7vqteMoIfajth6cb8kIjKO4Nusx2NzaPdYDwvOqrPsBsq6oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a04c88a379so32399885ab.1
        for <linux-ext4@vger.kernel.org>; Thu, 05 Sep 2024 21:42:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725597742; x=1726202542;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s5bilHsINcGF1THEmQ4wk6GrqSctQxwFBuM4E7VFf5M=;
        b=kxkJGnT7XbLh+CxaaM8p721whVPbLIvH8iUedQRYpibuVsPboLqgN2V9g9yWLn+wrC
         wwQjuSIBbWM+a3wpVeoxnAYva5zg5YZ6QLTRqWqulvlB34/mISLZreZY2RaafU2odHIR
         dlhBWo/+nWjaXASnGm5dcrpn3pwp4Ffgt2tLdyBqWDLxJ+3BRNNqd/fthg06Trg47SPy
         Vk9x+kSR4MN/bwGAgNAoTZ4hAnqV2/ULMV1tM/kKt3117pEY7WFRR2Z8btyMsZEX2E95
         Aapq+psqgTupQrjn//jDTfTaAl3i5ZspqMc4ESMNLuA9itLc1izAa9ntTN3C72/SaLNT
         IPZg==
X-Forwarded-Encrypted: i=1; AJvYcCWTM2qRNO0sJ2rqL1vT5fAtncJlQ86kIkn/ZuRbt+zhoLm5guiTxqLzaDsBaG7QTq2PKdtqiCs7al0r@vger.kernel.org
X-Gm-Message-State: AOJu0YwBkPFoWgtpbItSyBlDu6HUrXtgsxWr4kX5g4v09++UIGVe76EU
	cgPX6O4i0+XOm43uoUMC4KIM01IekyoD8H/nh4NV4azokTDce2lIZ+V5E5VviCgbZaJ7p0jaUMe
	Q70IKPXbQH12j/DCwWf5Yip7BcKYWkVmD50TcfxM99BScPA+RgZM1sK4=
X-Google-Smtp-Source: AGHT+IHF9VTBJ0eQiepHBOwWmRYPW4IT/JqBH3AAi1xqCv2qyV9bP33fg8ZFnp0IUBa+6UeG+RAw8W3kC2w95pBYxBO1xvJUCZ2V
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b27:b0:39f:559b:d0d4 with SMTP id
 e9e14a558f8ab-3a04f0ea774mr103995ab.3.1725597741696; Thu, 05 Sep 2024
 21:42:21 -0700 (PDT)
Date: Thu, 05 Sep 2024 21:42:21 -0700
In-Reply-To: <000000000000f4847d061f24861b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006b5d4e06216c08a6@google.com>
Subject: Re: [syzbot] [ext4?] kernel BUG in ext4_mb_use_inode_pa (2)
From: syzbot <syzbot+d79019213609e7056a19@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    ad618736883b Merge tag 'platform-drivers-x86-v6.11-6' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14fc4397980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=660f6eb11f9c7dc5
dashboard link: https://syzkaller.appspot.com/bug?extid=d79019213609e7056a19
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16691fdb980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1067bd97980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-ad618736.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5d2517f4cb56/vmlinux-ad618736.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0979c5ca28c2/bzImage-ad618736.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/043e7c757d36/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d79019213609e7056a19@syzkaller.appspotmail.com

EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode: none.
loop0: detected capacity change from 512 to 64
------------[ cut here ]------------
kernel BUG at fs/ext4/mballoc.c:4689!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5093 Comm: syz-executor323 Not tainted 6.11.0-rc6-syzkaller-00075-gad618736883b #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:ext4_mb_use_inode_pa+0x690/0x700 fs/ext4/mballoc.c:4689
Code: 40 1d b0 8e 4c 89 e6 48 89 ea e8 fb c5 8b 02 e9 be fc ff ff e8 f1 05 33 ff 90 0f 0b e8 e9 05 33 ff 90 0f 0b e8 e1 05 33 ff 90 <0f> 0b e8 d9 05 33 ff 90 0f 0b 48 8b 0c 24 80 e1 07 80 c1 03 38 c1
RSP: 0018:ffffc90002cde8e8 EFLAGS: 00010293
RAX: ffffffff826086cf RBX: 00000000fffffffe RCX: ffff88801edf2440
RDX: 0000000000000000 RSI: 0000000000000041 RDI: 000000000000003f
RBP: 0000000000000000 R08: ffffffff826083cf R09: 1ffff11003fcbd4e
R10: dffffc0000000000 R11: ffffed1003fcbd4f R12: ffff88801fe5ea88
R13: 1ffff110025a4181 R14: 0000000000000041 R15: 1ffff11003fcbd51
FS:  000055557d5ee380(0000) GS:ffff88801fe00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000002000f000 CR3: 0000000000b5c000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ext4_mb_use_preallocated+0x680/0x1420 fs/ext4/mballoc.c:4906
 ext4_mb_new_blocks+0x6ef/0x4e30 fs/ext4/mballoc.c:6210
 ext4_alloc_branch fs/ext4/indirect.c:340 [inline]
 ext4_ind_map_blocks+0x1084/0x2a10 fs/ext4/indirect.c:635
 ext4_map_blocks+0x9f6/0x1d20 fs/ext4/inode.c:654
 mpage_map_one_extent fs/ext4/inode.c:2237 [inline]
 mpage_map_and_submit_extent fs/ext4/inode.c:2290 [inline]
 ext4_do_writepages+0x1605/0x3d40 fs/ext4/inode.c:2753
 ext4_writepages+0x213/0x3c0 fs/ext4/inode.c:2842
 do_writepages+0x35d/0x870 mm/page-writeback.c:2683
 filemap_fdatawrite_wbc+0x125/0x180 mm/filemap.c:397
 __filemap_fdatawrite_range mm/filemap.c:430 [inline]
 file_write_and_wait_range+0x1aa/0x290 mm/filemap.c:788
 generic_buffers_fsync_noflush+0x73/0x170 fs/buffer.c:600
 ext4_fsync_nojournal fs/ext4/fsync.c:88 [inline]
 ext4_sync_file+0x413/0xb90 fs/ext4/fsync.c:151
 generic_write_sync include/linux/fs.h:2822 [inline]
 ext4_buffered_write_iter+0x286/0x350 fs/ext4/file.c:305
 ext4_file_write_iter+0x1de/0x1a10
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xa72/0xc90 fs/read_write.c:590
 ksys_pwrite64 fs/read_write.c:705 [inline]
 __do_sys_pwrite64 fs/read_write.c:715 [inline]
 __se_sys_pwrite64 fs/read_write.c:712 [inline]
 __x64_sys_pwrite64+0x1aa/0x230 fs/read_write.c:712
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2de5ebcc59
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdfe577c58 EFLAGS: 00000246 ORIG_RAX: 0000000000000012
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f2de5ebcc59
RDX: 000000000000fdef RSI: 0000000020000140 RDI: 0000000000000006
RBP: 00007f2de5f305f0 R08: 000055557d5ef4c0 R09: 000055557d5ef4c0
R10: 000000000000fecc R11: 0000000000000246 R12: 00007ffdfe577c80
R13: 00007ffdfe577ea8 R14: 431bde82d7b634db R15: 00007f2de5f0503b
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ext4_mb_use_inode_pa+0x690/0x700 fs/ext4/mballoc.c:4689
Code: 40 1d b0 8e 4c 89 e6 48 89 ea e8 fb c5 8b 02 e9 be fc ff ff e8 f1 05 33 ff 90 0f 0b e8 e9 05 33 ff 90 0f 0b e8 e1 05 33 ff 90 <0f> 0b e8 d9 05 33 ff 90 0f 0b 48 8b 0c 24 80 e1 07 80 c1 03 38 c1
RSP: 0018:ffffc90002cde8e8 EFLAGS: 00010293
RAX: ffffffff826086cf RBX: 00000000fffffffe RCX: ffff88801edf2440
RDX: 0000000000000000 RSI: 0000000000000041 RDI: 000000000000003f
RBP: 0000000000000000 R08: ffffffff826083cf R09: 1ffff11003fcbd4e
R10: dffffc0000000000 R11: ffffed1003fcbd4f R12: ffff88801fe5ea88
R13: 1ffff110025a4181 R14: 0000000000000041 R15: 1ffff11003fcbd51
FS:  000055557d5ee380(0000) GS:ffff88801fe00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000002000f000 CR3: 0000000000b5c000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

