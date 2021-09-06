Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA17B401D1E
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Sep 2021 16:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243565AbhIFOjC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 6 Sep 2021 10:39:02 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:15298 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243437AbhIFOi5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 6 Sep 2021 10:38:57 -0400
Received: from dggeme754-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4H39wL1BSbz8spw;
        Mon,  6 Sep 2021 22:37:22 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme754-chm.china.huawei.com
 (10.3.19.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Mon, 6 Sep
 2021 22:37:49 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <jack@suse.cz>,
        Ye Bin <yebin10@huawei.com>
Subject: [PATCH -next 1/6] ext4: init seq with random value in kmmpd
Date:   Mon, 6 Sep 2021 22:47:49 +0800
Message-ID: <20210906144754.2601607-2-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210906144754.2601607-1-yebin10@huawei.com>
References: <20210906144754.2601607-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme754-chm.china.huawei.com (10.3.19.100)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If two host has the same nodename, and seq start from 0, May cause the
detection mechanism to fail.
So init seq with random value to accelerate conflict detection.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/mmp.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
index cebea4270817..12af6dc8457b 100644
--- a/fs/ext4/mmp.c
+++ b/fs/ext4/mmp.c
@@ -122,6 +122,21 @@ void __dump_mmp_msg(struct super_block *sb, struct mmp_struct *mmp,
 		       (int)sizeof(mmp->mmp_bdevname), mmp->mmp_bdevname);
 }
 
+/*
+ * Get a random new sequence number but make sure it is not greater than
+ * EXT4_MMP_SEQ_MAX.
+ */
+static unsigned int mmp_new_seq(void)
+{
+	u32 new_seq;
+
+	do {
+		new_seq = prandom_u32();
+	} while (new_seq > EXT4_MMP_SEQ_MAX);
+
+	return new_seq;
+}
+
 /*
  * kmmpd will update the MMP sequence every s_mmp_update_interval seconds
  */
@@ -132,7 +147,7 @@ static int kmmpd(void *data)
 	struct buffer_head *bh = EXT4_SB(sb)->s_mmp_bh;
 	struct mmp_struct *mmp;
 	ext4_fsblk_t mmp_block;
-	u32 seq = 0;
+	u32 seq = mmp_new_seq();
 	unsigned long failed_writes = 0;
 	int mmp_update_interval = le16_to_cpu(es->s_mmp_update_interval);
 	unsigned mmp_check_interval;
@@ -258,21 +273,6 @@ void ext4_stop_mmpd(struct ext4_sb_info *sbi)
 	}
 }
 
-/*
- * Get a random new sequence number but make sure it is not greater than
- * EXT4_MMP_SEQ_MAX.
- */
-static unsigned int mmp_new_seq(void)
-{
-	u32 new_seq;
-
-	do {
-		new_seq = prandom_u32();
-	} while (new_seq > EXT4_MMP_SEQ_MAX);
-
-	return new_seq;
-}
-
 /*
  * Protect the filesystem from being mounted more than once.
  */
-- 
2.31.1

