Return-Path: <linux-ext4+bounces-4086-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3908697164B
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Sep 2024 13:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E61F92816EB
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Sep 2024 11:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BCA1B5826;
	Mon,  9 Sep 2024 11:08:26 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6571B5327
	for <linux-ext4@vger.kernel.org>; Mon,  9 Sep 2024 11:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725880105; cv=none; b=e9W7Mpk4BvYjlSidxJqRfG1+c0zZQDf5lP9iQTuZgBceBcOUSXlx9nC2HWnsccOQFjExnYGZzYyQNTvX76ztO/g9ZOzapjtdvELu7oyREIfe9zS0IXKxFudvTZuoyiZ5cxxEm/bqafC3hyzO4M8HjPgBRayuuIRtI/Of6NFtXvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725880105; c=relaxed/simple;
	bh=rUzDs6mLqJgTrCo5kvYYYJn3gpuG+qZ6P7lWtsXtOqM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=t9P+J8ERm2ZJN69RiNJttYF/wA7CrXFKwRkejFaqpVGnkpGnO7MZerAbWpkstBaGGQovezRiVLCn9J9UI5PkI624nVwrVUwSvcWKgwMF7WESMvfFy2o6+njddZ4U8doJicPO7IP09CKlU/7mt58pQp4FYphw4rnMXoBAsNeHLWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82cdd759b8cso115936639f.1
        for <linux-ext4@vger.kernel.org>; Mon, 09 Sep 2024 04:08:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725880103; x=1726484903;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kCPcqboRpWrf76ORmrTxuibY5kxlPT6Nr2oaBdlhdXI=;
        b=OabxXhbbbTmBPZvbeg5QtDWMeijnEt5bisDGkhfrtZukUBRHar98oDtK0rxr8m+LU8
         Q00kbNhHFhYKaPa82/QkK5MoNZoBpEYWNc+xUT9Ga8pc1Ytytz/1K2b1SJwDdKOdJrWP
         k33VuZrNa54JhQRg7VT3wajjtRBvzDte6fDcH8OXccbkJHqBdUVRpcRjGApf/LvyF9Df
         1kpSbl/saPr1YTztBTyrCgmRyET04HMcw81iF8TW/sqPHv8kuH8VcRpRT4yZLD7hPhcH
         YeZI+H30XPNg3Megyef7tx79X0nvIjv9G958sMmtbvogQtCqX0znEsnfOAFbZVXTXsWU
         oOhA==
X-Forwarded-Encrypted: i=1; AJvYcCWLw99T/77rYYCu9qW0mXzzINQUod9cqc72YWW6bqbe6zOdNQ854KVG/2t2OD7sDslmlrH78utr3b5E@vger.kernel.org
X-Gm-Message-State: AOJu0YzN8aXlVCZAEbhlg2wcu/RHUc1wBQjb2AwgH9gszPZ+x1HGTzWa
	RfJthO26yUa8QG423b2O8mPKiu2b9v4a8jWvHjdFv8BbZ6wAcMWyc2hrmJAESlZu9EeXkqS/b6K
	6u4Q8U2DXVkCrVZm5LjyLZ3VzCU0WPpTFmqQVPd02lhcaDuyqQF65yD8=
X-Google-Smtp-Source: AGHT+IGZB3oPmQUQt6PLjEEazdYBs2/+tYTl764QsfHAljNNIp3MnkYSNkdFh3j/j6eZR7b8vbdwc1IVyFc6fRT3CjlVHYNzx/ao
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:20d7:b0:82a:13f0:800d with SMTP id
 ca18e2360f4ac-82a79200b84mr1444402739f.5.1725880103342; Mon, 09 Sep 2024
 04:08:23 -0700 (PDT)
Date: Mon, 09 Sep 2024 04:08:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007c26a30621adc624@google.com>
Subject: [syzbot] [ext4?] WARNING in jbd2_journal_dirty_metadata
From: syzbot <syzbot+5cdc66c11e7bf43a9931@syzkaller.appspotmail.com>
To: jack@suse.com, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b31c44928842 Merge tag 'linux_kselftest-kunit-fixes-6.11-r..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10d28600580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=58a85aa6925a8b78
dashboard link: https://syzkaller.appspot.com/bug?extid=5cdc66c11e7bf43a9931
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-b31c4492.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c7a83e0168a1/vmlinux-b31c4492.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f991c4e68b58/bzImage-b31c4492.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5cdc66c11e7bf43a9931@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5119 at fs/jbd2/transaction.c:1556 jbd2_journal_dirty_metadata+0x8b2/0xc00 fs/jbd2/transaction.c:1556
Modules linked in:
CPU: 0 UID: 0 PID: 5119 Comm: syz.0.0 Not tainted 6.11.0-rc6-syzkaller-00308-gb31c44928842 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:jbd2_journal_dirty_metadata+0x8b2/0xc00 fs/jbd2/transaction.c:1556
Code: 8b 44 24 08 49 89 e9 50 41 55 53 41 57 e8 96 fc 45 09 48 83 c4 20 90 0f 0b 90 bb ea ff ff ff e9 26 fe ff ff e8 6f df 22 ff 90 <0f> 0b 90 bb e4 ff ff ff e9 13 fe ff ff 89 d9 80 e1 07 80 c1 03 38
RSP: 0018:ffffc90002e1e798 EFLAGS: 00010283
RAX: ffffffff8270ad41 RBX: 0000000000000000 RCX: 0000000000040000
RDX: ffffc9000b77b000 RSI: 00000000000221a7 RDI: 00000000000221a8
RBP: 1ffff11007b37edc R08: ffffffff8270a96a R09: fffff520005c3ce4
R10: dffffc0000000000 R11: fffff520005c3ce4 R12: dffffc0000000000
R13: ffff8880419c0e80 R14: 1ffff110083381d0 R15: ffff88803d9bf690
FS:  00007f0458bdb6c0(0000) GS:ffff88801fe00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000201da000 CR3: 000000001feaa000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ocfs2_journal_dirty+0x156/0x7c0 fs/ocfs2/journal.c:812
 ocfs2_add_branch fs/ocfs2/alloc.c:1325 [inline]
 ocfs2_grow_tree+0x2761/0x37d0 fs/ocfs2/alloc.c:1585
 ocfs2_split_and_insert+0x421/0x1690 fs/ocfs2/alloc.c:4943
 ocfs2_split_extent+0x1319/0x2020 fs/ocfs2/alloc.c:5125
 ocfs2_change_extent_flag+0xa70/0xda0 fs/ocfs2/alloc.c:5222
 ocfs2_mark_extent_refcounted fs/ocfs2/refcounttree.c:2354 [inline]
 ocfs2_add_refcount_flag+0x89b/0x1150 fs/ocfs2/refcounttree.c:3701
 ocfs2_reflink_remap_extent fs/ocfs2/refcounttree.c:4542 [inline]
 ocfs2_reflink_remap_blocks+0xe58/0x1f30 fs/ocfs2/refcounttree.c:4669
 ocfs2_remap_file_range+0x600/0x8e0 fs/ocfs2/file.c:2724
 vfs_copy_file_range+0xc1f/0x1530 fs/read_write.c:1522
 __do_sys_copy_file_range fs/read_write.c:1612 [inline]
 __se_sys_copy_file_range+0x3f2/0x5d0 fs/read_write.c:1575
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0457d7cef9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0458bdb038 EFLAGS: 00000246 ORIG_RAX: 0000000000000146
RAX: ffffffffffffffda RBX: 00007f0457f36058 RCX: 00007f0457d7cef9
RDX: 0000000000000005 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007f0457def046 R08: 0000000000002fff R09: 0000000000000000
R10: 0000000020000640 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f0457f36058 R15: 00007ffff37854b8
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

