Return-Path: <linux-ext4+bounces-6666-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2676A4EBF4
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Mar 2025 19:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 547E41899BDC
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Mar 2025 18:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008FD24EAA5;
	Tue,  4 Mar 2025 18:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="shrwxobu"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95819238D25;
	Tue,  4 Mar 2025 18:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741112820; cv=none; b=P6Q/Km0UgQSLlJRm2zs1U/IH5+FZMeTttjV+GiqWQYZUL79t57yOQZ+lFShxtM4w8wQRN1WS1Mg3qHbwWwdtiX5Q5ldOLO8X8dpLnJz/wu9+9bMbIcK9WJ80hR1SwGbYxMOdfiN7TapUMJL/OsacakBngJdkjQ2lwx4Np4rtsKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741112820; c=relaxed/simple;
	bh=KDbQMTmemyGh9g0g8iMaqhWOBnjTgJtMl7J66hpszjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jVj+whpWFku5/jGaeZk6nuI5HRNTZ4HOMgur2LiRUeMiHaOVGnFyFIGzKaBsBMdyGUEJoQ5HRfAIEhV8f6jYAfUvEL2RUDBWGrMuYk4SltBY/0kjEXVu/mHPyP6lv8xdSdvILqplo64ZoFp94g80kAu4DTOfc65gxSknWNnsuwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=shrwxobu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02BECC4CEE5;
	Tue,  4 Mar 2025 18:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741112820;
	bh=KDbQMTmemyGh9g0g8iMaqhWOBnjTgJtMl7J66hpszjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=shrwxobu/RBO+T+Thr0Zn9u6ynksVDMdrBwgWVs/dlXYcvyDUAtAq6gtLC9ZjpcK9
	 lIOEebKOuQIEX/+pM/J9sSYTnylRvVuRdmu2ZG70OjtN59Qn/crNXKY2WOrABtjF15
	 yUlAQgNY6O8pihZ5VQoKUVlG6P3993oa0wVoTkpktVXnySBQN9n2SwNBG6j0Vnlkwd
	 Cjh68jLit5tLtMTzIY06YCX3xWdbdZd/exNtQn7mvJPb8oJC9YR9iDcBJQnCUt46QQ
	 PuVoZFZMqbkCPlYmrItpWautn6IyOEzhEP3psQJAVvFjB3rSZXKIYqYBcCUqjKRd4V
	 ZNHI9yqt0MUWw==
Date: Tue, 4 Mar 2025 10:26:59 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/1] common: test statfs reporting with project quota
Message-ID: <20250304182659.GC2803740@frogsfrogsfrogs>
References: <173992590656.4080455.15086949489894120802.stgit@frogsfrogsfrogs>
 <173992590675.4080455.17713454161928793525.stgit@frogsfrogsfrogs>
 <20250302162610.y4l453sjzlw75agr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250302162610.y4l453sjzlw75agr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Mon, Mar 03, 2025 at 12:26:10AM +0800, Zorro Lang wrote:
> On Tue, Feb 18, 2025 at 05:03:39PM -0800, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Create a test to check that statfs on a directory tree with a project
> > quota will report the quota limit and available blocks; and that the
> > available blocks reported doesn't exceed that of the whole filesystem.
> > 
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > ---
> >  tests/generic/1955     |  114 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/1955.out |   13 +++++
> >  2 files changed, 127 insertions(+)
> >  create mode 100755 tests/generic/1955
> >  create mode 100644 tests/generic/1955.out
> > 
> > 
> > diff --git a/tests/generic/1955 b/tests/generic/1955
> > new file mode 100755
> > index 00000000000000..e431b3c4e3fd5d
> > --- /dev/null
> > +++ b/tests/generic/1955
> > @@ -0,0 +1,114 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2024-2025 Oracle.  All Rights Reserved.
> > +#
> > +# FS QA Test No. 1955
> > +#
> > +# Make sure that statfs reporting works when project quotas are set on a
> > +# directory tree.
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quota
> > +
> > +_fixed_by_git_commit kernel XXXXXXXXXXXXXX \
> > +	"xfs: don't over-report free space or inodes in statvfs"
> 
> 
> Ext4 fails on this test [1], is it a known issue of ext4 besides xfs?

Yeah, known issue on ext4 (and probably f2fs too).

--D

> Thanks,
> Zorro
> 
> [1]
> FSTYP         -- ext4
> PLATFORM      -- Linux/aarch64 hpe-apollo-cn99xx-14-vm-28 6.14.0-rc4+ #1 SMP PREEMPT_DYNAMIC Sat Mar  1 16:57:43 EST 2025
> MKFS_OPTIONS  -- -F /dev/vda3
> MOUNT_OPTIONS -- -o acl,user_xattr -o context=system_u:object_r:root_t:s0 /dev/vda3 /mnt/xfstests/scratch
> 
> generic/762       - output mismatch (see /var/lib/xfstests/results//generic/762.out.bad)
>     --- tests/generic/762.out	2025-03-01 17:23:52.961878242 -0500
>     +++ /var/lib/xfstests/results//generic/762.out.bad	2025-03-01 19:13:03.026588012 -0500
>     @@ -6,8 +6,10 @@
>      root blocks2 is in range
>      dir blocks2 is in range
>      root bavail2 is in range
>     -dir bavail2 is in range
>     +dir bavail2 has value of 1821553
>     +dir bavail2 is NOT in range 360666.9 .. 367953.1
>      root blocks3 is in range
>     ...
>     (Run 'diff -u /var/lib/xfstests/tests/generic/762.out /var/lib/xfstests/results//generic/762.out.bad'  to see the entire diff)
> 
> HINT: You _MAY_ be missing kernel fix:
>       XXXXXXXXXXXXXX xfs: don't over-report free space or inodes in statvfs
> 
> Ran: generic/762
> Failures: generic/762
> Failed 1 of 1 tests
> 
> > +
> > +. ./common/filter
> > +. ./common/quota
> > +
> > +_require_quota
> > +_require_scratch
> > +_require_xfs_io_command 'chproj'
> > +_require_xfs_io_command "falloc"
> > +
> > +_scratch_mkfs >$seqres.full 2>&1
> > +_scratch_enable_pquota
> > +_qmount_option "prjquota"
> > +_qmount
> > +_force_vfs_quota_testing $SCRATCH_MNT
> > +_require_prjquota $SCRATCH_DEV
> > +
> > +mkdir $SCRATCH_MNT/dir
> > +
> > +bsize() {
> > +	$XFS_IO_PROG -c 'statfs' $1 | grep f_bsize | awk '{print $3}'
> > +}
> > +
> > +blocks() {
> > +	$XFS_IO_PROG -c 'statfs' $1 | grep f_blocks | awk '{print $3}'
> > +}
> > +
> > +bavail() {
> > +	$XFS_IO_PROG -c 'statfs' $1 | grep f_bavail | awk '{print $3}'
> > +}
> > +
> > +bsize=$(bsize $SCRATCH_MNT)
> > +orig_bavail=$(bavail $SCRATCH_MNT)
> > +orig_blocks=$(blocks $SCRATCH_MNT)
> > +
> > +# Set a project quota limit of half the free space, make sure both report the
> > +# same number of blocks
> > +pquot_limit=$(( orig_bavail / 2 ))
> > +setquota -P 55 0 $((pquot_limit * bsize / 1024))K 0 0 $SCRATCH_DEV
> > +$XFS_IO_PROG -c 'chproj 55' -c 'chattr +P' $SCRATCH_MNT/dir
> > +
> > +# check statfs reporting
> > +fs_blocks=$(blocks $SCRATCH_MNT)
> > +dir_blocks=$(blocks $SCRATCH_MNT/dir)
> > +
> > +_within_tolerance "root blocks1" $fs_blocks $orig_blocks 1% -v
> > +_within_tolerance "dir blocks1" $dir_blocks $pquot_limit 1% -v
> > +
> > +fs_bavail=$(bavail $SCRATCH_MNT)
> > +expected_dir_bavail=$pquot_limit
> > +dir_bavail=$(bavail $SCRATCH_MNT/dir)
> > +
> > +_within_tolerance "root bavail1" $fs_bavail $orig_bavail 1% -v
> > +_within_tolerance "dir bavail1" $dir_bavail $expected_dir_bavail 1% -v
> > +
> > +# use up most of the free space in the filesystem
> > +rem_free=$(( orig_bavail / 10 ))	# bsize blocks
> > +fallocate -l $(( (orig_bavail - rem_free) * bsize )) $SCRATCH_MNT/a
> > +
> > +if [ $rem_free -gt $pquot_limit ]; then
> > +	echo "rem_free $rem_free greater than pquot_limit $pquot_limit??"
> > +fi
> > +
> > +# check statfs reporting
> > +fs_blocks=$(blocks $SCRATCH_MNT)
> > +dir_blocks=$(blocks $SCRATCH_MNT/dir)
> > +
> > +_within_tolerance "root blocks2" $fs_blocks $orig_blocks 1% -v
> > +_within_tolerance "dir blocks2" $dir_blocks $pquot_limit 1% -v
> > +
> > +fs_bavail=$(bavail $SCRATCH_MNT)
> > +dir_bavail=$(bavail $SCRATCH_MNT/dir)
> > +
> > +_within_tolerance "root bavail2" $fs_bavail $rem_free 1% -v
> > +_within_tolerance "dir bavail2" $dir_bavail $rem_free 1% -v
> > +
> > +# use up 10 blocks of project quota
> > +$XFS_IO_PROG -f -c "pwrite -S 0x99 0 $((bsize * 10))" -c fsync $SCRATCH_MNT/dir/a >> $seqres.full
> > +
> > +# check statfs reporting
> > +fs_blocks=$(blocks $SCRATCH_MNT)
> > +dir_blocks=$(blocks $SCRATCH_MNT/dir)
> > +
> > +_within_tolerance "root blocks3" $fs_blocks $orig_blocks 1% -v
> > +_within_tolerance "dir blocks3" $dir_blocks $pquot_limit 1% -v
> > +
> > +fs_bavail=$(bavail $SCRATCH_MNT)
> > +dir_bavail=$(bavail $SCRATCH_MNT/dir)
> > +
> > +_within_tolerance "root bavail3" $fs_bavail $rem_free 1% -v
> > +_within_tolerance "dir bavail3" $dir_bavail $((rem_free - 10)) 1% -v
> > +
> > +# final state diagnostics
> > +$XFS_IO_PROG -c 'statfs' $SCRATCH_MNT $SCRATCH_MNT/dir | grep statfs >> $seqres.full
> > +repquota -P $SCRATCH_DEV >> $seqres.full
> > +df $SCRATCH_MNT >> $seqres.full
> > +ls -laR $SCRATCH_MNT/ >> $seqres.full
> > +
> > +# success, all done
> > +status=0
> > +exit
> > diff --git a/tests/generic/1955.out b/tests/generic/1955.out
> > new file mode 100644
> > index 00000000000000..3601010962193e
> > --- /dev/null
> > +++ b/tests/generic/1955.out
> > @@ -0,0 +1,13 @@
> > +QA output created by 1955
> > +root blocks1 is in range
> > +dir blocks1 is in range
> > +root bavail1 is in range
> > +dir bavail1 is in range
> > +root blocks2 is in range
> > +dir blocks2 is in range
> > +root bavail2 is in range
> > +dir bavail2 is in range
> > +root blocks3 is in range
> > +dir blocks3 is in range
> > +root bavail3 is in range
> > +dir bavail3 is in range
> > 
> 
> 

