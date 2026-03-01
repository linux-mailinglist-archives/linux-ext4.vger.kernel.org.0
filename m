Return-Path: <linux-ext4+bounces-14292-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJ1KOBd6pGl3iAUAu9opvQ
	(envelope-from <linux-ext4+bounces-14292-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Sun, 01 Mar 2026 18:40:39 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E979C1D0D81
	for <lists+linux-ext4@lfdr.de>; Sun, 01 Mar 2026 18:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AC262300608A
	for <lists+linux-ext4@lfdr.de>; Sun,  1 Mar 2026 17:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA71C333725;
	Sun,  1 Mar 2026 17:40:33 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB1830B514
	for <linux-ext4@vger.kernel.org>; Sun,  1 Mar 2026 17:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772386833; cv=none; b=Sccp1fI0gomzdfEJRz8rxIIzjYkMR769Px+gCeL7Z6GxgXfh5yhj3gvmg6XUCVAgg+6pcisQPRHF/3NlQ4ZGp2PBoG1VTVy71b2Vx0Qs6xo3qW8pYxfiIt6ux0oGehGAAMhr9gn1OP6nNr0z4xCnU9ALo1N8hqV3PjzTuvtSypY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772386833; c=relaxed/simple;
	bh=c2AMNUmcL6ZVHG+nGRVd2R0Fvdz/nVNFA0bmNMjkJEk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=keMjhIlMhbQ45D+QVvhb4IBIk3A/TUCiJvTpzEt4ltkDO9Z6GyVZEhCvDp4SjIblqZpG79CPawL9RIoJrG7QZLNfXJKlByqbD2VuRxENnUwRAxvCNWr60Xf/RagQnSHLWnKgQxuB7IL/EGR+I7QYZlARP934z0dSUfWWaPMuVtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-463c4133ccaso48782096b6e.2
        for <linux-ext4@vger.kernel.org>; Sun, 01 Mar 2026 09:40:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772386831; x=1772991631;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rqF6YfiVtI9PUPl6zKaf/kpEamc4fPsUxjwnl79XGXA=;
        b=teqO7xPEaeMuLibQ1Wa+91YZVpVajR2ZyQdyOHt3pDp5VqqAzzLrf0VjDX5FuZ5jHo
         K3GrC3x+TU5ZCmDU3wtTjKlmZazQ0mpUhRvQ/p8/5Vw1kiCx7xUArxNt7/xfKiTjOSGm
         fGcxQkMIa9v97/VD1r9dEB/TaWmFPGHs5D3vAOxgkjUFIz1HSsb68cDb+jF5p39VV298
         rtsQsomlFYg+ar1Op+Bz1zq5Zv5oyR4VEBhWhO2Ilpv7i66qOBgKg+skj97wG1bZBFnH
         iPL1EozV0mA8OMpIFSrV/oXJDQIMf9GfVvLSezuTe4iM1xs/qD9UAFSm4KSC8jqNLsy/
         OKlg==
X-Forwarded-Encrypted: i=1; AJvYcCWTgk4TF4NULQV0rEFlZ+0qNHRqwPnC20PHQeU20lpRQFpusIvSDdWsbPyaPIkmwsXldE2Bpux+AhvW@vger.kernel.org
X-Gm-Message-State: AOJu0YwUl8aCOHqP6pz0PyTd2ar4O2Z+cfgEjF+jbQ4gDfZvI/YTrZxF
	rdwoOXUAYGgca2aor0ZX6tkNemCHc5ILSaAY73j2UGyQlOKSZeEbklMZRBC6fdkHP/JLxMvepjE
	lVPvISjz+/jqOYFONP2uUEU1oooAHg3wpnOJzMUi3fppOQ7fQjZS8aHjY56w=
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4988:b0:662:f763:c539 with SMTP id
 006d021491bc7-679fadb7a4amr4755094eaf.14.1772386831234; Sun, 01 Mar 2026
 09:40:31 -0800 (PST)
Date: Sun, 01 Mar 2026 09:40:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69a47a0f.050a0220.3a55be.0065.GAE@google.com>
Subject: [syzbot] [ext4?] kernel BUG in ext4_ext_map_blocks
From: syzbot <syzbot+b20d00cf1ba477ac419f@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=70fe0401f305d8d4];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-14292-lists,linux-ext4=lfdr.de,b20d00cf1ba477ac419f];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlegroups.com:email,storage.googleapis.com:url,goo.gl:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E979C1D0D81
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    7dff99b35460 Remove WARN_ALL_UNSEEDED_RANDOM kernel config..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1749955a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=70fe0401f305d8d4
dashboard link: https://syzkaller.appspot.com/bug?extid=b20d00cf1ba477ac419f
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f33ddab53df8/disk-7dff99b3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3c50676d2681/vmlinux-7dff99b3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bbae16d525e0/bzImage-7dff99b3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b20d00cf1ba477ac419f@syzkaller.appspotmail.com

EXT4-fs (loop9): mounted filesystem 00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode: writeback.
------------[ cut here ]------------
kernel BUG at fs/ext4/ext4_extents.h:193!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 8704 Comm: syz.9.339 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
RIP: 0010:ext4_ext_mark_unwritten fs/ext4/ext4_extents.h:193 [inline]
RIP: 0010:ext4_ext_map_blocks+0x5521/0x58b0 fs/ext4/extents.c:4453
Code: 06 af ff ff e8 b0 5a 4e ff 48 c7 c7 80 d6 e2 8d be 04 00 00 00 e8 5f e1 32 ff 65 48 ff 43 08 e9 e6 ae ff ff e8 90 5a 4e ff 90 <0f> 0b e8 88 5a 4e ff 90 0f 0b e8 80 5a 4e ff 90 0f 0b e8 78 5a 4e
RSP: 0018:ffffc9001238ef60 EFLAGS: 00010283
RAX: ffffffff8275f850 RBX: 0000000000000000 RCX: 0000000000080000
RDX: ffffc90006f92000 RSI: 000000000000d48e RDI: 000000000000d48f
RBP: ffffc9001238f240 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffffbfff1ed44b7 R12: 1ffff92002471e1c
R13: 0000000000000003 R14: 00000000000001c1 R15: 0000000000000000
FS:  0000[  298.651065][ T8704] FS:  00007f0b370f66c0(0000) GS:ffff888126343000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0b2ece1000 CR3: 0000000040192000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ext4_map_create_blocks+0x11d/0x540 fs/ext4/inode.c:616
 ext4_map_blocks+0x7cd/0x11d0 fs/ext4/inode.c:809
 _ext4_get_block+0x1e3/0x470 fs/ext4/inode.c:909
 ext4_get_block_unwritten+0x2e/0x100 fs/ext4/inode.c:942
 ext4_block_write_begin+0xb14/0x1950 fs/ext4/inode.c:1196
 ext4_write_begin+0xb40/0x18c0 fs/ext4/ext4_jbd2.h:-1
 ext4_da_write_begin+0x355/0xd90 fs/ext4/inode.c:3123
 generic_perform_write+0x2af/0x8b0 mm/filemap.c:4314
 ext4_buffered_write_iter+0xd0/0x3a0 fs/ext4/file.c:300
 ext4_file_write_iter+0x299/0x1c10 fs/ext4/file.c:-1
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x629/0xba0 fs/read_write.c:688
 ksys_pwrite64 fs/read_write.c:795 [inline]
 __do_sys_pwrite64 fs/read_write.c:803 [inline]
 __se_sys_pwrite64 fs/read_write.c:800 [inline]
 __x64_sys_pwrite64+0x19c/0x230 fs/read_write.c:800
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0b38e9c629
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0b370f6028 EFLAGS: 00000246 ORIG_RAX: 0000000000000012
RAX: ffffffffffffffda RBX: 00007f0b39115fa0 RCX: 00007f0b38e9c629
RDX: 000000000000fdef RSI: 0000200000000140 RDI: 0000000000000007
RBP: 00007f0b38f32b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000c00 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f0b39116038 R14: 00007f0b39115fa0 R15: 00007ffd1d3115a8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ext4_ext_mark_unwritten fs/ext4/ext4_extents.h:193 [inline]
RIP: 0010:ext4_ext_map_blocks+0x5521/0x58b0 fs/ext4/extents.c:4453
Code: 06 af ff ff e8 b0 5a 4e ff 48 c7 c7 80 d6 e2 8d be 04 00 00 00 e8 5f e1 32 ff 65 48 ff 43 08 e9 e6 ae ff ff e8 90 5a 4e ff 90 <0f> 0b e8 88 5a 4e ff 90 0f 0b e8 80 5a 4e ff 90 0f 0b e8 78 5a 4e
RSP: 0018:ffffc9001238ef60 EFLAGS: 00010283
RAX: ffffffff8275f850 RBX: 0000000000000000 RCX: 0000000000080000
RDX: ffffc90006f92000 RSI: 000000000000d48e RDI: 000000000000d48f
RBP: ffffc9001238f240 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffffbfff1ed44b7 R12: 1ffff92002471e1c
R13: 0000000000000003 R14: 00000000000001c1 R15: 0000000000000000
FS:  00007f0b370f66c0(0000) GS:ffff888126443000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0b2ece7000 CR3: 0000000040192000 CR4: 00000000003526f0


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

