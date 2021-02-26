Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC7EB326A5A
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Feb 2021 00:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhBZXSg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 26 Feb 2021 18:18:36 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:41971 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229618AbhBZXSg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 26 Feb 2021 18:18:36 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 11QNHiKa032342
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Feb 2021 18:17:45 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6CCE215C39D2; Fri, 26 Feb 2021 18:17:44 -0500 (EST)
Date:   Fri, 26 Feb 2021 18:17:44 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Artem Blagodarenko <artem.blagodarenko@gmail.com>
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca,
        Alexey Lyashkov <alexey.lyashkov@hpe.com>
Subject: Re: [PATCH] libfs: Fix DIO mode aligment
Message-ID: <YDmBmE159JOG8gRk@mit.edu>
References: <20201023112659.1559-1-artem.blagodarenko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201023112659.1559-1-artem.blagodarenko@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

I've rewritten the patch because it was simplest way to review the
code.  The resulting code is simpler and has a smaller number of lines
of code.  I don't have any 4k advanced format disks handy, so I'd
appreciate it if someone can test it.  It passes the existing
regression tests, and I've run a number of manual tests to simulate a
advanced format HDD, with the tests being run with clang and UBSAN and
ADDRSAN enabled.

If someone with access to an advanced format disk can test running
debugfs -D on an advanced format disk, that would be great, thanks.

	      	 	  	       - Ted

commit c001596110e834a85b01a47a20811b318cb3b9e4
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Fri Feb 26 17:41:06 2021 -0500

    libext2fs: fix unix_io's Direct I/O support
    
    The previous Direct I/O support worked on HDD's with 512 byte logical
    sector sizes, and on FreeBSD which required 4k aligned memory buffers.
    However, it was incomplete and was not correctly working on HDD's with
    4k logical sector sizes (aka Advanced Format Disks).
    
    Based on a patch from Alexey Lyashkov <alexey.lyashkov@hpe.com> but
    rewritten to work with the latest e2fsprogs and to minimize changes to
    make it easier to review.
    
    Signed-off-by: Theodore Ts'o <tytso@mit.edu>
    Reported-by: Artem Blagodarenko <artem.blagodarenko@gmail.com>

diff --git a/lib/ext2fs/io_manager.c b/lib/ext2fs/io_manager.c
index c395d615..996c31a1 100644
--- a/lib/ext2fs/io_manager.c
+++ b/lib/ext2fs/io_manager.c
@@ -134,9 +134,11 @@ errcode_t io_channel_alloc_buf(io_channel io, int count, void *ptr)
 	else
 		size = -count;
 
-	if (io->align)
+	if (io->align) {
+		if (io->align > size)
+			size = io->align;
 		return ext2fs_get_memalign(size, io->align, ptr);
-	else
+	} else
 		return ext2fs_get_mem(size, ptr);
 }
 
diff --git a/lib/ext2fs/unix_io.c b/lib/ext2fs/unix_io.c
index 73f5667e..8965535c 100644
--- a/lib/ext2fs/unix_io.c
+++ b/lib/ext2fs/unix_io.c
@@ -218,6 +218,8 @@ static errcode_t raw_read_blk(io_channel channel,
 	int		actual = 0;
 	unsigned char	*buf = bufv;
 	ssize_t		really_read = 0;
+	unsigned long long aligned_blk;
+	int		align_size, offset;
 
 	size = (count < 0) ? -count : (ext2_loff_t) count * channel->block_size;
 	mutex_lock(data, STATS_MTX);
@@ -226,7 +228,7 @@ static errcode_t raw_read_blk(io_channel channel,
 	location = ((ext2_loff_t) block * channel->block_size) + data->offset;
 
 	if (data->flags & IO_FLAG_FORCE_BOUNCE) {
-		if (ext2fs_llseek(data->dev, location, SEEK_SET) != location) {
+		if (ext2fs_llseek(data->dev, location, SEEK_SET) < 0) {
 			retval = errno ? errno : EXT2_ET_LLSEEK_FAILED;
 			goto error_out;
 		}
@@ -237,6 +239,7 @@ static errcode_t raw_read_blk(io_channel channel,
 	/* Try an aligned pread */
 	if ((channel->align == 0) ||
 	    (IS_ALIGNED(buf, channel->align) &&
+	     IS_ALIGNED(location, channel->align) &&
 	     IS_ALIGNED(size, channel->align))) {
 		actual = pread64(data->dev, buf, size, location);
 		if (actual == size)
@@ -248,6 +251,7 @@ static errcode_t raw_read_blk(io_channel channel,
 	if ((sizeof(off_t) >= sizeof(ext2_loff_t)) &&
 	    ((channel->align == 0) ||
 	     (IS_ALIGNED(buf, channel->align) &&
+	      IS_ALIGNED(location, channel->align) &&
 	      IS_ALIGNED(size, channel->align)))) {
 		actual = pread(data->dev, buf, size, location);
 		if (actual == size)
@@ -256,12 +260,13 @@ static errcode_t raw_read_blk(io_channel channel,
 	}
 #endif /* HAVE_PREAD */
 
-	if (ext2fs_llseek(data->dev, location, SEEK_SET) != location) {
+	if (ext2fs_llseek(data->dev, location, SEEK_SET) < 0) {
 		retval = errno ? errno : EXT2_ET_LLSEEK_FAILED;
 		goto error_out;
 	}
 	if ((channel->align == 0) ||
 	    (IS_ALIGNED(buf, channel->align) &&
+	     IS_ALIGNED(location, channel->align) &&
 	     IS_ALIGNED(size, channel->align))) {
 		actual = read(data->dev, buf, size);
 		if (actual != size) {
@@ -286,23 +291,39 @@ static errcode_t raw_read_blk(io_channel channel,
 	 * to the O_DIRECT rules, so we need to do this the hard way...
 	 */
 bounce_read:
+	if ((channel->block_size > channel->align) &&
+	    (channel->block_size % channel->align) == 0)
+		align_size = channel->block_size;
+	else
+		align_size = channel->align;
+	aligned_blk = location / align_size;
+	offset = location % align_size;
+
+	if (ext2fs_llseek(data->dev, aligned_blk * align_size, SEEK_SET) < 0) {
+		retval = errno ? errno : EXT2_ET_LLSEEK_FAILED;
+		goto error_out;
+	}
 	while (size > 0) {
 		mutex_lock(data, BOUNCE_MTX);
-		actual = read(data->dev, data->bounce, channel->block_size);
-		if (actual != channel->block_size) {
+		actual = read(data->dev, data->bounce, align_size);
+		if (actual != align_size) {
 			mutex_unlock(data, BOUNCE_MTX);
 			actual = really_read;
 			buf -= really_read;
 			size += really_read;
 			goto short_read;
 		}
-		actual = size;
-		if (size > channel->block_size)
-			actual = channel->block_size;
-		memcpy(buf, data->bounce, actual);
+		if ((actual + offset) > align_size)
+			actual = align_size - offset;
+		if (actual > size)
+			actual = size;
+		memcpy(buf, data->bounce + offset, actual);
+
 		really_read += actual;
 		size -= actual;
 		buf += actual;
+		offset = 0;
+		aligned_blk++;
 		mutex_unlock(data, BOUNCE_MTX);
 	}
 	return 0;
@@ -326,6 +347,8 @@ static errcode_t raw_write_blk(io_channel channel,
 	int		actual = 0;
 	errcode_t	retval;
 	const unsigned char *buf = bufv;
+	unsigned long long aligned_blk;
+	int		align_size, offset;
 
 	if (count == 1)
 		size = channel->block_size;
@@ -342,7 +365,7 @@ static errcode_t raw_write_blk(io_channel channel,
 	location = ((ext2_loff_t) block * channel->block_size) + data->offset;
 
 	if (data->flags & IO_FLAG_FORCE_BOUNCE) {
-		if (ext2fs_llseek(data->dev, location, SEEK_SET) != location) {
+		if (ext2fs_llseek(data->dev, location, SEEK_SET) < 0) {
 			retval = errno ? errno : EXT2_ET_LLSEEK_FAILED;
 			goto error_out;
 		}
@@ -353,6 +376,7 @@ static errcode_t raw_write_blk(io_channel channel,
 	/* Try an aligned pwrite */
 	if ((channel->align == 0) ||
 	    (IS_ALIGNED(buf, channel->align) &&
+	     IS_ALIGNED(location, channel->align) &&
 	     IS_ALIGNED(size, channel->align))) {
 		actual = pwrite64(data->dev, buf, size, location);
 		if (actual == size)
@@ -363,6 +387,7 @@ static errcode_t raw_write_blk(io_channel channel,
 	if ((sizeof(off_t) >= sizeof(ext2_loff_t)) &&
 	    ((channel->align == 0) ||
 	     (IS_ALIGNED(buf, channel->align) &&
+	      IS_ALIGNED(location, channel->align) &&
 	      IS_ALIGNED(size, channel->align)))) {
 		actual = pwrite(data->dev, buf, size, location);
 		if (actual == size)
@@ -370,13 +395,14 @@ static errcode_t raw_write_blk(io_channel channel,
 	}
 #endif /* HAVE_PWRITE */
 
-	if (ext2fs_llseek(data->dev, location, SEEK_SET) != location) {
+	if (ext2fs_llseek(data->dev, location, SEEK_SET) < 0) {
 		retval = errno ? errno : EXT2_ET_LLSEEK_FAILED;
 		goto error_out;
 	}
 
 	if ((channel->align == 0) ||
 	    (IS_ALIGNED(buf, channel->align) &&
+	     IS_ALIGNED(location, channel->align) &&
 	     IS_ALIGNED(size, channel->align))) {
 		actual = write(data->dev, buf, size);
 		if (actual < 0) {
@@ -400,40 +426,59 @@ static errcode_t raw_write_blk(io_channel channel,
 	 * to the O_DIRECT rules, so we need to do this the hard way...
 	 */
 bounce_write:
+	if ((channel->block_size > channel->align) &&
+	    (channel->block_size % channel->align) == 0)
+		align_size = channel->block_size;
+	else
+		align_size = channel->align;
+	aligned_blk = location / align_size;
+	offset = location % align_size;
+
 	while (size > 0) {
+		int actual_w;
+
 		mutex_lock(data, BOUNCE_MTX);
-		if (size < channel->block_size) {
+		if (size < align_size || offset) {
+			if (ext2fs_llseek(data->dev, aligned_blk * align_size,
+					  SEEK_SET) < 0) {
+				retval = errno ? errno : EXT2_ET_LLSEEK_FAILED;
+				goto error_out;
+			}
 			actual = read(data->dev, data->bounce,
-				      channel->block_size);
-			if (actual != channel->block_size) {
+				      align_size);
+			if (actual != align_size) {
 				if (actual < 0) {
 					mutex_unlock(data, BOUNCE_MTX);
 					retval = errno;
 					goto error_out;
 				}
 				memset((char *) data->bounce + actual, 0,
-				       channel->block_size - actual);
+				       align_size - actual);
 			}
 		}
 		actual = size;
-		if (size > channel->block_size)
-			actual = channel->block_size;
-		memcpy(data->bounce, buf, actual);
-		if (ext2fs_llseek(data->dev, location, SEEK_SET) != location) {
+		if ((actual + offset) > align_size)
+			actual = align_size - offset;
+		if (actual > size)
+			actual = size;
+		memcpy(((char *)data->bounce) + offset, buf, actual);
+		if (ext2fs_llseek(data->dev, aligned_blk * align_size, SEEK_SET) < 0) {
 			retval = errno ? errno : EXT2_ET_LLSEEK_FAILED;
 			goto error_out;
 		}
-		actual = write(data->dev, data->bounce, channel->block_size);
+		actual_w = write(data->dev, data->bounce, align_size);
 		mutex_unlock(data, BOUNCE_MTX);
-		if (actual < 0) {
+		if (actual_w < 0) {
 			retval = errno;
 			goto error_out;
 		}
-		if (actual != channel->block_size)
+		if (actual_w != align_size)
 			goto short_write;
 		size -= actual;
 		buf += actual;
 		location += actual;
+		aligned_blk++;
+		offset = 0;
 	}
 	return 0;
 
