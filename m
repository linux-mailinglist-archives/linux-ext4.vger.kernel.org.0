Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B460A432E6C
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Oct 2021 08:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234304AbhJSGjs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 Oct 2021 02:39:48 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:13954 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234178AbhJSGjl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 19 Oct 2021 02:39:41 -0400
Received: from dggeme754-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HYPBk4ZH1zZcNP;
        Tue, 19 Oct 2021 14:35:42 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme754-chm.china.huawei.com
 (10.3.19.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.15; Tue, 19
 Oct 2021 14:37:27 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <jack@suse.cz>,
        Ye Bin <yebin10@huawei.com>
Subject: [PATCH -next v3 5/5] ext4: avoid to re-read mmp check data get from page cache
Date:   Tue, 19 Oct 2021 14:49:59 +0800
Message-ID: <20211019064959.625557-6-yebin10@huawei.com>
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

As call read_mmp_block pass bh_check which value is NULL, then call
sb_getblk to get buffer_head. But mmp_block's buffer_head is already exist
 which also is uptodate. Lead to compare the same data.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/mmp.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
index 61c765c249b9..8018f6fb6ac2 100644
--- a/fs/ext4/mmp.c
+++ b/fs/ext4/mmp.c
@@ -186,10 +186,7 @@ static int kmmpd(void *data)
 		 */
 		diff = jiffies - last_update_time;
 		if (diff > mmp_check_interval * HZ) {
-			struct buffer_head *bh_check = NULL;
-			struct mmp_struct *mmp_check;
-
-			retval = read_mmp_block(sb, bh_check);
+			retval = read_mmp_block(sb, bh);
 			if (retval) {
 				ext4_error_err(sb, -retval,
 					       "error reading MMP data: %d",
@@ -197,20 +194,18 @@ static int kmmpd(void *data)
 				goto wait_to_exit;
 			}
 
-			mmp_check = (struct mmp_struct *)(bh_check->b_data);
-			if (seq != mmp_check->mmp_seq ||
-			    memcmp(nodename, mmp_check->mmp_nodename,
-				   sizeof(mmp->mmp_nodename))) {
-				dump_mmp_msg(sb, mmp_check,
+			mmp = (struct mmp_struct *)(bh->b_data);
+			if (seq != le32_to_cpu(mmp->mmp_seq) ||
+			    memcmp(nodename, mmp->mmp_nodename,
+				    sizeof(nodename))) {
+				dump_mmp_msg(sb, mmp,
 					     "Error while updating MMP info. "
 					     "The filesystem seems to have been"
 					     " multiply mounted.");
 				ext4_error_err(sb, EBUSY, "abort");
-				put_bh(bh_check);
 				retval = -EBUSY;
 				goto wait_to_exit;
 			}
-			put_bh(bh_check);
 		}
 
 		 /*
-- 
2.31.1

