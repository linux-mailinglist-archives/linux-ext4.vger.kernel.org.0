Return-Path: <linux-ext4+bounces-10909-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C15BE4DE2
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Oct 2025 19:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0DBD74F242A
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Oct 2025 17:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE98212566;
	Thu, 16 Oct 2025 17:36:43 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B178EED8
	for <linux-ext4@vger.kernel.org>; Thu, 16 Oct 2025 17:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760636202; cv=none; b=GJO6CPT81rOLzrEKan3o6dLADaqBBHavpXgyD7f4K7ujbycZOH8V4cmoepYakMb9OeDcQgEp0YGghnhEfoSIDGXonbHuYmqLAn2jbKLe+ekTFm4xhiVNRDESfQqQistkRZULJUo1DfjsO3V0V5Lo4owfkqWtBPVYxSIX7S5HcC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760636202; c=relaxed/simple;
	bh=TBg2vuYK+cI708IVZhElHlvtTpxB7rymoyb3gUuQl80=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=oC4p9GG1ltZiu9kaOA8dTr8C4Uk+MmrUFAp4ZsGn0kpxd9yikSpIfCKWdmwB8cUpwKNSUsdmw5C4RYOCEMsGudBWeSn5xOyIPJbZjq+WAHYN3QXvSJeu1G58szimTHpDV0UwMSYnPBH152cGDtEL7ujAeWzYisU6a7bV7bRRsSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-4308bc881abso7736795ab.1
        for <linux-ext4@vger.kernel.org>; Thu, 16 Oct 2025 10:36:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760636200; x=1761241000;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oPg0d6zIbA8VuWeZ8yHui07CalWA9zc91ILN9XOQsus=;
        b=oRtDLUn5+SeNBdpzFPqN4OdmmEq0zKRV0LIs3MMjFgKKySRMv+lZNUZPGmtQn/XhEG
         gfahC2ZjuiKAh0O7T5y+9kJejUTqwhU9LXh69+SXpunG/S6Sil5EAn77eg6tL3I9Wk1V
         TN7LQJZvknsi/MmrrkPOj86+YCykYaZkb+tJz6aT5XmwLCTOCibdv7XPJB2kOICnSLKW
         Dweo53NONqDnvdW3ZdzbWOPphTL3MXzYxhfgew8S4U9EYmddQMN7nOdf3mJGZQb71mhD
         PXZ8FWQ0hRZt/pjcD9xKsltWGzuiQfEW3QDz3qsPZQuntJYgshTYZ29uRWY4Bi7S3GO3
         lT8A==
X-Forwarded-Encrypted: i=1; AJvYcCUYOWgQzBCqBZBwycunmFvTB1p3qLUw2u/thJCVY+6fk2Mb5KNZtLxHufH7j8iUrnZ1sMhje1He1ZbG@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8NKQ3kXTLwgLRN4KBZTz8inQouFJNpJBkEn+Mx+9Tux0oTzQD
	eEeccB6Klbat8t6VuelquFqZN23RB4+Anw2oAJtnmOTsA7GDUXVpCmURvOJ55S+ymcfOr6vgmBY
	xmBxW3TecPJSF1yfsp7qtWbnK8g9WMD+dlWasvXa3Yha//PgToGLRTlKpkCc=
X-Google-Smtp-Source: AGHT+IFWCdxDVKR2wxpQsS4V4HPZ4HeJTiJl1MbDy1JWhyEbXz5dtfHxcDEmhBMfwShky/EcTgO0v32wGyNp0aulmZ8JemCCuFJz
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3c04:b0:430:b467:1af8 with SMTP id
 e9e14a558f8ab-430c526fd94mr13929805ab.2.1760636200452; Thu, 16 Oct 2025
 10:36:40 -0700 (PDT)
Date: Thu, 16 Oct 2025 10:36:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f12d28.050a0220.1186a4.03dd.GAE@google.com>
Subject: [syzbot] [ext4?] WARNING in ext4_write_inode (3)
From: syzbot <syzbot+070d9738dbe6a10fadc8@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    67029a49db6c Merge tag 'trace-v6.18-3' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=165f3304580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c2d7b4143707d3a0
dashboard link: https://syzkaller.appspot.com/bug?extid=070d9738dbe6a10fadc8
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-67029a49.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/462968d248b4/vmlinux-67029a49.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9b7dac7b9874/bzImage-67029a49.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+070d9738dbe6a10fadc8@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 78 at fs/ext4/inode.c:5698 ext4_write_inode+0x545/0x620 fs/ext4/inode.c:5698
Modules linked in:
CPU: 0 UID: 0 PID: 78 Comm: kswapd0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:ext4_write_inode+0x545/0x620 fs/ext4/inode.c:5698
Code: 8b 05 cf b4 18 10 48 3b 44 24 30 75 5a 44 89 e0 48 83 c4 38 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc cc e8 1c 18 47 ff 90 <0f> 0b 90 eb cf e8 11 18 47 ff 41 bc fb ff ff ff eb c2 e8 04 18 47
RSP: 0018:ffffc9000102ec60 EFLAGS: 00010293
RAX: ffffffff82793b74 RBX: 0000000000000800 RCX: ffff88801fbec900
RDX: 0000000000000000 RSI: 0000000000000800 RDI: 0000000000000000
RBP: dffffc0000000000 R08: ffffffff8f9e3177 R09: 1ffffffff1f3c62e
R10: dffffc0000000000 R11: ffffffff82793630 R12: 0000000000000000
R13: ffff888036b70298 R14: ffff888036b70298 R15: ffff88801fbec900
FS:  0000000000000000(0000) GS:ffff88808d301000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcf30301010 CR3: 000000000df38000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 write_inode fs/fs-writeback.c:1564 [inline]
 __writeback_single_inode+0x6f1/0xff0 fs/fs-writeback.c:1784
 writeback_single_inode+0x1f9/0x6a0 fs/fs-writeback.c:1840
 write_inode_now+0x160/0x1d0 fs/fs-writeback.c:2903
 iput_final fs/inode.c:1901 [inline]
 iput+0x830/0xc50 fs/inode.c:1966
 __dentry_kill+0x209/0x660 fs/dcache.c:669
 dput+0x19f/0x2b0 fs/dcache.c:911
 ovl_destroy_inode+0x42/0x150 fs/overlayfs/super.c:209
 destroy_inode fs/inode.c:396 [inline]
 evict+0x7c2/0x9c0 fs/inode.c:834
 __dentry_kill+0x209/0x660 fs/dcache.c:669
 shrink_kill+0xa9/0x2c0 fs/dcache.c:1114
 shrink_dentry_list+0x2e0/0x5e0 fs/dcache.c:1141
 prune_dcache_sb+0x10e/0x180 fs/dcache.c:1222
 super_cache_scan+0x369/0x4b0 fs/super.c:222
 do_shrink_slab+0x6ef/0x1110 mm/shrinker.c:437
 shrink_slab_memcg mm/shrinker.c:550 [inline]
 shrink_slab+0x7ef/0x10d0 mm/shrinker.c:628
 shrink_one+0x28a/0x7c0 mm/vmscan.c:4955
 shrink_many mm/vmscan.c:5016 [inline]
 lru_gen_shrink_node mm/vmscan.c:5094 [inline]
 shrink_node+0x315d/0x3780 mm/vmscan.c:6081
 kswapd_shrink_node mm/vmscan.c:6941 [inline]
 balance_pgdat mm/vmscan.c:7124 [inline]
 kswapd+0x147c/0x2800 mm/vmscan.c:7389
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
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

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

