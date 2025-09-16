Return-Path: <linux-ext4+bounces-10118-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D35F4B58A10
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 02:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2410B7AE075
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 00:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5402813AD3F;
	Tue, 16 Sep 2025 00:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qlsU+kxs"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA89C5C96
	for <linux-ext4@vger.kernel.org>; Tue, 16 Sep 2025 00:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983808; cv=none; b=Q6DRkXAOAi/5EjTY0wdNJRGKoiZ+FRtFn4YMzUIuwOaDPhABDY3pYdJNYbI4oC+0OAqNa3TtRygxyU0a3fS7++YOsyULRsVlt+5W1AFQlrqHU48U6tZ8cZ0zb5Y20F6SSSQe+oJHTt6qg2p6mV5dDHk07VRBfdhB9xkrBRFC4TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983808; c=relaxed/simple;
	bh=nPbH5Zk2K6lWeyTHLA0gHYx/haQimWxqYJZXrx57o4M=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OSt7yiNoKDWrR1UxGhLL9td0D10CdhaSVXCwGTRbq6G52ejU+1GFWLezGsGULUpTAuKMr66nDiICBNEud0Sop9zq7ynuG3goHPhAxKFHbRGMdhRGrkgS088pmPW3SyhO136+Yr1L+WyFFLhamUzrVKolNJ7Q9sP2WS2F+nQTU1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qlsU+kxs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA2EEC4CEF1;
	Tue, 16 Sep 2025 00:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757983807;
	bh=nPbH5Zk2K6lWeyTHLA0gHYx/haQimWxqYJZXrx57o4M=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=qlsU+kxsdgVYS9Kyn+fGg7pALAP5wOnrwFvWVfyaMjjIN9CzplyXaxsK5KlWkxfOf
	 ha2RbP/MSyk8K2Lh2h2jKBZT86jj4HtakHzrAXLy3Um/12+YRzuvIP1xQRvx3MBZn2
	 5mrgCu8d3ufqWA6W63gEtaJousgoVPl6zQyMhBf7w8DzbmYAD30yl2zcJMuFel1hSh
	 GvsjTinSEG796dv3ZXR+AKEH6iH5xOuZ7UlKIfU9UfLuBVZxh+DYd8BzroawXYOSJR
	 6Xogw+4JX8N9u5j1L3pha/4WUIyQOtvA2QMe8uHSyHHC+3M8ve0bgjH5OZy97YyAPI
	 QteX32DwlsgOw==
Date: Mon, 15 Sep 2025 17:50:07 -0700
Subject: [PATCH 2/4] fuse2fs: wrap the fuse_set_feature_flag helper for older
 libfuse
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <175798160511.389044.5108322625829000877.stgit@frogsfrogsfrogs>
In-Reply-To: <175798160460.389044.17475177319582767798.stgit@frogsfrogsfrogs>
References: <175798160460.389044.17475177319582767798.stgit@frogsfrogsfrogs>
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
index 101f0fa03c397d..aa51b8f55b0f50 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1298,6 +1298,19 @@ static int fuse2fs_read_bitmaps(struct fuse2fs *ff)
 	return 0;
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
@@ -1322,14 +1335,14 @@ static void *op_init(struct fuse_conn_info *conn
 	fs = ff->fs;
 	dbg_printf(ff, "%s: dev=%s\n", __func__, fs->device_name);
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
@@ -1349,6 +1362,19 @@ static void *op_init(struct fuse_conn_info *conn
 	if (ff->opstate == F2OP_WRITABLE)
 		fuse2fs_read_bitmaps(ff);
 
+#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 17)
+	/*
+	 * THIS MUST GO LAST!
+	 *
+	 * fuse_set_feature_flag in 3.17.0 has a strange bug: it sets feature
+	 * flags in conn->want_ext, but not conn->want.  Upon return to
+	 * libfuse, the lower level library observes that want and want_ext
+	 * have gotten out of sync, and refuses to mount.  Therefore,
+	 * synchronize the two.  This bug went away in 3.17.3, but we're stuck
+	 * with this forever because Debian trixie released with 3.17.2.
+	 */
+	conn->want = conn->want_ext & 0xFFFFFFFF;
+#endif
 	return ff;
 }
 


