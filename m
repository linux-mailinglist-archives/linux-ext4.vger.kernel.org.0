Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE78F5A627A
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Aug 2022 13:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbiH3LxO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 30 Aug 2022 07:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiH3LxH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 30 Aug 2022 07:53:07 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6227EA2216
        for <linux-ext4@vger.kernel.org>; Tue, 30 Aug 2022 04:53:05 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MH5HT2PKJzHnYb;
        Tue, 30 Aug 2022 19:51:17 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500004.china.huawei.com
 (7.192.104.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 30 Aug
 2022 19:53:03 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <lczerner@redhat.com>,
        <linux-ext4@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH 06/13] ext4: factor out ext4_inode_info_init()
Date:   Tue, 30 Aug 2022 20:04:04 +0800
Message-ID: <20220830120411.2371968-7-yanaijie@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220830120411.2371968-1-yanaijie@huawei.com>
References: <20220830120411.2371968-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500004.china.huawei.com (7.192.104.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Factor out ext4_inode_info_init(). No functional change.

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 fs/ext4/super.c | 137 ++++++++++++++++++++++++++----------------------
 1 file changed, 75 insertions(+), 62 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index d355eda2f184..458d146149b2 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4448,6 +4448,79 @@ static void ext4_fast_commit_init(struct super_block *sb)
 	sbi->s_fc_replay_state.fc_modified_inodes_used = 0;
 }
 
+static int ext4_inode_info_init(struct super_block *sb,
+				struct ext4_super_block *es,
+				int blocksize)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+
+	if (le32_to_cpu(es->s_rev_level) == EXT4_GOOD_OLD_REV) {
+		sbi->s_inode_size = EXT4_GOOD_OLD_INODE_SIZE;
+		sbi->s_first_ino = EXT4_GOOD_OLD_FIRST_INO;
+	} else {
+		sbi->s_inode_size = le16_to_cpu(es->s_inode_size);
+		sbi->s_first_ino = le32_to_cpu(es->s_first_ino);
+		if (sbi->s_first_ino < EXT4_GOOD_OLD_FIRST_INO) {
+			ext4_msg(sb, KERN_ERR, "invalid first ino: %u",
+				 sbi->s_first_ino);
+			return -EINVAL;
+		}
+		if ((sbi->s_inode_size < EXT4_GOOD_OLD_INODE_SIZE) ||
+		    (!is_power_of_2(sbi->s_inode_size)) ||
+		    (sbi->s_inode_size > blocksize)) {
+			ext4_msg(sb, KERN_ERR,
+			       "unsupported inode size: %d",
+			       sbi->s_inode_size);
+			ext4_msg(sb, KERN_ERR, "blocksize: %d", blocksize);
+			return -EINVAL;
+		}
+		/*
+		 * i_atime_extra is the last extra field available for
+		 * [acm]times in struct ext4_inode. Checking for that
+		 * field should suffice to ensure we have extra space
+		 * for all three.
+		 */
+		if (sbi->s_inode_size >= offsetof(struct ext4_inode, i_atime_extra) +
+			sizeof(((struct ext4_inode *)0)->i_atime_extra)) {
+			sb->s_time_gran = 1;
+			sb->s_time_max = EXT4_EXTRA_TIMESTAMP_MAX;
+		} else {
+			sb->s_time_gran = NSEC_PER_SEC;
+			sb->s_time_max = EXT4_NON_EXTRA_TIMESTAMP_MAX;
+		}
+		sb->s_time_min = EXT4_TIMESTAMP_MIN;
+	}
+
+	if (sbi->s_inode_size > EXT4_GOOD_OLD_INODE_SIZE) {
+		sbi->s_want_extra_isize = sizeof(struct ext4_inode) -
+			EXT4_GOOD_OLD_INODE_SIZE;
+		if (ext4_has_feature_extra_isize(sb)) {
+			unsigned v, max = (sbi->s_inode_size -
+					   EXT4_GOOD_OLD_INODE_SIZE);
+
+			v = le16_to_cpu(es->s_want_extra_isize);
+			if (v > max) {
+				ext4_msg(sb, KERN_ERR,
+					 "bad s_want_extra_isize: %d", v);
+				return -EINVAL;
+			}
+			if (sbi->s_want_extra_isize < v)
+				sbi->s_want_extra_isize = v;
+
+			v = le16_to_cpu(es->s_min_extra_isize);
+			if (v > max) {
+				ext4_msg(sb, KERN_ERR,
+					 "bad s_min_extra_isize: %d", v);
+				return -EINVAL;
+			}
+			if (sbi->s_want_extra_isize < v)
+				sbi->s_want_extra_isize = v;
+		}
+	}
+
+	return 0;
+}
+
 static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 {
 	struct buffer_head *bh, **group_desc;
@@ -4590,68 +4663,8 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	if (blocksize == PAGE_SIZE)
 		set_opt(sb, DIOREAD_NOLOCK);
 
-	if (le32_to_cpu(es->s_rev_level) == EXT4_GOOD_OLD_REV) {
-		sbi->s_inode_size = EXT4_GOOD_OLD_INODE_SIZE;
-		sbi->s_first_ino = EXT4_GOOD_OLD_FIRST_INO;
-	} else {
-		sbi->s_inode_size = le16_to_cpu(es->s_inode_size);
-		sbi->s_first_ino = le32_to_cpu(es->s_first_ino);
-		if (sbi->s_first_ino < EXT4_GOOD_OLD_FIRST_INO) {
-			ext4_msg(sb, KERN_ERR, "invalid first ino: %u",
-				 sbi->s_first_ino);
-			goto failed_mount;
-		}
-		if ((sbi->s_inode_size < EXT4_GOOD_OLD_INODE_SIZE) ||
-		    (!is_power_of_2(sbi->s_inode_size)) ||
-		    (sbi->s_inode_size > blocksize)) {
-			ext4_msg(sb, KERN_ERR,
-			       "unsupported inode size: %d",
-			       sbi->s_inode_size);
-			ext4_msg(sb, KERN_ERR, "blocksize: %d", blocksize);
-			goto failed_mount;
-		}
-		/*
-		 * i_atime_extra is the last extra field available for
-		 * [acm]times in struct ext4_inode. Checking for that
-		 * field should suffice to ensure we have extra space
-		 * for all three.
-		 */
-		if (sbi->s_inode_size >= offsetof(struct ext4_inode, i_atime_extra) +
-			sizeof(((struct ext4_inode *)0)->i_atime_extra)) {
-			sb->s_time_gran = 1;
-			sb->s_time_max = EXT4_EXTRA_TIMESTAMP_MAX;
-		} else {
-			sb->s_time_gran = NSEC_PER_SEC;
-			sb->s_time_max = EXT4_NON_EXTRA_TIMESTAMP_MAX;
-		}
-		sb->s_time_min = EXT4_TIMESTAMP_MIN;
-	}
-	if (sbi->s_inode_size > EXT4_GOOD_OLD_INODE_SIZE) {
-		sbi->s_want_extra_isize = sizeof(struct ext4_inode) -
-			EXT4_GOOD_OLD_INODE_SIZE;
-		if (ext4_has_feature_extra_isize(sb)) {
-			unsigned v, max = (sbi->s_inode_size -
-					   EXT4_GOOD_OLD_INODE_SIZE);
-
-			v = le16_to_cpu(es->s_want_extra_isize);
-			if (v > max) {
-				ext4_msg(sb, KERN_ERR,
-					 "bad s_want_extra_isize: %d", v);
-				goto failed_mount;
-			}
-			if (sbi->s_want_extra_isize < v)
-				sbi->s_want_extra_isize = v;
-
-			v = le16_to_cpu(es->s_min_extra_isize);
-			if (v > max) {
-				ext4_msg(sb, KERN_ERR,
-					 "bad s_min_extra_isize: %d", v);
-				goto failed_mount;
-			}
-			if (sbi->s_want_extra_isize < v)
-				sbi->s_want_extra_isize = v;
-		}
-	}
+	if (ext4_inode_info_init(sb, es, blocksize))
+		goto failed_mount;
 
 	err = parse_apply_sb_mount_options(sb, ctx);
 	if (err < 0)
-- 
2.31.1

