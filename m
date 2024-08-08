Return-Path: <linux-ext4+bounces-3668-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4649C94B5EF
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Aug 2024 06:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 693101C21945
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Aug 2024 04:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6746B84047;
	Thu,  8 Aug 2024 04:33:26 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952BC77103
	for <linux-ext4@vger.kernel.org>; Thu,  8 Aug 2024 04:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723091606; cv=none; b=q8VcPuWF73I6QFvB+ENGhfMSSdZ8jhd8Axf15HLyapFlCcSE410bNTt9MY3F6AK8802YueGTXhnl3AEI/ZB4WYhgOZl7AwNqLhWIZEF9BgN9NyXtwBCSUTFKPZXZkwhC0EBHY72Rto3hEMk66B2515u00MkvMuRCil4ojs1UDR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723091606; c=relaxed/simple;
	bh=GZ84eNB38uxTBB1qW0ohS5DQ8HFOmLwDlgWCvC/PJ/M=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hjzHgiyHolb4iylqw12EmR86qVqX8m5uDlRZ1ySspEqoCawWlRElETLrHgYh09KSkISNcJf/mT+kausA2VZXd1E9jhOD/okiHj/IHYIbQ+kcQZIVZGnUd5kUxyRhmzAwR8UgnkUt+o9oN/VuSBg0iGjRfyv6KtukYnVjNVL/TF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39a16e61586so7930535ab.3
        for <linux-ext4@vger.kernel.org>; Wed, 07 Aug 2024 21:33:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723091604; x=1723696404;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sODZFhFCDycVUFWw8oD00Ufq36ua/OtoTCbcpDRJURc=;
        b=jA8/PhpDXVrx12JiagDobrpupsNU3UlTgroEonYUeXagbuO1GSUcXfs81uFQFpQJQ0
         vjWm6p7Q7ko68rW97sdPOBvduYcFSrE18NSD7xQCtd01unAa3sWtztSLZxvuONKgWY4r
         VIb9XNpk0kZK+3U7c1j52KClqJ+A7HDH3fOQKxt7bL/P5x5B01dJ4lDyqHrySQMEV0ox
         MOigMbllZawg3iLHLBnKdC+Xc9ZVFgJdGggWMzdfHjNHI5obZeVKMyexuylTd/dWv+6J
         /e99cEPxcMYDwZSJqEus98c7vdshdpo5jg1eUlL5D6Ffjj1SnddMMroLHQAgyrs9Ge+4
         VaHw==
X-Forwarded-Encrypted: i=1; AJvYcCX4UqBCVbHW7UMEeGq5mfvZ7AIzPWyPrR6fiesyR6QwQ14uk0nsdBdckrn879tg43rOEilHG+hpow/x9Bfyy5eLG/Ar8L3+OE8iIg==
X-Gm-Message-State: AOJu0YzIbZDxz0+ZN1U6c+m2SkaC42NOUDBZLQbFR1Hk8LNAFlJvqNRj
	4JKlFPqfTL8E75qewsfQalIcgNN8E+1IZk4yo0L0y1SrtvCLE/dXsMDFvYVdh6iaHB+dotyt7Fe
	xclDQpacJaZj9d6FlX1/UJT6Z9igVnAURhRiRhXHyMK9vqnwpCacTVkA=
X-Google-Smtp-Source: AGHT+IFjIXnAypViXcBiJBJK+cAUkrdW/YSdAN1Jpxxv2h9margJ2gwmXITOp/BdhLz5jp+D8pegqvXXVY5mm3EFYNrbfKQY76qs
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13ab:b0:398:8d01:9c4c with SMTP id
 e9e14a558f8ab-39b5ed79c64mr663745ab.6.1723091603712; Wed, 07 Aug 2024
 21:33:23 -0700 (PDT)
Date: Wed, 07 Aug 2024 21:33:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f4847d061f24861b@google.com>
Subject: [syzbot] [ext4?] kernel BUG in ext4_mb_use_inode_pa (2)
From: syzbot <syzbot+d79019213609e7056a19@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    defaf1a2113a Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=145fe1c9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8da8b059e43c5370
dashboard link: https://syzkaller.appspot.com/bug?extid=d79019213609e7056a19
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/af289143b46d/disk-defaf1a2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/194e789e9f9f/vmlinux-defaf1a2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e00d8590048d/bzImage-defaf1a2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d79019213609e7056a19@syzkaller.appspotmail.com

EXT4-fs (sda1): Delayed block allocation failed for inode 1940 at logical offset 1516 with max blocks 20 with error 117
EXT4-fs (sda1): This should not happen!! Data will be lost
------------[ cut here ]------------
kernel BUG at fs/ext4/mballoc.c:4689!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 UID: 0 PID: 5797 Comm: kworker/u8:16 Not tainted 6.11.0-rc1-syzkaller-00293-gdefaf1a2113a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Workqueue: writeback wb_workfn (flush-8:0)
RIP: 0010:ext4_mb_use_inode_pa+0x4cf/0x5d0 fs/ext4/mballoc.c:4689
Code: 00 48 83 c4 30 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc e8 d2 91 43 ff 90 0f 0b e8 ca 91 43 ff 90 0f 0b e8 c2 91 43 ff 90 <0f> 0b e8 ba 91 43 ff 90 0f 0b e8 22 b9 a0 ff e9 11 fe ff ff 48 89
RSP: 0018:ffffc9000358eb88 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88806a511360 RCX: ffffffff8246e8ee
RDX: ffff888052c88000 RSI: ffffffff8246e96e RDI: 0000000000000004
RBP: ffff88806a419740 R08: 0000000000000004 R09: 0000000000000002
R10: 000000000000002c R11: 0000000000000000 R12: 0000000000000002
R13: 000000000000002c R14: 0000000000023800 R15: 0000000000023600
FS:  0000000000000000(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b301feff8 CR3: 000000006908c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ext4_mb_use_preallocated.constprop.0+0xeff/0x1520 fs/ext4/mballoc.c:4906
 ext4_mb_new_blocks+0x9b3/0x4e40 fs/ext4/mballoc.c:6210
 ext4_ext_map_blocks+0x1c24/0x5cd0 fs/ext4/extents.c:4318
 ext4_map_blocks+0x61d/0x17d0 fs/ext4/inode.c:652
 mpage_map_one_extent fs/ext4/inode.c:2237 [inline]
 mpage_map_and_submit_extent fs/ext4/inode.c:2290 [inline]
 ext4_do_writepages+0x172c/0x3250 fs/ext4/inode.c:2753
 ext4_writepages+0x303/0x730 fs/ext4/inode.c:2842
 do_writepages+0x1a3/0x7f0 mm/page-writeback.c:2683
 __writeback_single_inode+0x163/0xf90 fs/fs-writeback.c:1651
 writeback_sb_inodes+0x611/0x1150 fs/fs-writeback.c:1947
 __writeback_inodes_wb+0xff/0x2e0 fs/fs-writeback.c:2018
 wb_writeback+0x721/0xb50 fs/fs-writeback.c:2129
 wb_check_start_all fs/fs-writeback.c:2255 [inline]
 wb_do_writeback fs/fs-writeback.c:2281 [inline]
 wb_workfn+0x9fb/0xf40 fs/fs-writeback.c:2314
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf20 kernel/workqueue.c:3390
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ext4_mb_use_inode_pa+0x4cf/0x5d0 fs/ext4/mballoc.c:4689
Code: 00 48 83 c4 30 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc e8 d2 91 43 ff 90 0f 0b e8 ca 91 43 ff 90 0f 0b e8 c2 91 43 ff 90 <0f> 0b e8 ba 91 43 ff 90 0f 0b e8 22 b9 a0 ff e9 11 fe ff ff 48 89
RSP: 0018:ffffc9000358eb88 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88806a511360 RCX: ffffffff8246e8ee
RDX: ffff888052c88000 RSI: ffffffff8246e96e RDI: 0000000000000004
RBP: ffff88806a419740 R08: 0000000000000004 R09: 0000000000000002
R10: 000000000000002c R11: 0000000000000000 R12: 0000000000000002
R13: 000000000000002c R14: 0000000000023800 R15: 0000000000023600
FS:  0000000000000000(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b301feff8 CR3: 000000006908c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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

