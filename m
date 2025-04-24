Return-Path: <linux-ext4+bounces-7479-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFD9A9BA11
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 23:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E76E31BA50B5
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 21:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977C921E087;
	Thu, 24 Apr 2025 21:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nn8f/wqd"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC94198851
	for <linux-ext4@vger.kernel.org>; Thu, 24 Apr 2025 21:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745531035; cv=none; b=DBIFWHJNuSUOANr3XGKNtlTFYo5aQrnJgo2AFo9cCuY+zN8gPRPQph4nwygrhIfjRuWV4HfufUnF2njlER2398+rEOB1aY14C+d72KP87M6T3+nbKFrqd+IiaeXqCXiULM+orz4ZMYoGsbfTbW9oWbbFKsz6Lx9J1PJbiBEFwX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745531035; c=relaxed/simple;
	bh=11Xa9EFYuEtyWzGR6r+2kUDLydjV6VpSoQ21b28o+78=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PiOw8Q7+vBjqI0PZ5gV1IwGeGkTQ8MI1X4nJ28pRSz+MJ9JsJ6ll/S083Dmi3wUp0rj3M8wn/X0Fb4s0sEa3XL0anMpBRifUe+Rt5Xm435e8IM4kHAzN9f0jsRf6uU3dCz7+v1hZNNE07t5bvNd/edPIchaIhwY8MBlnZqrBOY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nn8f/wqd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11C66C4CEE3;
	Thu, 24 Apr 2025 21:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745531035;
	bh=11Xa9EFYuEtyWzGR6r+2kUDLydjV6VpSoQ21b28o+78=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=nn8f/wqd8aOoqaheR+bEVCNsA0tKJRfMB3N9VS/Ktv+B9T+R36lfALXphWPWbERws
	 +8AnDGEo7CiENPdXjI1GDRHYZuVpodrGyiom+dDRNTJsHfKW84DKEL79ASCo5Z7ILB
	 martsGsWWCiFZENYsFCZwecRXa70W2K8WLx7VPvkpp4T2oYFHE9cSw1ywFwf3HMUFe
	 qmheuimmM2LrUZPQt9djWCZgYw83Vc+1jZfMPgJYGFNOcPdZw6PGNZXpVQxSncMlIy
	 rXyUhrCytDi7Q+ljPCb0lZZ26PNVzK61URSeEx9svLpoV5e5S0Q7LfqCfJZnhdsKhx
	 Ar/n83bY/4b8Q==
Date: Thu, 24 Apr 2025 14:43:54 -0700
Subject: [PATCH 12/16] fuse2fs: update new child timestamps during
 mkdir/symlink
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174553065141.1160461.7342685341356901806.stgit@frogsfrogsfrogs>
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

These two file creation functions fail to update the timestamps of the
new child file, unlike the others (mknod/creat).  Fix that.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    2 ++
 1 file changed, 2 insertions(+)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 2220da4c3e8f64..a13564a30575da 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1016,6 +1016,7 @@ static int op_mkdir(const char *path, mode_t mode)
 	inode.i_mode = LINUX_S_IFDIR | (mode & ~S_ISUID) |
 		       parent_sgid;
 	inode.i_generation = ff->next_generation++;
+	init_times(&inode);
 
 	err = ext2fs_write_inode_full(fs, child, (struct ext2_inode *)&inode,
 				      sizeof(inode));
@@ -1390,6 +1391,7 @@ static int op_symlink(const char *src, const char *dest)
 	inode.i_gid = ctxt->gid;
 	ext2fs_set_i_gid_high(inode, ctxt->gid >> 16);
 	inode.i_generation = ff->next_generation++;
+	init_times(&inode);
 
 	err = ext2fs_write_inode_full(fs, child, (struct ext2_inode *)&inode,
 				      sizeof(inode));


