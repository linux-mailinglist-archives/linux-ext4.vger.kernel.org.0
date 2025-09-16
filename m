Return-Path: <linux-ext4+bounces-10119-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA5AB58A15
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 02:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD8DA1B22F23
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 00:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC2618C03F;
	Tue, 16 Sep 2025 00:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HY9KCtQS"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8438A1CD2C
	for <linux-ext4@vger.kernel.org>; Tue, 16 Sep 2025 00:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983823; cv=none; b=kTLSo7PcxUG0J9ftiEZ8wPPbefg5u4G530+vMu6QJfiZiyz6/LCUK0guLE4UZCss+q6rcoEpBS3LNDU7SAK4PWu53tmw/NJ43cLKDsJ+KmmeQ7QN/vcPqiMzbqAICKDHVhTyZ5WyN5NuCBWOrG6s7f0C5ibVW8CMRIXqUHU1IAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983823; c=relaxed/simple;
	bh=tXZwQCfhyM93bk6UQwIOQZArgFPdZR4s8ozsqY/3nuY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qIDG9Yy3eUZdE/zjm2ku8d2+PTuoMu8t37RwwrjJIcqzCPP4n2Lsi7n9Cjs9wSnOdMVDecyVeCa59EYYvWvYz3P5+azhi+djei2EkK2a04BldLSN3l5zeCPQ7fUDp1Mzk9Om+lnnyUI3DpxFbAu02J1JZaTzfoXmkOXJEW5QOx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HY9KCtQS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C695C4CEF1;
	Tue, 16 Sep 2025 00:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757983823;
	bh=tXZwQCfhyM93bk6UQwIOQZArgFPdZR4s8ozsqY/3nuY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=HY9KCtQSQe5NoOUXESU3Ekx4FdYtczRV4Geuu9bqb3i0ueEtCE+JA7UoeAIaP1n2E
	 J/9Q5N1CmZU46O3FQpc3CloLzm5HBz8N03RJBHkxYriD/4Acj42tGe2u0/ZLjucW6f
	 NxKOa0gFLwRy/zHgyZq5BjPrzUg6CpsHx5J+fPrpf3g+frVFLSjy2sAbcE4qfWRJdu
	 H5vdHypFvEg99Tj8MR8YzcNUUe9YZvVoWv5CRflO39a7l3aXKy1/7iW51173qbaDeC
	 GZijAqmLq9LtCMgVp3y+UfJr3pJHgI8dnC2+choh7I4n8daX4g+E1seo38X/5/uCIV
	 jvN9w+pPxvt6A==
Date: Mon, 15 Sep 2025 17:50:22 -0700
Subject: [PATCH 3/4] fuse2fs: disable nfs exports
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <175798160529.389044.5629334145903376847.stgit@frogsfrogsfrogs>
In-Reply-To: <175798160460.389044.17475177319582767798.stgit@frogsfrogsfrogs>
References: <175798160460.389044.17475177319582767798.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

The kernel fuse driver can export its own handles, but it doesn't
actually talk to the fuse server about those handles.  Hence they don't
survive unmount/mount cycles like regular ext4.  Disable them, because
they cause fstests regressions and it's not clear that they're suitable
for NFS export, at least not as most people understand ext4 NFS exports.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    3 +++
 1 file changed, 3 insertions(+)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index aa51b8f55b0f50..e3a350462f25f3 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1344,6 +1344,9 @@ static void *op_init(struct fuse_conn_info *conn
 #ifdef FUSE_CAP_CACHE_SYMLINKS
 	fuse_set_feature_flag(conn, FUSE_CAP_CACHE_SYMLINKS);
 #endif
+#ifdef FUSE_CAP_NO_EXPORT_SUPPORT
+	fuse_set_feature_flag(conn, FUSE_CAP_NO_EXPORT_SUPPORT);
+#endif
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
 	conn->time_gran = 1;
 	cfg->use_ino = 1;


