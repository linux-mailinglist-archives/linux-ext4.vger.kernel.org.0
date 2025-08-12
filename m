Return-Path: <linux-ext4+bounces-9342-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A13EBB22ED3
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Aug 2025 19:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49E9D56036E
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Aug 2025 17:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938E42FD1C7;
	Tue, 12 Aug 2025 17:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NFSSNAbv"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9A0305E31;
	Tue, 12 Aug 2025 17:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755019016; cv=none; b=RJUtXw3NwcmluDtNZ9qc2UMJjb2sfoIUCYkTM8iKMEx33V7XH0Nmrh0VqE2aEpNfukKkojmaBaoJQ4Bd44qks+mO2IaC34t3064LMJoNqzzTRB8zKUFCVfK56e/wCfACEi4h8hbtW2ntCeM4VncYrErcFKGMdLhXhcColMTL/WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755019016; c=relaxed/simple;
	bh=634pBqw0mHuPhjmf+NA8hzzSYWmkdmu/kMfY+dOF4GM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5ZLA3ha42Eucn2k+TUJplMNdNn9vl3BQQkMt6vo+3EVMDV9XKddq/1tXXtoR2bVWG5kryhoa3OBXYqlZSku0gnIKzzeJqnS+L0BpFxIdlah3NqGxSbx+ATOVgkrHP53zFIxwADmNb0wSrUBJ5r63dcim+o5Rqwf5osLyaCK0zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NFSSNAbv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A03EBC4CEF0;
	Tue, 12 Aug 2025 17:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755019015;
	bh=634pBqw0mHuPhjmf+NA8hzzSYWmkdmu/kMfY+dOF4GM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NFSSNAbvArjtwnnogPcGQr3210SIqurRZBEhsiZKQWPj5Q5kAvyifV1dT7ACyVY2I
	 VB9jpux2qRX93rpvGFyU5iDWj3uTJZIMnBgXRbDkTNLXT5HBpZieAkkLyxosupCA0i
	 8l3G3l9lWb4DVtjOTLNlsl05gI0z+EC215tZY9EbKUFy1wQulBX8MoQsgFdjfAEfO+
	 SEf9POHA831lI5Q2vGQdaOTgpNdugRLJEJF/QB/mlmh7n0OwiAxvuDPyfibdO37/S/
	 W9mbF839LJCp7kG7qhk2OZ3cy2WB72oJ6R3N7uJpKzse1I2WEEO3WTmT84333MFEwX
	 +UgPQHvRbtf2w==
Date: Tue, 12 Aug 2025 10:16:55 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
	Ritesh Harjani <ritesh.list@gmail.com>, john.g.garry@oracle.com,
	tytso@mit.edu, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v4 05/11] generic: Add atomic write test using fio verify
 on file mixed mappings
Message-ID: <20250812171655.GB7938@frogsfrogsfrogs>
References: <cover.1754833177.git.ojaswin@linux.ibm.com>
 <508d55ad8e3b8efde87ffbe3354e9e1d9ee8c908.1754833177.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <508d55ad8e3b8efde87ffbe3354e9e1d9ee8c908.1754833177.git.ojaswin@linux.ibm.com>

On Sun, Aug 10, 2025 at 07:11:56PM +0530, Ojaswin Mujoo wrote:
> This tests uses fio to first create a file with mixed mappings. Then it
> does atomic writes using aio dio with parallel jobs to the same file with
> mixed mappings. This forces the filesystem allocator to allocate extents
> over mixed mapping regions to stress FS block allocators.
> 
> Avoid doing overlapping parallel atomic writes because it might give
> unexpected results. Use offset_increment=, size= fio options to achieve
> this behavior.
> 
> Co-developed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Looks ok still...
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  tests/generic/1227     | 131 +++++++++++++++++++++++++++++++++++++++++
>  tests/generic/1227.out |   2 +
>  2 files changed, 133 insertions(+)
>  create mode 100755 tests/generic/1227
>  create mode 100644 tests/generic/1227.out
> 
> diff --git a/tests/generic/1227 b/tests/generic/1227
> new file mode 100755
> index 00000000..7423e67c
> --- /dev/null
> +++ b/tests/generic/1227
> @@ -0,0 +1,131 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
> +#
> +# FS QA Test 1227
> +#
> +# Validate FS atomic write using fio crc check verifier on mixed mappings
> +# of a file.
> +#
> +. ./common/preamble
> +. ./common/atomicwrites
> +
> +_begin_fstest auto aio rw atomicwrites
> +
> +_require_scratch_write_atomic_multi_fsblock
> +_require_odirect
> +_require_aio
> +_require_xfs_io_command "truncate"
> +
> +_scratch_mkfs >> $seqres.full 2>&1
> +_scratch_mount
> +
> +touch "$SCRATCH_MNT/f1"
> +awu_min_write=$(_get_atomic_write_unit_min "$SCRATCH_MNT/f1")
> +awu_max_write=$(_get_atomic_write_unit_max "$SCRATCH_MNT/f1")
> +
> +aw_bsize=$(_max "$awu_min_write" "$((awu_max_write/4))")
> +fsbsize=$(_get_block_size $SCRATCH_MNT)
> +
> +threads=$(_min "$(($(nproc) * 2 * LOAD_FACTOR))" "100")
> +filesize=$((aw_bsize * threads * 100))
> +depth=$threads
> +aw_io_size=$((filesize / threads))
> +aw_io_inc=$aw_io_size
> +testfile=$SCRATCH_MNT/test-file
> +
> +fio_prep_config=$tmp.prep.fio
> +fio_aw_config=$tmp.aw.fio
> +fio_verify_config=$tmp.verify.fio
> +fio_out=$tmp.fio.out
> +
> +cat >$fio_prep_config <<EOF
> +# prep file to have mixed mappings
> +[global]
> +ioengine=libaio
> +filename=$testfile
> +size=$filesize
> +bs=$fsbsize
> +direct=1
> +iodepth=$depth
> +group_reporting=1
> +
> +# Create written extents
> +[prep_written_blocks]
> +ioengine=libaio
> +rw=randwrite
> +io_size=$((filesize/3))
> +random_generator=lfsr
> +
> +# Create unwritten extents
> +[prep_unwritten_blocks]
> +ioengine=falloc
> +rw=randwrite
> +io_size=$((filesize/3))
> +random_generator=lfsr
> +EOF
> +
> +cat >$fio_aw_config <<EOF
> +# atomic write to mixed mappings of written/unwritten/holes
> +[atomic_write_job]
> +ioengine=libaio
> +rw=randwrite
> +direct=1
> +atomic=1
> +random_generator=lfsr
> +group_reporting=1
> +
> +filename=$testfile
> +bs=$aw_bsize
> +size=$aw_io_size
> +offset_increment=$aw_io_inc
> +iodepth=$depth
> +numjobs=$threads
> +
> +verify_state_save=0
> +verify=crc32c
> +do_verify=0
> +EOF
> +
> +cat >$fio_verify_config <<EOF
> +# verify atomic writes done by previous job
> +[verify_job]
> +ioengine=libaio
> +rw=read
> +random_generator=lfsr
> +group_reporting=1
> +
> +filename=$testfile
> +size=$filesize
> +bs=$aw_bsize
> +iodepth=$depth
> +
> +verify_state_save=0
> +verify_only=1
> +verify=crc32c
> +verify_fatal=1
> +verify_write_sequence=0
> +EOF
> +
> +_require_fio $fio_aw_config
> +_require_fio $fio_verify_config
> +
> +cat $fio_prep_config >> $seqres.full
> +cat $fio_aw_config >> $seqres.full
> +cat $fio_verify_config >> $seqres.full
> +
> +$XFS_IO_PROG -fc "truncate $filesize" $testfile >> $seqres.full
> +
> +#prepare file with mixed mappings
> +$FIO_PROG $fio_prep_config >> $seqres.full
> +
> +# do atomic writes without verifying
> +$FIO_PROG $fio_aw_config >> $seqres.full
> +
> +# verify data is not torn
> +$FIO_PROG $fio_verify_config >> $seqres.full
> +
> +# success, all done
> +echo Silence is golden
> +status=0
> +exit
> diff --git a/tests/generic/1227.out b/tests/generic/1227.out
> new file mode 100644
> index 00000000..2605d062
> --- /dev/null
> +++ b/tests/generic/1227.out
> @@ -0,0 +1,2 @@
> +QA output created by 1227
> +Silence is golden
> -- 
> 2.49.0
> 
> 

