Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5CD64335E9
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Oct 2021 14:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235595AbhJSM3P (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 Oct 2021 08:29:15 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:24359 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbhJSM3M (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 19 Oct 2021 08:29:12 -0400
Received: from dggeme754-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HYXtn3rXdzbhCr;
        Tue, 19 Oct 2021 20:22:25 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme754-chm.china.huawei.com
 (10.3.19.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.15; Tue, 19
 Oct 2021 20:26:58 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <jack@suse.cz>,
        Ye Bin <yebin10@huawei.com>
Subject: [PATCH -next v4 3/3] ext4: simplify read_mmp_block fucntion
Date:   Tue, 19 Oct 2021 20:39:31 +0800
Message-ID: <20211019123931.1545295-4-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211019123931.1545295-1-yebin10@huawei.com>
References: <20211019123931.1545295-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggeme754-chm.china.huawei.com (10.3.19.100)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch is according to Jan Kara's suggestion:
I guess I would just get rid of sb_getblk() in read_mmp_block() and always
expect valid bh passed. The only place that passes NULL bh after this
patch is one case in ext4_multi_mount_protect() and that can call
sb_getblk() on its own. That way we can also simplify read_mmp_block()
prototype to:

static int read_mmp_block(struct super_block *sb, struct buffer_head *bh);

Signed-off-by: Ye Bin <yebin10@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/mmp.c | 44 +++++++++++++++++++-------------------------
 1 file changed, 19 insertions(+), 25 deletions(-)

diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
index 9788c617e593..3a7370c88934 100644
--- a/fs/ext4/mmp.c
+++ b/fs/ext4/mmp.c
@@ -64,33 +64,26 @@ static int write_mmp_block(struct super_block *sb, struct buffer_head *bh)
 /*
  * Read the MMP block. It _must_ be read from disk and hence we clear the
  * uptodate flag on the buffer.
+ * Caller must ensure pass valid 'bh'.
  */
-static int read_mmp_block(struct super_block *sb, struct buffer_head **bh,
-			  ext4_fsblk_t mmp_block)
+static int read_mmp_block(struct super_block *sb, struct buffer_head *bh)
 {
 	struct mmp_struct *mmp;
 	int ret;
 
-	if (*bh)
-		clear_buffer_uptodate(*bh);
-
-	/* This would be sb_bread(sb, mmp_block), except we need to be sure
-	 * that the MD RAID device cache has been bypassed, and that the read
-	 * is not blocked in the elevator. */
-	if (!*bh) {
-		*bh = sb_getblk(sb, mmp_block);
-		if (!*bh) {
-			ret = -ENOMEM;
-			goto warn_exit;
-		}
+	if (!bh) {
+		ret = -EINVAL;
+		goto warn_exit;
 	}
 
-	lock_buffer(*bh);
-	ret = ext4_read_bh(*bh, REQ_META | REQ_PRIO, NULL);
+	clear_buffer_uptodate(bh);
+
+	lock_buffer(bh);
+	ret = ext4_read_bh(bh, REQ_META | REQ_PRIO, NULL);
 	if (ret)
 		goto warn_exit;
 
-	mmp = (struct mmp_struct *)((*bh)->b_data);
+	mmp = (struct mmp_struct *)((bh)->b_data);
 	if (le32_to_cpu(mmp->mmp_magic) != EXT4_MMP_MAGIC) {
 		ret = -EFSCORRUPTED;
 		goto warn_exit;
@@ -101,10 +94,7 @@ static int read_mmp_block(struct super_block *sb, struct buffer_head **bh,
 	}
 	return 0;
 warn_exit:
-	brelse(*bh);
-	*bh = NULL;
-	ext4_warning(sb, "Error %d while reading MMP block %llu",
-		     ret, mmp_block);
+	ext4_warning(sb, "Error %d while reading MMP block", ret);
 	return ret;
 }
 
@@ -195,7 +185,7 @@ static int kmmpd(void *data)
 		 */
 		diff = jiffies - last_update_time;
 		if (diff > mmp_check_interval * HZ) {
-			retval = read_mmp_block(sb, &bh, mmp_block);
+			retval = read_mmp_block(sb, bh);
 			if (retval) {
 				ext4_error_err(sb, -retval,
 					       "error reading MMP data: %d",
@@ -289,7 +279,11 @@ int ext4_multi_mount_protect(struct super_block *sb,
 		goto failed;
 	}
 
-	retval = read_mmp_block(sb, &bh, mmp_block);
+	bh = sb_getblk(sb, mmp_block);
+	if (bh)
+		goto failed;
+
+	retval = read_mmp_block(sb, bh);
 	if (retval)
 		goto failed;
 
@@ -327,7 +321,7 @@ int ext4_multi_mount_protect(struct super_block *sb,
 		goto failed;
 	}
 
-	retval = read_mmp_block(sb, &bh, mmp_block);
+	retval = read_mmp_block(sb, bh);
 	if (retval)
 		goto failed;
 	mmp = (struct mmp_struct *)(bh->b_data);
@@ -356,7 +350,7 @@ int ext4_multi_mount_protect(struct super_block *sb,
 		goto failed;
 	}
 
-	retval = read_mmp_block(sb, &bh, mmp_block);
+	retval = read_mmp_block(sb, bh);
 	if (retval)
 		goto failed;
 	mmp = (struct mmp_struct *)(bh->b_data);
-- 
2.31.1

