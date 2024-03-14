Return-Path: <linux-ext4+bounces-1653-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B6587C29B
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Mar 2024 19:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B2D5B21B4E
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Mar 2024 18:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834E374BFA;
	Thu, 14 Mar 2024 18:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="F9fRpw4C"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D3A73161;
	Thu, 14 Mar 2024 18:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710440730; cv=none; b=GMTPZlnLzgQQmAX6dDbfodQZDJuei19q3P1fZ89fVPJ7TbCzrfguRCCwgxZrPKgepSpxYVjrJ4R/HqKVrsCusvwNNLpfZAKLTxN+0ZuY437w4P74DlM/7p0DpnOJXMVQKvaUiTENlVzx/YvuFMZbAZeknYNNWaHQlt1231WApgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710440730; c=relaxed/simple;
	bh=8E0Cp30XGVgnf21bVDVFgdL/HtepvKVS2jpePHJilms=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=YOSOD/5tBCEDW4XStA4Nl+Ibp5HTOeH2e0uy+fp0FsQxp9QMOjBRpDlYFDkSuq/nc+iuT5yflC25HUJX5Ftj8jqLmCEdLkAufxEVNooDIwzbtinU01IcZT1Y0OQE+x+OZ6T+fzibcXN3xCPG/LEAyVWbfd68biitRJY+pdjmWro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=F9fRpw4C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DB89C433F1;
	Thu, 14 Mar 2024 18:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1710440729;
	bh=8E0Cp30XGVgnf21bVDVFgdL/HtepvKVS2jpePHJilms=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F9fRpw4Cat7wPAJ76UK/GohqRcuhcwKVKchiU7Jt9+gsBFkbnEJbrExxJOgU+KOYs
	 wYYU1XcfGfWr5f+aNjVwCQX9+Heqd5wqkABXalkhz3epd9KkvIWWoiYOLHptXKUVPU
	 /ZZqTAcI8Sb9x+PihV98tcKBHqKLQnY63QKG4FoY=
Date: Thu, 14 Mar 2024 11:25:23 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: cheung wall <zzqq0103.hey@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: WARNING in __kthread_create_on_node
Message-Id: <20240314112523.35feba8252931c912dc00bbf@linux-foundation.org>
In-Reply-To: <CAKHoSAtC3NzC6c-uA=Ruzn81psVTAX-60Fw51OscpnpeJ2S29g@mail.gmail.com>
References: <CAKHoSAtC3NzC6c-uA=Ruzn81psVTAX-60Fw51OscpnpeJ2S29g@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

(cc linux-ext4)

Interesting.

On Thu, 14 Mar 2024 22:23:54 +0800 cheung wall <zzqq0103.hey@gmail.com> wrote:

> Hello,
> 
> when using Healer to fuzz the latest Linux Kernel, the following crash
> 
> was triggered on:
> 
> 
> HEAD commit: e8f897f4afef0031fe618a8e94127a0934896aba  (tag: v6.8)
> 
> git tree: upstream
> 
> console output: https://pastebin.com/raw/4dqjbmVn
> 
> kernel config: https://pastebin.com/raw/enVJCL3u
> 
> C reproducer: https://pastebin.com/raw/wdKP6g0V
> 
> Syzlang reproducer: https://pastebin.com/raw/wfptradq
> 
> If you fix this issue, please add the following tag to the commit:
> 
> Reported-by: Qiang Zhang <zzqq0103.hey@gmail.com>
> 
> ----------------------------------------------------------
> 
> ------------[ cut here ]------------
> different return values (11 and 6) from vsnprintf("kmmpd-%.*s", ...)
> WARNING: CPU: 0 PID: 18743 at lib/kasprintf.c:30
> kvasprintf+0x14e/0x160 lib/kasprintf.c:30
> Modules linked in:
> CPU: 0 PID: 18743 Comm: syz-executor.0 Not tainted 6.8.0 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> RIP: 0010:kvasprintf+0x14e/0x160 lib/kasprintf.c:30
> Code: 5b 5d 41 5c 41 5d 41 5e 41 5f e9 e8 2f 2d 02 e8 08 54 43 ff 90
> 48 c7 c7 40 62 fe a1 4c 89 e9 44 89 e2 89 ee e8 d3 62 13 ff 90 <0f> 0b
> 90 90 eb 99 e8 27 96 12 02 0f 1f 80 00 00 00 00 90 90 90 90
> RSP: 0018:ffff88810485f760 EFLAGS: 00010286
> RAX: 0000000000000000 RBX: 1ffff1102090beec RCX: ffffffff9eb67582
> RDX: ffff888104dfe600 RSI: 0000000000000000 RDI: 0000000000000001
> RBP: 000000000000000b R08: 0000000000000001 R09: ffffed10235c5121
> R10: 0000000000000000 R11: 000000002d2d2d2d R12: 0000000000000006
> R13: ffffffffa1f42a20 R14: ffff888100b62900 R15: 000000000000000c
> FS:  00007f8db8f7e640(0000) GS:ffff88811ae00000(0000) knlGS:0000000000000000
> loop2: detected capacity change from 0 to 512
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffcd493ab98 CR3: 00000001063fe004 CR4: 0000000000770ef0
> PKRU: 55555554
> Call Trace:
>  <TASK>
> loop3: detected capacity change from 0 to 512
>  __kthread_create_on_node+0x17f/0x3c0 kernel/kthread.c:444
>  kthread_create_on_node+0xbf/0x100 kernel/kthread.c:512
> loop1: detected capacity change from 0 to 512
>  ext4_multi_mount_protect+0x953/0xb10 fs/ext4/mmp.c:392
>  __ext4_fill_super fs/ext4/super.c:5363 [inline]
>  ext4_fill_super+0xa76d/0xc290 fs/ext4/super.c:5703
>  get_tree_bdev+0x35a/0x5d0 fs/super.c:1614
>  vfs_get_tree+0x8c/0x320 fs/super.c:1779
>  do_new_mount fs/namespace.c:3352 [inline]
>  path_mount+0x6b3/0x1db0 fs/namespace.c:3679
>  do_mount fs/namespace.c:3692 [inline]
>  __do_sys_mount fs/namespace.c:3898 [inline]
>  __se_sys_mount fs/namespace.c:3875 [inline]
>  __x64_sys_mount+0x286/0x310 fs/namespace.c:3875
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xb3/0x1b0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x6f/0x77
> RIP: 0033:0x7f8db9410dfe
> Code: 48 c7 c0 ff ff ff ff eb aa e8 be 0d 00 00 66 2e 0f 1f 84 00 00
> 00 00 00 0f 1f 40 00 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f8db8f7de38 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 00000000000004b4 RCX: 00007f8db9410dfe
> RDX: 0000000020000040 RSI: 0000000020000500 RDI: 00007f8db8f7de90
> RBP: 00007f8db8f7ded0 R08: 00007f8db8f7ded0 R09: 0000000000004500
> R10: 0000000000004500 R11: 0000000000000246 R12: 0000000020000040
> R13: 0000000020000500 R14: 00007f8db8f7de90 R15: 0000000020000540
>  </TASK>
> ---[ end trace 0000000000000000 ]---

