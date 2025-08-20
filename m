Return-Path: <linux-ext4+bounces-9412-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C84DB2E8F8
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 01:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDB251CC47CF
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Aug 2025 23:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78012E1755;
	Wed, 20 Aug 2025 23:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Blh400Is"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656932E173E
	for <linux-ext4@vger.kernel.org>; Wed, 20 Aug 2025 23:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755733409; cv=none; b=nyYTS6gI3zpQQcQT+kGl1RFvrqds5aw2UH0fYF7ibElCNs42BFOj9EhD+8cHJqXv5sLlUc9ApAVipLOLbuU/eF9Ig0Ho9g3q8cvyCE6islk5318V65Ik7yp+pvKKYKDY2D6ZqtsPLQ+79aKc6sgK9XCygnwxPIuBBlpmKOgkQ5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755733409; c=relaxed/simple;
	bh=qEUVoydG+1bye59W5J6vxE2UrfW5OtCHU9yujieUAug=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FZmNkGwMHa2gv0jqnR7UeALIGbTeFq07lAM24XOID7HSpI6bSXOoQmFlkB7V9pq4FV4lvUsC5SE/WGxMiUs3q0DSgkR8TmDOEd88x0sG1T/wKxWOtPkZNbtmUnhrlHKf8P7LzMHfaUe54cprpMamm+hJLMnS/KemLETmG/gx9FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Blh400Is; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E543C4CEE7;
	Wed, 20 Aug 2025 23:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755733409;
	bh=qEUVoydG+1bye59W5J6vxE2UrfW5OtCHU9yujieUAug=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Blh400IsKZwWvFuacwbhiSSX9MNHCCiuhdeUuyqSHEcel6rcRJBgIjwBtMgYSWTP+
	 mKjGgqFm7fasZfgOmKh1THEl8kkyfIkOg8O/HMv9q1x8sMqb8v7YHXFspxlxJ1KAjB
	 9VbKQKMshsVaSwnkpzXJMGFSfxCf4y6Agzao1vW7W292w5yeEPZWL5H+87n6/tjSOn
	 bSvDuKr/2a97/9iKHWVoIHtbFDoyg10xvJExKBUF+wZOgkO4Iav98p1xMYSyLx/8SH
	 VXD3OfsbvgQoVObNQVoVJYNNCkweHsvGCJqPq2oeT83xnMl0lRcdKhahCguzOA5WqD
	 DoonJllPpTbaw==
Date: Wed, 20 Aug 2025 16:43:28 -0700
Subject: [PATCH 10/12] fuse2fs: set EXT2_ERROR_FS when recording errors
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <175573318782.4130038.7586301794202465954.stgit@frogsfrogsfrogs>
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

Set the ERROR_FS bit when recording errors in the superblock so that
e2fsck will actually scan the filesystem without -f.

Cc: <linux-ext4@vger.kernel.org> # v1.43
Fixes: 81cbf1ef4f5dab ("misc: add fuse2fs, a FUSE server for e2fsprogs")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    1 +
 1 file changed, 1 insertion(+)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 2648b55893d5e7..318bfb55345b9b 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -5062,6 +5062,7 @@ static int __translate_error(ext2_filsys fs, ext2_ino_t ino, errcode_t err,
 			sizeof(fs->super->s_first_error_func));
 	}
 
+	fs->super->s_state |= EXT2_ERROR_FS;
 	fs->super->s_error_count++;
 	ext2fs_mark_super_dirty(fs);
 	ext2fs_flush(fs);


