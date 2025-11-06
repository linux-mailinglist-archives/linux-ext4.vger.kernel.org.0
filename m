Return-Path: <linux-ext4+bounces-11590-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6443C3DA31
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BCA818855C4
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528A4308F11;
	Thu,  6 Nov 2025 22:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JyvgNyQ1"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F1D2E0934
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468761; cv=none; b=s6JU6ioYawq/6rgYJ6MzRuRtse9U5Pg4kQggC+fG+Zqc241h5flQqBQnltIgKcbiS4AdKn5LDj0Hpk/FMwP5o/dXIfmiOWqdLj0XYFKJTLuX+AwN2jYEWzc9Hj6Xkx55dHAEnDV6XAL5TPc/mykaMQVTo5uOLQC1LQ0l2zOAlZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468761; c=relaxed/simple;
	bh=aVFJZgbKKFSVOq79VH4UzPnicWn3E010sjA4tEN0Xa8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YzAL9VjpIDZrrJzJ031sEZzSjfyhn8oKwe6Hsi/cIr4CAqzmfc0Iy6i8rnnvP+4Veh7N1KLzOMdA0I1Q0NO1N8Qq/0qtVneoKat9ukuLormpqPnVrHuRDFChXcI3rgBclkddB9giCYxWYx3tVW1jJZ2xSv+q1Du6Kv2hi7l98uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JyvgNyQ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65763C116C6;
	Thu,  6 Nov 2025 22:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762468760;
	bh=aVFJZgbKKFSVOq79VH4UzPnicWn3E010sjA4tEN0Xa8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=JyvgNyQ10nIlrKOIyZctiRb1vDJG2dNBjuYU0BsRqDz08kvkQBY1Y30fqwQ9Rt415
	 zKhp+whOI1snUsmSD+76Nz8zPlg/A/DQLfp7BWfPdigh8oZLz05VEG4XkWxFULPgGY
	 y7KW7ALLOZmdy2q4YGvxveXzWoCwI6aUcDHK5yGn4OPTSC+9u67mJPTFFB6z97aW6Z
	 kE0wBnXajLEWkS0U1EarpaKwGjVo+XoWl7n6rHj5hjn7kMj9Lp/pYebQvUNg1pTLsD
	 t9Zdt5maOAyF8UfIiSCvg8eJIDxf2NyA/D6TGq9U1wAEs8dAT7mqFeZ2U0fkS+167X
	 a7n38EriZe8/g==
Date: Thu, 06 Nov 2025 14:39:19 -0800
Subject: [PATCH 3/3] fuse2fs: hoist unmount code from main
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246794515.2863378.3895794572865503509.stgit@frogsfrogsfrogs>
In-Reply-To: <176246794450.2863378.4457886029233676166.stgit@frogsfrogsfrogs>
References: <176246794450.2863378.4457886029233676166.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Hoist the unmount code into a separate function so that we can reduce
the complexity of main().  This also sets us up for unmounting the
filesystem from op_destroy, which we'll need for fuse2fs+iomap mode to
maintain the expected behavior that the block device is free when
umount(8) returns.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index cefc6442ae45ec..b096c3f496d740 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1095,6 +1095,27 @@ static void fuse2fs_release_lockfile(struct fuse2fs *ff)
 	free(ff->lockfile);
 }
 
+static void fuse2fs_unmount(struct fuse2fs *ff)
+{
+	char uuid[UUID_STR_SIZE];
+	errcode_t err;
+
+	if (ff->fs) {
+		uuid_unparse(ff->fs->super->s_uuid, uuid);
+		err = ext2fs_close_free(&ff->fs);
+		if (err)
+			err_printf(ff, "%s: %s\n", _("while closing fs"),
+				   error_message(err));
+
+		if (ff->kernel)
+			log_printf(ff, "%s %s.\n", _("unmounted filesystem"),
+				   uuid);
+	}
+
+	if (ff->lockfile)
+		fuse2fs_release_lockfile(ff);
+}
+
 static void op_destroy(void *p EXT2FS_ATTR((unused)))
 {
 	struct fuse2fs *ff = fuse2fs_get();
@@ -1133,13 +1154,6 @@ static void op_destroy(void *p EXT2FS_ATTR((unused)))
 				(stats->cache_hits + stats->cache_misses));
 	}
 
-	if (ff->kernel) {
-		char uuid[UUID_STR_SIZE];
-
-		uuid_unparse(fs->super->s_uuid, uuid);
-		log_printf(ff, "%s %s.\n", _("unmounting filesystem"), uuid);
-	}
-
 	fuse2fs_finish(ff, 0);
 }
 
@@ -5561,13 +5575,7 @@ int main(int argc, char *argv[])
 		fflush(orig_stderr);
 	}
 	fuse2fs_mmp_destroy(&fctx);
-	if (fctx.fs) {
-		err = ext2fs_close_free(&fctx.fs);
-		if (err)
-			com_err(argv[0], err, "while closing fs");
-	}
-	if (fctx.lockfile)
-		fuse2fs_release_lockfile(&fctx);
+	fuse2fs_unmount(&fctx);
 	if (fctx.device)
 		free(fctx.device);
 	pthread_mutex_destroy(&fctx.bfl);


