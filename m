Return-Path: <linux-ext4+bounces-8121-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E73D5ABFFF1
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 381CE9E42A6
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 22:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738EC2192E3;
	Wed, 21 May 2025 22:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USX7Ynon"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1742D1A23AA
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 22:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747867555; cv=none; b=HOfuVnVpDVUFQoBP1K2lqQi6HS7ea8DoKvKmd/KfB7v+bRDR3frckBU9IhgyXflaq1rMUFCaoiPEdGfSFDmrDuKfIOloylK4w5Wxcjo7iKphXJdF8JyfdMwtDoHLva+IIg71soILxfZ00pEqKGzkLALyq2bRor37112N2RY+Ta0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747867555; c=relaxed/simple;
	bh=/leEEgwtCiNjrV0Wh3/DWd8TtXfG1iVHKwm6Vc4KbBM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u7BAdwuW0BPD9WzhBcIwIWoFklFgiKugcolYmf/UpSAxH3ogwYaHRIMCv6xYfoI/+I42fiL3kf30IOTBN391st2j+iJHQ8u/rT9b6Lvt2rqYuMmw2XcbZ97zFvt12PtoU3Ulr9z+j2yr3nnYQpuA+Z2MMw9gShKV+G4vl3t9v+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USX7Ynon; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FC6AC4CEE4;
	Wed, 21 May 2025 22:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747867554;
	bh=/leEEgwtCiNjrV0Wh3/DWd8TtXfG1iVHKwm6Vc4KbBM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=USX7YnonpgvSTCtXBBb6dQHfAy174/Vu9hHuUkdoNEarPvbkxpdRwkhITzeXsm1wh
	 EmiZ2bEz73PTMa3aUBU2G2ibx/W6zaFr/mmiDK96Bk/9mwgMUE0vVECQOPbsBA4pKV
	 n0VKTrHYbtJzklmaThiPVdM8RejkJD7rW4XLle3JvlZRS+eEpKAm8cawydmkuxU5Q+
	 Ezp7el5UObJguQXRCSN+7nuPfbATygXRURNOUIwKBNPIq9UfvyttPmqgC7AxWRUO7v
	 zirBgFrQ0CNfCrcz3Zh+6t5ZUR8gjrTRrkK5lL3KTgico6bQYvcf98O/mSBrqBVpvJ
	 MP9OQstjF1qrA==
Date: Wed, 21 May 2025 15:45:54 -0700
Subject: [PATCH 03/10] fuse2fs: close filesystem from op_destroy
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174786678745.1385354.4539253023336874014.stgit@frogsfrogsfrogs>
In-Reply-To: <174786678650.1385354.14994099236248944550.stgit@frogsfrogsfrogs>
References: <174786678650.1385354.14994099236248944550.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Close the filesystem from op_destroy so that we know the block device
has been closed before the umount call completes.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 25d32a69729362..ec3d684085d975 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -675,6 +675,20 @@ static int check_inum_access(struct fuse2fs *ff, ext2_ino_t ino, int mask)
 	return -EACCES;
 }
 
+static void close_fs(struct fuse2fs *ff)
+{
+	errcode_t err;
+
+	if (!ff->fs)
+		return;
+
+	err = ext2fs_close(ff->fs);
+	if (err)
+		err_printf(ff, "%s\n", error_message(err));
+
+	ff->fs = NULL;
+}
+
 static void op_destroy(void *p EXT2FS_ATTR((unused)))
 {
 	struct fuse_context *ctxt = fuse_get_context();
@@ -717,7 +731,10 @@ static void op_destroy(void *p EXT2FS_ATTR((unused)))
 		char uuid[UUID_STR_SIZE];
 
 		uuid_unparse(fs->super->s_uuid, uuid);
+		close_fs(ff);
 		log_printf(ff, "%s %s.\n", _("unmounting filesystem"), uuid);
+	} else {
+		close_fs(ff);
 	}
 }
 
@@ -4723,12 +4740,7 @@ int main(int argc, char *argv[])
  _("Mount failed while opening filesystem.  Check dmesg(1) for details."));
 		fflush(orig_stderr);
 	}
-	if (fctx.fs) {
-		err = ext2fs_close(fctx.fs);
-		if (err)
-			com_err(argv[0], err, "while closing fs");
-		fctx.fs = NULL;
-	}
+	close_fs(&fctx);
 	if (fctx.device)
 		free(fctx.device);
 	fuse_opt_free_args(&args);


