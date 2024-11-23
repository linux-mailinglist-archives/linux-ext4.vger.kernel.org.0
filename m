Return-Path: <linux-ext4+bounces-5386-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFA09D6B7E
	for <lists+linux-ext4@lfdr.de>; Sat, 23 Nov 2024 21:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80E711620E3
	for <lists+linux-ext4@lfdr.de>; Sat, 23 Nov 2024 20:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F913189B8B;
	Sat, 23 Nov 2024 20:42:22 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7B015098F
	for <linux-ext4@vger.kernel.org>; Sat, 23 Nov 2024 20:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732394542; cv=none; b=sW02bJzgOA7IVJg8/uaoE6KHJ0310RY9GeIOPdnguctUK++OgoDH5LKgTVStx0eThD2vSr5mYnIaftBL4QcVIG/h5CzpM00HGjEhPAClUVvR5x3XZ3pPXA55irOgXEPhKJgMYPTtGfpdMJd4k22DNeWcjiEJu5+egtNhLjzVYKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732394542; c=relaxed/simple;
	bh=sAxJrHNk2HcF/xZs/Cd0jyUFG4+SVZcNHWZ2qubTljc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DixAi5DsxqFHB9C3tSssiB6PuAIwpZIP7B4Gx3kvwGsLEOmVO4V8EBDP24YQFrbp2e7zgJ2rCuHOXOXMIPXHEA/jAQb3sK0GoFKiibSIpGQrJvgZKp9vW2UQ0keRL0kAI9TTM3Asm6wPD2M5hP+6zsLqKsoqyZb41RAXy2Y/uUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83ab4cadf05so328642339f.1
        for <linux-ext4@vger.kernel.org>; Sat, 23 Nov 2024 12:42:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732394539; x=1732999339;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r5xb//LfxIX8p6Y7IvF2TwPUBJOmuJcwVWm1T3S6G9Q=;
        b=EAm2qTOn2ylmXxEF6QhUXJlnKWU1Pby4niXb2UnlwQ2gVTMIN9/FmyxoGvaToJnNn6
         TDyjAcQyKSd3JDGwNT75SR50tSOdFrHNJN2LZhxjOHTHCN2+JrZZpVTpvKnGb1AlyVWp
         U9urZ/jurXjCQda0Dky1py1SJsXRubzhnotU/Y8uX3zhCbzA9m9apX1t5Ej7c3WwPs+D
         X10e6gl0IqNeV1/82cZt0jTu1Qkr+yHF10sf1CJw93F8nXWMT/JS0D3wAhjx2Etv9I29
         3NoTVrnC6JPMFPGqpS28fprPTWfsFVQTo2q/ZDyRGLEdYmOt5KzamrWbCoGwjFUT79l1
         5JjA==
X-Forwarded-Encrypted: i=1; AJvYcCX3u6DRKiIgtGNRqoMs149cwBGiyhy1WmzS2KgI9zHoEhUEx8qXm9XiCirhzzO741sE+Kg11LnH8/Rs@vger.kernel.org
X-Gm-Message-State: AOJu0YwY4ckCPWdoitmzo025clYH3GtUp92FONJR9v62J15Tvee4rC1A
	Dw9Swjy9km/41jsVLv2hz2RnsZvsBnH8YKPMqXnskb2nzHY8DAUKtHFMjHP+WdseTgbqseCHvm9
	+ioDZPmbJGHX+vzZ3RTjAo6IJe8fsSwkTcenxHhoyaDSa9c1Tv63ea4E=
X-Google-Smtp-Source: AGHT+IGqLM1WnF7QbpwPkyvVDcPEkON+T6teMGuwdLiqyJEgJpHecMNaclz/zuUG+dBv7lupHah/4l1A8pWlFyjCjKDWctE2CuMF
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fed:b0:3a7:955e:1cc5 with SMTP id
 e9e14a558f8ab-3a79acf1b29mr91267925ab.1.1732394539519; Sat, 23 Nov 2024
 12:42:19 -0800 (PST)
Date: Sat, 23 Nov 2024 12:42:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67423e2b.050a0220.1cc393.001e.GAE@google.com>
Subject: [syzbot] [ext4?] INFO: task hung in do_get_write_access (3)
From: syzbot <syzbot+e7c786ece54bad9d1e43@syzkaller.appspotmail.com>
To: jack@suse.com, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    414c97c966b6 Add linux-next specific files for 20241119
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=170606c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=45719eec4c74e6ba
dashboard link: https://syzkaller.appspot.com/bug?extid=e7c786ece54bad9d1e43
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=108606c0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/394331d94392/disk-414c97c9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ad0dc40a5d80/vmlinux-414c97c9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fccab23947ef/bzImage-414c97c9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e7c786ece54bad9d1e43@syzkaller.appspotmail.com

INFO: task kworker/u8:9:3562 blocked for more than 143 seconds.
      Not tainted 6.12.0-next-20241119-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:9    state:D stack:18520 pid:3562  tgid:3562  ppid:2      flags:0x00004000
Workqueue: writeback wb_workfn (flush-8:0)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5369 [inline]
 __schedule+0x1850/0x4c30 kernel/sched/core.c:6756
 __schedule_loop kernel/sched/core.c:6833 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6848
 io_schedule+0x8d/0x110 kernel/sched/core.c:7681
 bit_wait_io+0x12/0xd0 kernel/sched/wait_bit.c:247
 __wait_on_bit_lock+0xd5/0x530 kernel/sched/wait_bit.c:90
 out_of_line_wait_on_bit_lock+0x1d5/0x260 kernel/sched/wait_bit.c:117
 lock_buffer include/linux/buffer_head.h:426 [inline]
 do_get_write_access+0x1be/0xe60 fs/jbd2/transaction.c:972
 jbd2_journal_get_write_access+0x1ee/0x240 fs/jbd2/transaction.c:1245
 __ext4_journal_get_write_access+0x1c8/0x680 fs/ext4/ext4_jbd2.c:239
 ext4_mb_mark_context+0x196/0xfb0 fs/ext4/mballoc.c:4003
 ext4_mb_mark_diskspace_used+0x3c8/0x960 fs/ext4/mballoc.c:4133
 ext4_mb_new_blocks+0x1494/0x4e30 fs/ext4/mballoc.c:6235
 ext4_ext_map_blocks+0x1beb/0x7e40 fs/ext4/extents.c:4379
 ext4_map_create_blocks fs/ext4/inode.c:516 [inline]
 ext4_map_blocks+0x8bf/0x1990 fs/ext4/inode.c:702
 mpage_map_one_extent fs/ext4/inode.c:2219 [inline]
 mpage_map_and_submit_extent fs/ext4/inode.c:2272 [inline]
 ext4_do_writepages+0x20ef/0x3d10 fs/ext4/inode.c:2735
 ext4_writepages+0x213/0x3c0 fs/ext4/inode.c:2824
 do_writepages+0x35f/0x880 mm/page-writeback.c:2702
 __writeback_single_inode+0x14f/0x10d0 fs/fs-writeback.c:1680
 writeback_sb_inodes+0x80c/0x1370 fs/fs-writeback.c:1976
 __writeback_inodes_wb+0x11b/0x260 fs/fs-writeback.c:2047
 wb_writeback+0x427/0xbc0 fs/fs-writeback.c:2158
 wb_check_old_data_flush fs/fs-writeback.c:2262 [inline]
 wb_do_writeback fs/fs-writeback.c:2315 [inline]
 wb_workfn+0xba1/0x1090 fs/fs-writeback.c:2343
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task jbd2/sda1-8:5166 blocked for more than 143 seconds.
      Not tainted 6.12.0-next-20241119-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:jbd2/sda1-8     state:D stack:24912 pid:5166  tgid:5166  ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5369 [inline]
 __schedule+0x1850/0x4c30 kernel/sched/core.c:6756
 __schedule_loop kernel/sched/core.c:6833 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6848
 jbd2_journal_wait_updates+0x1fd/0x2e0 fs/jbd2/transaction.c:847
 jbd2_journal_commit_transaction+0xb3a/0x66d0 fs/jbd2/commit.c:454
 kjournald2+0x41c/0x7b0 fs/jbd2/journal.c:201
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task syz.3.29:6604 blocked for more than 144 seconds.
      Not tainted 6.12.0-next-20241119-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.3.29        state:D stack:24312 pid:6604  tgid:6602  ppid:6386   flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5369 [inline]
 __schedule+0x1850/0x4c30 kernel/sched/core.c:6756
 __schedule_loop kernel/sched/core.c:6833 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6848
 io_schedule+0x8d/0x110 kernel/sched/core.c:7681
 folio_wait_bit_common+0x882/0x12b0 mm/filemap.c:1308
 folio_wait_writeback+0xe7/0x1e0 mm/page-writeback.c:3194
 __filemap_fdatawait_range+0x17c/0x2b0 mm/filemap.c:532
 file_write_and_wait_range+0x2f1/0x3c0 mm/filemap.c:791
 ext4_sync_file+0x25d/0xb90 fs/ext4/fsync.c:158
 __do_sys_msync mm/msync.c:96 [inline]
 __se_sys_msync+0x3d7/0x5a0 mm/msync.c:32
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f843df7e759
RSP: 002b:00007f843ed71038 EFLAGS: 00000246 ORIG_RAX: 000000000000001a
RAX: ffffffffffffffda RBX: 00007f843e135f80 RCX: 00007f843df7e759
RDX: 0000000000000006 RSI: 087abbe8d1cc6ad9 RDI: 0000000020952000
RBP: 00007f843dff175e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f843e135f80 R15: 00007fff5e31dab8
 </TASK>
INFO: task syz.1.28:6607 blocked for more than 144 seconds.
      Not tainted 6.12.0-next-20241119-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.1.28        state:D stack:25120 pid:6607  tgid:6606  ppid:6383   flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5369 [inline]
 __schedule+0x1850/0x4c30 kernel/sched/core.c:6756
 __schedule_loop kernel/sched/core.c:6833 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6848
 io_schedule+0x8d/0x110 kernel/sched/core.c:7681
 folio_wait_bit_common+0x882/0x12b0 mm/filemap.c:1308
 folio_wait_writeback+0xe7/0x1e0 mm/page-writeback.c:3194
 __filemap_fdatawait_range+0x17c/0x2b0 mm/filemap.c:532
 file_write_and_wait_range+0x2f1/0x3c0 mm/filemap.c:791
 ext4_sync_file+0x25d/0xb90 fs/ext4/fsync.c:158
 __do_sys_msync mm/msync.c:96 [inline]
 __se_sys_msync+0x3d7/0x5a0 mm/msync.c:32
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6260b7e759
RSP: 002b:00007f626197a038 EFLAGS: 00000246 ORIG_RAX: 000000000000001a
RAX: ffffffffffffffda RBX: 00007f6260d35f80 RCX: 00007f6260b7e759
RDX: 0000000000000006 RSI: 087abbe8d1cc6ad9 RDI: 0000000020952000
RBP: 00007f6260bf175e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f6260d35f80 R15: 00007ffdda3599f8
 </TASK>
INFO: task syz.7.25:6609 blocked for more than 144 seconds.
      Not tainted 6.12.0-next-20241119-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.7.25        state:D stack:24816 pid:6609  tgid:6608  ppid:6339   flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5369 [inline]
 __schedule+0x1850/0x4c30 kernel/sched/core.c:6756
 __schedule_loop kernel/sched/core.c:6833 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6848
 io_schedule+0x8d/0x110 kernel/sched/core.c:7681
 folio_wait_bit_common+0x882/0x12b0 mm/filemap.c:1308
 folio_wait_writeback+0xe7/0x1e0 mm/page-writeback.c:3194
 __filemap_fdatawait_range+0x17c/0x2b0 mm/filemap.c:532
 file_write_and_wait_range+0x2f1/0x3c0 mm/filemap.c:791
 ext4_sync_file+0x25d/0xb90 fs/ext4/fsync.c:158
 __do_sys_msync mm/msync.c:96 [inline]
 __se_sys_msync+0x3d7/0x5a0 mm/msync.c:32
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0b8397e759
RSP: 002b:00007f0b84713038 EFLAGS: 00000246 ORIG_RAX: 000000000000001a
RAX: ffffffffffffffda RBX: 00007f0b83b35f80 RCX: 00007f0b8397e759
RDX: 0000000000000006 RSI: 087abbe8d1cc6ad9 RDI: 0000000020952000
RBP: 00007f0b839f175e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f0b83b35f80 R15: 00007ffd10489398
 </TASK>
INFO: task syz.9.27:6617 blocked for more than 144 seconds.
      Not tainted 6.12.0-next-20241119-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.9.27        state:D stack:25120 pid:6617  tgid:6612  ppid:6344   flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5369 [inline]
 __schedule+0x1850/0x4c30 kernel/sched/core.c:6756
 __schedule_loop kernel/sched/core.c:6833 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6848
 io_schedule+0x8d/0x110 kernel/sched/core.c:7681
 folio_wait_bit_common+0x882/0x12b0 mm/filemap.c:1308
 folio_wait_writeback+0xe7/0x1e0 mm/page-writeback.c:3194
 __filemap_fdatawait_range+0x17c/0x2b0 mm/filemap.c:532
 file_write_and_wait_range+0x2f1/0x3c0 mm/filemap.c:791
 ext4_sync_file+0x25d/0xb90 fs/ext4/fsync.c:158
 __do_sys_msync mm/msync.c:96 [inline]
 __se_sys_msync+0x3d7/0x5a0 mm/msync.c:32
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd57a57e759
RSP: 002b:00007fd57b432038 EFLAGS: 00000246 ORIG_RAX: 000000000000001a
RAX: ffffffffffffffda RBX: 00007fd57a735f80 RCX: 00007fd57a57e759
RDX: 0000000000000006 RSI: 087abbe8d1cc6ad9 RDI: 0000000020952000
RBP: 00007fd57a5f175e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fd57a735f80 R15: 00007fff9330d8b8
 </TASK>
INFO: task syz.8.26:6616 blocked for more than 145 seconds.
      Not tainted 6.12.0-next-20241119-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.8.26        state:D stack:25120 pid:6616  tgid:6615  ppid:6343   flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5369 [inline]
 __schedule+0x1850/0x4c30 kernel/sched/core.c:6756
 __schedule_loop kernel/sched/core.c:6833 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6848
 io_schedule+0x8d/0x110 kernel/sched/core.c:7681
 folio_wait_bit_common+0x882/0x12b0 mm/filemap.c:1308
 folio_wait_writeback+0xe7/0x1e0 mm/page-writeback.c:3194
 __filemap_fdatawait_range+0x17c/0x2b0 mm/filemap.c:532
 file_write_and_wait_range+0x2f1/0x3c0 mm/filemap.c:791
 ext4_sync_file+0x25d/0xb90 fs/ext4/fsync.c:158
 __do_sys_msync mm/msync.c:96 [inline]
 __se_sys_msync+0x3d7/0x5a0 mm/msync.c:32
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8fc3f7e759
RSP: 002b:00007f8fc4e56038 EFLAGS: 00000246 ORIG_RAX: 000000000000001a
RAX: ffffffffffffffda RBX: 00007f8fc4135f80 RCX: 00007f8fc3f7e759
RDX: 0000000000000006 RSI: 087abbe8d1cc6ad9 RDI: 0000000020952000
RBP: 00007f8fc3ff175e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f8fc4135f80 R15: 00007ffeaf304488
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff8e937ae0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e937ae0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e937ae0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6744
6 locks held by kworker/u8:9/3562:
 #0: ffff8880202bd948 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff8880202bd948 ((wq_completion)writeback){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc9000d1ffd00 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc9000d1ffd00 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffff88814ef260e0 (&type->s_umount_key#32){++++}-{4:4}, at: super_trylock_shared+0x22/0xf0 fs/super.c:562
 #3: ffff88814ef28b98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_writepages_down_read fs/ext4/ext4.h:1776 [inline]
 #3: ffff88814ef28b98 (&sbi->s_writepages_rwsem){++++}-{0:0}, at: ext4_writepages+0x1bf/0x3c0 fs/ext4/inode.c:2823
 #4: ffff88814ef2a958 (jbd2_handle){++++}-{0:0}, at: start_this_handle+0x1e94/0x2110 fs/jbd2/transaction.c:448
 #5: ffff888075521658 (&ei->i_data_sem){++++}-{4:4}, at: ext4_map_blocks+0x7a6/0x1990 fs/ext4/inode.c:701
2 locks held by getty/5597:
 #0: ffff888034e310a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc900032f32f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x6a6/0x1e00 drivers/tty/n_tty.c:2211
2 locks held by syz-executor/5827:
 #0: ffff88802dbe2730 (&vma->vm_lock->lock){++++}-{4:4}, at: vma_start_read include/linux/mm.h:716 [inline]
 #0: ffff88802dbe2730 (&vma->vm_lock->lock){++++}-{4:4}, at: lock_vma_under_rcu+0x34b/0x790 mm/memory.c:6278
 #1: ffff88814ef26518 (sb_pagefaults){.+.+}-{0:0}, at: __sb_start_write include/linux/fs.h:1725 [inline]
 #1: ffff88814ef26518 (sb_pagefaults){.+.+}-{0:0}, at: sb_start_pagefault include/linux/fs.h:1890 [inline]
 #1: ffff88814ef26518 (sb_pagefaults){.+.+}-{0:0}, at: ext4_page_mkwrite+0x1ef/0xdf0 fs/ext4/inode.c:6158

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.12.0-next-20241119-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:234 [inline]
 watchdog+0xffb/0x1040 kernel/hung_task.c:397
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 1147 Comm: kworker/u8:6 Not tainted 6.12.0-next-20241119-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
Workqueue: events_unbound cfg80211_wiphy_work
RIP: 0010:cfg80211_put_bss+0x5/0x230 net/wireless/scan.c:3305
Code: 09 f3 f6 e9 b3 fe ff ff e8 a8 15 88 f6 90 0f 0b 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 55 <41> 57 41 56 41 55 41 54 53 49 89 f7 48 89 fb e8 77 15 88 f6 48 85
RSP: 0018:ffffc90004887830 EFLAGS: 00000293
RAX: 1ffff1100619b1d0 RBX: 0000000000000000 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: ffff88807d9b4c70 RDI: ffff888030cd8700
RBP: ffffc90004887ae8 R08: ffffffff8b37ab3c R09: 0000000000000000
R10: ffffc90004887750 R11: fffff52000910ef4 R12: dffffc0000000000
R13: dffffc0000000000 R14: ffff88807a08dbae R15: 1ffff92000910f20
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055b643a9cdb8 CR3: 000000000e736000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 ieee80211_rx_bss_info net/mac80211/ibss.c:1173 [inline]
 ieee80211_rx_mgmt_probe_beacon net/mac80211/ibss.c:1580 [inline]
 ieee80211_ibss_rx_queued_mgmt+0x1b1b/0x2d70 net/mac80211/ibss.c:1607
 ieee80211_iface_process_skb net/mac80211/iface.c:1616 [inline]
 ieee80211_iface_work+0x8a5/0xf20 net/mac80211/iface.c:1670
 cfg80211_wiphy_work+0x2db/0x490 net/wireless/core.c:440
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
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

