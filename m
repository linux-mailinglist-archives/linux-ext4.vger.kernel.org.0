Return-Path: <linux-ext4+bounces-9751-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B9CB3A3CE
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Aug 2025 17:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9AFB175271
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Aug 2025 15:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A59A258EF9;
	Thu, 28 Aug 2025 15:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPQkArcf"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA7D1E8324;
	Thu, 28 Aug 2025 15:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756393789; cv=none; b=FJ2QXWI3n28BqY3p5DKvW3SauWWBZlwOciWWZTFHD+ajmwouO8tbLxyV3LpZlTa3eJ0WJQCZIpZ9kH741U519NoEMcq/f7oqc1cc2fRkgrNCOQmkoxoGbyzyqKUxqSK6UQxVYdzYLVQkwMqzQFuKF4Mq7R+7ay6VoA1w8a0SIAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756393789; c=relaxed/simple;
	bh=YIyJiGHrdvf/AdzZEMdQ8OSqEdl+TQ8pU/saHGj6PYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjPYvRTLNKmfqiR1FhNj0qfNguywo2cRW1R4Z4eCogNYmKjuxLjQtyqmlPkB3AGyesX4gcvbrAwGRxL0IpsquojHm8nZWM65oqbfdngrzdaO019MCbh4okW0es5FC+/vZNka5RLhAq5BvJEp5gplFQ5Rms5/bVa7Do/jtuBuxEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPQkArcf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39700C4CEEB;
	Thu, 28 Aug 2025 15:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756393788;
	bh=YIyJiGHrdvf/AdzZEMdQ8OSqEdl+TQ8pU/saHGj6PYg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VPQkArcfp8fp5p7gzuD/X4PKg+CeSA9RuFEDqaM2qcftddAu+CehBWCTQkcJzB5F2
	 E46zzbijD4zQr/4mr6PvagvZX3RNl0bKtSQlaufdMvvLtyedpPjo0nkih2v7tE7GwB
	 G93LzDWUBLP9xYufYSU74Z+ZH5vgieLVyuQ3E+327uRnYhW0IpKUjDWLRJdqBZlM/1
	 cWDXUAKj4+sSGUyb2lxunlss8IvdJP9FJOD/EKExsijL5PHiUgciPYoh0Epw59Dz2C
	 0wIvjLK14CZqk9/MEE9xIiGFrcPc0KPgknnYNAE6lv17ldrEsGAA0JfN5dFU/qC+Z3
	 Ug30qKE4unqxA==
Date: Thu, 28 Aug 2025 08:09:47 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
	Ritesh Harjani <ritesh.list@gmail.com>, john.g.garry@oracle.com,
	tytso@mit.edu, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v5 10/12] ext4: test atomic write and ioend codepaths
 with bigalloc
Message-ID: <20250828150947.GC8092@frogsfrogsfrogs>
References: <cover.1755849134.git.ojaswin@linux.ibm.com>
 <5a39bfbbd73f8598e9f85fb4420955c8a95c78a2.1755849134.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a39bfbbd73f8598e9f85fb4420955c8a95c78a2.1755849134.git.ojaswin@linux.ibm.com>

On Fri, Aug 22, 2025 at 01:32:09PM +0530, Ojaswin Mujoo wrote:
> From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
> 
> This test does a lot of parallel RWF_ATOMIC IO on a preallocated file to
> stress the write and end-io unwritten conversion code paths. We brute
> force this for different blocksize and clustersizes and after each
> iteration we ensure the data was not torn or corrupted using fio crc
> verification.
> 
> Note that in this test we use overlapping atomic writes of same io size.
> Although serializing racing writes is not guaranteed for RWF_ATOMIC,
> NVMe and SCSI provide this guarantee as an inseparable feature to
> power-fail atomicity. Keeping the iosize as same also ensures that ext4
> doesn't tear the write due to racing ioend unwritten conversion.
> 
> The value of this test is that we make sure the RWF_ATOMIC is handled
> correctly by ext4 as well as test that the block layer doesn't split or
> only generate multiple bios for an atomic write.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Looks good to me!
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  tests/ext4/061     | 155 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/ext4/061.out |   2 +
>  2 files changed, 157 insertions(+)
>  create mode 100755 tests/ext4/061
>  create mode 100644 tests/ext4/061.out
> 
> diff --git a/tests/ext4/061 b/tests/ext4/061
> new file mode 100755
> index 00000000..0ccf9f69
> --- /dev/null
> +++ b/tests/ext4/061
> @@ -0,0 +1,155 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
> +#
> +# FS QA Test 061
> +#
> +# This test does a lot of parallel RWF_ATOMIC IO on a preallocated file to
> +# stress the write and end-io unwritten conversion code paths. We brute force
> +# this for all possible blocksize and clustersizes and after each iteration we
> +# ensure the data was not torn or corrupted using fio crc verification.
> +#
> +# Note that in this test we use overlapping atomic writes of same io size.
> +# Although serializing racing writes is not guaranteed for RWF_ATOMIC, NVMe and
> +# SCSI provide this guarantee as an inseparable feature to power-fail
> +# atomicity. Keeping the iosize as same also ensures that ext4 doesn't tear the
> +# write due to racing ioend unwritten conversion.
> +#
> +# The value of this test is that we make sure the RWF_ATOMIC is handled
> +# correctly by ext4 as well as test that the block layer doesn't split or only
> +# generate multiple bios for an atomic write.
> +
> +. ./common/preamble
> +. ./common/atomicwrites
> +
> +_begin_fstest auto rw stress atomicwrites
> +
> +_require_scratch_write_atomic
> +_require_aiodio
> +_require_fio_version "3.38+"
> +
> +FIO_LOAD=$(($(nproc) * 2 * LOAD_FACTOR))
> +SIZE=$((100*1024*1024))
> +
> +# Calculate fsblocksize as per bdev atomic write units.
> +bdev_awu_min=$(_get_atomic_write_unit_min $SCRATCH_DEV)
> +bdev_awu_max=$(_get_atomic_write_unit_max $SCRATCH_DEV)
> +bs=$(_max 4096 "$bdev_awu_min")
> +
> +function create_fio_configs()
> +{
> +	local bsize=$1
> +	create_fio_aw_config $bsize
> +	create_fio_verify_config $bsize
> +}
> +
> +function create_fio_verify_config()
> +{
> +	local bsize=$1
> +cat >$fio_verify_config <<EOF
> +	[aio-dio-aw-verify]
> +	direct=1
> +	ioengine=libaio
> +	rw=read
> +	bs=$bsize
> +	fallocate=native
> +	filename=$SCRATCH_MNT/test-file
> +	size=$SIZE
> +	iodepth=$FIO_LOAD
> +	numjobs=$FIO_LOAD
> +	atomic=1
> +	group_reporting=1
> +
> +	verify_only=1
> +	verify_state_save=0
> +	verify=crc32c
> +	verify_fatal=1
> +	verify_write_sequence=0
> +EOF
> +}
> +
> +function create_fio_aw_config()
> +{
> +	local bsize=$1
> +cat >$fio_aw_config <<EOF
> +	[aio-dio-aw]
> +	direct=1
> +	ioengine=libaio
> +	rw=randwrite
> +	bs=$bsize
> +	fallocate=native
> +	filename=$SCRATCH_MNT/test-file
> +	size=$SIZE
> +	iodepth=$FIO_LOAD
> +	numjobs=$FIO_LOAD
> +	group_reporting=1
> +	atomic=1
> +
> +	verify_state_save=0
> +	verify=crc32c
> +	do_verify=0
> +
> +EOF
> +}
> +
> +run_test_one() {
> +	local bs=$1
> +	local cs=$2
> +	local iosize=$3
> +
> +	MKFS_OPTIONS="-O bigalloc -b $bs -C $cs"
> +	_scratch_mkfs_ext4  >> $seqres.full 2>&1 || continue
> +	if _try_scratch_mount >> $seqres.full 2>&1; then
> +		echo "== Testing: bs=$bs cs=$cs iosize=$iosize ==" >> $seqres.full
> +
> +		touch $SCRATCH_MNT/f1
> +		create_fio_configs $iosize
> +
> +		cat $fio_aw_config >> $seqres.full
> +		echo >> $seqres.full
> +		cat $fio_verify_config >> $seqres.full
> +
> +		$FIO_PROG $fio_aw_config >> $seqres.full
> +		ret1=$?
> +
> +		$FIO_PROG $fio_verify_config >> $seqres.full
> +		ret2=$?
> +
> +		_scratch_unmount
> +
> +		[[ $ret1 -eq 0 && $ret2 -eq 0 ]] || _fail "fio with atomic write failed"
> +	fi
> +}
> +
> +run_test() {
> +	local bs=$1
> +
> +	# cluster sizes above 16 x blocksize are experimental so avoid them
> +	# Also, cap cluster size at 128kb to keep it reasonable for large
> +	# blocks size
> +	max_cs=$(_min $((16 * bs)) "$bdev_awu_max" $((128 * 1024)))
> +
> +	# Fuzz for combinations of blocksize, clustersize and
> +	# iosize that cover most of the cases
> +	run_test_one $bs $bs $bs
> +	run_test_one $bs $max_cs $bs
> +	run_test_one $bs $max_cs $max_cs
> +	run_test_one $bs $max_cs $(_max "$((max_cs/2))" $bs)
> +}
> +
> +# Let's create a sample fio config to check whether fio supports all options.
> +fio_aw_config=$tmp.aw.fio
> +fio_verify_config=$tmp.verify.fio
> +fio_out=$tmp.fio.out
> +
> +create_fio_configs $bs
> +_require_fio $fio_aw_config
> +
> +for ((bs=$bs; bs <= $(_get_page_size); bs = $bs << 1)); do
> +	run_test $bs
> +done
> +
> +# success, all done
> +echo Silence is golden
> +status=0
> +exit
> diff --git a/tests/ext4/061.out b/tests/ext4/061.out
> new file mode 100644
> index 00000000..273be9e0
> --- /dev/null
> +++ b/tests/ext4/061.out
> @@ -0,0 +1,2 @@
> +QA output created by 061
> +Silence is golden
> -- 
> 2.49.0
> 
> 

