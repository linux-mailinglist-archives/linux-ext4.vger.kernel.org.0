Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0D8682456
	for <lists+linux-ext4@lfdr.de>; Tue, 31 Jan 2023 07:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjAaGQL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 31 Jan 2023 01:16:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjAaGQJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 31 Jan 2023 01:16:09 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FD53BDBA
        for <linux-ext4@vger.kernel.org>; Mon, 30 Jan 2023 22:16:01 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 30V6FlAu024382
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 01:15:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1675145749; bh=kZvJHUTIUyHJrXL19dTYGYTlG0sjPmkge1I/9CEBrug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=fhbcU8fPtHhDUgc7mfzxt/GIA+RZvMWdNV34Fq+JsYiVla3MithM5t4nRL9Hqy/Uw
         pABy/rLbVmPgywAR5ICHP4zMBnvXY7xvcbttTEt7UNmexAvOwB0xQoJfqhlq9uK0to
         nYY5aGf8SE6TbzidF0tL5KcPtZvn69YTXA3IrnuB8yDGwV7PhB3c68JHaqlNGbFOqj
         VvgrcebTzLaSboMLf64AUY1d46+6lQMAAqyEUSJf2dJg9KWJXmb+GiS0/Y8hv8X2QL
         X5+fT3H4RQBO1P4aKaBjCmu76Ndkbfpba8hfaVxyaOTg2YDi9NcFdfwrnkKiaoIFId
         +Z+kjHx7zCf9w==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id BE11815C359E; Tue, 31 Jan 2023 01:15:47 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     zhanchengbin1@huawei.com, linfeilong@huawei.com,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 1/3] libext2fs: unix_io: add flag which suppresses calling the write error handler
Date:   Tue, 31 Jan 2023 01:15:40 -0500
Message-Id: <20230131061542.324172-2-tytso@mit.edu>
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

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 lib/ext2fs/unix_io.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/lib/ext2fs/unix_io.c b/lib/ext2fs/unix_io.c
index e53db333..02d7fe1a 100644
--- a/lib/ext2fs/unix_io.c
+++ b/lib/ext2fs/unix_io.c
@@ -337,10 +337,13 @@ error_unlock:
 	return retval;
 }
 
+#define RAW_WRITE_NO_HANDLER	1
+
 static errcode_t raw_write_blk(io_channel channel,
 			       struct unix_private_data *data,
 			       unsigned long long block,
-			       int count, const void *bufv)
+			       int count, const void *bufv,
+			       int flags)
 {
 	ssize_t		size;
 	ext2_loff_t	location;
@@ -482,7 +485,7 @@ bounce_write:
 error_unlock:
 	mutex_unlock(data, BOUNCE_MTX);
 error_out:
-	if (channel->write_error)
+	if (((flags & RAW_WRITE_NO_HANDLER) == 0) && channel->write_error)
 		retval = (channel->write_error)(channel, block, count, buf,
 						size, actual, retval);
 	return retval;
@@ -580,7 +583,7 @@ static void reuse_cache(io_channel channel, struct unix_private_data *data,
 		 struct unix_cache *cache, unsigned long long block)
 {
 	if (cache->dirty && cache->in_use)
-		raw_write_blk(channel, data, cache->block, 1, cache->buf);
+		raw_write_blk(channel, data, cache->block, 1, cache->buf, 0);
 
 	cache->in_use = 1;
 	cache->dirty = 0;
@@ -616,7 +619,7 @@ static errcode_t flush_cached_blocks(io_channel channel,
 			continue;
 
 		retval = raw_write_blk(channel, data,
-				       cache->block, 1, cache->buf);
+				       cache->block, 1, cache->buf, 0);
 		if (retval)
 			retval2 = retval;
 		else
@@ -1067,10 +1070,10 @@ static errcode_t unix_write_blk64(io_channel channel, unsigned long long block,
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
@@ -1079,7 +1082,7 @@ static errcode_t unix_write_blk64(io_channel channel, unsigned long long block,
 		if ((retval = flush_cached_blocks(channel, data,
 						  FLUSH_INVALIDATE)))
 			return retval;
-		return raw_write_blk(channel, data, block, count, buf);
+		return raw_write_blk(channel, data, block, count, buf, 0);
 	}
 
 	/*
@@ -1089,7 +1092,7 @@ static errcode_t unix_write_blk64(io_channel channel, unsigned long long block,
 	 */
 	writethrough = channel->flags & CHANNEL_FLAGS_WRITETHROUGH;
 	if (writethrough)
-		retval = raw_write_blk(channel, data, block, count, buf);
+		retval = raw_write_blk(channel, data, block, count, buf, 0);
 
 	cp = buf;
 	mutex_lock(data, CACHE_MTX);
-- 
2.31.0

