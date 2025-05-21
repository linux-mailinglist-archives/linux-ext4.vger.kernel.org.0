Return-Path: <linux-ext4+bounces-8123-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1B3ABFFFD
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9501B9E4AB6
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 22:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7274723506D;
	Wed, 21 May 2025 22:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pFyrPh6y"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DC11A23AA
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 22:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747867586; cv=none; b=txteNci8MXvG4lcrQPDeHWxSvqcCZyWR4XKOVSZGOu0z+nItDGGhqRFoA/M99yny+6f9DOQnUDBjUXBpFDUn5FfDz3zWNclicq2cN8ai1dDHwMNw/oCmQWuToosgqEhilhgvAGRIuDdLqOVCleCCQ8vcZRpWylYJaQMLUFqr/jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747867586; c=relaxed/simple;
	bh=em6Jtqbl+EFHeOizoYXTNzocrEA/bCw84P8ayIcUtjo=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fO+BotS0m37mf5qPZeLx4MbOzS7gsojPoyZugMZDNvSOyixx2zKz+xLNA48cbBSOz/EkpIYGFrysE7cZAcSB1UVlhUTC5Ln3Itf+EDsBBkM77sRhES15OybE0ZIZBC/+M+TlSS1+jgogEWLoVQ7T1a6kRB4StqxfTCqrxNuvVCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pFyrPh6y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1520C4CEE4;
	Wed, 21 May 2025 22:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747867585;
	bh=em6Jtqbl+EFHeOizoYXTNzocrEA/bCw84P8ayIcUtjo=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=pFyrPh6y7J18jChZa6sYSLp9ppGcNz3KaAsOC0wNjFjV0HZrbj4EQ8E+Ybe1P53HL
	 Ws+OK1fH/Z8ZKwk1grURMeICH/l18x6Ig/EaKGSfFek0Sa6+CsNT4eEVfkdvW4NM3P
	 j7BXfo5NiIecsaioLgj4TK4on/nj+o41BI0kNQfCwRhIK5KC+y35gp00jVI1zTXtbl
	 gS30HBO7i752xjvQ/lP2vXQiAUfRE4wbgbbZEAwD9Dqaw0a5v8UTYolMIZgmkCkIpi
	 2fCOTYb6AzJMU3gbWICYqjYhu8hcQFjAG8ZLujNWNJD60svAgPl4WmrXlzfQvvexmJ
	 IYVsP7QTX7OKA==
Date: Wed, 21 May 2025 15:46:25 -0700
Subject: [PATCH 05/10] fuse2fs: make norecovery behavior consistent with the
 kernel
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174786678781.1385354.18340518510462370135.stgit@frogsfrogsfrogs>
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
index e1202fe6ce4a46..364d26a4e0e00e 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -692,13 +692,12 @@ static void close_fs(struct fuse2fs *ff)
 static errcode_t open_fs(struct fuse2fs *ff, int libext2_flags)
 {
 	char options[128];
-	int flags = EXT2_FLAG_64BITS | EXT2_FLAG_THREADS | libext2_flags;
+	int flags = EXT2_FLAG_64BITS | EXT2_FLAG_THREADS | EXT2_FLAG_RW |
+		    libext2_flags;
 	errcode_t err;
 
 	snprintf(options, sizeof(options) - 1, "offset=%lu", ff->offset);
 
-	if (!ff->norecovery)
-		flags |= EXT2_FLAG_RW;
 	if (ff->directio)
 		flags |= EXT2_FLAG_DIRECT_IO;
 
@@ -759,6 +758,22 @@ static errcode_t check_fs_supported(struct fuse2fs *ff)
 	return 0;
 }
 
+static int check_norecovery(struct fuse2fs *ff)
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
 static errcode_t mount_fs(struct fuse2fs *ff)
 {
 	ext2_filsys fs = ff->fs;
@@ -4702,6 +4717,12 @@ int main(int argc, char *argv[])
 	if (ext2fs_has_feature_shared_blocks(fctx.fs->super))
 		fctx.ro = 1;
 
+	if (fctx.norecovery) {
+		ret = check_norecovery(&fctx);
+		if (ret)
+			goto out;
+	}
+
 	err = mount_fs(&fctx);
 	if (err) {
 		ret = 32;


