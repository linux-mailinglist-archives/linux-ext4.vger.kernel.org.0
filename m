Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C13A64335E5
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Oct 2021 14:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235549AbhJSM3M (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 Oct 2021 08:29:12 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:13955 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbhJSM3M (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 19 Oct 2021 08:29:12 -0400
Received: from dggeme754-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HYXy01NhlzWBsr;
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
Subject: [PATCH -next v4 1/3] ext4: compare to local seq and nodename when check conflict
Date:   Tue, 19 Oct 2021 20:39:29 +0800
Message-ID: <20211019123931.1545295-2-yebin10@huawei.com>
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

As mmp and check_mmp is point to the same data, so there will never
detect conflict.
To solve this issue just compare to local data.

Signed-off-by: Ye Bin <yebin10@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ext4.h | 5 ++++-
 fs/ext4/mmp.c  | 9 +++++----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 404dd50856e5..9a487a558787 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2601,6 +2601,8 @@ struct ext4_features {
 #define EXT4_MMP_SEQ_FSCK  0xE24D4D50U /* mmp_seq value when being fscked */
 #define EXT4_MMP_SEQ_MAX   0xE24D4D4FU /* maximum valid mmp_seq value */
 
+#define EXT4_MMP_NODENAME_LEN   64 /* mmp_nodename length */
+
 struct mmp_struct {
 	__le32	mmp_magic;		/* Magic number for MMP */
 	__le32	mmp_seq;		/* Sequence no. updated periodically */
@@ -2610,7 +2612,8 @@ struct mmp_struct {
 	 * purposes and do not affect the correctness of the algorithm
 	 */
 	__le64	mmp_time;		/* Time last updated */
-	char	mmp_nodename[64];	/* Node which last updated MMP block */
+	/* Node which last updated MMP block */
+	char	mmp_nodename[EXT4_MMP_NODENAME_LEN];
 	char	mmp_bdevname[32];	/* Bdev which last updated MMP block */
 
 	/*
diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
index cebea4270817..97d5a8136eb2 100644
--- a/fs/ext4/mmp.c
+++ b/fs/ext4/mmp.c
@@ -138,6 +138,7 @@ static int kmmpd(void *data)
 	unsigned mmp_check_interval;
 	unsigned long last_update_time;
 	unsigned long diff;
+	char nodename[EXT4_MMP_NODENAME_LEN];
 	int retval = 0;
 
 	mmp_block = le64_to_cpu(es->s_mmp_block);
@@ -153,8 +154,8 @@ static int kmmpd(void *data)
 	BUILD_BUG_ON(sizeof(mmp->mmp_bdevname) < BDEVNAME_SIZE);
 	bdevname(bh->b_bdev, mmp->mmp_bdevname);
 
-	memcpy(mmp->mmp_nodename, init_utsname()->nodename,
-	       sizeof(mmp->mmp_nodename));
+	memcpy(nodename, init_utsname()->nodename, sizeof(nodename));
+	memcpy(mmp->mmp_nodename, nodename, sizeof(mmp->mmp_nodename));
 
 	while (!kthread_should_stop() && !sb_rdonly(sb)) {
 		if (!ext4_has_feature_mmp(sb)) {
@@ -206,8 +207,8 @@ static int kmmpd(void *data)
 			}
 
 			mmp_check = (struct mmp_struct *)(bh_check->b_data);
-			if (mmp->mmp_seq != mmp_check->mmp_seq ||
-			    memcmp(mmp->mmp_nodename, mmp_check->mmp_nodename,
+			if (seq != mmp_check->mmp_seq ||
+			    memcmp(nodename, mmp_check->mmp_nodename,
 				   sizeof(mmp->mmp_nodename))) {
 				dump_mmp_msg(sb, mmp_check,
 					     "Error while updating MMP info. "
-- 
2.31.1

