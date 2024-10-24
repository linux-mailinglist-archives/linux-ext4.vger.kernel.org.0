Return-Path: <linux-ext4+bounces-4731-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B269AEF79
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Oct 2024 20:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A1BD1F224D3
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Oct 2024 18:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05CC1FF608;
	Thu, 24 Oct 2024 18:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mv5r/t1K"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B97B1AF0D3;
	Thu, 24 Oct 2024 18:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729793685; cv=none; b=u5Yxpn+w0mtorEZGyTQvzzlM7R3ZPGy3MxT6vIv2IQW+oFl3bkqvtvILR2EFN/8Hlt3onCvgwO6ZDKZAncDPk366zlh4Iyz907KpqhnpS9pvkijzlvqtftu+GLWbhKq52dpZ1POdJsnY8JQgbC0z6zTwgwfZ4XnMuQFRD2u0yv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729793685; c=relaxed/simple;
	bh=l2ebjqlL1izAgzxeZmbTDuy7WZ4hyodYRV9PyRTs3RU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PV8vzuZdWGdJaAE+3Pyh8tr+gc7YHWQ0LpxnspRA4HwN17Q7TsttYy4LeWZtVz//dr1IXJFDcaHoquIPf022iDld0ZAdOeulHrKHxWrhNw+7wjf9M3lWrJE57GY/NdGnfj+HJFWloNxoMXXkyILkzIRvgu7xf2DYtRXtRaaHzWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mv5r/t1K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9202C4CEC7;
	Thu, 24 Oct 2024 18:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729793684;
	bh=l2ebjqlL1izAgzxeZmbTDuy7WZ4hyodYRV9PyRTs3RU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mv5r/t1KYndSfRch6cL6chN4hEyyL3hzpwkz2bcA9l16Jz8UoSEDXzsZ4INrFevtO
	 lH0C7nZsbilbb4r9kqiGKtAsbQ7iI6cv8CSLIidskZzSQCbICQEbY3+AiLK0PFfrKe
	 oPSHs/SthU7sxhQhm6NDrmACWmsnefScJKvidMkkkXIwl99Q6EnKry6ShPxvl0DgDj
	 ax9aRrbAA/YvrC4lSFu47gd+p4vbjBx4FqRRdYkDOYhf02X1ISK+gT8WX8QCtXPxP/
	 Pr8N9Xb3k3zOdUf/8AXikjOlJxedcTke/chSihalXC1kN3ckxS7SgY+F/y/OTg07jf
	 VTiQgxpgel/0Q==
Date: Thu, 24 Oct 2024 11:14:44 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Nirjhar Roy <nirjhar@linux.ibm.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
	ojaswin@linux.ibm.com, zlang@kernel.org
Subject: Re: [PATCH 2/2] generic: Addition of new tests for extsize hints
Message-ID: <20241024181444.GE2386201@frogsfrogsfrogs>
References: <cover.1729624806.git.nirjhar@linux.ibm.com>
 <5cac327a9ee44c42035d9702b3a146aebc95e28c.1729624806.git.nirjhar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cac327a9ee44c42035d9702b3a146aebc95e28c.1729624806.git.nirjhar@linux.ibm.com>

On Wed, Oct 23, 2024 at 12:56:20AM +0530, Nirjhar Roy wrote:
> This commit adds new tests that checks the behaviour of xfs/ext4
> filesystems when extsize hint is set on file with inode size as 0, non-empty
> files with allocated and delalloc extents and so on.
> Although currently this test is placed under tests/generic, it
> only runs on xfs and there is an ongoing patch series[1] to enable
> extsize hints for ext4 as well.
> 
> [1] https://lore.kernel.org/linux-ext4/cover.1726034272.git.ojaswin@linux.ibm.com/
> 
> Suggested-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Signed-off-by: Nirjhar Roy <nirjhar@linux.ibm.com>
> ---
>  tests/generic/365     | 156 ++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/365.out |  26 +++++++
>  2 files changed, 182 insertions(+)
>  create mode 100755 tests/generic/365
>  create mode 100644 tests/generic/365.out
> 
> diff --git a/tests/generic/365 b/tests/generic/365
> new file mode 100755
> index 00000000..85a7ce9a
> --- /dev/null
> +++ b/tests/generic/365
> @@ -0,0 +1,156 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Nirjhar Roy (nirjhar@linux.ibm.com).  All Rights Reserved.
> +#
> +# FS QA Test 365
> +#
> +# This test verifies that extent allocation hint setting works correctly on files with
> +# no extents allocated and non-empty files which are truncated. It also checks that the
> +# extent hints setting fails with non-empty file i.e, with any file with allocated
> +# extents or delayed allocation. We also check if the extsize value and the
> +# xflag bit actually got reflected after setting/re-setting the extsize value.
> +
> +. ./common/config
> +. ./common/filter
> +. ./common/preamble
> +. ./common/xfs
> +
> +_begin_fstest ioctl quick
> +
> +_supported_fs xfs
> +
> +_fixed_by_kernel_commit XXXXXXXXXXXX \
> +    "xfs: Check for delayed allocations before setting extsize",
> +
> +_require_scratch
> +
> +FILE_DATA_SIZE=1M

Do these tests work correctly with fsblock size of 64k?  Just curious
since Pankaj just sent a series doing 1M -> 4M bumps to fix quota
issues.

> +filter_extsz()
> +{
> +    sed "s/$EXTSIZE/EXTSIZE/g"
> +}
> +
> +setup()
> +{
> +    _scratch_mkfs >> "$seqres.full"  2>&1
> +    _scratch_mount >> "$seqres.full" 2>&1
> +    BLKSZ=`_get_block_size $SCRATCH_MNT`
> +    EXTSIZE=$(( BLKSZ*2 ))

Might want to check that there isn't an extsize/cowextsize set on the
root directory due to mkfs options.

> +}
> +
> +read_file_extsize()
> +{
> +    $XFS_IO_PROG -c "extsize" $1 | _filter_scratch | filter_extsz
> +}
> +
> +check_extsz_and_xflag()
> +{
> +    local filename=$1
> +    read_file_extsize $filename
> +    _test_xfs_xflags_field $filename "e" && echo "e flag set" || echo "e flag unset"
> +}
> +
> +check_extsz_xflag_across_remount()
> +{
> +    local filename=$1
> +    _scratch_cycle_mount
> +    check_extsz_and_xflag $filename
> +}
> +
> +# Extsize flag should be cleared when extsize is reset, so this function
> +# checks that this behavior is followed.
> +reset_extsz_and_recheck_extsz_xflag()
> +{
> +    local filename=$1
> +    echo "Re-setting extsize hint to 0"
> +    $XFS_IO_PROG -c "extsize 0" $filename
> +    check_extsz_xflag_across_remount $filename
> +}
> +
> +check_extsz_xflag_before_and_after_reset()
> +{
> +    local filename=$1
> +    check_extsz_xflag_across_remount $filename
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
> +    check_extsz_xflag_before_and_after_reset $filename
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
> +    check_extsz_xflag_across_remount $filename
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
> +    check_extsz_xflag_across_remount $filename
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
> +    check_extsz_xflag_across_remount $filename
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
> +    check_extsz_xflag_across_remount $filename
> +    echo
> +}

Does this work for filesystems that don't have delalloc?  Like fsdax
filesystems?

--D

> +setup
> +echo -e "EXTSIZE = $EXTSIZE BLOCKSIZE = $BLKSZ\n" >> "$seqres.full"
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
> diff --git a/tests/generic/365.out b/tests/generic/365.out
> new file mode 100644
> index 00000000..38cd0885
> --- /dev/null
> +++ b/tests/generic/365.out
> @@ -0,0 +1,26 @@
> +QA output created by 365
> +TEST: Set extsize on empty file
> +[EXTSIZE] SCRATCH_MNT/new-file-00
> +e flag set
> +Re-setting extsize hint to 0
> +[0] SCRATCH_MNT/new-file-00
> +e flag unset
> +
> +TEST: Set extsize on non-empty file with delayed allocation
> +xfs_io: FS_IOC_FSSETXATTR SCRATCH_MNT/new-file-01: Invalid argument
> +[0] SCRATCH_MNT/new-file-01
> +e flag unset
> +
> +TEST: Set extsize on non-empty file with allocated extents
> +xfs_io: FS_IOC_FSSETXATTR SCRATCH_MNT/new-file-02: Invalid argument
> +[0] SCRATCH_MNT/new-file-02
> +e flag unset
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

