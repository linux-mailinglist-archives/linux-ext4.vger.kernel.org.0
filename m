Return-Path: <linux-ext4+bounces-4601-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9CF9A2A9C
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Oct 2024 19:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6703EB21F6B
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Oct 2024 17:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3548A1F4731;
	Thu, 17 Oct 2024 16:58:44 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5301E0E1E
	for <linux-ext4@vger.kernel.org>; Thu, 17 Oct 2024 16:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184323; cv=none; b=AiPXheh16cJGqC+0gc+4Rh+luyEPB6Ic81m4OfCPwPAne/9T8RFMU3CnjVsEgDMr+lHVixoaZ3qgr+IsnAz0w1xyvlZBqd5URRIT3xi7r8Rbe5JxzldwmfuwUGIiMb9ZE464BW6io5lfCiGfkLsUCkUcKQV5NhffcCW6UqOe+es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184323; c=relaxed/simple;
	bh=7YbQD8cLetHapQ6CCLa94g7znNsOotApkR1WM3YLPwY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=g7nP3vWth/hiv+kKsaPS1oQOwMIxA37XCItdY70rSGzFLQ8ZiGr30bNwZfRweghQiBGnoIJYcyKYggMmvqknYqvZV5CSzVWaJdqOveSGtc+ZX3I0088EuYJiswvDEoCdvCBcGIZXrpE3lwFHWBMnmZepnsZIEjyiJrOhPYZVbDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3b7129255so11503835ab.2
        for <linux-ext4@vger.kernel.org>; Thu, 17 Oct 2024 09:58:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729184318; x=1729789118;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=79cjQdibWULjOwjWvjlqagFC4XgdZamxycxUsvwt0S0=;
        b=tBRckSDMho7WCfwh/4rSyw9ds5Dl+o7mT/9gjR3PZapKweKJV7hnURqKXmOCtSG6m9
         J/g6tfWTSIkeHVgPVcxb5WxTA6huqNpbuIXPb6a8GuyT9ImhaJL915mu4wkxStlt6PG+
         mOpTVL4Hz8GMDroM2LAagbH0DtR5FDB5sFYhnPOR9pqFAxwbYP5RN9BHWde0CCvh5tGj
         4DfSP8PQF3CY9pay9qmgUpAp1T62pS04iD5lE3MXYkox4rvPcTdFFqaqrTJaKdM2eVlD
         I4omFICNyt+12itakSm2whfg9MJvk8vvSYWpMpbfHLmYd2Yy2ecMCaYLSwd/aem6WlSd
         qjjg==
X-Forwarded-Encrypted: i=1; AJvYcCXZ+NGpXJQ2eu1DfeZZJYW3/7KBt43pHC9V1Cjqw8aFlZDwD9bflf3tw9G9R7UPrahFbBZ6fNyUe3BH@vger.kernel.org
X-Gm-Message-State: AOJu0YwKAlsBTkN/TTrCvl9VSnjo/Wv23qPnpRBL6Yy1X7T/9gSXHbbA
	Sg5X0Fq/oo3oP+3F6bDJAv6fn7acp4cH991OxRbzeeI5fLcdbfUA6+PQgxDfJhHhSWBelPnPf3Z
	kx86PnUYdiI2pf0wvdTtWiuM8haOTa2++b538XCqQLTfsyRK4eZ57ghM=
X-Google-Smtp-Source: AGHT+IGpW0xuqa7ddvipdfnYt9Hb35BzdMnzmStx/8U/kihUTuPuTGpjwj/1jK4i627Q515+zIfU0LRvYCdEUADTUTJoDnwh4RCC
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17ce:b0:3a3:da4f:79f4 with SMTP id
 e9e14a558f8ab-3a3dc49fc9dmr74253015ab.2.1729184318273; Thu, 17 Oct 2024
 09:58:38 -0700 (PDT)
Date: Thu, 17 Oct 2024 09:58:38 -0700
In-Reply-To: <000000000000eacb0205d7c7865e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6711423e.050a0220.a68d8.0013.GAE@google.com>
Subject: Re: [syzbot] [ext4?] WARNING in ext4_write_inode (2)
From: syzbot <syzbot+748cc361874fca7d33cc@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    c964ced77262 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1575f45f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cfbd94c114a3d407
dashboard link: https://syzkaller.appspot.com/bug?extid=748cc361874fca7d33cc
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10561830580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=120c8240580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-c964ced7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e937ef58569a/vmlinux-c964ced7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f1df9880ca4b/bzImage-c964ced7.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/33caeecf49f6/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+748cc361874fca7d33cc@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 74 at fs/ext4/inode.c:5195 ext4_write_inode+0x627/0x6f0 fs/ext4/inode.c:5195
Modules linked in:
CPU: 0 UID: 0 PID: 74 Comm: kswapd0 Not tainted 6.12.0-rc3-syzkaller-00087-gc964ced77262 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:ext4_write_inode+0x627/0x6f0 fs/ext4/inode.c:5195
Code: ff ff ff 4d 85 ff 74 12 e8 16 38 34 ff 4c 89 ff e8 0e 7d c2 ff e9 cf fd ff ff e8 04 38 34 ff e9 c5 fd ff ff e8 fa 37 34 ff 90 <0f> 0b 90 e9 b7 fd ff ff e8 ec 37 34 ff e9 76 fd ff ff 44 89 f1 80
RSP: 0018:ffffc90000e46e20 EFLAGS: 00010293
RAX: ffffffff8260af56 RBX: 0000000000000800 RCX: ffff88801eea2440
RDX: 0000000000000000 RSI: 0000000000000800 RDI: 0000000000000000
RBP: ffffc90000e46f20 R08: ffffffff8260a9f2 R09: 1ffffffff2039fcd
R10: dffffc0000000000 R11: ffffffff8260a930 R12: 0000000000220840
R13: 1ffff920001c8dc8 R14: 0000000000000000 R15: ffff88801eea2440
FS:  0000000000000000(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbfc77f1af8 CR3: 000000000e734000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 write_inode fs/fs-writeback.c:1503 [inline]
 __writeback_single_inode+0x711/0x10d0 fs/fs-writeback.c:1723
 writeback_single_inode+0x1f3/0x660 fs/fs-writeback.c:1779
 write_inode_now+0x1dd/0x260 fs/fs-writeback.c:2829
 iput_final fs/inode.c:1864 [inline]
 iput+0x60d/0xa50 fs/inode.c:1903
 __dentry_kill+0x20d/0x630 fs/dcache.c:615
 shrink_kill+0xa9/0x2c0 fs/dcache.c:1060
 shrink_dentry_list+0x2c0/0x5b0 fs/dcache.c:1087
 prune_dcache_sb+0x10f/0x180 fs/dcache.c:1168
 super_cache_scan+0x34f/0x4b0 fs/super.c:221
 do_shrink_slab+0x701/0x1160 mm/shrinker.c:435
 shrink_slab+0x1093/0x14d0 mm/shrinker.c:662
 shrink_one+0x43b/0x850 mm/vmscan.c:4818
 shrink_many mm/vmscan.c:4879 [inline]
 lru_gen_shrink_node mm/vmscan.c:4957 [inline]
 shrink_node+0x3799/0x3de0 mm/vmscan.c:5937
 kswapd_shrink_node mm/vmscan.c:6765 [inline]
 balance_pgdat mm/vmscan.c:6957 [inline]
 kswapd+0x1ca3/0x3700 mm/vmscan.c:7226
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

