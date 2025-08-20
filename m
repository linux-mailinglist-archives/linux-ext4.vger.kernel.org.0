Return-Path: <linux-ext4+bounces-9405-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1051AB2E8EE
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 01:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1D511CC44CC
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Aug 2025 23:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA4B2E2281;
	Wed, 20 Aug 2025 23:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkMCvRmK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5988E25D21A
	for <linux-ext4@vger.kernel.org>; Wed, 20 Aug 2025 23:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755733300; cv=none; b=oYpCxhzzn2xAmmrloiyzWAr00eEcJArynjYGsw1LQS4esvLQgT0tDmHvrnm/Z/2mPftBAXG+PIeLmmeShVPL+rXwqyPqiQN6xauNcZvYzCOX0O52Nc3/dGz/CgnmEjsy4vFRWduJZEEyE6uQ88xYaVx84UjT60x0BKj5aJcknA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755733300; c=relaxed/simple;
	bh=BriSIJy/IkeiQ7x05HGn64c98cF7718JF+EAaMYKxS4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LHLr4oCEELWi7PNdSSo2gp5nva5Hd8qd1ymwmVgbP17D7RD+UIY91k6Za+rkpnW6H/7gop+gtaSTno+kM6Y5Ug1cA3ULmK/YvIBH+aYXujOEvyTrZRzWxwJwZi6DbFDcdlzJHZuFTrS1P7prENutKZiJBxO4WAW/pYfc+SuiLP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HkMCvRmK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C93F8C4CEE7;
	Wed, 20 Aug 2025 23:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755733299;
	bh=BriSIJy/IkeiQ7x05HGn64c98cF7718JF+EAaMYKxS4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=HkMCvRmKa5sEkVVynzsZvcNC2Q30cFvbzx8siCCdvXl9F5VeoAt3Q4o9rUP/OJo88
	 bmTYvPvaVm3TxiW7IgMfjuZkiJUUkGwam4jFAlNzQs4LrIcEUyUvZfJLCKKpSU3k1n
	 qriBj+NZuM/FIaGrEkl9vSFQlHpON32xAuMmvM1zTIZcTMgz7ie6cV42ISp21/xaRz
	 ljezrP9UYLpTwOLdfroHPq5ZbyyDmNRTmLnHu1LqdL0nxYA53ueD/84m23nGnxBGJt
	 3NndXD8yZJdAKAGpTvJpSc+0ZNCoR85otGpi/yKhhNN34BaEfNS3CAvroT6Ikl20A8
	 Fe38LFmy6lVyA==
Date: Wed, 20 Aug 2025 16:41:39 -0700
Subject: [PATCH 03/12] fuse2fs: fix various problems in get_req_groups
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <175573318658.4130038.11469557984847954264.stgit@frogsfrogsfrogs>
In-Reply-To: <175573318553.4130038.2069350865263085609.stgit@frogsfrogsfrogs>
References: <175573318553.4130038.2069350865263085609.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

get_req_groups has two problems: first, it doesn't free the array if
fuse_getgroups errors out; and it passes errors to its caller.  The
memory leak is an obvious fix, but in the error case we actually want to
fall back to checking the sole gid that the fuse request context gave
us.  Fix both of these errors.

Cc: <linux-ext4@vger.kernel.org> # v1.47.3
Fixes: 3469e6ff606af8 ("fuse2fs: fix group membership checking in op_chmod")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index f9da9c1ac051cb..cce1c97c81c075 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -2264,8 +2264,17 @@ static int get_req_groups(struct fuse2fs *ff, gid_t **gids, size_t *nr_gids)
 			return translate_error(fs, 0, err);
 
 		ret = fuse_getgroups(nr, array);
-		if (ret < 0)
-			return ret;
+		if (ret < 0) {
+			/*
+			 * If there's an error, we failed to find the group
+			 * membership of the process that initiated the file
+			 * change, either because the process went away or
+			 * because there's no Linux procfs.  Regardless of the
+			 * cause, we return -ENOENT.
+			 */
+			ext2fs_free_mem(&array);
+			return -ENOENT;
+		}
 
 		if (ret <= nr) {
 			*gids = array;
@@ -2296,13 +2305,23 @@ static int in_file_group(struct fuse_context *ctxt,
 	int ret;
 
 	ret = get_req_groups(ff, &gids, &nr_gids);
+	if (ret == -ENOENT) {
+		/* magic return code for "could not get caller group info" */
+		return ctxt->gid == inode_gid(*inode);
+	}
 	if (ret < 0)
 		return ret;
 
-	for (i = 0; i < nr_gids; i++)
-		if (gids[i] == gid)
-			return 1;
-	return 0;
+	ret = 0;
+	for (i = 0; i < nr_gids; i++) {
+		if (gids[i] == gid) {
+			ret = 1;
+			break;
+		}
+	}
+
+	ext2fs_free_mem(&gids);
+	return ret;
 }
 #else
 static int in_file_group(struct fuse_context *ctxt,


