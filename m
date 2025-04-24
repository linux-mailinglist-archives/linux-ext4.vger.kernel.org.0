Return-Path: <linux-ext4+bounces-7461-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8EAA9B9FC
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 23:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A08735A7D39
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 21:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F75721ADCB;
	Thu, 24 Apr 2025 21:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gox9FrvD"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235D0198851
	for <linux-ext4@vger.kernel.org>; Thu, 24 Apr 2025 21:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745530754; cv=none; b=J/YyILAFiEoHyD1icgttNmKxplMJWlLoWhqDxmLmhI4CkF+z2nCNY8ELvPNr9IAF2l4dU9dCTjS0zRo9FJHD3cPHmowAT5OcBlq+/D7VcnjrRjkDorCTRD8bSbcRJFyblMKpxJPiL+858Pw0nGaeDBPobDe8UrJvOi8ZhcXA3Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745530754; c=relaxed/simple;
	bh=mi56lLRubnxtJ6e9jiukPbRlKAVZGuVcHHaWsUxMvV8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lfLlv3jQF6MWkWh+D1/BvLVT11fLvYg5ifRnnAJKHZpBiF3f7rid+VA8najc4NSHvWMc4OWdwR2yHYgZ93xFowGjXF9DWHmOH45gV9W3zzUWYpvFh08iTsvn3RYRKdJ6g8KrTNr/b3VEr/SaYmM0lB2bbtDh8M/mNdz+KWq5Y5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gox9FrvD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C10C4CEE3;
	Thu, 24 Apr 2025 21:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745530754;
	bh=mi56lLRubnxtJ6e9jiukPbRlKAVZGuVcHHaWsUxMvV8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Gox9FrvD8BukoSSI4L/4RA8riTc6J4t483clq1T/HEXBS/KsqI5XSjVDlu+VPU37n
	 GaoS96/46hsKQPIwDtD4JfwJ42yqxd2WaBR3nOhiC/4R/FKukz7Lh3X4yaymqa6GD3
	 R/DanTbAMI1aHlRixO7OJYNOayXz7ipboyyzV/L9ee3L2yrtMpaOnCU2LLkjuHoxsd
	 wvOoKs5QKTfYqPdRt8KMpooS4XVNWCFZSc0Nd/LXqgOefljQa30IYnWpAdaGymCFOo
	 EAznG4cb5NfexMHsdpVM+i24BaOdZCObtEKNOUeQI9NcB8QQ1NAflN9CDXxTRUbuLO
	 0pmzHVuFOB1Ew==
Date: Thu, 24 Apr 2025 14:39:13 -0700
Subject: [PATCH 2/5] fuse2fs: stop aliasing stderr with ff->err_fp
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174553064491.1160047.2269966041756188067.stgit@frogsfrogsfrogs>
In-Reply-To: <174553064436.1160047.577374015997116030.stgit@frogsfrogsfrogs>
References: <174553064436.1160047.577374015997116030.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Remove this pointless aliasing of error stream pointers.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 18ae442c7ece03..f2d0e1f2441f83 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -89,6 +89,12 @@ static ext2_filsys global_fs; /* Try not to use this directly */
 		break; \
 	}
 
+#define err_printf(fuse2fs, format, ...) \
+	do { \
+		fprintf(stderr, "FUSE2FS (%s): " format, (fuse2fs)->shortdev, ##__VA_ARGS__); \
+		fflush(stderr); \
+	} while (0)
+
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(2, 8)
 # ifdef _IOR
 #  ifdef _IOW
@@ -344,7 +350,6 @@ struct fuse2fs {
 	int alloc_all_blocks;
 	int norecovery;
 	unsigned long offset;
-	FILE *err_fp;
 	unsigned int next_generation;
 };
 
@@ -3839,13 +3844,13 @@ int main(int argc, char *argv[])
 	/* Set up error logging */
 	logfile = getenv("FUSE2FS_LOGFILE");
 	if (logfile) {
-		fctx.err_fp = fopen(logfile, "a");
-		if (!fctx.err_fp) {
+		FILE *fp = fopen(logfile, "a");
+		if (!fp) {
 			perror(logfile);
 			goto out;
 		}
-	} else
-		fctx.err_fp = stderr;
+		stderr = fp;
+	}
 
 	/* Will we allow users to allocate every last block? */
 	if (getenv("FUSE2FS_ALLOC_ALL_BLOCKS")) {
@@ -4052,14 +4057,11 @@ static int __translate_error(ext2_filsys fs, errcode_t err, ext2_ino_t ino,
 		return ret;
 
 	if (ino)
-		fprintf(ff->err_fp, "FUSE2FS (%s): %s (inode #%d) at %s:%d.\n",
-			fs->device_name ? fs->device_name : "???",
+		err_printf(ff, "%s (inode #%d) at %s:%d.\n",
 			error_message(err), ino, file, line);
 	else
-		fprintf(ff->err_fp, "FUSE2FS (%s): %s at %s:%d.\n",
-			fs->device_name ? fs->device_name : "???",
+		err_printf(ff, "%s at %s:%d.\n",
 			error_message(err), file, line);
-	fflush(ff->err_fp);
 
 	/* Make a note in the error log */
 	get_now(&now);


