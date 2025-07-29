Return-Path: <linux-ext4+bounces-9222-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2150B153E4
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Jul 2025 21:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 144803B15E3
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Jul 2025 19:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C715124676D;
	Tue, 29 Jul 2025 19:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vOzlHsKG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD9323184F;
	Tue, 29 Jul 2025 19:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753818564; cv=none; b=tmedVAm+pDEO4oXWOM+sjuCBXqLBL3b2e0sY/lhD5nJF/tliLoVN8FYg7tGa/HRxMS2FZiTJeDSB8tF2hy6/Miq4hxR2cn9F2pQ4ojKB7yPb4d1x2QNQ9uRw1fmcpezgiRZ7JhkIfbAMt091cm065Qf1esCWvjO6ufHyPctfBHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753818564; c=relaxed/simple;
	bh=cFk4vFIsASUg+tOLvZKl6Km/LTyb5ZNVyfjNHmpGF9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZxQRIuirSPu8WGWo2GOWyTXrBM1H3pfQaEQnWqQd4aXDcnptzPqh2KA2AQpfB8RWvRpyCjvm2cKuyy+2hK+JGt8hG/nq/DvuKx+9gB221/EA3PUueMJBp/c+gX2meVKTZQzoB+kVSUyyF+GBv5H9ZoiAmiqIrvBzgJoxujtXjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vOzlHsKG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE4ABC4CEEF;
	Tue, 29 Jul 2025 19:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753818564;
	bh=cFk4vFIsASUg+tOLvZKl6Km/LTyb5ZNVyfjNHmpGF9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vOzlHsKGJGBL77oZbcfHIgL9H4CbdTWGAke8jHXfl7/nsS/6iJcxouTQungV60PUi
	 SUI6q2c6JTARlaQq6kZDdwoVujLmPkzbiSYJZxA0P7oMXpc2L9LU4KpszhMrjka0oF
	 bltJ/RjDXAu9L0zWovRUVzYVFI5INjrBNCtOe+4PYp8iEblu2EdBeH1dj9wderM0wj
	 kn4piSBZhbBjDu+sT/tBJKh9rXFSRZyVE4kryHiM2vFwWKdXOA4jxBwNrgBirzx+K2
	 wOutTnWZ4H8Dkt4bWgdKgwml0qFet942y2J5YfOAbJM1U8aJXIb+0dXERu+8sz88Vy
	 OkLvy9rwtTdpg==
Date: Tue, 29 Jul 2025 12:49:23 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
	Ritesh Harjani <ritesh.list@gmail.com>, john.g.garry@oracle.com,
	tytso@mit.edu, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 09/13] generic/1230: Add sudden shutdown tests for
 multi block atomic writes
Message-ID: <20250729194923.GW2672039@frogsfrogsfrogs>
References: <cover.1752329098.git.ojaswin@linux.ibm.com>
 <4965ba3e281a81558f1fe06fe1c478d29adca1e5.1752329098.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4965ba3e281a81558f1fe06fe1c478d29adca1e5.1752329098.git.ojaswin@linux.ibm.com>

On Sat, Jul 12, 2025 at 07:42:51PM +0530, Ojaswin Mujoo wrote:
> This test is intended to ensure that multi blocks atomic writes
> maintain atomic guarantees across sudden FS shutdowns.
> 
> The way we work is that we lay out a file with random mix of written,
> unwritten and hole extents. Then we start performing atomic writes
> sequentially on the file while we parallely shutdown the FS. Then we
> note the last offset where the atomic write happened just before shut
> down and then make sure blocks around it either have completely old
> data or completely new data, ie the write was not torn during shutdown.
> 
> We repeat the same with completely written, completely unwritten and completely
> empty file to ensure these cases are not torn either.  Finally, we have a
> similar test for append atomic writes
> 
> Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Looks fine to me,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  tests/generic/1230     | 397 +++++++++++++++++++++++++++++++++++++++++
>  tests/generic/1230.out |   2 +
>  2 files changed, 399 insertions(+)
>  create mode 100755 tests/generic/1230
>  create mode 100644 tests/generic/1230.out
> 
> diff --git a/tests/generic/1230 b/tests/generic/1230
> new file mode 100755
> index 00000000..cff5adc0
> --- /dev/null
> +++ b/tests/generic/1230
> @@ -0,0 +1,397 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
> +#
> +# FS QA Test No. 1230
> +#
> +# Test multi block atomic writes with sudden FS shutdowns to ensure
> +# the FS is not tearing the write operation
> +. ./common/preamble
> +. ./common/atomicwrites
> +_begin_fstest auto atomicwrites
> +
> +_require_scratch_write_atomic_multi_fsblock
> +_require_atomic_write_test_commands
> +_require_scratch_shutdown
> +_require_xfs_io_command "truncate"
> +
> +_scratch_mkfs >> $seqres.full 2>&1
> +_scratch_mount >> $seqres.full
> +
> +testfile=$SCRATCH_MNT/testfile
> +touch $testfile
> +
> +awu_max=$(_get_atomic_write_unit_max $testfile)
> +blksz=$(_get_block_size $SCRATCH_MNT)
> +echo "Awu max: $awu_max" >> $seqres.full
> +
> +num_blocks=$((awu_max / blksz))
> +# keep initial value high for dry run. This will be
> +# tweaked in dry_run() based on device write speed.
> +filesize=$(( 10 * 1024 * 1024 * 1024 ))
> +
> +_cleanup() {
> +	[ -n "$awloop_pid" ] && kill $awloop_pid &> /dev/null
> +	wait
> +}
> +
> +atomic_write_loop() {
> +	local off=0
> +	local size=$awu_max
> +	for ((i=0; i<$((filesize / $size )); i++)); do
> +		# Due to sudden shutdown this can produce errors so just
> +		# redirect them to seqres.full
> +		$XFS_IO_PROG -c "open -fsd $testfile" -c "pwrite -S 0x61 -DA -V1 -b $size $off $size" >> /dev/null 2>>$seqres.full
> +		echo "Written to offset: $off" >> $tmp.aw
> +		off=$((off + $size))
> +	done
> +}
> +
> +# This test has the following flow:
> +# 1. Start doing sequential atomic writes in bg, upto $filesize
> +# 2. Sleep for 0.2s and shutdown the FS
> +# 3. kill the atomic write process
> +# 4. verify the writes were not torn
> +#
> +# We ideally want the shutdown to happen while an atomic write is ongoing
> +# but this gets tricky since faster devices can actually finish the whole
> +# atomic write loop before sleep 0.2s completes, resulting in the shutdown
> +# happening after the write loop which is not what we want. A simple solution
> +# to this is to increase $filesize so step 1 takes long enough but a big
> +# $filesize leads to create_mixed_mappings() taking very long, which is not
> +# ideal.
> +#
> +# Hence, use the dry_run function to figure out the rough device speed and set
> +# $filesize accordingly.
> +dry_run() {
> +	echo >> $seqres.full
> +	echo "# Estimating ideal filesize..." >> $seqres.full
> +	atomic_write_loop &
> +	awloop_pid=$!
> +
> +	local i=0
> +	# Wait for atleast first write to be recorded or 10s
> +	while [ ! -f "$tmp.aw" -a $i -le 50 ]; do i=$((i + 1)); sleep 0.2; done
> +
> +	if [[ $i -gt 50 ]]
> +	then
> +		_fail "atomic write process took too long to start"
> +	fi
> +
> +	echo >> $seqres.full
> +	echo "# Shutting down filesystem while write is running" >> $seqres.full
> +	_scratch_shutdown
> +
> +	kill $awloop_pid 2>/dev/null  # the process might have finished already
> +	wait $awloop_pid
> +	unset $awloop_pid
> +
> +	bytes_written=$(tail -n 1 $tmp.aw | cut -d" " -f4)
> +	echo "# Bytes written in 0.2s: $bytes_written" >> $seqres.full
> +
> +	filesize=$((bytes_written * 3))
> +	echo "# Setting \$filesize=$filesize" >> $seqres.full
> +
> +	rm $tmp.aw
> +	sleep 0.5
> +
> +	_scratch_cycle_mount
> +
> +}
> +
> +create_mixed_mappings() {
> +	local file=$1
> +	local size_bytes=$2
> +
> +	echo "# Filling file $file with alternate mappings till size $size_bytes" >> $seqres.full
> +	#Fill the file with alternate written and unwritten blocks
> +	local off=0
> +	local operations=("W" "U")
> +
> +	for ((i=0; i<$((size_bytes / blksz )); i++)); do
> +		index=$(($i % ${#operations[@]}))
> +		map="${operations[$index]}"
> +
> +		case "$map" in
> +		    "W")
> +			$XFS_IO_PROG -fc "pwrite -b $blksz $off $blksz" $file  >> /dev/null
> +			;;
> +		    "U")
> +			$XFS_IO_PROG -fc "falloc $off $blksz" $file >> /dev/null
> +			;;
> +		esac
> +		off=$((off + blksz))
> +	done
> +
> +	sync $file
> +}
> +
> +populate_expected_data() {
> +	# create a dummy file with expected old data for different cases
> +	create_mixed_mappings $testfile.exp_old_mixed $awu_max
> +	expected_data_old_mixed=$(od -An -t x1 -j 0 -N $awu_max $testfile.exp_old_mixed)
> +
> +	$XFS_IO_PROG -fc "falloc 0 $awu_max" $testfile.exp_old_zeroes >> $seqres.full
> +	expected_data_old_zeroes=$(od -An -t x1 -j 0 -N $awu_max $testfile.exp_old_zeroes)
> +
> +	$XFS_IO_PROG -fc "pwrite -b $awu_max 0 $awu_max" $testfile.exp_old_mapped >> $seqres.full
> +	expected_data_old_mapped=$(od -An -t x1 -j 0 -N $awu_max $testfile.exp_old_mapped)
> +
> +	# create a dummy file with expected new data
> +	$XFS_IO_PROG -fc "pwrite -S 0x61 -b $awu_max 0 $awu_max" $testfile.exp_new >> $seqres.full
> +	expected_data_new=$(od -An -t x1 -j 0 -N $awu_max $testfile.exp_new)
> +}
> +
> +verify_data_blocks() {
> +	local verify_start=$1
> +	local verify_end=$2
> +	local expected_data_old="$3"
> +	local expected_data_new="$4"
> +
> +	echo >> $seqres.full
> +	echo "# Checking data integrity from $verify_start to $verify_end" >> $seqres.full
> +
> +	# After an atomic write, for every chunk we ensure that the underlying
> +	# data is either the old data or new data as writes shouldn't get torn.
> +	local off=$verify_start
> +	while [[ "$off" -lt "$verify_end" ]]
> +	do
> +		#actual_data=$(xxd -s $off -l $awu_max -p $testfile)
> +		actual_data=$(od -An -t x1 -j $off -N $awu_max $testfile)
> +		if [[ "$actual_data" != "$expected_data_new" ]] && [[ "$actual_data" != "$expected_data_old" ]]
> +		then
> +			echo "Checksum match failed at off: $off size: $awu_max"
> +			echo "Expected contents: (Either of the 2 below):"
> +			echo
> +			echo "Expected old: "
> +			echo "$expected_data_old"
> +			echo
> +			echo "Expected new: "
> +			echo "$expected_data_new"
> +			echo
> +			echo "Actual contents: "
> +			echo "$actual_data"
> +
> +			_fail
> +		fi
> +		echo -n "Check at offset $off suceeded! " >> $seqres.full
> +		if [[ "$actual_data" == "$expected_data_new" ]]
> +		then
> +			echo "matched new" >> $seqres.full
> +		elif [[ "$actual_data" == "$expected_data_old" ]]
> +		then
> +			echo "matched old" >> $seqres.full
> +		fi
> +		off=$(( off + awu_max ))
> +	done
> +}
> +
> +# test data integrity for file by shutting down in between atomic writes
> +test_data_integrity() {
> +	echo >> $seqres.full
> +	echo "# Writing atomically to file in background" >> $seqres.full
> +	atomic_write_loop &
> +	awloop_pid=$!
> +
> +	local i=0
> +	# Wait for atleast first write to be recorded or 10s
> +	while [ ! -f "$tmp.aw" -a $i -le 50 ]; do i=$((i + 1)); sleep 0.2; done
> +
> +	if [[ $i -gt 50 ]]
> +	then
> +		_fail "atomic write process took too long to start"
> +	fi
> +
> +	echo >> $seqres.full
> +	echo "# Shutting down filesystem while write is running" >> $seqres.full
> +	_scratch_shutdown
> +
> +	kill $awloop_pid 2>/dev/null  # the process might have finished already
> +	wait $awloop_pid
> +	unset $awloop_pid
> +
> +	last_offset=$(tail -n 1 $tmp.aw | cut -d" " -f4)
> +	if [[ -z $last_offset ]]
> +	then
> +		last_offset=0
> +	fi
> +
> +	echo >> $seqres.full
> +	echo "# Last offset of atomic write: $last_offset" >> $seqres.full
> +
> +	rm $tmp.aw
> +	sleep 0.5
> +
> +	_scratch_cycle_mount
> +
> +	# we want to verify all blocks around which the shutdown happended
> +	verify_start=$(( last_offset - (awu_max * 5)))
> +	if [[ $verify_start < 0 ]]
> +	then
> +		verify_start=0
> +	fi
> +
> +	verify_end=$(( last_offset + (awu_max * 5)))
> +	if [[ "$verify_end" -gt "$filesize" ]]
> +	then
> +		verify_end=$filesize
> +	fi
> +}
> +
> +# test data integrity for file wiht written and unwritten mappings
> +test_data_integrity_mixed() {
> +	$XFS_IO_PROG -fc "truncate 0" $testfile >> $seqres.full
> +
> +	echo >> $seqres.full
> +	echo "# Creating testfile with mixed mappings" >> $seqres.full
> +	create_mixed_mappings $testfile $filesize
> +
> +	test_data_integrity
> +
> +	verify_data_blocks $verify_start $verify_end "$expected_data_old_mixed" "$expected_data_new"
> +}
> +
> +# test data integrity for file with completely written mappings
> +test_data_integrity_writ() {
> +	$XFS_IO_PROG -fc "truncate 0" $testfile >> $seqres.full
> +
> +	echo >> $seqres.full
> +	echo "# Creating testfile with fully written mapping" >> $seqres.full
> +	$XFS_IO_PROG -c "pwrite -b $filesize 0 $filesize" $testfile >> $seqres.full
> +	sync $testfile
> +
> +	test_data_integrity
> +
> +	verify_data_blocks $verify_start $verify_end "$expected_data_old_mapped" "$expected_data_new"
> +}
> +
> +# test data integrity for file with completely unwritten mappings
> +test_data_integrity_unwrit() {
> +	$XFS_IO_PROG -fc "truncate 0" $testfile >> $seqres.full
> +
> +	echo >> $seqres.full
> +	echo "# Creating testfile with fully unwritten mappings" >> $seqres.full
> +	$XFS_IO_PROG -c "falloc 0 $filesize" $testfile >> $seqres.full
> +	sync $testfile
> +
> +	test_data_integrity
> +
> +	verify_data_blocks $verify_start $verify_end "$expected_data_old_zeroes" "$expected_data_new"
> +}
> +
> +# test data integrity for file with no mappings
> +test_data_integrity_hole() {
> +	$XFS_IO_PROG -fc "truncate 0" $testfile >> $seqres.full
> +
> +	echo >> $seqres.full
> +	echo "# Creating testfile with no mappings" >> $seqres.full
> +	$XFS_IO_PROG -c "truncate $filesize" $testfile >> $seqres.full
> +	sync $testfile
> +
> +	test_data_integrity
> +
> +	verify_data_blocks $verify_start $verify_end "$expected_data_old_zeroes" "$expected_data_new"
> +}
> +
> +test_filesize_integrity() {
> +	$XFS_IO_PROG -c "truncate 0" $testfile >> $seqres.full
> +
> +	echo >> $seqres.full
> +	echo "# Performing extending atomic writes over file in background" >> $seqres.full
> +	atomic_write_loop &
> +	awloop_pid=$!
> +
> +	local i=0
> +	# Wait for atleast first write to be recorded or 10s
> +	while [ ! -f "$tmp.aw" -a $i -le 50 ]; do i=$((i + 1)); sleep 0.2; done
> +
> +	if [[ $i -gt 50 ]]
> +	then
> +		_fail "atomic write process took too long to start"
> +	fi
> +
> +	echo >> $seqres.full
> +	echo "# Shutting down filesystem while write is running" >> $seqres.full
> +	_scratch_shutdown
> +
> +	kill $awloop_pid 2>/dev/null  # the process might have finished already
> +	wait $awloop_pid
> +	unset $awloop_pid
> +
> +	local last_offset=$(tail -n 1 $tmp.aw | cut -d" " -f4)
> +	if [[ -z $last_offset ]]
> +	then
> +		last_offset=0
> +	fi
> +
> +	echo >> $seqres.full
> +	echo "# Last offset of atomic write: $last_offset" >> $seqres.full
> +	rm $tmp.aw
> +	sleep 0.5
> +
> +	_scratch_cycle_mount
> +	local filesize=$(_get_filesize $testfile)
> +	echo >> $seqres.full
> +	echo "# Filesize after shutdown: $filesize" >> $seqres.full
> +
> +	# To confirm that the write went atomically, we check:
> +	# 1. The last block should be a multiple of awu_max
> +	# 2. The last block should be the completely new data
> +
> +	if (( $filesize % $awu_max ))
> +	then
> +		echo "Filesize after shutdown ($filesize) not a multiple of atomic write unit ($awu_max)"
> +	fi
> +
> +	verify_start=$(( filesize - (awu_max * 5)))
> +	if [[ $verify_start < 0 ]]
> +	then
> +		verify_start=0
> +	fi
> +
> +	local verify_end=$filesize
> +
> +	# Here the blocks should always match new data hence, for simplicity of
> +	# code, just corrupt the $expected_data_old buffer so it never matches
> +	local expected_data_old="POISON"
> +	verify_data_blocks $verify_start $verify_end "$expected_data_old" "$expected_data_new"
> +}
> +
> +$XFS_IO_PROG -fc "truncate 0" $testfile >> $seqres.full
> +
> +dry_run
> +
> +echo >> $seqres.full
> +echo "# Populating expected data buffers" >> $seqres.full
> +populate_expected_data
> +
> +# Loop 20 times to shake out any races due to shutdown
> +for ((iter=0; iter<20; iter++))
> +do
> +	echo >> $seqres.full
> +	echo "------ Iteration $iter ------" >> $seqres.full
> +
> +	echo >> $seqres.full
> +	echo "# Starting data integrity test for atomic writes over mixed mapping" >> $seqres.full
> +	test_data_integrity_mixed
> +
> +	echo >> $seqres.full
> +	echo "# Starting data integrity test for atomic writes over fully written mapping" >> $seqres.full
> +	test_data_integrity_writ
> +
> +	echo >> $seqres.full
> +	echo "# Starting data integrity test for atomic writes over fully unwritten mapping" >> $seqres.full
> +	test_data_integrity_unwrit
> +
> +	echo >> $seqres.full
> +	echo "# Starting data integrity test for atomic writes over holes" >> $seqres.full
> +	test_data_integrity_hole
> +
> +	echo >> $seqres.full
> +	echo "# Starting filesize integrity test for atomic writes" >> $seqres.full
> +	test_filesize_integrity
> +done
> +
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/generic/1230.out b/tests/generic/1230.out
> new file mode 100644
> index 00000000..d01f54ea
> --- /dev/null
> +++ b/tests/generic/1230.out
> @@ -0,0 +1,2 @@
> +QA output created by 1230
> +Silence is golden
> -- 
> 2.49.0
> 
> 

