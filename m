Return-Path: <linux-ext4+bounces-9219-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AE9B153BA
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Jul 2025 21:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 114041711DD
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Jul 2025 19:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80E524DCEA;
	Tue, 29 Jul 2025 19:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibU2TbnI"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E52F78F39;
	Tue, 29 Jul 2025 19:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753818115; cv=none; b=qk9u2VnQAsVdU+85v+ejAVzB9Aoff6HQ9vnk9L5PRojerl4CdAR2pF2Rc9LTxgRr6FJENTZxf9vJY2Dl4mlYd39BRA3CdHRxAUZz/FnNyaBpjOyH61YsVg0VGk92iCq824QGkM37r4vPVhaDnoBRqUVQsW3pufuAvw5we1ziqBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753818115; c=relaxed/simple;
	bh=Z5Bv5R0GynxADNMTJJLxnBtqWkmEUXqxVWlPqYjtpnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UW8cTsGnlL29zgcgG+PYKJ6vR/mPz1vYAI7ZxoQvx6nbCbdTdTqxmN+30SpssXSe7PrJkqbsZi83Iw8RlCJU1hcZlweF0GTbGGShDhB4LuCJpEWOUFPx7nDI3Kaz189OhA1IOMRKRA9LxnKf+tYnbrt+6d/n58V3HwLykTYPpoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ibU2TbnI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8225C4CEF7;
	Tue, 29 Jul 2025 19:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753818114;
	bh=Z5Bv5R0GynxADNMTJJLxnBtqWkmEUXqxVWlPqYjtpnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ibU2TbnIjcMknouscP+/Z43Xar3ciTldnl1yUofAzgS8afAePKRlLSGCGhqKo2lfJ
	 s1ISkSUPDOMBVeX4CSPQRc2ZVNv/kb3N1uNGlslEVO5enQHYwNlDdBfP7PfL75HWWv
	 DRDrf9WfLQTnjBv8jc0KtFTG/8mGAMPRmXWuy1UtRBI7NtYJxfeXZvnsOyL3HXdUdd
	 peRcUVzx9WS/IhPYEk9e5K9ZCzarPllwxUmsMbukMyuHk3pVUhXe20ozuEzf3/+d+3
	 rfcCujvrdqwHuB9LHVWmzPZuc84+r++VEUisR+HFv31NP4EFyWVvxXtQxlgqeYud4Z
	 pn/duSwxzqS/g==
Date: Tue, 29 Jul 2025 12:41:54 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
	Ritesh Harjani <ritesh.list@gmail.com>, john.g.garry@oracle.com,
	tytso@mit.edu, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 12/13] ext4/063: Atomic write test for extent split
 across leaf nodes
Message-ID: <20250729194154.GT2672039@frogsfrogsfrogs>
References: <cover.1752329098.git.ojaswin@linux.ibm.com>
 <b6f7b73de6bb6ebfc78e533f89f0899d884e5490.1752329098.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6f7b73de6bb6ebfc78e533f89f0899d884e5490.1752329098.git.ojaswin@linux.ibm.com>

On Sat, Jul 12, 2025 at 07:42:54PM +0530, Ojaswin Mujoo wrote:
> In ext4, even if an allocated range is physically and logically
> contiguous, it can still be split into 2 extents. This is because ext4
> does not merge extents across leaf nodes. This is an issue for atomic
> writes since even for a continuous extent the map block could (in rare
> cases) return a shorter map, hence tearning the write. This test creates
> such a file and ensures that the atomic write handles this case
> correctly
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>  tests/ext4/063     | 125 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/ext4/063.out |   2 +
>  2 files changed, 127 insertions(+)
>  create mode 100755 tests/ext4/063
>  create mode 100644 tests/ext4/063.out
> 
> diff --git a/tests/ext4/063 b/tests/ext4/063
> new file mode 100755
> index 00000000..25b5693d
> --- /dev/null
> +++ b/tests/ext4/063
> @@ -0,0 +1,125 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
> +#
> +# In ext4, even if an allocated range is physically and logically contiguous,
> +# it can still be split into 2 extents. This is because ext4 does not merge
> +# extents across leaf nodes. This is an issue for atomic writes since even for
> +# a continuous extent the map block could (in rare cases) return a shorter map,
> +# hence tearning the write. This test creates such a file and ensures that the
> +# atomic write handles this case correctly
> +#
> +. ./common/preamble
> +. ./common/atomicwrites
> +_begin_fstest auto atomicwrites
> +
> +_require_scratch_write_atomic_multi_fsblock
> +_require_atomic_write_test_commands
> +_require_command "$DEBUGFS_PROG" debugfs
> +
> +prep() {
> +	local bs=`_get_block_size $SCRATCH_MNT`
> +	local ex_hdr_bytes=12
> +	local ex_entry_bytes=12
> +	local entries_per_blk=$(( (bs - ex_hdr_bytes) / ex_entry_bytes ))
> +
> +	# fill the extent tree leaf which bs len extents at alternate offsets. For example,
> +	# for 4k bs the tree should look as follows
> +	#
> +	#                  +---------+---------+
> +	#                  | index 1 | index 2 |
> +	#                  +-----+---+-----+---+
> +	#               +--------+         +-------+
> +	#               |                          |
> +	#    +----------+--------------+     +-----+-----+
> +	#    | ex 1 | ex 2 |... | ex n |     |  ex n + 1 |
> +	#    +-------------------------+     +-----------+
> +	#    0      2            680          682
> +	for i in $(seq 0 $entries_per_blk)
> +	do
> +		$XFS_IO_PROG -fc "pwrite -b $bs $((i * 2 * bs)) $bs" $testfile > /dev/null
> +	done
> +	sync $testfile
> +
> +	echo >> $seqres.full
> +	echo "Create file with extents spanning 2 leaves. Extents:">> $seqres.full
> +	echo "...">> $seqres.full
> +	$DEBUGFS_PROG -R "ex `basename $testfile`" $SCRATCH_DEV |& tail >> $seqres.full
> +
> +	# Now try to insert a new extent ex(new) between ex(n) and ex(n+1). Since
> +	# this is a new FS the allocator would find continuous blocks such that
> +	# ex(n) ex(new) ex(n+1) are physically(and logically) contiguous. However,
> +	# since we dont merge extents across leaf we will end up with a tree as:
> +	#
> +	#                  +---------+---------+
> +	#                  | index 1 | index 2 |
> +	#                  +-----+---+-----+---+
> +	#               +--------+         +-------+
> +	#               |                          |
> +	#    +----------+--------------+     +-----+-----+
> +	#    | ex 1 | ex 2 |... | ex n |     | ex merged |
> +	#    +-------------------------+     +-----------+
> +	#    0      2            680          681  682  684

Where did 684 come from?  It's not in the 'before' diagram.  Did
"ex n + 1" previously map 682-684, and now it maps 681-684?

The rest looks ok though.

--D

> +	#
> +	echo >> $seqres.full
> +	torn_ex_offset=$((((entries_per_blk * 2) - 1) * bs))
> +	$XFS_IO_PROG -c "pwrite $torn_ex_offset $bs" $testfile >> /dev/null
> +	sync $testfile
> +
> +	echo >> $seqres.full
> +	echo "Perform 1 block write at $torn_ex_offset to create torn extent. Extents:">> $seqres.full
> +	echo "...">> $seqres.full
> +	$DEBUGFS_PROG -R "ex `basename $testfile`" $SCRATCH_DEV |& tail >> $seqres.full
> +
> +	_scratch_cycle_mount
> +}
> +
> +_scratch_mkfs >> $seqres.full
> +_scratch_mount >> $seqres.full
> +
> +testfile=$SCRATCH_MNT/testfile
> +touch $testfile
> +awu_max=$(_get_atomic_write_unit_max $testfile)
> +
> +echo >> $seqres.full
> +echo "# Prepping the file" >> $seqres.full
> +prep
> +
> +torn_aw_offset=$((torn_ex_offset - (torn_ex_offset % awu_max)))
> +
> +echo >> $seqres.full
> +echo "# Performing atomic IO on the torn extent range. Command: " >> $seqres.full
> +echo $XFS_IO_PROG -c "open -fsd $testfile" -c "pwrite -S 0x61 -DA -V1 -b $awu_max $torn_aw_offset $awu_max" >> $seqres.full
> +$XFS_IO_PROG -c "open -fsd $testfile" -c "pwrite -S 0x61 -DA -V1 -b $awu_max $torn_aw_offset $awu_max" >> $seqres.full
> +
> +echo >> $seqres.full
> +echo "Extent state after atomic write:">> $seqres.full
> +echo "...">> $seqres.full
> +$DEBUGFS_PROG -R "ex `basename $testfile`" $SCRATCH_DEV |& tail >> $seqres.full
> +
> +echo >> $seqres.full
> +echo "# Checking data integrity" >> $seqres.full
> +
> +# create a dummy file with expected data
> +$XFS_IO_PROG -fc "pwrite -S 0x61 -b $awu_max 0 $awu_max" $testfile.exp >> /dev/null
> +expected_data=$(od -An -t x1 -j 0 -N $awu_max $testfile.exp)
> +
> +# We ensure that the data after atomic writes should match the expected data
> +actual_data=$(od -An -t x1 -j $torn_aw_offset -N $awu_max $testfile)
> +if [[ "$actual_data" != "$expected_data" ]]
> +then
> +	echo "Checksum match failed at off: $torn_aw_offset size: $awu_max"
> +	echo
> +	echo "Expected: "
> +	echo "$expected_data"
> +	echo
> +	echo "Actual contents: "
> +	echo "$actual_data"
> +
> +	_fail
> +fi
> +
> +echo -n "Data verification at offset $torn_aw_offset suceeded!" >> $seqres.full
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/ext4/063.out b/tests/ext4/063.out
> new file mode 100644
> index 00000000..de35fc52
> --- /dev/null
> +++ b/tests/ext4/063.out
> @@ -0,0 +1,2 @@
> +QA output created by 063
> +Silence is golden
> -- 
> 2.49.0
> 
> 

