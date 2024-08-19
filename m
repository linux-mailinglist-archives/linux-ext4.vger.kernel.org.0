Return-Path: <linux-ext4+bounces-3774-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E26E595671B
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Aug 2024 11:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 109EB1C217CC
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Aug 2024 09:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC5C15D5B9;
	Mon, 19 Aug 2024 09:32:25 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8068715C151
	for <linux-ext4@vger.kernel.org>; Mon, 19 Aug 2024 09:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724059945; cv=none; b=bZH+rgoY/3eo/wTyiDwHeip2wKLdkhv50RKl3i5Xo/Jz0/cEDBRe3naPK4+aGa6inBZXWtPl/nQ0RYrwUWmIYCmoOqiTZTc68kh23G+JfSCXgFS22WJRwI5K3CEzfyjxvFfgfO0GzyEn7cgEiMHPtrqVMHqeApq+qV9h/0nvka0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724059945; c=relaxed/simple;
	bh=5rMARzXfjykrfd6VRs6OIjWAzoKwx9rwjE22ch6ES3w=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LU4eXPdbqBn+3h9ZQqICnChrDU8yOadZpDLJISc3glEtZgqvPU0IC929LhGTBaFLQ+dc87tlDVaBl4c5unqmdujDj5jjROZIufWocMCg7LlQX6Vb/CjiqDZtHONlRIeYMNL4BIDnuiuBZKxwjnb8n7DFdpGXXu74/frYnty0i50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-81fa44764bbso447967139f.3
        for <linux-ext4@vger.kernel.org>; Mon, 19 Aug 2024 02:32:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724059942; x=1724664742;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=31Ti/nVOY7JVVGXS7iHukqNPYzxM76JGPC6XDQTDHuY=;
        b=ch0JIp3qLvoKDj7F1DVbccyLa8+KXigxrAx4OhJ46WRl/v6Dl3Z6kLUmwA8qIGFPrd
         nBSXSL8NOA8Hc/y7HrClTp7TbkW6YcShXHUN2FOAnR0FR5nhMhTV1cvY+gXL/Cy1Apt4
         ZijLs6sCf3t0hD7VWeVZH8EzsHqCkvi2e9RL1Hii7WPXcADJ++eujAEmlwDSTSreNNt5
         G+1kUVYlRCRHjHNNNkb7/oA4yqoJGbHGKdCxDk7NXoIMFftqFSDtd1EIC62hVFQ/KSUF
         ztgXIE4LvvMfTN2/g1fomyJvFb7oF7ROI0rCWe2we7jJEHjcLQU7CMqQfNB+HX/Tg78z
         sWEQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4IEZ6PuUt/8mlYh0T1hq4omdioiLm0L3WfFJHLzLu+u2aIGUCe+oiVTUcXDZet3v9c0jZCpaaE3X+aEe608vzye2zb1O6RaRk8g==
X-Gm-Message-State: AOJu0YyaI/SKxVnFg6pnc85BgYt6EynOW5O3zQv44cPQK7X+dSopNDYG
	3L25Ni/OPiimy5e77VpwoaxEkSPTuNPKqabuzPJpkPH09VGb80ixqTUdTWEpEnhpu8cEbhNDHjU
	dMUyD3WVorql2UquqNDx/tejXtUdS1nhqFyd5lmOjv/qmM7spxAT9b0o=
X-Google-Smtp-Source: AGHT+IF6qveUhN2bNVUNT25upCC6vqQ9wkR5DddErz2BaGezXnt0SC16TLAqfzkPEwvNmJUpTTVpZ5GjGO2r+Pd99XrDX74fqQFT
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:370f:b0:4b9:e5b4:67fd with SMTP id
 8926c6da1cb9f-4cce15cdbd5mr540564173.1.1724059942654; Mon, 19 Aug 2024
 02:32:22 -0700 (PDT)
Date: Mon, 19 Aug 2024 02:32:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000742b9d062005fc1c@google.com>
Subject: [syzbot] [ext4?] [ocfs2?] KASAN: null-ptr-deref Write in jbd2_journal_update_sb_log_tail
From: syzbot <syzbot+05b9b39d8bdfe1a0861f@syzkaller.appspotmail.com>
To: jack@suse.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, mark@fasheh.com, 
	ocfs2-devel@lists.linux.dev, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c3f2d783a459 Merge tag 'mm-hotfixes-stable-2024-08-17-19-3..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13736c29980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7229118d88b4a71b
dashboard link: https://syzkaller.appspot.com/bug?extid=05b9b39d8bdfe1a0861f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15f1b191980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1042525b980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-c3f2d783.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4d927f7c3cfd/vmlinux-c3f2d783.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ea54bdfad24b/bzImage-c3f2d783.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/562379f73e38/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+05b9b39d8bdfe1a0861f@syzkaller.appspotmail.com

(syz-executor198,5100,0):ocfs2_check_volume:2481 ERROR: status = -22
(syz-executor198,5100,0):ocfs2_mount_volume:1821 ERROR: status = -22
==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
BUG: KASAN: null-ptr-deref in test_and_set_bit_lock include/asm-generic/bitops/instrumented-lock.h:57 [inline]
BUG: KASAN: null-ptr-deref in trylock_buffer include/linux/buffer_head.h:420 [inline]
BUG: KASAN: null-ptr-deref in lock_buffer include/linux/buffer_head.h:426 [inline]
BUG: KASAN: null-ptr-deref in jbd2_journal_update_sb_log_tail+0x19b/0x360 fs/jbd2/journal.c:1889
Write of size 8 at addr 0000000000000000 by task syz-executor198/5100

CPU: 0 UID: 0 PID: 5100 Comm: syz-executor198 Not tainted 6.11.0-rc3-syzkaller-00338-gc3f2d783a459 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 print_report+0xe8/0x550 mm/kasan/report.c:491
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
 test_and_set_bit_lock include/asm-generic/bitops/instrumented-lock.h:57 [inline]
 trylock_buffer include/linux/buffer_head.h:420 [inline]
 lock_buffer include/linux/buffer_head.h:426 [inline]
 jbd2_journal_update_sb_log_tail+0x19b/0x360 fs/jbd2/journal.c:1889
 __jbd2_update_log_tail+0x48/0x3f0 fs/jbd2/journal.c:1079
 jbd2_cleanup_journal_tail+0x230/0x2d0 fs/jbd2/checkpoint.c:334
 jbd2_journal_flush+0x290/0xc10 fs/jbd2/journal.c:2479
 ocfs2_journal_shutdown+0x443/0xbe0 fs/ocfs2/journal.c:1081
 ocfs2_mount_volume+0x169f/0x1940 fs/ocfs2/super.c:1842
 ocfs2_fill_super+0x483b/0x5880 fs/ocfs2/super.c:1084
 mount_bdev+0x20a/0x2d0 fs/super.c:1679
 legacy_get_tree+0xee/0x190 fs/fs_context.c:662
 vfs_get_tree+0x90/0x2a0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3472
 do_mount fs/namespace.c:3812 [inline]
 __do_sys_mount fs/namespace.c:4020 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:3997
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f69037ad16a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffed646ff58 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffed646ff70 RCX: 00007f69037ad16a
RDX: 0000000020004480 RSI: 00000000200044c0 RDI: 00007ffed646ff70
RBP: 0000000000000004 R08: 00007ffed646ffb0 R09: 0000000000004470
R10: 0000000000000000 R11: 0000000000000282 R12: 0000000000000000
R13: 00007ffed646ffb0 R14: 0000000000000003 R15: 0000000001000000
 </TASK>
==================================================================


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

