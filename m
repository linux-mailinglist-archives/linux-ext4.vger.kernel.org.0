Return-Path: <linux-ext4+bounces-11602-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 067FDC3DA58
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B54383AE7D3
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48E43016FF;
	Thu,  6 Nov 2025 22:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJ45lFG3"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7818A2C15B4
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468952; cv=none; b=UDoyEev8+pxt2xPw3GsClmWDqLosUcuSm1mvxO9zI965bKRksgu6uIbMHJsLL4XUiJPc5Io2mgyHebm53vPzeJOa98rYhcao0lTmA2MkMJ0j1AEOaYYpzeUVxFqzUeV8tSkI433nWVB4ZHzJqZHw0HyaUB0ETKirSEGq7g/M0wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468952; c=relaxed/simple;
	bh=cMrYYIy9H64vWV0PfeIEXSBWwTJaDMxVOVIL++ysa3A=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OVewr7DIsKhmJ0pT99t7ETs7Qk3Z7Hnu3H4Q0o/+6wL+5oGD73uKddwy+U3tZKJKiblSIn8CzWUQ1Z1Zt72CUSIXw+z/YUk/FJTUtxDmZdZ2NFzqf03Ry90YUz2AsdfH0IIJpcI0PsY1EsgOsyjZaFSyOnM8jhunwC2DvR4ceyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJ45lFG3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3AA1C4CEFB;
	Thu,  6 Nov 2025 22:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762468952;
	bh=cMrYYIy9H64vWV0PfeIEXSBWwTJaDMxVOVIL++ysa3A=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=AJ45lFG3xZ7UbagxN94o4NKijcucpxYQUxyMyoCk0E+JRYtmJTZRA6i/s/norNkW4
	 EeBcpPz/KPszF/hK34x3AUJjlYtnpGkOex3JhGr+gezrR7AiMNCgm2XyoJhZH3cDrJ
	 w4iSl47cdt3nyHwvn5s8MVvZ7/+XtpxVKNGWBDmZvT4jF4ZnVQbSdOJpP9hEJZcFvq
	 JDemYbxP2xpQbaNVH94bTTtV7+VZ7wOYQyP7o/vQF1PNqZ0L1XOStLSvHBwtXDAX9v
	 EDO/j2bOgEKl2YaX7vg+rXPTnuNhHzFhQtc4zYrpfKvcAnODUUV8jPfzA8UfKdMusO
	 C27v8UJf/QLJA==
Date: Thu, 06 Nov 2025 14:42:31 -0800
Subject: [PATCH 2/4] fuse2fs: wrap the fuse_set_feature_flag helper for older
 libfuse
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246795280.2864102.13170247566013132296.stgit@frogsfrogsfrogs>
In-Reply-To: <176246795228.2864102.6424613500490349959.stgit@frogsfrogsfrogs>
References: <176246795228.2864102.6424613500490349959.stgit@frogsfrogsfrogs>
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
index 51e6b3b1969d62..2468e7e1017d59 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1542,6 +1542,19 @@ static int fuse2fs_read_bitmaps(struct fuse2fs *ff)
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
@@ -1566,14 +1579,14 @@ static void *op_init(struct fuse_conn_info *conn
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
@@ -1593,6 +1606,19 @@ static void *op_init(struct fuse_conn_info *conn
 	 */
 	fuse2fs_mmp_start(ff);
 
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
 


