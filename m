Return-Path: <linux-ext4+bounces-5888-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9C3A01192
	for <lists+linux-ext4@lfdr.de>; Sat,  4 Jan 2025 02:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BDD73A4714
	for <lists+linux-ext4@lfdr.de>; Sat,  4 Jan 2025 01:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952042BAF8;
	Sat,  4 Jan 2025 01:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XMTONl7C"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0879436C;
	Sat,  4 Jan 2025 01:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735955769; cv=none; b=sDdL5d7CGfy5tqcwNeDOyFBendAAXA+sr6CJPsWQIc9AsrA0fdToG00XF+v/nb9LUJXMmkuOVA2UA1RwPlHJ3EO77BjOVpcle4NOkA3BmPSEKssG/svUG2OPxT4XBV8bnW6dxU6OmFaYyIYXazuu7bhZZqhUManUtm1NpyDsZpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735955769; c=relaxed/simple;
	bh=2PI2dbBFdO58pshzvvuPaxZMSuh1AlyrR65TCKHtA+w=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=k3YAGexM23jC3O3MmwOIqliadg0qprthP/ufAkJ9vojgSITadG1AxUzNYlyfAFJW9igMwh2JhLkFwcRF4TEG5fBdXOZTQnErtrv9uPloVMQXwxgpJAshJpJXouhaMuSqovCJGlZtQguQRMfM4Rl7xKEx8fpf/Xa7u342lI70XE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XMTONl7C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF51C4CED6;
	Sat,  4 Jan 2025 01:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1735955768;
	bh=2PI2dbBFdO58pshzvvuPaxZMSuh1AlyrR65TCKHtA+w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XMTONl7CwPQMNyJk9jQPEo0yyjHE8nLxLuEO1AFO+gP2GmtyhGGK8kgJBeV5RY0gZ
	 D/l9Mo+wAQuvjyXQJusF1OFRMmK4sC9vI/yYQ9PFtxGgzZEk3Tj2ut/LYzrTbd0vgA
	 hfcC8BPD5bhSnGrTxhOmzvEsD1RB4i7fspYjERWM=
Date: Fri, 3 Jan 2025 17:56:07 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: cheung wall <zzqq0103.hey@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-ext4@vger.kernel.org
Subject: Re: "WARNING in corrupted" in Linux kernel version 6.13.0-rc2
Message-Id: <20250103175607.12981bce1523e23d73315fd5@linux-foundation.org>
In-Reply-To: <CAKHoSAtW=zZ3yN3oGpZ3rmTh6p5oZyAbt5YoRvU7Kk5rHUfoVw@mail.gmail.com>
References: <CAKHoSAtW=zZ3yN3oGpZ3rmTh6p5oZyAbt5YoRvU7Kk5rHUfoVw@mail.gmail.com>
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

On Fri, 3 Jan 2025 15:42:39 +0800 cheung wall <zzqq0103.hey@gmail.com> wrote:

> Hello,
> 
> I am writing to report a potential vulnerability identified in the
> Linux Kernel version 5.15.169. This issue was discovered using our
> custom vulnerability discovery tool.
> 
> Affected File: mm/page_alloc.c
> 
> File: mm/page_alloc.c
> 
> Function: __alloc_pages
> 
> Detailed Call Stack:
> 
> ------------[ cut here begin]------------
> 
> WARNING: CPU: 1 PID: 3458 at mm/page_alloc.c:5398 current_gfp_context
> include/linux/sched/mm.h:174 [inline]
> WARNING: CPU: 1 PID: 3458 at mm/page_alloc.c:5398
> __alloc_pages+0x3d0/0x450 mm/page_alloc.c:5410
> Modules linked in:
> CPU: 1 PID: 3458 Comm: syz.4.203 Not tainted 5.15.169 #1
> Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS
> 1.16.3-debian-1.16.3-2 04/01/2014
> RIP: 0010:__alloc_pages+0x3d0/0x450 mm/page_alloc.c:5398
> Code: ff 4c 89 fa 44 89 f6 89 ef 89 6c 24 48 c6 44 24 78 00 4c 89 6c
> 24 60 e8 de dc ff ff 49 89 c4 e9 f8 fd ff ff 40 80 e5 3f eb c5 <0f> 0b
> eb 91 4c 89 e7 44 89 f6 45 31 e4 e8 5e 80 ff ff e9 ff fd ff
> RSP: 0018:ffff8881020df718 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 1ffff1102041bee4 RCX: dffffc0000000000
> RDX: 0000000000000000 RSI: 0000000000000014 RDI: 0000000000040dc0
> RBP: 0000000000000000 R08: 0000000000000001 R09: ffff8881020dfa67
> R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000001
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> FS: 00007f0c2bb1a6c0(0000) GS:ffff88811ae80000(0000) knlGS:0000000000000000
> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b2d11fffc CR3: 0000000108780000 CR4: 0000000000350ee0
> Call Trace:
> <TASK>
> alloc_pages+0x18c/0x410 mm/mempolicy.c:2185
> kmalloc_order+0x30/0xd0 mm/slab_common.c:966
> kmalloc_order_trace+0x14/0xa0 mm/slab_common.c:982
> kmalloc_array include/linux/slab.h:631 [inline]
> kcalloc include/linux/slab.h:660 [inline]
> hashtab_init+0xe5/0x240 security/selinux/ss/hashtab.c:41
> policydb_read+0x781/0x61b0 security/selinux/ss/policydb.c:2531
> security_load_policy+0x15b/0xf30 security/selinux/ss/services.c:2301
> sel_write_load+0x382/0x1e70 security/selinux/selinuxfs.c:644
> vfs_write+0x28f/0xad0 fs/read_write.c:592
> ksys_write+0x12d/0x260 fs/read_write.c:647
> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> do_syscall_64+0x33/0x80 arch/x86/entry/common.c:80
> entry_SYSCALL_64_after_hwframe+0x6c/0xd6
> RIP: 0033:0x7f0c2cf4c9c9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48
> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f0c2bb1a038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00007f0c2d168f80 RCX: 00007f0c2cf4c9c9
> RDX: 0000000000000163 RSI: 0000000020000380 RDI: 0000000000000003
> RBP: 00007f0c2cff91b6 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007f0c2d168f80 R15: 00007fff5b996ef8
> </TASK>
> irq event stamp: 1509
> hardirqs last enabled at (1519): [<ffffffff812acfb8>]
> __up_console_sem+0x78/0x80 kernel/printk/printk.c:257
> hardirqs last disabled at (1528): [<ffffffff812acf9d>]
> __up_console_sem+0x5d/0x80 kernel/printk/printk.c:255
> softirqs last enabled at (798): [<ffffffff81166c99>] __do_softirq
> kernel/softirq.c:592 [inline]
> softirqs last enabled at (798): [<ffffffff81166c99>] invoke_softirq
> kernel/softirq.c:432 [inline]
> softirqs last enabled at (798): [<ffffffff81166c99>] __irq_exit_rcu
> kernel/softirq.c:641 [inline]
> softirqs last enabled at (798): [<ffffffff81166c99>]
> irq_exit_rcu+0xe9/0x130 kernel/softirq.c:653
> softirqs last disabled at (175): [<ffffffff81166c99>] __do_softirq
> kernel/softirq.c:592 [inline]
> softirqs last disabled at (175): [<ffffffff81166c99>] invoke_softirq
> kernel/softirq.c:432 [inline]
> softirqs last disabled at (175): [<ffffffff81166c99>] __irq_exit_rcu
> kernel/softirq.c:641 [inline]
> softirqs last disabled at (175): [<ffffffff81166c99>]
> irq_exit_rcu+0xe9/0x130 kernel/softirq.c:653
> 
> ------------[ cut here end]------------
> 
> Root Cause:
> 
> The crash is caused by a circular locking dependency detected within
> the Linux kernel's Ext4 filesystem and quota management subsystems.
> Specifically, the task is attempting to acquire the dq_lock
> (&dquot->dq_lock) in the dquot_commit function (fs/quota/dquot.c:507)
> while another task already holds the i_data_sem lock (&ei->i_data_sem)
> in the ext4_map_blocks function (fs/ext4/inode.c:665). This creates a
> circular dependency where each lock is waiting for the other to be
> released, potentially leading to a deadlock. Additionally, a separate
> warning is raised in mm/page_alloc.c:5398 during the __alloc_pages
> function, which occurs while loading SELinux policies
> (security/selinux/ss/policydb.c:2531). This memory allocation warning
> suggests that the system is experiencing issues allocating memory in
> the context of SELinux operations, possibly exacerbated by the locking
> problem. The combination of improper lock ordering in Ext4's quota
> handling and concurrent memory allocation failures indicates flaws in
> the synchronization mechanisms and memory management within the
> kernel. These issues can lead to system instability, including
> deadlocks and memory allocation failures, ultimately causing kernel
> panics and crashes. Addressing these problems would require revising
> the lock acquisition order to eliminate circular dependencies and
> ensuring robust memory allocation handling during critical security
> operations.
> 
> Thank you for your time and attention.
> 
> Best regards
> 
> Wall

