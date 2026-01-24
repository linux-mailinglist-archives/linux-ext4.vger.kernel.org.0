Return-Path: <linux-ext4+bounces-13285-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCAEKAEgdGk32QAAu9opvQ
	(envelope-from <linux-ext4+bounces-13285-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Sat, 24 Jan 2026 02:27:29 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE977BF83
	for <lists+linux-ext4@lfdr.de>; Sat, 24 Jan 2026 02:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D7993016EC2
	for <lists+linux-ext4@lfdr.de>; Sat, 24 Jan 2026 01:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DADB1EF36C;
	Sat, 24 Jan 2026 01:27:25 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685AA1A2630
	for <linux-ext4@vger.kernel.org>; Sat, 24 Jan 2026 01:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769218044; cv=none; b=jfQf0g0+1gIMrkl43uqM+OGewZo5ESRsrDVoLeXOJFo7xaE1TAmJFoJvCZrSr2/hPUumJ/s3TJHQW9fXR4wyIxB0zGqerCQqo0OnpOQ8H9uL2W/iO0+Gufr6QmcuU/5LcIM6ZUmEJBcjuOxao3Y+IUfYgno1EirNQXobS0e7NIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769218044; c=relaxed/simple;
	bh=79CQmac/vHMKx4+blnA6JfjbpbzdMH2UwWRnE3rknIw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PM/AJ25sLTcjZQpwsk8EqdeCIZJldM2mwfpkLwRJPWw9Npwo2WtPoKTCmMifX8Mx5+ytMGh8/1lvBVUwlIRqori3xg9l9+kPxgyC8gd41bDXD/9lBaHMx1N0cCWnUrCSEDX/YjaykJEGL3WxS+vwZtEKqZgOUDCYokxtBO6wieE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-65f30d38617so5316036eaf.1
        for <linux-ext4@vger.kernel.org>; Fri, 23 Jan 2026 17:27:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769218042; x=1769822842;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7jJqVblTcaDm59x9pbra9PFYT8IN4hr11UnTJQhv4XY=;
        b=sQZCxmObR12T2kVQ3iciK8PUcqwRqkurPrdNwhcu/mO9Pa6TF5jD3tQW0zXxqiqmRk
         JfluV3wvdz1PmqdLbwH69vVyGEyiR0lusgb8D+t2CE0WZV+ay7t+I4AtAF1pbjT/SWQD
         g0vD7ixl5fCYg6kE22cENQwpt4IQO5Zwrieh1lH/J5g9osuVJ8dNEKF0kJtiv0CeUqQW
         hqYN5C+BzTMKkVyj3qC148cDrE7OPcVLd/OIMaNkbi/HlPilwBrUXhJmVlQswvsF1XGr
         iIXvCtkjaFtYEpqs2DaGFxJwuXI1K4bxGJVFPPQP13vA7QonNH2LSPtI9ktDyPg7xeUN
         ckMg==
X-Forwarded-Encrypted: i=1; AJvYcCXnSc5UY9aZRC4JqMf3Fa1NW8+yZN141oKjo8d/t3VOLpPKVkzOZm8A4hx6tDb/wnLWccy6x5jndknZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd1M9YiGovuYOEFooqND8wobbUOMvoFS2uJddtwj3D7yJdjbzr
	rY58hv76YXHQNXTUXNlVzcpMcRw/7L2Vlhfy7Qmmz0H+4YcPYhj3oN1AF6ezWEOPhPa04ROaQNm
	ethOa+tPXI3Z9OzzB9pWFm8csL++tsEfOYOWlHmZxxEXztWF+jJY0/sfCKGU=
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:8188:b0:65c:2501:6c79 with SMTP id
 006d021491bc7-662cab9db87mr2267253eaf.59.1769218042409; Fri, 23 Jan 2026
 17:27:22 -0800 (PST)
Date: Fri, 23 Jan 2026 17:27:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69741ffa.050a0220.1a75db.0328.GAE@google.com>
Subject: [syzbot] [ext4?] WARNING in ext4_split_convert_extents
From: syzbot <syzbot+e625b79bfdd66c067432@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=ee3bfbe9e319ed0c];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13285-lists,linux-ext4=lfdr.de,e625b79bfdd66c067432];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goo.gl:url,syzkaller.appspot.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,storage.googleapis.com:url,googlegroups.com:email]
X-Rspamd-Queue-Id: 0CE977BF83
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    d08c85ac8894 Add linux-next specific files for 20260119
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=171a1852580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ee3bfbe9e319ed0c
dashboard link: https://syzkaller.appspot.com/bug?extid=e625b79bfdd66c067432
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=121533fa580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12bc7b9a580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/94cfdbd8a0c9/disk-d08c85ac.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f7ec0695ac29/vmlinux-d08c85ac.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ddc8307e03e3/bzImage-d08c85ac.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/6ddc9a8efbb6/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=14f96bfc580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e625b79bfdd66c067432@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: fs/ext4/extents.c:3486 at ext4_split_extent fs/ext4/extents.c:3485 [inline], CPU#1: kworker/u8:4/58
WARNING: fs/ext4/extents.c:3486 at ext4_split_convert_extents+0x13c2/0x1a10 fs/ext4/extents.c:3839, CPU#1: kworker/u8:4/58
Modules linked in:
CPU: 1 UID: 0 PID: 58 Comm: kworker/u8:4 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Workqueue: ext4-rsv-conversion ext4_end_io_rsv_work
RIP: 0010:ext4_split_extent fs/ext4/extents.c:3485 [inline]
RIP: 0010:ext4_split_convert_extents+0x13c2/0x1a10 fs/ext4/extents.c:3839
Code: 4c 8b 44 24 38 e8 be 85 fe ff 40 b5 01 4c 8b 64 24 18 49 81 fc 00 f0 ff ff 0f 87 19 ff ff ff e9 4e f0 ff ff e8 3f 8f 4a ff 90 <0f> 0b 90 49 bf 00 00 00 00 00 fc ff df 44 8b 6c 24 04 4c 8b 64 24
RSP: 0018:ffffc900015f7328 EFLAGS: 00010293
RAX: ffffffff82768aa1 RBX: dffffc0000000001 RCX: ffff88801cb99e40
RDX: 0000000000000000 RSI: 0000000000000100 RDI: 0000000000000008
RBP: 0000000000000008 R08: ffff88802ba1269f R09: 0000000000000000
R10: ffff88802ba12690 R11: ffffed10057424d4 R12: 0000000000000010
R13: ffff888073634d01 R14: 0000000000000010 R15: 0000000000000100
FS:  0000000000000000(0000) GS:ffff888125cf2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000080 CR3: 000000000df3e000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ext4_convert_unwritten_extents_endio fs/ext4/extents.c:3915 [inline]
 ext4_ext_handle_unwritten_extents fs/ext4/extents.c:3999 [inline]
 ext4_ext_map_blocks+0xde4/0x5560 fs/ext4/extents.c:4336
 ext4_map_create_blocks+0x11d/0x540 fs/ext4/inode.c:616
 ext4_map_blocks+0x759/0x1170 fs/ext4/inode.c:809
 ext4_convert_unwritten_extents+0x2a8/0x5d0 fs/ext4/extents.c:5038
 ext4_convert_unwritten_io_end_vec+0xff/0x170 fs/ext4/extents.c:5078
 ext4_end_io_end+0xc7/0x410 fs/ext4/page-io.c:200
 ext4_do_flush_completed_IO fs/ext4/page-io.c:291 [inline]
 ext4_end_io_rsv_work+0x262/0x330 fs/ext4/page-io.c:306
 process_one_work+0x93a/0x15a0 kernel/workqueue.c:3279
 process_scheduled_works kernel/workqueue.c:3362 [inline]
 worker_thread+0x9b0/0xee0 kernel/workqueue.c:3443
 kthread+0x389/0x480 kernel/kthread.c:467
 ret_from_fork+0x510/0xa50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


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

