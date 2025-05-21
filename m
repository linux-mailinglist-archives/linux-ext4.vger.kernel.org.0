Return-Path: <linux-ext4+bounces-8081-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C85ABFF9C
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27C807A5200
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 22:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7F9239E62;
	Wed, 21 May 2025 22:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrxicfgP"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FABD2B9A9
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 22:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747866927; cv=none; b=Fd6DzwkN/eYomaMtFoVZHouiJoImEV3NBK3VobcgjQ/Q+B3lLb351iX4PDWEdhs7xwBs8TLnwaqeQzmSPx0x2jFCSnhxeWyutY/RHl93MhLr/slMNBBiRrM2ap3tfJ0aVCs+T3Z1J/pgr1VADbA5NPKw22NC0w7InAtZsFirfGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747866927; c=relaxed/simple;
	bh=e4xqqyWIP2HqhDAfhEWJ9RKQSFC5Zqg1KTZpeUW+sqA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iQepb2FJObZDQCvrK9qolT65I0aazZ612yLre147XEZ9X87390SaScmF/jjkn2mYxtZOj8WKFF8O2qeXJwB77mdoUTc6mtBxpsphVcswN6/TRxVBSEBko+X/Bc76EDNPiwCOjDtU96T2Q3SisWnTiZzgoxCkhhNrrZue/cz0bEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrxicfgP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3CB6C4CEE4;
	Wed, 21 May 2025 22:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747866926;
	bh=e4xqqyWIP2HqhDAfhEWJ9RKQSFC5Zqg1KTZpeUW+sqA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=lrxicfgPHMMNRXUpDnSSaCrRGvWDOFKz4wQTQ4JLnOcPJWfwNqrRoyaSuwEjiMP86
	 29AZfWzLGoD90604KKBwg4GDiOTvKMiOHZKl+bfzUL5hMMZQHE1Y/m7y8TQFklYpEP
	 JdCy8jpfpiE9wQ0EFbsYh77z/kj+6iS2IVT3uAkitAhsdKu+nnGluPjTv4lc6B5jai
	 aI/S+uaGn6icGQwieU8M97afdF94Zmnbkhr34Qru7tMml9WM/5WfqUvJPdBBzsVNyp
	 lrBoD8ZCQn9AfnSTQs8PPIhNvzcrsvd2qMa0foTYTbx2GhOfZaNa1emqRhuLbyKdfw
	 Q1MRqOfYomTTg==
Date: Wed, 21 May 2025 15:35:26 -0700
Subject: [PATCH 02/29] libext2fs: fix livelock in the unix io manager
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <174786677584.1383760.1107858755678329558.stgit@frogsfrogsfrogs>
In-Reply-To: <174786677421.1383760.15289906755026332870.stgit@frogsfrogsfrogs>
References: <174786677421.1383760.15289906755026332870.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

generic/441 found a livelock in the unix IO manager.  Let's say that
write_primary_superblock decides to call io_channel_set_blksize in the
process of writing the primary super.

unix_set_blksize then takes the cache and bounce mutexes, and calls
flush_cached_blocks.  If there are dirty blocks in the cache, they will
be written with raw_write_blk.  Unfortunately, that function tries to
take the bounce mutex, which we already hold.  At that point, we
livelock fuse2fs.

Cc: <linux-ext4@vger.kernel.org> # v1.46.0
Fixes: f20627cc639ab6 ("libext2fs: add threading support to the I/O manager abstraction")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/ext2fs/unix_io.c |   25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)


diff --git a/lib/ext2fs/unix_io.c b/lib/ext2fs/unix_io.c
index b98c44a84bb0af..be70fee38890c8 100644
--- a/lib/ext2fs/unix_io.c
+++ b/lib/ext2fs/unix_io.c
@@ -344,7 +344,8 @@ static errcode_t raw_read_blk(io_channel channel,
 	return retval;
 }
 
-#define RAW_WRITE_NO_HANDLER	1
+#define RAW_WRITE_NO_HANDLER	(1U << 0)
+#define RAW_WRITE_NOLOCK	(1U << 1)
 
 static errcode_t raw_write_blk(io_channel channel,
 			       struct unix_private_data *data,
@@ -404,13 +405,15 @@ static errcode_t raw_write_blk(io_channel channel,
 	    (IS_ALIGNED(buf, channel->align) &&
 	     IS_ALIGNED(location, channel->align) &&
 	     IS_ALIGNED(size, channel->align))) {
-		mutex_lock(data, BOUNCE_MTX);
+		if (!(flags & RAW_WRITE_NOLOCK))
+			mutex_lock(data, BOUNCE_MTX);
 		if (ext2fs_llseek(data->dev, location, SEEK_SET) < 0) {
 			retval = errno ? errno : EXT2_ET_LLSEEK_FAILED;
 			goto error_unlock;
 		}
 		actual = write(data->dev, buf, size);
-		mutex_unlock(data, BOUNCE_MTX);
+		if (!(flags & RAW_WRITE_NOLOCK))
+			mutex_unlock(data, BOUNCE_MTX);
 		if (actual < 0) {
 			retval = errno;
 			goto error_out;
@@ -445,7 +448,8 @@ static errcode_t raw_write_blk(io_channel channel,
 	while (size > 0) {
 		int actual_w;
 
-		mutex_lock(data, BOUNCE_MTX);
+		if (!(flags & RAW_WRITE_NOLOCK))
+			mutex_lock(data, BOUNCE_MTX);
 		if (size < align_size || offset) {
 			if (ext2fs_llseek(data->dev, aligned_blk * align_size,
 					  SEEK_SET) < 0) {
@@ -474,7 +478,8 @@ static errcode_t raw_write_blk(io_channel channel,
 			goto error_unlock;
 		}
 		actual_w = write(data->dev, data->bounce, align_size);
-		mutex_unlock(data, BOUNCE_MTX);
+		if (!(flags & RAW_WRITE_NOLOCK))
+			mutex_unlock(data, BOUNCE_MTX);
 		if (actual_w < 0) {
 			retval = errno;
 			goto error_out;
@@ -490,7 +495,8 @@ static errcode_t raw_write_blk(io_channel channel,
 	return 0;
 
 error_unlock:
-	mutex_unlock(data, BOUNCE_MTX);
+	if (!(flags & RAW_WRITE_NOLOCK))
+		mutex_unlock(data, BOUNCE_MTX);
 error_out:
 	if (((flags & RAW_WRITE_NO_HANDLER) == 0) && channel->write_error)
 		retval = (channel->write_error)(channel, block, count, buf,
@@ -673,9 +679,14 @@ static errcode_t flush_cached_blocks(io_channel channel,
 		if (!cache->in_use)
 			continue;
 		if (cache->dirty) {
+			int raw_flags = RAW_WRITE_NO_HANDLER;
+
+			if (flags & FLUSH_NOLOCK)
+				raw_flags |= RAW_WRITE_NOLOCK;
+
 			retval = raw_write_blk(channel, data,
 					       cache->block, 1, cache->buf,
-					       RAW_WRITE_NO_HANDLER);
+					       raw_flags);
 			if (retval) {
 				cache->write_err = 1;
 				errors_found = 1;


