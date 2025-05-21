Return-Path: <linux-ext4+bounces-8124-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D87EABFFFE
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD8E61890F99
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 22:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740E7237176;
	Wed, 21 May 2025 22:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGOzGyhu"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BA01EA65
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 22:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747867602; cv=none; b=qJIiDDJ/mOaqcb7Wk8jymHzjcFLvHua7eXncqpiyzT8KGMyV54aWeBw+irG/ppRuVB8TytNU1EjNeG97K4uhmZ+ZYJPhvChECUIrVpkx66OfxiTt1XXBsRidYAH256AeYa2yJwDwhIgeLjsW2pkzbrrXzJacxeNAcI9CJRveeMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747867602; c=relaxed/simple;
	bh=FLQxOh89btNJAK0kDgK6fCYWmZYdwE0Q9SfQ1u5BIGY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gYVof36e8SmJ7q88njV4V/wjRtQGdhqmfHd87Ol/0MLfattzmg649rKFIrEpyDOdMX2TJO1so+bZTnsZbaACoITnnyq0mWTo9Y7hQ8B3tRca0tCWMnCzeFmKMtt11VeeL7FORxKjy9WksJYOCP5wtgXHb07ZaCINObE+8pCH6Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGOzGyhu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D621C4CEE4;
	Wed, 21 May 2025 22:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747867601;
	bh=FLQxOh89btNJAK0kDgK6fCYWmZYdwE0Q9SfQ1u5BIGY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=jGOzGyhu//mW0FJDLH1dkdktp+S0yuKoQ7UcCRUpQ0I+MiZrgch7/WeLKO8YHdPIj
	 PASqTDa4XqeXEwy7N3rBNLwgNX9wtH8PD7tS0JY2UAZ3kuGH4sgaSEkPWhvx9mCq8N
	 M56QMFbAvX5xBt0EODZjhiwgQe3Uyd0M5DHMJC9dfGMJ9qeFcj1MH/6isOUljYP+NE
	 6gWLotQ0xRpWmTs7Z+zB4ucgxOzEBhbuIvdt3qlnZEgmm/YMeKRJAZ+bLNLfpR7Oer
	 Ivc4bumoVDz+18XfqXAm/v2BZK3FdvL2qFwMCJEkpPXsZVbVGehrqA+klmWJ61YyCs
	 RPpjCLAY+yVHg==
Date: Wed, 21 May 2025 15:46:41 -0700
Subject: [PATCH 06/10] fuse2fs: check for recorded fs errors before touching
 things
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174786678799.1385354.14854510405696168481.stgit@frogsfrogsfrogs>
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

Refuse the mount if there are errors recorded in the superblock.
We should not be trying to replay the journal on damaged filesystems.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 364d26a4e0e00e..7c61c470723a88 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -755,6 +755,12 @@ static errcode_t check_fs_supported(struct fuse2fs *ff)
 		return EXT2_ET_UNSUPP_FEATURE;
 	}
 
+	if (fs->super->s_state & EXT2_ERROR_FS) {
+		err_printf(ff, "%s\n",
+ _("Errors detected; running e2fsck is required."));
+		return EXT2_ET_FILESYSTEM_CORRUPTED;
+	}
+
 	return 0;
 }
 
@@ -831,12 +837,6 @@ _("Mounting read-only without recovering journal."));
 		err_printf(ff, "%s\n",
  _("Orphans detected; running e2fsck is recommended."));
 
-	if (fs->super->s_state & EXT2_ERROR_FS) {
-		err_printf(ff, "%s\n",
- _("Errors detected; running e2fsck is required."));
-		return EXT2_ET_FILESYSTEM_CORRUPTED;
-	}
-
 	return 0;
 }
 


