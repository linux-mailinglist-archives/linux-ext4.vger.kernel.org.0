Return-Path: <linux-ext4+bounces-11593-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 150BCC3DA3D
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8BB23A591D
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308BE32AAD4;
	Thu,  6 Nov 2025 22:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3jBr78z"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88902DBF4B
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468808; cv=none; b=fQh5lloWebmaE9cqLocEeHb9OFivAliZXgrpgx0Px9KH1zRqnT34bhah6szObtPBr3G0kbScbXAAb0r4zbcaCXTds730zUEJRo30K0fSum/iQpk455y/fKbVQiyhshl5VaOEqsi3ntugXOZAA1g/Oec7xFqtOHMsE4Bf6k/oS20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468808; c=relaxed/simple;
	bh=Dvyd9H/ipotxnpyGHZvz6ZO90BSHGOIyIG0EEb29cCo=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JAkOR0mjpBK6LghhflXuW1xUUpjIO2hfIG/QGkx9qRxbPE10sTYjXSXOYPDIw9KQNv4tmN3/9BqItWjHDe7Acf160c1sHVBwlrIxJuj+tll5Ieqtjx9kKHsdep9YCVJB2YxzbDye0nendza3Z2Flslhi2HkmZVgoQhkJ3LkOhKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3jBr78z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B9BAC4CEFB;
	Thu,  6 Nov 2025 22:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762468808;
	bh=Dvyd9H/ipotxnpyGHZvz6ZO90BSHGOIyIG0EEb29cCo=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=S3jBr78zDH0upONVbKWxYXQOI4tdrGD+IHJ5VVjSB3fRjJbd7qYrucWHrBiQhzrL6
	 QcNkKIhvRrkv0kWlrGoHWAVI+2dg45X738BFikDhiCVxAL40pmACL7l4BTEobj+/Tm
	 uXrnYhybVSSw1WR/T7jT2OTJqLaWRQVMjcD+j/xlfa5afFRLQzcn77MyoJxUnMheLj
	 ECFl1ujf8nhDA6mhlMR4jIgrcMgXWrx9iBM6+Xb7TGM1zMS9SUqvvN9XNEGHL04XXp
	 Zm/jrQlPFbKqbpcE99jyEWY8xxkmsuuF0x3epPSHXoVLUA3tLjE4kQa0gttYHUfk4B
	 1wMYjFqnwqqBw==
Date: Thu, 06 Nov 2025 14:40:07 -0800
Subject: [PATCH 3/3] fuse2fs: adjust OOM killer score if possible
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246794705.2863550.4386662432074837729.stgit@frogsfrogsfrogs>
In-Reply-To: <176246794639.2863550.14252706802579101303.stgit@frogsfrogsfrogs>
References: <176246794639.2863550.14252706802579101303.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Users don't like it when their filesystems go down unexpectedly.  Set
the OOM score adjustment to -500 to try to prevent this, particularly
because fuse2fs doesn't support journal transactions.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 86e0222a51369a..d6be5e9968567c 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -242,6 +242,7 @@ struct fuse2fs {
 
 	int logfd;
 	int blocklog;
+	int oom_score_adj;
 	unsigned int blockmask;
 	unsigned long offset;
 	unsigned int next_generation;
@@ -5298,6 +5299,7 @@ static struct fuse_opt fuse2fs_opts[] = {
 	FUSE2FS_OPT("norecovery",	norecovery,		1),
 	FUSE2FS_OPT("noload",		norecovery,		1),
 	FUSE2FS_OPT("offset=%lu",	offset,			0),
+	FUSE2FS_OPT("oom_score_adj=%d",	oom_score_adj,		-500),
 	FUSE2FS_OPT("kernel",		kernel,			1),
 	FUSE2FS_OPT("directio",		directio,		1),
 	FUSE2FS_OPT("acl",		acl,			1),
@@ -5508,19 +5510,31 @@ static void try_set_io_flusher(struct fuse2fs *ff)
 #endif
 }
 
+/* Try to adjust the OOM score so that we don't get killed */
+static void try_adjust_oom_score(struct fuse2fs *ff)
+{
+	FILE *fp = fopen("/proc/self/oom_score_adj", "w+");
+
+	if (!fp)
+		return;
+
+	fprintf(fp, "%d\n", ff->oom_score_adj);
+	fclose(fp);
+}
+
 int main(int argc, char *argv[])
 {
 	struct fuse_args args = FUSE_ARGS_INIT(argc, argv);
-	struct fuse2fs fctx;
+	struct fuse2fs fctx = {
+		.magic = FUSE2FS_MAGIC,
+		.logfd = -1,
+		.bfl = (pthread_mutex_t)PTHREAD_MUTEX_INITIALIZER,
+		.oom_score_adj = -500,
+	};
 	errcode_t err;
 	FILE *orig_stderr = stderr;
 	int ret;
 
-	memset(&fctx, 0, sizeof(fctx));
-	fctx.magic = FUSE2FS_MAGIC;
-	fctx.logfd = -1;
-	fctx.bfl = (pthread_mutex_t)PTHREAD_MUTEX_INITIALIZER;
-
 	ret = fuse_opt_parse(&args, &fctx, fuse2fs_opts, fuse2fs_opt_proc);
 	if (ret)
 		exit(1);
@@ -5554,6 +5568,7 @@ int main(int argc, char *argv[])
 	}
 
 	try_set_io_flusher(&fctx);
+	try_adjust_oom_score(&fctx);
 
 	/* Will we allow users to allocate every last block? */
 	if (getenv("FUSE2FS_ALLOC_ALL_BLOCKS")) {


