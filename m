Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3934335E8
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Oct 2021 14:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhJSM3N (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 Oct 2021 08:29:13 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:25168 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbhJSM3M (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 19 Oct 2021 08:29:12 -0400
Received: from dggeme754-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HYXy05gZHz1DH8W;
        Tue, 19 Oct 2021 20:25:12 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme754-chm.china.huawei.com
 (10.3.19.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.15; Tue, 19
 Oct 2021 20:26:57 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <jack@suse.cz>,
        Ye Bin <yebin10@huawei.com>
Subject: [PATCH -next v4 2/3] ext4: remove useless bh_check variable
Date:   Tue, 19 Oct 2021 20:39:30 +0800
Message-ID: <20211019123931.1545295-3-yebin10@huawei.com>
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

Since we initialize 'bh_check' to NULL and pass it to read_mmp_block(), that
function will just call sb_getblk() which will just return the buffer_head
we have in 'bh'. So just remove the pointless 'bh_check' variable and use
'bh' directly.

Signed-off-by: Ye Bin <yebin10@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/mmp.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
index 97d5a8136eb2..9788c617e593 100644
--- a/fs/ext4/mmp.c
+++ b/fs/ext4/mmp.c
@@ -195,10 +195,7 @@ static int kmmpd(void *data)
 		 */
 		diff = jiffies - last_update_time;
 		if (diff > mmp_check_interval * HZ) {
-			struct buffer_head *bh_check = NULL;
-			struct mmp_struct *mmp_check;
-
-			retval = read_mmp_block(sb, &bh_check, mmp_block);
+			retval = read_mmp_block(sb, &bh, mmp_block);
 			if (retval) {
 				ext4_error_err(sb, -retval,
 					       "error reading MMP data: %d",
@@ -206,20 +203,18 @@ static int kmmpd(void *data)
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

