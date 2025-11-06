Return-Path: <linux-ext4+bounces-11566-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE5FC3D9D4
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 733514E5618
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A22630DED7;
	Thu,  6 Nov 2025 22:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGAEpush"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D19F3074AC
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468377; cv=none; b=GZBCsCSDPKS1dmhukzJeIJJPEL5gnBNWBc3LUwdbftaiMhzdd/MEEIWGNCH2CBY1V4NUe3VEe+vA2obA1yP6T1e/RZuh0sUleH6PeEeZD8wU2M9kYuVZceXThKUg1JwlZIQO/znPfOwvuPYe/7SIdBLbn7P+WnlrsFgYxVHGFl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468377; c=relaxed/simple;
	bh=HfrgrXfWvNvpNn3QOxHfolme+B+SMSIZZmfX4LKLJoU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uYvxkXoE1Y7IQNjNM8lzNXrkDxUarPstCunKeMLSDIOc3eVOhDhr8aIpYfbCSSDzb+AatOMKiFYEgkHnGHoviFK9grJI1zBva1iswhNBhWEsMNN3NJ9p1DdCqNDrnXyk2devn0793ym4FtFE9NIvgeVPLZ6v6gLWe7vsT2dsSNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGAEpush; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B34C19422;
	Thu,  6 Nov 2025 22:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762468377;
	bh=HfrgrXfWvNvpNn3QOxHfolme+B+SMSIZZmfX4LKLJoU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=GGAEpush9b5zd+x7bl8xEvWHp2FASzxih/sxKkhsjn188ylSwcBlI4l+P1n2KReRx
	 QbMYywzb43dSCeGm55MkdnNTSD1glf6KEs4ew4D2o3W9MG+SMUUwzJF+7OHZc4nyR9
	 5SmhLVKvy018TJdEbtwLZrF2mxllas+8ceM3DcfED0Ln8T8pISKwv5FKYp/d2RCQfs
	 J0ImsKYzJnB9CfARkfIfVz3zw+PiFnGccisH8p9WHBxrDnrvi3+jilj60lzMYu72PT
	 PGKv+sORCLM+iMsgaow7dD03sluoNFWTcO6NpPaiokBZn1u9Vxe5ioVJedi/m/mPTR
	 vyef0G4o715CQ==
Date: Thu, 06 Nov 2025 14:32:56 -0800
Subject: [PATCH 07/19] fuse2fs: read bitmaps asynchronously during
 initialization
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246793754.2862242.7421695138830555566.stgit@frogsfrogsfrogs>
In-Reply-To: <176246793541.2862242.16879509838698966689.stgit@frogsfrogsfrogs>
References: <176246793541.2862242.16879509838698966689.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

The kernel reads the bitmaps asynchronously when the filesystem is
mounted.  Do this as well in fuse2fs to reduce mount times.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 3e02eb13ec5488..ebb0539abc2237 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -981,6 +981,21 @@ static int fuse2fs_setup_logging(struct fuse2fs *ff)
 	return 0;
 }
 
+static int fuse2fs_read_bitmaps(struct fuse2fs *ff)
+{
+	errcode_t err;
+
+	err = ext2fs_read_inode_bitmap(ff->fs);
+	if (err)
+		return translate_error(ff->fs, 0, err);
+
+	err = ext2fs_read_block_bitmap(ff->fs);
+	if (err)
+		return translate_error(ff->fs, 0, err);
+
+	return 0;
+}
+
 static void *op_init(struct fuse_conn_info *conn
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
 			, struct fuse_config *cfg EXT2FS_ATTR((unused))
@@ -1028,6 +1043,10 @@ static void *op_init(struct fuse_conn_info *conn
 		uuid_unparse(fs->super->s_uuid, uuid);
 		log_printf(ff, "%s %s.\n", _("mounted filesystem"), uuid);
 	}
+
+	if (global_fs->flags & EXT2_FLAG_RW)
+		fuse2fs_read_bitmaps(ff);
+
 	return ff;
 }
 
@@ -5001,16 +5020,6 @@ int main(int argc, char *argv[])
  _("Warning: fuse2fs does not support using the journal.\n"
    "There may be file system corruption or data loss if\n"
    "the file system is not gracefully unmounted.\n"));
-		err = ext2fs_read_inode_bitmap(global_fs);
-		if (err) {
-			translate_error(global_fs, 0, err);
-			goto out;
-		}
-		err = ext2fs_read_block_bitmap(global_fs);
-		if (err) {
-			translate_error(global_fs, 0, err);
-			goto out;
-		}
 	}
 
 	if (!(global_fs->super->s_state & EXT2_VALID_FS))


