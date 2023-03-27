Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F476C9995
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Mar 2023 04:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbjC0C1Z (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 26 Mar 2023 22:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbjC0C1W (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 26 Mar 2023 22:27:22 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23B346B0;
        Sun, 26 Mar 2023 19:27:21 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PlGpZ466Dznjwb;
        Mon, 27 Mar 2023 10:24:06 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Mon, 27 Mar
 2023 10:27:19 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
        <yukuai3@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH v2 2/2] ext4: refactoring to use the unified helper ext4_quotas_off()
Date:   Mon, 27 Mar 2023 10:27:03 +0800
Message-ID: <20230327022703.576857-3-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230327022703.576857-1-libaokun1@huawei.com>
References: <20230327022703.576857-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Rename ext4_quota_off_umount() to ext4_quotas_off(), and add type
parameter to replace open code in ext4_enable_quotas().

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
V1->V2:
	Adapting to the changes in PATCH 1/2.

 fs/ext4/super.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index bd1ca1c3022e..59c5dd4dbe5a 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1157,12 +1157,12 @@ static void dump_orphan_list(struct super_block *sb, struct ext4_sb_info *sbi)
 #ifdef CONFIG_QUOTA
 static int ext4_quota_off(struct super_block *sb, int type);
 
-static inline void ext4_quota_off_umount(struct super_block *sb)
+static inline void ext4_quotas_off(struct super_block *sb, int type)
 {
-	int type;
+	BUG_ON(type > EXT4_MAXQUOTAS);
 
 	/* Use our quota_off function to clear inode flags etc. */
-	for (type = 0; type < EXT4_MAXQUOTAS; type++)
+	for (type--; type >= 0; type--)
 		ext4_quota_off(sb, type);
 }
 
@@ -1178,7 +1178,7 @@ static inline char *get_qf_name(struct super_block *sb,
 					 lockdep_is_held(&sb->s_umount));
 }
 #else
-static inline void ext4_quota_off_umount(struct super_block *sb)
+static inline void ext4_quotas_off(struct super_block *sb, int type)
 {
 }
 #endif
@@ -1209,7 +1209,7 @@ static void ext4_put_super(struct super_block *sb)
 			 &sb->s_uuid);
 
 	ext4_unregister_li_request(sb);
-	ext4_quota_off_umount(sb);
+	ext4_quotas_off(sb, EXT4_MAXQUOTAS);
 
 	flush_work(&sbi->s_error_work);
 	destroy_workqueue(sbi->rsv_conversion_wq);
@@ -5541,7 +5541,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 
 failed_mount10:
 #ifdef CONFIG_QUOTA
-	ext4_quota_off_umount(sb);
+	ext4_quotas_off(sb, EXT4_MAXQUOTAS);
 failed_mount9:
 #endif  /* CONFIG_QUOTA */
 	ext4_release_orphan_info(sb);
@@ -7014,20 +7014,8 @@ int ext4_enable_quotas(struct super_block *sb)
 					"(type=%d, err=%d, ino=%lu). "
 					"Please run e2fsck to fix.", type,
 					err, qf_inums[type]);
-				for (type--; type >= 0; type--) {
-					struct inode *inode;
-
-					inode = sb_dqopt(sb)->files[type];
-					if (inode)
-						inode = igrab(inode);
-					dquot_quota_off(sb, type);
-					if (inode) {
-						lockdep_set_quota_inode(inode,
-							I_DATA_SEM_NORMAL);
-						iput(inode);
-					}
-				}
 
+				ext4_quotas_off(sb, type);
 				return err;
 			}
 		}
-- 
2.31.1

