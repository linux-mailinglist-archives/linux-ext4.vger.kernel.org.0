Return-Path: <linux-ext4+bounces-7681-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4580AA9A76
	for <lists+linux-ext4@lfdr.de>; Mon,  5 May 2025 19:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D3103BE05A
	for <lists+linux-ext4@lfdr.de>; Mon,  5 May 2025 17:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A8D2701BC;
	Mon,  5 May 2025 17:27:45 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9D32701AA
	for <linux-ext4@vger.kernel.org>; Mon,  5 May 2025 17:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746466065; cv=none; b=qIK+F5dnYxPhnceLWpo/Jy/BxIVm5pPaNijy0GMtq+9Mx0AR1brpXuI6TQQNj9pj8xBEVU/W8Iwhx4r5he592rjXhwjcXTh6tMNlL3kqm54a89qWTCT2UwkdZnM2EbXm400T8vGpkA6HKv0/IdF4k0c1n4EXByYpBLN7wAhlsmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746466065; c=relaxed/simple;
	bh=C6h2luvRc6hxvf4jxR5PXLOzkViw6W6tou5w95NxzH8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HvCgFwNmZwTpnWuV3kMZGLe8TVQiNE+VGjb2OQ3P0NkI8mgGBpXBOKlZqkKvVwXz348yjBozcdFkn+ZFcc4Dqf7PVdacZYVU+0URqsLKhLNEhKYHevydB6O5ZMFjN+qOXnQBtVGawWJdFQ6U52OfGnX0HHtRpPDGtj8ZGr02Thg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-148.bstnma.fios.verizon.net [173.48.82.148])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 545HRXEX018683
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 May 2025 13:27:34 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id B0B5C2E00E9; Mon, 05 May 2025 13:27:33 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH -e2fsprogs] mke2fs: don't set the raid stripe for non-rotational devices by default
Date: Mon,  5 May 2025 13:27:32 -0400
Message-ID: <20250505172732.570955-1-tytso@mit.edu>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ext4 block allocator is not at all efficient when it is asked to
enforce RAID alignment.  It is especially bad for flash-based devices,
or when the file system is highly fragmented.  For non-rotational
devices, it's fine to set the stride parameter (which controls
spreading the allocation bitmaps across the RAID component devices,
which always makessense); but for the stripe parameter (which asks the
ext4 block alocator to try _very_ hard to find RAID stripe aligned
devices) it's probably not a good idea.

Add new mke2fs.conf parameters with the defaults:

[defaults]
   set_raid_stride = always
   set_raid_stripe = disk

Even for RAID arrays based on HDD's, we can still have problems for
highly fragmented file systems.  This will need to solved in the
kernel, probably by having some kind of wall clock or CPU time
limitation for each block allocation or adding some kind of
optimization which is faster than using our current buddy bitmap
implementation, especially if the stripe size is not multiple of a
power of two.  But for SSD's, it's much less likely to make sense even
if we have an optimized block allocator, because if you've paid $$$
for a flash-based RAID array, the cost/benefit tradeoffs of doing less
optimized stripe RMW cycles versus the block allocator time and CPU
overhead is harder to justify without a lot of optimization effort.

If and when we can improve the ext4 kernel implementation (and it gets
rolled out to users using LTS kernels), we can change the defaults.
And of course, system administrators can always change
/etc/mke2fs.conf settings.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 misc/mke2fs.c         | 73 +++++++++++++++++++++++++++++++++++++++++--
 misc/mke2fs.conf.5.in | 18 +++++++++++
 2 files changed, 88 insertions(+), 3 deletions(-)

diff --git a/misc/mke2fs.c b/misc/mke2fs.c
index f24076bc1..dfb4405a7 100644
--- a/misc/mke2fs.c
+++ b/misc/mke2fs.c
@@ -46,6 +46,9 @@ extern int optind;
 #ifdef HAVE_SYS_IOCTL_H
 #include <sys/ioctl.h>
 #endif
+#ifdef HAVE_SYS_SYSMACROS_H
+#include <sys/sysmacros.h>
+#endif
 #include <libgen.h>
 #include <limits.h>
 #include <blkid/blkid.h>
@@ -1571,6 +1574,36 @@ struct device_param {
 };
 
 #ifdef HAVE_BLKID_PROBE_GET_TOPOLOGY
+static int is_rotational (const char *device_name EXT2FS_ATTR((unused)))
+{
+	int		rotational = -1;
+#ifdef __linux__
+	char		path[1024];
+	struct stat	st;
+	FILE		*f;
+
+	if ((stat(device_name, &st) < 0) || !S_ISBLK(st.st_mode))
+		return -1;
+
+	snprintf(path, sizeof(path), "/sys/dev/block/%d:%d/queue/rotational",
+		major(st.st_rdev), minor(st.st_rdev));
+	f = fopen(path, "r");
+	if (!f) {
+		snprintf(path, sizeof(path),
+			"/sys/dev/block/%d:%d/../queue/rotational",
+			major(st.st_rdev), minor(st.st_rdev));
+		f = fopen(path, "r");
+	}
+	if (f) {
+		if (fscanf(f, "%d", &rotational) != 1)
+			rotational = -1;
+		fclose(f);
+	}
+#endif
+	return rotational;
+}
+
+
 /*
  * Sets the geometry of a device (stripe/stride), and returns the
  * device's alignment offset, if any, or a negative error.
@@ -2429,13 +2462,47 @@ profile_error:
 			_("warning: Unable to get device geometry for %s\n"),
 			device_name);
 	} else {
+		int set_stripe, set_stride, rotational;
+
 		/* setting stripe/stride to blocksize is pointless */
-		if (dev_param.min_io > (unsigned) blocksize)
+		set_stride = dev_param.min_io > (unsigned) blocksize;
+		set_stripe = dev_param.opt_io > (unsigned) blocksize;
+		rotational = is_rotational(device_name) != 0;
+
+		/*
+		 * allow mke2fs.conf settings to control whether the
+		 * raid stripe/stride is set.  The default is to
+		 * always set the stride regardless of whether the
+		 * storage device is using HDD's or SSD's.  But only
+		 * set the stripe size if the storage device is
+		 * HDD-based by default because the ext4's block
+		 * allocator is very inefficient and especially for
+		 * SSD-based RAID arrays, trying to do raid-aligned
+		 * allocations is not worth it.
+		 */
+		tmp = get_string_from_profile(fs_types, "set_raid_stride",
+					      "always");
+		if (tmp && *tmp) {
+			if ((strcmp(tmp, "never") == 0) ||
+			    ((strcmp(tmp, "always") != 0) && !rotational))
+				set_stride = 0;
+		}
+		free(tmp);
+
+		tmp = get_string_from_profile(fs_types, "set_raid_stripe",
+					      "disk");
+		if (tmp && *tmp) {
+			if ((strcmp(tmp, "never") == 0) ||
+			    ((strcmp(tmp, "always") != 0) && !rotational))
+				set_stripe = 0;
+		}
+		free(tmp);
+
+		if (set_stride)
 			fs_param.s_raid_stride = dev_param.min_io / blocksize;
-		if (dev_param.opt_io > (unsigned) blocksize) {
+		if (set_stripe)
 			fs_param.s_raid_stripe_width =
 						dev_param.opt_io / blocksize;
-		}
 
 		if (dev_param.alignment_offset) {
 			printf(_("%s alignment is offset by %lu bytes.\n"),
diff --git a/misc/mke2fs.conf.5.in b/misc/mke2fs.conf.5.in
index 96dbfcbf8..629d1e1d0 100644
--- a/misc/mke2fs.conf.5.in
+++ b/misc/mke2fs.conf.5.in
@@ -438,6 +438,24 @@ This boolean relation specifies whether the
 .BR mke2fs (8)
 should attempt to discard device prior to file system creation.
 .TP
+.I set_raid_stride
+This relation specifies whether the file sytem's RAID stride size is set
+from the block device if available.  Valid values are:
+.IR always ,
+.IR disk ,
+.IR never .
+The default value is
+.IR always .
+.TP
+.I set_raid_stripe
+This relation specifies whether the file sytem's RAID stripe size is set
+from the block device if available.  Valid values are:
+.IR always ,
+.IR disk ,
+.IR never .
+The default value is
+.IR disk .
+.TP
 .I cluster_size
 This relation specifies the default cluster size if the bigalloc file
 system feature is enabled.  It can be overridden via the
-- 
2.47.2


