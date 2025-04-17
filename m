Return-Path: <linux-ext4+bounces-7328-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AE5A92C6F
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Apr 2025 22:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 749EA4A2A0A
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Apr 2025 20:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECAF20A5D3;
	Thu, 17 Apr 2025 20:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCbSGp4S"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB572063D8;
	Thu, 17 Apr 2025 20:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744923392; cv=none; b=S3qTqSGwKeqCfUVWfM+a2lmvVBiMHmyVOF/CGfqHyMHGkx5kSRJ0vj5SiGuGYNebTBgTh4bktNMdv58zpsT/snnvVO9Ey8mxrbcSHsTI16Ul3SUq0BpQMjGStFrApBqsca1s5nw8MYAiXZk7ymVjtd01dPC1wIXLUQCE6UFnOX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744923392; c=relaxed/simple;
	bh=IA6ElAAByoJ4UUnxt/+JefawSXUyewS5YypI8gyRNyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ijb8TJO2R6tVZx8RYee3Xd/NaqceMDQ7a7kHHrkqMbwE17AP6X1YvxIQ5hB2z59IpvzqD79Aj6KzKE9H/gjnqCG4QrnBmXSoDgdukexqroxwkMKojuuFKawIXOtP9CwSZ46T6C0eul7tWu51W1TxhNecHG1G8bil/ldTc1xCxL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCbSGp4S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C75C4CEE4;
	Thu, 17 Apr 2025 20:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744923391;
	bh=IA6ElAAByoJ4UUnxt/+JefawSXUyewS5YypI8gyRNyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eCbSGp4SmNvmXvwXhyBj1rFRbtptkrnX3OcJXIlP+rqEdEv6f2rt3osU1NzDK/Anu
	 LVUpBHrqfd8sCQMWqhYezEJIDqVvWuM1mNMMLsbgkw/McY8EgvC5F1yIisseFPz5kG
	 I35d2T/CH4g3UIa1L2SmPuqI5mjmz+UFQhoNrOHjwd8vi/jQ6VSBagdpyNEzYRB5Mc
	 uMRU4l0DLVgKrlEzWfIq0GFQxZvBt8mF0k39zFuWzXvgA22tcCsp9D1ilqonVbK1+E
	 Lb2RI5zhXS3RLUaBnQTFlPRfyF3vZtfD5HTkZOaE4RdFZtLB6SaBBA3vvmOdBv8Jcc
	 mSwPdW+Ol/yOg==
Date: Thu, 17 Apr 2025 13:56:29 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: "Darrick J. Wong" <djwong@kernel.org>, adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org, kdevops@lists.linux.dev,
	dave@stgolabs.net, jack@suse.cz
Subject: Re: ext4 v6.15-rc2 baseline
Message-ID: <aAFq_bef9liguosY@bombadil.infradead.org>
References: <Z__vQcCF9xovbwtT@bombadil.infradead.org>
 <20250416233415.GA3779528@mit.edu>
 <20250417163820.GA25655@frogsfrogsfrogs>
 <20250417183711.GB6008@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417183711.GB6008@mit.edu>

On Thu, Apr 17, 2025 at 01:37:11PM -0500, Theodore Ts'o wrote:
> 
> On Thu, Apr 17, 2025 at 09:38:20AM -0700, Darrick J. Wong wrote:
> > 
> > generic/04[456] fail with a bunch of...
> 
> Yeah, this is known.   I have an ext4-specific exclude file:
> 
> // generic/04[456] tests how truncate and delayed allocation works
> // ext4 uses the data=ordered to avoid exposing stale data, and
> // so it uses a different mechanism than xfs.  So these tests will fail
> generic/044
> generic/045
> generic/046

Perhaps something like (not tested):

From a9386348701e387942e3eaaef8ee9daac8ace16a Mon Sep 17 00:00:00 2001
From: Luis Chamberlain <mcgrof@kernel.org>
Date: Thu, 17 Apr 2025 13:54:25 -0700
Subject: [PATCH] ext4: add ordered requirement for generic/04[456]

generic/04[456] tests how truncate and delayed allocation works.
ext4 uses the data=ordered to avoid exposing stale data, and
so it uses a different mechanism than xfs. So these tests will fail
on it.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 common/rc         | 19 +++++++++++++++++++
 tests/generic/044 |  1 +
 tests/generic/045 |  1 +
 tests/generic/046 |  1 +
 4 files changed, 22 insertions(+)

diff --git a/common/rc b/common/rc
index 9bed6dad9303..dd640c70f428 100644
--- a/common/rc
+++ b/common/rc
@@ -4495,6 +4495,25 @@ _exclude_test_mount_option()
 	_exclude_mount_option "$TEST_FS_MOUNT_OPTS" $@
 }
 
+_require_scratch_mount_ordered()
+{
+	[ "$FSTYP" = "ext4" ] || return
+
+	_require_scratch
+
+	local ordered_set=false
+	for opt in $(_normalize_mount_options "$MOUNT_OPTIONS"); do
+		case "$opt" in
+			data=ordered)
+				ordered_set=true
+				break
+				;;
+		esac
+	done
+
+	$ordered_set || _notrun "Test requires ext4 with data=ordered mount option"
+}
+
 _require_atime()
 {
 	_exclude_scratch_mount_option "noatime"
diff --git a/tests/generic/044 b/tests/generic/044
index 5d21875cf772..b596f66d07e8 100755
--- a/tests/generic/044
+++ b/tests/generic/044
@@ -19,6 +19,7 @@ _require_xfs_io_command "fiemap"
 _scratch_mkfs >/dev/null 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _scratch_mount
+_require_scratch_mount_ordered
 
 # create files
 i=1;
diff --git a/tests/generic/045 b/tests/generic/045
index 9904142f89ac..3ee59642239c 100755
--- a/tests/generic/045
+++ b/tests/generic/045
@@ -19,6 +19,7 @@ _require_xfs_io_command "fiemap"
 _scratch_mkfs >/dev/null 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _scratch_mount
+_require_scratch_mount_ordered
 
 # create files
 i=1;
diff --git a/tests/generic/046 b/tests/generic/046
index 5ed60c762fe8..9e77bd9573af 100755
--- a/tests/generic/046
+++ b/tests/generic/046
@@ -19,6 +19,7 @@ _require_xfs_io_command "fiemap"
 _scratch_mkfs >/dev/null 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 _scratch_mount
+_require_scratch_mount_ordered
 
 # create files
 i=1;
-- 
2.47.2

