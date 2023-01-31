Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5BE682459
	for <lists+linux-ext4@lfdr.de>; Tue, 31 Jan 2023 07:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjAaGQQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 31 Jan 2023 01:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjAaGQK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 31 Jan 2023 01:16:10 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5AE73C290
        for <linux-ext4@vger.kernel.org>; Mon, 30 Jan 2023 22:16:04 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 30V6FlR3024373
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 01:15:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1675145749; bh=bB3ol3QwJHPaCYD51i1b5VRfIPM/3/RD8IZoaQQRJng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=fRZJt8WUpVA7l3xb5BsvS1lUmoNvEJWfugXGdvw3kTu+4q8PG/GjoQs+EBWcWX/7D
         QeIAaT9705uG9TdmCUoyV0yzVaH8E0+JD7ssQAoJLnVkOKi6+xsXjhjp3ewIMQSGZr
         +re9QP0+lHQyoowDExEBQXP3S+px2M9UIwIAdDULkxW/E+Rp8CG4sB9Wt2NTUlKd03
         /EJ1qyS+qd2xIVWsLOWQPhNaRCEIh0xKyGP5mKOH6yBXzaOi1dTcVK3++7oTWvyvGx
         2CAm9VN2s8nk77kpozP2+Kxgh1A7IDvFTr4cKRiS6A2XnCBSLgKjlvDBaEzMe1NKI7
         pbCASFbHBj27w==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id C030315C359F; Tue, 31 Jan 2023 01:15:47 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     zhanchengbin1@huawei.com, linfeilong@huawei.com,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 2/3] libext2fs: unix_io: fix potential error path deadlock in reuse_cache()
Date:   Tue, 31 Jan 2023 01:15:41 -0500
Message-Id: <20230131061542.324172-3-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230131061542.324172-1-tytso@mit.edu>
References: <20230131061542.324172-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This was reported by [1] but the fix was incorrect.  The issue is that
when unix_io was made thread-safe, it was necessary that to add a
CACHE_MUTEX to protect multiple threads from potentially colliding
with the very simple writeback cache used by the unix_io I/O manager.
The original I/O manager was purposefully kept simple, used a
fixed-size cache; accordingly, the locking used also kept simple, and
used a single global mutex.

[1] https://lore.kernel.org/r/310fb77f-dfed-1196-c4ee-30d5138ee5a2@huawei.com

The problem was that if an application (such as e2fsck) registers a
write error handler, that handler would be called with the CACHE_MUTEX
still held, and if that application tried to do any I/O --- for
example, closing the file system using ext2fs_close() and then exiting
--- the application would deadlock.

We should perhaps fix this either by deciding that the simple Unix I/O
cache doesn't actually buy much beyond some system call overhead, or
by putting in a full-fledged buffer I/O cache system which uses a much
larger cache with allocated memory, fine-grained locking and Direct
I/O to prevent double cache at the kernel and userspace level.
However, for now, fix the problem by waiting until after we have
released the CACHE_MUTEX before calling the write handler.  This is
good enough given how e2fsck's ehandler.c use case, and in practice no
one else really uses the error handler in any case.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 lib/ext2fs/unix_io.c | 75 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 69 insertions(+), 6 deletions(-)

diff --git a/lib/ext2fs/unix_io.c b/lib/ext2fs/unix_io.c
index 02d7fe1a..2e108a2f 100644
--- a/lib/ext2fs/unix_io.c
+++ b/lib/ext2fs/unix_io.c
@@ -94,6 +94,7 @@ struct unix_cache {
 	int			access_time;
 	unsigned		dirty:1;
 	unsigned		in_use:1;
+	unsigned		write_err:1;
 };
 
 #define CACHE_SIZE 8
@@ -579,16 +580,27 @@ static struct unix_cache *find_cached_block(struct unix_private_data *data,
 /*
  * Reuse a particular cache entry for another block.
  */
-static void reuse_cache(io_channel channel, struct unix_private_data *data,
-		 struct unix_cache *cache, unsigned long long block)
+static errcode_t reuse_cache(io_channel channel,
+		struct unix_private_data *data, struct unix_cache *cache,
+		unsigned long long block)
 {
-	if (cache->dirty && cache->in_use)
-		raw_write_blk(channel, data, cache->block, 1, cache->buf, 0);
+	if (cache->dirty && cache->in_use) {
+		errcode_t retval;
+
+		retval = raw_write_blk(channel, data, cache->block, 1,
+				       cache->buf, RAW_WRITE_NO_HANDLER);
+		if (retval) {
+			cache->write_err = 1;
+			return retval;
+		}
+	}
 
 	cache->in_use = 1;
 	cache->dirty = 0;
+	cache->write_err = 0;
 	cache->block = block;
 	cache->access_time = ++data->access_time;
+	return 0;
 }
 
 #define FLUSH_INVALIDATE	0x01
@@ -1037,7 +1049,10 @@ static errcode_t unix_read_blk64(io_channel channel, unsigned long long block,
 		/* Save the results in the cache */
 		for (j=0; j < i; j++) {
 			if (!find_cached_block(data, block, &cache)) {
-				reuse_cache(channel, data, cache, block);
+				retval = reuse_cache(channel, data,
+						     cache, block);
+				if (retval)
+					goto call_write_handler;
 				memcpy(cache->buf, cp, channel->block_size);
 			}
 			count--;
@@ -1047,6 +1062,28 @@ static errcode_t unix_read_blk64(io_channel channel, unsigned long long block,
 	}
 	mutex_unlock(data, CACHE_MTX);
 	return 0;
+
+call_write_handler:
+	if (cache->write_err && channel->write_error) {
+		char *err_buf = NULL;
+		unsigned long long err_block = cache->block;
+
+		cache->dirty = 0;
+		cache->in_use = 0;
+		cache->write_err = 0;
+		if (io_channel_alloc_buf(channel, 0, &err_buf))
+			err_buf = NULL;
+		else
+			memcpy(err_buf, cache->buf, channel->block_size);
+		mutex_unlock(data, CACHE_MTX);
+		(channel->write_error)(channel, err_block, 1, err_buf,
+				       channel->block_size, -1,
+				       retval);
+		if (err_buf)
+			ext2fs_free_mem(&err_buf);
+	} else
+		mutex_unlock(data, CACHE_MTX);
+	return retval;
 #endif /* NO_IO_CACHE */
 }
 
@@ -1099,8 +1136,12 @@ static errcode_t unix_write_blk64(io_channel channel, unsigned long long block,
 	while (count > 0) {
 		cache = find_cached_block(data, block, &reuse);
 		if (!cache) {
+			errcode_t err;
+
 			cache = reuse;
-			reuse_cache(channel, data, cache, block);
+			err = reuse_cache(channel, data, cache, block);
+			if (err)
+				goto call_write_handler;
 		}
 		if (cache->buf != cp)
 			memcpy(cache->buf, cp, channel->block_size);
@@ -1111,6 +1152,28 @@ static errcode_t unix_write_blk64(io_channel channel, unsigned long long block,
 	}
 	mutex_unlock(data, CACHE_MTX);
 	return retval;
+
+call_write_handler:
+	if (cache->write_err && channel->write_error) {
+		char *err_buf = NULL;
+		unsigned long long err_block = cache->block;
+
+		cache->dirty = 0;
+		cache->in_use = 0;
+		cache->write_err = 0;
+		if (io_channel_alloc_buf(channel, 0, &err_buf))
+			err_buf = NULL;
+		else
+			memcpy(err_buf, cache->buf, channel->block_size);
+		mutex_unlock(data, CACHE_MTX);
+		(channel->write_error)(channel, err_block, 1, err_buf,
+				       channel->block_size, -1,
+				       retval);
+		if (err_buf)
+			ext2fs_free_mem(&err_buf);
+	} else
+		mutex_unlock(data, CACHE_MTX);
+	return retval;
 #endif /* NO_IO_CACHE */
 }
 
-- 
2.31.0

