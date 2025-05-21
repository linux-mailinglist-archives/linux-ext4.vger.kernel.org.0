Return-Path: <linux-ext4+bounces-8127-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8BFAC0001
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3D143A6280
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 22:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A3522B8B6;
	Wed, 21 May 2025 22:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9SkfLXu"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2A41A23AA
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 22:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747867649; cv=none; b=R6Z8OLX4p6ts4iCD4fh+ZAy7CHNhIbwABcIMVhN8O+5ECUSNEQI78ic6InB7/aSG0TVsR3SLDeiPPrsNdIEUXcGaCbs8f0lwo0H76xOBsWY4fzyH1vrmJsrNzv6NK5J6M+TnRUsKc77aW3wsP5iYYu4wGGKTl8CglA3KYi7grPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747867649; c=relaxed/simple;
	bh=hF3eqNgajuzNBzCtM5eC8oNzNw9b8pO6jONIS+b7ny0=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n4yHr0XWHttpU+6wciGWIdNGnh6q6d51defOa1Ky2JmTsj91MarzQpnTnVRNTEtrjReIaSHiPCPML7QOAxUc3Ve3lz+q1HLF1VFJ45UWW29mMqkw1+0zlWO71/Ki5iAmoPXhHJHQXuHRan8aTWfjIaPM0+u8hIL2swlUZDYP4Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P9SkfLXu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C511DC4CEEA;
	Wed, 21 May 2025 22:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747867648;
	bh=hF3eqNgajuzNBzCtM5eC8oNzNw9b8pO6jONIS+b7ny0=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=P9SkfLXu63GSnDZZOZk9kw8l9xu2VuRNoqFjiyko1iBwVQ2ZPYrQRzpDgE3iBpB/3
	 OPctrgMkypH4FnZNpddqySLXYPxPDo/1DRGA5TObwX7wBaDz/rXjdPx5FQskIEhlQR
	 AYNfVp/WGsFFxMRjx3I4pI+2Wx5Liq4JWv3fA/3jW1zMEw0XCBqiuH97an3gLGxVMx
	 6wYNdZ9JUIwk8FnuI7BwDrYP12rDjAOCZe01327MjmKyM/a4qJ/cl03YZ7vKy7731u
	 KYEaW5c9/dsAVdx17RVemuYxPnf81knJD0ojIB7F7vQAGgyYbsBWegB56vUdxHSNKG
	 cuaM7SsbtyyuQ==
Date: Wed, 21 May 2025 15:47:28 -0700
Subject: [PATCH 09/10] libext2fs: make it possible to extract the fd from an
 IO manager
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174786678853.1385354.14638126520261794242.stgit@frogsfrogsfrogs>
In-Reply-To: <174786678650.1385354.14994099236248944550.stgit@frogsfrogsfrogs>
References: <174786678650.1385354.14994099236248944550.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Make it so that we can extract the fd from an open IO manager.  This
will be used in subsequent patches to register the open block device
with the fuse iomap kernel driver.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/ext2fs/ext2_io.h         |    4 +++-
 debian/libext2fs2t64.symbols |    1 +
 lib/ext2fs/io_manager.c      |    8 ++++++++
 lib/ext2fs/unix_io.c         |   15 +++++++++++++++
 4 files changed, 27 insertions(+), 1 deletion(-)


diff --git a/lib/ext2fs/ext2_io.h b/lib/ext2fs/ext2_io.h
index 39a4e8fcf6b515..78c988374c8808 100644
--- a/lib/ext2fs/ext2_io.h
+++ b/lib/ext2fs/ext2_io.h
@@ -102,7 +102,8 @@ struct struct_io_manager {
 				     unsigned long long count);
 	errcode_t (*zeroout)(io_channel channel, unsigned long long block,
 			     unsigned long long count);
-	long	reserved[14];
+	errcode_t (*get_fd)(io_channel channel, int *fd);
+	long	reserved[13];
 };
 
 #define IO_FLAG_RW		0x0001
@@ -145,6 +146,7 @@ extern errcode_t io_channel_alloc_buf(io_channel channel,
 extern errcode_t io_channel_cache_readahead(io_channel io,
 					    unsigned long long block,
 					    unsigned long long count);
+extern errcode_t io_channel_fd(io_channel io, int *fd);
 
 #ifdef _WIN32
 /* windows_io.c */
diff --git a/debian/libext2fs2t64.symbols b/debian/libext2fs2t64.symbols
index fc1e16ff1e086c..9cf3b33ca15f91 100644
--- a/debian/libext2fs2t64.symbols
+++ b/debian/libext2fs2t64.symbols
@@ -688,6 +688,7 @@ libext2fs.so.2 libext2fs2t64 #MINVER#
  io_channel_alloc_buf@Base 1.42.3
  io_channel_cache_readahead@Base 1.43
  io_channel_discard@Base 1.42
+ io_channel_fd@Base 1.47.3
  io_channel_read_blk64@Base 1.41.1
  io_channel_set_options@Base 1.37
  io_channel_write_blk64@Base 1.41.1
diff --git a/lib/ext2fs/io_manager.c b/lib/ext2fs/io_manager.c
index dca6af09996b70..1bab069de63e12 100644
--- a/lib/ext2fs/io_manager.c
+++ b/lib/ext2fs/io_manager.c
@@ -150,3 +150,11 @@ errcode_t io_channel_cache_readahead(io_channel io, unsigned long long block,
 
 	return io->manager->cache_readahead(io, block, count);
 }
+
+errcode_t io_channel_fd(io_channel io, int *fd)
+{
+	if (!io->manager->get_fd)
+		return EXT2_ET_OP_NOT_SUPPORTED;
+
+	return io->manager->get_fd(io, fd);
+}
diff --git a/lib/ext2fs/unix_io.c b/lib/ext2fs/unix_io.c
index be70fee38890c8..ede75cf8ee3681 100644
--- a/lib/ext2fs/unix_io.c
+++ b/lib/ext2fs/unix_io.c
@@ -1652,6 +1652,19 @@ static errcode_t unix_zeroout(io_channel channel, unsigned long long block,
 unimplemented:
 	return EXT2_ET_UNIMPLEMENTED;
 }
+
+static errcode_t unix_get_fd(io_channel channel, int *fd)
+{
+	struct unix_private_data *data;
+
+	EXT2_CHECK_MAGIC(channel, EXT2_ET_MAGIC_IO_CHANNEL);
+	data = (struct unix_private_data *) channel->private_data;
+	EXT2_CHECK_MAGIC(data, EXT2_ET_MAGIC_UNIX_IO_CHANNEL);
+
+	*fd = data->dev;
+	return 0;
+}
+
 #if __GNUC_PREREQ (4, 6)
 #pragma GCC diagnostic pop
 #endif
@@ -1673,6 +1686,7 @@ static struct struct_io_manager struct_unix_manager = {
 	.discard	= unix_discard,
 	.cache_readahead	= unix_cache_readahead,
 	.zeroout	= unix_zeroout,
+	.get_fd		= unix_get_fd,
 };
 
 io_manager unix_io_manager = &struct_unix_manager;
@@ -1694,6 +1708,7 @@ static struct struct_io_manager struct_unixfd_manager = {
 	.discard	= unix_discard,
 	.cache_readahead	= unix_cache_readahead,
 	.zeroout	= unix_zeroout,
+	.get_fd		= unix_get_fd,
 };
 
 io_manager unixfd_io_manager = &struct_unixfd_manager;


