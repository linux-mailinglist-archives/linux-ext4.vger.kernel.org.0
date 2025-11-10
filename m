Return-Path: <linux-ext4+bounces-11741-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D3183C48967
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Nov 2025 19:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3C37A4F208D
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Nov 2025 18:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F2D32D43F;
	Mon, 10 Nov 2025 18:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNQ8BC4u"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54A532D42A;
	Mon, 10 Nov 2025 18:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762799240; cv=none; b=WF/Km/2FO8zJbdjRZVuFOWZyW1n44umUj99qbFMWLb5ezQgGwDkbDXJKS269zkTUxf9tXmf7HW4SLAV19PE/jOGeCSXWJpX2xAVllqOJQhlRUJ1ovYjQ4tSegQ9BSost0XnpVTmWyzxHAhcBSb0mVjE7VbdOxVMutzJm09horMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762799240; c=relaxed/simple;
	bh=JANc0HPJbbkLnf0amNCf7eVJbSOLEo0QqDUcPzvVUhk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o6KjbalZAiA2oknwPD0HXHHetIjAdXkWvCVheA8zzk1PgoDbz9/HjQd2a/y/DqL+FwJh3c2h9a4mAoK+Pry7/k8H7CG7uS+DC5BHUlqjnEAHkonEpkAw9kvo90LmKZTJ5QUYAvMVpOWAkmBAKXp2tPoVdLxLmdz0BzwOSGIbKuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNQ8BC4u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E091C19425;
	Mon, 10 Nov 2025 18:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762799240;
	bh=JANc0HPJbbkLnf0amNCf7eVJbSOLEo0QqDUcPzvVUhk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=CNQ8BC4ut1T74qWTcdakaFrBoea8you+afKEea8Z6XSBw4zxJmHehYwI9EFN0ww6k
	 G9mFel8a5n+YVsYGWQII2wVygHIxzAskb78MqjHWj6m3AVWpXNG4/Dk2QeN73sW5eb
	 oxEhGWZ5E/9chhpy3RNg5vpLdToGI2ZoYBdzPgozbnOLBDWw03E5c6eIDv8IeHEIav
	 6HZRWMNZcfbHGJsj5KTIjgR2gn+MRqBbMjbsk/TprXArcLFVkGKO7tU0ryquWM0K6f
	 +xLhp54JfopZZ5MNs6mMhKOzqplfsathWI0MPoRbt+pRmkRn/k9LR4vEv7oDQBsYhM
	 c+Y4w8AtCEkBw==
Date: Mon, 10 Nov 2025 10:27:20 -0800
Subject: [PATCH 5/7] xfs/837: fix test to work with pre-metadir quota mount
 options
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, zlang@redhat.com
Cc: fstests@vger.kernel.org, fstests@vger.kernel.org,
 linux-ext4@vger.kernel.org
Message-ID: <176279909097.605950.5129078568168785441.stgit@frogsfrogsfrogs>
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

Prior to metadir, xfs users always had to supply quota mount options to
get quota functionality, even if the mount options match the ondisk
superblock's qflag state.  The kernel, in turn, required a writable
filesystem if any mount options were specified.  As a result, this test
fails on those old filesystems because the _scratch_mount fails.

Metadir filesystems reuse whatever's in qflags if no mount options are
supplied, so we don't need them in MOUNT_OPTS anymore.

Change the _scratch_mount to _try_scratch_mount and add configurable
golden output to handle this case.

Cc: <fstests@vger.kernel.org> # v2025.06.22
Fixes: e225772353e212 ("xfs: add mount test for read only rt devices")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 tests/xfs/837              |   28 ++++++++++++++++++++--------
 tests/xfs/837.cfg          |    1 +
 tests/xfs/837.out.default  |    0 
 tests/xfs/837.out.oldquota |    6 ++++++
 4 files changed, 27 insertions(+), 8 deletions(-)
 create mode 100644 tests/xfs/837.cfg
 rename tests/xfs/{837.out => 837.out.default} (100%)
 create mode 100644 tests/xfs/837.out.oldquota


diff --git a/tests/xfs/837 b/tests/xfs/837
index 61e51d3a7d0e81..2fe195a009f10f 100755
--- a/tests/xfs/837
+++ b/tests/xfs/837
@@ -8,6 +8,7 @@
 # Check out various mount/remount/unmount scenarious on a read-only rtdev
 # Based on generic/050
 #
+seqfull=$0
 . ./common/preamble
 _begin_fstest mount auto quick
 
@@ -36,6 +37,17 @@ _register_cleanup "_cleanup_setrw"
 
 _scratch_mkfs "-d rtinherit" > /dev/null 2>&1
 
+# Select appropriate output file
+features=""
+if ! _xfs_has_feature "$SCRATCH_DEV" metadir && echo "$MOUNT_OPTIONS" | grep -q quota ; then
+	# Mounting with quota mount options on a non-metadir fs requires a
+	# writable fs because the kernel requires write access even if the
+	# mount options match the superblock qflags.  This means we expect to
+	# fail the ro blockdev test with with EPERM.
+	features="oldquota"
+fi
+_link_out_file "$features"
+
 #
 # Mark the rt device read-only.
 #
@@ -46,20 +58,20 @@ blockdev --setro $SCRATCH_RTDEV
 # Mount it and make sure it can't be written to.
 #
 echo "mounting read-only rt block device:"
-_scratch_mount 2>&1 | _filter_ro_mount | _filter_scratch
+_try_scratch_mount 2>&1 | _filter_ro_mount | _filter_scratch
 if [ "${PIPESTATUS[0]}" -eq 0 ]; then
 	echo "writing to file on read-only filesystem:"
 	dd if=/dev/zero of=$SCRATCH_MNT/foo bs=1M count=1 oflag=direct 2>&1 | _filter_scratch
+
+	echo "remounting read-write:"
+	_scratch_remount rw 2>&1 | _filter_scratch | _filter_ro_mount
+
+	echo "unmounting read-only filesystem"
+	_scratch_unmount 2>&1 | _filter_scratch | _filter_ending_dot
 else
-	_fail "failed to mount"
+	echo "failed to mount"
 fi
 
-echo "remounting read-write:"
-_scratch_remount rw 2>&1 | _filter_scratch | _filter_ro_mount
-
-echo "unmounting read-only filesystem"
-_scratch_unmount 2>&1 | _filter_scratch | _filter_ending_dot
-
 # success, all done
 echo "*** done"
 status=0
diff --git a/tests/xfs/837.cfg b/tests/xfs/837.cfg
new file mode 100644
index 00000000000000..01456b2fa80f04
--- /dev/null
+++ b/tests/xfs/837.cfg
@@ -0,0 +1 @@
+oldquota: oldquota
diff --git a/tests/xfs/837.out b/tests/xfs/837.out.default
similarity index 100%
rename from tests/xfs/837.out
rename to tests/xfs/837.out.default
diff --git a/tests/xfs/837.out.oldquota b/tests/xfs/837.out.oldquota
new file mode 100644
index 00000000000000..1383b4440dd8ee
--- /dev/null
+++ b/tests/xfs/837.out.oldquota
@@ -0,0 +1,6 @@
+QA output created by 837
+setting device read-only
+mounting read-only rt block device:
+mount: SCRATCH_MNT: permission denied
+failed to mount
+*** done


