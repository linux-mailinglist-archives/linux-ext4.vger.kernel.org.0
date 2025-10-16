Return-Path: <linux-ext4+bounces-10905-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B75BE44E9
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Oct 2025 17:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 980074E2E7B
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Oct 2025 15:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DE631B80D;
	Thu, 16 Oct 2025 15:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qJoGTDBo"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4C520DD48
	for <linux-ext4@vger.kernel.org>; Thu, 16 Oct 2025 15:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760629392; cv=none; b=HXeweF+yzswVjYqu8KW8MwQOO4mVPte6WZWTyvz4Z/0Lo1ptWIkz6DVJ+oZIa1Wu3iWOhT/dpc7JHFYr9Qizv9u0st1HFBrHx1mFp8R7sfPjElEtH8Vde/umQ5/d5dx4BKGJelucx+TO1ptIopLBgAbX+zjB+voTtvW31+b0Ln4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760629392; c=relaxed/simple;
	bh=A5cdithFxkgN33kLpZj+SoVkf2QQFRVDzfNb4iGNPp0=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AuBRRX+l+hCgsD8rb/2rild8fGV3dbHxU+QQIYtU+0FRFrz4awY9hZHl2x82jeMqk8fucaWWHPWlTcK3btQiX/ddpvayBl/j0v+i1VFwYv008ALqHDotKw7Pj76Id1k6+M8Vy00wYogOinwYhSJIn2TB+AjMOS1ArUua6ujJf0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qJoGTDBo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E666EC4CEF1;
	Thu, 16 Oct 2025 15:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760629392;
	bh=A5cdithFxkgN33kLpZj+SoVkf2QQFRVDzfNb4iGNPp0=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=qJoGTDBoZyjucN/EaRD6zLkMuBgqV5eZI/5yhDj6PeD3Uq7XeRIwqJW8n9MYasJr+
	 Oi1ydzUPqC0YVA4+4dwrr5L9zrXnPqRA42h06YNFcNYxYb2VlRMHvkHv7oKKLeJkFO
	 bT766JK9MQvSqqK0BHeENeMX85/rAvdp1L/StST5dF1rsDLbLsG30RsP3Xo6QDCY/9
	 m0GzqUUt8aVhntp+pDqeKD9cHMCpmv4Jx7ER7yzV6mCtUWkmhvM4WGai/qXCAH8dWW
	 S6OHd6+Han9QQUbUw/Y5TZs7MHvcqXhLWwCC51fQIaR/gd5EIF8gXwqEGEvR32Utj8
	 nEe/hgLvdUkcw==
Date: Thu, 16 Oct 2025 08:43:11 -0700
Subject: [PATCH 13/16] fuse2fs: fix in_file_group missing the primary process
 gid
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <176062915701.3343688.8714211042480698391.stgit@frogsfrogsfrogs>
In-Reply-To: <176062915393.3343688.9810444125172113159.stgit@frogsfrogsfrogs>
References: <176062915393.3343688.9810444125172113159.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

I forgot that Unix processes have both a primary group id and a list of
supplementary group ids.  The primary is provided by the fuse client;
the supplemental groups are noted by the Groups: field of
/proc/self/status.

If a process does not have /any/ supplemental group ids, then
in_file_group returns the wrong answer if the inode gid matches the
group id provided by the fuse client because it doesn't check that
anymore.  Make it so the primary group id check always happens.

Found by generic/375.

Cc: <linux-ext4@vger.kernel.org> # v1.47.3
Fixes: 3469e6ff606af8 ("fuse2fs: fix group membership checking in op_chmod")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 0ecdd4f9e93225..b8db298cde202f 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -2303,10 +2303,14 @@ static int in_file_group(struct fuse_context *ctxt,
 	gid_t gid = inode_gid(*inode);
 	int ret;
 
+	/* If the inode gid matches the process' primary group, we're done. */
+	if (ctxt->gid == gid)
+		return 1;
+
 	ret = get_req_groups(ff, &gids, &nr_gids);
 	if (ret == -ENOENT) {
 		/* magic return code for "could not get caller group info" */
-		return ctxt->gid == inode_gid(*inode);
+		return 0;
 	}
 	if (ret < 0)
 		return ret;


