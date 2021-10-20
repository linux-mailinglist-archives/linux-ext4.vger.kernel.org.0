Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFC464343AE
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Oct 2021 05:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbhJTDHr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 Oct 2021 23:07:47 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:14832 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbhJTDHp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 19 Oct 2021 23:07:45 -0400
Received: from dggeme754-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HYwN20g05z905l;
        Wed, 20 Oct 2021 11:00:34 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme754-chm.china.huawei.com
 (10.3.19.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.15; Wed, 20
 Oct 2021 11:05:29 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <jack@suse.cz>,
        Ye Bin <yebin10@huawei.com>
Subject: [PATCH -next v5 3/3] ext4: simplify read_mmp_block fucntion
Date:   Wed, 20 Oct 2021 11:18:02 +0800
Message-ID: <20211020031802.2312022-4-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211020031802.2312022-1-yebin10@huawei.com>
References: <20211020031802.2312022-1-yebin10@huawei.com>
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
 fs/ext4/mmp.c | 46 +++++++++++++++++++---------------------------
 1 file changed, 19 insertions(+), 27 deletions(-)

diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
index 9788c617e593..d46239a0e36b 100644
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
 
@@ -131,7 +121,6 @@ static int kmmpd(void *data)
 	struct ext4_super_block *es = EXT4_SB(sb)->s_es;
 	struct buffer_head *bh = EXT4_SB(sb)->s_mmp_bh;
 	struct mmp_struct *mmp;
-	ext4_fsblk_t mmp_block;
 	u32 seq = 0;
 	unsigned long failed_writes = 0;
 	int mmp_update_interval = le16_to_cpu(es->s_mmp_update_interval);
@@ -141,7 +130,6 @@ static int kmmpd(void *data)
 	char nodename[EXT4_MMP_NODENAME_LEN];
 	int retval = 0;
 
-	mmp_block = le64_to_cpu(es->s_mmp_block);
 	mmp = (struct mmp_struct *)(bh->b_data);
 	mmp->mmp_time = cpu_to_le64(ktime_get_real_seconds());
 	/*
@@ -195,7 +183,7 @@ static int kmmpd(void *data)
 		 */
 		diff = jiffies - last_update_time;
 		if (diff > mmp_check_interval * HZ) {
-			retval = read_mmp_block(sb, &bh, mmp_block);
+			retval = read_mmp_block(sb, bh);
 			if (retval) {
 				ext4_error_err(sb, -retval,
 					       "error reading MMP data: %d",
@@ -289,7 +277,11 @@ int ext4_multi_mount_protect(struct super_block *sb,
 		goto failed;
 	}
 
-	retval = read_mmp_block(sb, &bh, mmp_block);
+	bh = sb_getblk(sb, mmp_block);
+	if (!bh)
+		goto failed;
+
+	retval = read_mmp_block(sb, bh);
 	if (retval)
 		goto failed;
 
@@ -327,7 +319,7 @@ int ext4_multi_mount_protect(struct super_block *sb,
 		goto failed;
 	}
 
-	retval = read_mmp_block(sb, &bh, mmp_block);
+	retval = read_mmp_block(sb, bh);
 	if (retval)
 		goto failed;
 	mmp = (struct mmp_struct *)(bh->b_data);
@@ -356,7 +348,7 @@ int ext4_multi_mount_protect(struct super_block *sb,
 		goto failed;
 	}
 
-	retval = read_mmp_block(sb, &bh, mmp_block);
+	retval = read_mmp_block(sb, bh);
 	if (retval)
 		goto failed;
 	mmp = (struct mmp_struct *)(bh->b_data);
-- 
2.31.1

