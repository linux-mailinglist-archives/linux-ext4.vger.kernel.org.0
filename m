Return-Path: <linux-ext4+bounces-13671-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NEAK4tojGkdnAAAu9opvQ
	(envelope-from <linux-ext4+bounces-13671-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Feb 2026 12:31:23 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C82D123DFF
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Feb 2026 12:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A1F5303817B
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Feb 2026 11:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3BC314A83;
	Wed, 11 Feb 2026 11:30:35 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEFC313550
	for <linux-ext4@vger.kernel.org>; Wed, 11 Feb 2026 11:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770809435; cv=none; b=OCiot2MbkTKl6yAGoG8aEPQl6Dl+Jab/bdP6ziyuW/cTPXoMZctCy9jMdQfyLyXKSMwkYGsWVCJ8hhIz5PSnY6P04X97QNiubezZXx/Nmr/eLJqqEuHHkZ6qP3e1XUFjjM96OaxBnFY5RzW6SD5U6URdE1F80bS/T48t4I7+sMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770809435; c=relaxed/simple;
	bh=u0xoDv2+kAoobBzt/NaBQMbvEqM4hanp7cc1KRUS8Gw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aSsy03QTADAfYYh9KZ5tGZwMZni33oFrMq1ne5z67CZ16uRgJnVJ0Eczk6Kns339hzf5ScVnKCWejRDW5dxV2JD9PlbQPB3wLpnM9WkgKMFZS9Dryijkx1kA9APBMu0bcOmWbAwtR4LGlw0q5Dp1THrRgUo6ZyfvF86xRU78+Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-66ad005c9dfso11312304eaf.1
        for <linux-ext4@vger.kernel.org>; Wed, 11 Feb 2026 03:30:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770809432; x=1771414232;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5mD4ROzvxWtQWHYsL49AuxnlWS8DSC7+nMe1S5XrkHE=;
        b=b4sg3zVnZ/ea7M0gVZBnKc+of6dp/wz0R/iC6Sgk+Iz7R+1lThlNOxnUOG3kQ8mJaV
         tbwUjFovR4Py+N2tr4qqneD6apBm/oVmYRdv0UV6ORvF64mR3BPbZODEJK501HftSplx
         QblUjixa26+I3UFO5mSnxiki0RWUOxADD2a2mmmCvQPJoSR04cKWholKC+OJfPLlXZsR
         UP4gj6e3pkrpxR6aJyCJUuq1UkOpnPTbzyhIK0la0ycOdWoUvLajQCvzyPi60myOK6qQ
         /YusEK6ONOku3/GatQnm/ToVWQyRK7JLwcRxXTDRGMRmaV6M9EcqyIhfxKXC/40Kv+CZ
         UI6w==
X-Forwarded-Encrypted: i=1; AJvYcCXp9SM8hkKyCJypkbv3jyqI6I/kmParCObIGs6uhS20Nnk45c6jPkANS+/ekdqOPKogiqkHggAqeBec@vger.kernel.org
X-Gm-Message-State: AOJu0YwT4RQP69Rrhjh99O/EvuyENUZrw9InXc7WD400icRrDKjGROz8
	7TXsezcy2CQQqpeIzfG+yyTYJzB8xhsG5kmrZ+EYV6ONJFoNnw0gn3O1tnPENlqQco+9frh/NuA
	HSfMOrSiMRj40mBX1y5ZGQEXNoYnz5s2RrcWoL9SWT0NOrXpjq71O2tHMxs0=
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:220b:b0:663:89a:8125 with SMTP id
 006d021491bc7-66d0bcb984amr9877411eaf.51.1770809432682; Wed, 11 Feb 2026
 03:30:32 -0800 (PST)
Date: Wed, 11 Feb 2026 03:30:32 -0800
In-Reply-To: <6980e9ff.050a0220.16b13.00a9.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <698c6858.050a0220.340abe.000e.GAE@google.com>
Subject: Re: [syzbot] [ext4?] kernel BUG in ext4_write_inline_data (4)
From: syzbot <syzbot+7de5fe447862fc37576f@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, kartikey406@gmail.com, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=c48edf5effbe2b83];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13671-lists,linux-ext4=lfdr.de,7de5fe447862fc37576f];
	RCVD_TLS_LAST(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[];
	FREEMAIL_TO(0.00)[dilger.ca,gmail.com,vger.kernel.org,googlegroups.com,mit.edu];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email,storage.googleapis.com:url,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 0C82D123DFF
X-Rspamd-Action: no action

syzbot has found a reproducer for the following issue on:

HEAD commit:    dc855b77719f Merge tag 'irq-drivers-2026-02-09' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=179e0b3a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c48edf5effbe2b83
dashboard link: https://syzkaller.appspot.com/bug?extid=7de5fe447862fc37576f
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=137b6ae6580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=109fb402580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d7c9816606c2/disk-dc855b77.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cb6f0c59d3d1/vmlinux-dc855b77.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7abf33193f14/bzImage-dc855b77.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/cc23e4e0f61c/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=11aaccaa580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7de5fe447862fc37576f@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/ext4/inline.c:240!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 6183 Comm: syz.1.27 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/24/2026
RIP: 0010:ext4_write_inline_data+0x43c/0x440 fs/ext4/inline.c:240
Code: c1 38 c1 0f 8c 19 ff ff ff 48 89 df 49 89 d7 e8 3a 5d ac ff 4c 89 fa e9 06 ff ff ff e8 7d 31 43 ff 90 0f 0b e8 75 31 43 ff 90 <0f> 0b 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f
RSP: 0018:ffffc900041bf3a8 EFLAGS: 00010293
RAX: ffffffff8281434b RBX: 0000000000003000 RCX: ffff88802ab8dac0
RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000003000
RBP: ffff888072ee11a2 R08: ffff88805b996387 R09: 1ffff1100b732c70
R10: dffffc0000000000 R11: ffffed100b732c71 R12: 000000000000003c
R13: ffffc900041bf460 R14: 0000000000002000 R15: ffff888072ee0c38
FS:  00007f67e2ffe6c0(0000) GS:ffff8881256ca000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555753c59e8 CR3: 0000000079001000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 ext4_write_inline_data_end+0x34d/0xad0 fs/ext4/inline.c:817
 generic_perform_write+0x620/0x8f0 mm/filemap.c:4335
 ext4_buffered_write_iter+0xce/0x3a0 fs/ext4/file.c:300
 ext4_file_write_iter+0x298/0x1c10 fs/ext4/file.c:-1
 iter_file_splice_write+0x99b/0x1100 fs/splice.c:738
 do_splice_from fs/splice.c:938 [inline]
 direct_splice_actor+0x101/0x160 fs/splice.c:1161
 splice_direct_to_actor+0x53a/0xc70 fs/splice.c:1105
 do_splice_direct_actor fs/splice.c:1204 [inline]
 do_splice_direct+0x195/0x290 fs/splice.c:1230
 do_sendfile+0x535/0x7d0 fs/read_write.c:1372
 __do_sys_sendfile64 fs/read_write.c:1433 [inline]
 __se_sys_sendfile64+0x144/0x1a0 fs/read_write.c:1419
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f67e399bf79
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f67e2ffe028 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f67e3c15fa0 RCX: 00007f67e399bf79
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000004
RBP: 00007f67e3a327e0 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000e3aa6ea R11: 0000000000000246 R12: 0000000000000000
R13: 00007f67e3c16038 R14: 00007f67e3c15fa0 R15: 00007fff789394f8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ext4_write_inline_data+0x43c/0x440 fs/ext4/inline.c:240
Code: c1 38 c1 0f 8c 19 ff ff ff 48 89 df 49 89 d7 e8 3a 5d ac ff 4c 89 fa e9 06 ff ff ff e8 7d 31 43 ff 90 0f 0b e8 75 31 43 ff 90 <0f> 0b 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f
RSP: 0018:ffffc900041bf3a8 EFLAGS: 00010293

RAX: ffffffff8281434b RBX: 0000000000003000 RCX: ffff88802ab8dac0
RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000003000
RBP: ffff888072ee11a2 R08: ffff88805b996387 R09: 1ffff1100b732c70
R10: dffffc0000000000 R11: ffffed100b732c71 R12: 000000000000003c
R13: ffffc900041bf460 R14: 0000000000002000 R15: ffff888072ee0c38
FS:  00007f67e2ffe6c0(0000) GS:ffff8881256ca000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa159255000 CR3: 0000000079001000 CR4: 0000000000350ef0


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

