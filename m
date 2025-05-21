Return-Path: <linux-ext4+bounces-8091-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 615A6ABFFAE
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78B7C4E4D25
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 22:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C21023958D;
	Wed, 21 May 2025 22:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ia1fjY+4"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30AB136351
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 22:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747867083; cv=none; b=OpHcOn/tqFRxqA5PbHddCRLQHFYMQTSUjowD8FNkdY//oDu7tC5IqUsNYJ3lba/qGeBLm8nFvYV5PC4Xpm3scI7bGks8X95WBTXBXrl9R/cqv6qPs/KiGfN4+qDk9OdmoyKYAjJdnG0/e1J+vbLJ2hK0FgZlnF9N2rDaiZNRYgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747867083; c=relaxed/simple;
	bh=VXmwY0jun7wclTVqcBy7mXvWf1j7IIJPWqJu0Da70nI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IO6xojipmrXkf+A0BhxmNhIzT0nzggNHdHeGhBAxjWCgV52Y5N/9Eg+/zpvRhxbC2aFvUL/XaN4m6V4ThyjjPEOtitWBScxRrgaHOQUJjKb4808KzmZphHX+7Toq+a4dRwvC/YHFHb9ZNnmrcMTpw4BX+V+jInQGEKWpVrmRt4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ia1fjY+4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 513E6C4CEE4;
	Wed, 21 May 2025 22:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747867083;
	bh=VXmwY0jun7wclTVqcBy7mXvWf1j7IIJPWqJu0Da70nI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ia1fjY+4T3HCibxPB9+IKjS50czRPkZfL10u4QHNWThtOoVKtINJw5lQlOA/BzHMh
	 tB+zmQubKhwHU3VpYz2lwC0FOeoiLyyMZuSK0WBy/YtdTdBHoeQuSIxWpDhjYib8Q7
	 /kfgYFM5pnWTJpAd7e0Ioc+KwpZGeOwYi4qI2vORGMs3vlHHRHxsbgyCBGv6lSEKpS
	 O2vqFNKxNYodBzvVk5h9Pn3GUt0pNgZ5OUcW08jCSEPtwtgfNmhq4vJG7ScR5Sh14e
	 C1ok6emKRSDrKtdXe30UuEm8jjY0+bWogPXBO1ntvd0/cZKhaW28defmSKHD/Cn+ra
	 6MNBXXAHDiGCg==
Date: Wed, 21 May 2025 15:38:02 -0700
Subject: [PATCH 12/29] fuse2fs: make removexattr work correctly
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174786677765.1383760.11407998503450588763.stgit@frogsfrogsfrogs>
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

removexattr is supposed to return ENODATA if the xattr name does not
exist, so we need to check for it explicitly.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index ce5314fa439090..299e62d3935886 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -2611,6 +2611,8 @@ static int op_removexattr(const char *path, const char *key)
 	struct fuse2fs *ff = (struct fuse2fs *)ctxt->private_data;
 	ext2_filsys fs;
 	struct ext2_xattr_handle *h;
+	void *buf;
+	size_t buflen;
 	ext2_ino_t ino;
 	errcode_t err;
 	int ret = 0;
@@ -2651,6 +2653,27 @@ static int op_removexattr(const char *path, const char *key)
 		goto out2;
 	}
 
+	err = ext2fs_xattr_get(h, key, &buf, &buflen);
+	switch (err) {
+	case EXT2_ET_EA_KEY_NOT_FOUND:
+		/*
+		 * ACLs are special snowflakes that require a 0 return when
+		 * the ACL never existed in the first place.
+		 */
+		if (!strncmp(XATTR_SECURITY_PREFIX, key,
+			     XATTR_SECURITY_PREFIX_LEN))
+			ret = 0;
+		else
+			ret = -ENODATA;
+		goto out2;
+	case 0:
+		ext2fs_free_mem(&buf);
+		break;
+	default:
+		ret = translate_error(fs, ino, err);
+		goto out2;
+	}
+
 	err = ext2fs_xattr_remove(h, key);
 	if (err) {
 		ret = translate_error(fs, ino, err);


