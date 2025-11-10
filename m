Return-Path: <linux-ext4+bounces-11739-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8755EC48943
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Nov 2025 19:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4597C3B355A
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Nov 2025 18:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FC332ABF6;
	Mon, 10 Nov 2025 18:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JbZbPqNe"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765513218B2;
	Mon, 10 Nov 2025 18:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762799209; cv=none; b=NeornkOlXNyAqjirS4gQAdOkQHdjENsi6LoagD9ex/Xnn7WGB4iEChtFbBV61/7JXrbol9Jg9NJD7/pdmbIHhCeQwBfkgIbJv2Ixm+3/1gNm0GtLbQlbPk3ICJ7Xqg/9NEijn7htP8E3dfADiMg894b9MPagpyc+Lc1Zbe/C5YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762799209; c=relaxed/simple;
	bh=uNRf4B+4FDhivv3veKgpbEP8PhYbfV4nLYqqXvisDIw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=il3KZJkGfE28MA2aEbgHoP3SsHR9C2YF6yhwVASkDMsuUNnNpKDirF8glqqE4VHACkToO4SuZBhaBDIYD0RTW+Uti6aOEy6cY1KISmfMspB6aNcj6EmqGnqlrk0+w0tZBGnqa/KiZM8W7sGP2zOHF0318KygsymjyZu98brXfwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JbZbPqNe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37445C116D0;
	Mon, 10 Nov 2025 18:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762799209;
	bh=uNRf4B+4FDhivv3veKgpbEP8PhYbfV4nLYqqXvisDIw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=JbZbPqNeXjS3+QZ9PADKeXSVw+b4sJDqZ5KE832HBHksj4yi8t8B2SjjGfMEqgLs1
	 NSooETmFobsStbJCG4qTtXWQ2RF4gUaCWYvCnCMbdjpFqVL1N8oYL9J9pPyX7vmnsi
	 02DS2ktnn4w4I2dBHCKzswuRoTcqzli+/6lKHgF3CbA5AQ45UNzQZOTlBCf1wkaPUL
	 GEnqyMLTp2Yyq03ChjLdhHXF4kLhYyhNM+ltIeJX0LMMVR52ZU1NjHb7qsr65LfF5d
	 9w7GZs9/xbNRVeFEA0rOGuZQ8usZinRsFFcwB4Vv3WN4jTBTUHgyK8XoZ5GoikvhgC
	 10mRaGbpYvVsA==
Date: Mon, 10 Nov 2025 10:26:48 -0800
Subject: [PATCH 3/7] generic/778: fix background loop control with sentinel
 files
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, zlang@redhat.com
Cc: fstests@vger.kernel.org, fstests@vger.kernel.org,
 linux-ext4@vger.kernel.org
Message-ID: <176279909060.605950.10294250986845341696.stgit@frogsfrogsfrogs>
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

This test fails on my slowish QA VM with 32k-fsblock xfs:

 --- /run/fstests/bin/tests/generic/778.out      2025-10-20 10:03:43.432910446 -0700
 +++ /var/tmp/fstests/generic/778.out.bad        2025-11-04 12:01:31.137813652 -0800
 @@ -1,2 +1,137 @@
  QA output created by 778
 -Silence is golden
 +umount: /opt: target is busy.
 +mount: /opt: /dev/sda4 already mounted on /opt.
 +       dmesg(1) may have more information after failed mount system call.
 +cycle mount failed
 +(see /var/tmp/fstests/generic/778.full for details)

Injecting a 'ps auxfww' into the _scratch_cycle_mount helper reveals
that this process is still sitting on /opt:

root     1804418  9.0  0.8 144960 134368 pts/0   Dl+  12:01   0:00 /run/fstests/xfsprogs/io/xfs_io -i -c open -fsd /opt/testfile -c pwrite -S 0x61 -DA -V1 -b 134217728 134217728 134217728

Yes, that's the xfs_io process started by atomic_write_loop.
Inexplicably, the awloop killing code terminates the subshell running
the for loop in atomic_write_loop but only waits for the subshell itself
to exit.  It doesn't wait for any of that subshell's children, and
that's why the unmount fails.

A bare "wait" (without the $awloop_pid parameter) also doesn't wait for
the xfs_io because the parent shell sees the subshell exit and treats
that as job completion.  We can't use killall here because the system
could be running check-parallel, nor can we use pkill here because the
pid namespace containment code was removed.

The simplest stupid answer is to use sentinel files to control the loop.

Cc: <fstests@vger.kernel.org> # v2025.10.20
Fixes: ca954527ff9d97 ("generic: Add sudden shutdown tests for multi block atomic writes")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 tests/generic/778 |   36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)


diff --git a/tests/generic/778 b/tests/generic/778
index 7cfabc3a47a521..715de458268ebc 100755
--- a/tests/generic/778
+++ b/tests/generic/778
@@ -21,6 +21,9 @@ _scratch_mount >> $seqres.full
 testfile=$SCRATCH_MNT/testfile
 touch $testfile
 
+awloop_runfile=$tmp.awloop_running
+awloop_killfile=$tmp.awloop_kill
+
 awu_max=$(_get_atomic_write_unit_max $testfile)
 blksz=$(_get_block_size $SCRATCH_MNT)
 echo "Awu max: $awu_max" >> $seqres.full
@@ -31,25 +34,48 @@ num_blocks=$((awu_max / blksz))
 filesize=$(( 10 * 1024 * 1024 * 1024 ))
 
 _cleanup() {
-	[ -n "$awloop_pid" ] && kill $awloop_pid &> /dev/null
-	wait
+	kill_awloop
 }
 
 atomic_write_loop() {
 	local off=0
 	local size=$awu_max
+
+	rm -f $awloop_killfile
+	touch $awloop_runfile
+
 	for ((i=0; i<$((filesize / $size )); i++)); do
 		# Due to sudden shutdown this can produce errors so just
 		# redirect them to seqres.full
 		$XFS_IO_PROG -c "open -fsd $testfile" -c "pwrite -S 0x61 -DA -V1 -b $size $off $size" >> /dev/null 2>>$seqres.full
+		if [ ! -w "$testfile" ] || [ -e "$awloop_killfile" ]; then
+			break
+		fi
 		echo "Written to offset: $((off + size))" >> $tmp.aw
 		off=$((off + size))
 	done
+
+	rm -f $awloop_runfile
+}
+
+# Use sentinel files to control the loop execution because we don't know the
+# pid of the xfs_io process and so we can't wait for it directly.  A bare
+# wait command won't wait for a D-state xfs_io process so we can't do that
+# either.  We can't use killall because check-parallel, and we can't pkill
+# because the pid namespacing code was removed withotu fixing check-parallel.
+kill_awloop() {
+	test -e $awloop_runfile || return
+
+	touch $awloop_killfile
+
+	for ((i=0;i<300;i++)); do
+		test -e $awloop_runfile || break
+		sleep 0.1
+	done
 }
 
 start_atomic_write_and_shutdown() {
 	atomic_write_loop &
-	awloop_pid=$!
 	local max_loops=100
 
 	local i=0
@@ -70,9 +96,7 @@ start_atomic_write_and_shutdown() {
 	echo "# Shutting down filesystem while write is running" >> $seqres.full
 	_scratch_shutdown
 
-	kill $awloop_pid 2>/dev/null  # the process might have finished already
-	wait $awloop_pid
-	unset $awloop_pid
+	kill_awloop
 }
 
 # This test has the following flow:


