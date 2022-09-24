Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3615E8941
	for <lists+linux-ext4@lfdr.de>; Sat, 24 Sep 2022 09:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbiIXHl6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 24 Sep 2022 03:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbiIXHl4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 24 Sep 2022 03:41:56 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBBA11DFFC;
        Sat, 24 Sep 2022 00:41:52 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MZLTH5B0rzlXPL;
        Sat, 24 Sep 2022 15:37:39 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 24 Sep
 2022 15:41:50 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <jack@suse.cz>,
        Ye Bin <yebin10@huawei.com>
Subject: [PATCH -next 2/3] ext4: factor out ext4_fc_get_tl()
Date:   Sat, 24 Sep 2022 15:52:32 +0800
Message-ID: <20220924075233.2315259-3-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220924075233.2315259-1-yebin10@huawei.com>
References: <20220924075233.2315259-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Factor out ext4_fc_get_tl() to fill 'tl' with host byte order.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/fast_commit.c | 46 +++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index a65772c22f6d..54622005a0c8 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1338,7 +1338,7 @@ struct dentry_info_args {
 };
 
 static inline void tl_to_darg(struct dentry_info_args *darg,
-			      struct  ext4_fc_tl *tl, u8 *val)
+			      struct ext4_fc_tl *tl, u8 *val)
 {
 	struct ext4_fc_dentry_info fcd;
 
@@ -1347,8 +1347,14 @@ static inline void tl_to_darg(struct dentry_info_args *darg,
 	darg->parent_ino = le32_to_cpu(fcd.fc_parent_ino);
 	darg->ino = le32_to_cpu(fcd.fc_ino);
 	darg->dname = val + offsetof(struct ext4_fc_dentry_info, fc_dname);
-	darg->dname_len = le16_to_cpu(tl->fc_len) -
-		sizeof(struct ext4_fc_dentry_info);
+	darg->dname_len = tl->fc_len - sizeof(struct ext4_fc_dentry_info);
+}
+
+static inline void ext4_fc_get_tl(struct ext4_fc_tl *tl, u8 *val)
+{
+	memcpy(tl, val, EXT4_FC_TAG_BASE_LEN);
+	tl->fc_len = le16_to_cpu(tl->fc_len);
+	tl->fc_tag = le16_to_cpu(tl->fc_tag);
 }
 
 /* Unlink replay function */
@@ -1513,7 +1519,7 @@ static int ext4_fc_replay_inode(struct super_block *sb, struct ext4_fc_tl *tl,
 	struct ext4_inode *raw_fc_inode;
 	struct inode *inode = NULL;
 	struct ext4_iloc iloc;
-	int inode_len, ino, ret, tag = le16_to_cpu(tl->fc_tag);
+	int inode_len, ino, ret, tag = tl->fc_tag;
 	struct ext4_extent_header *eh;
 
 	memcpy(&fc_inode, val, sizeof(fc_inode));
@@ -1538,7 +1544,7 @@ static int ext4_fc_replay_inode(struct super_block *sb, struct ext4_fc_tl *tl,
 	if (ret)
 		goto out;
 
-	inode_len = le16_to_cpu(tl->fc_len) - sizeof(struct ext4_fc_inode);
+	inode_len = tl->fc_len - sizeof(struct ext4_fc_inode);
 	raw_inode = ext4_raw_inode(&iloc);
 
 	memcpy(raw_inode, raw_fc_inode, offsetof(struct ext4_inode, i_block));
@@ -2027,12 +2033,12 @@ static int ext4_fc_replay_scan(journal_t *journal,
 
 	state->fc_replay_expected_off++;
 	for (cur = start; cur < end;
-	     cur = cur + EXT4_FC_TAG_BASE_LEN + le16_to_cpu(tl.fc_len)) {
-		memcpy(&tl, cur, EXT4_FC_TAG_BASE_LEN);
+	     cur = cur + EXT4_FC_TAG_BASE_LEN + tl.fc_len) {
+		ext4_fc_get_tl(&tl, cur);
 		val = cur + EXT4_FC_TAG_BASE_LEN;
 		ext4_debug("Scan phase, tag:%s, blk %lld\n",
-			  tag2str(le16_to_cpu(tl.fc_tag)), bh->b_blocknr);
-		switch (le16_to_cpu(tl.fc_tag)) {
+			   tag2str(tl.fc_tag), bh->b_blocknr);
+		switch (tl.fc_tag) {
 		case EXT4_FC_TAG_ADD_RANGE:
 			memcpy(&ext, val, sizeof(ext));
 			ex = (struct ext4_extent *)&ext.fc_ex;
@@ -2052,7 +2058,7 @@ static int ext4_fc_replay_scan(journal_t *journal,
 		case EXT4_FC_TAG_PAD:
 			state->fc_cur_tag++;
 			state->fc_crc = ext4_chksum(sbi, state->fc_crc, cur,
-				EXT4_FC_TAG_BASE_LEN + le16_to_cpu(tl.fc_len));
+				EXT4_FC_TAG_BASE_LEN + tl.fc_len);
 			break;
 		case EXT4_FC_TAG_TAIL:
 			state->fc_cur_tag++;
@@ -2085,7 +2091,7 @@ static int ext4_fc_replay_scan(journal_t *journal,
 			}
 			state->fc_cur_tag++;
 			state->fc_crc = ext4_chksum(sbi, state->fc_crc, cur,
-				EXT4_FC_TAG_BASE_LEN + le16_to_cpu(tl.fc_len));
+				EXT4_FC_TAG_BASE_LEN + tl.fc_len);
 			break;
 		default:
 			ret = state->fc_replay_num_tags ?
@@ -2141,8 +2147,8 @@ static int ext4_fc_replay(journal_t *journal, struct buffer_head *bh,
 	end = (__u8 *)bh->b_data + journal->j_blocksize - 1;
 
 	for (cur = start; cur < end;
-	     cur = cur + EXT4_FC_TAG_BASE_LEN + le16_to_cpu(tl.fc_len)) {
-		memcpy(&tl, cur, EXT4_FC_TAG_BASE_LEN);
+	     cur = cur + EXT4_FC_TAG_BASE_LEN + tl.fc_len) {
+		ext4_fc_get_tl(&tl, cur);
 		val = cur + EXT4_FC_TAG_BASE_LEN;
 
 		if (state->fc_replay_num_tags == 0) {
@@ -2150,10 +2156,9 @@ static int ext4_fc_replay(journal_t *journal, struct buffer_head *bh,
 			ext4_fc_set_bitmaps_and_counters(sb);
 			break;
 		}
-		ext4_debug("Replay phase, tag:%s\n",
-				tag2str(le16_to_cpu(tl.fc_tag)));
+		ext4_debug("Replay phase, tag:%s\n", tag2str(tl.fc_tag));
 		state->fc_replay_num_tags--;
-		switch (le16_to_cpu(tl.fc_tag)) {
+		switch (tl.fc_tag) {
 		case EXT4_FC_TAG_LINK:
 			ret = ext4_fc_replay_link(sb, &tl, val);
 			break;
@@ -2174,19 +2179,18 @@ static int ext4_fc_replay(journal_t *journal, struct buffer_head *bh,
 			break;
 		case EXT4_FC_TAG_PAD:
 			trace_ext4_fc_replay(sb, EXT4_FC_TAG_PAD, 0,
-					     le16_to_cpu(tl.fc_len), 0);
+					     tl.fc_len, 0);
 			break;
 		case EXT4_FC_TAG_TAIL:
-			trace_ext4_fc_replay(sb, EXT4_FC_TAG_TAIL, 0,
-					     le16_to_cpu(tl.fc_len), 0);
+			trace_ext4_fc_replay(sb, EXT4_FC_TAG_TAIL,
+					     0, tl.fc_len, 0);
 			memcpy(&tail, val, sizeof(tail));
 			WARN_ON(le32_to_cpu(tail.fc_tid) != expected_tid);
 			break;
 		case EXT4_FC_TAG_HEAD:
 			break;
 		default:
-			trace_ext4_fc_replay(sb, le16_to_cpu(tl.fc_tag), 0,
-					     le16_to_cpu(tl.fc_len), 0);
+			trace_ext4_fc_replay(sb, tl.fc_tag, 0, tl.fc_len, 0);
 			ret = -ECANCELED;
 			break;
 		}
-- 
2.31.1

