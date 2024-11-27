Return-Path: <linux-ext4+bounces-5420-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BED79DA023
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Nov 2024 01:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D08A168DB5
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Nov 2024 00:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735978836;
	Wed, 27 Nov 2024 00:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRJH6dhu"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE7A881E;
	Wed, 27 Nov 2024 00:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732668952; cv=none; b=ay+wFJGYOkJsiCyvHJ+PM1PJ6d2XvhzMuLScDBsYh1PjU7sMtjXmFDfZJA6MqGnrFFZUY6yxBzczjCkdmx+g1Kh5IJQK+cCaCPFfBdwIf9nvi6Jvs6kJs8mZa3RN5mwRj1/7Su764DPwSX15vyRXm7jys2l2+F3JsNdFi04t+Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732668952; c=relaxed/simple;
	bh=LaCxv7itauXwK4aIxCAOrV0rHrua6ZtwOoobuvlbAUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X36KZY9V+3lk2I65l3kYmf8qwAy/XSvwIcoWKkxO8YzDdxHbkvMN4BDIPyOBCy7eDbxymPVHSB3nFqpsqn1QxVq29Z+6qpTP8pk3o4JhHf8/OlCZL/6lULlRcceqXrbONLtdRsI7OMTJQioD/smwvRaqwfcBE70ftc9OOSoqYCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aRJH6dhu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED74C4CED0;
	Wed, 27 Nov 2024 00:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732668951;
	bh=LaCxv7itauXwK4aIxCAOrV0rHrua6ZtwOoobuvlbAUE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aRJH6dhuh2kFAVu3Xk7R4Ln0f4DjcEjpGFIZVtRJHuuCMXy9tRNb1jq4G6AKq+xIs
	 KhPGcKM46jpyI4WHYk5Wt6L7MHkabz2rmXPlz7eJKM1fkf8xPkE/hPSPGPKYGWGaxv
	 tWOsPxIxF7+88lHNIg5XZqpAmdmQWZpNq/0SdoOIwDzyjRjCN6dntzkgVB56wfnEfx
	 2SNmYDESwAQUccKnujwecnSf+XfczU3LbGyNS3x2y0h5zcl5xkVPx0JaQloCNwG7wh
	 XmaFRCxj6bxK2IFxObn0G+9TeDNxkbSuaVayp+BaeWBOoIEiHrxPg0cvuPYbeALyW4
	 9rDkjvAyN/OdQ==
Date: Tue, 26 Nov 2024 16:55:51 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Nirjhar Roy <nirjhar@linux.ibm.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
	ojaswin@linux.ibm.com, zlang@kernel.org
Subject: Re: [PATCH v4 3/3] generic: Addition of new tests for extsize hints
Message-ID: <20241127005551.GT9438@frogsfrogsfrogs>
References: <cover.1732599868.git.nirjhar@linux.ibm.com>
 <4b3bc104222cba372115d6e249da555f7fbe528b.1732599868.git.nirjhar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b3bc104222cba372115d6e249da555f7fbe528b.1732599868.git.nirjhar@linux.ibm.com>

On Tue, Nov 26, 2024 at 11:24:08AM +0530, Nirjhar Roy wrote:
> This commit adds new tests that checks the behaviour of xfs/ext4
> filesystems when extsize hint is set on file with inode size as 0,
> non-empty files with allocated and delalloc extents and so on.
> Although currently this test is placed under tests/generic, it
> only runs on xfs and there is an ongoing patch series[1] to
> enable extsize hints for ext4 as well.
> 
> [1] https://lore.kernel.org/linux-ext4/cover.1726034272.git.ojaswin@linux.ibm.com/
> 
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> Reviewed-by Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Suggested-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Signed-off-by: Nirjhar Roy <nirjhar@linux.ibm.com>
> ---
>  tests/generic/367     | 175 ++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/367.out |  26 +++++++
>  2 files changed, 201 insertions(+)
>  create mode 100755 tests/generic/367
>  create mode 100644 tests/generic/367.out
> 
> diff --git a/tests/generic/367 b/tests/generic/367
> new file mode 100755
> index 00000000..25d23f42
> --- /dev/null
> +++ b/tests/generic/367
> @@ -0,0 +1,175 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Nirjhar Roy (nirjhar@linux.ibm.com).  All Rights Reserved.
> +#
> +# FS QA Test 366

s/366/367/

./tools/mvtest is your friend.

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

The commit id should be the second parameter and the subject line the
third parameter.

_fixed_by_kernel_commit 2a492ff66673 \
	"xfs: Check for delayed allocations before setting extsize"

With those fixed,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

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
> diff --git a/tests/generic/367.out b/tests/generic/367.out
> new file mode 100644
> index 00000000..f94e8545
> --- /dev/null
> +++ b/tests/generic/367.out
> @@ -0,0 +1,26 @@
> +QA output created by 367
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

