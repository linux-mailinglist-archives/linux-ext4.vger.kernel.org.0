Return-Path: <linux-ext4+bounces-10066-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB39B587A9
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 00:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9794B485402
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Sep 2025 22:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E5C2D47EB;
	Mon, 15 Sep 2025 22:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAmGHrb4"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B282D23A4
	for <linux-ext4@vger.kernel.org>; Mon, 15 Sep 2025 22:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757976083; cv=none; b=RxGe0kbsNqtfDuLr1u29iltj2H3caGgVES2mmiHg4PeOd2QgClG46p+/in9dzrtwava2A31BHVPIHTQmQbe1G8/eate7zM7DLQmKpI01OBWBb1rvBSuG75Jez3gTjwazgs/OnjP9z44XQ+4PzWNuCt2drv3e20pMXSNsr0r8Oko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757976083; c=relaxed/simple;
	bh=lHR40C1FyGcDdGZ5UTUMNOOBDfxQvl4oSWAvjiXjnvI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IsCWTyjKrMWW7eQ3cBipKvnEqq6oPJwCXb5pSb9l0JRpSBUToP4UFGRpSveqql32sVzpmNk6p4ObjaiGMt4sa6CBaAn91T9saOC25CfAaX6mjtB7hcPxFClhGASgFPB1Jy1aBi/bQnyr7UsMyNt4LlyRSLHptaVf8H/KTU5zrcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAmGHrb4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96F9EC4CEF5;
	Mon, 15 Sep 2025 22:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757976082;
	bh=lHR40C1FyGcDdGZ5UTUMNOOBDfxQvl4oSWAvjiXjnvI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=EAmGHrb4sedUnlSHsQzlL5/Cg2RoGkJjkzLn9uNX9HzAttk3oRFY2AhlPDjjrDurv
	 sUDdr1OoxNfduYzimd4DXuq3+1cjbfnIXI/i2RysitbV04fE6fkfcRS3UiHK+xrNDS
	 yCFsphdy5+bxoPy9ilFLGDoI0JvmKiud80U9ds9oo9KJ23Hyv6n9d+N1/RTikWVxrc
	 7TTwbsqTEVyULxWwJpBXrUMjRybGqywRKq1zdOh8JLsJ0XTMtRQc9YDyKbKJ0QSUEn
	 o8A6zwgm/hGz+woLXfBvUvgXy6mtvobRMR2WGzOmbc+OFUIZWAmVha/TZMSmOLCHBh
	 ytRbi8IVXIp1A==
Date: Mon, 15 Sep 2025 15:41:22 -0700
Subject: [PATCH 02/11] fuse2fs: read bitmaps asynchronously during
 initialization
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <175797570049.246189.1110386236122504548.stgit@frogsfrogsfrogs>
In-Reply-To: <175797569966.246189.4996503880732213475.stgit@frogsfrogsfrogs>
References: <175797569966.246189.4996503880732213475.stgit@frogsfrogsfrogs>
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
index 8389cc3a4872b2..438ac1194082b8 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -901,6 +901,21 @@ static int fuse2fs_setup_logging(struct fuse2fs *ff)
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
@@ -948,6 +963,10 @@ static void *op_init(struct fuse_conn_info *conn
 		uuid_unparse(fs->super->s_uuid, uuid);
 		log_printf(ff, "%s %s.\n", _("mounted filesystem"), uuid);
 	}
+
+	if (global_fs->flags & EXT2_FLAG_RW)
+		fuse2fs_read_bitmaps(ff);
+
 	return ff;
 }
 
@@ -4844,16 +4863,6 @@ int main(int argc, char *argv[])
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


