Return-Path: <linux-ext4+bounces-4816-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 562659B1B90
	for <lists+linux-ext4@lfdr.de>; Sun, 27 Oct 2024 02:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE232B214F0
	for <lists+linux-ext4@lfdr.de>; Sun, 27 Oct 2024 00:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2AE15684;
	Sun, 27 Oct 2024 00:58:30 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FA723BE
	for <linux-ext4@vger.kernel.org>; Sun, 27 Oct 2024 00:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729990710; cv=none; b=l+3GRBBYrdOP/+nqNMj8KZcrxQJ7a+Qymhby/cwbc9k9xkgALxNDQyrtogbmWPxiWECGSGQX/9esr5vivZqhvI3pTAOO4XVGRBizfBKQG5ao7f10DtrKVvluZWrRVeqppXVkIkvhVrVPd95WeZJYjHIBIFX/dzkr+H0EN1MmlG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729990710; c=relaxed/simple;
	bh=YUflqTEDF478+/tVdjYU/hndAhkuvnd3Jee6k5XghIU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DUblx1sZGis497/abpRka2bVqDtb/87RxcgmIvGWpisXHwJ1rp7+kkCtqTkuzATiA7stfuQFz9wGUeFYxMgwSYqdW4TqdzThHYo89kux0bhp2LXN+fx/2Exhc1vlu9YGCS/V9Y95Et6cfJT+Ntg1B2zCGDlcwFkgSo/1X9091nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a4ee7817b3so7183375ab.0
        for <linux-ext4@vger.kernel.org>; Sat, 26 Oct 2024 17:58:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729990706; x=1730595506;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zCL32huj2tEQgWp9QyjlZAa5uxxuNjYCzTXjgBkvUqk=;
        b=WYM7LKCNX6koU9MvEA78sDlxM5006yZp6AH7Rq2HXOJ2oPitg0OzQaO64Pe9URPGFk
         /GsMhQPEOEjsoollx/grg488Tr2FY5ZhhD8q3MIMFrqr3pureQWw26JQ9f3wzFHkkkBB
         S8cYKpivYpIvTR3/TCvx4NLfIMmXrRU8HuW8xbl+7+WZ32sPQhZ9nBXw2kc04kOipN8g
         p1FoMy3UyGHuBSTmN9KuAmVl6QHTh+RfyrnNX3PFXvUYZf7L/hHXKOZcy9nCyWDwhw/W
         DRvhfaKNKQ9zaLcjt5ds2DqpIw5a2CmcEJyCFVUtf155SgEW7BCg7BXwcZS6hkfBiUnq
         TqvQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+gLOC7f3QyzpfqVMk/ExbcPbYnstfYtlahv+7jiy0leei4Eao7MhPbESk0lbaMGub/cip0jyuDvWl@vger.kernel.org
X-Gm-Message-State: AOJu0YxEcKNW6A9N7I0zPI7g2QHCJ8ipC/k2HOPxeKbRpB3gMM8Ts4de
	LgOgaqCeGTCrRuXuamGugsEXea/Q+LpQaFtL0TPMtvOfK2uUd5p+WURtt3RCWfEoptxlDWb98mV
	IemIbmOVbhyD0n/VvAavwwnvSZ95px9fDsjJAmL9Ww/OBkx/BiW/sAXY=
X-Google-Smtp-Source: AGHT+IGXhn82YV0dmIo+zmshyYrslIAGHRXBdFel3FZKNPHHRyZU1MVZUW8qa7i2QXtgrsJXq7CudCPnQfFuajlZ+jiQIJTrceEQ
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e8:b0:3a3:b4ec:b3ea with SMTP id
 e9e14a558f8ab-3a4ed2f4abfmr30417365ab.16.1729990706521; Sat, 26 Oct 2024
 17:58:26 -0700 (PDT)
Date: Sat, 26 Oct 2024 17:58:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671d9032.050a0220.2fdf0c.0231.GAE@google.com>
Subject: [syzbot] [ext4?] WARNING: locking bug in ext4_mb_add_groupinfo (2)
From: syzbot <syzbot+883742a0b3b485018df5@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    526116b79e8c KVM: arm64: Shave a few bytes from the EL2 id..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=15cf0c30580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e39b0b4b1ace5bc0
dashboard link: https://syzkaller.appspot.com/bug?extid=883742a0b3b485018df5
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2f7b2b08fdad/disk-526116b7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b69595b63015/vmlinux-526116b7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/39fd415ada60/Image-526116b7.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+883742a0b3b485018df5@syzkaller.appspotmail.com

loop4: detected capacity change from 0 to 2048
------------[ cut here ]------------
Looking for class "c->lock" with key init_kmem_cache_cpus.__key, but found a different class "&c->lock" with the same key
WARNING: CPU: 0 PID: 7531 at kernel/locking/lockdep.c:939 look_up_lock_class+0xec/0x160 kernel/locking/lockdep.c:936
Modules linked in:
CPU: 0 UID: 0 PID: 7531 Comm: syz.4.213 Not tainted 6.12.0-rc4-syzkaller-g526116b79e8c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : look_up_lock_class+0xec/0x160 kernel/locking/lockdep.c:936
lr : look_up_lock_class+0xec/0x160 kernel/locking/lockdep.c:936
sp : ffff8000a1546ec0
x29: ffff8000a1546ec0 x28: dfff800000000000 x27: 0000000000000000
x26: ffff800097322640 x25: ffff800097322000 x24: 0000000000000001
x23: 0000000000000000 x22: 1ffff00011f000ba x21: ffff8000973833d0
x20: fffffdffbf6e2360 x19: ffff800092df5330 x18: 0000000000000008
x17: 2c79656b5f5f2e73 x16: ffff8000830c7d0c x15: 0000000000000001
x14: 1fffe000366c74e2 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000040000 x10: 000000000000e48f x9 : 4747ec9eeb91e600
x8 : 4747ec9eeb91e600 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff8000a15465f8 x4 : ffff80008f8ed8a0 x3 : ffff80008062a854
x2 : 0000000000000001 x1 : 0000000100000001 x0 : 0000000000000000
Call trace:
 look_up_lock_class+0xec/0x160 kernel/locking/lockdep.c:936 (P)
 look_up_lock_class+0xec/0x160 kernel/locking/lockdep.c:936 (L)
 register_lock_class+0x8c/0x6b4 kernel/locking/lockdep.c:1290
 __lock_acquire+0x18c/0x77c8 kernel/locking/lockdep.c:5077
 lock_acquire+0x240/0x728 kernel/locking/lockdep.c:5825
 local_lock_acquire+0x3c/0x98 include/linux/local_lock_internal.h:29
 ___slab_alloc+0xcd0/0xf4c mm/slub.c:3867
 __slab_alloc+0x74/0xd0 mm/slub.c:3908
 __slab_alloc_node mm/slub.c:3961 [inline]
 slab_alloc_node mm/slub.c:4122 [inline]
 kmem_cache_alloc_noprof+0x26c/0x354 mm/slub.c:4141
 ext4_mb_add_groupinfo+0x5b8/0xdc4 fs/ext4/mballoc.c:3356
 ext4_mb_init_backend fs/ext4/mballoc.c:3435 [inline]
 ext4_mb_init+0x107c/0x1ff4 fs/ext4/mballoc.c:3733
 __ext4_fill_super fs/ext4/super.c:5512 [inline]
 ext4_fill_super+0x4b48/0x57c8 fs/ext4/super.c:5686
 get_tree_bdev+0x320/0x470 fs/super.c:1635
 ext4_get_tree+0x28/0x38 fs/ext4/super.c:5718
 vfs_get_tree+0x90/0x28c fs/super.c:1800
 do_new_mount+0x278/0x900 fs/namespace.c:3507
 path_mount+0x590/0xe04 fs/namespace.c:3834
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4055 [inline]
 __se_sys_mount fs/namespace.c:4032 [inline]
 __arm64_sys_mount+0x45c/0x5a8 fs/namespace.c:4032
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
irq event stamp: 4990
hardirqs last  enabled at (4989): [<ffff800080a12d48>] seqcount_lockdep_reader_access+0x6c/0xd4 include/linux/seqlock.h:74
hardirqs last disabled at (4990): [<ffff800080a2fa14>] ___slab_alloc+0xca4/0xf4c mm/slub.c:3867
softirqs last  enabled at (4320): [<ffff80008003084c>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (4318): [<ffff800080030818>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
EXT4-fs (loop4): mounted filesystem 00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode: none.


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

