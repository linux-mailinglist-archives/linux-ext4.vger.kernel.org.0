Return-Path: <linux-ext4+bounces-13659-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GpLAqtNi2mWTwAAu9opvQ
	(envelope-from <linux-ext4+bounces-13659-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Feb 2026 16:24:27 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA4C11C708
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Feb 2026 16:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE44530379A5
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Feb 2026 15:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52F036681B;
	Tue, 10 Feb 2026 15:24:05 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E94B32A3D7
	for <linux-ext4@vger.kernel.org>; Tue, 10 Feb 2026 15:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770737045; cv=none; b=NfpMin5oEYHgWN97sVgiT6GI3xurHkb84kuHvSBf7imewpJQtBV+IQIPIj69NJFGbWkloVspHTTthOs3B0KYn/POY8Ln9ZezS7JaHqcUKSGl5PBjQbAHufwRnUnwpLerEUpmraFQot6gZPy+d09sUuZl2OUlAwtsirUDAs09n60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770737045; c=relaxed/simple;
	bh=7qObaTK4feCd2wGpHZrKNGj2zM+OHPlPC/IUTyspar4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DnrqtNNdDqVBY3NyKTIa4Ov9N5lWQUO1XdxBnD91/RO4WrmZ2Pi8okcXJPj9MUCatgp5I0mwc/ZC85VfztVxyHbyHlMSlzjw4K/cmDoXymUTXV7oyRhvrE1IoVmhPbms9rbHTz5wcEvPrang+YU5oIrB0eYLW1VQ1hIwTwm0mZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-6630dd039ccso3982736eaf.3
        for <linux-ext4@vger.kernel.org>; Tue, 10 Feb 2026 07:24:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770737043; x=1771341843;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i2m9bXQJrR32kHMqUJzT9LqGWflhEt/kyyEhkwvL6rk=;
        b=iab3Vk5ijpQTuRfvIgVS6fGp3bk0LwYxI4qAzrjxHHaStXo+8Ttjv32PmdCJDTz4Kj
         vGEgtfXbOx1734AI7YL8R8V96nUWx5fPuyCU5AbeGOXKQoLNPqayzhDqrkcqskYofoHX
         ZJKVnUr4S5fu+XifSFK3W0gYDwYOKTCN2AI8EsJhQTSr6hzV45y+7PAPndspOj0XbFI+
         JoClFTCK58dG3KkiM9BOkcQOTPeZ7tdJmVrMa8fduwAJR7oAbpeEGAqlba4p9bKGBphQ
         cTJ8iJsQ4kNMolbXFD/1kfk/GjJ7gxTcGcoVPAiTpnjyygh+1trBsGDK3W67qN3MzEjt
         oZIw==
X-Forwarded-Encrypted: i=1; AJvYcCWb15K7RTO9Y4ykVuEwFwbxKtAdlUMF6tSaWyxHO6dwNljdWP8LExzMAgvjVoWF6nbVAI3GIn9UH6dv@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4MFwLGGtWP5rwarAp6aBkqiWfMYdd1NW26eR9Ql8iqPUc0Bqz
	/Ib3sWz1W7VOsCs7gxHGkr/I+PINIiEnKb3ADcVwWcteMzoaTvAMvSawtu+0SsxrCLrSxnSBqcs
	bQeRcwJM3XNSt7ydl4evkyUwbDhW6Rpvl3Lz9aM6iNUT6g4Jb+WGkTOzF75U=
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2913:b0:66f:c72c:7c7 with SMTP id
 006d021491bc7-66fc72c0c14mr4345046eaf.18.1770737043251; Tue, 10 Feb 2026
 07:24:03 -0800 (PST)
Date: Tue, 10 Feb 2026 07:24:03 -0800
In-Reply-To: <aYsltA41z7B23GVN@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <698b4d93.a70a0220.2c38d7.0075.GAE@google.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13659-lists,linux-ext4=lfdr.de,ccf1421545dbe5caa20c];
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
X-Rspamd-Queue-Id: 5CA4C11C708
X-Rspamd-Action: no action

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in ext4_ext_insert_extent

inode 15: block 305:freeing already freed block (bit 19); block bitmap corrupt.
------------[ cut here ]------------
kernel BUG at fs/ext4/extents.c:2174!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 6747 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/24/2026
RIP: 0010:ext4_ext_insert_extent+0x5248/0x5280 fs/ext4/extents.c:2174
Code: 89 d9 80 e1 07 fe c1 38 c1 0f 8c 75 e4 ff ff 48 89 df e8 1b 8f b1 ff e9 68 e4 ff ff e8 41 54 49 ff 90 0f 0b e8 39 54 49 ff 90 <0f> 0b e8 31 54 49 ff 90 0f 0b 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c
RSP: 0018:ffffc9000426ebe0 EFLAGS: 00010293
RAX: ffffffff827aea67 RBX: 0000000000000021 RCX: ffff88802fe9db80
RDX: 0000000000000000 RSI: 0000000000000021 RDI: 0000000000000021
RBP: ffffc9000426edd0 R08: ffff888076d2d0ef R09: 1ffff1100eda5a1d
R10: dffffc0000000000 R11: ffffed100eda5a1e R12: ffff888063f4b43c
R13: ffff888143ff8500 R14: ffff888063f4b400 R15: 0000000000000021
FS:  00007efc4003a6c0(0000) GS:ffff888125766000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000003000 CR3: 0000000028bcc000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ext4_ext_map_blocks+0x168a/0x5760 fs/ext4/extents.c:4480
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
RIP: 0033:0x7efc3f19aeb9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007efc4003a028 EFLAGS: 00000246 ORIG_RAX: 0000000000000148
RAX: ffffffffffffffda RBX: 00007efc3f415fa0 RCX: 00007efc3f19aeb9
RDX: 0000000000000001 RSI: 0000200000000100 RDI: 0000000000000004
RBP: 00007efc3f208c1f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000005412 R11: 0000000000000246 R12: 0000000000000000
R13: 00007efc3f416038 R14: 00007efc3f415fa0 R15: 00007ffefdbddaa8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ext4_ext_insert_extent+0x5248/0x5280 fs/ext4/extents.c:2174
Code: 89 d9 80 e1 07 fe c1 38 c1 0f 8c 75 e4 ff ff 48 89 df e8 1b 8f b1 ff e9 68 e4 ff ff e8 41 54 49 ff 90 0f 0b e8 39 54 49 ff 90 <0f> 0b e8 31 54 49 ff 90 0f 0b 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c
RSP: 0018:ffffc9000426ebe0 EFLAGS: 00010293
RAX: ffffffff827aea67 RBX: 0000000000000021 RCX: ffff88802fe9db80
RDX: 0000000000000000 RSI: 0000000000000021 RDI: 0000000000000021
RBP: ffffc9000426edd0 R08: ffff888076d2d0ef R09: 1ffff1100eda5a1d
R10: dffffc0000000000 R11: ffffed100eda5a1e R12: ffff888063f4b43c
R13: ffff888143ff8500 R14: ffff888063f4b400 R15: 0000000000000021
FS:  00007efc4003a6c0(0000) GS:ffff888125866000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc4a9f45000 CR3: 0000000028bcc000 CR4: 00000000003526f0


Tested on:

commit:         4f5e8e6f et4: allow zeroout when doing written to unwr..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
console output: https://syzkaller.appspot.com/x/log.txt?x=1081d33a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a535ad5429f72a2
dashboard link: https://syzkaller.appspot.com/bug?extid=ccf1421545dbe5caa20c
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10c15194580000


