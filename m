Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49E73432E6A
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Oct 2021 08:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbhJSGjn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 Oct 2021 02:39:43 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:25233 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233986AbhJSGjl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 19 Oct 2021 02:39:41 -0400
Received: from dggeme754-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HYPCL2QN0z8tm8;
        Tue, 19 Oct 2021 14:36:14 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme754-chm.china.huawei.com
 (10.3.19.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.15; Tue, 19
 Oct 2021 14:37:26 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <jack@suse.cz>,
        Ye Bin <yebin10@huawei.com>
Subject: [PATCH -next v3 4/5] ext4: simplify read_mmp_block fucntion
Date:   Tue, 19 Oct 2021 14:49:58 +0800
Message-ID: <20211019064959.625557-5-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211019064959.625557-1-yebin10@huawei.com>
References: <20211019064959.625557-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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
---
 fs/ext4/mmp.c | 40 +++++++++++++++-------------------------
 1 file changed, 15 insertions(+), 25 deletions(-)

diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
index 6ac6aacd8fa5..61c765c249b9 100644
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
 
@@ -199,7 +189,7 @@ static int kmmpd(void *data)
 			struct buffer_head *bh_check = NULL;
 			struct mmp_struct *mmp_check;
 
-			retval = read_mmp_block(sb, &bh_check, mmp_block);
+			retval = read_mmp_block(sb, bh_check);
 			if (retval) {
 				ext4_error_err(sb, -retval,
 					       "error reading MMP data: %d",
@@ -299,7 +289,7 @@ int ext4_multi_mount_protect(struct super_block *sb,
 	if (bh)
 		goto failed;
 
-	retval = read_mmp_block(sb, &bh, mmp_block);
+	retval = read_mmp_block(sb, bh);
 	if (retval)
 		goto failed;
 
@@ -337,7 +327,7 @@ int ext4_multi_mount_protect(struct super_block *sb,
 		goto failed;
 	}
 
-	retval = read_mmp_block(sb, &bh, mmp_block);
+	retval = read_mmp_block(sb, bh);
 	if (retval)
 		goto failed;
 	mmp = (struct mmp_struct *)(bh->b_data);
@@ -366,7 +356,7 @@ int ext4_multi_mount_protect(struct super_block *sb,
 		goto failed;
 	}
 
-	retval = read_mmp_block(sb, &bh, mmp_block);
+	retval = read_mmp_block(sb, bh);
 	if (retval)
 		goto failed;
 	mmp = (struct mmp_struct *)(bh->b_data);
-- 
2.31.1

