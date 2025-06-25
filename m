Return-Path: <linux-ext4+bounces-8639-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97424AE86C8
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Jun 2025 16:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7A29172268
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Jun 2025 14:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7E1267B90;
	Wed, 25 Jun 2025 14:41:29 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290B42620E4
	for <linux-ext4@vger.kernel.org>; Wed, 25 Jun 2025 14:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750862489; cv=none; b=KbOvVY2SHJdtxYptwwwygDUg+ykxACs8ICweMX6YkB1DL3BDsDe1iJ2tnkoWhb50bJ766zlCzj6j0sJ/kicPTpHhok/BGsOihc1ki0lQth5RDUrvc530niH4DHbuPi/k52j9PeCR1A3JmXbh18lQWb0vefHiDT9WvVbqn+q+8F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750862489; c=relaxed/simple;
	bh=OByHNjmN/xaoYcZp3ws/ocDd7Iqgcjfde70VtKIxQEo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZyfG3+VkkGzaapKOyqpgxZ+CwBEU/j/eBy7N8RKXerIhxmAF8Ded0hdAnJL7t5Ob7P8Q2uLv9xIW+XeV+2i4bT7Do7ZQPr5jJhXBGTdx3r3PF1/hGs/28JjNu8Kr13zFE/sEsoCNWjg6LV0/H0gR1n1KQyj9idWl3duw0nZQRQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3ddbec809acso24361345ab.2
        for <linux-ext4@vger.kernel.org>; Wed, 25 Jun 2025 07:41:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750862486; x=1751467286;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XjoRFej/UKb8LuFDoRlRF1Np8CWhwwmwQcq7gCrq3vg=;
        b=cUoUf/vecHZRzRsa41Veeh8eEcDkN96FzTtUfgvLCN/2f2St+sEljEw7XbCK9u70b2
         //B3/BPSLZOBoOmHv04WT0Y6mFRlUC/YUX2pVdUT7brsaD5lzCPxaD4EcKKVG3iyelgp
         82q698wjY2OSfh/ozJ1ufkERSbL+uKGw9vNJ/NrPJ1aF6vFwntH+IMzuivp07KZtBMTK
         bppchdBuyH6oSv2JYf7fGIEvj9N671e9w36QxD1IWc0JmQCTbPChhwaiEJ0Gl1NkJA5z
         ZDQhz+BWWO77ETbcJcQQtn83KeN3u+bMaAyJ/IDUIKUJXCeNfKX2hWd9mMCKLODzmx6X
         EHnw==
X-Forwarded-Encrypted: i=1; AJvYcCU7sQauWUxfnyhUJfJg9TPWjNXlyCzKbqhv4dBK4hV7huPZEWRKAkrPCWm55B9IYzNI7LdvyTrgxS3O@vger.kernel.org
X-Gm-Message-State: AOJu0YzErwt1N4ESDbtuh26mGR7S4FtOccMKzr7Nse+Xe1aRMrM/Hwn1
	JYYy3pMrhWrHv6gEqun597f7r/0jAXmk3FHsQER0Es9XCAIYrEHio9O1pllBMDp897CBTMOfCNY
	8rlhCligaOgyS6UR+JcJPGmPiaFm8d5keKin8SEciONKZ/dKnYf/GyjVYtpw=
X-Google-Smtp-Source: AGHT+IGUhXYBuDfGFwI0FKkrMRCOgbtkJD7xxrow/+iajmYcam1hY2is0OzHQPo/I0qDtDU3UUjpNtjL25Totmrl3lDoM1Cclo3V
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c24f:0:b0:3dc:8bb8:28a1 with SMTP id
 e9e14a558f8ab-3df3296d5ebmr39617735ab.14.1750862486178; Wed, 25 Jun 2025
 07:41:26 -0700 (PDT)
Date: Wed, 25 Jun 2025 07:41:26 -0700
In-Reply-To: <67ea7949.050a0220.1547ec.0137.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <685c0a96.a00a0220.2e5631.00d9.GAE@google.com>
Subject: Re: [syzbot] [ext4?] KASAN: slab-use-after-free Read in ext4_ext_remove_space
From: syzbot <syzbot+b73703b873a33d8eb8f6@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    9aa9b43d689e Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1052df0c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=27f179c74d5c35cd
dashboard link: https://syzkaller.appspot.com/bug?extid=b73703b873a33d8eb8f6
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10809b70580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=106cbdd4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/974f3ac1c6a5/disk-9aa9b43d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a5b5075d317f/vmlinux-9aa9b43d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2f0ba7fec19b/Image-9aa9b43d.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/e99c31ce9609/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=13c1d182580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b73703b873a33d8eb8f6@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in ext4_ext_rm_leaf fs/ext4/extents.c:2627 [inline]
BUG: KASAN: use-after-free in ext4_ext_remove_space+0x276c/0x37c8 fs/ext4/extents.c:2965
Read of size 4 at addr ffff0000df6bdc18 by task syz-executor309/6516

CPU: 1 UID: 0 PID: 6516 Comm: syz-executor309 Not tainted 6.16.0-rc2-syzkaller-g9aa9b43d689e #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:501 (C)
 __dump_stack+0x30/0x40 lib/dump_stack.c:94
 dump_stack_lvl+0xd8/0x12c lib/dump_stack.c:120
 print_address_description+0xa8/0x254 mm/kasan/report.c:408
 print_report+0x68/0x84 mm/kasan/report.c:521
 kasan_report+0xb0/0x110 mm/kasan/report.c:634
 __asan_report_load4_noabort+0x20/0x2c mm/kasan/report_generic.c:380
 ext4_ext_rm_leaf fs/ext4/extents.c:2627 [inline]
 ext4_ext_remove_space+0x276c/0x37c8 fs/ext4/extents.c:2965
 ext4_ext_truncate+0x134/0x1d0 fs/ext4/extents.c:4484
 ext4_truncate+0x9c4/0xfe0 fs/ext4/inode.c:4574
 ext4_evict_inode+0x9b4/0x104c fs/ext4/inode.c:261
 evict+0x414/0x928 fs/inode.c:810
 iput_final fs/inode.c:1898 [inline]
 iput+0x6e4/0x83c fs/inode.c:1924
 do_unlinkat+0x338/0x4dc fs/namei.c:4657
 __do_sys_unlinkat fs/namei.c:4691 [inline]
 __se_sys_unlinkat fs/namei.c:4684 [inline]
 __arm64_sys_unlinkat+0xdc/0xf8 fs/namei.c:4684
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x58/0x17c arch/arm64/kernel/entry-common.c:767
 el0t_64_sync_handler+0x78/0x108 arch/arm64/kernel/entry-common.c:786
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xea pfn:0x11f6bd
flags: 0x5ffc00000000000(node=0|zone=2|lastcpupid=0x7ff)
raw: 05ffc00000000000 fffffdffc37daf88 fffffdffc37daf08 0000000000000000
raw: 00000000000000ea 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff0000df6bdb00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff0000df6bdb80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff0000df6bdc00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                            ^
 ffff0000df6bdc80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff0000df6bdd00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 2244176752, count = 0
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 147072565182463, count = 27456
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 32928, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 175, count = 32767
EXT4-fs error (device loop0): mb_free_blocks:1948: group 0, inode 18: block 145:freeing already freed block (bit 9); block bitmap corrupt.
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 0, count = 174
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 0, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 2244176584, count = 0
EXT4-fs (loop0): unmounting filesystem 00000000-0000-0000-0000-000000000000.
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 0, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 0, count = 4
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 0, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 3036617056, count = 0
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 4294967295, count = 0
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 4294967280, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 199007309732176, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 199007309725695, count = 6492
EXT4-fs (loop0): unmounting filesystem 00000000-0000-0000-0000-000000000000.
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 111477107367824, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 111477107342893, count = 24934
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 111477107342880, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 121450642510224, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 121450642499955, count = 10272
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 121450642499952, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 35650244284304, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 35650244255805, count = 28515
EXT4-fs (loop0): unmounting filesystem 00000000-0000-0000-0000-000000000000.
EXT4-fs (loop0): unmounting filesystem 00000000-0000-0000-0000-000000000000.
EXT4-fs (loop0): unmounting filesystem 00000000-0000-0000-0000-000000000000.
EXT4-fs (loop0): unmounting filesystem 00000000-0000-0000-0000-000000000000.
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 35528778226320, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 35528778203731, count = 22601
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 35528778203728, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 44118729738928, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 44118729709645, count = 29285
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 44118729709632, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 35654476944544, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 35654476918595, count = 25956
EXT4-fs (loop0): unmounting filesystem 00000000-0000-0000-0000-000000000000.
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 109270199922864, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 109270199919971, count = 2898
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 109270199919968, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 121380089654400, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 121380089626904, count = 27503
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 121380089626896, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 13238790227568, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 13238790218593, count = 8978
EXT4-fs (loop0): unmounting filesystem 00000000-0000-0000-0000-000000000000.
EXT4-fs (loop0): unmounting filesystem 00000000-0000-0000-0000-000000000000.
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 133540988372176, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 133540988347760, count = 24421
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 133540988347760, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 121424907179424, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 121424907149882, count = 29546
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 121424907149872, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 48814256808672, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 48814256779888, count = 28793
EXT4-fs (loop0): unmounting filesystem 00000000-0000-0000-0000-000000000000.
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 23390391899024, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 23390391898899, count = 131
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 23390391898896, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 0, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 0, count = 2
EXT4-fs (loop0): unmounting filesystem 00000000-0000-0000-0000-000000000000.
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 52983525039200, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 52983525026871, count = 12332
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 52966278390864, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 52966278377520, count = 13360
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 52966278377520, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 55182548283436, count = 12336
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 52983524777056, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 52983524765744, count = 11322
------------[ cut here ]------------
WARNING: CPU: 1 PID: 6516 at fs/ext4/mballoc.c:1908 mb_free_blocks+0xe7c/0x1260 fs/ext4/mballoc.c:1908
Modules linked in:
CPU: 1 UID: 0 PID: 6516 Comm: syz-executor309 Tainted: G    B               6.16.0-rc2-syzkaller-g9aa9b43d689e #0 PREEMPT 
Tainted: [B]=BAD_PAGE
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : mb_free_blocks+0xe7c/0x1260 fs/ext4/mballoc.c:1908
lr : mb_free_blocks+0xe7c/0x1260 fs/ext4/mballoc.c:1908
sp : ffff8000a40e72a0
x29: ffff8000a40e7320 x28: 0000000000000007 x27: 0000000000000000
x26: ffff0000e3b7b268 x25: ffff0000e3b7b268 x24: dfff800000000000
x23: ffff8000a40e7428 x22: dfff800000000000 x21: ffff0000dcfa26a4
x20: 0000000000000000 x19: ffff0000dcfa0000 x18: 1fffe000337e1476
x17: ffff80008f62e000 x16: ffff80008aecb65c x15: 0000000000000001
x14: 1fffe0001b9f44d4 x13: 0000000000000000 x12: 0000000000000000
x11: ffff60001b9f44d5 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000c8175b80 x7 : ffff8000a40e7424 x6 : ffff8000810f91a0
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000007 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 mb_free_blocks+0xe7c/0x1260 fs/ext4/mballoc.c:1908 (P)
 ext4_mb_clear_bb fs/ext4/mballoc.c:6519 [inline]
 ext4_free_blocks+0xf6c/0x18e4 fs/ext4/mballoc.c:6651
 ext4_remove_blocks fs/ext4/extents.c:2551 [inline]
 ext4_ext_rm_leaf fs/ext4/extents.c:2716 [inline]
 ext4_ext_remove_space+0x1610/0x37c8 fs/ext4/extents.c:2965
 ext4_ext_truncate+0x134/0x1d0 fs/ext4/extents.c:4484
 ext4_truncate+0x9c4/0xfe0 fs/ext4/inode.c:4574
 ext4_evict_inode+0x9b4/0x104c fs/ext4/inode.c:261
 evict+0x414/0x928 fs/inode.c:810
 iput_final fs/inode.c:1898 [inline]
 iput+0x6e4/0x83c fs/inode.c:1924
 do_unlinkat+0x338/0x4dc fs/namei.c:4657
 __do_sys_unlinkat fs/namei.c:4691 [inline]
 __se_sys_unlinkat fs/namei.c:4684 [inline]
 __arm64_sys_unlinkat+0xdc/0xf8 fs/namei.c:4684
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x58/0x17c arch/arm64/kernel/entry-common.c:767
 el0t_64_sync_handler+0x78/0x108 arch/arm64/kernel/entry-common.c:786
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
irq event stamp: 23287
hardirqs last  enabled at (23287): [<ffff80008aec8cb0>] __exit_to_kernel_mode arch/arm64/kernel/entry-common.c:85 [inline]
hardirqs last  enabled at (23287): [<ffff80008aec8cb0>] exit_to_kernel_mode+0xc0/0xf0 arch/arm64/kernel/entry-common.c:95
hardirqs last disabled at (23286): [<ffff80008aec689c>] __el1_irq arch/arm64/kernel/entry-common.c:580 [inline]
hardirqs last disabled at (23286): [<ffff80008aec689c>] el1_interrupt+0x24/0x54 arch/arm64/kernel/entry-common.c:598
softirqs last  enabled at (21110): [<ffff8000801fcf10>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (21108): [<ffff8000801fcedc>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
EXT4-fs (loop0): unmounting filesystem 00000000-0000-0000-0000-000000000000.
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 53955348821872, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 53955348795914, count = 25973
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 53955348795904, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 11349257057649, count = 808
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 11349257057648, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 130152096189904, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 130152096164961, count = 24948
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 130152096164960, count = 16
EXT4-fs (loop0): unmounting filesystem 00000000-0000-0000-0000-000000000000.
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 274057454951360, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 274057454948322, count = 3041
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 187048375239104, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 187048375238123, count = 995
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 187048375238112, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 273782572856256, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 273782572850149, count = 6116
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 273782572850144, count = 16
EXT4-fs (loop0): unmounting filesystem 00000000-0000-0000-0000-000000000000.
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 121399102505152, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 121399102502003, count = 3154
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 107125092697296, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 107125092672877, count = 24421
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 107125092672864, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 11147376753520, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 11147376748813, count = 4709
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 11147376748800, count = 16
EXT4-fs (loop0): unmounting filesystem 00000000-0000-0000-0000-000000000000.
EXT4-fs (loop0): unmounting filesystem 00000000-0000-0000-0000-000000000000.
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 32768, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 6, count = 32767
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 0, count = 20
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 0, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 2240614592, count = 0
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 2240614592, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 146840636948479, count = 8928
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 32768, count = 16
EXT4-fs (loop0): unmounting filesystem 00000000-0000-0000-0000-000000000000.
EXT4-fs (loop0): unmounting filesystem 00000000-0000-0000-0000-000000000000.
EXT4-fs (loop0): unmounting filesystem 00000000-0000-0000-0000-000000000000.
EXT4-fs (loop0): unmounting filesystem 00000000-0000-0000-0000-000000000000.
EXT4-fs (loop0): unmounting filesystem 00000000-0000-0000-0000-000000000000.
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 162744944121408, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 162744944116483, count = 4930
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 162744944116480, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 494727485440, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 494727479552, count = 5892
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 494727479552, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 4294255808, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 4294229272, count = 26540
EXT4-fs (loop0): unmounting filesystem 00000000-0000-0000-0000-000000000000.
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 30355232, count = 0
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 139685640869072, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 139685640864015, count = 5060
EXT4-fs (loop0): unmounting filesystem 00000000-0000-0000-0000-000000000000.
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 281470681743360, count = 32768
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 281474976743408, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 281474976710655, count = 32767
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 244838905695904, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 244838905675775, count = 20141
EXT4-fs (loop0): unmounting filesystem 00000000-0000-0000-0000-000000000000.
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 305399552, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 305388640, count = 10923
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 20010252675755, count = 22496
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 10912, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 0, count = 10913
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 0, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 0, count = 64
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 33424, count = 16
EXT4-fs (loop0): unmounting filesystem 00000000-0000-0000-0000-000000000000.
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 30317912, count = 0
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 188910748055552, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 188910748043273, count = 12291
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 8, count = 0
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 51539611440, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 51539607551, count = 3904
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 51539607536, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 0, count = 16
EXT4-fs (loop0): unmounting filesystem 00000000-0000-0000-0000-000000000000.
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 70429001517213, count = 16640
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 17179152208, count = 23584
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 71468255809232, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 71468255805451, count = 3796
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 71468255805440, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 241750150690528, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 241750150666716, count = 23818
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 241750150666704, count = 16
EXT4-fs (loop0): unmounting filesystem 00000000-0000-0000-0000-000000000000.
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 7308266, count = 0
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 7308256, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 523986010112, count = 6112
EXT4-fs (loop0): unmounting filesystem 00000000-0000-0000-0000-000000000000.
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 281470681743360, count = 32768
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 281474976743408, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 281474976710655, count = 32767
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 244838905695904, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 244838905675775, count = 20141
EXT4-fs (loop0): unmounting filesystem 00000000-0000-0000-0000-000000000000.
EXT4-fs (loop0): unmounting filesystem 00000000-0000-0000-0000-000000000000.
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 105524727857488, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 105524727841024, count = 16475
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 105524727841024, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 217230362534192, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 217230362532889, count = 1315
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 247360067207408, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 247360067207229, count = 191
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 247360067207216, count = 16
EXT4-fs (loop0): unmounting filesystem 00000000-0000-0000-0000-000000000000.
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 281473147498488, count = 32768
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 281474976743408, count = 16
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 281474976710655, count = 32767
EXT4-fs error (device loop0): ext4_free_blocks:6587: comm syz-executor309: Freeing blocks not in datazone - block = 281470681743375, count = 0


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

