Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972DA6C8BF0
	for <lists+linux-ext4@lfdr.de>; Sat, 25 Mar 2023 07:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbjCYG6G (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 25 Mar 2023 02:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbjCYG6E (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 25 Mar 2023 02:58:04 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB79E166FD
        for <linux-ext4@vger.kernel.org>; Fri, 24 Mar 2023 23:57:54 -0700 (PDT)
Received: from dggpeml500016.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Pk8yw2vn3zKncm;
        Sat, 25 Mar 2023 14:57:28 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500016.china.huawei.com
 (7.185.36.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Sat, 25 Mar
 2023 14:57:53 +0800
From:   zhanchengbin <zhanchengbin1@huawei.com>
To:     <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>, <linfeilong@huawei.com>,
        <louhongxiang@huawei.com>, <liuzhiqiang26@huawei.com>,
        zhanchengbin <zhanchengbin1@huawei.com>
Subject: [PATCH 1/2] lib/ext2fs: add error handle in unix_flush and unix_write_byte
Date:   Sat, 25 Mar 2023 14:56:51 +0800
Message-ID: <20230325065652.2111384-2-zhanchengbin1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230325065652.2111384-1-zhanchengbin1@huawei.com>
References: <20230325065652.2111384-1-zhanchengbin1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500016.china.huawei.com (7.185.36.70)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

As you can see, a new error handling has been added for fsync, and the error
handling for unix_write_byte function has reused the error handling of
write_blk.

Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
---
 lib/ext2fs/ext2_io.h |  2 ++
 lib/ext2fs/unix_io.c | 37 ++++++++++++++++++++++++++-----------
 2 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/lib/ext2fs/ext2_io.h b/lib/ext2fs/ext2_io.h
index 679184e3..becd7078 100644
--- a/lib/ext2fs/ext2_io.h
+++ b/lib/ext2fs/ext2_io.h
@@ -56,6 +56,8 @@ struct struct_io_channel {
 				       size_t size,
 				       int actual_bytes_written,
 				       errcode_t error);
+	errcode_t       (*sync_error)(io_channel channel,
+	                               errcode_t error);
 	int		refcount;
 	int		flags;
 	long		reserved[14];
diff --git a/lib/ext2fs/unix_io.c b/lib/ext2fs/unix_io.c
index 3171c736..283b4eb6 100644
--- a/lib/ext2fs/unix_io.c
+++ b/lib/ext2fs/unix_io.c
@@ -1250,7 +1250,8 @@ static errcode_t unix_write_byte(io_channel channel, unsigned long offset,
 #ifdef ALIGN_DEBUG
 		printf("unix_write_byte: O_DIRECT fallback\n");
 #endif
-		return EXT2_ET_UNIMPLEMENTED;
+		retval = EXT2_ET_UNIMPLEMENTED;
+		goto error_out;
 	}
 
 #ifndef NO_IO_CACHE
@@ -1258,19 +1259,30 @@ static errcode_t unix_write_byte(io_channel channel, unsigned long offset,
 	 * Flush out the cache completely
 	 */
 	if ((retval = flush_cached_blocks(channel, data, FLUSH_INVALIDATE)))
-		return retval;
+		goto error_out;
 #endif
 
-	if (lseek(data->dev, offset + data->offset, SEEK_SET) < 0)
-		return errno;
+	if (lseek(data->dev, offset + data->offset, SEEK_SET) < 0) {
+		retval = errno;
+		goto error_out;
+	}
 
 	actual = write(data->dev, buf, size);
-	if (actual < 0)
-		return errno;
-	if (actual != size)
-		return EXT2_ET_SHORT_WRITE;
-
+	if (actual < 0) {
+		retval = errno;
+		goto error_out;
+	}
+	if (actual != size) {
+		retval = EXT2_ET_SHORT_WRITE;
+		goto error_out;
+	}
 	return 0;
+error_out:
+	if (channel->write_error)
+		retval = (channel->write_error)(channel,
+					offset / channel->block_size, 0, buf,
+					size, actual, retval);
+	return retval;
 }
 
 /*
@@ -1289,8 +1301,11 @@ static errcode_t unix_flush(io_channel channel)
 	retval = flush_cached_blocks(channel, data, 0);
 #endif
 #ifdef HAVE_FSYNC
-	if (!retval && fsync(data->dev) != 0)
-		return errno;
+	if (!retval && fsync(data->dev) != 0) {
+		if (channel->sync_error)
+			retval = (channel->sync_error)(channel, errno);
+		return retval;
+	}
 #endif
 	return retval;
 }
-- 
2.31.1

