Return-Path: <linux-ext4+bounces-5435-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4164E9DB283
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Nov 2024 06:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE978166995
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Nov 2024 05:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C09713B780;
	Thu, 28 Nov 2024 05:37:26 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA48712C7FD
	for <linux-ext4@vger.kernel.org>; Thu, 28 Nov 2024 05:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732772246; cv=none; b=gD3yfO9y6GD3SK0A+g4zjhA1/7Gy6+LJKj19JTvj3MbGZ0+vVcjWWnvjk2+/Fcbv06B9VdNozR0IAmmZa8byK5wEk2Ym9hPU3XqSP2vCa86Pn43H+Fdh/rdkv1K7wegnBwkN0+NMdGKXkL0cnDh/uP38050yq3XPYmaQQzDEsm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732772246; c=relaxed/simple;
	bh=I0fWGtRYkrk71ug5Z5vT0Z9EtDi9G71hOV/nq8reRD4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=AJ5XRzSxV7W67mz8wSHyVuZ35qaczPH3m4sqV51FwQq2r5Xp0kT64zVJANyKi0ttDzoodkkHgoYLaZbiaAk0o2KEUBdeq5wBcpkgnF7wNkYCGqBWFyUvIZ5XtftbCOdBYe+0xzeWTmeJ6LnA8eRQCFBdFwmor/glrNh01GOfHYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a78e952858so4584835ab.3
        for <linux-ext4@vger.kernel.org>; Wed, 27 Nov 2024 21:37:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732772244; x=1733377044;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z/Aeo78pYxl1DJJesHxrCd5dfR7WVwjSchzygaVTFbM=;
        b=O7N33IZX63XwCCcFt47kLrcPRq06bt/lJUncUgzSL+IGz8T94Yr8boHAJY1kJJTt2y
         p4HEv2rAbyMGc0FKupnH8x9qk8eaFFZyuAQPgGq/kJMowJXGCT6qrxa/ZRjYy69s3Alv
         NqLdmDU+fUmvsI/KMjIWSW9TYn9BtpU6UqB3ym5WEIB/7eHzCV5yCRB3zvebCpETVvX3
         TdPWzvPj2VymAKq76HhNWEUXwnMS67nnqL8rn2dRpJqJcRlnpd4SloklC9HX9XglQOIZ
         Gp8Ocvynr6KPRSTItPiLYbp08aAdbnuk/elUuBfZDPsJ5Cebji9EFtgKUB/KOThM+aVW
         udcw==
X-Forwarded-Encrypted: i=1; AJvYcCWnmBo0vyKtEbIPj0pX5DuvZnStJ5MR3bJHGAdr3VZY50CcNJRudoncp4dshLR16E8EUkC7KKtwGq/R@vger.kernel.org
X-Gm-Message-State: AOJu0YyU2OLWdlMJZjo1Pk5m2Xa2xCVCEn2Qy3eVfDohvEwfeemSavJA
	RwnkOx5cpsxdaqwNr0xosnq/z/TPAIDQhKm86QfEIZO/n2LTs6BYAORmUDNZ4OCU8VGWMHW3vdl
	1I3IZhRBTbK3CCGSiEFsqxVmgRt9jglaNHYSsCcUZsh+fiijBgqpSmbo=
X-Google-Smtp-Source: AGHT+IEWPYyxD9EO0mGxxvRLOUDwes72Or4cilDb2il/HYQsAUdTOlHiEsM0UvEWTTS01yZOvxicABaMAOLEDxlFGCSKvhaKkODb
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1785:b0:3a7:8040:5962 with SMTP id
 e9e14a558f8ab-3a7c5445eb6mr66056225ab.0.1732772243891; Wed, 27 Nov 2024
 21:37:23 -0800 (PST)
Date: Wed, 27 Nov 2024 21:37:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67480193.050a0220.253251.0071.GAE@google.com>
Subject: [syzbot] [ext4?] WARNING: locking bug in jbd2_alloc
From: syzbot <syzbot+92b9109f47b38b1a6657@syzkaller.appspotmail.com>
To: jack@suse.com, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9f16d5e6f220 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11fe76e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e92fc420ca55fe33
dashboard link: https://syzkaller.appspot.com/bug?extid=92b9109f47b38b1a6657
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c9f905470542/disk-9f16d5e6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5b4c9cc530ec/vmlinux-9f16d5e6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e0f262e4c35e/bzImage-9f16d5e6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+92b9109f47b38b1a6657@syzkaller.appspotmail.com

loop2: detected capacity change from 0 to 32768
JBD2: Ignoring recovery information on journal
ocfs2: Mounting device (7,2) on (node local, slot 0) with ordered data mode.
------------[ cut here ]------------
Looking for class "lock" with key init_kmem_cache_cpus.__key, but found a different class "&c->lock" with the same key
WARNING: CPU: 1 PID: 6128 at kernel/locking/lockdep.c:939 look_up_lock_class+0xdc/0x170 kernel/locking/lockdep.c:936
Modules linked in:
CPU: 1 UID: 0 PID: 6128 Comm: syz.2.25 Not tainted 6.12.0-syzkaller-09073-g9f16d5e6f220 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:look_up_lock_class+0xdc/0x170 kernel/locking/lockdep.c:936
Code: 01 0f 85 8a 00 00 00 c6 05 68 74 47 04 01 90 49 8b 16 49 8b 76 18 48 8b 8b b8 00 00 00 48 c7 c7 00 fa 0a 8c e8 b5 9c 97 f5 90 <0f> 0b 90 90 eb 61 90 e8 58 cc ea f8 e8 53 f7 b6 f5 48 c7 c7 40 f9
RSP: 0018:ffffc90004e25dd0 EFLAGS: 00010046
RAX: e7d07740ab1e6700 RBX: ffffffff93c329a0 RCX: 0000000000080000
RDX: ffffc9000c6f9000 RSI: 0000000000007ed7 RDI: 0000000000007ed8
RBP: ffffc90004e25ee0 R08: ffffffff815687d2 R09: 1ffff110170e519a
R10: dffffc0000000000 R11: ffffed10170e519b R12: ffffe8ffffd7fbf0
R13: ffffe8ffffd7fbf0 R14: ffffe8ffffd7fbf0 R15: ffffffff9a41b310
FS:  00007fe17797a6c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b3181fffc CR3: 000000005d318000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 register_lock_class+0x102/0x980 kernel/locking/lockdep.c:1290
 __lock_acquire+0xf3/0x2100 kernel/locking/lockdep.c:5101
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
 local_lock_acquire+0x20/0x80 include/linux/local_lock_internal.h:29
 ___slab_alloc+0x11e2/0x14b0 mm/slub.c:3867
 __slab_alloc+0x58/0xa0 mm/slub.c:3908
 __slab_alloc_node mm/slub.c:3961 [inline]
 slab_alloc_node mm/slub.c:4122 [inline]
 kmem_cache_alloc_noprof+0x1c1/0x2a0 mm/slub.c:4141
 jbd2_alloc+0x155/0x1b0 fs/jbd2/journal.c:2787
 jbd2_journal_get_undo_access+0x1d1/0x310 fs/jbd2/transaction.c:1395
 __ocfs2_journal_access+0x4de/0x8a0 fs/ocfs2/journal.c:692
 ocfs2_block_group_set_bits+0x29e/0x9a0 fs/ocfs2/suballoc.c:1387
 ocfs2_search_chain+0x1b27/0x26d0 fs/ocfs2/suballoc.c:1900
 ocfs2_claim_suballoc_bits+0x11ef/0x2570 fs/ocfs2/suballoc.c:1985
 __ocfs2_claim_clusters+0x332/0xa40 fs/ocfs2/suballoc.c:2395
 ocfs2_claim_clusters fs/ocfs2/suballoc.c:2432 [inline]
 ocfs2_block_group_alloc_contig fs/ocfs2/suballoc.c:432 [inline]
 ocfs2_block_group_alloc fs/ocfs2/suballoc.c:699 [inline]
 ocfs2_reserve_suballoc_bits+0x1161/0x4eb0 fs/ocfs2/suballoc.c:832
 ocfs2_reserve_new_metadata_blocks+0x41c/0x9c0 fs/ocfs2/suballoc.c:982
 ocfs2_mknod+0x143a/0x2b40 fs/ocfs2/namei.c:345
 ocfs2_create+0x1ab/0x480 fs/ocfs2/namei.c:672
 lookup_open fs/namei.c:3649 [inline]
 open_last_lookups fs/namei.c:3748 [inline]
 path_openat+0x1c03/0x3590 fs/namei.c:3984
 do_filp_open+0x27f/0x4e0 fs/namei.c:4014
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1402
 do_sys_open fs/open.c:1417 [inline]
 __do_sys_open fs/open.c:1425 [inline]
 __se_sys_open fs/open.c:1421 [inline]
 __x64_sys_open+0x225/0x270 fs/open.c:1421
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe176b7e819
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe17797a038 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007fe176d35fa0 RCX: 00007fe176b7e819
RDX: 0000000000000000 RSI: 0000000000145142 RDI: 0000000020000240
RBP: 00007fe176bf175e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fe176d35fa0 R15: 00007fff9fb5c5d8
 </TASK>


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

