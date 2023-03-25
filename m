Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023456C8BE0
	for <lists+linux-ext4@lfdr.de>; Sat, 25 Mar 2023 07:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjCYGsk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 25 Mar 2023 02:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbjCYGsg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 25 Mar 2023 02:48:36 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE35D93EF;
        Fri, 24 Mar 2023 23:48:34 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Pk8hy12FcznY4n;
        Sat, 25 Mar 2023 14:45:22 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Sat, 25 Mar
 2023 14:48:32 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
        <yukuai3@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH 2/2] ext4: refactoring to use the unified helper ext4_quotas_off()
Date:   Sat, 25 Mar 2023 14:47:32 +0800
Message-ID: <20230325064732.1897482-3-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230325064732.1897482-1-libaokun1@huawei.com>
References: <20230325064732.1897482-1-libaokun1@huawei.com>
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
 fs/ext4/super.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 94c37da41b64..ce77216e336c 100644
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
@@ -5540,7 +5540,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	return 0;
 
 failed_mount10:
-	ext4_quota_off_umount(sb);
+	ext4_quotas_off(sb, EXT4_MAXQUOTAS);
 failed_mount9:
 	ext4_release_orphan_info(sb);
 failed_mount8:
@@ -7012,20 +7012,8 @@ int ext4_enable_quotas(struct super_block *sb)
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

