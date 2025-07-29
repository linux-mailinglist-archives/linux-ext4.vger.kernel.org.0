Return-Path: <linux-ext4+bounces-9218-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA17EB15382
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Jul 2025 21:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A50AC7B0BD4
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Jul 2025 19:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E90242927;
	Tue, 29 Jul 2025 19:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUJsvXRH"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1593EF507;
	Tue, 29 Jul 2025 19:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753817813; cv=none; b=X8VaSHrqU6YDEASxajm25iYlnxjKfg7q4PO9V7JZTO0PJpdx+sANlOyGCH6vfB3ZIrWomPsRKbwLHUIiPFzmtEWQqZPisMujbwQEVpQA4JRBiq9WqpKK1bbTswNVgfFddoyBCkELs2qIjm32SQF+9EmZtGltSu5vRa2qOZJ2t8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753817813; c=relaxed/simple;
	bh=roOFkqTFzp4zTjiVcl31QDnEMxJzSfs1CfVy7zIV4Cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sn+B4YoQVcjLv3rRl/Yr3HGGpK5aaYv6ybVSCXtBlriyL39oPk269lCVeDbNokMB5qKwgT775BicC3I6Z4f70Oq5vpg9CX5P4lhjhRUjjvDgHzh+GdacBoGfe9ZdaU1uw47sv8LBwFOz856/b2zcfwzDO3tNm3GP0KcpdfKXJYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUJsvXRH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F034C4CEEF;
	Tue, 29 Jul 2025 19:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753817812;
	bh=roOFkqTFzp4zTjiVcl31QDnEMxJzSfs1CfVy7zIV4Cg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fUJsvXRH4YcSxYcTWBV9YbGPiYZPlhblP5hKP62hSog2kJBI++PN9T2FtZ3Vj4J2X
	 iCN2Y97Vxe2E6/BzBcI0IEzqtnlMlNGrCku3m6/tC6FB12kgXG9N+ErrLxQdik1kQO
	 wHZYk3YAe/bfAB5EvwXlhs3v7YZHASr+2ueat9T3uyZ91os8ib6ZtLV6fMsDqH9+1r
	 qzNSax/gDGzhOZww9OkdV2Cs8b3WHgoJqGePvkwOWDx2xBGOTJ+SmrqRxDevWrXDMC
	 2KvUTJcWEly0rCM0Oqlopglw0D2As6DB1O6pG2xZi7HIdXiKv2XjqaDQsmsbXqcoDn
	 OVJ57NNoc9AUw==
Date: Tue, 29 Jul 2025 12:36:51 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
	Ritesh Harjani <ritesh.list@gmail.com>, john.g.garry@oracle.com,
	tytso@mit.edu, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 13/13] ext4/064: Add atomic write tests for journal
 credit calculation
Message-ID: <20250729193651.GS2672039@frogsfrogsfrogs>
References: <cover.1752329098.git.ojaswin@linux.ibm.com>
 <77fb2f74dfce591aed65364984803904da9c1408.1752329098.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77fb2f74dfce591aed65364984803904da9c1408.1752329098.git.ojaswin@linux.ibm.com>

On Sat, Jul 12, 2025 at 07:42:55PM +0530, Ojaswin Mujoo wrote:
> Test atomic writes with journal credit calculation. We take 2 cases
> here:
> 
> 1. Atomic writes on single mapping causing tree to collapse into
>    the inode
> 2. Atomic writes on mixed mapping causing tree to collapse into the
>    inode
> 
> This test is inspired by ext4/034.
> 
> Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>  tests/ext4/064     | 75 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/ext4/064.out |  2 ++
>  2 files changed, 77 insertions(+)
>  create mode 100755 tests/ext4/064
>  create mode 100644 tests/ext4/064.out
> 
> diff --git a/tests/ext4/064 b/tests/ext4/064
> new file mode 100755
> index 00000000..ec31f983
> --- /dev/null
> +++ b/tests/ext4/064
> @@ -0,0 +1,75 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
> +#
> +# FS QA Test 034
> +#
> +# Test proper credit reservation is done when performing
> +# tree collapse during an aotmic write based allocation
> +#
> +. ./common/preamble
> +. ./common/atomicwrites
> +_begin_fstest auto quick quota fiemap prealloc atomicwrites
> +
> +# Import common functions.
> +
> +
> +# Modify as appropriate.
> +_exclude_fs ext2
> +_exclude_fs ext3
> +_require_xfs_io_command "falloc"
> +_require_xfs_io_command "fiemap"
> +_require_xfs_io_command "syncfs"
> +_require_scratch_write_atomic_multi_fsblock
> +_require_atomic_write_test_commands

_require_metadata_journaling $SCRATCH_DEV ?

> +
> +echo "----- Testing with atomic write on non-mixed mapping -----" >> $seqres.full
> +
> +echo "Format and mount" >> $seqres.full
> +_scratch_mkfs  > $seqres.full 2>&1
> +_scratch_mount > $seqres.full 2>&1
> +
> +echo "Create the original file" >> $seqres.full
> +touch $SCRATCH_MNT/foobar >> $seqres.full
> +
> +echo "Create 2 level extent tree (btree) for foobar with a unwritten extent" >> $seqres.full
> +$XFS_IO_PROG -f -c "pwrite 0 4k" -c "falloc 4k 4k" -c "pwrite 8k 4k" \
> +	     -c "pwrite 20k 4k"  -c "pwrite 28k 4k" -c "pwrite 36k 4k" \
> +	     -c "fsync" $SCRATCH_MNT/foobar >> $seqres.full

What happens if the block size isn't 4k?

--D

> +
> +$XFS_IO_PROG -c "fiemap -v" $SCRATCH_MNT/foobar >> $seqres.full
> +
> +echo "Convert unwritten extent to written and collapse extent tree to inode" >> $seqres.full
> +$XFS_IO_PROG -dc "pwrite -A -V1 4k 4k" $SCRATCH_MNT/foobar >> $seqres.full
> +
> +echo "Create a new file and do fsync to force a jbd2 commit" >> $seqres.full
> +$XFS_IO_PROG -f -c "pwrite 0 4k" -c "fsync" $SCRATCH_MNT/dummy >> $seqres.full
> +
> +echo "sync $SCRATCH_MNT to writeback" >> $seqres.full
> +$XFS_IO_PROG -c "syncfs" $SCRATCH_MNT >> $seqres.full
> +
> +echo "----- Testing with atomi write on mixed mapping -----" >> $seqres.full
> +
> +echo "Create the original file" >> $seqres.full
> +touch $SCRATCH_MNT/foobar2 >> $seqres.full
> +
> +echo "Create 2 level extent tree (btree) for foobar2 with a unwritten extent" >> $seqres.full
> +$XFS_IO_PROG -f -c "pwrite 0 4k" -c "falloc 4k 4k" -c "pwrite 8k 4k" \
> +	     -c "pwrite 20k 4k"  -c "pwrite 28k 4k" -c "pwrite 36k 4k" \
> +	     -c "fsync" $SCRATCH_MNT/foobar2 >> $seqres.full
> +
> +$XFS_IO_PROG -c "fiemap -v" $SCRATCH_MNT/foobar2 >> $seqres.full
> +
> +echo "Convert unwritten extent to written and collapse extent tree to inode" >> $seqres.full
> +$XFS_IO_PROG -dc "pwrite -A -V1 0k 12k" $SCRATCH_MNT/foobar2 >> $seqres.full
> +
> +echo "Create a new file and do fsync to force a jbd2 commit" >> $seqres.full
> +$XFS_IO_PROG -f -c "pwrite 0 4k" -c "fsync" $SCRATCH_MNT/dummy2 >> $seqres.full
> +
> +echo "sync $SCRATCH_MNT to writeback" >> $seqres.full
> +$XFS_IO_PROG -c "syncfs" $SCRATCH_MNT >> $seqres.full
> +
> +# success, all done
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/ext4/064.out b/tests/ext4/064.out
> new file mode 100644
> index 00000000..d9076546
> --- /dev/null
> +++ b/tests/ext4/064.out
> @@ -0,0 +1,2 @@
> +QA output created by 064
> +Silence is golden
> -- 
> 2.49.0
> 
> 

