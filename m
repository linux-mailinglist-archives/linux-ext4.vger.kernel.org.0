Return-Path: <linux-ext4+bounces-7481-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E57F8A9BA13
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 23:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F025C7AE90D
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 21:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0F421E087;
	Thu, 24 Apr 2025 21:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjL5Y2tF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F8D1F4297
	for <linux-ext4@vger.kernel.org>; Thu, 24 Apr 2025 21:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745531066; cv=none; b=fve/KsIq31r8b/nAnQrV9vblxKS2bmWYBgtvTrrb0VzJxFIKLFPz13cumEpK1vvt4/vsBGgks3TqwJ887d5qBf0Gu6AUrihSj0Hl5RRaqBnz8eNbDD4J0AC5gaLR57YQDVhL21cyIq617nO1Fx0Rbfg9yNp3VktC1wk/ICN8FGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745531066; c=relaxed/simple;
	bh=qts1Pq5kmv68nJ7gFEIuAv+NiTVluEh0zzBcrAgnn3s=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=svBq3GFl00oUu6AFv2rdtRU4RwXLVoofyLXpUxIHm3M0a00nLwsqdFr8p0e02hQzSxhdm+LSSbPjRRQY4EVdJpKxnO9i/j6qh5QpBxu23cWgJ4HkP0YFGlCzokbvbbE7c/WjY3dh8wd7XI+4Odj1DB63TvA6zsDd/PHIX56khk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjL5Y2tF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42DB4C4CEE3;
	Thu, 24 Apr 2025 21:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745531066;
	bh=qts1Pq5kmv68nJ7gFEIuAv+NiTVluEh0zzBcrAgnn3s=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=TjL5Y2tFSiPVSHRqJhIfiR2CJ4EoK7dv6o7ag0b7ZkD7nELEDCt9TZl68Xeust6ks
	 1P5seSgi0sE8yGLBIL1sT7D5IMzwa/Ic8j0zQYvVf1vAPohIbhzM9aLtzKpfw3AH/C
	 2gwOe7n//HMDTFYw41fwj+7lYr14nAbL1YuERzGUD44P+/O1dOhF21mUVDSgTnXGej
	 PgTAL7+Yh/npWHXHMpR94j8rgqrxKRf9SVvKGUC7TdtwzYd3ybgQVBcZ+VRpPaeN3b
	 Tm6XN5XmOhkdTiIoFhjZ/i03TemleGifxO/Ehb9CqFVlbdHELf717bDTtv8LrOUBZz
	 V7ITRe6uaC6NA==
Date: Thu, 24 Apr 2025 14:44:25 -0700
Subject: [PATCH 14/16] fuse2fs: disable renameat2
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174553065177.1160461.684615549721279410.stgit@frogsfrogsfrogs>
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

Apparently fuse munged rename and renameat2 together into the same
upcall, so we actually have to filter out nonzero flags because
otherwise we do a regular rename for a RENAME_EXCHANGE/WHITEOUT, which
is not what the user asked for.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    6 ++++++
 1 file changed, 6 insertions(+)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 7db0a2d1f2d855..420fbfd5db5969 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1447,6 +1447,12 @@ static int op_rename(const char *from, const char *to
 	struct update_dotdot ud;
 	int ret = 0;
 
+#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
+	/* renameat2 is not supported */
+	if (flags)
+		return -ENOSYS;
+#endif
+
 	FUSE2FS_CHECK_CONTEXT(ff);
 	fs = ff->fs;
 	dbg_printf(ff, "%s: renaming %s to %s\n", __func__, from, to);


