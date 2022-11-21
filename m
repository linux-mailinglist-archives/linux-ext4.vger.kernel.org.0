Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B53263186D
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Nov 2022 03:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiKUCAz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 20 Nov 2022 21:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiKUCAy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 20 Nov 2022 21:00:54 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5616318B0D
        for <linux-ext4@vger.kernel.org>; Sun, 20 Nov 2022 18:00:52 -0800 (PST)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NFrFL5h2sz15Mmq;
        Mon, 21 Nov 2022 10:00:22 +0800 (CST)
Received: from dggpeml500016.china.huawei.com (7.185.36.70) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 10:00:50 +0800
Received: from [10.174.176.102] (10.174.176.102) by
 dggpeml500016.china.huawei.com (7.185.36.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 10:00:50 +0800
Message-ID: <310fb77f-dfed-1196-c4ee-30d5138ee5a2@huawei.com>
Date:   Mon, 21 Nov 2022 10:00:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
From:   zhanchengbin <zhanchengbin1@huawei.com>
Subject: [PATCH] unix_io.c: fix deadlock problem in unix_write_blk64
To:     Theodore Ts'o <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>, linfeilong <linfeilong@huawei.com>,
        <liuzhiqiang26@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.102]
X-ClientProxiedBy: dggpeml500006.china.huawei.com (7.185.36.76) To
 dggpeml500016.china.huawei.com (7.185.36.70)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The process is deadlocked, and an I/O error occurs when logs
are replayed. Because in the I/O error handling function, I/O
is sent again and catch the mutexlock of CACHE_MTX.

stack:
(gdb) bt
0  0x0000ffffa740bc34 in ?? () from /usr/lib64/libc.so.6
1  0x0000ffffa7412024 in pthread_mutex_lock () from /usr/lib64/libc.so.6
2  0x0000ffffa7654e54 in mutex_lock (kind=CACHE_MTX, 
data=0xaaaaf5c98f30) at unix_io.c:151
3  unix_write_blk64 (channel=0xaaaaf5c98e60, block=2, count=4, 
buf=0xaaaaf5c9d170) at unix_io.c:1092
4  0x0000ffffa762e610 in ext2fs_flush2 (flags=0, fs=0xaaaaf5c98cc0) at 
closefs.c:401
5  ext2fs_flush2 (fs=0xaaaaf5c98cc0, flags=0) at closefs.c:279
6  0x0000ffffa762eb14 in ext2fs_close2 (fs=fs@entry=0xaaaaf5c98cc0, 
flags=flags@entry=0) at closefs.c:510
7  0x0000ffffa762eba4 in ext2fs_close_free 
(fs_ptr=fs_ptr@entry=0xffffc8cbab30) at closefs.c:472
8  0x0000aaaadcc39bd8 in preenhalt (ctx=ctx@entry=0xaaaaf5c98460) at 
util.c:365
9  0x0000aaaadcc3bc5c in e2fsck_handle_write_error (channel=<optimized 
out>, block=262152, count=<optimized out>, data=<optimized out>, 
size=<optimized out>, actual=<optimized out>, error=5) at ehandler.c:114
10 0x0000ffffa7655044 in reuse_cache (block=262206, 
cache=0xaaaaf5c98f80, data=0xaaaaf5c98f30, channel=0xaaaaf5c98e60) at 
unix_io.c:583
11 unix_write_blk64 (channel=0xaaaaf5c98e60, block=262206, 
count=<optimized out>, buf=<optimized out>) at unix_io.c:1097
12 0x0000aaaadcc3702c in ll_rw_block (rw=rw@entry=1, 
op_flags=op_flags@entry=0, nr=<optimized out>, nr@entry=1, 
bhp=0xffffc8cbac60, bhp@entry=0xffffc8cbac58) at journal.c:184
13 0x0000aaaadcc375e8 in brelse (bh=<optimized out>, 
bh@entry=0xaaaaf5cac4a0) at journal.c:217
14 0x0000aaaadcc3ebe0 in do_one_pass 
(journal=journal@entry=0xaaaaf5c9f590, info=info@entry=0xffffc8cbad60, 
pass=pass@entry=PASS_REPLAY) at recovery.c:693
15 0x0000aaaadcc3ee74 in jbd2_journal_recover (journal=0xaaaaf5c9f590) 
at recovery.c:310
16 0x0000aaaadcc386a8 in recover_ext3_journal (ctx=0xaaaaf5c98460) at 
journal.c:1653
17 e2fsck_run_ext3_journal (ctx=0xaaaaf5c98460) at journal.c:1706
18 0x0000aaaadcc207e0 in main (argc=<optimized out>, argv=<optimized 
out>) at unix.c:1791

Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
---
  lib/ext2fs/unix_io.c | 63 +++++++++++++++++++++++++++++++-------------
  1 file changed, 45 insertions(+), 18 deletions(-)

diff --git a/lib/ext2fs/unix_io.c b/lib/ext2fs/unix_io.c
index e53db333..89d82b48 100644
--- a/lib/ext2fs/unix_io.c
+++ b/lib/ext2fs/unix_io.c
@@ -210,7 +210,8 @@ static char *safe_getenv(const char *arg)
  static errcode_t raw_read_blk(io_channel channel,
  			      struct unix_private_data *data,
  			      unsigned long long block,
-			      int count, void *bufv)
+			      int count, void *bufv,
+			      int cache_lock)
  {
  	errcode_t	retval;
  	ssize_t		size;
@@ -331,16 +332,22 @@ error_unlock:
  	mutex_unlock(data, BOUNCE_MTX);
  	if (actual >= 0 && actual < size)
  		memset((char *) buf+actual, 0, size-actual);
-	if (channel->read_error)
+	if (channel->read_error) {
+		if (cache_lock)
+			mutex_unlock(data, CACHE_MTX);
  		retval = (channel->read_error)(channel, block, count, buf,
  					       size, actual, retval);
+		if (cache_lock)
+			mutex_lock(data, CACHE_MTX);
+	}
  	return retval;
  }

  static errcode_t raw_write_blk(io_channel channel,
  			       struct unix_private_data *data,
  			       unsigned long long block,
-			       int count, const void *bufv)
+			       int count, const void *bufv,
+			       int cache_lock)
  {
  	ssize_t		size;
  	ext2_loff_t	location;
@@ -482,9 +489,14 @@ bounce_write:
  error_unlock:
  	mutex_unlock(data, BOUNCE_MTX);
  error_out:
-	if (channel->write_error)
+	if (channel->write_error) {
+		if (cache_lock)
+			mutex_unlock(data, CACHE_MTX);
  		retval = (channel->write_error)(channel, block, count, buf,
  						size, actual, retval);
+		if (cache_lock)
+			mutex_lock(data, CACHE_MTX);
+	}
  	return retval;
  }

@@ -576,16 +588,22 @@ static struct unix_cache *find_cached_block(struct 
unix_private_data *data,
  /*
   * Reuse a particular cache entry for another block.
   */
-static void reuse_cache(io_channel channel, struct unix_private_data *data,
+static errcode_t reuse_cache(io_channel channel, struct 
unix_private_data *data,
  		 struct unix_cache *cache, unsigned long long block)
  {
-	if (cache->dirty && cache->in_use)
-		raw_write_blk(channel, data, cache->block, 1, cache->buf);
+	errcode_t               retval = 0;
+	if (cache->dirty && cache->in_use) {
+		retval = raw_write_blk(channel, data, cache->block, 1, cache->buf, 1);
+		if (retval)
+			return retval;
+	}

  	cache->in_use = 1;
  	cache->dirty = 0;
  	cache->block = block;
  	cache->access_time = ++data->access_time;
+
+	return retval;
  }

  #define FLUSH_INVALIDATE	0x01
@@ -616,7 +634,8 @@ static errcode_t flush_cached_blocks(io_channel channel,
  			continue;

  		retval = raw_write_blk(channel, data,
-				       cache->block, 1, cache->buf);
+				       cache->block, 1, cache->buf,
+				       !(flags & FLUSH_NOLOCK));
  		if (retval)
  			retval2 = retval;
  		else
@@ -987,10 +1006,10 @@ static errcode_t unix_read_blk64(io_channel 
channel, unsigned long long block,
  	EXT2_CHECK_MAGIC(data, EXT2_ET_MAGIC_UNIX_IO_CHANNEL);

  #ifdef NO_IO_CACHE
-	return raw_read_blk(channel, data, block, count, buf);
+	return raw_read_blk(channel, data, block, count, buf, 0);
  #else
  	if (data->flags & IO_FLAG_NOCACHE)
-		return raw_read_blk(channel, data, block, count, buf);
+		return raw_read_blk(channel, data, block, count, buf, 0);
  	/*
  	 * If we're doing an odd-sized read or a very large read,
  	 * flush out the cache and then do a direct read.
@@ -998,7 +1017,7 @@ static errcode_t unix_read_blk64(io_channel 
channel, unsigned long long block,
  	if (count < 0 || count > WRITE_DIRECT_SIZE) {
  		if ((retval = flush_cached_blocks(channel, data, 0)))
  			return retval;
-		return raw_read_blk(channel, data, block, count, buf);
+		return raw_read_blk(channel, data, block, count, buf, 0);
  	}

  	cp = buf;
@@ -1027,14 +1046,18 @@ static errcode_t unix_read_blk64(io_channel 
channel, unsigned long long block,
  		printf("Reading %d blocks starting at %lu\n", i, block);
  #endif
  		mutex_unlock(data, CACHE_MTX);
-		if ((retval = raw_read_blk(channel, data, block, i, cp)))
+		if ((retval = raw_read_blk(channel, data, block, i, cp, 0)))
  			return retval;
  		mutex_lock(data, CACHE_MTX);

  		/* Save the results in the cache */
  		for (j=0; j < i; j++) {
  			if (!find_cached_block(data, block, &cache)) {
-				reuse_cache(channel, data, cache, block);
+				retval = reuse_cache(channel, data, cache, block);
+				if (retval) {
+					mutex_unlock(data, CACHE_MTX);
+					return retval;
+				}
  				memcpy(cache->buf, cp, channel->block_size);
  			}
  			count--;
@@ -1067,10 +1090,10 @@ static errcode_t unix_write_blk64(io_channel 
channel, unsigned long long block,
  	EXT2_CHECK_MAGIC(data, EXT2_ET_MAGIC_UNIX_IO_CHANNEL);

  #ifdef NO_IO_CACHE
-	return raw_write_blk(channel, data, block, count, buf);
+	return raw_write_blk(channel, data, block, count, buf, 0);
  #else
  	if (data->flags & IO_FLAG_NOCACHE)
-		return raw_write_blk(channel, data, block, count, buf);
+		return raw_write_blk(channel, data, block, count, buf, 0);
  	/*
  	 * If we're doing an odd-sized write or a very large write,
  	 * flush out the cache completely and then do a direct write.
@@ -1079,7 +1102,7 @@ static errcode_t unix_write_blk64(io_channel 
channel, unsigned long long block,
  		if ((retval = flush_cached_blocks(channel, data,
  						  FLUSH_INVALIDATE)))
  			return retval;
-		return raw_write_blk(channel, data, block, count, buf);
+		return raw_write_blk(channel, data, block, count, buf, 0);
  	}

  	/*
@@ -1089,7 +1112,7 @@ static errcode_t unix_write_blk64(io_channel 
channel, unsigned long long block,
  	 */
  	writethrough = channel->flags & CHANNEL_FLAGS_WRITETHROUGH;
  	if (writethrough)
-		retval = raw_write_blk(channel, data, block, count, buf);
+		retval = raw_write_blk(channel, data, block, count, buf, 0);

  	cp = buf;
  	mutex_lock(data, CACHE_MTX);
@@ -1097,7 +1120,11 @@ static errcode_t unix_write_blk64(io_channel 
channel, unsigned long long block,
  		cache = find_cached_block(data, block, &reuse);
  		if (!cache) {
  			cache = reuse;
-			reuse_cache(channel, data, cache, block);
+			retval = reuse_cache(channel, data, cache, block);
+			if (retval) {
+				mutex_unlock(data, CACHE_MTX);
+				return retval;
+			}
  		}
  		if (cache->buf != cp)
  			memcpy(cache->buf, cp, channel->block_size);
-- 
2.27.0

