Return-Path: <linux-ext4+bounces-9052-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AC4B091F1
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Jul 2025 18:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B24B189418F
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Jul 2025 16:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126A62F85FA;
	Thu, 17 Jul 2025 16:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Es6iKDxd"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F901E5207;
	Thu, 17 Jul 2025 16:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752770111; cv=none; b=psqIp1JzhjUTQIrZOBH7YO+6SmcLgWJ/YJTgodkD+SOdTS/7WVe2LUx8tNpar5a54HcmcZrR3j0bC6v+NE860VAWqXrv0IWwtUr6bnjscUbgCAJkTnRRBoig4AwZMGU3fqgOm3gSShM1ce9RbAmRdZVXUXI3kAvCZxOQJxsdm7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752770111; c=relaxed/simple;
	bh=RAcZ+A+iHinoFPvbrIQmeXWWCLpNcugJR3aQB6YG3Kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k9pjtNgqmR7UOx5an0nUq7cbS3n6OjCn6aGCuGmnNXrkHkpMTJWp2QIihz0Gws3FVMe7+B5PZONW2XQQwz3Us/xSyXZa/4jHfh1Mrj5K6s1u0dDXKYHtHC5g3UKkFuA6/jEWKTaSU9l7kAIVHEe/BHIBDbM+FhtEXwiB6EHipwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Es6iKDxd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DAA7C4CEE3;
	Thu, 17 Jul 2025 16:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752770111;
	bh=RAcZ+A+iHinoFPvbrIQmeXWWCLpNcugJR3aQB6YG3Kw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Es6iKDxdHVOaFrpn9HOdL2whny8QNiTLqNE8fu8C4MZYEw33qLuiHZSceTs8o9BWO
	 VO3E5OVuoQ+4rNeeYlHgSY0ySmXsmf/hKidDN5tBeBYId6iJXVeY3GdOA+eDEjrEuv
	 JNaqWXiYYS/EomttGfUth/aXuuxlL0f3kz5iUHAoxRCXduUWeeTE/1yX4lRcKh3V4m
	 Swhr/h/w7OGDSIC4zaB0eUbA0zC5KXigkcAlzKOd9Gqgr5qdc4KI/E8Nlk4vB3BrUG
	 /1exYl6bOdVsTxy39QOFQCcK42z9insgpkV4I2a7/W5/vwi7UnLOGudmCAIltxoOCe
	 Zvm8w0hdFBJwg==
Date: Thu, 17 Jul 2025 09:35:10 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
	Ritesh Harjani <ritesh.list@gmail.com>, john.g.garry@oracle.com,
	tytso@mit.edu, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 07/13] generic/1228: Add atomic write multi-fsblock
 O_[D]SYNC tests
Message-ID: <20250717163510.GJ2672039@frogsfrogsfrogs>
References: <cover.1752329098.git.ojaswin@linux.ibm.com>
 <ae247b8d0a9b1309a2e4887f8dd30c1d6e479848.1752329098.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae247b8d0a9b1309a2e4887f8dd30c1d6e479848.1752329098.git.ojaswin@linux.ibm.com>

On Sat, Jul 12, 2025 at 07:42:49PM +0530, Ojaswin Mujoo wrote:
> This adds various atomic write multi-fsblock stresst tests
> with mixed mappings and O_SYNC, to ensure the data and metadata
> is atomically persisted even if there is a shutdown.
> 
> Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>  tests/generic/1228     | 139 +++++++++++++++++++++++++++++++++++++++++
>  tests/generic/1228.out |   2 +
>  2 files changed, 141 insertions(+)
>  create mode 100755 tests/generic/1228
>  create mode 100644 tests/generic/1228.out
> 
> diff --git a/tests/generic/1228 b/tests/generic/1228
> new file mode 100755
> index 00000000..3f9a6af1
> --- /dev/null
> +++ b/tests/generic/1228
> @@ -0,0 +1,139 @@
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
> +	if [[ "$1" == "shutdown" ]]
> +	then
> +		local do_shutdown=1
> +	fi
> +
> +	test $bytes_written -eq $awu_max || _fail "atomic write len=$awu_max assertion failed"
> +
> +	if [[ $do_shutdown -eq "1" ]]
> +	then
> +		echo "Shutting down filesystem" >> $seqres.full
> +		_scratch_shutdown >> $seqres.full
> +		_scratch_cycle_mount >>$seqres.full 2>&1 || _fail "remount failed for Test-3"
> +	fi
> +
> +	check_data_integrity
> +}
> +
> +mixed_mapping_test() {
> +	prep_mixed_mapping
> +
> +	echo "+ + Performing O_DSYNC atomic write from 0 to $awu_max" >> $seqres.full
> +	bytes_written=$($XFS_IO_PROG -dc "pwrite -DA -V1 -b $awu_max 0 $awu_max" $testfile | \
> +		        grep wrote | awk -F'[/ ]' '{print $2}')
> +
> +	verify_atomic_write $1

The shutdown happens after the synchronous write completes?  If so, then
what part of recovery is this testing?

--D

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
> +bytes_written=$($XFS_IO_PROG -dstc "pwrite -A -V1 -b $awu_max 0 $awu_max" $testfile | \
> +                grep wrote | awk -F'[/ ]' '{print $2}')
> +verify_atomic_write "shutdown"
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

