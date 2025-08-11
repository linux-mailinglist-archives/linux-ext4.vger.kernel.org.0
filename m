Return-Path: <linux-ext4+bounces-9331-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C21B2106E
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Aug 2025 17:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35CF418A1E3D
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Aug 2025 15:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865D52E5B0C;
	Mon, 11 Aug 2025 15:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u+ee6uzy"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA642E0934;
	Mon, 11 Aug 2025 15:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754926172; cv=none; b=g+PcOgopCm9b+4F5igGn5PQPGTPWDNQaA61lJ31ur98uPKR44lp3nb186ZT1vrx1Xo3GzOXJ5v6oKe2X8JtrjUQqMZnK+UnuxsHK/qPEDy8vi6WMz6IBItx53bCmuj+Mqlrx6j+Wa7iyUvxYzTKDP2sUcoE8u/+hDXK3yX3q0X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754926172; c=relaxed/simple;
	bh=DaoO0tOAvuz+IieVCs2Sd8Rvss6i/VyAINsBzWtgG08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HlILmarBmBsTBNBYYX7j7wgzEBI4AJqmWLgBVmc80j1gfJzRPMyaJ9O+VvAZ9W3cRmqWCGHYswlpyGxAGk5tKaPjEFVgFWbiOFCbHrclpk3ptpyrcvrMU2M9CAqj1616AR1C0OfnhwhVGeu6BvjblDo18EOYXcowxJ13G8+gYI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u+ee6uzy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7EACC4CEED;
	Mon, 11 Aug 2025 15:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754926171;
	bh=DaoO0tOAvuz+IieVCs2Sd8Rvss6i/VyAINsBzWtgG08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u+ee6uzyVyBXe3OGMvR73lm8imKsfB3QLa0r3oVyr53nuV+UFgcuDRoNpMLAtIkzL
	 N7q6xmJHs8ImeY0PuX7INuJEplIyHdIw1HmslRd/HZ0MyBK7MGeVguerKl1pwLBbA9
	 owVy9BHNa1REfFNrO4G9zCCugNr1wUudSll+G4GKKhpIkhw7U1fTYb0xiYIaXImJj3
	 O5pkkD8CxthBIjekBuqxrUGHi/cGYOnDW8XOvTYg8zZBaP2f5sm7VbAhIqCo9b1FyJ
	 novVXUKROcJZvIIraAhV3Vwn0fDT2ALJ8QyINnWNVBr4IXlhac305eHEg9Vga5GOWB
	 +sUIr5juO4jSg==
Date: Mon, 11 Aug 2025 08:29:31 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
	Ritesh Harjani <ritesh.list@gmail.com>, john.g.garry@oracle.com,
	tytso@mit.edu, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v4 06/11] generic: Add atomic write multi-fsblock
 O_[D]SYNC tests
Message-ID: <20250811152931.GI7965@frogsfrogsfrogs>
References: <cover.1754833177.git.ojaswin@linux.ibm.com>
 <af97ff125953e4e29abc42d1726c632398652d67.1754833177.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af97ff125953e4e29abc42d1726c632398652d67.1754833177.git.ojaswin@linux.ibm.com>

On Sun, Aug 10, 2025 at 07:11:57PM +0530, Ojaswin Mujoo wrote:
> This adds various atomic write multi-fsblock stresst tests
> with mixed mappings and O_SYNC, to ensure the data and metadata
> is atomically persisted even if there is a shutdown.
> 
> Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Looks fine to me now.
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  tests/generic/1228     | 137 +++++++++++++++++++++++++++++++++++++++++
>  tests/generic/1228.out |   2 +
>  2 files changed, 139 insertions(+)
>  create mode 100755 tests/generic/1228
>  create mode 100644 tests/generic/1228.out
> 
> diff --git a/tests/generic/1228 b/tests/generic/1228
> new file mode 100755
> index 00000000..888599ce
> --- /dev/null
> +++ b/tests/generic/1228
> @@ -0,0 +1,137 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
> +#
> +# FS QA Test 1228
> +#
> +# Atomic write multi-fsblock data integrity tests with mixed mappings
> +# and O_SYNC
> +#
> +. ./common/preamble
> +. ./common/atomicwrites
> +_begin_fstest auto quick rw atomicwrites
> +
> +_require_scratch_write_atomic_multi_fsblock
> +_require_atomic_write_test_commands
> +_require_scratch_shutdown
> +_require_xfs_io_command "truncate"
> +
> +_scratch_mkfs >> $seqres.full
> +_scratch_mount >> $seqres.full
> +
> +check_data_integrity() {
> +	actual=$(_hexdump $testfile)
> +	if [[ "$expected" != "$actual" ]]
> +	then
> +		echo "Integrity check failed"
> +		echo "Integrity check failed" >> $seqres.full
> +		echo "# Expected file contents:" >> $seqres.full
> +		echo "$expected" >> $seqres.full
> +		echo "# Actual file contents:" >> $seqres.full
> +		echo "$actual" >> $seqres.full
> +
> +		_fail "Data integrity check failed. The atomic write was torn."
> +	fi
> +}
> +
> +prep_mixed_mapping() {
> +	$XFS_IO_PROG -c "truncate 0" $testfile >> $seqres.full
> +	local off=0
> +	local mapping=""
> +
> +	local operations=("W" "H" "U")
> +	local num_blocks=$((awu_max / blksz))
> +	for ((i=0; i<num_blocks; i++)); do
> +		local index=$((RANDOM % ${#operations[@]}))
> +		local map="${operations[$index]}"
> +		local mapping="${mapping}${map}"
> +
> +		case "$map" in
> +			"W")
> +				$XFS_IO_PROG -dc "pwrite -S 0x61 -b $blksz $off $blksz" $testfile > /dev/null
> +				;;
> +			"H")
> +				# No operation needed for hole
> +				;;
> +			"U")
> +				$XFS_IO_PROG -c "falloc $off $blksz" $testfile >> /dev/null
> +				;;
> +		esac
> +		off=$((off + blksz))
> +	done
> +
> +	echo "+ + Mixed mapping prep done. Full mapping pattern: $mapping" >> $seqres.full
> +
> +	sync $testfile
> +}
> +
> +verify_atomic_write() {
> +	test $bytes_written -eq $awu_max || _fail "atomic write len=$awu_max assertion failed"
> +	check_data_integrity
> +}
> +
> +mixed_mapping_test() {
> +	prep_mixed_mapping
> +
> +	echo -"+ + Performing O_DSYNC atomic write from 0 to $awu_max" >> $seqres.full
> +	if [[ "$1" == "shutdown" ]]
> +	then
> +		bytes_written=$($XFS_IO_PROG -x -dc \
> +				"pwrite -DA -V1 -b $awu_max 0 $awu_max" \
> +				-c "shutdown" $testfile | grep wrote | \
> +				awk -F'[/ ]' '{print $2}')
> +		_scratch_cycle_mount >>$seqres.full 2>&1 || _fail "remount failed"
> +	else
> +		bytes_written=$($XFS_IO_PROG -dc \
> +				"pwrite -DA -V1 -b $awu_max 0 $awu_max" $testfile | \
> +				grep wrote | awk -F'[/ ]' '{print $2}')
> +	fi
> +
> +	verify_atomic_write
> +}
> +
> +testfile=$SCRATCH_MNT/testfile
> +touch $testfile
> +
> +awu_max=$(_get_atomic_write_unit_max $testfile)
> +blksz=$(_get_block_size $SCRATCH_MNT)
> +
> +# Create an expected pattern to compare with
> +$XFS_IO_PROG -tc "pwrite -b $awu_max 0 $awu_max" $testfile >> $seqres.full
> +expected=$(_hexdump $testfile)
> +echo "# Expected file contents:" >> $seqres.full
> +echo "$expected" >> $seqres.full
> +echo >> $seqres.full
> +
> +echo "# Test 1: Do O_DSYNC atomic write on random mixed mapping:" >> $seqres.full
> +echo >> $seqres.full
> +for ((iteration=1; iteration<=10; iteration++)); do
> +	echo "=== Mixed Mapping Test Iteration $iteration ===" >> $seqres.full
> +
> +	echo "+ Testing without shutdown..." >> $seqres.full
> +	mixed_mapping_test
> +	echo "Passed!" >> $seqres.full
> +
> +	echo "+ Testing with sudden shutdown..." >> $seqres.full
> +	mixed_mapping_test "shutdown"
> +	echo "Passed!" >> $seqres.full
> +
> +	echo "Iteration $iteration completed: OK" >> $seqres.full
> +	echo >> $seqres.full
> +done
> +echo "# Test 1: Do O_SYNC atomic write on random mixed mapping (10 iterations): OK" >> $seqres.full
> +
> +
> +echo >> $seqres.full
> +echo "# Test 2: Do extending O_SYNC atomic writes: " >> $seqres.full
> +bytes_written=$($XFS_IO_PROG -x -dstc "pwrite -A -V1 -b $awu_max 0 $awu_max" \
> +		-c "shutdown" $testfile | grep wrote | awk -F'[/ ]' '{print $2}')
> +_scratch_cycle_mount >>$seqres.full 2>&1 || _fail "remount failed"
> +verify_atomic_write
> +echo "# Test 2: Do extending O_SYNC atomic writes: OK" >> $seqres.full
> +
> +# success, all done
> +echo "Silence is golden"
> +status=0
> +exit
> +
> diff --git a/tests/generic/1228.out b/tests/generic/1228.out
> new file mode 100644
> index 00000000..1baffa91
> --- /dev/null
> +++ b/tests/generic/1228.out
> @@ -0,0 +1,2 @@
> +QA output created by 1228
> +Silence is golden
> -- 
> 2.49.0
> 
> 

