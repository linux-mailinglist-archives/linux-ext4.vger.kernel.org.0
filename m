Return-Path: <linux-ext4+bounces-13648-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cYv2FR3OimkUOAAAu9opvQ
	(envelope-from <linux-ext4+bounces-13648-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Feb 2026 07:20:13 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DCB11752E
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Feb 2026 07:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 433743014579
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Feb 2026 06:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D382E7164;
	Tue, 10 Feb 2026 06:20:05 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267252459E5
	for <linux-ext4@vger.kernel.org>; Tue, 10 Feb 2026 06:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770704405; cv=none; b=OBUAwUqEhj9SKRim2Xfowhljalu1MghONMaFCBIrcQauWukaMpnoAo3cgxZxdHTet1lHMa5FcIlF6x5zdN/nEXE6yxzSJgsmZc6nhUJfmRMmrIV2nlXB6NuthuvSNq8n/gZVgEt0JT1Fp2PbNsEaxhA7tMIRWFZP7cPZkBc+xPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770704405; c=relaxed/simple;
	bh=u/pQwJA1FcnbozV7Ute7l4O+0hdXMEZxCkijnCXlg18=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MKpPJQ9Owg18hk7dsAdFEfVXY93TDNbH6n9gNvISFSb3FL/s38PWF4+M+sJ4JGefCuzzDZhVP3XMet+VIGm0Mwdw0NuKA3LywyYTlFU0LAPaThn+vGZPHX1Gw11jdkq3Itb6IWCrIxYnib5xWgY1NMzWWv2ZXZU+T988AvpZpHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-663126bb42dso2203702eaf.1
        for <linux-ext4@vger.kernel.org>; Mon, 09 Feb 2026 22:20:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770704403; x=1771309203;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=70ipFTJzInwy1wthBH7bNAPYA2X+vPYs2ELBGcT3CWo=;
        b=aa3h6Jmim2/8TvpbpC7Ip7f7MYKtBfoDJNk/9YCcTLvjRYpew/BOjuplP8eAVJST59
         XH0ZWmHt5uffi5+UMcblCx+ruoAQAUwwJ5eh1jpbhwwALVREyDplyfD7FNwt0XfWQt1L
         g7lLvdPPPYHYP8uoo/uVPHpze5HdEW9iLBTYaEApRD/3KjI16ssNz+zdz8uJ8tHdKF4f
         WbXQyZYMjVjrxOVjr+6D0qn9gOMnaQU2pwZyt45WF6qFxAlillDpCyPJZlR+jjPQL8Kb
         XbusU84deO2NuU/0UbREX8L3ylvsyM5k/HVNObpDjhNMbixwgKaas9mCLodwlAqhtwhc
         JjTw==
X-Forwarded-Encrypted: i=1; AJvYcCX9R/rk/53xoEjTUNdbhOZNFo7oQqz5bl4ukNKlYTKS9qWEZKYoc0cqjthBzcXTJgnFpVFXpPwb3dhi@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/Let4IigCUuQErSrkbrVIgZc/62kIQFEpWEMeLHPVdxUuOngS
	YY5eJZsL6lqQ3A0xNZx0VTsqZUkOaDQ9EvxCHAsn7c48oJa+zRoESz8h8huomANtqSGlUU+e21L
	EpbNMa7H1jUtr7b0ZJol1XqWieNRVa5MZfJOX00C8/2t6tUCy70dzaG5JTBM=
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1843:b0:662:f90e:ce02 with SMTP id
 006d021491bc7-66d09cabfd3mr6927064eaf.14.1770704403108; Mon, 09 Feb 2026
 22:20:03 -0800 (PST)
Date: Mon, 09 Feb 2026 22:20:03 -0800
In-Reply-To: <aYrG032GU9Nesjsz@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <698ace13.050a0220.1ad825.004f.GAE@google.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13648-lists,linux-ext4=lfdr.de,ccf1421545dbe5caa20c];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: A0DCB11752E
X-Rspamd-Action: no action

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in ext4_es_cache_extent

EXT4-fs warning (device loop7): ext4_es_cache_extent:1081: inode #18: comm syz.7.209: ES cache extent failed: add [33,3,18446744073709551615,0x8] conflict with existing [33,15,257,0x2]
EXT4-fs warning (device loop7): ext4_es_cache_extent:1081: inode #18: comm syz.7.209: ES cache extent failed: add [36,12,292,0x1] conflict with existing [33,15,257,0x2]
------------[ cut here ]------------
kernel BUG at fs/ext4/extents_status.c:1043!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 1 UID: 0 PID: 9040 Comm: syz.7.209 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/24/2026
RIP: 0010:ext4_es_cache_extent+0x86e/0x990 fs/ext4/extents_status.c:1043
Code: e1 07 80 c1 03 38 c1 0f 8c 5d fe ff ff 48 8b 7c 24 20 e8 25 4d af ff e9 4e fe ff ff e8 1b 12 47 ff 90 0f 0b e8 13 12 47 ff 90 <0f> 0b 65 8b 1d 9d 73 6e 10 bf 07 00 00 00 89 de e8 3d 16 47 ff 83
RSP: 0018:ffffc900054fdba0 EFLAGS: 00010293
RAX: ffffffff827d2c8d RBX: 0000000000000023 RCX: ffff88801dfe8000
RDX: 0000000000000000 RSI: 0000000000000030 RDI: 0000000000000023
RBP: ffffc900054fdce8 R08: ffffc900054fdc57 R09: 0000000000000000
R10: ffffc900054fdc40 R11: fffff52000a9fb8b R12: 0000000000000030
R13: dffffc0000000000 R14: 000000000000000f R15: ffff88807d100638
FS:  00007efd221aa6c0(0000) GS:ffff888125866000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbc5c5e8600 CR3: 000000007569c000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ext4_cache_extents fs/ext4/extents.c:544 [inline]
 __read_extent_tree_block+0x4b4/0x840 fs/ext4/extents.c:591
 ext4_find_extent+0x76b/0xcc0 fs/ext4/extents.c:944
 ext4_ext_map_blocks+0x29d/0x6cd0 fs/ext4/extents.c:4239
 ext4_map_create_blocks fs/ext4/inode.c:613 [inline]
 ext4_map_blocks+0x8da/0x1830 fs/ext4/inode.c:816
 _ext4_get_block+0x1e3/0x470 fs/ext4/inode.c:916
 ext4_get_block_unwritten+0x2e/0x100 fs/ext4/inode.c:949
 ext4_block_write_begin+0xb14/0x1950 fs/ext4/inode.c:1203
 ext4_write_begin+0xb40/0x1870 fs/ext4/ext4_jbd2.h:-1
 ext4_da_write_begin+0x355/0xd30 fs/ext4/inode.c:3130
 generic_perform_write+0x2e2/0x8f0 mm/filemap.c:4314
 ext4_buffered_write_iter+0xce/0x3a0 fs/ext4/file.c:299
 ext4_file_write_iter+0x298/0x1c10 fs/ext4/file.c:-1
 __kernel_write_iter+0x41e/0x880 fs/read_write.c:619
 dump_emit_page fs/coredump.c:1298 [inline]
 dump_user_range+0xb89/0x12d0 fs/coredump.c:1372
 elf_core_dump+0x34c2/0x3ad0 fs/binfmt_elf.c:2111
 coredump_write+0x1219/0x1950 fs/coredump.c:1049
 do_coredump fs/coredump.c:1126 [inline]
 vfs_coredump+0x369e/0x4270 fs/coredump.c:1200
 get_signal+0x1107/0x1330 kernel/signal.c:3019
 arch_do_signal_or_restart+0xbc/0x830 arch/x86/kernel/signal.c:337
 __exit_to_user_mode_loop kernel/entry/common.c:41 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:75 [inline]
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
 irqentry_exit_to_user_mode_prepare include/linux/irq-entry-common.h:270 [inline]
 irqentry_exit_to_user_mode include/linux/irq-entry-common.h:339 [inline]
 irqentry_exit+0x176/0x620 kernel/entry/common.c:196
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:618
RIP: 0033:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 002b:0000200000000548 EFLAGS: 00010217
RAX: 0000000000000000 RBX: 00007efd21615fa0 RCX: 00007efd2139aeb9
RDX: 0000000000000000 RSI: 0000200000000540 RDI: 0000000000000000
RBP: 00007efd21408c1f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007efd21616038 R14: 00007efd21615fa0 R15: 00007ffc2b2553f8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ext4_es_cache_extent+0x86e/0x990 fs/ext4/extents_status.c:1043
Code: e1 07 80 c1 03 38 c1 0f 8c 5d fe ff ff 48 8b 7c 24 20 e8 25 4d af ff e9 4e fe ff ff e8 1b 12 47 ff 90 0f 0b e8 13 12 47 ff 90 <0f> 0b 65 8b 1d 9d 73 6e 10 bf 07 00 00 00 89 de e8 3d 16 47 ff 83
RSP: 0018:ffffc900054fdba0 EFLAGS: 00010293
RAX: ffffffff827d2c8d RBX: 0000000000000023 RCX: ffff88801dfe8000
RDX: 0000000000000000 RSI: 0000000000000030 RDI: 0000000000000023
RBP: ffffc900054fdce8 R08: ffffc900054fdc57 R09: 0000000000000000
R10: ffffc900054fdc40 R11: fffff52000a9fb8b R12: 0000000000000030
R13: dffffc0000000000 R14: 000000000000000f R15: ffff88807d100638
FS:  00007efd221aa6c0(0000) GS:ffff888125766000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f82eec0f000 CR3: 000000007569c000 CR4: 00000000003526f0


Tested on:

commit:         26f260ce ext4: remove unnecessary zero-initialization ..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12dcd78a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a535ad5429f72a2
dashboard link: https://syzkaller.appspot.com/bug?extid=ccf1421545dbe5caa20c
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Note: no patches were applied.

