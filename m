Return-Path: <linux-ext4+bounces-8365-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA96AD5C88
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Jun 2025 18:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DA99172D58
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Jun 2025 16:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5642036EC;
	Wed, 11 Jun 2025 16:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVfYtqie"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA831FDE02
	for <linux-ext4@vger.kernel.org>; Wed, 11 Jun 2025 16:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749660242; cv=none; b=o5UZiWP6UvB4zz5OPphrXzV+4ULPOTuzUiVpY02Qge5ILlTbs+ZqZPmQZ62SJfmAi80Q5gTjHJlQm2B/GUdo1yUeBKDD/EeAyiWZX7GJ93MCxaA6bMaREm5/Qir8RkmW/+9TGMAAQHdGuVrarDkOz+Sj7cswzfHV98BI/F+Oo2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749660242; c=relaxed/simple;
	bh=gyqwf5+MHj6CEwRkppp0MaUfWMge+T9U8UFWccuOfQU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qZs5ZtJ44OTQebP1/Mk8yPA4Pn3c8QNywWcb1SP0TrFuI6OhKEIxTpAKbbdOMZ+qAzw0uPl5+92qpHkGVk/ovop1u4dedWokHfY7tIY62/6fPnDm0CX+Lcw+bZF7VH3cdw4FPIoko/7TXg475MBb1WHBloI5e13VXR/i7GFE3YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVfYtqie; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6162C4CEE3;
	Wed, 11 Jun 2025 16:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749660241;
	bh=gyqwf5+MHj6CEwRkppp0MaUfWMge+T9U8UFWccuOfQU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=eVfYtqieNnwWHUAVfZVnqFAzajYhCCC0QcgTmm3oU2QYxR46iVOSgfjwAEQZe7kVb
	 7g7n6ikuNXga3lfk4NVgYknim6z24/NvF1rE46caXDX5yZlqOSQJbv1+urWvF5jsue
	 IS+Eq+VNr9Aqsd4Y6II17iH1/ai2Y3h8idXZ6tCEf/FBLgW4VdSko4YAV7xaoSsW/n
	 SYThUVb1lBhQzlqVJkjV6vYKMrEF+GC6gGMkVUuN7VZEfgfKcAm3hbMm42f/BFPVui
	 IUyxghGReZBP+HCTNcNpFLvXveSXgIE2ATnJPNplfDCgPYjA7FD/2iTkhHtX+CF4RP
	 I3/8anVMEFzBQ==
Date: Wed, 11 Jun 2025 09:44:01 -0700
Subject: [PATCH 2/3] fuse2fs: fix error bailout in op_create
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: debianbugs@woodall.me.uk, linux-ext4@vger.kernel.org,
 linux-ext4@vger.kernel.org
Message-ID: <174966018088.3972888.266269916293367037.stgit@frogsfrogsfrogs>
In-Reply-To: <174966018041.3972888.391896904012834159.stgit@frogsfrogsfrogs>
References: <174966018041.3972888.391896904012834159.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Tim Woodall pointed out that op_create returns garbage error codes if
the ext2fs_extent_open2 in op_create fails.  Worse than that, it also
neglects to drop the bfl and leaks temp_path.  Let's fix all that.

Cc: <linux-ext4@vger.kernel.org> # v1.43
Fixes: 81cbf1ef4f5dab ("misc: add fuse2fs, a FUSE server for e2fsprogs")
Reported-by: Tim Woodall <debianbugs@woodall.me.uk>
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index ad4795ae4ed907..cc023065727fd5 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -3306,8 +3306,11 @@ static int op_create(const char *path, mode_t mode, struct fuse_file_info *fp)
 		inode.i_flags &= ~EXT4_EXTENTS_FL;
 		ret = ext2fs_extent_open2(fs, child,
 					  EXT2_INODE(&inode), &handle);
-		if (ret)
-			return ret;
+		if (ret) {
+			ret = translate_error(fs, child, err);
+			goto out2;
+		}
+
 		ext2fs_extent_free(handle);
 	}
 


