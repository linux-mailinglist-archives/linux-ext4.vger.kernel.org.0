Return-Path: <linux-ext4+bounces-11829-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB26C53DD8
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Nov 2025 19:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F50B4E04A6
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Nov 2025 18:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B87F348894;
	Wed, 12 Nov 2025 18:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ie2Qql5f"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1945F329C64;
	Wed, 12 Nov 2025 18:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762970750; cv=none; b=kM4d9+0vNJuS+j1dCCuJIAhf2qWrGTDWVwM2dLt9Cfsxi6uLZODSnoVHEmZ7wzVBNj4YHTCI3AcpRBsf4frD/m1MeW9BWpVbxyRksC1FUir53fPfzDZMxYCPaGaUslMmGxQysp2I4eYiKBCK6NeNJzenS6LdbbMQX8i1tTZ38Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762970750; c=relaxed/simple;
	bh=K6mIgHlRVr4RQHM2LC+rQO8DlVLYN2kPrpWaw3AMSFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DO5TPcfFnOP59OquphXw/+mItJrdxfYZ1210SjXD99fT0oLFf2AlB7kLLdzbdqOLIDsgAJgLUTIbbJmo5DF5Jt+dqiy/uj0xJJRo/Bls/Ub/1OpHivIj3rY5x99CKQSMtM26D6dadpAJOO/zRNuRkjAhv/mQzFpjCPV1J3j076Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ie2Qql5f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFCDAC4CEF1;
	Wed, 12 Nov 2025 18:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762970749;
	bh=K6mIgHlRVr4RQHM2LC+rQO8DlVLYN2kPrpWaw3AMSFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ie2Qql5fXfoTRUVI/4qGp1vGfYG7MUQrAgXcegxX2k3BSrl4bvM8Xdslxs/toxdWc
	 bwW4QoriLPk3PgZ5A7Sf6O4y/j2TkVzT0WWz/Oxj8PBAk3+sJuIz06M4Gfm8CtSGtM
	 0V7P+286jIXI0NIdfrA2JU4WKtVpH1clHARrL8fy39CuHviZxtfp9CT4Fzw+43y1Ck
	 SXPuhl1izQ03YPkRWdZ3QaPIY2VoXfXYOJ9hJf9W+Gkt/7VgecdS5aoSrhJCCUH0Uo
	 MMILnNo0AuFf8kaAPkn9olm66eSwXBMnr6fRhsVaG0lYgeT/SUTEcXgrtgpoqgjtkl
	 gnJ2VEwZepDyQ==
Date: Wed, 12 Nov 2025 10:05:49 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: zlang@redhat.com, fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 6/7] generic/774: reduce file size
Message-ID: <20251112180549.GD196366@frogsfrogsfrogs>
References: <176279908967.605950.2192923313361120314.stgit@frogsfrogsfrogs>
 <176279909116.605950.12144124358096086284.stgit@frogsfrogsfrogs>
 <aRMCWr2UHlc2FawQ@infradead.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRMCWr2UHlc2FawQ@infradead.org>

On Tue, Nov 11, 2025 at 01:31:06AM -0800, Christoph Hellwig wrote:
> On Mon, Nov 10, 2025 at 10:27:35AM -0800, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > We've gotten complaints about this test taking hours to run and
> > producing stall warning on test VMs with a large number of cpu cores.  I
> 
> Btw, we should still find a way to avoid stalls for anything a user
> can easily trigger, independent of fixing the test case.  What were
> these stall warnings?

The ones I see look like this:

FSTYP         -- xfs (debug)
PLATFORM      -- Linux/x86_64 oci-mtr49 6.18.0-rc5-xfsx #rc5 SMP PREEMPT_DYNAMIC Sun Nov  9 20:11:20 PST 2025
MKFS_OPTIONS  -- -f -m metadir=1,autofsck=1,uquota,gquota,pquota, -b size=32768, /dev/sda4
MOUNT_OPTIONS -- /dev/sda4 /opt

and dmesg does this:

run fstests generic/774 at 2025-11-10 13:37:52
XFS (sda3): EXPERIMENTAL large block size feature enabled.  Use at your own risk!
XFS (sda3): EXPERIMENTAL metadata directory tree feature enabled.  Use at your own risk!
XFS (sda3): Mounting V5 Filesystem 0280a424-6e91-401b-8c47-864532b77ceb
XFS (sda3): Ending clean mount
XFS (sda4): EXPERIMENTAL large block size feature enabled.  Use at your own risk!
XFS (sda4): EXPERIMENTAL metadata directory tree feature enabled.  Use at your own risk!
XFS (sda4): Mounting V5 Filesystem f09b8bdf-3518-44e5-97cb-e0ab36808488
XFS (sda4): Ending clean mount
XFS (sda4): Quotacheck needed: Please wait.
XFS (sda4): Quotacheck: Done.
XFS (sda4): Unmounting Filesystem f09b8bdf-3518-44e5-97cb-e0ab36808488
XFS (sda4): EXPERIMENTAL large block size feature enabled.  Use at your own risk!
XFS (sda4): EXPERIMENTAL metadata directory tree feature enabled.  Use at your own risk!
XFS (sda4): Mounting V5 Filesystem 11615837-dfa0-47b8-a078-21f9f1f7525b
XFS (sda4): Ending clean mount
XFS (sda4): Quotacheck needed: Please wait.
XFS (sda4): Quotacheck: Done.
workqueue: iomap_dio_complete_work hogged CPU for >10666us 4 times, consider switching to WQ_UNBOUND
workqueue: iomap_dio_complete_work hogged CPU for >10666us 5 times, consider switching to WQ_UNBOUND
workqueue: iomap_dio_complete_work hogged CPU for >10666us 7 times, consider switching to WQ_UNBOUND
workqueue: iomap_dio_complete_work hogged CPU for >10666us 11 times, consider switching to WQ_UNBOUND
workqueue: iomap_dio_complete_work hogged CPU for >10666us 19 times, consider switching to WQ_UNBOUND
INFO: task 3:1:2248454 blocked for more than 61 seconds.
      Tainted: G        W           6.18.0-rc5-xfsx #rc5
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:3:1             state:D stack:12744 pid:2248454 tgid:2248454 ppid:2      task_flags:0x4248060 flags:0x00080000
Workqueue: dio/sda4 iomap_dio_complete_work
Call Trace:
 <TASK>
 __schedule+0x4cb/0x1a70
 ? check_preempt_wakeup_fair+0x162/0x2a0
 ? wakeup_preempt+0x66/0x70
 schedule+0x2a/0xe0
 schedule_preempt_disabled+0x18/0x30
 rwsem_down_write_slowpath+0x2c5/0x780
 down_write+0x6e/0x70
 xfs_reflink_end_atomic_cow+0x133/0x200 [xfs 28bfed63550f2a1085614a29851734fab813b29a]
 ? finish_task_switch.isra.0+0x9b/0x2b0
 xfs_dio_write_end_io+0x117/0x320 [xfs 28bfed63550f2a1085614a29851734fab813b29a]
 iomap_dio_complete+0x41/0x240
 ? aio_fsync_work+0x120/0x120
 iomap_dio_complete_work+0x17/0x30
 process_one_work+0x196/0x3e0
 worker_thread+0x264/0x380
 ? _raw_spin_unlock_irqrestore+0x1e/0x40
 ? rescuer_thread+0x4f0/0x4f0
 kthread+0x117/0x270
 ? kthread_complete_and_exit+0x20/0x20
 ? kthread_complete_and_exit+0x20/0x20
 ret_from_fork+0xa4/0xe0
 ? kthread_complete_and_exit+0x20/0x20
 ret_from_fork_asm+0x11/0x20
 </TASK>
INFO: task 3:1:2248454 <writer> blocked on an rw-semaphore likely owned by task 3:13:2308404 <writer>
INFO: task 3:13:2308404 blocked for more than 61 seconds.
      Tainted: G        W           6.18.0-rc5-xfsx #rc5
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:3:13            state:D stack:12184 pid:2308404 tgid:2308404 ppid:2      task_flags:0x4248060 flags:0x00080000
Workqueue: dio/sda4 iomap_dio_complete_work
Call Trace:
 <TASK>
 __schedule+0x4cb/0x1a70
 ? do_raw_spin_unlock+0x49/0xb0
 ? _raw_spin_unlock_irqrestore+0x1e/0x40
 schedule+0x2a/0xe0
 xlog_grant_head_wait+0x5c/0x2a0 [xfs 28bfed63550f2a1085614a29851734fab813b29a]
 ? kmem_cache_free+0x540/0x5b0
 xlog_grant_head_check+0x10e/0x180 [xfs 28bfed63550f2a1085614a29851734fab813b29a]
 xfs_log_regrant+0xc2/0x1e0 [xfs 28bfed63550f2a1085614a29851734fab813b29a]
 xfs_trans_roll+0x90/0xc0 [xfs 28bfed63550f2a1085614a29851734fab813b29a]
 xfs_defer_trans_roll+0x73/0x120 [xfs 28bfed63550f2a1085614a29851734fab813b29a]
 xfs_defer_finish_noroll+0x2a3/0x520 [xfs 28bfed63550f2a1085614a29851734fab813b29a]
 xfs_trans_commit+0x3d/0x70 [xfs 28bfed63550f2a1085614a29851734fab813b29a]
 xfs_reflink_end_atomic_cow+0x19c/0x200 [xfs 28bfed63550f2a1085614a29851734fab813b29a]
 ? finish_task_switch.isra.0+0x9b/0x2b0
 xfs_dio_write_end_io+0x117/0x320 [xfs 28bfed63550f2a1085614a29851734fab813b29a]
 iomap_dio_complete+0x41/0x240
 ? aio_fsync_work+0x120/0x120
 iomap_dio_complete_work+0x17/0x30
 process_one_work+0x196/0x3e0
 worker_thread+0x264/0x380
 ? _raw_spin_unlock_irqrestore+0x1e/0x40
 ? rescuer_thread+0x4f0/0x4f0
 kthread+0x117/0x270
 ? kthread_complete_and_exit+0x20/0x20
 ? kthread_complete_and_exit+0x20/0x20
 ret_from_fork+0xa4/0xe0
 ? kthread_complete_and_exit+0x20/0x20
 ret_from_fork_asm+0x11/0x20
 </TASK>

I think this is an ABBA livelock where nearly all the threads hold a log
grant reservation and are trying to obtain ILOCK; but one thread is in
the middle of an atomic cow write ioend transaction chain but has run
out of permanent reservation during xfs_trans_roll, which means it holds
ILOCK and is trying to reserve log grant space.

I also suspect this could happen with regular ioend remapping of shared
space after a COW.  Perhaps for these ioend types we should chain ioends
together like we do for direct writes to zoned storage.  Remapping isn't
going to be low-latency like pure overwrites anyway.

> The patch looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks!

--D

