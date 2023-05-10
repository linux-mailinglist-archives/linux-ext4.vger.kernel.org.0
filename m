Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5D26FD614
	for <lists+linux-ext4@lfdr.de>; Wed, 10 May 2023 07:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjEJFTD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 10 May 2023 01:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjEJFTC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 10 May 2023 01:19:02 -0400
Received: from omta002.cacentral1.a.cloudfilter.net (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C1F2683
        for <linux-ext4@vger.kernel.org>; Tue,  9 May 2023 22:19:00 -0700 (PDT)
Received: from shw-obgw-4002a.ext.cloudfilter.net ([10.228.9.250])
        by cmsmtp with ESMTP
        id wUGqpqcG36NwhwcE8p6ZB2; Wed, 10 May 2023 05:19:00 +0000
Received: from centos7.adilger.int ([70.77.221.9])
        by cmsmtp with ESMTP
        id wcE7pOqEuyAOewcE7pauLm; Wed, 10 May 2023 05:19:00 +0000
X-Authority-Analysis: v=2.4 cv=e5oV9Il/ c=1 sm=1 tr=0 ts=645b2944
 a=2Y6h5+ypAxmHcsumz2f7Og==:117 a=2Y6h5+ypAxmHcsumz2f7Og==:17 a=RPJ6JBhKAAAA:8
 a=Zv9RFgW65yl-G-HOgCIA:9 a=fa_un-3J20JGBB2Tu-mn:22
From:   Andreas Dilger <adilger@dilger.ca>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org, Andreas Dilger <adilger@dilger.ca>
Subject: [PATCH] ext2fs: don't retry discard/zeroout repeatedly
Date:   Tue,  9 May 2023 23:18:49 -0600
Message-Id: <1683695929-26972-1-git-send-email-adilger@dilger.ca>
X-Mailer: git-send-email 1.8.3.1
X-CMAE-Envelope: MS4xfE4W9GitLCGOpQgrlezNlX5AVtU1mSii4Ge89hIpgSTI4JLQwbKA4w52rQHxbSUJEekrxQLk0rH9IAfRwSfIhaGyo2O1x9bHyMJTJJwz1pcgyeBJNI4Z
 pff6jsNz3aAz2E6fCVYz0qp19xLXCpAKURS/5dG+TVE5SrmaeB01/Oke7Tqrb2++5QqEKKsLVf5dS31XYk0S/RK7zPYLQ+KsGiFxIuSVMpULyeQMsKcT6+CN
 UX2DAOOXP4U2xc0IySTWUQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Call safe_getenv(UNIX_IO_NOZEROOUT) once when the device is
opened and set CHANNEL_FLAG_NOZEROOUT if present instead of
getting uid/euid/getenv every time unix_zeroout() is called.

For unix_discard() and unix_zeroout() don't continue to call
them if the block device doesn't support these operations.

Signed-off-by: Andreas Dilger <adilger@dilger.ca>
---
 lib/ext2fs/ext2_io.h |  4 +++-
 lib/ext2fs/unix_io.c | 43 ++++++++++++++++++++++++++-----------------
 2 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/lib/ext2fs/ext2_io.h b/lib/ext2fs/ext2_io.h
index 679184e393f1..27eaaf1be354 100644
--- a/lib/ext2fs/ext2_io.h
+++ b/lib/ext2fs/ext2_io.h
@@ -34,6 +34,8 @@ typedef struct struct_io_stats *io_stats;
 #define CHANNEL_FLAGS_DISCARD_ZEROES	0x02
 #define CHANNEL_FLAGS_BLOCK_DEVICE	0x04
 #define CHANNEL_FLAGS_THREADS		0x08
+#define CHANNEL_FLAGS_NODISCARD		0x10
+#define CHANNEL_FLAGS_NOZEROOUT		0x20
 
 #define io_channel_discard_zeroes_data(i) (i->flags & CHANNEL_FLAGS_DISCARD_ZEROES)
 
@@ -57,7 +59,7 @@ struct struct_io_channel {
 				       int actual_bytes_written,
 				       errcode_t error);
 	int		refcount;
-	int		flags;
+	unsigned int	flags;
 	long		reserved[14];
 	void		*private_data;
 	void		*app_data;
diff --git a/lib/ext2fs/unix_io.c b/lib/ext2fs/unix_io.c
index 3171c7368feb..33c5d568656c 100644
--- a/lib/ext2fs/unix_io.c
+++ b/lib/ext2fs/unix_io.c
@@ -761,6 +761,9 @@ static errcode_t unix_open_channel(const char *name, int fd,
 	io->refcount = 1;
 	io->flags = 0;
 
+	if (safe_getenv("UNIX_IO_NOZEROOUT"))
+		io->flags |= CHANNEL_FLAGS_NOZEROOUT;
+
 	memset(data, 0, sizeof(struct unix_private_data));
 	data->magic = EXT2_ET_MAGIC_UNIX_IO_CHANNEL;
 	data->io_stats.num_fields = 2;
@@ -783,20 +786,19 @@ static errcode_t unix_open_channel(const char *name, int fd,
 	 * zero.
 	 */
 	if (ext2fs_fstat(data->dev, &st) == 0) {
-		if (ext2fsP_is_disk_device(st.st_mode))
-			io->flags |= CHANNEL_FLAGS_BLOCK_DEVICE;
-		else
-			io->flags |= CHANNEL_FLAGS_DISCARD_ZEROES;
-	}
-
+		if (ext2fsP_is_disk_device(st.st_mode)) {
 #ifdef BLKDISCARDZEROES
-	{
-		int zeroes = 0;
-		if (ioctl(data->dev, BLKDISCARDZEROES, &zeroes) == 0 &&
-		    zeroes)
+			int zeroes = 0;
+
+			if (ioctl(data->dev, BLKDISCARDZEROES, &zeroes) == 0 &&
+			    zeroes)
+				io->flags |= CHANNEL_FLAGS_DISCARD_ZEROES;
+#endif
+			io->flags |= CHANNEL_FLAGS_BLOCK_DEVICE;
+		} else {
 			io->flags |= CHANNEL_FLAGS_DISCARD_ZEROES;
+		}
 	}
-#endif
 
 #if defined(__CYGWIN__)
 	/*
@@ -1344,12 +1346,15 @@ static errcode_t unix_discard(io_channel channel, unsigned long long block,
 			      unsigned long long count)
 {
 	struct unix_private_data *data;
-	int		ret;
+	int		ret = EOPNOTSUPP;
 
 	EXT2_CHECK_MAGIC(channel, EXT2_ET_MAGIC_IO_CHANNEL);
 	data = (struct unix_private_data *) channel->private_data;
 	EXT2_CHECK_MAGIC(data, EXT2_ET_MAGIC_UNIX_IO_CHANNEL);
 
+	if (channel->flags & CHANNEL_FLAGS_NODISCARD)
+		goto unimplemented;
+
 	if (channel->flags & CHANNEL_FLAGS_BLOCK_DEVICE) {
 #ifdef BLKDISCARD
 		__u64 range[2];
@@ -1376,8 +1381,10 @@ static errcode_t unix_discard(io_channel channel, unsigned long long block,
 #endif
 	}
 	if (ret < 0) {
-		if (errno == EOPNOTSUPP)
+		if (errno == EOPNOTSUPP) {
+			channel->flags |= CHANNEL_FLAGS_NODISCARD;
 			goto unimplemented;
+		}
 		return errno;
 	}
 	return 0;
@@ -1425,9 +1432,6 @@ static errcode_t unix_zeroout(io_channel channel, unsigned long long block,
 	data = (struct unix_private_data *) channel->private_data;
 	EXT2_CHECK_MAGIC(data, EXT2_ET_MAGIC_UNIX_IO_CHANNEL);
 
-	if (safe_getenv("UNIX_IO_NOZEROOUT"))
-		goto unimplemented;
-
 	if (!(channel->flags & CHANNEL_FLAGS_BLOCK_DEVICE)) {
 		/* Regular file, try to use truncate/punch/zero. */
 		struct stat statbuf;
@@ -1450,13 +1454,18 @@ static errcode_t unix_zeroout(io_channel channel, unsigned long long block,
 		}
 	}
 
+	if (channel->flags & CHANNEL_FLAGS_NOZEROOUT)
+		goto unimplemented;
+
 	ret = __unix_zeroout(data->dev,
 			(off_t)(block) * channel->block_size + data->offset,
 			(off_t)(count) * channel->block_size);
 err:
 	if (ret < 0) {
-		if (errno == EOPNOTSUPP)
+		if (errno == EOPNOTSUPP) {
+			channel->flags |= CHANNEL_FLAGS_NOZEROOUT;
 			goto unimplemented;
+		}
 		return errno;
 	}
 	return 0;
-- 
1.8.3.1

