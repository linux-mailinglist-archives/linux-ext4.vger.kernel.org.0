Return-Path: <linux-ext4+bounces-8580-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2CCAE282E
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Jun 2025 10:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D0947AE4FB
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Jun 2025 08:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C561E5713;
	Sat, 21 Jun 2025 08:57:29 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B0E1DEFE6
	for <linux-ext4@vger.kernel.org>; Sat, 21 Jun 2025 08:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750496248; cv=none; b=DqwTsjXVcFgh3oASF8yKaW7uFyOct3aRlPOgAvuk7e5ZjLnD24rUczNOwYUrn9VR2Izpw0nigPgR1XSeWPJwkdLuVFPQ/3IPYm1MyIG/vP8ZeZ/3BfuAPRwdgdPdrGr5nIK1BkDFShlB9i7xzAURQG8ljv2NAb9UT1yZst2t3LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750496248; c=relaxed/simple;
	bh=lub0b/szAmhbjFegTqAuxOlxZox4dvWvVbouOYfQolw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=J4cqtUcR652wClc81QshcDx5mr/yGgHodOQaZ4Cj6mNzQ5C+7SqFQL0+DbprwEaIVP//s1+39pmkoCN1LiRJP8aoiHVoc32mtx1Mu3lZHunP2RplHBuj2PxdPmTMVny3pemLVnGYwaVYfJzqoQvYQLEplg8QBWCHAXTgNg206Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3ddbfe1fc8fso59500135ab.2
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jun 2025 01:57:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750496246; x=1751101046;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sWF5o3kqcqNc4iUb3mWUMNuCp6m/AfkmZbA68N+x2G0=;
        b=A/Vf91D1MQndzNf1u1r5TbfZcGH2P0dmhC0M2PCXnPWdEcBh9r7B6Q7zWN5AnjFbAc
         gaPrdcdMBA0IChHdx8fECX4W6cWXCYZLmYnK19tojmWmxovyJeWUt2kTnj7tRGdNEi8P
         Cfxjf8ARIipT+Xfx/w6U5S6TyMPP2r3VSLvXoNs4jozJGn7Od6BVHIEugiXrpS26Ibda
         +IJ34l1UrlMM0/PDoKPS8PTgMPODH1oWhDquvPj2mVt8eQZM+NK+KP+j6Q2gFi4QZn9o
         Mmclk0FX6qgf13xf3NfUse0PxTQUXmBPEOLy9Ky54ekam3zBDGZMs6jfk6HCdNt/WIKR
         Y/GQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgRqULvD2hMBkgrmDO+yMVWXhn/AcSWUxG/YCa2xcBgklHIWfdrVZr/r0ti2G0+etlx0sU+bdU+0mO@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0XNFIsCto1mX0Chs0FXUgch8U107sInq/ZNhH1QzCthX9qa1s
	sl326xqeID4HL36eyLrC+fagigIIDXyg5QoC1lJ9ngPLAR2Dvq1Qn7I8akLriSn4uLRXq1ENg7X
	rq4pwFFbTE3SfKIq5dNpUiRtY3sxYpAse4Ee9S5iq+tiVwQb+freS6wyoSaQ=
X-Google-Smtp-Source: AGHT+IHZu9I9i6sUyg4UFksQfzf+xbzk1KcTMWEgivhOj6DfYvV0LtRITOLinL64OzMi6lNQ0CIoSJlPNnvPq8m5frHiHyAMm/Ue
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2482:b0:3dc:79e5:e6a8 with SMTP id
 e9e14a558f8ab-3de38cbf5d4mr71626705ab.15.1750496246272; Sat, 21 Jun 2025
 01:57:26 -0700 (PDT)
Date: Sat, 21 Jun 2025 01:57:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <685673f6.a00a0220.137b3.006d.GAE@google.com>
Subject: [syzbot] [ext4?] WARNING: locking bug in ext4_mb_initialize_context
From: syzbot <syzbot+ea221a9ce60300d76278@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9afe652958c3 Merge tag 'x86_urgent_for_6.16-rc3' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16b855d4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6a237c32900fc479
dashboard link: https://syzkaller.appspot.com/bug?extid=ea221a9ce60300d76278
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ca235ca5eaeb/disk-9afe6529.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ce4a880751fe/vmlinux-9afe6529.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a7c651092242/bzImage-9afe6529.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ea221a9ce60300d76278@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 0 PID: 6035 at kernel/locking/lockdep.c:238 hlock_class kernel/locking/lockdep.c:238 [inline]
WARNING: CPU: 0 PID: 6035 at kernel/locking/lockdep.c:238 check_wait_context kernel/locking/lockdep.c:4857 [inline]
WARNING: CPU: 0 PID: 6035 at kernel/locking/lockdep.c:238 __lock_acquire+0x379/0xd20 kernel/locking/lockdep.c:5190
Modules linked in:
CPU: 0 UID: 0 PID: 6035 Comm: syz.3.14 Not tainted 6.16.0-rc2-syzkaller-00024-g9afe652958c3 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:hlock_class kernel/locking/lockdep.c:238 [inline]
RIP: 0010:check_wait_context kernel/locking/lockdep.c:4857 [inline]
RIP: 0010:__lock_acquire+0x379/0xd20 kernel/locking/lockdep.c:5190
Code: eb 33 90 e8 c9 c7 18 03 85 c0 74 22 83 3d 52 dd 01 0e 00 75 19 90 48 c7 c7 e5 92 b5 8d 48 c7 c6 95 15 a5 8d e8 38 ce e5 ff 90 <0f> 0b 90 90 90 31 c0 48 8b 3c 24 0f b6 98 c4 00 00 00 41 8b 46 20
RSP: 0018:ffffc90004d76670 EFLAGS: 00010046
RAX: 81ee8a3c79ebc200 RBX: ffffe8ffffc6a7d8 RCX: 0000000000080000
RDX: ffffc9000c60a000 RSI: 0000000000001e53 RDI: 0000000000001e54
RBP: 00000000000009aa R08: ffff8880b8624293 R09: 1ffff110170c4852
R10: dffffc0000000000 R11: ffffed10170c4853 R12: 0000000000000000
R13: 0000000000000000 R14: ffff888034eb8b68 R15: ffff888034eb8af0
FS:  00007f5d1dc0e6c0(0000) GS:ffff888125c85000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7bbcce56c0 CR3: 0000000079236000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
 __mutex_lock_common kernel/locking/mutex.c:602 [inline]
 __mutex_lock+0x182/0xe80 kernel/locking/mutex.c:747
 ext4_mb_group_or_file fs/ext4/mballoc.c:5784 [inline]
 ext4_mb_initialize_context+0x893/0xcd0 fs/ext4/mballoc.c:5828
 ext4_mb_new_blocks+0x573/0x46a0 fs/ext4/mballoc.c:6202
 ext4_ext_map_blocks+0x161a/0x6ac0 fs/ext4/extents.c:4383
 ext4_map_create_blocks fs/ext4/inode.c:609 [inline]
 ext4_map_blocks+0x931/0x18d0 fs/ext4/inode.c:813
 ext4_iomap_alloc fs/ext4/inode.c:3680 [inline]
 ext4_iomap_begin+0xe67/0x18f0 fs/ext4/inode.c:3756
 iomap_iter+0x537/0xdf0 fs/iomap/iter.c:109
 __iomap_dio_rw+0xc67/0x1e40 fs/iomap/direct-io.c:733
 iomap_dio_rw+0x45/0xb0 fs/iomap/direct-io.c:823
 ext4_dio_write_iter fs/ext4/file.c:580 [inline]
 ext4_file_write_iter+0x16a2/0x1bc0 fs/ext4/file.c:721
 iter_file_splice_write+0x937/0x1000 fs/splice.c:738
 do_splice_from fs/splice.c:935 [inline]
 direct_splice_actor+0x101/0x160 fs/splice.c:1158
 splice_direct_to_actor+0x5a5/0xcc0 fs/splice.c:1102
 do_splice_direct_actor fs/splice.c:1201 [inline]
 do_splice_direct+0x181/0x270 fs/splice.c:1227
 do_sendfile+0x4da/0x7e0 fs/read_write.c:1370
 __do_sys_sendfile64 fs/read_write.c:1431 [inline]
 __se_sys_sendfile64+0x13e/0x190 fs/read_write.c:1417
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5d1cd8e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5d1dc0e038 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f5d1cfb5fa0 RCX: 00007f5d1cd8e929
RDX: 0000000000000000 RSI: 0000000000000008 RDI: 0000000000000007
RBP: 00007f5d1ce10b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000fffe82 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f5d1cfb5fa0 R15: 00007ffd2b8d2518
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

