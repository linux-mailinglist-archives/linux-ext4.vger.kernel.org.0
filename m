Return-Path: <linux-ext4+bounces-2891-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2BF90D3B3
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Jun 2024 16:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C54FE288A6C
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Jun 2024 14:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD03E14B06C;
	Tue, 18 Jun 2024 13:57:24 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF34B13B780
	for <linux-ext4@vger.kernel.org>; Tue, 18 Jun 2024 13:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719044; cv=none; b=ncAvy+CAcc5eUa9nZw87vO8pKJJRkcO/x2HCfFH3qSV2i4Xl84v3KvwKJLPDPreES1ncFJRmfQfmqJ2JO8HHq8sxBiIbtLqu6NM5PGru0bqCPcmKNf8He9zO9vFvBdlLH7A5VA1PMCg5HSgkGzzJtt2L1vhZpYLvgGnuy6Od+pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719044; c=relaxed/simple;
	bh=phkVyprkZlRXl0ioMSwoOUZcGwCq68Cq5FvuXpKhzZY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ES/zj8HX43pXqdwblK6Fj0kCSpNoiQESIQPmwOZkbXK03v2OGV8FnbP5nM8CXJDyhbHt9S5spAno5N95cJPOPB98LNWbcOd1Iy7beaBiQQov9O+n3/CQL6LhGsnH1ixFUHj2hPmghqsE2li9i/2Z/2x6hxjWt4XXvokNYGp2oto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7eb7c3b8cf8so673825839f.0
        for <linux-ext4@vger.kernel.org>; Tue, 18 Jun 2024 06:57:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718719042; x=1719323842;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lrAzP9fwQeVGt1rs6C6zPpuJACa2vFihzxhS3uBR464=;
        b=PzQN/+ll6skMW8PsuRI49rfBe8lqLKGR5gnSwwd7wo9JTOscws7+37QrQ6Bq5pEzKZ
         Latz82+hVOHVQnFQQAe+N2k+sUnMHSoac09Y9e2ZlI31YkhrMDbcsq7JnPkDDsHVyxeq
         TrXf0ecnNvY1qtanBaJU32C3acPUPPbWjX/eKcCo5P0qZyNz7BojPyHOjz0a0Cj/HB2+
         s4yXClHoxFP3zvG1QjmZfCd6CWCTF5RDYamtWBiMPJJC+uGBUN70v/nyLN2+JN9bPPHl
         zM9jfNaDFoY2dNneLLHR41DnLCFyNBltgimD7a65W8pK4035OYmip3zbrWx/BpUDH/NK
         ML4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVudQr7n3g4dknyhE0Qoc2BoSybItaVl6X55QpAh7HeUpU06xtCEA3IV9SZfh1+mGKqITlrSomyWkEMPfrh1FtEmftowQjeshIEGg==
X-Gm-Message-State: AOJu0YxG6m0bEglhS1tZcjuwyR69o1SUbAILVqq86CBD13lAS/XToLHU
	9q+mbvMdP1qHZNH8f6/mNy8jU56/Zc+ZrYfon/s47bNHICnwg5pysU9ld7V3cizae7rhIqgXkBV
	i6TBuMvLNltobTd31Tq2IxgiVCziHBN/nwVEThl301g5UBhikQpivuyo=
X-Google-Smtp-Source: AGHT+IELYmIXGJtF1y4fFoLYfjw5YqVzyDJNTrDnkWwfrvEXy8K9qJLW6ZMral0lSsuwm/gEF/WnjygL3bT6Vdd4qEV52NlaGIrM
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:164e:b0:375:ae17:a2aa with SMTP id
 e9e14a558f8ab-375e0e9fc29mr9537425ab.3.1718719042057; Tue, 18 Jun 2024
 06:57:22 -0700 (PDT)
Date: Tue, 18 Jun 2024 06:57:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f8878d061b2a75d0@google.com>
Subject: [syzbot] [ext4?] WARNING in ext4_fileattr_get
From: syzbot <syzbot+d6a7a43c85606b87babd@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    14d7c92f8df9 Revert "mm: mmap: allow for the maximum numbe..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16e8c341980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a7c279056fc785df
dashboard link: https://syzkaller.appspot.com/bug?extid=d6a7a43c85606b87babd
compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/8ead8862021c/non_bootable_disk-14d7c92f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/14a0f94a4c14/vmlinux-14d7c92f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/aaa25622f902/zImage-14d7c92f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d6a7a43c85606b87babd@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 7719 at lib/string_helpers.c:1029 __fortify_report+0x6c/0x74 lib/string_helpers.c:1029
strnlen: detected buffer overflow: 17 byte read of buffer size 16
Modules linked in:
Kernel panic - not syncing: kernel: panic_on_warn set ...
CPU: 0 PID: 7719 Comm: syz-executor.0 Not tainted 6.10.0-rc4-syzkaller #0
Hardware name: ARM-Versatile Express
Call trace: 
[<818d4c98>] (dump_backtrace) from [<818d4d94>] (show_stack+0x18/0x1c arch/arm/kernel/traps.c:257)
 r7:00000000 r6:82622d44 r5:00000000 r4:81fe1404
[<818d4d7c>] (show_stack) from [<818f23c4>] (__dump_stack lib/dump_stack.c:88 [inline])
[<818d4d7c>] (show_stack) from [<818f23c4>] (dump_stack_lvl+0x54/0x7c lib/dump_stack.c:114)
[<818f2370>] (dump_stack_lvl) from [<818f2404>] (dump_stack+0x18/0x1c lib/dump_stack.c:123)
 r5:00000000 r4:8285fd18
[<818f23ec>] (dump_stack) from [<818d583c>] (panic+0x120/0x358 kernel/panic.c:347)
[<818d571c>] (panic) from [<80243dcc>] (check_panic_on_warn kernel/panic.c:240 [inline])
[<818d571c>] (panic) from [<80243dcc>] (print_tainted+0x0/0xa0 kernel/panic.c:235)
 r3:8260c5c4 r2:00000001 r1:81fca074 r0:81fd1cc4
 r7:8080f8d0
[<80243d58>] (check_panic_on_warn) from [<80243fc0>] (__warn+0x7c/0x180 kernel/panic.c:693)
[<80243f44>] (__warn) from [<802442ac>] (warn_slowpath_fmt+0x1e8/0x1f4 kernel/panic.c:726)
 r8:00000009 r7:8202ef04 r6:eab31db4 r5:84670c00 r4:00000000
[<802440c8>] (warn_slowpath_fmt) from [<8080f8d0>] (__fortify_report+0x6c/0x74 lib/string_helpers.c:1029)
 r10:8271c088 r9:00000003 r8:eab31ec3 r7:8408b000 r6:20000080 r5:837f3478
 r4:83f1c800
[<8080f864>] (__fortify_report) from [<818df088>] (__fortify_panic+0x10/0x14 lib/string_helpers.c:1036)
[<818df078>] (__fortify_panic) from [<8062b018>] (strnlen include/linux/fortify-string.h:235 [inline])
[<818df078>] (__fortify_panic) from [<8062b018>] (sized_strscpy include/linux/fortify-string.h:309 [inline])
[<818df078>] (__fortify_panic) from [<8062b018>] (ext4_ioctl_getlabel fs/ext4/ioctl.c:1154 [inline])
[<818df078>] (__fortify_panic) from [<8062b018>] (ext4_fileattr_get+0x0/0x78 fs/ext4/ioctl.c:1609)
[<80628f04>] (__ext4_ioctl) from [<8062b714>] (ext4_ioctl+0x10/0x14 fs/ext4/ioctl.c:1626)
 r10:84670c00 r9:00000003 r8:8747d3c0 r7:20000080 r6:8747d3c1 r5:00000000
 r4:81009431
[<8062b704>] (ext4_ioctl) from [<8051a9ac>] (vfs_ioctl fs/ioctl.c:51 [inline])
[<8062b704>] (ext4_ioctl) from [<8051a9ac>] (do_vfs_ioctl fs/ioctl.c:861 [inline])
[<8062b704>] (ext4_ioctl) from [<8051a9ac>] (__do_sys_ioctl fs/ioctl.c:905 [inline])
[<8062b704>] (ext4_ioctl) from [<8051a9ac>] (sys_ioctl+0x134/0xda4 fs/ioctl.c:893)
[<8051a878>] (sys_ioctl) from [<80200060>] (ret_fast_syscall+0x0/0x1c arch/arm/mm/proc-v7.S:67)
Exception stack(0xeab31fa8 to 0xeab31ff0)
1fa0:                   00000000 00000000 00000003 81009431 20000080 00000000
1fc0: 00000000 00000000 001542c8 00000036 7ea87336 7ea87337 003d0f00 76b280fc
1fe0: 76b27f08 76b27ef8 00016f30 000516d0
 r10:00000036 r9:84670c00 r8:8020029c r7:00000036 r6:001542c8 r5:00000000
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

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

