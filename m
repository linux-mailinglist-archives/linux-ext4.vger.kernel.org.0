Return-Path: <linux-ext4+bounces-1662-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E79D487CECB
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Mar 2024 15:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C11EB21D33
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Mar 2024 14:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B4E3717C;
	Fri, 15 Mar 2024 14:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CY0COQ6J";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4SXDapyA"
X-Original-To: linux-ext4@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6783C6A3
	for <linux-ext4@vger.kernel.org>; Fri, 15 Mar 2024 14:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710512787; cv=none; b=NPwWDm0c+qdOGSNc6s593InO0/tBKcnAWARJd7ae2T41dBwxAOU2cNpI+eyc5hQqhXcfykWgWxuyagyl/sRFFx8lAJ1+z6jPq1ewo6fpr0IQDVV3/8G9/Y11y/hyum3AbgXC8iezOsvKdocjwCozMzje3tS6CozA/igHQs50rcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710512787; c=relaxed/simple;
	bh=fT+IZqR0nlaXFATpYVyrT7iAcDhJ9ZidoEsBdxskAi0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kHOXx0AVZ8BUjRnAqD6rNldbjCeZ3ypLTYUwXF+oI+C2SINRwTd2HO7r+5LVJRxeL2fMRP7Gi8lPN6AK7VSLR3+MIxBtkSZ8D4AfQCcpP4R/NN1jHjBo8K5BdZixRr28Kbvvq6l/juTigb+h9+yRKyo/bbZF4F1TcKfA8QPyxQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CY0COQ6J; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4SXDapyA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710512777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y02ACzhWR1gRcDBks+rIxo+bCLCgIVZB47qJVHK8YJ4=;
	b=CY0COQ6JE/XNQTzzgdojePmURj3mUAihAEme4O07dmgivXnTBGdDZjMIkSU8IgaljW6DXI
	7dBHfZ6t/twfNTz14AqEUw7ePXRe8c/P/7+8Dx/VhA1c9hskdBjmqBoo+IclhHOYRAG/jn
	Xb8FJMaKP4hnjBmw0XVhd+UZCcSl+GzFGRe30lbWiFqbpxOd3HTZcvQ+v5XgCYBDiKw2XT
	dJQwlOac2d2Zv7GyR0NHy86/TiPER/uBMYa4rmjNQmtgW63/dY9J9AN7Un+fcL3idGu+x7
	mstQ5yomQlWpihLJW/J/A8odYFaBkCopcwLrL1fnVXn5bMferKeU/a6/ek+gGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710512777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y02ACzhWR1gRcDBks+rIxo+bCLCgIVZB47qJVHK8YJ4=;
	b=4SXDapyA8e3ncE6wzyegGNc/kJpClG3FXupvjhpyFoT1lDso8u1aPFy0ZEF1MXjquQ2z9b
	7O6Tg9GMgfVtB0DQ==
To: cheung wall <zzqq0103.hey@gmail.com>
Cc: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
 adilger.kernel@dilger.ca
Subject: Re: BUG: unable to handle kernel paging request in
 ext4_ext_remove_space
In-Reply-To: <CAKHoSAvEbO_dGdkNm5AMOxNwO1vdpcCFuy3VQNwwa7uxrC7MOA@mail.gmail.com>
References: <CAKHoSAvEbO_dGdkNm5AMOxNwO1vdpcCFuy3VQNwwa7uxrC7MOA@mail.gmail.com>
Date: Fri, 15 Mar 2024 15:26:16 +0100
Message-ID: <87a5mzlgfr.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Mar 15 2024 at 12:50, cheung wall wrote:

Removed x86 and random other people from CC and added the EXT4 folks
which are the ones who are really interested in this. Kept full context
intact.

> when using Healer to fuzz the latest Linux Kernel, the following crash
>
> was triggered on:
>
>
> HEAD commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a  (tag: v6.7)
>
> git tree: upstream
>
> console output: https://pastebin.com/raw/dtWhAR8Y
>
> kernel config: https://pastebin.com/raw/dRctH7sr
>
> C reproducer: https://pastebin.com/raw/zUiGyNi9
>
> Syzlang reproducer:https://pastebin.com/raw/PNyeDjq6
>
> If you fix this issue, please add the following tag to the commit:
>
> Reported-by: Qiang Zhang <zzqq0103.hey@gmail.com>
>
> ----------------------------------------------------------
>
> EXT4-fs (loop0): mounted filesystem
> 00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode:
> writeback.
> ext4 filesystem being mounted at /syzkaller.TPYs2I/19/file1 supports
> timestamps until 2038-01-19 (0x7fffffff)
> BUG: unable to handle page fault for address: ffff888002cba000
> #PF: supervisor write access in kernel mode
> #PF: error_code(0x0003) - permissions violation
> PGD a4c01067 P4D a4c01067 PUD a4c02067 PMD 2c63063 PTE 8000000002cba121

The page is mapped RO ...

> Oops: 0003 [#1] PREEMPT SMP KASAN NOPTI
> CPU: 2 PID: 366 Comm: syz-executor127 Not tainted 6.7.0 #2
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> RIP: 0010:memmove+0x1e/0x1b0
> root/zhangqiang/kernel_fuzzing/zq-LLM-OS/llm-syz-environment/linux-6.7/arch/x86/lib/memmove_64.S:44
> Code: 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 89 f8 48 39
> fe 7d 0f 49 89 f0 49 01 d0 49 39 f8 0f 8f b5 00 00 00 48 89 d1 <f3> a4
> e9 26 14 1b 00 66 2e 0f 1f 84 00 00 00 00 00 48 81 fa a8 02
> RSP: 0018:ffff88800d84f840 EFLAGS: 00010216
> RAX: ffff888002c9903c RBX: ffff888002c99000 RCX: fffffffffffdf000
> RDX: ffffffffffffffc4 RSI: ffff888002cba00c RDI: ffff888002cba000
> RBP: ffff888002c99002 R08: 0000000000000001 R09: fffff94000039076
> R10: 0000000000000000 R11: 0000000000000000 R12: dffffc0000000000
> R13: ffff88800ba37868 R14: ffff888002c99040 R15: 0000000000000004
> FS:  00007fefc4cb4640(0000) GS:ffff88809e900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffff888002cba000 CR3: 00000000092fc005 CR4: 0000000000770ef0
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  ext4_ext_rm_leaf
> root/zhangqiang/kernel_fuzzing/zq-LLM-OS/llm-syz-environment/linux-6.7/fs/ext4/extents.c:2736
> [inline]
>  ext4_ext_remove_space+0x1aae/0x36b0
> root/zhangqiang/kernel_fuzzing/zq-LLM-OS/llm-syz-environment/linux-6.7/fs/ext4/extents.c:2958
>  ext4_punch_hole+0xb8b/0xe50
> root/zhangqiang/kernel_fuzzing/zq-LLM-OS/llm-syz-environment/linux-6.7/fs/ext4/inode.c:4019
>  ext4_fallocate+0xb68/0x3230
> root/zhangqiang/kernel_fuzzing/zq-LLM-OS/llm-syz-environment/linux-6.7/fs/ext4/extents.c:4707
>  vfs_fallocate+0x361/0xae0
> root/zhangqiang/kernel_fuzzing/zq-LLM-OS/llm-syz-environment/linux-6.7/fs/open.c:324
>  ioctl_preallocate+0x172/0x1f0
> root/zhangqiang/kernel_fuzzing/zq-LLM-OS/llm-syz-environment/linux-6.7/fs/ioctl.c:291
>  file_ioctl root/zhangqiang/kernel_fuzzing/zq-LLM-OS/llm-syz-environment/linux-6.7/fs/ioctl.c:334
> [inline]
>  do_vfs_ioctl+0x109e/0x13c0
> root/zhangqiang/kernel_fuzzing/zq-LLM-OS/llm-syz-environment/linux-6.7/fs/ioctl.c:850
>  __do_sys_ioctl
> root/zhangqiang/kernel_fuzzing/zq-LLM-OS/llm-syz-environment/linux-6.7/fs/ioctl.c:869
> [inline]
>  __se_sys_ioctl
> root/zhangqiang/kernel_fuzzing/zq-LLM-OS/llm-syz-environment/linux-6.7/fs/ioctl.c:857
> [inline]
>  __x64_sys_ioctl+0xef/0x1e0
> root/zhangqiang/kernel_fuzzing/zq-LLM-OS/llm-syz-environment/linux-6.7/fs/ioctl.c:857
>  do_syscall_x64
> root/zhangqiang/kernel_fuzzing/zq-LLM-OS/llm-syz-environment/linux-6.7/arch/x86/entry/common.c:52
> [inline]
>  do_syscall_64+0x46/0xf0
> root/zhangqiang/kernel_fuzzing/zq-LLM-OS/llm-syz-environment/linux-6.7/arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x6f/0x77
> RIP: 0033:0x7fefc4d3263d
> Code: c3 e8 27 23 00 00 0f 1f 80 00 00 00 00 f3 0f 1e fa 48 89 f8 48
> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fefc4cb4198 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007fefc4dc95d0 RCX: 00007fefc4d3263d
> RDX: 0000000020000080 RSI: 0000000040305829 RDI: 0000000000000004
> RBP: 00007fefc4d93598 R08: 00007ffe5e3ab7bf R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0031656c69662f2e
> R13: 6f6f6c2f7665642f R14: 000001ff7fdfd000 R15: 00007fefc4dc95d8
>  </TASK>
> Modules linked in:
> CR2: ffff888002cba000
> ---[ end trace 0000000000000000 ]---
> BUG: unable to handle page fault for address: ffffebde001bf808
> RIP: 0010:memmove+0x1e/0x1b0
> root/zhangqiang/kernel_fuzzing/zq-LLM-OS/llm-syz-environment/linux-6.7/arch/x86/lib/memmove_64.S:44
> #PF: supervisor read access in kernel mode
> Code: 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 89 f8 48 39
> fe 7d 0f 49 89 f0 49 01 d0 49 39 f8 0f 8f b5 00 00 00 48 89 d1 <f3> a4
> e9 26 14 1b 00 66 2e 0f 1f 84 00 00 00 00 00 48 81 fa a8 02
> #PF: error_code(0x0000) - not-present page
> RSP: 0018:ffff88800d84f840 EFLAGS: 00010216
> PGD 0 P4D 0

