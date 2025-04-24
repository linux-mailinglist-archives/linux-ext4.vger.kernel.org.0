Return-Path: <linux-ext4+bounces-7475-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C81A9BA0D
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 23:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 527E116C75C
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 21:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5BF21FF2C;
	Thu, 24 Apr 2025 21:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UcraiIWc"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64BD198851
	for <linux-ext4@vger.kernel.org>; Thu, 24 Apr 2025 21:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745530972; cv=none; b=T3W5k9r2hPxLTCdz84CtyXWTE+6tc8QTNND0ep2CN3jfkRW+n3p5t/hZZ6UboI00dIKiuMcXpRKedUmsi4vE2k+LW9Y+Bm4VFuqvXGM5pYMbwd94KbEUjQcZFi9CxUV8fb1pgCjzmjUUCP4olt4+WW8jQUogbC0DGPaD1brJi2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745530972; c=relaxed/simple;
	bh=D3geD668dYQCYWALjajm4BVmx4d0jul3yq8hsw1QP1M=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lmRKXkDGoiLENz+RG5zHnuAinuzG9rXkzTqQe1xDShDRB0mCMgk2p6Qef6CRcnHb6XS5JClgyc8nYXqSnbBPiS+FALyz/TvTOlXwWI1FeWEcmHXURhe5Lgrwks1dx6gZzKGQylyFl6tmo649o0X0XND29IwaBH1CsQgmY3OIdRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UcraiIWc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DBA5C4CEE3;
	Thu, 24 Apr 2025 21:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745530972;
	bh=D3geD668dYQCYWALjajm4BVmx4d0jul3yq8hsw1QP1M=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=UcraiIWc8hX7yCzQv1ZkUUmU5ekPfpBnGtNr9/613nttI03IqZwEy6L1MJOGnAsvq
	 p0xyGc6nIUtiMRWItQ6tJac+jOb5D0FFLVLcqP3NcL+wrzJnVKeQCBY+mC2c/a9HLq
	 E8u6dOGKipuGNqxoBRhSOkH/Cuc+n7ZLoZqlSAjtpBsOLjOsNAhPO+AglhEEy3lrUv
	 U3fqAeWg6P4yn3MSrjNV3NEO43cnHZSgE3PXoJ/PeGHgwbZ6odIq5h576uSsVqD80j
	 SNhjypABnEZepzUfM+1NwILaJ+Ub9h1bwNYkoQKrukv42WkQgOSS83ovihZGsyf078
	 GAnH+zptVifVA==
Date: Thu, 24 Apr 2025 14:42:52 -0700
Subject: [PATCH 08/16] fuse2fs: clamp timestamps that are being written to
 disk
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174553065069.1160461.14751120886781323020.stgit@frogsfrogsfrogs>
In-Reply-To: <174553064857.1160461.865616278603382583.stgit@frogsfrogsfrogs>
References: <174553064857.1160461.865616278603382583.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Clamp the timestamps that we write to disk to the minimum and maximum
values permitted given the ondisk format.  This fixes y2038 support, as
tested by generic/402.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/ext2fs/ext2_fs.h |    4 ++++
 misc/fuse2fs.c       |   39 ++++++++++++++++++++++++++++++++-------
 2 files changed, 36 insertions(+), 7 deletions(-)


diff --git a/lib/ext2fs/ext2_fs.h b/lib/ext2fs/ext2_fs.h
index 3a5eb7387d0c9d..fcd42055665788 100644
--- a/lib/ext2fs/ext2_fs.h
+++ b/lib/ext2fs/ext2_fs.h
@@ -801,6 +801,10 @@ struct ext2_super_block {
 
 #define EXT2_GOOD_OLD_INODE_SIZE 128
 
+#define EXT4_EXTRA_TIMESTAMP_MAX	(((int64_t)1 << 34) - 1  + INT32_MIN)
+#define EXT4_NON_EXTRA_TIMESTAMP_MAX	INT32_MAX
+#define EXT4_TIMESTAMP_MIN		INT32_MIN
+
 /*
  * Journal inode backup types
  */
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index bf4e592e7d2782..9cf8c59b8b88ee 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -227,21 +227,43 @@ static inline void ext4_decode_extra_time(struct timespec *time, __u32 extra)
 	time->tv_nsec = ((extra) & EXT4_NSEC_MASK) >> EXT4_EPOCH_BITS;
 }
 
+#define EXT4_CLAMP_TIMESTAMP(xtime, timespec, raw_inode)		       \
+do {									       \
+	if ((timespec)->tv_sec < EXT4_TIMESTAMP_MIN)			       \
+		(timespec)->tv_sec = EXT4_TIMESTAMP_MIN;		       \
+	if ((timespec)->tv_sec < EXT4_TIMESTAMP_MIN)			       \
+		(timespec)->tv_sec = EXT4_TIMESTAMP_MIN;		       \
+									       \
+	if (EXT4_FITS_IN_INODE(raw_inode, xtime ## _extra)) {		       \
+		if ((timespec)->tv_sec > EXT4_EXTRA_TIMESTAMP_MAX)	       \
+			(timespec)->tv_sec = EXT4_EXTRA_TIMESTAMP_MAX;	       \
+	} else {							       \
+		if ((timespec)->tv_sec > EXT4_NON_EXTRA_TIMESTAMP_MAX)	       \
+			(timespec)->tv_sec = EXT4_NON_EXTRA_TIMESTAMP_MAX;     \
+	}								       \
+} while (0)
+
 #define EXT4_INODE_SET_XTIME(xtime, timespec, raw_inode)		       \
 do {									       \
-	(raw_inode)->xtime = (timespec)->tv_sec;			       \
+	typeof(*(timespec)) _ts = *(timespec);				       \
+									       \
+	EXT4_CLAMP_TIMESTAMP(xtime, &_ts, raw_inode);			       \
+	(raw_inode)->xtime = _ts.tv_sec;				       \
 	if (EXT4_FITS_IN_INODE(raw_inode, xtime ## _extra))		       \
 		(raw_inode)->xtime ## _extra =				       \
-				ext4_encode_extra_time(timespec);	       \
+				ext4_encode_extra_time(&_ts);		       \
 } while (0)
 
 #define EXT4_EINODE_SET_XTIME(xtime, timespec, raw_inode)		       \
 do {									       \
+	typeof(*(timespec)) _ts = *(timespec);				       \
+									       \
+	EXT4_CLAMP_TIMESTAMP(xtime, &_ts, raw_inode);			       \
 	if (EXT4_FITS_IN_INODE(raw_inode, xtime))			       \
-		(raw_inode)->xtime = (timespec)->tv_sec;		       \
+		(raw_inode)->xtime = _ts.tv_sec;			       \
 	if (EXT4_FITS_IN_INODE(raw_inode, xtime ## _extra))		       \
 		(raw_inode)->xtime ## _extra =				       \
-				ext4_encode_extra_time(timespec);	       \
+				ext4_encode_extra_time(&_ts);		       \
 } while (0)
 
 #define EXT4_INODE_GET_XTIME(xtime, timespec, raw_inode)		       \
@@ -2884,7 +2906,10 @@ static int op_utimens(const char *path, const struct timespec ctv[2]
 		ret = translate_error(fs, 0, err);
 		goto out;
 	}
-	dbg_printf(ff, "%s: ino=%d\n", __func__, ino);
+	dbg_printf(ff, "%s: ino=%d atime=%lld.%ld mtime=%lld.%ld\n", __func__,
+			ino,
+			(long long int)ctv[0].tv_sec, ctv[0].tv_nsec,
+			(long long int)ctv[1].tv_sec, ctv[1].tv_nsec);
 
 	ret = check_inum_access(fs, ino, W_OK);
 	if (ret)
@@ -2908,9 +2933,9 @@ static int op_utimens(const char *path, const struct timespec ctv[2]
 #endif /* UTIME_NOW */
 #ifdef UTIME_OMIT
 	if (tv[0].tv_nsec != UTIME_OMIT)
-		EXT4_INODE_SET_XTIME(i_atime, tv, &inode);
+		EXT4_INODE_SET_XTIME(i_atime, &tv[0], &inode);
 	if (tv[1].tv_nsec != UTIME_OMIT)
-		EXT4_INODE_SET_XTIME(i_mtime, tv + 1, &inode);
+		EXT4_INODE_SET_XTIME(i_mtime, &tv[1], &inode);
 #endif /* UTIME_OMIT */
 	ret = update_ctime(fs, ino, &inode);
 	if (ret)


