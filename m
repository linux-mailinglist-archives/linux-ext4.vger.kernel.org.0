Return-Path: <linux-ext4+bounces-7465-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A571DA9BA03
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 23:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBB984A6F66
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 21:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A7421D3E3;
	Thu, 24 Apr 2025 21:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IeKOgDwa"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC1D198851
	for <linux-ext4@vger.kernel.org>; Thu, 24 Apr 2025 21:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745530816; cv=none; b=RIBmXCmEZO1zi+is23zEFs4gZhz3taswI1XWyCHXHFszhliiEdEQ0G3fNXHTB0AStJhmVS2eVRgJTFSD+p3KTf3WO+PVPxxAXa1MDOH2zeQvTfw//e0TYIiOYBWsCtVbQxGH13WB0JBU4/U94lz5oSag4i8AmLlcieu47/DRe4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745530816; c=relaxed/simple;
	bh=dHgdtQfWxVRyOw1tm5zWzPXtFKjOMQXObrKQm3IzR24=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kV0Bl2cUC0ow+4Fa7fZGksLNUZMdGg6UCMMeCpFZosOc5evAL8uZpqJv2WfEKj/MCfXiO+1dv/77+uuCbmkZy7YZJoaxdxt6GS7b2SJQCOSAyjzENvHI6toQzLcqcde4uL+8ZXzHc9SF/3VRT0DPtnYZ4OW7ujZQMURTEgMMHLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IeKOgDwa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6644CC4CEE3;
	Thu, 24 Apr 2025 21:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745530816;
	bh=dHgdtQfWxVRyOw1tm5zWzPXtFKjOMQXObrKQm3IzR24=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=IeKOgDwaTPd89IJ3d2pHcPIJi3TLu7OlRl6RsctfUFCPdb8s1Kxmm8FRko0rKMzYA
	 I0r4uv/iYvnNoort+jctQS7jFT0C4o+SJYoWIbapWdIB8EPXg0icaLX7oj6D8+uPqa
	 spp/1KES6Fu39ayyO+nBtJFLCgjlurgPSkOuYjRNpUkRVhTZpbOnhvnKCH0Hjxfvt6
	 7Aplf7RvUaAerxgmXAr9GC+6a6C46/Mcjhz42nfSWm1HLwSxQvts2Uw1jS8Mm95IOi
	 msvRQ3NCqznorcbinK9gEXWZz/fk3/iKmbHBC9jD7S6DAfcq8VgKv5WFjZvBb8rlww
	 uPPdy/anqZ1lA==
Date: Thu, 24 Apr 2025 14:40:16 -0700
Subject: [PATCH 1/3] fuse2fs: add dummy acl/user_xattr mount options
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174553064691.1160289.2390597214443719562.stgit@frogsfrogsfrogs>
In-Reply-To: <174553064664.1160289.1903497308767982357.stgit@frogsfrogsfrogs>
References: <174553064664.1160289.1903497308767982357.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

ACLs and user xattrs are always supported, so add these mount options
and do nothing.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index fa48956396e9d1..245d2b3b916686 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -3728,6 +3728,7 @@ static int get_random_bytes(void *p, size_t sz)
 }
 
 enum {
+	FUSE2FS_IGNORED,
 	FUSE2FS_VERSION,
 	FUSE2FS_HELP,
 	FUSE2FS_HELPFULL,
@@ -3743,7 +3744,10 @@ static struct fuse_opt fuse2fs_opts[] = {
 	FUSE2FS_OPT("fuse2fs_debug",	debug,			1),
 	FUSE2FS_OPT("no_default_opts",	no_default_opts,	1),
 	FUSE2FS_OPT("norecovery",	norecovery,		1),
-	FUSE2FS_OPT("offset=%lu",	offset,		0),
+	FUSE2FS_OPT("offset=%lu",	offset,			0),
+
+	FUSE_OPT_KEY("acl",		FUSE2FS_IGNORED),
+	FUSE_OPT_KEY("user_xattr",	FUSE2FS_IGNORED),
 
 	FUSE_OPT_KEY("-V",             FUSE2FS_VERSION),
 	FUSE_OPT_KEY("--version",      FUSE2FS_VERSION),
@@ -3766,6 +3770,8 @@ static int fuse2fs_opt_proc(void *data, const char *arg,
 			return 0;
 		}
 		return 1;
+	case FUSE2FS_IGNORED:
+		return 0;
 	case FUSE2FS_HELP:
 	case FUSE2FS_HELPFULL:
 		fprintf(stderr,


