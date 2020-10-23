Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D485296DAA
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Oct 2020 13:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S462959AbgJWL1X (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 23 Oct 2020 07:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S462917AbgJWL1X (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 23 Oct 2020 07:27:23 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A3FC0613CE
        for <linux-ext4@vger.kernel.org>; Fri, 23 Oct 2020 04:27:22 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id m20so1179378ljj.5
        for <linux-ext4@vger.kernel.org>; Fri, 23 Oct 2020 04:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=o610TAWzvyPonwyhymse6BdsrWyjrIXp6XT6ReWAx6A=;
        b=ZQtPBwe6EtE8vpbwkqUwOnBEbhKUmAIjLyEQuasxo9sZc+8LKQ1VfpWOIoiP9WyNk1
         UiZCx9PzkN+PAuozG7Gxndi4a+xCkNlIeZAa34BS6P3LYlcYJn0fRZByZsTaRBotjPqB
         DnXNAQHVpL7I9uh+XDKsp9MSlZFYXUhk2dFIBru/T+rAo9klrHSFQROl8a1pFDTwhC4I
         W0YkjoN2dHgQby16yaAwr/UwWhfL4J9nVELysAdsQOe9fyPakmFtWKaYkbXOLuizHZwV
         z/e6lVv3MaUW0ATwPglc1wyduGqvQV2poE9qbGcxvQeWnBrLkw0Bv/EF1IhsbOj/LDja
         lxAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=o610TAWzvyPonwyhymse6BdsrWyjrIXp6XT6ReWAx6A=;
        b=LqM0t7rESUjuRnBDLZPeibQKuRztv8MrQ/rV8JVE2zPt8WGQncFVRol63l9ORSnqGr
         EBR+SYRSjB2bHnh4KAJlU0+7zngtcrlbKKijT7HPehyiu5W3je79DpM3hE6+kkUtdPcZ
         40qzMbDtsi0c5mnx2nugw3lCZ0YKGyTZa7MgMT95hVpeMB7W1fCx1CLU/bXmjRtkJHab
         XBMzgBmnJdgPW+itmQiyysDKSx9HtLNyYZEni5l5YHUuuIFz3dpgpit2aQK+BGdLD42H
         huvrSz7YBrR8IdEbB+AIU3PM/7sVNYxTUFrenwwPrxjXxgOt8nDbPzWKYdiHneXvIR5i
         nx4A==
X-Gm-Message-State: AOAM532zl8BO9THwQaQctZQ4qXLHCpkVwlrf/EtzeI1FD2eJc3FnAuXa
        rwRqs4y03pla5d6rEP3NN/XOLgM5h7vVSLJa
X-Google-Smtp-Source: ABdhPJwdWVI7AjtnIILBxTs6aQR5tTp21hMK/RuGOaEpIu3idxBKbsv5OG0VzhVRh63sOQDl7eloOw==
X-Received: by 2002:a2e:a54a:: with SMTP id e10mr618450ljn.87.1603452440867;
        Fri, 23 Oct 2020 04:27:20 -0700 (PDT)
Received: from localhost.localdomain ([195.245.244.36])
        by smtp.gmail.com with ESMTPSA id f16sm115041lfk.110.2020.10.23.04.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 04:27:19 -0700 (PDT)
From:   Artem Blagodarenko <artem.blagodarenko@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     adilger.kernel@dilger.ca, Alexey Lyashkov <alexey.lyashkov@hpe.com>
Subject: [PATCH] libfs: Fix DIO mode aligment
Date:   Fri, 23 Oct 2020 07:26:59 -0400
Message-Id: <20201023112659.1559-1-artem.blagodarenko@gmail.com>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Alexey Lyashkov <alexey.lyashkov@hpe.com>

Bounce buffer must be extended to hold a whole disk block size.
Read/write operations with unaligned offsets is prohobined
in the DIO mode, so read/write blocks should be adjusted to
reflect it.

Change-Id: Ic573c9ff0d476028dd2293f8b814c6112705db0e
Signed-off-by: Alexey Lyashkov <alexey.lyashkov@hpe.com>
HPE-bug-id: LUS-9241
---
 lib/ext2fs/io_manager.c |   5 +-
 lib/ext2fs/unix_io.c    | 296 +++++++++++++++++++++++++---------------
 2 files changed, 190 insertions(+), 111 deletions(-)

diff --git a/lib/ext2fs/io_manager.c b/lib/ext2fs/io_manager.c
index c395d615..84399a12 100644
--- a/lib/ext2fs/io_manager.c
+++ b/lib/ext2fs/io_manager.c
@@ -20,6 +20,9 @@
 #include "ext2_fs.h"
 #include "ext2fs.h"
 
+#define max(a, b) ((a) > (b) ? (a) : (b))
+
+
 errcode_t io_channel_set_options(io_channel channel, const char *opts)
 {
 	errcode_t retval = 0;
@@ -128,7 +131,7 @@ errcode_t io_channel_alloc_buf(io_channel io, int count, void *ptr)
 	size_t	size;
 
 	if (count == 0)
-		size = io->block_size;
+		size = max(io->block_size, io->align);
 	else if (count > 0)
 		size = io->block_size * count;
 	else
diff --git a/lib/ext2fs/unix_io.c b/lib/ext2fs/unix_io.c
index 628e60c3..53647a22 100644
--- a/lib/ext2fs/unix_io.c
+++ b/lib/ext2fs/unix_io.c
@@ -154,46 +154,30 @@ static char *safe_getenv(const char *arg)
 /*
  * Here are the raw I/O functions
  */
-static errcode_t raw_read_blk(io_channel channel,
+static errcode_t raw_aligned_read_blk(io_channel channel,
 			      struct unix_private_data *data,
-			      unsigned long long block,
-			      int count, void *bufv)
+			      ext2_loff_t location,
+			      ssize_t size, void *bufv,
+			      int *asize)
 {
-	errcode_t	retval;
-	ssize_t		size;
-	ext2_loff_t	location;
 	int		actual = 0;
+	errcode_t	retval;
 	unsigned char	*buf = bufv;
-	ssize_t		really_read = 0;
-
-	size = (count < 0) ? -count : (ext2_loff_t) count * channel->block_size;
-	data->io_stats.bytes_read += size;
-	location = ((ext2_loff_t) block * channel->block_size) + data->offset;
 
-	if (data->flags & IO_FLAG_FORCE_BOUNCE) {
-		if (ext2fs_llseek(data->dev, location, SEEK_SET) != location) {
-			retval = errno ? errno : EXT2_ET_LLSEEK_FAILED;
-			goto error_out;
-		}
-		goto bounce_read;
-	}
+#ifdef ALIGN_DEBUG
+	printf("raw_aligned_read_blk: %p %lu<>%lu\n", buf,
+		location, (unsigned long) size);
+#endif
 
 #ifdef HAVE_PREAD64
 	/* Try an aligned pread */
-	if ((channel->align == 0) ||
-	    (IS_ALIGNED(buf, channel->align) &&
-	     IS_ALIGNED(size, channel->align))) {
-		actual = pread64(data->dev, buf, size, location);
-		if (actual == size)
-			return 0;
-		actual = 0;
-	}
+	actual = pread64(data->dev, buf, size, location);
+	if (actual == size)
+		return 0;
+	actual = 0;
 #elif HAVE_PREAD
 	/* Try an aligned pread */
-	if ((sizeof(off_t) >= sizeof(ext2_loff_t)) &&
-	    ((channel->align == 0) ||
-	     (IS_ALIGNED(buf, channel->align) &&
-	      IS_ALIGNED(size, channel->align)))) {
+	if (sizeof(off_t) >= sizeof(ext2_loff_t)) {
 		actual = pread(data->dev, buf, size, location);
 		if (actual == size)
 			return 0;
@@ -205,47 +189,100 @@ static errcode_t raw_read_blk(io_channel channel,
 		retval = errno ? errno : EXT2_ET_LLSEEK_FAILED;
 		goto error_out;
 	}
+
+	actual = read(data->dev, buf, size);
+	if (actual != size) {
+		if (actual < 0) {
+			retval = errno;
+			actual = 0;
+		} else {
+			retval = EXT2_ET_SHORT_READ;
+		}
+	}
+
+error_out:
+	*asize = actual;
+	return retval;
+}
+
+
+/*
+ * Here are the raw I/O functions
+ */
+static errcode_t raw_read_blk(io_channel channel,
+			      struct unix_private_data *data,
+			      unsigned long long block,
+			      int count, void *bufv)
+{
+	errcode_t	retval;
+	ssize_t		size;
+	ext2_loff_t	location;
+	int		actual = 0;
+	unsigned char	*buf = bufv;
+	unsigned int	align = channel->align;
+	ssize_t		really_read = 0;
+	blk64_t		blk;
+	loff_t		offset;
+
+	size = (count < 0) ? -count : count * channel->block_size;
+	data->io_stats.bytes_read += size;
+	location = ((ext2_loff_t) block * channel->block_size) + data->offset;
+
+	if (data->flags & IO_FLAG_FORCE_BOUNCE) {
+		align = channel->block_size;
+		goto bounce_read;
+	}
+
 	if ((channel->align == 0) ||
-	    (IS_ALIGNED(buf, channel->align) &&
+	    (IS_ALIGNED(location, channel->align) &&
+	     IS_ALIGNED(buf, channel->align) &&
 	     IS_ALIGNED(size, channel->align))) {
-		actual = read(data->dev, buf, size);
-		if (actual != size) {
-		short_read:
-			if (actual < 0) {
-				retval = errno;
-				actual = 0;
-			} else
-				retval = EXT2_ET_SHORT_READ;
+		retval = raw_aligned_read_blk(channel, data, location,
+						size, bufv, &actual);
+		if (retval != 0)
 			goto error_out;
-		}
-		return 0;
+
+		return retval;
 	}
 
+bounce_read:
 #ifdef ALIGN_DEBUG
-	printf("raw_read_blk: O_DIRECT fallback: %p %lu\n", buf,
-	       (unsigned long) size);
+	printf("raw_read_blk: O_DIRECT fallback: %p %lu<>%lu\n", buf,
+		location, (unsigned long) size);
 #endif
-
 	/*
 	 * The buffer or size which we're trying to read isn't aligned
 	 * to the O_DIRECT rules, so we need to do this the hard way...
+	 * read / write must be aligned to the block device sector size
 	 */
-bounce_read:
+
+	blk = location / align;
+	offset = location % align;
+
+	if (lseek(data->dev, blk * align, SEEK_SET) < 0)
+		return errno;
+
 	while (size > 0) {
-		actual = read(data->dev, data->bounce, channel->block_size);
-		if (actual != channel->block_size) {
+		actual = read(data->dev, data->bounce, align);
+		if (actual != align) {
 			actual = really_read;
 			buf -= really_read;
 			size += really_read;
-			goto short_read;
+			retval = EXT2_ET_SHORT_READ;
+			goto error_out;
 		}
 		actual = size;
-		if (size > channel->block_size)
-			actual = channel->block_size;
-		memcpy(buf, data->bounce, actual);
+		if ((actual + offset) > align)
+			actual = align - offset;
+		if (actual > size)
+			actual = size;
+
+		memcpy(buf, data->bounce + offset, actual);
 		really_read += actual;
 		size -= actual;
 		buf += actual;
+		offset = 0;
+		blk++;
 	}
 	return 0;
 
@@ -258,6 +295,58 @@ error_out:
 	return retval;
 }
 
+static errcode_t raw_aligned_write_blk(io_channel channel,
+			       struct unix_private_data *data,
+			       ext2_loff_t  location,
+			       ssize_t size, const void *bufv,
+			       int *asize)
+
+{
+	int		actual = 0;
+	errcode_t	retval;
+	const unsigned char *buf = (void *)bufv;
+
+#ifdef ALIGN_DEBUG
+	printf("raw_aligned_write_blk: %p %lu %lu\n", buf,
+	       location, (unsigned long) size);
+#endif
+
+#ifdef HAVE_PWRITE64
+	/* Try an aligned pwrite */
+	actual = pwrite64(data->dev, buf, size, location);
+	if (actual == size)
+		return 0;
+#elif HAVE_PWRITE
+	/* Try an aligned pwrite */
+	if ((sizeof(off_t) >= sizeof(ext2_loff_t)) {
+		actual = pwrite(data->dev, buf, size, location);
+		if (actual == size)
+			return 0;
+	}
+#endif /* HAVE_PWRITE */
+
+	if (ext2fs_llseek(data->dev, location, SEEK_SET) != location) {
+		retval = errno ? errno : EXT2_ET_LLSEEK_FAILED;
+		goto error_out;
+	}
+
+	actual = write(data->dev, buf, size);
+	if (actual < 0) {
+		retval = errno;
+		goto error_out;
+	}
+	if (actual != size) {
+		retval = EXT2_ET_SHORT_WRITE;
+		goto error_out;
+	}
+	retval = 0;
+error_out:
+	*asize = actual;
+	return retval;
+
+}
+
+
 static errcode_t raw_write_blk(io_channel channel,
 			       struct unix_private_data *data,
 			       unsigned long long block,
@@ -268,6 +357,9 @@ static errcode_t raw_write_blk(io_channel channel,
 	int		actual = 0;
 	errcode_t	retval;
 	const unsigned char *buf = bufv;
+	unsigned int	align = channel->align;
+	blk64_t		blk;
+	loff_t		offset;
 
 	if (count == 1)
 		size = channel->block_size;
@@ -282,95 +374,79 @@ static errcode_t raw_write_blk(io_channel channel,
 	location = ((ext2_loff_t) block * channel->block_size) + data->offset;
 
 	if (data->flags & IO_FLAG_FORCE_BOUNCE) {
-		if (ext2fs_llseek(data->dev, location, SEEK_SET) != location) {
-			retval = errno ? errno : EXT2_ET_LLSEEK_FAILED;
-			goto error_out;
-		}
+		align = channel->block_size;
 		goto bounce_write;
 	}
 
-#ifdef HAVE_PWRITE64
-	/* Try an aligned pwrite */
 	if ((channel->align == 0) ||
-	    (IS_ALIGNED(buf, channel->align) &&
+	    (IS_ALIGNED(location, channel->align) &&
+	     IS_ALIGNED(buf, channel->align) &&
 	     IS_ALIGNED(size, channel->align))) {
-		actual = pwrite64(data->dev, buf, size, location);
-		if (actual == size)
-			return 0;
-	}
-#elif HAVE_PWRITE
-	/* Try an aligned pwrite */
-	if ((sizeof(off_t) >= sizeof(ext2_loff_t)) &&
-	    ((channel->align == 0) ||
-	     (IS_ALIGNED(buf, channel->align) &&
-	      IS_ALIGNED(size, channel->align)))) {
-		actual = pwrite(data->dev, buf, size, location);
-		if (actual == size)
-			return 0;
-	}
-#endif /* HAVE_PWRITE */
+		retval = raw_aligned_write_blk(channel, data, location,
+						size, bufv, &actual);
+		if (retval != 0)
+			goto error_out;
 
-	if (ext2fs_llseek(data->dev, location, SEEK_SET) != location) {
-		retval = errno ? errno : EXT2_ET_LLSEEK_FAILED;
-		goto error_out;
+		return retval;
 	}
 
-	if ((channel->align == 0) ||
-	    (IS_ALIGNED(buf, channel->align) &&
-	     IS_ALIGNED(size, channel->align))) {
-		actual = write(data->dev, buf, size);
-		if (actual < 0) {
-			retval = errno;
-			goto error_out;
-		}
-		if (actual != size) {
-		short_write:
-			retval = EXT2_ET_SHORT_WRITE;
-			goto error_out;
-		}
-		return 0;
-	}
 
+bounce_write:
 #ifdef ALIGN_DEBUG
 	printf("raw_write_blk: O_DIRECT fallback: %p %lu\n", buf,
 	       (unsigned long) size);
 #endif
+
+	/* logical offset may don't aligned with block device block size */
+	blk = location / align;
+	offset = location % align;
+
+	if (lseek(data->dev, blk * align, SEEK_SET) != blk * align) {
+		retval = errno ? errno : EXT2_ET_LLSEEK_FAILED;
+		goto error_out;
+	}
+
 	/*
 	 * The buffer or size which we're trying to write isn't aligned
 	 * to the O_DIRECT rules, so we need to do this the hard way...
 	 */
-bounce_write:
 	while (size > 0) {
-		if (size < channel->block_size) {
-			actual = read(data->dev, data->bounce,
-				      channel->block_size);
-			if (actual != channel->block_size) {
-				if (actual < 0) {
-					retval = errno;
-					goto error_out;
-				}
-				memset((char *) data->bounce + actual, 0,
-				       channel->block_size - actual);
+		int actual_w;
+
+		memset((char *) data->bounce, 0, align);
+		if (offset || (size < align)) {
+			actual = read(data->dev, data->bounce, align);
+			if (actual < 0) {
+				retval = errno;
+				goto error_out;
 			}
 		}
 		actual = size;
-		if (size > channel->block_size)
-			actual = channel->block_size;
-		memcpy(data->bounce, buf, actual);
-		if (ext2fs_llseek(data->dev, location, SEEK_SET) != location) {
+		if ((actual + offset) > align)
+			actual = align - offset;
+		if (actual > size)
+			actual = size;
+		memcpy(((char *)data->bounce) + offset, buf, actual);
+
+		if (lseek(data->dev, blk * align, SEEK_SET) != blk * align) {
 			retval = errno ? errno : EXT2_ET_LLSEEK_FAILED;
 			goto error_out;
 		}
-		actual = write(data->dev, data->bounce, channel->block_size);
-		if (actual < 0) {
+
+		actual_w = write(data->dev, data->bounce, align);
+		if (actual_w < 0) {
 			retval = errno;
 			goto error_out;
 		}
-		if (actual != channel->block_size)
-			goto short_write;
+		if (actual_w != align) {
+			retval = EXT2_ET_SHORT_WRITE;
+			goto error_out;
+		}
 		size -= actual;
 		buf += actual;
 		location += actual;
+		blk ++;
+		offset = 0;
 	}
 	return 0;
 
-- 
2.18.4

