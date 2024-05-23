Return-Path: <linux-ext4+bounces-2633-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2DC8CCC42
	for <lists+linux-ext4@lfdr.de>; Thu, 23 May 2024 08:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 899A2B2194D
	for <lists+linux-ext4@lfdr.de>; Thu, 23 May 2024 06:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EB613B5A8;
	Thu, 23 May 2024 06:29:27 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DF313B59B
	for <linux-ext4@vger.kernel.org>; Thu, 23 May 2024 06:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716445767; cv=none; b=rMghx61RuoRMZfOM85Tyu7Q9E+zuf8Ge8N/dNltcBmno6LTJAm7t93kjv8a4u9Uh5XTRSF2SMW6FkTuZCyJZIupr4zYraVwBMgoK0jcgSDe1vM4m5MynahCyAakaIFTaTzQw0MoErwSPWx+sMaGpJSR66Bs59HFixk9yys1pIEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716445767; c=relaxed/simple;
	bh=J5ZpVyVAUpg4pyUCflJLXJxbcwWcZMn/drjfnI+AD/g=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HHsDW7S9xxZECKlcnIEkqQr3U7SJmW3pClTWDzRqQ6NvDTkR+/dFcZLlcaTUb3HAqT5DLIN73wykv/8bnFXi0eaTF66dWjVw89m/mTYrgHhwyeyY6q2HDFT3+ZZbrtemxUYNuxWdv0kFwzq/S/JQaLuqvO5Jgtyg7IQQViqoV5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-36c96503424so16608535ab.2
        for <linux-ext4@vger.kernel.org>; Wed, 22 May 2024 23:29:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716445765; x=1717050565;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n8NprSr1ChIB9sOY5kSoYkl/O9cUSM9fplRC4s3tYng=;
        b=NMpnijBWp7R2jXAuyh5lOe99HR0h51zBTNOGQuSDUWE18oneyAcB6Z/mxxDnHSjyqF
         PRfzptpDS4ADRxcpxSBBpWy+HMb3gfaDG3H+K/hjgLzj4QhjsdsEDfrDHztR7kSDdTNO
         BlA6WTvcLFmjBSW0amuOQNxyK3jJCHVMzzjXksmknNGT4k+wQYtMpGAqozOEU4AMfB/x
         a5pX75f4qPa6q7S2erZvT+SMY1N8kI7N6WfQQOg7HBEtqclLbG/JSjlYHCSv2vIKnc1x
         ceHCtL5tmX1C7U9mn11QZd5BQ91mRRJqhr1hT90uwiHjeT7RLV+N2qy/MyNpd2yxHMk8
         5FSQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5N/QBZvSxt6VzmsfxdtKd4cAy5xe2ueVu0uIcTI8ikVnmjABS9iMytE7nPUUy8cpWiIYPsYcYF5C+koAe4FVtjwqgn54q7N0BKA==
X-Gm-Message-State: AOJu0Ywp2i5jkN43PW0eGhCKjJv77mJfSFsTfxVzVhufnNeL2yoBLO6B
	fZ16yOZB57RoWstBDkZ04gG6rUnVrtLDxB7/PrU+fMFU3CkmJSwIv3epZ/7DLSQU0C23Os8L2wx
	BQAEjPvHmjSCX4AuMPoGaCeMdvusadQyGQ6hLwruk4qcUq3fM8Idnzi4=
X-Google-Smtp-Source: AGHT+IHN2y3KnTn3x8xNNPvRVm6HbPg02D7Zv4zP0a7ndXO9ZLfhjbbhLqpnCoZk2d+jCz3iQrBEgNnjqhB9GQli9lr+icrLbTqa
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d19:b0:36f:4a03:6406 with SMTP id
 e9e14a558f8ab-371faf4c83bmr3593655ab.5.1716445765033; Wed, 22 May 2024
 23:29:25 -0700 (PDT)
Date: Wed, 22 May 2024 23:29:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000019f4c00619192c05@google.com>
Subject: [syzbot] [ext4?] WARNING in __fortify_report
From: syzbot <syzbot+50835f73143cc2905b9e@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0450d2083be6 Merge tag '6.10-rc-smb-fix' of git://git.samb..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=152aa7d0980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=769d2e801ee872cc
dashboard link: https://syzkaller.appspot.com/bug?extid=50835f73143cc2905b9e
compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=103cb2a4980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16502844980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/8ead8862021c/non_bootable_disk-0450d208.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/11a51fed42ca/vmlinux-0450d208.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1df7cb920c72/zImage-0450d208.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+50835f73143cc2905b9e@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 3004 at lib/string_helpers.c:1029 __fortify_report+0x6c/0x74 lib/string_helpers.c:1029
strnlen: detected buffer overflow: 17 byte read of buffer size 16
Modules linked in:
Kernel panic - not syncing: kernel: panic_on_warn set ...
CPU: 0 PID: 3004 Comm: syz-executor296 Not tainted 6.9.0-syzkaller #0
Hardware name: ARM-Versatile Express
Call trace: 
[<818df678>] (dump_backtrace) from [<818df774>] (show_stack+0x18/0x1c arch/arm/kernel/traps.c:256)
 r7:00000000 r6:82622e04 r5:00000000 r4:81fe2534
[<818df75c>] (show_stack) from [<818fcdd8>] (__dump_stack lib/dump_stack.c:88 [inline])
[<818df75c>] (show_stack) from [<818fcdd8>] (dump_stack_lvl+0x54/0x7c lib/dump_stack.c:114)
[<818fcd84>] (dump_stack_lvl) from [<818fce18>] (dump_stack+0x18/0x1c lib/dump_stack.c:123)
 r5:00000000 r4:82860d18
[<818fce00>] (dump_stack) from [<818e021c>] (panic+0x120/0x358 kernel/panic.c:347)
[<818e00fc>] (panic) from [<80243d54>] (check_panic_on_warn kernel/panic.c:240 [inline])
[<818e00fc>] (panic) from [<80243d54>] (print_tainted+0x0/0xa0 kernel/panic.c:235)
 r3:8260c5c4 r2:00000001 r1:81fcb130 r0:81fd2d44
 r7:8080fe7c
[<80243ce0>] (check_panic_on_warn) from [<80243f48>] (__warn+0x7c/0x180 kernel/panic.c:693)
[<80243ecc>] (__warn) from [<80244234>] (warn_slowpath_fmt+0x1e8/0x1f4 kernel/panic.c:726)
 r8:00000009 r7:8202fe0c r6:df969db4 r5:836e6c00 r4:00000000
[<80244050>] (warn_slowpath_fmt) from [<8080fe7c>] (__fortify_report+0x6c/0x74 lib/string_helpers.c:1029)
 r10:8271c1c8 r9:00000005 r8:df969ec3 r7:8372e000 r6:00000000 r5:836be478
 r4:82e27000
[<8080fe10>] (__fortify_report) from [<818e9a40>] (__fortify_panic+0x10/0x14 lib/string_helpers.c:1036)
[<818e9a30>] (__fortify_panic) from [<8062a3b0>] (strnlen include/linux/fortify-string.h:221 [inline])
[<818e9a30>] (__fortify_panic) from [<8062a3b0>] (sized_strscpy include/linux/fortify-string.h:295 [inline])
[<818e9a30>] (__fortify_panic) from [<8062a3b0>] (ext4_ioctl_getlabel fs/ext4/ioctl.c:1154 [inline])
[<818e9a30>] (__fortify_panic) from [<8062a3b0>] (ext4_fileattr_get+0x0/0x78 fs/ext4/ioctl.c:1609)
[<8062829c>] (__ext4_ioctl) from [<8062aaac>] (ext4_ioctl+0x10/0x14 fs/ext4/ioctl.c:1626)
 r10:836e6c00 r9:00000005 r8:845e7900 r7:00000000 r6:845e7900 r5:00000000
 r4:81009431
[<8062aa9c>] (ext4_ioctl) from [<80518930>] (vfs_ioctl fs/ioctl.c:51 [inline])
[<8062aa9c>] (ext4_ioctl) from [<80518930>] (do_vfs_ioctl fs/ioctl.c:861 [inline])
[<8062aa9c>] (ext4_ioctl) from [<80518930>] (__do_sys_ioctl fs/ioctl.c:905 [inline])
[<8062aa9c>] (ext4_ioctl) from [<80518930>] (sys_ioctl+0x134/0xda4 fs/ioctl.c:893)
[<805187fc>] (sys_ioctl) from [<80200060>] (ret_fast_syscall+0x0/0x1c arch/arm/mm/proc-v7.S:67)
Exception stack(0xdf969fa8 to 0xdf969ff0)
9fa0:                   00000000 00000000 00000005 81009431 00000000 00000000
9fc0: 00000000 00000000 0008e060 00000036 000f4240 00000000 00000001 00003a97
9fe0: 7e98ac70 7e98ac60 00010764 0002e8c0
 r10:00000036 r9:836e6c00 r8:8020029c r7:00000036 r6:0008e060 r5:00000000
 r4:00000000
Rebooting in 86400 seconds..


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

