Return-Path: <linux-ext4+bounces-14577-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAwIMWY0p2k9fwAAu9opvQ
	(envelope-from <linux-ext4+bounces-14577-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Tue, 03 Mar 2026 20:20:06 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 677C61F5E28
	for <lists+linux-ext4@lfdr.de>; Tue, 03 Mar 2026 20:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 416B2307C9DE
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Mar 2026 19:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4C939659E;
	Tue,  3 Mar 2026 19:19:37 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2121739656F
	for <linux-ext4@vger.kernel.org>; Tue,  3 Mar 2026 19:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772565577; cv=none; b=YXrM2TD4Tl9x+FeenFgyVHXVF/tCSk/X9z4lgpg9k2ceOfShY0kpQe+dKNkOI08PU2uPYSn0dkTMrW6pn8bbKCda3SrAkDIbccYWpJII9KtS10kfkTcM3MDRPNQYEumnfchq2nkydizu1phPVUVjHlSAyM/m1gEkU9fGZ3tY3ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772565577; c=relaxed/simple;
	bh=Z/Ii9CniBRHk23b/zMxRSoA1SGewDyFifdBQAs84En0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hYj1TuOx0DzhN0vWQmBpXG7/+RCIPHuWkLLNIXoGf8+oT9DzE6WMwplOW4GsIEuFWbPI/W9yP0S3X6xY0PTOL7dDKraI990YAQ6d1rMwyRCZGquz2UC8p85PHyWMUkC7qkKE9UdbXlJAdQCAlVGW8yFae841a8Ox54G1ruiDpWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-663019e3e05so39281861eaf.3
        for <linux-ext4@vger.kernel.org>; Tue, 03 Mar 2026 11:19:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772565575; x=1773170375;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+Qe1W6KkrIcUagLnQbxWlrMY3cGxaZHtnEdoD9tGUY=;
        b=puG8trvA5l0a61JTgId+2IBBPUDe8uGbpoxKjuxcUrlrLa43n+1h90GSFhMol1s3MM
         DRn7HjfTvKaaLS85WtB1KcmBEzPxmcEe02uZr+GUdLtj4HyWRF6LpM8PrRonFRdir11S
         N4unZSSmExDJX+7DikvKnmt6n2jTBYb0vKT/A45BVyKHoLOeemF/8SC0qjyj5fx1LmXb
         q6Y1d1Gu4eVqzzlc2PifpOrNLzjqRBgCr1y2ulxiX1qCFRVJ1K6B4YvKirctCJzbRwlz
         mN3A7t0I33vCwo6WONlysrJGDIXBliwB6I2NR/YIVcsBUqmCTmozS4DyVdyevszVahPd
         V6aw==
X-Forwarded-Encrypted: i=1; AJvYcCWbDI/sr5Io5BMpKDAt+Eabg69U0wSbeMCZKPvoaziaNEtpU6cRFKCKZlh26Y4s6IWX0qKOD36tgiAg@vger.kernel.org
X-Gm-Message-State: AOJu0YykwJGaXUZ7DfvpLAmgefamWfZbsu0XKB0KrKd3AnM7DibaNQw0
	CYrqToshvN2urMkdrov2rugk7fUrVe6AJfhecdubfw7cjk2iG/YvjuwkAwly3OvcWsI0cpM+3+y
	wKdqI8TKOBHLsK6OPVboYijY09Um52462GxpMPKPAMwRfQrEDYH4tjmm9iZI=
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:edcc:0:b0:679:e8fd:6a7d with SMTP id
 006d021491bc7-679faf0a2e3mr9456915eaf.49.1772565575118; Tue, 03 Mar 2026
 11:19:35 -0800 (PST)
Date: Tue, 03 Mar 2026 11:19:35 -0800
In-Reply-To: <6989419b.050a0220.3b3015.0065.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69a73447.a70a0220.b118c.0012.GAE@google.com>
Subject: Re: [syzbot] [ext4?] kernel BUG in ext4_es_cache_extent (4)
From: syzbot <syzbot+ccf1421545dbe5caa20c@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 677C61F5E28
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=779072223d02a312];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14577-lists,linux-ext4=lfdr.de,ccf1421545dbe5caa20c];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,storage.googleapis.com:url,syzkaller.appspot.com:url]
X-Rspamd-Action: no action

syzbot has found a reproducer for the following issue on:

HEAD commit:    af4e9ef3d784 uaccess: Fix scoped_user_read_access() for 'p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13811b5a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=779072223d02a312
dashboard link: https://syzkaller.appspot.com/bug?extid=ccf1421545dbe5caa20c
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1620e552580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13810a02580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f6b75c8f432f/disk-af4e9ef3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4513ad566789/vmlinux-af4e9ef3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f7eea878db42/bzImage-af4e9ef3.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/8d81a7f0b7b8/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=1351b006580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ccf1421545dbe5caa20c@syzkaller.appspotmail.com

EXT4-fs warning (device loop0): ext4_es_cache_extent:1082: inode #15: comm syz.0.36: ES cache extent failed: add [0,1,177,0x1] conflict with existing [0,1,113,0x2]
EXT4-fs warning (device loop0): ext4_es_cache_extent:1082: inode #15: comm syz.0.36: ES cache extent failed: add [1,15,177,0x1] conflict with existing [1,35,576460752303423487,0x18]
EXT4-fs warning (device loop0): ext4_es_cache_extent:1082: inode #15: comm syz.0.36: ES cache extent failed: add [16,1,177,0x1] conflict with existing [1,35,576460752303423487,0x18]
EXT4-fs warning (device loop0): ext4_es_cache_extent:1082: inode #15: comm syz.0.36: ES cache extent failed: add [17,10,177,0x1] conflict with existing [1,35,576460752303423487,0x18]
------------[ cut here ]------------
kernel BUG at fs/ext4/extents_status.c:1044!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 6062 Comm: syz.0.36 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
RIP: 0010:ext4_es_cache_extent+0x875/0x9e0 fs/ext4/extents_status.c:1044
Code: e1 07 80 c1 03 38 c1 0f 8c 5c fe ff ff 48 8b 7c 24 18 e8 fe ac ad ff e9 4d fe ff ff e8 a4 6e 43 ff 90 0f 0b e8 9c 6e 43 ff 90 <0f> 0b 65 8b 1d e6 98 99 10 bf 07 00 00 00 89 de e8 c6 72 43 ff 83
RSP: 0018:ffffc90003456d20 EFLAGS: 00010293
RAX: ffffffff82822744 RBX: 0000000000000018 RCX: ffff88803155bd00
RDX: 0000000000000000 RSI: 000000000000001b RDI: 0000000000000018
RBP: ffffc90003456e68 R08: ffffc90003456dd7 R09: ffffc90003456dc0
R10: dffffc0000000000 R11: fffff5200068adbb R12: ffffc90003456dc0
R13: 000000000000001b R14: 000000000000000f R15: dffffc0000000000
FS:  00007fbdae25d6c0(0000) GS:ffff888125464000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbdad3e9e80 CR3: 00000000781f0000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 ext4_cache_extents fs/ext4/extents.c:539 [inline]
 __read_extent_tree_block+0x4b4/0x890 fs/ext4/extents.c:586
 ext4_find_extent+0x76f/0xcc0 fs/ext4/extents.c:939
 ext4_ext_map_blocks+0x283/0x58b0 fs/ext4/extents.c:4261
 ext4_map_create_blocks+0x11d/0x540 fs/ext4/inode.c:616
 ext4_map_blocks+0x7cd/0x11d0 fs/ext4/inode.c:809
 _ext4_get_block+0x1e3/0x470 fs/ext4/inode.c:909
 ext4_get_block_unwritten+0x2e/0x100 fs/ext4/inode.c:942
 ext4_block_write_begin+0xb14/0x1950 fs/ext4/inode.c:1196
 ext4_write_begin+0xb40/0x18c0 fs/ext4/ext4_jbd2.h:-1
 ext4_da_write_begin+0x355/0xd80 fs/ext4/inode.c:3123
 generic_perform_write+0x2e2/0x8f0 mm/filemap.c:4314
 ext4_buffered_write_iter+0xce/0x3a0 fs/ext4/file.c:300
 ext4_file_write_iter+0x298/0x1bf0 fs/ext4/file.c:-1
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x61d/0xb90 fs/read_write.c:688
 ksys_pwrite64 fs/read_write.c:795 [inline]
 __do_sys_pwrite64 fs/read_write.c:803 [inline]
 __se_sys_pwrite64 fs/read_write.c:800 [inline]
 __x64_sys_pwrite64+0x199/0x230 fs/read_write.c:800
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbdad39c799
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbdae25d028 EFLAGS: 00000246 ORIG_RAX: 0000000000000012
RAX: ffffffffffffffda RBX: 00007fbdad615fa0 RCX: 00007fbdad39c799
RDX: 00000000200000c1 RSI: 00002000000000c0 RDI: 0000000000000006
RBP: 00007fbdad432bd9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000009000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fbdad616038 R14: 00007fbdad615fa0 R15: 00007fff33d9aaf8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ext4_es_cache_extent+0x875/0x9e0 fs/ext4/extents_status.c:1044
Code: e1 07 80 c1 03 38 c1 0f 8c 5c fe ff ff 48 8b 7c 24 18 e8 fe ac ad ff e9 4d fe ff ff e8 a4 6e 43 ff 90 0f 0b e8 9c 6e 43 ff 90 <0f> 0b 65 8b 1d e6 98 99 10 bf 07 00 00 00 89 de e8 c6 72 43 ff 83
RSP: 0018:ffffc90003456d20 EFLAGS: 00010293
RAX: ffffffff82822744 RBX: 0000000000000018 RCX: ffff88803155bd00
RDX: 0000000000000000 RSI: 000000000000001b RDI: 0000000000000018
RBP: ffffc90003456e68 R08: ffffc90003456dd7 R09: ffffc90003456dc0
R10: dffffc0000000000 R11: fffff5200068adbb R12: ffffc90003456dc0
R13: 000000000000001b R14: 000000000000000f R15: dffffc0000000000
FS:  00007fbdae25d6c0(0000) GS:ffff888125464000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbdad3e9e80 CR3: 00000000781f0000 CR4: 0000000000350ef0


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

