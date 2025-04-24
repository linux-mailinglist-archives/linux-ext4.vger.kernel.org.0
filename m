Return-Path: <linux-ext4+bounces-7470-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A473A9BA08
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 23:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEE2B3BDCC4
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 21:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10699223DD7;
	Thu, 24 Apr 2025 21:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eaeRE0zC"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65A4198851
	for <linux-ext4@vger.kernel.org>; Thu, 24 Apr 2025 21:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745530894; cv=none; b=C/iNpUw79JCl+7Zz5a/MJKLCtM+qWzM3DlDTkMGlWNLUft1uGWB88ZS2Y7WfuBSmBssv3vvOnO7J8RTcCzamWtHmHug45hM/VYuOu5i5fBrmq8KzF3bQyOypJPbaSOhbXQoTTS9B9gMwb075uMDQArQhQFjpbeM/KdfalxevcEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745530894; c=relaxed/simple;
	bh=vC+a9wc5odosz5bMxn0skrpmfTWOrjXyr1Cy7onlWlQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UxcJ9ZTaKuRX5znnbx256pKkW2uL3G5MDeNfxjCyaH06FqscoUvD+WzrnJvuKQAaBimAAqHZLhJyYqhogstnxPv2R8aqb6UyzO8+5LvAqLVtRIvhIkhqIEfW1B0kjp3cZbiDF37EiNYDVZUJKIHXqE9FGUHBYpfdFXjqxXuJQD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eaeRE0zC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DCC4C4CEE3;
	Thu, 24 Apr 2025 21:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745530894;
	bh=vC+a9wc5odosz5bMxn0skrpmfTWOrjXyr1Cy7onlWlQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=eaeRE0zCKUVDam5j3O4ezznAoEg/0OK4IhbCP0mZPVBSq+gp5/8TCsbxulhJV2O37
	 38ewLmh6USfO2F79D/nmjU2z55vzTxeFNkfpf/7cyF15J++urbcudHbRm5MUww/ZmW
	 agjyTegckQbbqM9rEjSdymCluoi8xU4/wiKBljYhDboCzNwMxnYnArzHbTNZvrE6aw
	 ADuQLXNEkX5CU8SO5e0jZ/5gip52jVppNxkGJEMaEBcu04IhAtKu0a7Uh0mcPnN5IA
	 ZTYXIVPzp/ECc6oG9rLD8J8EavAgpdwpWVCXbNGEs+kNDvMAUi9+NTcQ9p3tJB0HdY
	 QgBiSHHkOBkoA==
Date: Thu, 24 Apr 2025 14:41:34 -0700
Subject: [PATCH 03/16] fuse2fs: implement zero range
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174553064980.1160461.9850792727586596449.stgit@frogsfrogsfrogs>
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

Implement FALLOC_FL_ZERO_RANGE.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index e5f3cec083c0f5..4f3074261d0f53 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -123,6 +123,12 @@ static ext2_filsys global_fs; /* Try not to use this directly */
 # define FL_PUNCH_HOLE_FLAG (0)
 #endif
 
+#ifdef FALLOC_FL_ZERO_RANGE
+# define FL_ZERO_RANGE_FLAG FALLOC_FL_ZERO_RANGE
+#else
+# define FL_ZERO_RANGE_FLAG (0)
+#endif
+
 errcode_t ext2fs_run_ext3_journal(ext2_filsys *fs);
 
 #ifdef CONFIG_JBD_DEBUG		/* Enabled by configure --enable-jbd-debug */
@@ -3619,6 +3625,16 @@ static int punch_helper(struct fuse_file_info *fp, int mode, off_t offset,
 	return 0;
 }
 
+static int zero_helper(struct fuse_file_info *fp, int mode, off_t offset,
+		       off_t len)
+{
+	int ret = punch_helper(fp, mode | FL_KEEP_SIZE_FLAG, offset, len);
+
+	if (!ret)
+		ret = fallocate_helper(fp, mode, offset, len);
+	return ret;
+}
+
 static int op_fallocate(const char *path EXT2FS_ATTR((unused)), int mode,
 			off_t offset, off_t len,
 			struct fuse_file_info *fp)
@@ -3637,7 +3653,9 @@ static int op_fallocate(const char *path EXT2FS_ATTR((unused)), int mode,
 		ret = -EROFS;
 		goto out;
 	}
-	if (mode & FL_PUNCH_HOLE_FLAG)
+	if (mode & FL_ZERO_RANGE_FLAG)
+		ret = zero_helper(fp, mode, offset, len);
+	else if (mode & FL_PUNCH_HOLE_FLAG)
 		ret = punch_helper(fp, mode, offset, len);
 	else
 		ret = fallocate_helper(fp, mode, offset, len);


