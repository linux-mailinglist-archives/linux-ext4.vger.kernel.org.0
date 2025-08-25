Return-Path: <linux-ext4+bounces-9592-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9480B3338A
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Aug 2025 03:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53ED17A2EC3
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Aug 2025 01:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3AA20C029;
	Mon, 25 Aug 2025 01:29:01 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123851E5B82;
	Mon, 25 Aug 2025 01:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756085341; cv=none; b=u3sFo9W/KLC1wC79OfHF7jMYC4QPh4X5S7Q5Picb+1+3Qbwl3aM8kS3RNligClwFzmicNFoAMqJobYpn7p+6fLCJglxnZ1v8CrvQHuor3Gwb1eqt/urKVpEZlo1X13RbE86jR2VViEZq+pAI25MV4T0hKtdb0+mvPVvgwd9i2Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756085341; c=relaxed/simple;
	bh=tsO1sIGSmfsrGB7/OBNuUQpfskKfQnKpwqhj2n6lfMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:CC:
	 In-Reply-To:Content-Type; b=GchUvb8rReSLBeapSE7ifZq7Wkqpkpe5/ujT2FgEHLQONvwrDTcBTIIHgJC+wdJYv1MSRnvx4Ai6xwwtDsEEUSi1srqIGR1s0YXxB4CqgDFaUKAwlzbjoW+fyFxd1SFXFFvyajht5E1SVAN7SGgQCE4GO0apCrGOMAOc1vIOXXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4c9Ckc0MphzdcW8;
	Mon, 25 Aug 2025 09:24:24 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 2484E1400E3;
	Mon, 25 Aug 2025 09:28:49 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 25 Aug
 2025 09:28:48 +0800
Message-ID: <ea16b402-245e-4a74-a1d4-05edb2d0c40c@huawei.com>
Date: Mon, 25 Aug 2025 09:28:47 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [ext4?] general protection fault in xa_destroy
To: syzbot <syzbot+1713b1aa266195b916c2@syzkaller.appspotmail.com>
References: <68ab9f9f.050a0220.37038e.0080.GAE@google.com>
Content-Language: en-GB
From: Baokun Li <libaokun1@huawei.com>
CC: <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>,
	<tytso@mit.edu>, Baokun Li <libaokun1@huawei.com>, Yang Erkun
	<yangerkun@huawei.com>
In-Reply-To: <68ab9f9f.050a0220.37038e.0080.GAE@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025-08-25 07:26, syzbot wrote:
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    c330cb607721 Merge tag 'i2c-for-6.17-rc3' of git://git.ker..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=115a7a34580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=292f3bc9f654adeb
> dashboard link: https://syzkaller.appspot.com/bug?extid=1713b1aa266195b916c2
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/bb57ae49985b/disk-c330cb60.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/bac705cd2981/vmlinux-c330cb60.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/9817d12458c5/bzImage-c330cb60.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+1713b1aa266195b916c2@syzkaller.appspotmail.com
>
> EXT4-fs: no memory for groupinfo slab cache
> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] SMP KASAN NOPTI
> KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
Thank you for reporting this issue!

This issue was caused by the lack of null-checking logic in
ext4_mb_avg_fragment_size_destroy(), which led to problems in
error path handling. My apologies for this oversight - I will
immediately send out the fix patch.


Thanks,
Baokun

> CPU: 0 UID: 0 PID: 6121 Comm: syz.1.19 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
> RIP: 0010:kasan_byte_accessible+0x12/0x30 mm/kasan/generic.c:199
> Code: 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 48 c1 ef 03 48 b8 00 00 00 00 00 fc ff df <0f> b6 04 07 3c 08 0f 92 c0 e9 fb 3c ed fe cc 66 66 66 66 66 66 2e
> RSP: 0018:ffffc9000ad37700 EFLAGS: 00010016
> RAX: dffffc0000000000 RBX: ffffffff8b7c3b57 RCX: 29738ff3f3108600
> RDX: 0000000000000000 RSI: ffffffff8b7c3b57 RDI: 0000000000000003
> RBP: ffffffff8b786d59 R08: 0000000000000001 R09: 0000000000000000
> R10: dffffc0000000000 R11: fffffbfff1f47127 R12: 0000000000000000
> R13: 0000000000000018 R14: 0000000000000018 R15: 0000000000000001
> FS:  00007f0bf6da46c0(0000) GS:ffff888125c1b000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f4414b3ff98 CR3: 0000000078296000 CR4: 0000000000350ef0
> Call Trace:
>  <TASK>
>  __kasan_check_byte+0x12/0x40 mm/kasan/common.c:567
>  kasan_check_byte include/linux/kasan.h:399 [inline]
>  lock_acquire+0x8d/0x360 kernel/locking/lockdep.c:5842
>  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>  _raw_spin_lock_irqsave+0xa7/0xf0 kernel/locking/spinlock.c:162
>  xa_destroy+0x59/0x2e0 lib/xarray.c:2390
>  ext4_mb_avg_fragment_size_destroy fs/ext4/mballoc.c:3659 [inline]
>  ext4_mb_init+0x136a/0x2860 fs/ext4/mballoc.c:3817
>  __ext4_fill_super fs/ext4/super.c:5558 [inline]
>  ext4_fill_super+0x5253/0x6090 fs/ext4/super.c:5728
>  get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1692
>  vfs_get_tree+0x92/0x2b0 fs/super.c:1815
>  do_new_mount+0x2a2/0x9e0 fs/namespace.c:3808
>  do_mount fs/namespace.c:4136 [inline]
>  __do_sys_mount fs/namespace.c:4347 [inline]
>  __se_sys_mount+0x317/0x410 fs/namespace.c:4324
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f0bf5f9038a
> Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f0bf6da3e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 00007f0bf6da3ef0 RCX: 00007f0bf5f9038a
> RDX: 0000200000000240 RSI: 0000200000000280 RDI: 00007f0bf6da3eb0
> RBP: 0000200000000240 R08: 00007f0bf6da3ef0 R09: 0000000000000004
> R10: 0000000000000004 R11: 0000000000000246 R12: 0000200000000280
> R13: 00007f0bf6da3eb0 R14: 0000000000000236 R15: 0000200000000000
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:kasan_byte_accessible+0x12/0x30 mm/kasan/generic.c:199
> Code: 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 48 c1 ef 03 48 b8 00 00 00 00 00 fc ff df <0f> b6 04 07 3c 08 0f 92 c0 e9 fb 3c ed fe cc 66 66 66 66 66 66 2e
> RSP: 0018:ffffc9000ad37700 EFLAGS: 00010016
> RAX: dffffc0000000000 RBX: ffffffff8b7c3b57 RCX: 29738ff3f3108600
> RDX: 0000000000000000 RSI: ffffffff8b7c3b57 RDI: 0000000000000003
> RBP: ffffffff8b786d59 R08: 0000000000000001 R09: 0000000000000000
> R10: dffffc0000000000 R11: fffffbfff1f47127 R12: 0000000000000000
> R13: 0000000000000018 R14: 0000000000000018 R15: 0000000000000001
> FS:  00007f0bf6da46c0(0000) GS:ffff888125c1b000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f4414b3ff98 CR3: 0000000078296000 CR4: 0000000000350ef0
> ----------------
> Code disassembly (best guess):
>    0:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
>    7:	00
>    8:	90                   	nop
>    9:	90                   	nop
>    a:	90                   	nop
>    b:	90                   	nop
>    c:	90                   	nop
>    d:	90                   	nop
>    e:	90                   	nop
>    f:	90                   	nop
>   10:	90                   	nop
>   11:	90                   	nop
>   12:	90                   	nop
>   13:	90                   	nop
>   14:	90                   	nop
>   15:	90                   	nop
>   16:	90                   	nop
>   17:	90                   	nop
>   18:	66 0f 1f 00          	nopw   (%rax)
>   1c:	48 c1 ef 03          	shr    $0x3,%rdi
>   20:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
>   27:	fc ff df
> * 2a:	0f b6 04 07          	movzbl (%rdi,%rax,1),%eax <-- trapping instruction
>   2e:	3c 08                	cmp    $0x8,%al
>   30:	0f 92 c0             	setb   %al
>   33:	e9 fb 3c ed fe       	jmp    0xfeed3d33
>   38:	cc                   	int3
>   39:	66                   	data16
>   3a:	66                   	data16
>   3b:	66                   	data16
>   3c:	66                   	data16
>   3d:	66                   	data16
>   3e:	66                   	data16
>   3f:	2e                   	cs
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
>


