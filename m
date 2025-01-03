Return-Path: <linux-ext4+bounces-5869-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F790A0055C
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Jan 2025 08:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C04DD162806
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Jan 2025 07:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C101C5F32;
	Fri,  3 Jan 2025 07:50:26 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail.thelounge.net (mail.thelounge.net [91.118.73.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B321917ED
	for <linux-ext4@vger.kernel.org>; Fri,  3 Jan 2025 07:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.118.73.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735890626; cv=none; b=p/0QLH/vDF4YCRiF5V34fqM0jJVRSb2s3siJYuwWGa7ltOGWRf5/Cri4r7cBkW1TeMYS/R5y+7eY7S6TUqZNWTxfqEJzjwsXMB5I0tk723EcE9u/n/Cv4Qk+hIowAL/7ANbiM4aJnIHgSJqWLCmluKTvG4PYCEdTWCwTfT8QUZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735890626; c=relaxed/simple;
	bh=CFkvusAcPqjGmYUA884zJrIzCZdKY7xdxb5EEX/31CI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jd912U4vQ05oEWAx2l6kxYLOXenZPwrO7ASwHzBLpO3abF95krguFyS+xzouLkeXyrUHf0zVTz0/vT+uByMfMkTCILQ/+Lp/KATPSZIqVvOGNUq3ZqrYqC0ocGl07WHTbFYUyaBZY6bvCMtRVwDRJWU+nMk140p764ykN9/VeU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thelounge.net; spf=pass smtp.mailfrom=thelounge.net; arc=none smtp.client-ip=91.118.73.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thelounge.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thelounge.net
Received: from [10.10.10.2] (rh.vpn.thelounge.net [10.10.10.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: h.reindl@thelounge.net)
	by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 4YPbMn0T8wzXLW;
	Fri,  3 Jan 2025 08:50:13 +0100 (CET)
Message-ID: <99bc9f52-e319-4d7b-a6c0-936356d7d590@thelounge.net>
Date: Fri, 3 Jan 2025 08:50:12 +0100
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: "possible deadlock in corrupted" in Linux kernel version 5.15.169
Content-Language: en-US
To: cheung wall <zzqq0103.hey@gmail.com>
Cc: linux-ext4@vger.kernel.org
References: <CAKHoSAviexD6O+QuaNya4xsqaW6URLFWee7vgTGOiJO8x1mkJw@mail.gmail.com>
From: Reindl Harald <h.reindl@thelounge.net>
Autocrypt: addr=h.reindl@thelounge.net; keydata=
 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
 K4rYsjPimkSIVdrNM//wVKdCTbO+
Organization: the lounge interactive design
In-Reply-To: <CAKHoSAviexD6O+QuaNya4xsqaW6URLFWee7vgTGOiJO8x1mkJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


https://www.kernel.org/
longterm: 5.15.175 2024-12-19

you are SIX point releases behind, so this may or may not be already fixed

Am 03.01.25 um 08:37 schrieb cheung wall:
> Hello,
> 
> I am writing to report a potential vulnerability identified in the
> Linux Kernel version 5.15.169. This issue was discovered using our
> custom vulnerability discovery tool.
> 
> Affected File: fs/ext4/inode.c
> 
> File: fs/ext4/inode.c
> 
> Function: ext4_map_blocks
> 
> Detailed Call Stack:
> 
> ------------[ cut here begin]------------
> 
> WARNING: possible circular locking dependency detected
> ------------------------------------------------------
> the task is trying to acquire lock:
> ffff888018a76428 (&dquot->dq_lock){+.+.}-{3:3}, at:
> dquot_commit+0x4d/0x4c0 fs/quota/dquot.c:507
> 
> but other task is already holding lock:
> ffff88800833a9b8 (&ei->i_data_sem/2){++++}-{3:3}, at:
> ext4_map_blocks+0x686/0x1870 fs/ext4/inode.c:665
> 
> which lock already depends on the new lock.
> 
> Call Trace:
> <TASK>
> __dump_stack lib/dump_stack.c:88 [inline]
> dump_stack_lvl+0x8b/0xb3 lib/dump_stack.c:106
> check_noncircular+0x263/0x2e0 kernel/locking/lockdep.c:2133
> check_prev_add kernel/locking/lockdep.c:3053 [inline]
> check_prevs_add kernel/locking/lockdep.c:3172 [inline]
> validate_chain kernel/locking/lockdep.c:3788 [inline]
> __lock_acquire+0x2b72/0x6070 kernel/locking/lockdep.c:5012
> lock_acquire kernel/locking/lockdep.c:5623 [inline]
> lock_acquire+0x194/0x470 kernel/locking/lockdep.c:5588
> __mutex_lock_common kernel/locking/mutex.c:596 [inline]
> __mutex_lock+0x135/0x12c0 kernel/locking/mutex.c:729
> dquot_commit+0x4d/0x4c0 fs/quota/dquot.c:507
> ext4_write_dquot+0x254/0x3f0 fs/ext4/super.c:6173
> ext4_mark_dquot_dirty fs/ext4/super.c:6233 [inline]
> ext4_mark_dquot_dirty+0x111/0x1b0 fs/ext4/super.c:6227
> mark_dquot_dirty fs/quota/dquot.c:372 [inline]
> mark_all_dquot_dirty fs/quota/dquot.c:412 [inline]
> __dquot_free_space+0x829/0xbd0 fs/quota/dquot.c:1940
> dquot_free_space_nodirty include/linux/quotaops.h:376 [inline]
> dquot_free_space include/linux/quotaops.h:381 [inline]
> dquot_free_block include/linux/quotaops.h:392 [inline]
> ext4_mb_clear_bb fs/ext4/mballoc.c:6156 [inline]
> ext4_free_blocks+0x1cc1/0x2200 fs/ext4/mballoc.c:6286
> ext4_remove_blocks fs/ext4/extents.c:2523 [inline]
> ext4_ext_rm_leaf fs/ext4/extents.c:2689 [inline]
> ext4_ext_remove_space+0x1e96/0x3ce0 fs/ext4/extents.c:2937
> ext4_ext_truncate+0x1ea/0x250 fs/ext4/extents.c:4471
> ext4_truncate+0xc37/0x1160 fs/ext4/inode.c:4249
> ext4_evict_inode+0xac2/0x1a50 fs/ext4/inode.c:289
> evict+0x32c/0x820 fs/inode.c:622
> iput_final fs/inode.c:1744 [inline]
> iput.part.0+0x4b6/0x6d0 fs/inode.c:1770
> iput+0x58/0x70 fs/inode.c:1760
> ext4_orphan_cleanup+0x565/0xf80 fs/ext4/orphan.c:474
> ext4_fill_super+0x8bb5/0xc920 fs/ext4/super.c:4975
> mount_bdev+0x336/0x400 fs/super.c:1400
> legacy_get_tree+0x106/0x220 fs/fs_context.c:611
> vfs_get_tree+0x8e/0x300 fs/super.c:1530
> do_new_mount fs/namespace.c:3012 [inline]
> path_mount+0x138a/0x1ff0 fs/namespace.c:3342
> do_mount fs/namespace.c:3355 [inline]
> __do_sys_mount fs/namespace.c:3563 [inline]
> __se_sys_mount fs/namespace.c:3540 [inline]
> __x64_sys_mount+0x282/0x300 fs/namespace.c:3540
> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> do_syscall_64+0x33/0x80 arch/x86/entry/common.c:80
> entry_SYSCALL_64_after_hwframe+0x6c/0xd6
> RIP: 0033:0x7fe399de916a
> Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f
> 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fe3989b4e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 00007fe3989b4ef0 RCX: 00007fe399de916a
> RDX: 0000000020000040 RSI: 0000000020000500 RDI: 00007fe3989b4eb0
> RBP: 0000000020000040 R08: 00007fe3989b4ef0 R09: 0000000000004500
> R10: 0000000000004500 R11: 0000000000000246 R12: 0000000020000500
> R13: 00007fe3989b4eb0 R14: 00000000000004b4 R15: 000000000000002c
> 
> ------------[ cut here end]------------
> 
> Root Cause:
> 
> The crash is caused by a potential circular locking dependency
> detected within the Linux kernel's Ext4 filesystem during quota
> management operations. Specifically, the task is attempting to acquire
> the dq_lock (&dquot->dq_lock) in the dquot_commit function
> (fs/quota/dquot.c:507) while another task already holds the i_data_sem
> lock (&ei->i_data_sem) in the ext4_map_blocks function
> (fs/ext4/inode.c:665). This situation creates a circular dependency
> where each lock is waiting for the other to be released, which can
> lead to a deadlock. The call trace reveals that the issue arises
> during the writeback process (wb_workfn) when the filesystem is trying
> to commit quota information (dquot_commit) while simultaneously
> handling inode data (ext4_map_blocks). The Kernel Lock Validator
> (lockdep) has flagged this as a possible circular dependency because
> the existing lock (i_data_sem) already depends on the new lock
> (dq_lock), violating the expected lock acquisition order. This
> improper lock ordering within the Ext4 quota handling and inode
> management paths indicates a flaw in the synchronization mechanisms,
> potentially caused by concurrent operations or incorrect lock
> hierarchy implementation. As a result, the kernel emits a warning to
> prevent a deadlock scenario, highlighting the need for revising the
> locking strategy to ensure that locks are acquired in a consistent and
> non-circular manner.
> 
> Thank you for your time and attention.

