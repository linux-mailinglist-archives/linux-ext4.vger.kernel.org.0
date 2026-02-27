Return-Path: <linux-ext4+bounces-14196-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGYtDGlNoWkfsAQAu9opvQ
	(envelope-from <linux-ext4+bounces-14196-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Feb 2026 08:53:13 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E4A1B4204
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Feb 2026 08:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F144303B7D5
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Feb 2026 07:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DA6355F35;
	Fri, 27 Feb 2026 07:52:20 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B55132AAD1
	for <linux-ext4@vger.kernel.org>; Fri, 27 Feb 2026 07:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772178739; cv=none; b=fYW0XwYgCYF6R+ArQxNncLJu4zM6skFnzoh5YdfCHRjnd83TtzA6zO9B30q2QBc7daMn0LfTeK9O/IhRnE8FCLqlnFNsz7zs/7hmwxEoNvpZ1GkfnPMudRBZkmO2eikWxKRj25dWf3sTFIHyyy8cXbWKRGSjYNGJCFKYGm0APFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772178739; c=relaxed/simple;
	bh=bUY81NVini8ehJyw2aPjwPsWMUoB9siRg29m/Xs5viE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=m5QsC00Zh484irKFJAPV23VkhBtuuShWiwlTx6aT0I7CBNFc+Zs7uTKx1yTbMJfVbXOzESPiH/o0jo+5bGTdtB8HOA5j+/YL5sCW9WXE74asNTuhuEdtWhlwBpkkyKIGxgK1cQZ75ELCmTADUgXjkORNoQAAX54tHRGRgIXXH0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-66b612efb4aso25824474eaf.0
        for <linux-ext4@vger.kernel.org>; Thu, 26 Feb 2026 23:52:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772178737; x=1772783537;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Hj6swBUSI0e11N5NmPgAr9HdO3mYh7gXhmw6hg+I3Q=;
        b=PC23sdQQ/zMy1WAwgZbSBgAYquWf5/4PnChyNjaKkx/Ktn8hrVgBhRx1SI9ttJ3nif
         6qeL3RuIOEX2hlgG6ZS70RtWmDn/o1YvnOppgseVvrXp0/1XeTHJKXqmhZ+d/6dOd3OE
         OZaM9nCEFs76rVHKGODZDWb7Unu2Mr2ULm74IrQHrwg0DrKPp5OpccHC1ILi1JQMPIuV
         ncf1a0yg/tAxlH4AYmMMxyDg6jfazs3aM5y5M9jyFUs0KWi2TTj3SQSdFWE+ZbaHr4X5
         8RPIK4u3WqiHvqr6XWOYS20vw9n8FQRTy5StbpC79UtINVPWZqkDs6VIUb9esL6cUe7L
         jIcw==
X-Forwarded-Encrypted: i=1; AJvYcCVKJ/jER9qEIEhvn4rpjZ1gzGr6p3EdJ1As3QK3drUQlz/oThADwQ70QslRiysc4FQHd/c5tSsprl5P@vger.kernel.org
X-Gm-Message-State: AOJu0YwyHUV9y1Z0cttB3mtT3DOYZcZ3o6Yy9dSwDwfOYNLehSNe80EH
	F5MaNeINOV5vYI1GefcHeG7g3exYtyWmjCY5RTBPQpSmwSK3y5cBipB4sPRU2HH+g02WHofLo40
	7W+6pnKaoTBlbWbKFMrskAwhQzH39aswW2GSpTTUCvhH/pA2uRR0qToLtTCg=
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:80a:b0:679:c41f:edf with SMTP id
 006d021491bc7-679f2330cc6mr3625616eaf.29.1772178737521; Thu, 26 Feb 2026
 23:52:17 -0800 (PST)
Date: Thu, 26 Feb 2026 23:52:17 -0800
In-Reply-To: <20260226110718.1904825-1-yebin@huaweicloud.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69a14d31.050a0220.305b49.00aa.GAE@google.com>
Subject: [syzbot ci] Re: ext4: test if inode's all dirty pages are submitted
 to disk
From: syzbot ci <syzbot+cif302214182590c61@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, jack@suse.cz, linux-ext4@vger.kernel.org, 
	tytso@mit.edu, yebin@huaweicloud.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,googlesource.com:url,googlegroups.com:email,appspotmail.com:email,syzbot.org:url];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-ext4];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_THREE(0.00)[4];
	R_DKIM_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-14196-lists,linux-ext4=lfdr.de,cif302214182590c61];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 86E4A1B4204
X-Rspamd-Action: no action

syzbot ci has tested the following series

[v1] ext4: test if inode's all dirty pages are submitted to disk
https://lore.kernel.org/all/20260226110718.1904825-1-yebin@huaweicloud.com
* [PATCH] ext4: test if inode's all dirty pages are submitted to disk

and found the following issue:
WARNING in ext4_evict_inode

Full report is available here:
https://ci.syzbot.org/series/8f9434e5-a73c-4b31-be9f-e9b76f1c2596

***

WARNING in ext4_evict_inode

tree:      torvalds
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
base:      f4d0ec0aa20d49f09dc01d82894ce80d72de0560
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/7053c6f2-2ee6-4a1d-9f74-d2f56facd9f9/config
C repro:   https://ci.syzbot.org/findings/4f7c2b91-8121-443d-9a4f-991feda8057c/c_repro
syz repro: https://ci.syzbot.org/findings/4f7c2b91-8121-443d-9a4f-991feda8057c/syz_repro

------------[ cut here ]------------
mapping_tagged(&inode->i_data, PAGECACHE_TAG_DIRTY)
WARNING: fs/ext4/inode.c:191 at ext4_evict_inode+0xbdc/0xf10 fs/ext4/inode.c:191, CPU#1: syz-executor/5915
Modules linked in:
CPU: 1 UID: 0 PID: 5915 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:ext4_evict_inode+0xbdc/0xf10 fs/ext4/inode.c:191
Code: ba 2c 02 00 48 8b bc 24 a0 00 00 00 e8 bd 49 14 00 e9 71 fe ff ff e8 43 63 40 ff 90 0f 0b 90 e9 e6 f4 ff ff e8 35 63 40 ff 90 <0f> 0b 90 e9 f2 f5 ff ff e8 27 63 40 ff 48 8d 3d 50 df 92 0d 67 48
RSP: 0018:ffffc900048b79a0 EFLAGS: 00010293
RAX: ffffffff8285287b RBX: ffff88811d980298 RCX: ffff8881027d8000
RDX: 0000000000000000 RSI: 0000000004000000 RDI: 0000000000000000
RBP: ffffc900048b7ab0 R08: ffffffff901181b7 R09: 1ffffffff2023036
R10: dffffc0000000000 R11: fffffbfff2023037 R12: 1ffff92000916f44
R13: dffffc0000000000 R14: ffff88811d9804b8 R15: 0000000004000000
FS:  000055557d541500(0000) GS:ffff8882a9464000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c00003e720 CR3: 000000010f9d2000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 evict+0x61e/0xb10 fs/inode.c:846
 dispose_list fs/inode.c:888 [inline]
 evict_inodes+0x75a/0x7f0 fs/inode.c:942
 generic_shutdown_super+0xaa/0x2d0 fs/super.c:632
 kill_block_super+0x44/0x90 fs/super.c:1725
 ext4_kill_sb+0x68/0xb0 fs/ext4/super.c:7459
 deactivate_locked_super+0xbc/0x130 fs/super.c:476
 cleanup_mnt+0x437/0x4d0 fs/namespace.c:1312
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:67 [inline]
 exit_to_user_mode_loop+0xed/0x480 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:325 [inline]
 do_syscall_64+0x32d/0xf80 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcf3c79d897
Code: a2 c7 05 5c ee 24 00 00 00 00 00 eb 96 e8 e1 12 00 00 90 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 e8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffe2362cef8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00007fcf3c831ef0 RCX: 00007fcf3c79d897
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffe2362cfb0
RBP: 00007ffe2362cfb0 R08: 00007ffe2362dfb0 R09: 00000000ffffffff
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe2362e040
R13: 00007fcf3c831ef0 R14: 000000000000f11c R15: 00007ffe2362e080
 </TASK>


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

