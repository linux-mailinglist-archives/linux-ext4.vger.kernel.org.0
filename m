Return-Path: <linux-ext4+bounces-12007-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A0EC7CAFA
	for <lists+linux-ext4@lfdr.de>; Sat, 22 Nov 2025 09:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 78CF74E38C0
	for <lists+linux-ext4@lfdr.de>; Sat, 22 Nov 2025 08:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2402228853A;
	Sat, 22 Nov 2025 08:55:34 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6651AA7A6
	for <linux-ext4@vger.kernel.org>; Sat, 22 Nov 2025 08:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763801733; cv=none; b=dEOnb0pLBXRhq+VxtkbxibJKijIlGufuc10hS5AJG5+NvuqFzTPv4x+3nF02zQDQymfYzb1Ys7CGR0RefGJS/qKtNHRfcF4ZcoBrKfsO1yNSAC3HnEe9yPWwBxo7vojPB45ylIhHeNLSxti1r1/fCKthOMbhq/qwn00sAuy7ywQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763801733; c=relaxed/simple;
	bh=gkxQaAfUYdFWUJSbQ+mHao+heZsRwxrKiPISTQaDZQM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=qxRD/IpQxcGRWo7KZTfckX2z5bWryRMCQZsB87G3T3gRD87sRWY8sjm7kY4yG8jpJnwybLnIMrWeRMfM47Co91xWhqj7gjzBXpr2+M+Ky6zrr0vNEWAB9n1eITitrw7UfKcoHm3Rten72Izbtvzfzltb8jE1NwujqHkrYMDdd/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-43373c85296so24946495ab.2
        for <linux-ext4@vger.kernel.org>; Sat, 22 Nov 2025 00:55:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763801731; x=1764406531;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BXwn3UJidjRpWML7XVWo01nngggTnHLrtf/eXHKD0n8=;
        b=HyCzVxyP7+VRBLQo9ZZ1tSDvtIhIAMSahSIy9XH8O2ofhv3fFXd9cSBob0AmhT2iO2
         DbjG/uyDv4SryYLFcmFxM4cHQoqcRSTScCU3PlaV2Y6iKhaE4lnopzIwsGY9RYblsn2M
         T6+POZwM6wYTei2C76NoJlNdIaicD/M1B6MO0EPwfn8XvyL+DxUHpSH6Opf0D7J5rVpr
         V/AwBFMqRmAKU9pQhIoDOIV66eb3Yq/xdsv8vViQeNH7+fP7jXEHOiEJqnT4pCSLMGA6
         9vuFJ1b+EpvlkVXpME5LgYThji99G9rP3obR1eR44ax0i5IJZ8ZmyJwPgmGYnHtXTjIB
         78tA==
X-Forwarded-Encrypted: i=1; AJvYcCUwfgGhh+sM1ekdDieMt890+tAGsvsz5meOSDgFrL1it2iqg/t+RzA3QRum6bL7cEuyugxAIk0VP4qJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+0Z2BLely/8od1aNZUb/7eDfgl4aXLNQPtN6l9nOoenDChFpb
	xL9F5Ph1Dk8bvoQTDMeiliPRAYtRY0OE2qu6WmwTFz8wuDagQj1Jx+rYYTDtS8r77OVk2PAtK8k
	dzC+Zsjr4VWnAjdnN+e30QVZ63PcD22/LAruZgVfgqMciyoS46W0P86M+LuY=
X-Google-Smtp-Source: AGHT+IH6yKfeDiSQ0+vnvDlJ1lxGh7RHL53kJYoEQvdKF4QFA9zMfkQtZiJdknTtjj2oDaEwioQzrFiz9hqTc7tZ+nXaLakxGGbz
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2190:b0:433:5b75:64cf with SMTP id
 e9e14a558f8ab-435b8e5cbb2mr44718635ab.21.1763801731070; Sat, 22 Nov 2025
 00:55:31 -0800 (PST)
Date: Sat, 22 Nov 2025 00:55:31 -0800
In-Reply-To: <20251122024555.140798-2-eraykrdg1@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69217a83.a70a0220.d98e3.0056.GAE@google.com>
Subject: [syzbot ci] Re: ext4: fix unaligned preallocation with bigalloc
From: syzbot ci <syzbot+ci862263647b1e3a00@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, albinbabuvarghese20@gmail.com, 
	david.hunter.linux@gmail.com, eraykrdg1@gmail.com, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	syzbot@syzkaller.appspotmail.com, tytso@mit.edu
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v2] ext4: fix unaligned preallocation with bigalloc
https://lore.kernel.org/all/20251122024555.140798-2-eraykrdg1@gmail.com
* [PATCH v2] ext4: fix unaligned preallocation with bigalloc

and found the following issues:
* WARNING in ext4_mb_complex_scan_group
* WARNING in mb_update_avg_fragment_size

Full report is available here:
https://ci.syzbot.org/series/ba644d0c-b0cd-47e5-aac4-5bc33f8d2823

***

WARNING in ext4_mb_complex_scan_group

tree:      torvalds
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
base:      23cb64fb76257309e396ea4cec8396d4a1dbae68
arch:      amd64
compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
config:    https://ci.syzbot.org/builds/3d0f1523-91b4-4aa0-b4ec-0f13803a4e4e/config
C repro:   https://ci.syzbot.org/findings/d24ca945-6ee1-4b64-827e-93a61ab96735/c_repro
syz repro: https://ci.syzbot.org/findings/d24ca945-6ee1-4b64-827e-93a61ab96735/syz_repro

EXT4-fs: Ignoring removed bh option
EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode: writeback.
------------[ cut here ]------------
WARNING: CPU: 1 PID: 5962 at fs/ext4/mballoc.c:2531 ext4_mb_complex_scan_group+0xd64/0xf30 fs/ext4/mballoc.c:2531
Modules linked in:
CPU: 1 UID: 0 PID: 5962 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:ext4_mb_complex_scan_group+0xd64/0xf30 fs/ext4/mballoc.c:2531
Code: 81 c4 c8 00 00 00 5b 41 5c 41 5d 41 5e 41 5f 5d e9 01 f8 cc 08 cc e8 1b 97 43 ff 90 0f 0b 90 e9 3d fe ff ff e8 0d 97 43 ff 90 <0f> 0b 65 48 8b 05 62 e3 f1 0f 48 3b 84 24 c0 00 00 00 75 20 90 eb
RSP: 0018:ffffc90003c069c8 EFLAGS: 00010293
RAX: ffffffff827c6cb3 RBX: 00000000fffffff8 RCX: ffff888114d61d00
RDX: 0000000000000000 RSI: 00000000fffffff8 RDI: 0000000000000001
RBP: ffff88816ef5b000 R08: ffff888114d61d00 R09: 0000000000000005
R10: 0000000000000004 R11: 0000000000000000 R12: ffff888166fec000
R13: ffff888166fec638 R14: ffff8881b7ac0000 R15: dffffc0000000000
FS:  0000555585e78500(0000) GS:ffff8882a9f3b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2ec63fff CR3: 000000011407a000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 __ext4_mb_scan_group fs/ext4/mballoc.c:2664 [inline]
 ext4_mb_scan_group+0x116e/0x18e0 fs/ext4/mballoc.c:2955
 ext4_mb_scan_groups_linear+0xe8/0x360 fs/ext4/mballoc.c:1146
 ext4_mb_scan_groups fs/ext4/mballoc.c:1180 [inline]
 ext4_mb_regular_allocator+0x90e/0x2970 fs/ext4/mballoc.c:3026
 ext4_mb_new_blocks+0xd11/0x4720 fs/ext4/mballoc.c:6320
 ext4_ext_map_blocks+0x161a/0x6ac0 fs/ext4/extents.c:4383
 ext4_map_create_blocks fs/ext4/inode.c:609 [inline]
 ext4_map_blocks+0x860/0x1740 fs/ext4/inode.c:811
 _ext4_get_block+0x200/0x4c0 fs/ext4/inode.c:910
 ext4_get_block_unwritten+0x2e/0x100 fs/ext4/inode.c:943
 ext4_block_write_begin+0x993/0x1710 fs/ext4/inode.c:1198
 ext4_write_begin+0xc04/0x19a0 fs/ext4/ext4_jbd2.h:-1
 ext4_da_write_begin+0x445/0xda0 fs/ext4/inode.c:3129
 generic_perform_write+0x2c5/0x900 mm/filemap.c:4254
 ext4_buffered_write_iter+0xce/0x3a0 fs/ext4/file.c:299
 ext4_file_write_iter+0x298/0x1bc0 fs/ext4/file.c:-1
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x5c9/0xb30 fs/read_write.c:686
 ksys_write+0x145/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3f93f8f749
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff83277a88 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f3f941e5fa0 RCX: 00007f3f93f8f749
RDX: 0000000000001006 RSI: 0000200000000940 RDI: 0000000000000005
RBP: 00007f3f94013f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f3f941e5fa0 R14: 00007f3f941e5fa0 R15: 0000000000000003
 </TASK>


***

WARNING in mb_update_avg_fragment_size

tree:      torvalds
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
base:      23cb64fb76257309e396ea4cec8396d4a1dbae68
arch:      amd64
compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
config:    https://ci.syzbot.org/builds/3d0f1523-91b4-4aa0-b4ec-0f13803a4e4e/config
C repro:   https://ci.syzbot.org/findings/4f77b4c9-f795-4c41-ad77-5c5a174be3a1/c_repro
syz repro: https://ci.syzbot.org/findings/4f77b4c9-f795-4c41-ad77-5c5a174be3a1/syz_repro

EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode: writeback.
EXT4-fs: Ignoring removed orlov option
EXT4-fs (loop0): can't enable nombcache during remount
------------[ cut here ]------------
WARNING: CPU: 1 PID: 5969 at fs/ext4/mballoc.c:839 mb_avg_fragment_size_order fs/ext4/mballoc.c:839 [inline]
WARNING: CPU: 1 PID: 5969 at fs/ext4/mballoc.c:839 mb_update_avg_fragment_size+0x304/0x450 fs/ext4/mballoc.c:856
Modules linked in:
CPU: 1 UID: 0 PID: 5969 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:mb_avg_fragment_size_order fs/ext4/mballoc.c:839 [inline]
RIP: 0010:mb_update_avg_fragment_size+0x304/0x450 fs/ext4/mballoc.c:856
Code: 5d 41 5e 41 5f 5d e9 1b 6a cd 08 e8 96 57 44 ff 48 83 c4 28 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc cc e8 7d 57 44 ff 90 <0f> 0b 90 48 bb 00 00 00 00 00 fc ff df 41 0f b6 44 1d 00 84 c0 0f
RSP: 0018:ffffc90003a56f48 EFLAGS: 00010293
RAX: ffffffff827bac43 RBX: 000000000000000d RCX: ffff8881037ad700
RDX: 0000000000000000 RSI: 000000000000000c RDI: 000000000000001e
RBP: 000000000000001e R08: ffff8881a9014007 R09: 1ffff11035202800
R10: dffffc0000000000 R11: ffffed1035202801 R12: ffff88810b77e014
R13: 1ffff110216efc02 R14: 000000000000001f R15: 000000000000000c
FS:  000055557ed08500(0000) GS:ffff8882a9f3b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9c75c3f000 CR3: 0000000112a5a000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 mb_mark_used+0xfd8/0x12f0 fs/ext4/mballoc.c:2195
 ext4_mb_use_best_found+0x192/0x7e0 fs/ext4/mballoc.c:2216
 ext4_mb_check_limits fs/ext4/mballoc.c:2280 [inline]
 ext4_mb_complex_scan_group+0xd27/0xf30 fs/ext4/mballoc.c:2596
 __ext4_mb_scan_group fs/ext4/mballoc.c:2664 [inline]
 ext4_mb_scan_group+0x116e/0x18e0 fs/ext4/mballoc.c:2955
 ext4_mb_scan_groups_linear+0xe8/0x360 fs/ext4/mballoc.c:1146
 ext4_mb_scan_groups fs/ext4/mballoc.c:1180 [inline]
 ext4_mb_regular_allocator+0x90e/0x2970 fs/ext4/mballoc.c:3026
 ext4_mb_new_blocks+0xd11/0x4720 fs/ext4/mballoc.c:6320
 ext4_ext_map_blocks+0x161a/0x6ac0 fs/ext4/extents.c:4383
 ext4_map_create_blocks fs/ext4/inode.c:609 [inline]
 ext4_map_blocks+0x860/0x1740 fs/ext4/inode.c:811
 ext4_convert_inline_data_nolock+0x249/0x970 fs/ext4/inline.c:1112
 ext4_convert_inline_data+0x4b3/0x5e0 fs/ext4/inline.c:1976
 ext4_fallocate+0x1e2/0x3d0 fs/ext4/extents.c:4793
 vfs_fallocate+0x669/0x7e0 fs/open.c:342
 ksys_fallocate fs/open.c:366 [inline]
 __do_sys_fallocate fs/open.c:371 [inline]
 __se_sys_fallocate fs/open.c:369 [inline]
 __x64_sys_fallocate+0xc0/0x110 fs/open.c:369
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9c7eb8f749
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd1029f7c8 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffda RBX: 00007f9c7ede5fa0 RCX: 00007f9c7eb8f749
RDX: 0000000000004003 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007f9c7ec13f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000010000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f9c7ede5fa0 R14: 00007f9c7ede5fa0 R15: 0000000000000004
 </TASK>


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

