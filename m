Return-Path: <linux-ext4+bounces-8831-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F4AAFA72D
	for <lists+linux-ext4@lfdr.de>; Sun,  6 Jul 2025 20:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B627E1891408
	for <lists+linux-ext4@lfdr.de>; Sun,  6 Jul 2025 18:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CBC12C544;
	Sun,  6 Jul 2025 18:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7PvGmae"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9250C846F
	for <linux-ext4@vger.kernel.org>; Sun,  6 Jul 2025 18:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751826661; cv=none; b=An1ovT4fetqceedqpYiIRorEXquZ1WbZVmmWXhUyUx3axP054m8FiUGmNSlfyVHoid35M3wV0bSLOM5cDIIy378bId/VcT4FgXYLvdJ1sDu4NFP4Lo+Pvny9/I3sYK4Y5BGUMdI2UCOFdK6wNWrgfukAvSdvzGrhTQntcOXrEAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751826661; c=relaxed/simple;
	bh=Mh/FB4eqpkB/1XbOt7s6Qs/0ECn65mgmiyPwIhoGl/4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uwne37pVgvEDOlqW+NwGPcZx68zapP0xuA32tCnl1ujwyrCGzW5i4c/Vh3yA9LLmmNXudnXCLKn7L/GTBQWVgnYt5SH92W6CvlKcYM3Lu54JeCXSPqZfVVJ1LYYNfA+Y2NkZhIlccSlspLPPRG40VJrKaz+fgU/Qoy4s6WcA86Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7PvGmae; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B10C4CEEE;
	Sun,  6 Jul 2025 18:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751826661;
	bh=Mh/FB4eqpkB/1XbOt7s6Qs/0ECn65mgmiyPwIhoGl/4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=C7PvGmaeHG4VXvRt7CENPHTslRb0ZnIJfz0OLuNRky1IwpU0zrlquNXvg5777Dbpq
	 58Gyuu0ujT6Gs+dUhfo6BRjgVtav1nHErNsIbWYe/veaFSsjg/0qyjsX+TvFYDtcA/
	 Zcl/5svIZG+Ikhg4yQLsSnYE2uOskZtiOeWXE6k+sMugMgIMsQwzzb4FrZJ/4tUDmU
	 9wPwl4eOrmo9mxD6SAVzrlu5wzrrWk0J6qpBPolsy1BhjbkKmrK9vy5Y74CHNdrtvz
	 asi81bCbYAiCs1Sh9i+U/2PBqNjvpxWU3J8AgFCWKXtoc6Xcc8wWW/AzxwNncOeEH4
	 hWlNYiBZd7uFA==
Date: Sun, 06 Jul 2025 11:31:00 -0700
Subject: [PATCH 1/8] libext2fs: fix off-by-one bug in punch_extent_blocks
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <175182662987.1984706.5292286424808159532.stgit@frogsfrogsfrogs>
In-Reply-To: <175182662934.1984706.3737778061161342509.stgit@frogsfrogsfrogs>
References: <175182662934.1984706.3737778061161342509.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

punch_extent_blocks tries to validate its input parameters to make sure
that the physical range of blocks being punched do not go past the end
of the filesystem.  Unfortunately, there's an off-by-one bug in the
valiation, because start==0 count==10 is a perfectly valid range on a
10-block filesystem.

Cc: <linux-ext4@vger.kernel.org> # v1.46.6
Fixes: 6772d4969e9c90 ("libext2fs: check for invalid blocks in ext2fs_punch_blocks()")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/ext2fs/punch.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


diff --git a/lib/ext2fs/punch.c b/lib/ext2fs/punch.c
index 80c699eb0c13f5..19b6a37824c589 100644
--- a/lib/ext2fs/punch.c
+++ b/lib/ext2fs/punch.c
@@ -201,7 +201,7 @@ static errcode_t punch_extent_blocks(ext2_filsys fs, ext2_ino_t ino,
 	errcode_t	retval = 0;
 
 	if (free_start < fs->super->s_first_data_block ||
-	    (free_start + free_count) >= ext2fs_blocks_count(fs->super))
+	    (free_start + free_count) > ext2fs_blocks_count(fs->super))
 		return EXT2_ET_BAD_BLOCK_NUM;
 
 	/* No bigalloc?  Just free each block. */


