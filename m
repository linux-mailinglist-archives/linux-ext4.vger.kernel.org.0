Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBE7682458
	for <lists+linux-ext4@lfdr.de>; Tue, 31 Jan 2023 07:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjAaGQO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 31 Jan 2023 01:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjAaGQJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 31 Jan 2023 01:16:09 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9D53B668
        for <linux-ext4@vger.kernel.org>; Mon, 30 Jan 2023 22:16:02 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 30V6Flm9024387
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 01:15:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1675145749; bh=UBnODzrvHrhWlE18sysyOhRWhOHYCrKAw7AocrTCRRY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=mruIK0rpMEQm/7r6n1zD7+ojlH/xyW6BHsQ2RU9NlD+QQApxhF/Yh5E7aYraD4Mu5
         0SpywscVgdwcGEPTKxEfGr4tXUITsmOOtlQON2hGwRTvlyTGKM9FN8EUSK5gCcAKf7
         vRa03z3KV2V9Dwz6OhvAch5WsKdgo/ziBEg+X8diNBUiMQi3gBgQ4+LD5vHfruQCzl
         3KhKjXcnsHyfOMvFnWM+Jkw5dnlz/dYGUeTcEDiAVQBLtpAr1JouGL2omsp+Dbp4OA
         H6k2VtSaonmsrajGh4wIV0RJa0AVeT5KQaHkgJ6AzwxVT/8hd9wz1qvokH0YdnHIvX
         FrLPSugfP+T/g==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id C191815C35A0; Tue, 31 Jan 2023 01:15:47 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     zhanchengbin1@huawei.com, linfeilong@huawei.com,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 3/3] libext2fs: unix_io: fix_potential error path deadlock in flush_cached_blocks()
Date:   Tue, 31 Jan 2023 01:15:42 -0500
Message-Id: <20230131061542.324172-4-tytso@mit.edu>
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

We can't call the error handler while holding the CACHE_MUTEX (see
previous commit, "libext2fs: unix_io: fix_potential error path
deadlock in reuse_cache()" for details), so first try to write out all
of the dirty blocks in the cache, and then for those where we had
errors, then call the error handler.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 lib/ext2fs/unix_io.c | 61 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 48 insertions(+), 13 deletions(-)

diff --git a/lib/ext2fs/unix_io.c b/lib/ext2fs/unix_io.c
index 2e108a2f..353d85af 100644
--- a/lib/ext2fs/unix_io.c
+++ b/lib/ext2fs/unix_io.c
@@ -614,31 +614,66 @@ static errcode_t flush_cached_blocks(io_channel channel,
 				     int flags)
 {
 	struct unix_cache	*cache;
-	errcode_t		retval, retval2;
+	errcode_t		retval, retval2 = 0;
 	int			i;
+	int			errors_found = 0;
 
-	retval2 = 0;
 	if ((flags & FLUSH_NOLOCK) == 0)
 		mutex_lock(data, CACHE_MTX);
 	for (i=0, cache = data->cache; i < CACHE_SIZE; i++, cache++) {
-		if (!cache->in_use)
+		if (!cache->in_use || !cache->dirty)
 			continue;
-
-		if (flags & FLUSH_INVALIDATE)
-			cache->in_use = 0;
-
-		if (!cache->dirty)
-			continue;
-
 		retval = raw_write_blk(channel, data,
-				       cache->block, 1, cache->buf, 0);
-		if (retval)
+				       cache->block, 1, cache->buf,
+				       RAW_WRITE_NO_HANDLER);
+		if (retval) {
+			cache->write_err = 1;
+			errors_found = 1;
 			retval2 = retval;
-		else
+		} else {
 			cache->dirty = 0;
+			cache->write_err = 0;
+			if (flags & FLUSH_INVALIDATE)
+				cache->in_use = 0;
+		}
 	}
 	if ((flags & FLUSH_NOLOCK) == 0)
 		mutex_unlock(data, CACHE_MTX);
+retry:
+	while (errors_found) {
+		if ((flags & FLUSH_NOLOCK) == 0)
+			mutex_lock(data, CACHE_MTX);
+		errors_found = 0;
+		for (i=0, cache = data->cache; i < CACHE_SIZE; i++, cache++) {
+			if (!cache->in_use || !cache->write_err)
+				continue;
+			errors_found = 1;
+			if (cache->write_err && channel->write_error) {
+				char *err_buf = NULL;
+				unsigned long long err_block = cache->block;
+
+				cache->dirty = 0;
+				cache->in_use = 0;
+				cache->write_err = 0;
+				if (io_channel_alloc_buf(channel, 0,
+							 &err_buf))
+					err_buf = NULL;
+				else
+					memcpy(err_buf, cache->buf,
+					       channel->block_size);
+				mutex_unlock(data, CACHE_MTX);
+				(channel->write_error)(channel, err_block,
+					1, err_buf, channel->block_size, -1,
+					retval2);
+				if (err_buf)
+					ext2fs_free_mem(&err_buf);
+				goto retry;
+			} else
+				cache->write_err = 0;
+		}
+		if ((flags & FLUSH_NOLOCK) == 0)
+			mutex_unlock(data, CACHE_MTX);
+	}
 	return retval2;
 }
 #endif /* NO_IO_CACHE */
-- 
2.31.0

