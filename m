Return-Path: <linux-ext4+bounces-9050-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A997B0919D
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Jul 2025 18:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73641169785
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Jul 2025 16:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340AC2FCE02;
	Thu, 17 Jul 2025 16:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIvCsXYQ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCA92FC3D6;
	Thu, 17 Jul 2025 16:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752769351; cv=none; b=kvt1nwqF56Sd4QB2+SBwjg5TfmoiFVZNIKiYrB9NR9mBjbhRwN6P8kaC1tZdJgu+lFyB4k4Uv0c+3Sp7+Rb3K7tOEXfzcZQy58Pl7GuVkBVZl3UzTO0qCcReRjG6W5ffMhALMtGOHRfMDn165L/C/vc5Qy48WxsGQvRQDg3/Fes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752769351; c=relaxed/simple;
	bh=aOZ4UXUHU742RZyFYCBD+aqPcjlKc9y2ocreOqmH2+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NYhMyXMeNqUMVWVoDkN/kr1M0R7b/YzFCXqBmiOAEsAjaUHV4Ioa1Ygg1NojqKFrsQ+iSGDHe7m5a28NJGLRgbksL3FiIACHzKgf3sSF7tNbNiJFrVvxX/wagALAJGOBAxNSNR8ZpPA/Kxl/aWoVbiSe6AMKNRMl8guVGbwi1JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIvCsXYQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4517DC4CEE3;
	Thu, 17 Jul 2025 16:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752769351;
	bh=aOZ4UXUHU742RZyFYCBD+aqPcjlKc9y2ocreOqmH2+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KIvCsXYQHYks0NgRDnTRPc28F6C8gvGrllbssBaykoV4JWoFBxW6PM5AvZlK7TrOO
	 ra3zO1ZI63G3g7ne17DqZ8N5OQyCQ3Cl+9xR1Z12gThzNS4EhslrD1QAvLcNwekyIA
	 CfcgY7dDyDUKn6KUPIsmDxPwo65uFh5HrKjJTczQDvZX9wzGKF3Lra9uKcBqgkjoIm
	 dP9ukrfo6d5Vofd7WPVkl25IT2q+E3AjHVr4uhhgBSjI0rGNRIucu6/UklZgXI0Q1s
	 bwkK2VO2g1SGQpnA00TB9kjtDUYt7rCNyZdsw2lkHvrUoPxrb8bN1yxEHMayhPRtKj
	 OJ7hvbof5MUUg==
Date: Thu, 17 Jul 2025 09:22:30 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
	Ritesh Harjani <ritesh.list@gmail.com>, john.g.garry@oracle.com,
	tytso@mit.edu, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 08/13] generic/1229: Stress fsx with atomic writes
 enabled
Message-ID: <20250717162230.GH2672039@frogsfrogsfrogs>
References: <cover.1752329098.git.ojaswin@linux.ibm.com>
 <1e1e7d552e91fab58037b7b35ffbf8b2e7070be5.1752329098.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e1e7d552e91fab58037b7b35ffbf8b2e7070be5.1752329098.git.ojaswin@linux.ibm.com>

On Sat, Jul 12, 2025 at 07:42:50PM +0530, Ojaswin Mujoo wrote:
> Stress file with atomic writes to ensure we excercise codepaths
> where we are mixing different FS operations with atomic writes
> 
> Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Hrm, doesn't generic/521 test this already if the fs happens to support
atomic writes?

--D

> ---
>  tests/generic/1229     | 41 +++++++++++++++++++++++++++++++++++++++++
>  tests/generic/1229.out |  2 ++
>  2 files changed, 43 insertions(+)
>  create mode 100755 tests/generic/1229
>  create mode 100644 tests/generic/1229.out
> 
> diff --git a/tests/generic/1229 b/tests/generic/1229
> new file mode 100755
> index 00000000..98e9b50c
> --- /dev/null
> +++ b/tests/generic/1229
> @@ -0,0 +1,41 @@
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
> +# fsx usage:
> +#
> +# -N numops: total # operations to do
> +# -l flen: the upper bound on file size
> +# -o oplen: the upper bound on operation size (64k default)
> +# -Z: O_DIRECT ()
> +
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

