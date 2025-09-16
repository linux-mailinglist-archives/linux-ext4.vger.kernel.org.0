Return-Path: <linux-ext4+bounces-10095-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 906E1B588C3
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 02:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A0B916F8CD
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 00:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCF91F94A;
	Tue, 16 Sep 2025 00:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVCxmaIL"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA17EE571
	for <linux-ext4@vger.kernel.org>; Tue, 16 Sep 2025 00:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757980963; cv=none; b=S9feyo1fjtUXd8qVT3nCjElkaU+n/ThWTD3qDzPjBdpw7hgiTdX0ETTZ3MWW+OIeJAYX3swwu8kn5gcbY+5uI6QEBQA79cZ32r+9PH6mHQyZVgPaMdgftlOfiWdVbZrVT2DicWX+73aVZXTRfW77NE2L1XLbL5HxBeoDm7HmVlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757980963; c=relaxed/simple;
	bh=d2Sk9nSqcl+AVARExhaUa3SfJev3pIu9dcxsk0ai5nM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V5fSMNpzvecA6deeL/QBHdzXSQkSqEKrgtSv7ClLmAjcJbcCasV3gXHD9MCAmjfsWpuex/YnK2AtP/NW11aK96RBb4Sw+BIBqaEj7Top7nL/ZveGovhWibJMRRyby3Sey2rx4TqvEcP9uEpwJvhMGHi7Vf1q0zz7vvwRGHKPEY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVCxmaIL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F766C4CEF1;
	Tue, 16 Sep 2025 00:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757980963;
	bh=d2Sk9nSqcl+AVARExhaUa3SfJev3pIu9dcxsk0ai5nM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=EVCxmaILQsfr/80ReEcVdHqJzYmCU9iqA8gUwcjwurZ3aEtP02wk8ZA3x56YE26OA
	 O24Om61AE9ocLy4d5DA2sn6f2tdUYGbtfFemK1k6H84Zs0NZlfxLK9vEjKUH/gpqv7
	 KRjvHNcUYsNfwmlRSo7GHixvLJwdm3thiNNJ+GM8SdTCAD9Oc/eIqSK6G7qmfKjsRN
	 N+SYLjO7u6Z3VTp3SQ9B8KD+H3awr4chxz4/qbfRQqdtdLQFj/Hw6N7Xbu8tHsCdGQ
	 W47jTt7os5RifGEJ2ITIU+DbtNhJCcrnqjtJ3a/GZLIcxHug+kw53qdlXP5HM1VJZG
	 2TWVekbbexPCQ==
Date: Mon, 15 Sep 2025 17:02:42 -0700
Subject: [PATCH 2/3] fuse2fs: make norecovery behavior consistent with the
 kernel
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <175798064615.349841.5241149079975163420.stgit@frogsfrogsfrogs>
In-Reply-To: <175798064569.349841.5710112269701643406.stgit@frogsfrogsfrogs>
References: <175798064569.349841.5710112269701643406.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Amazingly, norecovery/noload on the kernel ext4 driver allows a
read-write mount even for journalled filesystems.  The one case where
mounting fails is if there's a journal and it's dirty.  Make the fuse2fs
option behave the same as the kernel.

Found via ext4/271.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index a84bd2245d82df..5917569c0a8d32 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -929,7 +929,8 @@ static void fuse2fs_unmount(struct fuse2fs *ff)
 static errcode_t fuse2fs_open(struct fuse2fs *ff, int libext2_flags)
 {
 	char options[128];
-	int flags = EXT2_FLAG_64BITS | EXT2_FLAG_THREADS | libext2_flags;
+	int flags = EXT2_FLAG_64BITS | EXT2_FLAG_THREADS | EXT2_FLAG_RW |
+		    libext2_flags;
 	errcode_t err;
 
 	if (ff->lockfile) {
@@ -940,8 +941,6 @@ static errcode_t fuse2fs_open(struct fuse2fs *ff, int libext2_flags)
 
 	snprintf(options, sizeof(options) - 1, "offset=%lu", ff->offset);
 
-	if (!ff->norecovery)
-		flags |= EXT2_FLAG_RW;
 	if (ff->directio)
 		flags |= EXT2_FLAG_DIRECT_IO;
 
@@ -1008,6 +1007,22 @@ static errcode_t fuse2fs_check_support(struct fuse2fs *ff)
 	return 0;
 }
 
+static int fuse2fs_check_norecovery(struct fuse2fs *ff)
+{
+	if (ext2fs_has_feature_journal_needs_recovery(ff->fs->super) &&
+	    !ff->ro) {
+		log_printf(ff, "%s\n",
+ _("Required journal recovery suppressed and not mounted read-only."));
+		return 32;
+	}
+
+	/*
+	 * Amazingly, norecovery allows a rw mount when there's a clean journal
+	 * present.
+	 */
+	return 0;
+}
+
 static int fuse2fs_mount(struct fuse2fs *ff)
 {
 	struct ext2_inode_large inode;
@@ -5196,6 +5211,12 @@ int main(int argc, char *argv[])
 	if (ext2fs_has_feature_shared_blocks(fctx.fs->super))
 		fctx.ro = 1;
 
+	if (fctx.norecovery) {
+		ret = fuse2fs_check_norecovery(&fctx);
+		if (ret)
+			goto out;
+	}
+
 	err = fuse2fs_mount(&fctx);
 	if (err) {
 		ret = 32;


