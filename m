Return-Path: <linux-ext4+bounces-1096-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9019A8495C7
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Feb 2024 10:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3E4F1C23F12
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Feb 2024 09:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794AB11CB6;
	Mon,  5 Feb 2024 09:01:46 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721BA12E45
	for <linux-ext4@vger.kernel.org>; Mon,  5 Feb 2024 09:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707123706; cv=none; b=t/7avx3b+jgXQNOReMd1og/M6vWqlwJQlSyQ9FbdE+QDQsT0uDYNBgWWRZZK/KNhQquZaXVfPxxQpJYtwLR+IQx+dc2sKnSb5h7HQYfkt6dogrRVOVOVlqqJjsA0/4qhqfxky6k25dl9F+fzJofW3AnTWmfQp61zwF090XPq0/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707123706; c=relaxed/simple;
	bh=Y1tvMdcD1KcRa8ihdcMDLe2VTaYbBW2VHfg53zzTNxA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qKidPs9heHWuItRHwuqyJnFFAXC+SmAjONymWxQzFK2kHlfHplAl+ZQ7MagtqspS4DXwFAC0n01z3JIacerLdBXTUGH73e/dpZbO6DkJjc23+Rg8bg0oDP2c6bhl0n8lTbF7pS6Z72l/qDFrFBn87rSVc52vuv2Bg/rhp4iLmoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7becfc75cd4so355537539f.3
        for <linux-ext4@vger.kernel.org>; Mon, 05 Feb 2024 01:01:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707123703; x=1707728503;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DL7sT0R0lCMePu4/4pnetWzg+tj7VTTtQXhE0cYtBTE=;
        b=hmyaBEeocpjndYMLA3HT0x+Bm/i6MEVBLVaTbf94QGe8/EOTZ7pgvz5i9G0Ai1Gwse
         Wo8xhTdhnz/yhRCckvzS6VPxQGLNGwSVYESIgcqoJUcu5ZNuQT8Fu4GYlqWkP1U6u04+
         5Kw6pQ71btYi9qbXn/Lb+eHqZPeHsTKUpaLtZzj49pUgCrWdeNg9usXbQGVsLaXqexrf
         xJp37a03NGizUG8F2f9WgE6TYaVY1Eff1q3RpAmeKeW4LP6xMdhF//CsgQRwJ/oqd4S0
         BuUokErK7J92Ix96+DwjseDJJidscoR53aJr/7V4J49piHMYkcFFlEgZLWsIVb5BP0m9
         7slg==
X-Gm-Message-State: AOJu0YxUkS46fUbNGTwgoJZj2OzTHw8/oGppVqtAn6s9DVh6pDxGInZb
	AL61V5OHjUEQvw4PWdwcupHnfIPsDkSH2RqPAw9gSvuuk9WemtgfChwwlWyMWa3i5KSHvdU0meE
	02IIJYZE1C6La05RPpGgYbrSsdzQGK+WmJ14Ltx/nZKfOLPT00uCAFwg=
X-Google-Smtp-Source: AGHT+IGtQjw4M7O1hHR4+f3rLVTV1yft0FTQPoMe0O5W1v3q58JneTGq6ZgeJuRNi5dOMcqrrcyOhHSsvN+fyCo/ZlmlbC7Vcj83
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:216a:b0:35f:eb20:3599 with SMTP id
 s10-20020a056e02216a00b0035feb203599mr553015ilv.2.1707123703648; Mon, 05 Feb
 2024 01:01:43 -0800 (PST)
Date: Mon, 05 Feb 2024 01:01:43 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f19a1406109eb5c5@google.com>
Subject: [syzbot] [ext4?] general protection fault in __block_commit_write
From: syzbot <syzbot+18df508cf00a0598d9a6@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    56897d51886f Merge tag 'trace-v6.8-rc2' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1550b18fe80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b60b985eda147877
dashboard link: https://syzkaller.appspot.com/bug?extid=18df508cf00a0598d9a6
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=166f7aa8180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1c0cc47da79d/disk-56897d51.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ef9122f0ce05/vmlinux-56897d51.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8e2856cfcf95/bzImage-56897d51.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/5175bbf40ca7/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+18df508cf00a0598d9a6@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 2048
general protection fault, probably for non-canonical address 0xdffffc0000000004: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000020-0x0000000000000027]
CPU: 0 PID: 6860 Comm: syz-executor.0 Not tainted 6.8.0-rc2-syzkaller-00397-g56897d51886f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
RIP: 0010:__block_commit_write+0x61/0x270 fs/buffer.c:2165
Code: ea 03 80 3c 02 00 0f 85 16 02 00 00 48 8b 44 24 18 4c 8b 78 28 48 b8 00 00 00 00 00 fc ff df 49 8d 7f 20 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 e4 01 00 00 41 8b 47 20 4c 89 fb 45 31 f6 31 ed
RSP: 0018:ffffc90008947918 EFLAGS: 00010212
RAX: dffffc0000000000 RBX: ffffea00019b1180 RCX: ffffffff82086d31
RDX: 0000000000000004 RSI: ffffffff820823e4 RDI: 0000000000000020
RBP: 0000000000000040 R08: 0000000000000004 R09: 0000000000000040
R10: 0000000000000040 R11: 0000000000000003 R12: 0000000000000000
R13: 0000000000000040 R14: 0000000000000040 R15: 0000000000000000
FS:  00007f6f6a4016c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020007640 CR3: 0000000015340000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 block_write_end+0xc8/0x250 fs/buffer.c:2251
 ext4_write_end+0x277/0xed0 fs/ext4/inode.c:1287
 ext4_da_write_end+0xa64/0xce0 fs/ext4/inode.c:3020
 generic_perform_write+0x33b/0x620 mm/filemap.c:3941
 ext4_buffered_write_iter+0x11f/0x3d0 fs/ext4/file.c:299
 ext4_file_write_iter+0x819/0x1960 fs/ext4/file.c:698
 call_write_iter include/linux/fs.h:2085 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0x6e1/0x1110 fs/read_write.c:590
 ksys_write+0x12f/0x260 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd8/0x270 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7f6f6967dda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6f6a4010c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f6f697abf80 RCX: 00007f6f6967dda9
RDX: 0000000000000040 RSI: 0000000020002ac0 RDI: 0000000000000005
RBP: 00007f6f696ca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f6f697abf80 R15: 00007ffc14067c28
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__block_commit_write+0x61/0x270 fs/buffer.c:2165
Code: ea 03 80 3c 02 00 0f 85 16 02 00 00 48 8b 44 24 18 4c 8b 78 28 48 b8 00 00 00 00 00 fc ff df 49 8d 7f 20 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 e4 01 00 00 41 8b 47 20 4c 89 fb 45 31 f6 31 ed
RSP: 0018:ffffc90008947918 EFLAGS: 00010212
RAX: dffffc0000000000 RBX: ffffea00019b1180 RCX: ffffffff82086d31
RDX: 0000000000000004 RSI: ffffffff820823e4 RDI: 0000000000000020
RBP: 0000000000000040 R08: 0000000000000004 R09: 0000000000000040
R10: 0000000000000040 R11: 0000000000000003 R12: 0000000000000000
R13: 0000000000000040 R14: 0000000000000040 R15: 0000000000000000
FS:  00007f6f6a4016c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9a064f7000 CR3: 0000000015340000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	03 80 3c 02 00 0f    	add    0xf00023c(%rax),%eax
   6:	85 16                	test   %edx,(%rsi)
   8:	02 00                	add    (%rax),%al
   a:	00 48 8b             	add    %cl,-0x75(%rax)
   d:	44 24 18             	rex.R and $0x18,%al
  10:	4c 8b 78 28          	mov    0x28(%rax),%r15
  14:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  1b:	fc ff df
  1e:	49 8d 7f 20          	lea    0x20(%r15),%rdi
  22:	48 89 fa             	mov    %rdi,%rdx
  25:	48 c1 ea 03          	shr    $0x3,%rdx
* 29:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2d:	0f 85 e4 01 00 00    	jne    0x217
  33:	41 8b 47 20          	mov    0x20(%r15),%eax
  37:	4c 89 fb             	mov    %r15,%rbx
  3a:	45 31 f6             	xor    %r14d,%r14d
  3d:	31 ed                	xor    %ebp,%ebp


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

