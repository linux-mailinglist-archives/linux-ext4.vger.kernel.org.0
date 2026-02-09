Return-Path: <linux-ext4+bounces-13640-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kExaCpI4imkeIgAAu9opvQ
	(envelope-from <linux-ext4+bounces-13640-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Mon, 09 Feb 2026 20:42:10 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7D0114326
	for <lists+linux-ext4@lfdr.de>; Mon, 09 Feb 2026 20:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BAC873020841
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Feb 2026 19:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61676425CFE;
	Mon,  9 Feb 2026 19:42:04 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F403938946B
	for <linux-ext4@vger.kernel.org>; Mon,  9 Feb 2026 19:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770666124; cv=none; b=W/tHLvsNOkn6rrJfEalVwNd6Zzb/5SYR+UNRLdpNIn+K4iqa/1+xO/3B1qZDVhBsRHr+e+VR024uocEXLMLoBH49dy/JwxOP4OL+HMsTR6UqweONiSqLOiT8Sa/ze1qxaAg1cJCVZL0JYK1QSvpzlV76DfMogVoDuX08npWiLNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770666124; c=relaxed/simple;
	bh=ZmCd418+O49a7S0s5AfGmaweRJ+Ow3LLvLyDW4KvLUQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BTFkwfYFHXUQwAA6FOeHQinyoZElIrWkbZC3dtaLr/ABY4ADlcJuEMoI8AYvxbiQvo1t+XBpjxRhzbUg/QHIul+Pw/pvZl7ZwJ9cN2/w9kF1TiD2WMOcPzJWdbduAK7yr/VG5j+aYnagBEv6IWcZqWn6CEdMkH1DsjMCB1y2TEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7d14b9caf47so12249515a34.1
        for <linux-ext4@vger.kernel.org>; Mon, 09 Feb 2026 11:42:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770666123; x=1771270923;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vfspPUJR2WWeV/Cj+bb0LGuWLe2ZjzwuZjbRs61/yJQ=;
        b=Um3I3V27V95wu2dESy54nUnLXPn/MftwyG/xm/sqyHBUOhcKj2fFV4RvIscdXmPK3p
         1EatOiZebelDwTnEX0SakN2PnRRUII8THrSuzou5tdSLDjSgfaKrFKgxuR6w/QWDElA+
         MEAy6F86miY95Y1yUmuhkGs1K2Ys+hFGOizjIRud7nUUo5FqiQpuJ0tCth3EfZ+YIBXD
         HEdaZicJCs4PfiaHFMq7Zg02od549H8TI2NNvk3PAJnvJhv7AX0Yo0Cn+G1LXfj5qEaO
         TrU1jlwB2/RYNNaZ2WI8xK3U36y2gsmXZ775mmKvPROIYFGYPFGvTaEZgnsUaO1P3Zn8
         Bw8w==
X-Forwarded-Encrypted: i=1; AJvYcCWbYjzhYwvIR7DJ8wgrRBpt2vSkkMX5zmukxB67Pc6+TpA0WhQKIJuFXGRak37p+h8n1RMxMQu1ghVA@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7wu+us8Y1kq1fbukBV8MJawXaUAvc+SqkN6q2H+/PBt1IRkx+
	c7IBbjd/IjdNlnQWOjFtjRupYWyf0NWjHvgx1wK5l55iHGm97IWu/FVzujvVPTc6zB586t3Mjlt
	Lwglfo9uVhalXK5VKs16WtZHa8AfF4ET+VLP4QD1o/O6x4xa5L375eRv20Kk=
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1898:b0:662:fbdd:1ace with SMTP id
 006d021491bc7-66d0a85bacdmr5923430eaf.30.1770666123037; Mon, 09 Feb 2026
 11:42:03 -0800 (PST)
Date: Mon, 09 Feb 2026 11:42:03 -0800
In-Reply-To: <aYoz6l_q2t-Wa5TP@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <698a388b.050a0220.1ad825.0030.GAE@google.com>
Subject: Re: [syzbot] [ext4?] kernel BUG in ext4_es_cache_extent (4)
From: syzbot <syzbot+ccf1421545dbe5caa20c@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=a535ad5429f72a2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13640-lists,linux-ext4=lfdr.de,ccf1421545dbe5caa20c];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8E7D0114326
X-Rspamd-Action: no action

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in ext4_ext_insert_extent

inode 15: block 305:freeing already freed block (bit 19); block bitmap corrupt.
------------[ cut here ]------------
kernel BUG at fs/ext4/extents.c:2158!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 7267 Comm: syz.8.85 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/24/2026
RIP: 0010:ext4_ext_insert_extent+0x4b19/0x4b50 fs/ext4/extents.c:2158
Code: 89 d9 80 e1 07 fe c1 38 c1 0f 8c 98 e7 ff ff 48 89 df e8 4a 96 b1 ff e9 8b e7 ff ff e8 70 5b 49 ff 90 0f 0b e8 68 5b 49 ff 90 <0f> 0b e8 60 5b 49 ff 90 0f 0b 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c
RSP: 0018:ffffc90004d8ec20 EFLAGS: 00010293
RAX: ffffffff827ae338 RBX: 0000000000000021 RCX: ffff8880269d1e80
RDX: 0000000000000000 RSI: 0000000000000021 RDI: 0000000000000021
RBP: ffffc90004d8edd0 R08: ffff88805b34b747 R09: 1ffff1100b6696e8
R10: dffffc0000000000 R11: ffffed100b6696e9 R12: 0000000000000021
R13: dffffc0000000000 R14: ffff88807090c43c R15: ffff88804dea8700
FS:  00007f7f021716c0(0000) GS:ffff888125766000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fdd8b3e1198 CR3: 000000005af88000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ext4_ext_map_blocks+0x168a/0x5760 fs/ext4/extents.c:4459
 ext4_map_create_blocks+0x11d/0x540 fs/ext4/inode.c:616
 ext4_map_blocks+0x7cd/0x11d0 fs/ext4/inode.c:809
 _ext4_get_block+0x1e3/0x470 fs/ext4/inode.c:909
 ext4_get_block_unwritten+0x2e/0x100 fs/ext4/inode.c:942
 ext4_block_write_begin+0xb14/0x1950 fs/ext4/inode.c:1196
 ext4_write_begin+0xb40/0x1870 fs/ext4/ext4_jbd2.h:-1
 ext4_da_write_begin+0x355/0xd30 fs/ext4/inode.c:3123
 generic_perform_write+0x2e2/0x8f0 mm/filemap.c:4314
 ext4_buffered_write_iter+0xce/0x3a0 fs/ext4/file.c:299
 ext4_file_write_iter+0x298/0x1bf0 fs/ext4/file.c:-1
 do_iter_readv_writev+0x619/0x8c0 fs/read_write.c:-1
 vfs_writev+0x33c/0x990 fs/read_write.c:1057
 do_pwritev fs/read_write.c:1153 [inline]
 __do_sys_pwritev2 fs/read_write.c:1211 [inline]
 __se_sys_pwritev2+0x184/0x2a0 fs/read_write.c:1202
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7f0139aeb9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7f02171028 EFLAGS: 00000246 ORIG_RAX: 0000000000000148
RAX: ffffffffffffffda RBX: 00007f7f01615fa0 RCX: 00007f7f0139aeb9
RDX: 0000000000000001 RSI: 0000200000000100 RDI: 0000000000000004
RBP: 00007f7f01408c1f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000005412 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f7f01616038 R14: 00007f7f01615fa0 R15: 00007ffd34928518
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ext4_ext_insert_extent+0x4b19/0x4b50 fs/ext4/extents.c:2158
Code: 89 d9 80 e1 07 fe c1 38 c1 0f 8c 98 e7 ff ff 48 89 df e8 4a 96 b1 ff e9 8b e7 ff ff e8 70 5b 49 ff 90 0f 0b e8 68 5b 49 ff 90 <0f> 0b e8 60 5b 49 ff 90 0f 0b 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c
RSP: 0018:ffffc90004d8ec20 EFLAGS: 00010293
RAX: ffffffff827ae338 RBX: 0000000000000021 RCX: ffff8880269d1e80
RDX: 0000000000000000 RSI: 0000000000000021 RDI: 0000000000000021
RBP: ffffc90004d8edd0 R08: ffff88805b34b747 R09: 1ffff1100b6696e8
R10: dffffc0000000000 R11: ffffed100b6696e9 R12: 0000000000000021
R13: dffffc0000000000 R14: ffff88807090c43c R15: ffff88804dea8700
FS:  00007f7f021716c0(0000) GS:ffff888125766000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fdd8b1e8600 CR3: 000000005af88000 CR4: 00000000003526f0


Tested on:

commit:         4f5e8e6f et4: allow zeroout when doing written to unwr..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
console output: https://syzkaller.appspot.com/x/log.txt?x=15091b22580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a535ad5429f72a2
dashboard link: https://syzkaller.appspot.com/bug?extid=ccf1421545dbe5caa20c
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Note: no patches were applied.

