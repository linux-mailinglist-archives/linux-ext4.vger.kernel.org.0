Return-Path: <linux-ext4+bounces-11556-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADDAC3D9AD
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 84E454E4BB0
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A93E33F8C7;
	Thu,  6 Nov 2025 22:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bRl0OSI/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A4C33F8BF
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468217; cv=none; b=SZkXRDHZUBbjILBZMetQWGR0Cu7wYZHbtLzRGWh0ahuJhn2FH4QqDtwPIwV/00atwnC2P03L5XknNFMd1X0+JGPmuIYJscQAqVrx9wpVSVMlzZwAaCKMegShjHGrZwAgJ+lnf/MtSDLwIEbNsraRCzwiMseczB8HLrCJp48Xtcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468217; c=relaxed/simple;
	bh=0UXwpYC33gMDqPTLr3GM2IuwjP1O6/eWjpY6/PYUEdw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k1bCvqH8hQqAXxQsEdv059QPkh6cn9abqhv7yAYAlOewgsbfgZXXNHDPsxp9okEfN7J3F2WfmpOSGfaCqOD9WTHKLoLyitCGEUmwQsUlmrewc1MDMZT9VKGLdbUvDNHBMDeCOukonuC0ewBabuuR3VJACGb82YdkkzqApjaYJnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bRl0OSI/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C548C113D0;
	Thu,  6 Nov 2025 22:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762468217;
	bh=0UXwpYC33gMDqPTLr3GM2IuwjP1O6/eWjpY6/PYUEdw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=bRl0OSI/k30aPjv/R36GXhwkPsUK8xTuyq86UVdAwo0q1rNhVyBq6LRiepFBNgr/v
	 NBAx3AI++6FXlXDBdl3GPJ6eU/kaVSaKgPyzwKZObUe0j9LDLfnt0P2tv7UuNh+auA
	 yBha38aA26NaYPgsaxYEetZIO1DleNgk2aOU/wWYiN92k7MYpkno7Vkhu0DU22TNa/
	 KXfbYluf8ywGyDPXRdC3O1ape8GxcTzbbiOgiYLRAnJfoSVjl+se+5K8P1dnAXbiUK
	 Mp05hhLVuZEHqyRY9xh+RYM2wu4luyfuenUdI3o6acj2rWapCOpGORGpm90jktnxbG
	 30bPVHG0zotYw==
Date: Thu, 06 Nov 2025 14:30:16 -0800
Subject: [PATCH 1/4] libext2fs: add POSIX advisory locking to the unix IO
 manager
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246793347.2862036.7225995759685117808.stgit@frogsfrogsfrogs>
In-Reply-To: <176246793314.2862036.15869840216751367735.stgit@frogsfrogsfrogs>
References: <176246793314.2862036.15869840216751367735.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Add support for using flock() to protect the files opened by the Unix IO
manager so that other fuse2fs servers cannot stomp all over the
filesystem.  We may some day want to adopt this in e2fsck.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/ext2fs/ext2_io.h         |   12 +++++++
 debian/libext2fs2t64.symbols |    2 +
 lib/ext2fs/io_manager.c      |   16 +++++++++
 lib/ext2fs/unix_io.c         |   71 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 100 insertions(+), 1 deletion(-)


diff --git a/lib/ext2fs/ext2_io.h b/lib/ext2fs/ext2_io.h
index 39a4e8fcf6b515..61865d54d82490 100644
--- a/lib/ext2fs/ext2_io.h
+++ b/lib/ext2fs/ext2_io.h
@@ -102,7 +102,8 @@ struct struct_io_manager {
 				     unsigned long long count);
 	errcode_t (*zeroout)(io_channel channel, unsigned long long block,
 			     unsigned long long count);
-	long	reserved[14];
+	errcode_t (*flock)(io_channel channel, unsigned int flock_flags);
+	long	reserved[13];
 };
 
 #define IO_FLAG_RW		0x0001
@@ -112,6 +113,13 @@ struct struct_io_manager {
 #define IO_FLAG_THREADS		0x0010
 #define IO_FLAG_NOCACHE		0x0020
 
+/* Prevent other programs from reading or writing to underlying storage */
+#define IO_CHANNEL_FLOCK_EXCLUSIVE	0x1
+/* Prevent other programs from writing to underlying storage */
+#define IO_CHANNEL_FLOCK_SHARED		0x2
+/* Return EBUSY if the lock cannot be taken immediately */
+#define IO_CHANNEL_FLOCK_TRYLOCK	0x4
+
 /*
  * Convenience functions....
  */
@@ -145,6 +153,8 @@ extern errcode_t io_channel_alloc_buf(io_channel channel,
 extern errcode_t io_channel_cache_readahead(io_channel io,
 					    unsigned long long block,
 					    unsigned long long count);
+extern errcode_t io_channel_flock(io_channel io, unsigned int flock_flags);
+extern errcode_t io_channel_funlock(io_channel io);
 
 #ifdef _WIN32
 /* windows_io.c */
diff --git a/debian/libext2fs2t64.symbols b/debian/libext2fs2t64.symbols
index a3042c3292da93..b4d80161f1e1b4 100644
--- a/debian/libext2fs2t64.symbols
+++ b/debian/libext2fs2t64.symbols
@@ -693,6 +693,8 @@ libext2fs.so.2 libext2fs2t64 #MINVER#
  io_channel_alloc_buf@Base 1.42.3
  io_channel_cache_readahead@Base 1.43
  io_channel_discard@Base 1.42
+ io_channel_flock@Base 1.47.99
+ io_channel_funlock@Base 1.47.99
  io_channel_read_blk64@Base 1.41.1
  io_channel_set_options@Base 1.37
  io_channel_write_blk64@Base 1.41.1
diff --git a/lib/ext2fs/io_manager.c b/lib/ext2fs/io_manager.c
index dca6af09996b70..791ec7d14adbba 100644
--- a/lib/ext2fs/io_manager.c
+++ b/lib/ext2fs/io_manager.c
@@ -150,3 +150,19 @@ errcode_t io_channel_cache_readahead(io_channel io, unsigned long long block,
 
 	return io->manager->cache_readahead(io, block, count);
 }
+
+errcode_t io_channel_flock(io_channel io, unsigned int flock_flags)
+{
+	if (!io->manager->flock)
+		return EXT2_ET_OP_NOT_SUPPORTED;
+
+	return io->manager->flock(io, flock_flags);
+}
+
+errcode_t io_channel_funlock(io_channel io)
+{
+	if (!io->manager->flock)
+		return EXT2_ET_OP_NOT_SUPPORTED;
+
+	return io->manager->flock(io, 0);
+}
diff --git a/lib/ext2fs/unix_io.c b/lib/ext2fs/unix_io.c
index 1456b4d4bbe212..abd33ba839f7e9 100644
--- a/lib/ext2fs/unix_io.c
+++ b/lib/ext2fs/unix_io.c
@@ -64,6 +64,9 @@
 #ifdef HAVE_PTHREAD
 #include <pthread.h>
 #endif
+#ifdef HAVE_SYS_FILE_H
+#include <sys/file.h>
+#endif
 
 #if defined(__linux__) && defined(_IO) && !defined(BLKROGET)
 #define BLKROGET   _IO(0x12, 94) /* Get read-only status (0 = read_write).  */
@@ -135,6 +138,7 @@ struct unix_private_data {
 	int	flags;
 	int	align;
 	int	access_time;
+	int	unix_flock_flags;
 	ext2_loff_t offset;
 	struct unix_cache *cache;
 	unsigned int cache_size;
@@ -875,6 +879,68 @@ int ext2fs_fstat(int fd, ext2fs_struct_stat *buf)
 #endif
 }
 
+#ifdef HAVE_SYS_FILE_H
+static errcode_t unix_funlock(io_channel channel)
+{
+	struct unix_private_data *data;
+	int ret;
+
+	EXT2_CHECK_MAGIC(channel, EXT2_ET_MAGIC_IO_CHANNEL);
+	data = (struct unix_private_data *) channel->private_data;
+	EXT2_CHECK_MAGIC(data, EXT2_ET_MAGIC_UNIX_IO_CHANNEL);
+
+	if (data->unix_flock_flags) {
+		ret = flock(data->dev, LOCK_UN);
+		if (ret)
+			return errno;
+
+		data->unix_flock_flags = 0;
+	}
+
+	return 0;
+}
+
+static errcode_t unix_flock(io_channel channel, unsigned int flock_flags)
+{
+	struct unix_private_data *data;
+	int unix_flock_flags = 0;
+	errcode_t ret;
+
+	EXT2_CHECK_MAGIC(channel, EXT2_ET_MAGIC_IO_CHANNEL);
+	data = (struct unix_private_data *) channel->private_data;
+	EXT2_CHECK_MAGIC(data, EXT2_ET_MAGIC_UNIX_IO_CHANNEL);
+
+	ret = unix_funlock(channel);
+	if (ret)
+		return ret;
+
+	if (flock_flags & IO_CHANNEL_FLOCK_EXCLUSIVE)
+		unix_flock_flags |= LOCK_EX;
+
+	if (flock_flags & IO_CHANNEL_FLOCK_SHARED)
+		unix_flock_flags |= LOCK_SH;
+
+	if (flock_flags & IO_CHANNEL_FLOCK_TRYLOCK)
+		unix_flock_flags |= LOCK_NB;
+
+	if (!unix_flock_flags)
+		return 0;
+
+	ret = flock(data->dev, unix_flock_flags);
+	if (ret < 0)
+		return errno;
+
+	data->unix_flock_flags = unix_flock_flags & ~LOCK_NB;
+	return 0;
+}
+#else
+#define unix_flock		NULL
+
+static errcode_t unix_funlock(io_channel channel)
+{
+	return 0;
+}
+#endif /* HAVE_SYS_FILE_H */
 
 static errcode_t unix_open_channel(const char *name, int fd,
 				   int flags, io_channel *channel,
@@ -1061,6 +1127,7 @@ static errcode_t unix_open_channel(const char *name, int fd,
 
 cleanup:
 	if (data) {
+		unix_funlock(io);
 		if (io->manager != unixfd_io_manager && data->dev >= 0)
 			close(data->dev);
 		if (data->cache) {
@@ -1147,6 +1214,8 @@ static errcode_t unix_close(io_channel channel)
 	retval = flush_cached_blocks(channel, data, 0);
 #endif
 
+	unix_funlock(channel);
+
 	if (channel->manager != unixfd_io_manager && close(data->dev) < 0)
 		retval = errno;
 	free_cache(data);
@@ -1683,6 +1752,7 @@ static struct struct_io_manager struct_unix_manager = {
 	.discard	= unix_discard,
 	.cache_readahead	= unix_cache_readahead,
 	.zeroout	= unix_zeroout,
+	.flock		= unix_flock,
 };
 
 io_manager unix_io_manager = &struct_unix_manager;
@@ -1704,6 +1774,7 @@ static struct struct_io_manager struct_unixfd_manager = {
 	.discard	= unix_discard,
 	.cache_readahead	= unix_cache_readahead,
 	.zeroout	= unix_zeroout,
+	.flock		= unix_flock,
 };
 
 io_manager unixfd_io_manager = &struct_unixfd_manager;


