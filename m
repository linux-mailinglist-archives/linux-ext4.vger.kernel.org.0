Return-Path: <linux-ext4+bounces-4615-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8089A31B6
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Oct 2024 02:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03E26285947
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Oct 2024 00:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429993C466;
	Fri, 18 Oct 2024 00:39:28 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA6433981
	for <linux-ext4@vger.kernel.org>; Fri, 18 Oct 2024 00:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729211968; cv=none; b=mOtuBzn6R0W9xRU/CTHkDBHJViA5ra/LfhyfWaeNfz5f/+WIpYLYESIWdo8h7TbijfmvNFm9LvMqWkK4fMP7wpaCRD7xpOfVRcvcMtC7GqlYBMUZr9+/ZKSvw265fnQFt3P/HjPntrzdCn7n+4LRKYVW18nm1MERY6r/EUtyzpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729211968; c=relaxed/simple;
	bh=5fSEQNoeTbpyYXe9Yw6I7ojiSv3joK1cTUFEhHtdns0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZSfZgqKpqW3KAh6l2zEOhKiDqAsHj0f5/QB2ao1MjtfdA5+OBmNCEA9YkoPQi4msSOt9P8UuO0MOZDL0f48NGLlsG18I/PzrGzA4elVBZiDcYpoRSOheV+zkSA3h+PGLR09hdvL1TrcpSXFQdwGFqPV5NeWEHMmxc3rIe6+PJ6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3bf44b0f5so9074825ab.0
        for <linux-ext4@vger.kernel.org>; Thu, 17 Oct 2024 17:39:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729211965; x=1729816765;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N209BwSmweOzJ3ZaZRLkfvYT/6YztZMfKQHhqhiVp0Q=;
        b=uJOzYu6JnPovKqPRd1cOEYK3qEfcIBKPEBCfHg8yFmAnNSZpgdAgbF23uNVvjCkEho
         BXoTlJJAMF9m+ki9c4HCRdpqNdmxh7aqF1kUewLO8XUe7onM7+w/hwe2OXoQXKSxPsn7
         C0uQPKRJEZpWMDzuJ6WvQ55+mw3kQ7moTOVr+2lsuAqL3QcstghuM5bd42ssxzwoY/dL
         waGMT6bEbIuCGZOxiLIOpAAMsLod6kNgj1R5hAexhIAcS2xnTGyM3fOe+W/ypAIFs/Kw
         UA1xs4zd7KWKhpzN0F6AhJe2O0C6K6YeEzn9esW6+GWE/zA1TeCPQzD10k/iXj5JcooW
         N/2A==
X-Forwarded-Encrypted: i=1; AJvYcCWPK2ZVJsxY/A7YJw017pbWjyBnZGOBu1fN8WedMqxa53yfkjsmINoOQCV1LzSoMJ2xwcyAgprR0mrB@vger.kernel.org
X-Gm-Message-State: AOJu0YxKxaPN8bPjlc7/QYIc2ew3mzEHkBfswqONjhsaUaYLZuuCppX4
	Z5BBauR8Zxt0BxYekvDRdC17A+VNv6wgD+6sqIgbo+0oIaena7riji00LT3q7XlHsliSsbDcp2x
	XNMpdRhWCysGes0Td0Ms/77V73QipPLQydlvuBpe9mhV24XVGj9QSeeg=
X-Google-Smtp-Source: AGHT+IEDkVy45RIW7A+1vMsuVsYj/P0DjjZvK/1n/rREfT2H3I5/GDtE+P+r/XKroxGYdyGpST8HLdT4dL2rY+kQSP1OOqqXSIQ5
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18c6:b0:3a3:44e6:fe66 with SMTP id
 e9e14a558f8ab-3a3f4054402mr5612015ab.10.1729211965474; Thu, 17 Oct 2024
 17:39:25 -0700 (PDT)
Date: Thu, 17 Oct 2024 17:39:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6711ae3d.050a0220.1e4b4d.000a.GAE@google.com>
Subject: [syzbot] [ext4?] WARNING in ext4_journal_check_start (2)
From: syzbot <syzbot+b75d75f957975f3d40e3@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c964ced77262 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=158df45f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cfbd94c114a3d407
dashboard link: https://syzkaller.appspot.com/bug?extid=b75d75f957975f3d40e3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11361830580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14cc8240580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/45c8600041e4/disk-c964ced7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/71768ca7dfeb/vmlinux-c964ced7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/15d1aaba4355/bzImage-c964ced7.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/cd943498b7b9/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/67cd36770cec/mount_2.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b75d75f957975f3d40e3@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 2903 at fs/ext4/ext4_jbd2.c:76 ext4_journal_check_start+0x1f8/0x250 fs/ext4/ext4_jbd2.c:76
Modules linked in:
CPU: 1 UID: 0 PID: 2903 Comm: kworker/u8:6 Not tainted 6.12.0-rc3-syzkaller-00087-gc964ced77262 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: writeback wb_workfn (flush-7:2)
RIP: 0010:ext4_journal_check_start+0x1f8/0x250 fs/ext4/ext4_jbd2.c:76
Code: 5c 41 5d 41 5e 41 5f e9 c1 ca 97 09 e8 01 71 3c ff 41 bf fb ff ff ff eb e2 e8 f4 70 3c ff 90 0f 0b 90 eb d1 e8 e9 70 3c ff 90 <0f> 0b 90 43 80 7c 25 00 00 0f 85 03 ff ff ff e9 06 ff ff ff 89 d9
RSP: 0018:ffffc90009d46c40 EFLAGS: 00010293
RAX: ffffffff82587667 RBX: 0000000000000004 RCX: ffff88802f5a5a00
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000004
RBP: 0000000000000001 R08: ffffffff82587564 R09: 1ffff1100f968870
R10: dffffc0000000000 R11: ffffed100f968871 R12: dffffc0000000000
R13: 1ffff1100f9684c7 R14: ffff88807cb42000 R15: ffff88807cb42638
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f60253c26c0 CR3: 000000007ba9e000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 __ext4_journal_start_sb+0x181/0x600 fs/ext4/ext4_jbd2.c:105
 __ext4_journal_start fs/ext4/ext4_jbd2.h:326 [inline]
 ext4_do_writepages+0x112c/0x3d20 fs/ext4/inode.c:2707
 ext4_writepages+0x213/0x3c0 fs/ext4/inode.c:2813
 do_writepages+0x35f/0x870 mm/page-writeback.c:2683
 __writeback_single_inode+0x14f/0x10d0 fs/fs-writeback.c:1658
 writeback_sb_inodes+0x80c/0x1370 fs/fs-writeback.c:1954
 wb_writeback+0x41b/0xbd0 fs/fs-writeback.c:2134
 wb_do_writeback fs/fs-writeback.c:2281 [inline]
 wb_workfn+0x410/0x1090 fs/fs-writeback.c:2321
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa65/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
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

