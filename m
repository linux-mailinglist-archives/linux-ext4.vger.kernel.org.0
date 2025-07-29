Return-Path: <linux-ext4+bounces-9221-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90673B153DE
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Jul 2025 21:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DBA318953B4
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Jul 2025 19:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CD923F42A;
	Tue, 29 Jul 2025 19:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMNtaczP"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678084501A;
	Tue, 29 Jul 2025 19:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753818429; cv=none; b=OT4yZQGjfUdPZEpKQUbotDjVBAYZIq6FSsATR1aDnsA64xnD2MZZsViqK0MXS5shfEUjhb+dvwOUsI9bp1i33stqsetxzBBzQm0fHRptvo8NLOIqEgB9IRD5zMQ5YidHequiVXPVzqXLpIqCJ6hQoRmVw6iV636O8hrFuoMg8Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753818429; c=relaxed/simple;
	bh=7g+vHY2HvBya9KJddCkKHnXJQbLMcLxb6XOLx4HCaFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=szrD3NUv9xqaVkyrKKBfqTgctVGwyWTDo77QFbwZhsWMn0fuoRi5W78/Fjq2q5bz+y40Yl3UMoMyXOaUkp7OjUe3qZoOSkiNQf1RVfr95gKfuouv82hI3WfAYC7eUVoB/Obc/YbW2o+Z98nfXuTG8ow3YF16JTY/56/Xbln7UeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMNtaczP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CB1AC4CEF6;
	Tue, 29 Jul 2025 19:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753818429;
	bh=7g+vHY2HvBya9KJddCkKHnXJQbLMcLxb6XOLx4HCaFo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cMNtaczPIT6PYSBtvnrXHAjxBMHndrLNjIr3T6dmx+dbDbVJ1O/c/2PyyOg1PsDNG
	 3xNsuX2SfdO3tSupMXYpMWU8VPQjS4jRWUhU76CxsAqX8wJ4m1QSfFbyLYvlkBKxBU
	 KDhWA7iD2oNIYhii7I/mnJg70F8I6GmjBGh4Sp9fSs7KlYgGFi61vmfTIE4Xv57g/Q
	 TFvL2OqEPFxNsVCM7bZreyE9JpjRfA8vo/W7xRxUyTYkS6Hkyd+nS9ubQYHpTgqUnp
	 5Jv3dH4ur5VjzYHEVxNhn+fuwnA+tA1kHtQZMKtwuivRGKFDv0B2bIXe0ZA/l542rn
	 OA0oc85mh9GPQ==
Date: Tue, 29 Jul 2025 12:47:08 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
	Ritesh Harjani <ritesh.list@gmail.com>, john.g.garry@oracle.com,
	tytso@mit.edu, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 10/13] ext4/061: Atomic writes stress test for
 bigalloc using fio crc verifier
Message-ID: <20250729194708.GV2672039@frogsfrogsfrogs>
References: <cover.1752329098.git.ojaswin@linux.ibm.com>
 <9b59eb50b171dece1a15bc7c1b6cadff438586d6.1752329098.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b59eb50b171dece1a15bc7c1b6cadff438586d6.1752329098.git.ojaswin@linux.ibm.com>

On Sat, Jul 12, 2025 at 07:42:52PM +0530, Ojaswin Mujoo wrote:
> From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
> 
> We brute force all possible blocksize & clustersize combinations on
> a bigalloc filesystem for stressing atomic write using fio data crc
> verifier. We run nproc * $LOAD_FACTOR threads in parallel writing to
> a single $SCRATCH_MNT/test-file. With atomic writes this test ensures
> that we never see the mix of data contents from different threads on
> a given bsrange.

Err, how does this differ from the next patch?  It looks like this one
creates one IO thread, whereas the next one creates 8?  If so, what does
this test add over ext4/062?

(and now that I look at it, ext4/062 says "FS QA Test 061"...)

--D

> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>  tests/ext4/061     | 130 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/ext4/061.out |   2 +
>  2 files changed, 132 insertions(+)
>  create mode 100755 tests/ext4/061
>  create mode 100644 tests/ext4/061.out
> 
> diff --git a/tests/ext4/061 b/tests/ext4/061
> new file mode 100755
> index 00000000..a0e49249
> --- /dev/null
> +++ b/tests/ext4/061
> @@ -0,0 +1,130 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
> +#
> +# FS QA Test 061
> +#
> +# Brute force all possible blocksize clustersize combination on a bigalloc
> +# filesystem for stressing atomic write using fio data crc verifier. We run
> +# nproc * 2 * $LOAD_FACTOR threads in parallel writing to a single
> +# $SCRATCH_MNT/test-file. With fio aio-dio atomic write this test ensures that
> +# we should never see the mix of data contents from different threads for any
> +# given fio blocksize.
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
> +FIO_LOAD=$(($(nproc) * 2 * LOAD_FACTOR))
> +SIZE=$((100*1024*1024))
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
> +	[aio-dio-aw-verify]
> +	direct=1
> +	ioengine=libaio
> +	rw=randwrite
> +	bs=$fiobsize
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
> +cat >$fio_aw_config <<EOF
> +	[aio-dio-aw]
> +	direct=1
> +	ioengine=libaio
> +	rw=randwrite
> +	bs=$fiobsize
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
> +	# blocks size
> +	fs_max_clustersize=$(_min $((16 * fsblocksize)) "$bdev_awu_max" $((128 * 1024)))
> +
> +	for ((fsclustersize=$fsblocksize; fsclustersize <= $fs_max_clustersize; fsclustersize = $fsclustersize << 1)); do
> +		for ((fiobsize = $fsblocksize; fiobsize <= $fsclustersize; fiobsize = $fiobsize << 1)); do
> +			MKFS_OPTIONS="-O bigalloc -b $fsblocksize -C $fsclustersize"
> +			_scratch_mkfs_ext4  >> $seqres.full 2>&1 || continue
> +			if _try_scratch_mount >> $seqres.full 2>&1; then
> +				echo "== FIO test for fsblocksize=$fsblocksize fsclustersize=$fsclustersize fiobsize=$fiobsize ==" >> $seqres.full
> +
> +				touch $SCRATCH_MNT/f1
> +				create_fio_configs
> +
> +				cat $fio_aw_config >> $seqres.full
> +				echo >> $seqres.full
> +				cat $fio_verify_config >> $seqres.full
> +
> +				$FIO_PROG $fio_aw_config >> $seqres.full
> +				ret1=$?
> +
> +				$FIO_PROG $fio_verify_config >> $seqres.full
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

