Return-Path: <linux-ext4+bounces-5337-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDDC9D51B4
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Nov 2024 18:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 332CDB258DD
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Nov 2024 17:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BB11A2C04;
	Thu, 21 Nov 2024 17:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NV40nLru"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFCC10A3E;
	Thu, 21 Nov 2024 17:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732210023; cv=none; b=D4RCaj5RrSen93qmzZ1MZfu5ggdjnBx/pzVw8/hh4WMUd4pNLxohBY4kKvL7g6ZKGMspIzbRWpLYNkKJ18nAWqhgAgUhkfjQcWDTzHG+rWWlt2nSOOOBawGbZR8UirGpUORplF0946EdjO0ML4Q8GyZ+xgcOQQWv8UPCflboff4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732210023; c=relaxed/simple;
	bh=4KKYbRVkuRIRrFgxCAVy6E5O5hvfEATgy0+hSoKcN/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iWvVPDcC+FlZKANXHykN5maSH+TTawYHlkE4KxvnmgL+5zm6W7emBF82E0xxsoqaRdYLjr9yGoEwDLHf4oUIHTBlPT0xfE1bJLdZvSl2p4eRyajJecezVXTM10bNPOAo/mxCvk1vvP3gSPC3AOUSmrz4hWYR+J9kgg5K6YvjeL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NV40nLru; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B810C4CECC;
	Thu, 21 Nov 2024 17:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732210023;
	bh=4KKYbRVkuRIRrFgxCAVy6E5O5hvfEATgy0+hSoKcN/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NV40nLru/17DcbS2ITkWDSzwhCSFN8PflgWekVh3vSobxGkymdeWlLdJTM4SEczpu
	 E/3hen2uZGSj91mP2LwSWRyIn4eEiUn41ewEk4eFBDwR81jw68pzICDHqMxV2XQ7LI
	 qyz6KFi2GklE0awt0zC6xm3baWtEv2YIsf8EKdg/SzrJN+SJkHRrGGUzTy3Dtb5n3z
	 cl4INpf9R3NiO7vkfhfb2/r4g4hUqkviWZ7tDup8zCllz8GpVZq1euyZAwr1Ev3FyT
	 51Hw+mDYSj0MJ5BlWTR3dZkZLVhNh44gms+IOchRaEmRigi1avsMWoFmawLSO2V5ED
	 I9jRkv6cLX+kQ==
Date: Thu, 21 Nov 2024 09:27:02 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Nirjhar Roy <nirjhar@linux.ibm.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
	ojaswin@linux.ibm.com, zlang@kernel.org
Subject: Re: [PATCH v3 3/3] generic: Addition of new tests for extsize hints
Message-ID: <20241121172702.GY9425@frogsfrogsfrogs>
References: <cover.1732126365.git.nirjhar@linux.ibm.com>
 <efd35dc3af1cae406d4ea7644eb9d58b68feb405.1732126365.git.nirjhar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efd35dc3af1cae406d4ea7644eb9d58b68feb405.1732126365.git.nirjhar@linux.ibm.com>

On Thu, Nov 21, 2024 at 10:39:12AM +0530, Nirjhar Roy wrote:
> This commit adds new tests that checks the behaviour of xfs/ext4
> filesystems when extsize hint is set on file with inode size as 0,
> non-empty files with allocated and delalloc extents and so on.
> Although currently this test is placed under tests/generic, it
> only runs on xfs and there is an ongoing patch series[1] to
> enable extsize hints for ext4 as well.
> 
> [1] https://lore.kernel.org/linux-ext4/cover.1726034272.git.ojaswin@linux.ibm.com/
> 
> Reviewed-by Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Suggested-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Signed-off-by: Nirjhar Roy <nirjhar@linux.ibm.com>

Looks ok, though you might want to change generic/366 to a higher number
because that's now taken.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  tests/generic/366     | 175 ++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/366.out |  26 +++++++
>  2 files changed, 201 insertions(+)
>  create mode 100755 tests/generic/366
>  create mode 100644 tests/generic/366.out
> 
> diff --git a/tests/generic/366 b/tests/generic/366
> new file mode 100755
> index 00000000..25d23f42
> --- /dev/null
> +++ b/tests/generic/366
> @@ -0,0 +1,175 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Nirjhar Roy (nirjhar@linux.ibm.com).  All Rights Reserved.
> +#
> +# FS QA Test 366
> +#
> +# This test verifies that extent allocation hint setting works correctly on
> +# files with no extents allocated and non-empty files which are truncated.
> +# It also checks that the  extent hints setting fails with non-empty file
> +# i.e, with any file with allocated extents or delayed allocation. We also
> +# check if the extsize value and the xflag bit actually got reflected after
> +# setting/re-setting the extsize value.
> +
> +. ./common/config
> +. ./common/filter
> +. ./common/preamble
> +
> +_begin_fstest ioctl quick
> +
> +_fixed_by_kernel_commit "2a492ff66673 \
> +                        xfs: Check for delayed allocations before setting \
> +			extsize"
> +
> +_require_scratch_extsize
> +
> +FILE_DATA_SIZE=1M
> +
> +get_default_extsize()
> +{
> +    if [ -z $1 ] || [ ! -d $1 ]; then
> +        echo "Missing mount point argument for get_default_extsize"
> +        exit 1
> +    fi
> +    $XFS_IO_PROG -c "extsize" "$1" | sed 's/^\[\([0-9]\+\)\].*/\1/'
> +}
> +
> +filter_extsz()
> +{
> +    sed "s/\[$1\]/\[EXTSIZE\]/g"
> +}
> +
> +setup()
> +{
> +    _scratch_mkfs >> "$seqres.full"  2>&1
> +    _scratch_mount >> "$seqres.full" 2>&1
> +    BLKSZ=`_get_block_size $SCRATCH_MNT`
> +    DEFAULT_EXTSIZE=`get_default_extsize $SCRATCH_MNT`
> +    EXTSIZE=$(( BLKSZ*2 ))
> +    # Make sure the new extsize is not the same as the default
> +    # extsize so that we can observe it changing
> +    [[ "$DEFAULT_EXTSIZE" -eq "$EXTSIZE" ]] && EXTSIZE=$(( BLKSZ*4 ))
> +}
> +
> +read_file_extsize()
> +{
> +    $XFS_IO_PROG -c "extsize" $1 | _filter_scratch | filter_extsz $2
> +}
> +
> +check_extsz_and_xflag()
> +{
> +    local filename=$1
> +    local extsize=$2
> +    read_file_extsize $filename $extsize
> +    _test_fsxattr_xflag $filename "extsize" && echo "e flag set" || \
> +	    echo "e flag unset"
> +}
> +
> +check_extsz_xflag_across_remount()
> +{
> +    local filename=$1
> +    local extsize=$2
> +    _scratch_cycle_mount
> +    check_extsz_and_xflag $filename $extsize
> +}
> +
> +# Extsize flag should be cleared when extsize is reset, so this function
> +# checks that this behavior is followed.
> +reset_extsz_and_recheck_extsz_xflag()
> +{
> +    local filename=$1
> +    echo "Re-setting extsize hint to 0"
> +    $XFS_IO_PROG -c "extsize 0" $filename
> +    check_extsz_xflag_across_remount $filename "0"
> +}
> +
> +check_extsz_xflag_before_and_after_reset()
> +{
> +    local filename=$1
> +    local extsize=$2
> +    check_extsz_xflag_across_remount $filename $extsize
> +    reset_extsz_and_recheck_extsz_xflag $filename
> +}
> +
> +test_empty_file()
> +{
> +    echo "TEST: Set extsize on empty file"
> +    local filename=$1
> +    $XFS_IO_PROG \
> +        -c "open -f $filename" \
> +        -c "extsize $EXTSIZE" \
> +
> +    check_extsz_xflag_before_and_after_reset $filename $EXTSIZE
> +    echo
> +}
> +
> +test_data_delayed()
> +{
> +    echo "TEST: Set extsize on non-empty file with delayed allocation"
> +    local filename=$1
> +    $XFS_IO_PROG \
> +        -c "open -f $filename" \
> +        -c "pwrite -q  0 $FILE_DATA_SIZE" \
> +        -c "extsize $EXTSIZE" | _filter_scratch
> +
> +    echo "test for default extsize setting if any"
> +    read_file_extsize $filename $DEFAULT_EXTSIZE
> +    echo
> +}
> +
> +test_data_allocated()
> +{
> +    echo "TEST: Set extsize on non-empty file with allocated extents"
> +    local filename=$1
> +    $XFS_IO_PROG \
> +        -c "open -f $filename" \
> +        -c "pwrite -qW  0 $FILE_DATA_SIZE" \
> +        -c "extsize $EXTSIZE" | _filter_scratch
> +
> +    echo "test for default extsize setting if any"
> +    read_file_extsize $filename $DEFAULT_EXTSIZE
> +    echo
> +}
> +
> +test_truncate_allocated()
> +{
> +    echo "TEST: Set extsize after truncating a file with allocated extents"
> +    local filename=$1
> +    $XFS_IO_PROG \
> +        -c "open -f $filename" \
> +        -c "pwrite -qW  0 $FILE_DATA_SIZE" \
> +        -c "truncate 0" \
> +        -c "extsize $EXTSIZE" \
> +
> +    check_extsz_xflag_across_remount $filename $EXTSIZE
> +    echo
> +}
> +
> +test_truncate_delayed()
> +{
> +    echo "TEST: Set extsize after truncating a file with delayed allocation"
> +    local filename=$1
> +    $XFS_IO_PROG \
> +        -c "open -f $filename" \
> +        -c "pwrite -q  0 $FILE_DATA_SIZE" \
> +        -c "truncate 0" \
> +        -c "extsize $EXTSIZE" \
> +
> +    check_extsz_xflag_across_remount $filename $EXTSIZE
> +    echo
> +}
> +
> +setup
> +echo -e "EXTSIZE = $EXTSIZE DEFAULT_EXTSIZE = $DEFAULT_EXTSIZE \
> +	BLOCKSIZE = $BLKSZ\n" >> "$seqres.full"
> +
> +NEW_FILE_NAME_PREFIX=$SCRATCH_MNT/new-file-
> +
> +test_empty_file "$NEW_FILE_NAME_PREFIX"00
> +test_data_delayed "$NEW_FILE_NAME_PREFIX"01
> +test_data_allocated "$NEW_FILE_NAME_PREFIX"02
> +test_truncate_allocated "$NEW_FILE_NAME_PREFIX"03
> +test_truncate_delayed "$NEW_FILE_NAME_PREFIX"04
> +
> +status=0
> +exit
> diff --git a/tests/generic/366.out b/tests/generic/366.out
> new file mode 100644
> index 00000000..cdd2f5fa
> --- /dev/null
> +++ b/tests/generic/366.out
> @@ -0,0 +1,26 @@
> +QA output created by 366
> +TEST: Set extsize on empty file
> +[EXTSIZE] SCRATCH_MNT/new-file-00
> +e flag set
> +Re-setting extsize hint to 0
> +[EXTSIZE] SCRATCH_MNT/new-file-00
> +e flag unset
> +
> +TEST: Set extsize on non-empty file with delayed allocation
> +xfs_io: FS_IOC_FSSETXATTR SCRATCH_MNT/new-file-01: Invalid argument
> +test for default extsize setting if any
> +[EXTSIZE] SCRATCH_MNT/new-file-01
> +
> +TEST: Set extsize on non-empty file with allocated extents
> +xfs_io: FS_IOC_FSSETXATTR SCRATCH_MNT/new-file-02: Invalid argument
> +test for default extsize setting if any
> +[EXTSIZE] SCRATCH_MNT/new-file-02
> +
> +TEST: Set extsize after truncating a file with allocated extents
> +[EXTSIZE] SCRATCH_MNT/new-file-03
> +e flag set
> +
> +TEST: Set extsize after truncating a file with delayed allocation
> +[EXTSIZE] SCRATCH_MNT/new-file-04
> +e flag set
> +
> -- 
> 2.43.5
> 
> 

