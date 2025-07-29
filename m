Return-Path: <linux-ext4+bounces-9220-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E47FB153BE
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Jul 2025 21:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE9AB18905D4
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Jul 2025 19:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED33D24C669;
	Tue, 29 Jul 2025 19:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDH11pEo"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A6D2512FD;
	Tue, 29 Jul 2025 19:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753818254; cv=none; b=kPPsOuaWcXAhjOQcL6PTXCRHSB6soQd/j94/DhH5+x5WqamC22aO7my5WjPKAsmJm/BHx2OLJTqO/uTtUvXrf2LTmbtc1yJ8GYoy1KuOFEMbxSwBdZfTUIYdG4Q9qqSSU6eBi31pRzSunnBHIICrlsV9hB9SWKeAknaI8LA2xU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753818254; c=relaxed/simple;
	bh=6jTwPDO0eh4QASbSahA4vdXsCMh0dgOy7n3puJ+ozWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aTE9aZf5eWdqtCu3LCzg2pKsKAHfYLCfAxNZFNZXzFTIEMBMcOMel6SJIcwreYovOD2fUlnMwUyxgzhuztyy4GuHmQnyIldgZcC8ak61+VPwKB4D9BWfnIC+DPLe26Ss5FnX7X58g1lijiJwS5+dCRMmVbyRdJA5hN80UI5EKOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mDH11pEo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF35C4CEEF;
	Tue, 29 Jul 2025 19:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753818254;
	bh=6jTwPDO0eh4QASbSahA4vdXsCMh0dgOy7n3puJ+ozWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mDH11pEoLcnOVBjP3vv7tJlnQw2ZkQyvc00B8xv2ur3r4maG7vI2lElOKgSHb7Iop
	 M7LylqZIbez/nsJqQb19H/mji332VPJvysS6ZL5zcsEbfh14fsg3muZbdWeBFeVhc0
	 xJJCmLohiFMWgQUMYczYXhCLq4nQ/iS8KkrzMkiTH7T0upBkOdF5Gxmve/qpEWLvxl
	 ERyOpGJfxXSQiV9me+Nuk82wzwx2YlJ99Vzj30epVqqmSjOx+nYb5UtUKxfMAjlOkk
	 MBpIMz8/LZAN7017r58ziisL9zVh0WclRH7gGsa++rho2it+xsLoZaBtEP3vuLbYEV
	 tWasPksPJyhMg==
Date: Tue, 29 Jul 2025 12:44:13 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
	Ritesh Harjani <ritesh.list@gmail.com>, john.g.garry@oracle.com,
	tytso@mit.edu, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 11/13] ext4/062: Atomic writes test for bigalloc using
 fio crc verifier on multiple files
Message-ID: <20250729194413.GU2672039@frogsfrogsfrogs>
References: <cover.1752329098.git.ojaswin@linux.ibm.com>
 <0116498a542ba9ea9026b2b61ad747eca31f931d.1752329098.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0116498a542ba9ea9026b2b61ad747eca31f931d.1752329098.git.ojaswin@linux.ibm.com>

On Sat, Jul 12, 2025 at 07:42:53PM +0530, Ojaswin Mujoo wrote:
> From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
> 
> Brute force all possible blocksize clustersize combination on a bigalloc
> filesystem for stressing atomic write using fio data crc verifier. We run
> multiple threads in parallel with each job writing to its own file. The
> parallel jobs running on a constrained filesystem size ensure that we stress
> the ext4 allocator to allocate contiguous extents.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>  tests/ext4/062     | 176 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/ext4/062.out |   2 +
>  2 files changed, 178 insertions(+)
>  create mode 100755 tests/ext4/062
>  create mode 100644 tests/ext4/062.out
> 
> diff --git a/tests/ext4/062 b/tests/ext4/062
> new file mode 100755
> index 00000000..85b82f97
> --- /dev/null
> +++ b/tests/ext4/062
> @@ -0,0 +1,176 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
> +#
> +# FS QA Test 061
> +#
> +# Brute force all possible blocksize clustersize combination on a bigalloc
> +# filesystem for stressing atomic write using fio data crc verifier. We run
> +# nproc * $LOAD_FACTOR threads in parallel writing to a single
> +# $SCRATCH_MNT/test-file. We also create 8 such parallel jobs to run on
> +# a constrained filesystem size to stress the ext4 allocator to allocate
> +# contiguous extents.

Looks ok to me,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> +#
> +
> +. ./common/preamble
> +. ./common/atomicwrites
> +
> +_begin_fstest auto rw stress atomicwrites
> +
> +_require_scratch_write_atomic
> +_require_aiodio
> +
> +FSSIZE=$((360*1024*1024))
> +FIO_LOAD=$(($(nproc) * LOAD_FACTOR))
> +fiobsize=4096
> +
> +# Calculate fsblocksize as per bdev atomic write units.
> +bdev_awu_min=$(_get_atomic_write_unit_min $SCRATCH_DEV)
> +bdev_awu_max=$(_get_atomic_write_unit_max $SCRATCH_DEV)
> +fsblocksize=$(_max 4096 "$bdev_awu_min")
> +
> +function create_fio_configs()
> +{
> +	create_fio_aw_config
> +	create_fio_verify_config
> +}
> +
> +function create_fio_verify_config()
> +{
> +cat >$fio_verify_config <<EOF
> +	[global]
> +	direct=1
> +	ioengine=libaio
> +	rw=randwrite
> +	bs=$fiobsize
> +	fallocate=truncate
> +	size=$((FSSIZE / 12))
> +	iodepth=$FIO_LOAD
> +	numjobs=$FIO_LOAD
> +	group_reporting=1
> +	atomic=1
> +
> +	verify_only=1
> +	verify_state_save=0
> +	verify=crc32c
> +	verify_fatal=1
> +	verify_write_sequence=0
> +
> +	[verify-job1]
> +	filename=$SCRATCH_MNT/testfile-job1
> +
> +	[verify-job2]
> +	filename=$SCRATCH_MNT/testfile-job2
> +
> +	[verify-job3]
> +	filename=$SCRATCH_MNT/testfile-job3
> +
> +	[verify-job4]
> +	filename=$SCRATCH_MNT/testfile-job4
> +
> +	[verify-job5]
> +	filename=$SCRATCH_MNT/testfile-job5
> +
> +	[verify-job6]
> +	filename=$SCRATCH_MNT/testfile-job6
> +
> +	[verify-job7]
> +	filename=$SCRATCH_MNT/testfile-job7
> +
> +	[verify-job8]
> +	filename=$SCRATCH_MNT/testfile-job8
> +
> +EOF
> +}
> +
> +function create_fio_aw_config()
> +{
> +cat >$fio_aw_config <<EOF
> +	[global]
> +	direct=1
> +	ioengine=libaio
> +	rw=randwrite
> +	bs=$fiobsize
> +	fallocate=truncate
> +	size=$((FSSIZE / 12))
> +	iodepth=$FIO_LOAD
> +	numjobs=$FIO_LOAD
> +	group_reporting=1
> +	atomic=1
> +
> +	verify_state_save=0
> +	verify=crc32c
> +	do_verify=0
> +
> +	[write-job1]
> +	filename=$SCRATCH_MNT/testfile-job1
> +
> +	[write-job2]
> +	filename=$SCRATCH_MNT/testfile-job2
> +
> +	[write-job3]
> +	filename=$SCRATCH_MNT/testfile-job3
> +
> +	[write-job4]
> +	filename=$SCRATCH_MNT/testfile-job4
> +
> +	[write-job5]
> +	filename=$SCRATCH_MNT/testfile-job5
> +
> +	[write-job6]
> +	filename=$SCRATCH_MNT/testfile-job6
> +
> +	[write-job7]
> +	filename=$SCRATCH_MNT/testfile-job7
> +
> +	[write-job8]
> +	filename=$SCRATCH_MNT/testfile-job8
> +
> +EOF
> +}
> +
> +# Let's create a sample fio config to check whether fio supports all options.
> +fio_aw_config=$tmp.aw.fio
> +fio_verify_config=$tmp.verify.fio
> +fio_out=$tmp.fio.out
> +
> +create_fio_configs
> +_require_fio $fio_aw_config
> +
> +for ((fsblocksize=$fsblocksize; fsblocksize <= $(_get_page_size); fsblocksize = $fsblocksize << 1)); do
> +	# cluster sizes above 16 x blocksize are experimental so avoid them
> +	# Also, cap cluster size at 128kb to keep it reasonable for large
> +	# blocks size cases.
> +	fs_max_clustersize=$(_min $((16 * fsblocksize)) "$bdev_awu_max" $((128 * 1024)))
> +
> +	for ((fsclustersize=$fsblocksize; fsclustersize <= $fs_max_clustersize; fsclustersize = $fsclustersize << 1)); do
> +		for ((fiobsize = $fsblocksize; fiobsize <= $fsclustersize; fiobsize = $fiobsize << 1)); do
> +			MKFS_OPTIONS="-O bigalloc -b $fsblocksize -C $fsclustersize"
> +			_scratch_mkfs_sized "$FSSIZE" >> $seqres.full 2>&1 || continue
> +			if _try_scratch_mount >> $seqres.full 2>&1; then
> +				echo "== FIO test for fsblocksize=$fsblocksize fsclustersize=$fsclustersize fiobsize=$fiobsize ==" >> $seqres.full
> +
> +				touch $SCRATCH_MNT/f1
> +				create_fio_configs
> +
> +				cat $fio_aw_config >> $seqres.full
> +				cat $fio_verify_config >> $seqres.full
> +
> +				$FIO_PROG $fio_aw_config >> $seqres.full
> +				ret1=$?
> +
> +				$FIO_PROG $fio_verify_config  >> $seqres.full
> +				ret2=$?
> +
> +				_scratch_unmount
> +
> +				[[ $ret1 -eq 0 && $ret2 -eq 0 ]] || _fail "fio with atomic write failed"
> +			fi
> +		done
> +	done
> +done
> +
> +# success, all done
> +echo Silence is golden
> +status=0
> +exit
> diff --git a/tests/ext4/062.out b/tests/ext4/062.out
> new file mode 100644
> index 00000000..a1578f48
> --- /dev/null
> +++ b/tests/ext4/062.out
> @@ -0,0 +1,2 @@
> +QA output created by 062
> +Silence is golden
> -- 
> 2.49.0
> 
> 

