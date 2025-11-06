Return-Path: <linux-ext4+bounces-11595-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3BEC3DA43
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 34AAE34E9C9
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1BC30B51B;
	Thu,  6 Nov 2025 22:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s2HzMRlr"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7EF2DBF4B
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468840; cv=none; b=UlKcCyYc+v5Pjc6u7PhfXX/FRvqrUPBJXxrXfcJ58zyMVEN3gkp/inA1uWje0VZSp7nwf2ApxbR3YfW/XrHKKn138Va57pHEc95tGMv39krhoXkynDRBOX6ufV1hsAy2Um8MgnU0OizwnTwcwfJuLU0vNi4sqLnmsytpHw7qcy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468840; c=relaxed/simple;
	bh=D5ryFnhJpTbZyZf7jDsVg/z/M4/b+v0bvFsEGMINM0E=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nw73E0Pa1sYEcBTXXwGyRlb8IkvAmOJoiJJPdnpHSRnimqE1J0FK2APWNC7AH/tSroS+223xwZtqE2/8wRYmfIcqB0icUEsA6xS+xIdHBZ9DIx2QpzyfmyaFPGVRgGYzKyen7W/vyPCZBsAhfoLfRR4htj4UWo5IG/4eBt3w1BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s2HzMRlr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C761C4CEFB;
	Thu,  6 Nov 2025 22:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762468840;
	bh=D5ryFnhJpTbZyZf7jDsVg/z/M4/b+v0bvFsEGMINM0E=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=s2HzMRlrQoM2qz3sACYqmGcTlri9It/NukSIyhbpU6c1d5Y3RZrLFwT9GZ8+hsRFV
	 aISMVchSpMI4kcc05dOEkbhB+OcQ7nNzSrr8GsVc+wtLNcwSFT8wLLISf58jJL03bQ
	 4+3CZd3B/t/k11qJ2u4BKEI75gEdoOiIU2QmcwDs7nvTA15fj7BCNTry+6WVXS4Fur
	 UWNvxlfUZSGzrdmRH9CUkp5zTQIFB9/QOWfecZ815szAx94cAvOkCYS+hv5c5iMfAz
	 bPT1CZ6fNeSRz8CZriq9wX6spBUN64loJ39lUvmQa5GmauQTdDIEvPY9uvHGUZiUhf
	 ZXnOetZGfiwRw==
Date: Thu, 06 Nov 2025 14:40:39 -0800
Subject: [PATCH 2/4] fuse2fs: print the function name in error messages,
 not the file name
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246794881.2863722.10893845967847592777.stgit@frogsfrogsfrogs>
In-Reply-To: <176246794829.2863722.7643052073534781800.stgit@frogsfrogsfrogs>
References: <176246794829.2863722.7643052073534781800.stgit@frogsfrogsfrogs>
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
index c2896de2316bce..cede10765f5c1b 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -293,9 +293,9 @@ struct fuse2fs {
 	__FUSE2FS_CHECK_CONTEXT((ff), abort())
 
 static int __translate_error(ext2_filsys fs, ext2_ino_t ino, errcode_t err,
-			     const char *file, int line);
+			     const char *func, int line);
 #define translate_error(fs, ino, err) __translate_error((fs), (ino), (err), \
-			__FILE__, __LINE__)
+			__func__, __LINE__)
 
 /* for macosx */
 #ifndef W_OK
@@ -5678,7 +5678,7 @@ int main(int argc, char *argv[])
 }
 
 static int __translate_error(ext2_filsys fs, ext2_ino_t ino, errcode_t err,
-			     const char *file, int line)
+			     const char *func, int line)
 {
 	struct timespec now;
 	int ret = err;
@@ -5805,10 +5805,10 @@ static int __translate_error(ext2_filsys fs, ext2_ino_t ino, errcode_t err,
 
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
@@ -5816,14 +5816,14 @@ static int __translate_error(ext2_filsys fs, ext2_ino_t ino, errcode_t err,
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
 


