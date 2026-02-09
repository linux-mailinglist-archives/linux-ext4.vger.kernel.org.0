Return-Path: <linux-ext4+bounces-13623-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLFeJqFBiWke5QQAu9opvQ
	(envelope-from <linux-ext4+bounces-13623-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Mon, 09 Feb 2026 03:08:33 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDBD10AFAD
	for <lists+linux-ext4@lfdr.de>; Mon, 09 Feb 2026 03:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80B673008A4C
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Feb 2026 02:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C485428AAEB;
	Mon,  9 Feb 2026 02:08:28 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7081DE8AD
	for <linux-ext4@vger.kernel.org>; Mon,  9 Feb 2026 02:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770602908; cv=none; b=UIUHrV9KjwLHsMbxSBdB5zObp65llIufKdPNIo2NG0Xqr0FuZI0YUUGdhkGMZ8Fibmb4f2twBUHutx9osn8/14vzicDHa2Q+spJoQoUUfyUXb2AUq72QsOUMyLXOzRk9zkLiNxPNlVjxVI79jY5XRb55xiBCHm+yUHz00mH4F3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770602908; c=relaxed/simple;
	bh=N8aGlm6zztvsDONjwxrYfE3jVaBN3efl471A/QdOMmY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=kziX0HKNcYpWGvtjWe/X8Q0yrPLqQZe3BHqPK2P5WLTUR55pKby/iqJ1/HMl6YAsnFChSfV4ZMDqTSw4jwLFkYE9xYC2TOK2CThuhKBf0yJXACW3l9IlMUIIDLlLB7NWr5kLwEhy3k/3Yp9yWtUO7sVc9ZT7jRb7ol+rI8rxMUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-663019e3e05so4903026eaf.3
        for <linux-ext4@vger.kernel.org>; Sun, 08 Feb 2026 18:08:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770602907; x=1771207707;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oU2iPtTs/u4Kq0wydeiESwq+NnkbLIM31WDSj8uz7nM=;
        b=feggc4zILx38FrWCFGZmfqCZJ74jd4wxHmeOo7CdbN/mcSG/8ZVUWCOD2NZ286rt+d
         s/Ah5XCdiCgaiGpLQBZ5mBnqd8zA6gA2rZycnaEAVrIRud9yMdm7LfBtvBdEKWf7otRn
         /ywvJm72svKw64Oe8xADxasXytGA838rT/9KTSZaw7XHrzEUJqJmdDCZO0k1DTfB1O4H
         7hHl90sbjU/S1o05oiZupmHZWIk90bjZ4orJ4FLa+5WDbBORkSQ8tldiXAMMM/b1+Che
         wmDriq5bkFNzNhhBnlxhJVbvs5DfuFQ3ZtUXagxvMzt5aZIdKEkVmRb2xiLUNjMeygcA
         03ng==
X-Forwarded-Encrypted: i=1; AJvYcCXYt8tithwY8A1wfBFItHtiXnsMensLKI3yNLCJqC/chk9xE1ExPPz7Vb4na7h7QDLFRyuYzdy7ZSUB@vger.kernel.org
X-Gm-Message-State: AOJu0YxgnizprFRJ/G1dGzrX74ZFrcyOdlu6rGl0FoDQ2wLBg0wLx6K0
	iebrAmeiZxrXkhuymmIEgSllVb2Q1WLC8eMgBo23lma2asKQ5JW6u23EIyOlWCN1x0k/rsO4tTU
	GurVJz7wynyx7HrYlqZrdf++dgImzPKM3JUxAAJYQ2p1B8GLl+Tm3OdgWM6U=
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:818b:b0:662:f42e:7cfe with SMTP id
 006d021491bc7-66d0bea535fmr4513048eaf.54.1770602907333; Sun, 08 Feb 2026
 18:08:27 -0800 (PST)
Date: Sun, 08 Feb 2026 18:08:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6989419b.050a0220.3b3015.0065.GAE@google.com>
Subject: [syzbot] [ext4?] kernel BUG in ext4_es_cache_extent (4)
From: syzbot <syzbot+ccf1421545dbe5caa20c@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=c09aefae2687abea];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13623-lists,linux-ext4=lfdr.de,ccf1421545dbe5caa20c];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,googlegroups.com:email,appspotmail.com:email,goo.gl:url]
X-Rspamd-Queue-Id: EBDBD10AFAD
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    0f8a890c4524 Add linux-next specific files for 20260204
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12d547fa580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c09aefae2687abea
dashboard link: https://syzkaller.appspot.com/bug?extid=ccf1421545dbe5caa20c
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16420a52580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3c923d50ef46/disk-0f8a890c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3a560206fcf3/vmlinux-0f8a890c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e0826a2ee028/bzImage-0f8a890c.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/4532e6e390d7/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=1533aa5a580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ccf1421545dbe5caa20c@syzkaller.appspotmail.com

EXT4-fs warning (device loop0): ext4_es_cache_extent:1082: inode #18: comm syz.0.37: ES cache extent failed: add [22,10,230,0x1] conflict with existing [17,15,145,0x2]
EXT4-fs warning (device loop0): ext4_es_cache_extent:1082: inode #18: comm syz.0.37: ES cache extent failed: add [32,1,353,0x1] conflict with existing [32,1,161,0x2]
EXT4-fs warning (device loop0): ext4_es_cache_extent:1082: inode #18: comm syz.0.37: ES cache extent failed: add [33,15,353,0x1] conflict with existing [33,15,161,0x2]
------------[ cut here ]------------
kernel BUG at fs/ext4/extents_status.c:1044!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 6168 Comm: syz.0.37 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/24/2026
RIP: 0010:ext4_es_cache_extent+0x875/0x9e0 fs/ext4/extents_status.c:1044
Code: e1 07 80 c1 03 38 c1 0f 8c 5c fe ff ff 48 8b 7c 24 18 e8 7e 15 ae ff e9 4d fe ff ff e8 a4 32 44 ff 90 0f 0b e8 9c 32 44 ff 90 <0f> 0b 65 8b 1d f6 c4 99 10 bf 07 00 00 00 89 de e8 c6 36 44 ff 83
RSP: 0018:ffffc90003dedb80 EFLAGS: 00010293
RAX: ffffffff82816b34 RBX: 0000000000000023 RCX: ffff8880271c9e40
RDX: 0000000000000000 RSI: 0000000000000030 RDI: 0000000000000023
RBP: ffffc90003dedcc8 R08: ffffc90003dedc37 R09: 0000000000000000
R10: ffffc90003dedc20 R11: fffff520007bdb87 R12: ffffc90003dedc20
R13: 0000000000000030 R14: 000000000000000f R15: dffffc0000000000
FS:  000055556ddfe500(0000) GS:ffff88812546d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f56b9c15000 CR3: 0000000079388000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ext4_cache_extents fs/ext4/extents.c:539 [inline]
 __read_extent_tree_block+0x4b4/0x890 fs/ext4/extents.c:586
 ext4_find_extent+0x76b/0xcc0 fs/ext4/extents.c:941
 ext4_ext_map_blocks+0x283/0x58b0 fs/ext4/extents.c:4263
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
 __kernel_write_iter+0x41e/0x880 fs/read_write.c:621
 dump_emit_page fs/coredump.c:1299 [inline]
 dump_user_range+0xb89/0x12d0 fs/coredump.c:1373
 elf_core_dump+0x34c2/0x3ad0 fs/binfmt_elf.c:2111
 coredump_write+0x1219/0x1950 fs/coredump.c:1050
 do_coredump fs/coredump.c:1127 [inline]
 vfs_coredump+0x36a9/0x4280 fs/coredump.c:1201
 get_signal+0x1107/0x1330 kernel/signal.c:3019
 arch_do_signal_or_restart+0xbc/0x830 arch/x86/kernel/signal.c:337
 __exit_to_user_mode_loop kernel/entry/common.c:64 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:98 [inline]
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
 irqentry_exit_to_user_mode_prepare include/linux/irq-entry-common.h:270 [inline]
 irqentry_exit_to_user_mode include/linux/irq-entry-common.h:339 [inline]
 irqentry_exit+0x176/0x620 kernel/entry/common.c:219
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:618
RIP: 0033:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 002b:0000200000000548 EFLAGS: 00010217
RAX: 0000000000000000 RBX: 00007efd00215fa0 RCX: 00007efcfff9aeb9
RDX: 0000000000000000 RSI: 0000200000000540 RDI: 0000000000000000
RBP: 00007efd00008c1f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007efd00215fac R14: 00007efd00215fa0 R15: 00007efd00215fa0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ext4_es_cache_extent+0x875/0x9e0 fs/ext4/extents_status.c:1044
Code: e1 07 80 c1 03 38 c1 0f 8c 5c fe ff ff 48 8b 7c 24 18 e8 7e 15 ae ff e9 4d fe ff ff e8 a4 32 44 ff 90 0f 0b e8 9c 32 44 ff 90 <0f> 0b 65 8b 1d f6 c4 99 10 bf 07 00 00 00 89 de e8 c6 36 44 ff 83
RSP: 0018:ffffc90003dedb80 EFLAGS: 00010293
RAX: ffffffff82816b34 RBX: 0000000000000023 RCX: ffff8880271c9e40
RDX: 0000000000000000 RSI: 0000000000000030 RDI: 0000000000000023
RBP: ffffc90003dedcc8 R08: ffffc90003dedc37 R09: 0000000000000000
R10: ffffc90003dedc20 R11: fffff520007bdb87 R12: ffffc90003dedc20
R13: 0000000000000030 R14: 000000000000000f R15: dffffc0000000000
FS:  000055556ddfe500(0000) GS:ffff88812556d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c00426e000 CR3: 0000000079388000 CR4: 00000000003526f0


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

