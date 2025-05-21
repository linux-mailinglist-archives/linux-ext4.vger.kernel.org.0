Return-Path: <linux-ext4+bounces-8108-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D5CABFFDE
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 786161BC24AA
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 22:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E52239E87;
	Wed, 21 May 2025 22:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6l2HVmI"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2191A317A
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 22:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747867351; cv=none; b=rgOsJG5mLyOeNM6CNgsoQEOj5Rm1ohoTkksl2v9Dw4N5a1NbmvGzSJygwq/HFAQZkTYw9RYAnLsBF80nwrEGAPxzMkc07elxbV3zqnwB0kfLUkcPyjaX7gu/TKpuh2togMY7BwX1lnHScYi7TYA+WHKfqzlh0PTjY/Dbk1hVeNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747867351; c=relaxed/simple;
	bh=i3Z29cbVnVmr20W4krU2kur7HLS/dtNN6PunytRKrbs=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uQoGRg6ynM//5VEGzWWbN1xv9wQdlyc8jmf0O1aOcN2YWvmcE04/1O8diKzYuurfgJC8v/7NZMhYldRTLepZx7xiaXYu9zyBt4UbmX5FZ/rm2N91bcnbx74y+w2rxXXE0k7Jxu6hLZYS+aLpj6h2N2CR8AFiVDLJWCrWii7XgUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6l2HVmI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6057C4CEE4;
	Wed, 21 May 2025 22:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747867351;
	bh=i3Z29cbVnVmr20W4krU2kur7HLS/dtNN6PunytRKrbs=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=k6l2HVmInTt0Zv8h97V2bnLlC9DVFw1T14w010+CXhwssh+XncH5T1MVZu7owQi4Z
	 9AyoO2JRUdByacv/tgafUW4LNENMb61T5YvlgtUwngSFGbKgeltkhbN53J/5CAnF0X
	 /05i8AVSup4BmytkpjgoOljdUCKLUGOFnKvLMPEeRA5inSP8mfLBTt/BvWiXLW1Sya
	 RRhb5n2ev724uvvLOqztWWbSPjRAXqYrQzn1j2EtYd+SZbFEiV1IV0C5oc1l8sj6Fc
	 wj54L4xMWvZ68g4tM9CAyc+MGZEbE9o2dpm7TQCqdkuUI8Qizos5uVjFLvkPCPluPd
	 t3aQTchUnK80Q==
Date: Wed, 21 May 2025 15:42:30 -0700
Subject: [PATCH 29/29] fuse2fs: fix group membership checking in op_chmod
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174786678066.1383760.15547379523110361909.stgit@frogsfrogsfrogs>
In-Reply-To: <174786677421.1383760.15289906755026332870.stgit@frogsfrogsfrogs>
References: <174786677421.1383760.15289906755026332870.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

In the decade or so since I touched fuse2fs, libfuse3 has grown the
ability to read the group ids of a process making a chmod request.  So
now we actually /can/ determine if a file's gid is a in the group list
of the process that initiated a fuse request.  Let's implement that too.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   78 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 76 insertions(+), 2 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index a9f753c775db09..7ec9c6d861fd80 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -2020,6 +2020,70 @@ static int op_link(const char *src, const char *dest)
 	return ret;
 }
 
+#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
+/* Obtain group ids of the process that sent us a command(?) */
+static int get_req_groups(struct fuse2fs *ff, gid_t **gids, size_t *nr_gids)
+{
+	ext2_filsys fs = ff->fs;
+	errcode_t err;
+	gid_t *array;
+	int nr = 32;	/* nobody has more than 32 groups right? */
+	int ret;
+
+	do {
+		err = ext2fs_get_array(nr, sizeof(gid_t), &array);
+		if (err)
+			return translate_error(fs, 0, err);
+
+		ret = fuse_getgroups(nr, array);
+		if (ret < 0)
+			return ret;
+
+		if (ret <= nr) {
+			*gids = array;
+			*nr_gids = ret;
+			return 0;
+		}
+
+		ext2fs_free_mem(&array);
+		nr = ret;
+	} while (0);
+
+	/* shut up gcc */
+	return -ENOMEM;
+}
+
+/*
+ * Is this file's group id in the set of groups associated with the process
+ * that initiated the fuse request?  Returns 1 for yes, 0 for no, or a negative
+ * errno.
+ */
+static int in_file_group(struct fuse_context *ctxt,
+			 const struct ext2_inode_large *inode)
+{
+	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
+	gid_t *gids = NULL;
+	size_t i, nr_gids = 0;
+	gid_t gid = inode_gid(*inode);
+	int ret;
+
+	ret = get_req_groups(ff, &gids, &nr_gids);
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; i < nr_gids; i++)
+		if (gids[i] == gid)
+			return 1;
+	return 0;
+}
+#else
+static int in_file_group(struct fuse_context *ctxt,
+			 const struct ext2_inode_large *inode)
+{
+	return ctxt->gid == inode_gid(*inode);
+}
+#endif
+
 static int op_chmod(const char *path, mode_t mode
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
 			, struct fuse_file_info *fi EXT2FS_ATTR((unused))
@@ -2066,11 +2130,21 @@ static int op_chmod(const char *path, mode_t mode
 	 * of the user's groups, but FUSE only tells us about the primary
 	 * group.
 	 */
-	if (!is_superuser(ff, ctxt) && ctxt->gid != inode_gid(inode))
-		mode &= ~S_ISGID;
+	if (!is_superuser(ff, ctxt)) {
+		ret = in_file_group(ctxt, &inode);
+		if (ret < 0)
+			goto out;
+
+		if (!ret)
+			mode &= ~S_ISGID;
+	}
 
 	inode.i_mode &= ~0xFFF;
 	inode.i_mode |= mode & 0xFFF;
+
+	dbg_printf(ff, "%s: path=%s new_mode=0%o ino=%d\n", __func__,
+		   path, inode.i_mode, ino);
+
 	ret = update_ctime(fs, ino, &inode);
 	if (ret)
 		goto out;


