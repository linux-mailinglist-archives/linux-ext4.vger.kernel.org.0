Return-Path: <linux-ext4+bounces-9343-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93298B22EDB
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Aug 2025 19:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA21B189F140
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Aug 2025 17:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFB42FD1CE;
	Tue, 12 Aug 2025 17:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnUeVR3d"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E682E8895;
	Tue, 12 Aug 2025 17:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755019137; cv=none; b=M9vyIZnb1+FCF3vdr592vkdw9ibv+WvU0MmFQU3f80WWHbfGzymxL9oarP90AX2KqCVKeg7I/HPQOLfHn6WTS7nsI+5dfrxDa+ztcw5l9FLfwPpWRQhgDRXY1RD7OMqtsscCzyPyt8PYOaLVA31aTmKFxl7eU3IJqtKCg/ZASdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755019137; c=relaxed/simple;
	bh=Yb0koM1v5zVJkGPV0tK0r+Qe/NOn1YeQ9N+JMgvWYkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CixyJ8U3fwqNTGQFmxYA0gt5try7q3TkSoYz6+KL9kMLVxHD3u0JN1hxfxw6cpULmnpBKeiFoFt7Tt/WM/7Td39zbIIDozUkRz8abQ1XRWnupTN+8tqvjWIIsUgiaF7FTSJfMnz3JqhiFyNkuPf6UINvxJjWQU5OTlGSgR425vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnUeVR3d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F01C4CEF0;
	Tue, 12 Aug 2025 17:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755019135;
	bh=Yb0koM1v5zVJkGPV0tK0r+Qe/NOn1YeQ9N+JMgvWYkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gnUeVR3dirkaxTzmweSmNCG3p9m0Wmr1ZqbPvU57sHJ4tWtvLf/N4XBC6vX8Ch51n
	 eJvGUcf4edJUUPWbXya33K0l7eyTqT8Lh5xDIIOjM/55K2bhCtv39qCp1+o7IiP4W+
	 Q1JKo2QAB07KIIlBRAdGrwNLytMA79TadwWI2hvXuA3MkwNL+Og93JauQbAdjqUOsN
	 5J2wlJuv1RUbLcCorAOfrVgZkFubhhBDxsql8ebuw6CVBoccNKZLbRKuwUlEWWlSTM
	 teS6nS/TwnP95jMR9Wh0o84gJvyg4frC4QHuKBSwzql6NDOr87pGzLyDKdmGThxc0Q
	 JyYop4QrsrFFw==
Date: Tue, 12 Aug 2025 10:18:55 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
	Ritesh Harjani <ritesh.list@gmail.com>, john.g.garry@oracle.com,
	tytso@mit.edu, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v4 07/11] generic: Stress fsx with atomic writes enabled
Message-ID: <20250812171855.GC7938@frogsfrogsfrogs>
References: <cover.1754833177.git.ojaswin@linux.ibm.com>
 <50487b2e8a510598a93888c2674df7357d371da8.1754833177.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50487b2e8a510598a93888c2674df7357d371da8.1754833177.git.ojaswin@linux.ibm.com>

On Sun, Aug 10, 2025 at 07:11:58PM +0530, Ojaswin Mujoo wrote:
> Stress file with atomic writes to ensure we excercise codepaths
> where we are mixing different FS operations with atomic writes
> 
> Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Didn't I already tag this
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  tests/generic/1229     | 68 ++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/1229.out |  2 ++
>  2 files changed, 70 insertions(+)
>  create mode 100755 tests/generic/1229
>  create mode 100644 tests/generic/1229.out
> 
> diff --git a/tests/generic/1229 b/tests/generic/1229
> new file mode 100755
> index 00000000..7fa57105
> --- /dev/null
> +++ b/tests/generic/1229
> @@ -0,0 +1,68 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
> +#
> +# FS QA Test 1229
> +#
> +# fuzz fsx with atomic writes
> +#
> +. ./common/preamble
> +. ./common/atomicwrites
> +_begin_fstest rw auto quick atomicwrites
> +
> +_require_odirect
> +_require_scratch_write_atomic
> +
> +_scratch_mkfs >> $seqres.full 2>&1
> +_scratch_mount  >> $seqres.full 2>&1
> +
> +testfile=$SCRATCH_MNT/testfile
> +touch $testfile
> +
> +awu_max=$(_get_atomic_write_unit_max $testfile)
> +blksz=$(_get_block_size $SCRATCH_MNT)
> +bsize=`$here/src/min_dio_alignment $SCRATCH_MNT $SCRATCH_DEV`
> +
> +set_fsx_avoid() {
> +	local file=$1
> +
> +	case "$FSTYP" in
> +	"ext4")
> +		local dev=$(findmnt -n -o SOURCE --target $testfile)
> +
> +		# fsx insert/collpase range support for ext4+bigalloc is
> +		# currently broken, so disable it. Also disable incase we can't
> +		# detect bigalloc to be on safer side.
> +		if [ -z "$DUMPE2FS_PROG" ]; then
> +			echo "dumpe2fs not found, disabling insert/collapse range" >> $seqres.full
> +			FSX_AVOID+=" -I -C"
> +			return
> +		fi
> +
> +		$DUMPE2FS_PROG -h $dev 2>&1 | grep -q bigalloc && {
> +			echo "fsx insert/collapse range not supported with bigalloc. Disabling.." >> $seqres.full
> +			FSX_AVOID+=" -I -C"
> +		}
> +		;;
> +	*)
> +		;;
> +	esac
> +}
> +
> +# fsx usage:
> +#
> +# -N numops: total # operations to do
> +# -l flen: the upper bound on file size
> +# -o oplen: the upper bound on operation size (64k default)
> +# -Z: O_DIRECT ()
> +
> +set_fsx_avoid
> +_run_fsx_on_file $testfile -N 10000 -o $awu_max -A -l 500000 -r $bsize -w $bsize -Z $FSX_AVOID  >> $seqres.full
> +if [[ "$?" != "0" ]]
> +then
> +	_fail "fsx returned error: $?"
> +fi
> +
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/generic/1229.out b/tests/generic/1229.out
> new file mode 100644
> index 00000000..737d61c6
> --- /dev/null
> +++ b/tests/generic/1229.out
> @@ -0,0 +1,2 @@
> +QA output created by 1229
> +Silence is golden
> -- 
> 2.49.0
> 
> 

