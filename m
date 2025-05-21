Return-Path: <linux-ext4+bounces-8130-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D025AC0006
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6E717B22C5
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 22:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D02B23A9BD;
	Wed, 21 May 2025 22:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oChoadmQ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E489E23A994
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 22:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747867696; cv=none; b=s97YDv+7e7XWhLzXelGhzmOaJdEMW+VyRI/C38q8fkUxdFzj1hvf8QkhDEYGm9iymcGibvd++9QBNf2HZZy6XCsV4IPfu4rt9WeFqTIiAuohhutcUz9r3AvNYn5aETkT1M9ezaQVYgGYfgp4WHSHTwOOrhCs9gweUFuGZ1YZbr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747867696; c=relaxed/simple;
	bh=Rq0/In7APrBzqsf4z32Np9FoXovKKHim2a3dkU3v8dc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HvajnlXmzU4s3Nnmie62Udlno7UKW7HnnfObM+jaeeAgLG3DLW0/QiNVZnYhtQ9ol7MkOPVadXny3e+j8VZxySOZpYkMXt+5o7/jz2klUhYbTEMdHvn8WwRjQoqVn9H2WkdKFwvi0ndNGDCmGZn5AWFifNF0j9f8rNW/PfDaWzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oChoadmQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E2DC4CEE4;
	Wed, 21 May 2025 22:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747867695;
	bh=Rq0/In7APrBzqsf4z32Np9FoXovKKHim2a3dkU3v8dc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=oChoadmQJlQazfZxxZOH2rjhVkpPSOV9vdKPNSp5Q+aRSZHNY9xDlNpTf1c5XEM3Q
	 282zTCqM5wfCd12x1QmewQ6zL/XBY9Y+6RWaxWVu2nDXjONvBbDcDbiY9b0pto1IkY
	 klpb0ClmENm4gJihV6rT27YUo2qB7pUSYBI9+pDbUq8Nq6ptG/lyWXc/BNbVrsS+qo
	 KijzG287WG4aQAFLcUwLJMMfrPf8X4Bu7z0AOUeCh0jZ4gqdpdqSGn2dMCX8UfoYg5
	 WIv9BP7YzpdXBRgfp7lD8i6kKrUx3iuXy2gI8O4+iPFm+fuinaXWn5Ff6TuihINzrZ
	 glgz2zXDMPBZg==
Date: Wed, 21 May 2025 15:48:15 -0700
Subject: [PATCH 2/4] fuse2fs: hook library error message printing
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174786679041.1385778.13234110843946598675.stgit@frogsfrogsfrogs>
In-Reply-To: <174786678990.1385778.5352134289344525189.stgit@frogsfrogsfrogs>
References: <174786678990.1385778.5352134289344525189.stgit@frogsfrogsfrogs>
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
index cbe9afd4ba1290..d78ab5558b6182 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -127,6 +127,8 @@
 
 errcode_t ext2fs_run_ext3_journal(ext2_filsys *fs);
 
+const char *err_shortdev;
+
 #ifdef CONFIG_JBD_DEBUG		/* Enabled by configure --enable-jbd-debug */
 int journal_enable_debug = -1;
 #endif
@@ -4736,6 +4738,18 @@ static unsigned long long default_cache_size(void)
 	return ret;
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
@@ -4765,6 +4779,10 @@ int main(int argc, char *argv[])
 	else
 		fctx.shortdev = fctx.device;
 
+	/* capture library error messages */
+	err_shortdev = fctx.shortdev;
+	set_com_err_hook(fuse2fs_com_err_proc);
+
 #ifdef ENABLE_NLS
 	setlocale(LC_MESSAGES, "");
 	setlocale(LC_CTYPE, "");
@@ -4956,6 +4974,8 @@ int main(int argc, char *argv[])
 		fflush(orig_stderr);
 	}
 	close_fs(&fctx);
+	reset_com_err_hook();
+	err_shortdev = NULL;
 	if (fctx.device)
 		free(fctx.device);
 	fuse_opt_free_args(&args);


