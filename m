Return-Path: <linux-ext4+bounces-2236-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC2B8B5E8D
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Apr 2024 18:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5B9F1F24A5F
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Apr 2024 16:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BF284A5F;
	Mon, 29 Apr 2024 16:05:34 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71EC83A09
	for <linux-ext4@vger.kernel.org>; Mon, 29 Apr 2024 16:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714406734; cv=none; b=DrCJbvp5D7MhU8ggPilGxk4+BqUn0ppKuswzKS3g2Rj2YMIle9u55OzG3eeE4BkZpmbfzCSPkblbU2odzvrFPBvMcwuauCfJRWvYHFY8wJCeqI5wD01F0tjMQZFaqC3PP7K7RHDklZa4rzubG96ZyX/0WFSk0Ir4LdPOT77Y8bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714406734; c=relaxed/simple;
	bh=hiRsBpZoZcTi5qoEJ1/IvH/Ifa7hifEK7POZMgl74j0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rKaBLWxdAx+93Ypz1cl+IrYmp1CziEc4mXoquMLyzSKlOFd8TysV2gDO1UmhdaeWppR9ahj9zHfbvnG3PteoZ76AEGJfX9M5FKcYPrsyRKGqCotoQkBI+WaDKhpjl5rTrgUk+oeWYTzZCd4eGNTbnIj5UaR/iBcweFBuDhxm5IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7dea5889eb7so370939139f.1
        for <linux-ext4@vger.kernel.org>; Mon, 29 Apr 2024 09:05:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714406732; x=1715011532;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=93rlfPbij6l5AfI5569BrabwgqGsAA8Z5rOA/e+b6Xo=;
        b=Cnolrmj/tUBunp6QekhqIBXEmd8h2TMDgm9Rl9HB7N3bLsWy+kyZsoddK3uKfGy7pJ
         9icg0xVCYVOFKwqR7eakerIYOEG1yg5GZSPZPQjjzy9RPIIjBNzfNThz0CzXeP/8RyKc
         ukB5OR3GNPee0VOTMe7DL2Un8zfXscQ1ulZa+q3R1SLPpDEf65+SdxsZ0n1Gu8NHTd7i
         qEG+0W+JllwsXWoVsXuneluovuJZBvVyJrahWyhBOZBU0MBISouAUSr505a6qeFgGnXq
         ZpsgHz/gPMOaYn4T4L5bJdsovFWNh0B4TGwkD7Fu1r9rjp/PW+jeG51ZQPOa51dEgE3f
         ulSA==
X-Forwarded-Encrypted: i=1; AJvYcCVuOlmkwag7UfEpshIT5pq1rDwikgpT2gX2qGV5geNKdmo3q4tNXzREae1xmbSNV4U+kdv47mvyogWE6w+hPr2my7dk+4bBp1JowA==
X-Gm-Message-State: AOJu0YzhU+1/eXYiXC9PawYAriHcw8UDN0+Eqo9NbxhhvWcAUOp3pRSk
	9ks0XbJwrH4kE3TroOCoX1Kx18EPErBQvV2VqJZOwCijoX+2OLxhsX5hKnZKLKhwaaWpzs9nq2e
	kSODgNqKuqmIaKE28VYwUtEL4SQFQDF3+bllP24Ij5s6C4Jy4X7Gis5U=
X-Google-Smtp-Source: AGHT+IGv85KPokVkT162yvZpYCbRMU9EmRQ9fqyjXZXn1tM/O9TOHf/WV0VlbQPMLkv8KF8jnGZmSeiDnkJq+lhTd/gzX8sv5s4J
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3d86:b0:487:30aa:adb6 with SMTP id
 ci6-20020a0566383d8600b0048730aaadb6mr15264jab.2.1714406732068; Mon, 29 Apr
 2024 09:05:32 -0700 (PDT)
Date: Mon, 29 Apr 2024 09:05:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000440b0a06173e6ca8@google.com>
Subject: [syzbot] [ext4?] KMSAN: uninit-value in ext4_inlinedir_to_tree
From: syzbot <syzbot+eaba5abe296837a640c0@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e88c4cfcb7b8 Merge tag 'for-6.9-rc5-tag' of git://git.kern..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12fbc980980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=776c05250f36d55c
dashboard link: https://syzkaller.appspot.com/bug?extid=eaba5abe296837a640c0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13e2cd27180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1741a028980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/76771e00ba79/disk-e88c4cfc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c957ed943a4f/vmlinux-e88c4cfc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e719306ed8e3/bzImage-e88c4cfc.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/9d3c2a1fa449/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+eaba5abe296837a640c0@syzkaller.appspotmail.com

EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode: none.
EXT4-fs warning (device loop0): __ext4fs_dirhash:270: inode #12: comm syz-executor253: Siphash requires key
=====================================================
BUG: KMSAN: uninit-value in ext4_inlinedir_to_tree+0xde2/0x15a0 fs/ext4/inline.c:1415
 ext4_inlinedir_to_tree+0xde2/0x15a0 fs/ext4/inline.c:1415
 ext4_htree_fill_tree+0x1941/0x1cd0 fs/ext4/namei.c:1210
 ext4_dx_readdir fs/ext4/dir.c:597 [inline]
 ext4_readdir+0x4bbf/0x5b00 fs/ext4/dir.c:142
 iterate_dir+0x688/0x870 fs/readdir.c:110
 __do_sys_getdents64 fs/readdir.c:409 [inline]
 __se_sys_getdents64+0x169/0x530 fs/readdir.c:394
 __x64_sys_getdents64+0x96/0xe0 fs/readdir.c:394
 x64_sys_call+0x343d/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:218
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Local variable hinfo created at:
 ext4_htree_fill_tree+0x52/0x1cd0 fs/ext4/namei.c:1185
 ext4_dx_readdir fs/ext4/dir.c:597 [inline]
 ext4_readdir+0x4bbf/0x5b00 fs/ext4/dir.c:142

CPU: 1 PID: 5020 Comm: syz-executor253 Not tainted 6.9.0-rc5-syzkaller-00042-ge88c4cfcb7b8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
=====================================================


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

