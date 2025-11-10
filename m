Return-Path: <linux-ext4+bounces-11738-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D461CC4893A
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Nov 2025 19:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCF15189331C
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Nov 2025 18:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD5D32ABCC;
	Mon, 10 Nov 2025 18:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJNJ9jmA"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D053632AAB4;
	Mon, 10 Nov 2025 18:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762799193; cv=none; b=V+de0hlDybf96KaAUNrvqu2KsgIy4sgA+wMUVZuPWMH9l3dg1bCFXos8RNTE45hufxpoVJggXjucwhX0qIsNlFVS1MBqIM0IMJtIeg8QNbDOZ2H4ooCL5ru5YGBgrJ/3m5+/1sgh5Tv5SEWbjCDCfkJ0q6dUWjOWPLLRZTFobAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762799193; c=relaxed/simple;
	bh=jfNBoCEc9S9hhcd9RqjPICLkTopKmY7m+H3XZV7JGBw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H0GwOiMm+wtsGFpzdE0oeBhLko8e8u8efaC+bH7oV3Mit0Rzqu+jtLp8pyHUKLM8i13VP+R9ypkPqMIrAqMyU7AMECI3QPGtOpu0tufcqx4/oYKkDCsXGXEQhQH9uCDzYRKBZVNoVm+rJJYTYHAPZau/B3DE6s8lgWlXxmyTnFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJNJ9jmA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 605A4C16AAE;
	Mon, 10 Nov 2025 18:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762799193;
	bh=jfNBoCEc9S9hhcd9RqjPICLkTopKmY7m+H3XZV7JGBw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=CJNJ9jmA4+Fbli/aKYUrvOugbH/5+HSqx7XCLVoEmSe+1NFjQOFvhbNu4IdBhA+dG
	 LVl7OkcdEG+tI90UA7v3b49hsCBs+yWfJh7whp+7DAeX36cf/G1Zb60+dQL8fzwpIx
	 rHq/xm1cOxJbOCyQQyyENjv24z5XejYBDI0Fv034PY2kplC8l5Lu3NkL0vAAIe6RLC
	 UX8UTgJ774TODmDUBsbCY6ZLDya1Ei5Bfsh2VVDZr1P0Vsz9EwAKXDADsVljImNAHh
	 k2GqXJiSaPs/pWSz16/CbcU2rUJsEOP00v8Uu+dbhCVSKEjhmZ7OTj2BdOUq41/PFq
	 AuqODehl9F7IQ==
Date: Mon, 10 Nov 2025 10:26:32 -0800
Subject: [PATCH 2/7] generic/778: fix severe performance problems
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, zlang@redhat.com
Cc: fstests@vger.kernel.org, fstests@vger.kernel.org,
 linux-ext4@vger.kernel.org
Message-ID: <176279909041.605950.16815410156483574567.stgit@frogsfrogsfrogs>
In-Reply-To: <176279908967.605950.2192923313361120314.stgit@frogsfrogsfrogs>
References: <176279908967.605950.2192923313361120314.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

This test takes 4800s to run, which is horrible.  AFAICT it starts out
by timing how much can be written atomically to a new file in 0.2
seconds, then scales up the file size by 3x.  On not very fast storage,
this can result in file_size being set to ~250MB on a 4k fsblock
filesystem.  That's about 64,000 blocks.

The next thing this test does is try to create a file of that size
(250MB) of alternating written and unwritten blocks.  For some reason,
it sets up this file by invoking xfs_io 64,000 times to write small
amounts of data, which takes 3+ minutes on the author's system because
exec overhead is pretty high when you do that.

As a result, one loop through the test takes almost 4 minutes.  The test
loops 20 times, so it runs for 80 minutes(!!) which is a really long
time.

So the first thing we do is observe that the giant slow loop is being
run as a single thread on an empty filesystem.  Most of the time the
allocator generates a mostly physically contiguous file.  We could
fallocate the whole file instead of fallocating one block every other
time through the loop.  This halves the setup time.

Next, we can also stuff the remaining pwrite commands into a bash array
and only invoke xfs_io once every 128x through the loop.  This amortizes
the xfs_io startup time, which reduces the test loop runtime to about 20
seconds.

Finally, replace the 20x loop with a _soak_loop_running 5x loop because
5 seems like enough.  Anyone who wants more can set TIME_FACTOR or
SOAK_DURATION to get more intensive testing.  On my system this cuts the
runtime to 75 seconds.

Cc: <fstests@vger.kernel.org> # v2025.10.20
Fixes: ca954527ff9d97 ("generic: Add sudden shutdown tests for multi block atomic writes")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 tests/generic/778 |   59 ++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 40 insertions(+), 19 deletions(-)


diff --git a/tests/generic/778 b/tests/generic/778
index 8cb1d8d4cad45d..7cfabc3a47a521 100755
--- a/tests/generic/778
+++ b/tests/generic/778
@@ -42,22 +42,28 @@ atomic_write_loop() {
 		# Due to sudden shutdown this can produce errors so just
 		# redirect them to seqres.full
 		$XFS_IO_PROG -c "open -fsd $testfile" -c "pwrite -S 0x61 -DA -V1 -b $size $off $size" >> /dev/null 2>>$seqres.full
-		echo "Written to offset: $off" >> $tmp.aw
-		off=$((off + $size))
+		echo "Written to offset: $((off + size))" >> $tmp.aw
+		off=$((off + size))
 	done
 }
 
 start_atomic_write_and_shutdown() {
 	atomic_write_loop &
 	awloop_pid=$!
+	local max_loops=100
 
 	local i=0
-	# Wait for at least first write to be recorded or 10s
-	while [ ! -f "$tmp.aw" -a $i -le 50 ]; do i=$((i + 1)); sleep 0.2; done
+	# Wait for at least first write to be recorded or too much time passes
+	while [ ! -f "$tmp.aw" -a $i -le $max_loops ]; do
+		i=$((i + 1))
+		sleep 0.2
+	done
 
-	if [[ $i -gt 50 ]]
+	cat $tmp.aw >> $seqres.full
+
+	if [[ $i -gt $max_loops ]]
 	then
-		_fail "atomic write process took too long to start"
+		_notrun "atomic write process took too long to start"
 	fi
 
 	echo >> $seqres.full
@@ -113,21 +119,34 @@ create_mixed_mappings() {
 	local off=0
 	local operations=("W" "U")
 
+	test $size_bytes -eq 0 && return
+
+	# fallocate the whole file once because preallocating single blocks
+	# with individual xfs_io invocations is really slow and the allocator
+	# usually gives out consecutive blocks anyway
+	$XFS_IO_PROG -f -c "falloc 0 $size_bytes" $file
+
+	local cmds=()
 	for ((i=0; i<$((size_bytes / blksz )); i++)); do
-		index=$(($i % ${#operations[@]}))
-		map="${operations[$index]}"
+		if (( i % 2 == 0 )); then
+			cmds+=(-c "pwrite -b $blksz $off $blksz")
+		fi
+
+		# batch the write commands into larger xfs_io invocations to
+		# amortize the fork overhead
+		if [ "${#cmds[@]}" -ge 128 ]; then
+			$XFS_IO_PROG "${cmds[@]}" "$file" >> /dev/null
+			cmds=()
+		fi
 
-		case "$map" in
-		    "W")
-			$XFS_IO_PROG -fc "pwrite -b $blksz $off $blksz" $file  >> /dev/null
-			;;
-		    "U")
-			$XFS_IO_PROG -fc "falloc $off $blksz" $file >> /dev/null
-			;;
-		esac
 		off=$((off + blksz))
 	done
 
+	if [ "${#cmds[@]}" -gt 0 ]; then
+		$XFS_IO_PROG "${cmds[@]}" "$file" >> /dev/null
+		cmds=()
+	fi
+
 	sync $file
 }
 
@@ -336,9 +355,9 @@ echo >> $seqres.full
 echo "# Populating expected data buffers" >> $seqres.full
 populate_expected_data
 
-# Loop 20 times to shake out any races due to shutdown
-for ((iter=0; iter<20; iter++))
-do
+# Loop to shake out any races due to shutdown
+iter=0
+while _soak_loop_running $TIME_FACTOR; do
 	echo >> $seqres.full
 	echo "------ Iteration $iter ------" >> $seqres.full
 
@@ -361,6 +380,8 @@ do
 	echo >> $seqres.full
 	echo "# Starting shutdown torn write test for append atomic writes" >> $seqres.full
 	test_append_torn_write
+
+	iter=$((iter + 1))
 done
 
 echo "Silence is golden"


