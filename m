Return-Path: <linux-ext4+bounces-10100-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB9FB588CA
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 02:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEE5B188D25D
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 00:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BD44C9F;
	Tue, 16 Sep 2025 00:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+sy3jMy"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E025214F70
	for <linux-ext4@vger.kernel.org>; Tue, 16 Sep 2025 00:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757981042; cv=none; b=etvUzXMqd+eevdwIph+OSY+xJwBFwYqvh9mGLE2VL/qS+Y/b4mzF2pTGbnTet0XuGS1m6L95KH+8S2T/wGMHciSols4Rju9lY51VPNWDf3UsTlNwl8gv3ZgEFFpL6g0HBAQ7qMUUVqDyesopC0jOTH6WviDDKFBubp9/oRN7L2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757981042; c=relaxed/simple;
	bh=F3XLffjrImF+mNFrP5FptwxqmaFN4LbDe3jVhfCrp4s=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uyBuTt5cKY465a1FmOBavOoegd4pU0FlpsSE+p2Bef9W2HR20cfLKZ9JfA+00lNUyhwh3vYDQKM5aUfJUFAaWmXG4XdQGDhWqTSgvZfatQ06TOZHtgsfuYsnBXSnPusWusnyteq3wu9PHjZu+XP03gopciS7cKhY2w9N3NRB7NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+sy3jMy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5F5CC4CEF1;
	Tue, 16 Sep 2025 00:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757981041;
	bh=F3XLffjrImF+mNFrP5FptwxqmaFN4LbDe3jVhfCrp4s=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=M+sy3jMyQKH0e3pr02OB5CjpxHrfgNC3I08Ro8Kc7pdwGLSWyxDmR8dTBqsMdmnuI
	 gASP+Ur+j388/NeYLr7QnkrtnfzcK8esk+DWLvvT5be9A7gVbkPcD8P9fBs+pHV5KJ
	 wL1p9S3kX1cPvlo3GlYQAyMTxlqUuViN5sA2+t1qi5bQQlwGp0yXeL4M1ZLpsgzh0x
	 K4AQ0t2C8ir5OmYy7aHa3E4DDrspGNBwp1ARKR2GXz0yDfCUvaPDDs7/oLVEd0DHCd
	 I7q4c7LkETdpDCzqZxL8wUD6EmQEVEwH91ZJRXV2zKNYCGPAric5tfev+5c4rbiCBP
	 2ZkO1a6hVbszQ==
Date: Mon, 15 Sep 2025 17:04:01 -0700
Subject: [PATCH 2/5] fuse2fs: hook library error message printing
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <175798064968.350149.12407637697198806921.stgit@frogsfrogsfrogs>
In-Reply-To: <175798064915.350149.2906646381396770725.stgit@frogsfrogsfrogs>
References: <175798064915.350149.2906646381396770725.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Hook the com_err library so that error messages coming from libext2fs
such as:
Illegal block number passed to ext2fs_test_block_bitmap #9462 for block bitmap for /dev/sda

are actually printed with the standard "FUSE2FS (sda):" prefix.
Libraries shouldn't be printing that kind of stuff, but it is what it
is, and what it is is against the normal conventions.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 1789fbf86c7578..5e8581438aa9d7 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -200,6 +200,8 @@ static inline uint64_t round_down(uint64_t b, unsigned int align)
 
 errcode_t ext2fs_run_ext3_journal(ext2_filsys *fs);
 
+const char *err_shortdev;
+
 #ifdef CONFIG_JBD_DEBUG		/* Enabled by configure --enable-jbd-debug */
 int journal_enable_debug = -1;
 #endif
@@ -5168,6 +5170,18 @@ static inline bool fuse2fs_want_fuseblk(const struct fuse2fs *ff)
 	return fuse2fs_on_bdev(ff);
 }
 
+static void fuse2fs_com_err_proc(const char *whoami, errcode_t code,
+				 const char *fmt, va_list args)
+{
+	fprintf(stderr, "FUSE2FS (%s): ", err_shortdev ? err_shortdev : "?");
+	if (whoami)
+		fprintf(stderr, "%s: ", whoami);
+	fprintf(stderr, "%s ", error_message(code));
+        vfprintf(stderr, fmt, args);
+	fprintf(stderr, "\n");
+	fflush(stderr);
+}
+
 int main(int argc, char *argv[])
 {
 	struct fuse_args args = FUSE_ARGS_INIT(argc, argv);
@@ -5197,6 +5211,10 @@ int main(int argc, char *argv[])
 	else
 		fctx.shortdev = fctx.device;
 
+	/* capture library error messages */
+	err_shortdev = fctx.shortdev;
+	set_com_err_hook(fuse2fs_com_err_proc);
+
 #ifdef ENABLE_NLS
 	setlocale(LC_MESSAGES, "");
 	setlocale(LC_CTYPE, "");
@@ -5390,6 +5408,8 @@ int main(int argc, char *argv[])
 		fflush(orig_stderr);
 	}
 	fuse2fs_unmount(&fctx);
+	reset_com_err_hook();
+	err_shortdev = NULL;
 	if (fctx.device)
 		free(fctx.device);
 	fuse_opt_free_args(&args);


