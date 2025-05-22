Return-Path: <linux-ext4+bounces-8140-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2EEAC0105
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 02:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 199204E78D8
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5545D64D;
	Thu, 22 May 2025 00:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RfGs/Ona"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBA8383
	for <linux-ext4@vger.kernel.org>; Thu, 22 May 2025 00:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747872477; cv=none; b=SMYPhCtXRmYtLp0XlHEKMOZlEWXoXtcOjHx5gQSZp/WQ3r/iu53cCeEPqltKHRVv2GYWn78F5bcRXIuk/DNTcGvTOEkRiMheae+iCO4KZOnhNJCPlBpScN9MDaUH8+grgb0pnlEGEV5yNk5JxEe3OW6OtYPRVfVUuu+ZqB5OIjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747872477; c=relaxed/simple;
	bh=Td4W/QFGYqNDbWyuirkXECNEJWTiHpnFE/r8vjyGs1A=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lcTtEKgi+MV0DgDVLvb1TCl7L8ENBjL4fsMDaQIo5TOhtYW0GLUe1Yzbb5xVO94HJRmTP2n9r+Q9Ab5T4rMNjpncnQzGEsR55ii1mLJkQ9GEFzuiUjhWAxZQ9M5B48S5chiN6VknSsPJbBsMpa7PL5CR57xn8nm21Rh9w6jcpIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RfGs/Ona; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4C4DC4CEE4;
	Thu, 22 May 2025 00:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747872476;
	bh=Td4W/QFGYqNDbWyuirkXECNEJWTiHpnFE/r8vjyGs1A=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=RfGs/OnayEGepq7QVcKqdgfrehCSBuDUHnLUrrDqmm5kcGwk/o7Lxyf+fmu98Mkt5
	 J9CzyoE/A1ohy4j8d7IJH+55nunOPvt8Rp/F3qhxdQ7c0ctEdh9RYPfh+AhBoCifMa
	 w/VasvYSATBSHPhJahMVv46mYkKu/Br+0MJh/env1qaZOz3B3Ddog6vHQokpExEmHx
	 /rtSf6fJyQ+GtbAAPzZl/XgXQ3N4h7UzMSmnylAJu5aVzhq9iXe0Q05GSZr925Fdlu
	 /y64xbSBcUbhZ4ZHmJAZNBHdKEAdA2ah8p9i6JGQdk1J8kIzbYihkn1OkwoFvC0kQB
	 CNHie+TtywQ0Q==
Date: Wed, 21 May 2025 17:07:56 -0700
Subject: [PATCH 2/3] fuse2fs: wrap the fuse_set_feature_flag helper for older
 libfuse
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174787197879.1484400.15421415902148671315.stgit@frogsfrogsfrogs>
In-Reply-To: <174787197833.1484400.960875804610238864.stgit@frogsfrogsfrogs>
References: <174787197833.1484400.960875804610238864.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Create a compatibility wrapper for fuse_set_feature_flag if the libfuse
version is older than the one where that function was introduced (3.17).

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 9667f00e366a66..6137fc04198d39 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -932,6 +932,19 @@ static void op_destroy(void *p EXT2FS_ATTR((unused)))
 	}
 }
 
+#if FUSE_VERSION < FUSE_MAKE_VERSION(3, 17)
+static inline int fuse_set_feature_flag(struct fuse_conn_info *conn,
+					 uint64_t flag)
+{
+	if (conn->capable & flag) {
+		conn->want |= flag;
+		return 1;
+	}
+
+	return 0;
+}
+#endif
+
 static void *op_init(struct fuse_conn_info *conn
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
 			, struct fuse_config *cfg EXT2FS_ATTR((unused))
@@ -947,14 +960,14 @@ static void *op_init(struct fuse_conn_info *conn
 	FUSE2FS_CHECK_CONTEXT_NULL(ff);
 	dbg_printf(ff, "%s: dev=%s\n", __func__, ff->device);
 #ifdef FUSE_CAP_IOCTL_DIR
-	conn->want |= FUSE_CAP_IOCTL_DIR;
+	fuse_set_feature_flag(conn, FUSE_CAP_IOCTL_DIR);
 #endif
 #ifdef FUSE_CAP_POSIX_ACL
 	if (ff->acl)
-		conn->want |= FUSE_CAP_POSIX_ACL;
+		fuse_set_feature_flag(conn, FUSE_CAP_POSIX_ACL);
 #endif
 #ifdef FUSE_CAP_CACHE_SYMLINKS
-	conn->want |= FUSE_CAP_CACHE_SYMLINKS;
+	fuse_set_feature_flag(conn, FUSE_CAP_CACHE_SYMLINKS);
 #endif
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
 	conn->time_gran = 1;
@@ -1020,6 +1033,19 @@ static void *op_init(struct fuse_conn_info *conn
 		log_printf(ff, "%s %s.\n", _("mounted filesystem"), uuid);
 	}
 out:
+#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 17)
+	/*
+	 * THIS MUST GO LAST!
+	 *
+	 * The high-level libfuse code has a strange bug: it sets feature flags
+	 * in conn->want_ext, and later copies the lower 32 bits to conn->want.
+	 * If we in turn change some bits in want_ext without updating want,
+	 * the lower level library to observe that both want and want_ext have
+	 * gotten out of sync, and refuses to mount.  Therefore, synchronize
+	 * the two.
+	 */
+	conn->want = conn->want_ext & 0xFFFFFFFF;
+#endif
 	return ff;
 mount_fail:
 	ff->retcode = 32;


