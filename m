Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5757761F2E4
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbiKGMXT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbiKGMXS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:23:18 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188F06365
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:23:18 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id d59-20020a17090a6f4100b00213202d77e1so14419821pjk.2
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=irSzPw79BRKUVrHVl4f23XokUTckSF260z11EDuYM7Y=;
        b=MT9bzENgyufshjZCrjPnVVQY7lA+rvJ7Nij555u8DnnEbz8phJpGApqyMwdWcCm8Ls
         QSarOJXQWAB8lxXcZttXL8xXoDE2u7NWttdjxNM5G1VaRrH3PoTIKAMzajGJYavcn0y2
         lfpogVkB8lS2xZbDF9shCvHTjX1xKYN6MviIPtXQIIgbOc1b4dZQP/Thh75q/T3IPD3f
         m+gRcNig/+2QZvlmmw5zk8uENPq6HaPDfW8UuhwXki6F/VSA3BzxxCuH44bJfABIUtyC
         siJ2Wg/qwVY83NFoDfGj1drsZxOcTbDbT/DLU2IVb4JN8ExiKX0F03rlJPwMgt3yDFR4
         VPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=irSzPw79BRKUVrHVl4f23XokUTckSF260z11EDuYM7Y=;
        b=oPa4V7UbYJe+yqPkVfuEd5iWfs87nMZsTZE2cTX7nyFHl7jChzAeu1+Vm7X3foI7R8
         fLwwzwde+LTn6BJU48HgEAbpkr8HWC8VLyt6/7KIkm5DQd7LlZK+Qfijzu2Xu5M/K8Tr
         tBbhl6+Sr94FsV1uWzhCGKxZgCCs/2uKHbsmYnPVDKlrS1BzVwUmurNsAHU95mMysx2T
         LcBUgJiLbhp6bwl51N1X77hVe2DKPNhzO7aVIX6H3Yt+5vcpap8R/Zaltni3Vr6NJbPL
         0+atTVrHc+3YrOMogt4QgYXyN+Fcm0+oksKgTyUYKrBiC2sIE3sojhKzpSqRH2A7wRja
         74nw==
X-Gm-Message-State: ACrzQf0uAe3SlqoQn05bI+PtbG7sS/TYTyIjAurPQKCa2hPmcAeFkGxT
        J/JbM6dh1dqgpjqymJXOWsQ=
X-Google-Smtp-Source: AMsMyM5TQIXJHahPVWTVPL/9YGnXOogquy5Rzb4cnsUrmYxeVOO0ngFlD6sbUO2GptAwQ3oVDLXhVQ==
X-Received: by 2002:a17:902:b281:b0:186:9596:742f with SMTP id u1-20020a170902b28100b001869596742fmr49856214plr.49.1667823797587;
        Mon, 07 Nov 2022 04:23:17 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id p1-20020a170902a40100b00177f4ef7970sm4896664plq.11.2022.11.07.04.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:23:16 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFCv1 09/72] libext2fs: Add flush cleanup API
Date:   Mon,  7 Nov 2022 17:50:57 +0530
Message-Id: <81451e5fcf02b502164e0e9f049df940b07de715.1667822611.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1667822611.git.ritesh.list@gmail.com>
References: <cover.1667822611.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Li Xi <lixi@ddn.com>

Signed-off-by: Li Xi <lixi@ddn.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 lib/ext2fs/ext2_io.h |  2 ++
 lib/ext2fs/undo_io.c | 19 +++++++++++++++++++
 lib/ext2fs/unix_io.c | 24 +++++++++++++++++++++---
 3 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/lib/ext2fs/ext2_io.h b/lib/ext2fs/ext2_io.h
index 8fe5b323..8cc355be 100644
--- a/lib/ext2fs/ext2_io.h
+++ b/lib/ext2fs/ext2_io.h
@@ -82,6 +82,7 @@ struct struct_io_manager {
 	errcode_t (*write_blk)(io_channel channel, unsigned long block,
 			       int count, const void *data);
 	errcode_t (*flush)(io_channel channel);
+	errcode_t (*flush_cleanup)(io_channel channel);
 	errcode_t (*write_byte)(io_channel channel, unsigned long offset,
 				int count, const void *data);
 	errcode_t (*set_option)(io_channel channel, const char *option,
@@ -116,6 +117,7 @@ struct struct_io_manager {
 #define io_channel_read_blk(c,b,n,d)	((c)->manager->read_blk((c),b,n,d))
 #define io_channel_write_blk(c,b,n,d)	((c)->manager->write_blk((c),b,n,d))
 #define io_channel_flush(c) 		((c)->manager->flush((c)))
+#define io_channel_flush_cleanup(c) 	((c)->manager->flush_cleanup((c)))
 #define io_channel_bumpcount(c)		((c)->refcount++)
 
 /* io_manager.c */
diff --git a/lib/ext2fs/undo_io.c b/lib/ext2fs/undo_io.c
index f4a6d526..678ff421 100644
--- a/lib/ext2fs/undo_io.c
+++ b/lib/ext2fs/undo_io.c
@@ -1024,6 +1024,24 @@ static errcode_t undo_flush(io_channel channel)
 	return retval;
 }
 
+/*
+ * Flush data buffers to disk and cleanup the cache.
+ */
+static errcode_t undo_flush_cleanup(io_channel channel)
+{
+	errcode_t	retval = 0;
+	struct undo_private_data *data;
+
+	EXT2_CHECK_MAGIC(channel, EXT2_ET_MAGIC_IO_CHANNEL);
+	data = (struct undo_private_data *) channel->private_data;
+	EXT2_CHECK_MAGIC(data, EXT2_ET_MAGIC_UNIX_IO_CHANNEL);
+
+	if (data->real)
+		retval = io_channel_flush_cleanup(data->real);
+
+	return retval;
+}
+
 static errcode_t undo_set_option(io_channel channel, const char *option,
 				 const char *arg)
 {
@@ -1095,6 +1113,7 @@ static struct struct_io_manager struct_undo_manager = {
 	.read_blk	= undo_read_blk,
 	.write_blk	= undo_write_blk,
 	.flush		= undo_flush,
+	.flush_cleanup	= undo_flush_cleanup,
 	.write_byte	= undo_write_byte,
 	.set_option	= undo_set_option,
 	.get_stats	= undo_get_stats,
diff --git a/lib/ext2fs/unix_io.c b/lib/ext2fs/unix_io.c
index 5b894826..8f8118a3 100644
--- a/lib/ext2fs/unix_io.c
+++ b/lib/ext2fs/unix_io.c
@@ -1173,9 +1173,9 @@ static errcode_t unix_write_byte(io_channel channel, unsigned long offset,
 }
 
 /*
- * Flush data buffers to disk.
+ * Flush data buffers to disk and invalidate cache if needed
  */
-static errcode_t unix_flush(io_channel channel)
+static errcode_t _unix_flush(io_channel channel, int invalidate)
 {
 	struct unix_private_data *data;
 	errcode_t retval = 0;
@@ -1185,7 +1185,7 @@ static errcode_t unix_flush(io_channel channel)
 	EXT2_CHECK_MAGIC(data, EXT2_ET_MAGIC_UNIX_IO_CHANNEL);
 
 #ifndef NO_IO_CACHE
-	retval = flush_cached_blocks(channel, data, 0);
+	retval = flush_cached_blocks(channel, data, invalidate);
 #endif
 #ifdef HAVE_FSYNC
 	if (!retval && fsync(data->dev) != 0)
@@ -1194,6 +1194,22 @@ static errcode_t unix_flush(io_channel channel)
 	return retval;
 }
 
+/*
+ * Flush data buffers to disk.
+ */
+static errcode_t unix_flush(io_channel channel)
+{
+	return _unix_flush(channel, 0);
+}
+
+/*
+ * Flush data buffers to disk and invalidate cache.
+ */
+static errcode_t unix_flush_cleanup(io_channel channel)
+{
+	return _unix_flush(channel, 1);
+}
+
 static errcode_t unix_set_option(io_channel channel, const char *option,
 				 const char *arg)
 {
@@ -1383,6 +1399,7 @@ static struct struct_io_manager struct_unix_manager = {
 	.discard	= unix_discard,
 	.cache_readahead	= unix_cache_readahead,
 	.zeroout	= unix_zeroout,
+	.flush_cleanup	= unix_flush_cleanup,
 };
 
 io_manager unix_io_manager = &struct_unix_manager;
@@ -1404,6 +1421,7 @@ static struct struct_io_manager struct_unixfd_manager = {
 	.discard	= unix_discard,
 	.cache_readahead	= unix_cache_readahead,
 	.zeroout	= unix_zeroout,
+	.flush_cleanup	= unix_flush_cleanup,
 };
 
 io_manager unixfd_io_manager = &struct_unixfd_manager;
-- 
2.37.3

