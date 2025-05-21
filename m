Return-Path: <linux-ext4+bounces-8132-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FFBAC0008
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0DBC1BC1B62
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 22:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4522356B4;
	Wed, 21 May 2025 22:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ujsqQzxp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359E31B0F20
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 22:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747867727; cv=none; b=kSyZ82bQgOCsHq4nRywH48nmilocULMyxXYTqLf5Na4oCfdSK51+zr9KLUsOdt9URgAY4QXn5Sp1X/5H0ji54PnAFGnGru99frhukJQHhGkj/Bu/yxSkGkmbQRXfPmk7c5kd3AWw/85P8CnJ4/YDk2szL4HCZZS5JR47+C8+a5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747867727; c=relaxed/simple;
	bh=qszYKSY1EamRZD0B+uOyoFVkT0UpGKdbkBQcT63qowk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jAmXEwI82r6gW31LsHIOIEvK9WSbKIzzXK8BKAQSJX1LtQMODt7bGprOY73DZGI2ROFLRXFbvH2LsqbvLqdFmsLvRpNj6Nirssmjk8mAifpRq7iCi2O/lqVwSDk1/XWQOUWRSVS7EL5Gqk2a+MNGEheMyvA254W1i1phGpQxMho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ujsqQzxp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB82C4CEE4;
	Wed, 21 May 2025 22:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747867727;
	bh=qszYKSY1EamRZD0B+uOyoFVkT0UpGKdbkBQcT63qowk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ujsqQzxpmwV10xOyDTr/hJf7YGabuIPdq7+/73waoJv1F6D72HZQrZ+V2ylFpr+YR
	 LyOvBLzQ0rDSOxdZhAyFPgH2gQfHiSEfVEuTQ+jZchZQERBgCcfs4UiIJmhOvSJYMf
	 O7v8mxDSCFwXCAl1C7c1x2y7gG+FieYD0qhuCQ0nd5m2eyBp4gAPp5NrqON5LmkIF1
	 Pspc6+cEH5rF/fs47AYWJXcE4DxnSKsCsmI7sQL/Z9ZqDlJflwzwIEByVGRlOS4VmP
	 VcggwMKTm8ifQXIycjSAziqX5vWE5ciZxZkza/aFgYBWUq2Q2ab9CVFDB8J1VHK32q
	 J5rwNOSTFt5xQ==
Date: Wed, 21 May 2025 15:48:46 -0700
Subject: [PATCH 4/4] fuse2fs: print the function name in error messages,
 not the file name
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174786679077.1385778.80472067011360869.stgit@frogsfrogsfrogs>
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

It would be nice to know which fuse op actually causes failures such as:
FUSE2FS (sda4): Directory block checksum does not match directory block at ../../misc/fuse2fs.c:819.

The filename is utterly pointless, there's only one for the whole
daemon.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index fa7618adef48d1..54753c79abeb1d 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -196,9 +196,9 @@ struct fuse2fs {
 	__FUSE2FS_CHECK_CONTEXT((ff), return NULL)
 
 static int __translate_error(ext2_filsys fs, ext2_ino_t ino, errcode_t err,
-			     const char *file, int line);
+			     const char *func, int line);
 #define translate_error(fs, ino, err) __translate_error((fs), (ino), (err), \
-			__FILE__, __LINE__)
+			__func__, __LINE__)
 
 /* for macosx */
 #ifndef W_OK
@@ -5043,7 +5043,7 @@ int main(int argc, char *argv[])
 }
 
 static int __translate_error(ext2_filsys fs, ext2_ino_t ino, errcode_t err,
-			     const char *file, int line)
+			     const char *func, int line)
 {
 	struct timespec now;
 	int ret = err;
@@ -5158,10 +5158,10 @@ static int __translate_error(ext2_filsys fs, ext2_ino_t ino, errcode_t err,
 
 	if (ino)
 		err_printf(ff, "%s (inode #%d) at %s:%d.\n",
-			error_message(err), ino, file, line);
+			error_message(err), ino, func, line);
 	else
 		err_printf(ff, "%s at %s:%d.\n",
-			error_message(err), file, line);
+			error_message(err), func, line);
 
 	/* Make a note in the error log */
 	get_now(&now);
@@ -5169,14 +5169,14 @@ static int __translate_error(ext2_filsys fs, ext2_ino_t ino, errcode_t err,
 	fs->super->s_last_error_ino = ino;
 	fs->super->s_last_error_line = line;
 	fs->super->s_last_error_block = err; /* Yeah... */
-	strncpy((char *)fs->super->s_last_error_func, file,
+	strncpy((char *)fs->super->s_last_error_func, func,
 		sizeof(fs->super->s_last_error_func));
 	if (ext2fs_get_tstamp(fs->super, s_first_error_time) == 0) {
 		ext2fs_set_tstamp(fs->super, s_first_error_time, now.tv_sec);
 		fs->super->s_first_error_ino = ino;
 		fs->super->s_first_error_line = line;
 		fs->super->s_first_error_block = err;
-		strncpy((char *)fs->super->s_first_error_func, file,
+		strncpy((char *)fs->super->s_first_error_func, func,
 			sizeof(fs->super->s_first_error_func));
 	}
 


