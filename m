Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7435E8940
	for <lists+linux-ext4@lfdr.de>; Sat, 24 Sep 2022 09:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233536AbiIXHlz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 24 Sep 2022 03:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233559AbiIXHly (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 24 Sep 2022 03:41:54 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53491181F0;
        Sat, 24 Sep 2022 00:41:51 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MZLTH2609zlXK8;
        Sat, 24 Sep 2022 15:37:39 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 24 Sep
 2022 15:41:49 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <jack@suse.cz>,
        Ye Bin <yebin10@huawei.com>
Subject: [PATCH -next 1/3] ext4: introduce EXT4_FC_TAG_BASE_LEN helper
Date:   Sat, 24 Sep 2022 15:52:31 +0800
Message-ID: <20220924075233.2315259-2-yebin10@huawei.com>
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

Introduce EXT4_FC_TAG_BASE_LEN helper for calculate length of
struct ext4_fc_tl.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/fast_commit.c | 54 ++++++++++++++++++++++---------------------
 fs/ext4/fast_commit.h |  3 +++
 2 files changed, 31 insertions(+), 26 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 54ccc61c713a..a65772c22f6d 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -702,10 +702,10 @@ static u8 *ext4_fc_reserve_space(struct super_block *sb, int len, u32 *crc)
 	 * After allocating len, we should have space at least for a 0 byte
 	 * padding.
 	 */
-	if (len + sizeof(struct ext4_fc_tl) > bsize)
+	if (len + EXT4_FC_TAG_BASE_LEN > bsize)
 		return NULL;
 
-	if (bsize - off - 1 > len + sizeof(struct ext4_fc_tl)) {
+	if (bsize - off - 1 > len + EXT4_FC_TAG_BASE_LEN) {
 		/*
 		 * Only allocate from current buffer if we have enough space for
 		 * this request AND we have space to add a zero byte padding.
@@ -722,10 +722,10 @@ static u8 *ext4_fc_reserve_space(struct super_block *sb, int len, u32 *crc)
 	/* Need to add PAD tag */
 	tl = (struct ext4_fc_tl *)(sbi->s_fc_bh->b_data + off);
 	tl->fc_tag = cpu_to_le16(EXT4_FC_TAG_PAD);
-	pad_len = bsize - off - 1 - sizeof(struct ext4_fc_tl);
+	pad_len = bsize - off - 1 - EXT4_FC_TAG_BASE_LEN;
 	tl->fc_len = cpu_to_le16(pad_len);
 	if (crc)
-		*crc = ext4_chksum(sbi, *crc, tl, sizeof(*tl));
+		*crc = ext4_chksum(sbi, *crc, tl, EXT4_FC_TAG_BASE_LEN);
 	if (pad_len > 0)
 		ext4_fc_memzero(sb, tl + 1, pad_len, crc);
 	ext4_fc_submit_bh(sb, false);
@@ -767,7 +767,7 @@ static int ext4_fc_write_tail(struct super_block *sb, u32 crc)
 	 * ext4_fc_reserve_space takes care of allocating an extra block if
 	 * there's no enough space on this block for accommodating this tail.
 	 */
-	dst = ext4_fc_reserve_space(sb, sizeof(tl) + sizeof(tail), &crc);
+	dst = ext4_fc_reserve_space(sb, EXT4_FC_TAG_BASE_LEN + sizeof(tail), &crc);
 	if (!dst)
 		return -ENOSPC;
 
@@ -777,8 +777,8 @@ static int ext4_fc_write_tail(struct super_block *sb, u32 crc)
 	tl.fc_len = cpu_to_le16(bsize - off - 1 + sizeof(struct ext4_fc_tail));
 	sbi->s_fc_bytes = round_up(sbi->s_fc_bytes, bsize);
 
-	ext4_fc_memcpy(sb, dst, &tl, sizeof(tl), &crc);
-	dst += sizeof(tl);
+	ext4_fc_memcpy(sb, dst, &tl, EXT4_FC_TAG_BASE_LEN, &crc);
+	dst += EXT4_FC_TAG_BASE_LEN;
 	tail.fc_tid = cpu_to_le32(sbi->s_journal->j_running_transaction->t_tid);
 	ext4_fc_memcpy(sb, dst, &tail.fc_tid, sizeof(tail.fc_tid), &crc);
 	dst += sizeof(tail.fc_tid);
@@ -800,15 +800,15 @@ static bool ext4_fc_add_tlv(struct super_block *sb, u16 tag, u16 len, u8 *val,
 	struct ext4_fc_tl tl;
 	u8 *dst;
 
-	dst = ext4_fc_reserve_space(sb, sizeof(tl) + len, crc);
+	dst = ext4_fc_reserve_space(sb, EXT4_FC_TAG_BASE_LEN + len, crc);
 	if (!dst)
 		return false;
 
 	tl.fc_tag = cpu_to_le16(tag);
 	tl.fc_len = cpu_to_le16(len);
 
-	ext4_fc_memcpy(sb, dst, &tl, sizeof(tl), crc);
-	ext4_fc_memcpy(sb, dst + sizeof(tl), val, len, crc);
+	ext4_fc_memcpy(sb, dst, &tl, EXT4_FC_TAG_BASE_LEN, crc);
+	ext4_fc_memcpy(sb, dst + EXT4_FC_TAG_BASE_LEN, val, len, crc);
 
 	return true;
 }
@@ -820,8 +820,8 @@ static bool ext4_fc_add_dentry_tlv(struct super_block *sb, u32 *crc,
 	struct ext4_fc_dentry_info fcd;
 	struct ext4_fc_tl tl;
 	int dlen = fc_dentry->fcd_name.len;
-	u8 *dst = ext4_fc_reserve_space(sb, sizeof(tl) + sizeof(fcd) + dlen,
-					crc);
+	u8 *dst = ext4_fc_reserve_space(sb,
+			EXT4_FC_TAG_BASE_LEN + sizeof(fcd) + dlen, crc);
 
 	if (!dst)
 		return false;
@@ -830,8 +830,8 @@ static bool ext4_fc_add_dentry_tlv(struct super_block *sb, u32 *crc,
 	fcd.fc_ino = cpu_to_le32(fc_dentry->fcd_ino);
 	tl.fc_tag = cpu_to_le16(fc_dentry->fcd_op);
 	tl.fc_len = cpu_to_le16(sizeof(fcd) + dlen);
-	ext4_fc_memcpy(sb, dst, &tl, sizeof(tl), crc);
-	dst += sizeof(tl);
+	ext4_fc_memcpy(sb, dst, &tl, EXT4_FC_TAG_BASE_LEN, crc);
+	dst += EXT4_FC_TAG_BASE_LEN;
 	ext4_fc_memcpy(sb, dst, &fcd, sizeof(fcd), crc);
 	dst += sizeof(fcd);
 	ext4_fc_memcpy(sb, dst, fc_dentry->fcd_name.name, dlen, crc);
@@ -868,13 +868,13 @@ static int ext4_fc_write_inode(struct inode *inode, u32 *crc)
 
 	ret = -ECANCELED;
 	dst = ext4_fc_reserve_space(inode->i_sb,
-			sizeof(tl) + inode_len + sizeof(fc_inode.fc_ino), crc);
+		EXT4_FC_TAG_BASE_LEN + inode_len + sizeof(fc_inode.fc_ino), crc);
 	if (!dst)
 		goto err;
 
-	if (!ext4_fc_memcpy(inode->i_sb, dst, &tl, sizeof(tl), crc))
+	if (!ext4_fc_memcpy(inode->i_sb, dst, &tl, EXT4_FC_TAG_BASE_LEN, crc))
 		goto err;
-	dst += sizeof(tl);
+	dst += EXT4_FC_TAG_BASE_LEN;
 	if (!ext4_fc_memcpy(inode->i_sb, dst, &fc_inode, sizeof(fc_inode), crc))
 		goto err;
 	dst += sizeof(fc_inode);
@@ -2026,9 +2026,10 @@ static int ext4_fc_replay_scan(journal_t *journal,
 	}
 
 	state->fc_replay_expected_off++;
-	for (cur = start; cur < end; cur = cur + sizeof(tl) + le16_to_cpu(tl.fc_len)) {
-		memcpy(&tl, cur, sizeof(tl));
-		val = cur + sizeof(tl);
+	for (cur = start; cur < end;
+	     cur = cur + EXT4_FC_TAG_BASE_LEN + le16_to_cpu(tl.fc_len)) {
+		memcpy(&tl, cur, EXT4_FC_TAG_BASE_LEN);
+		val = cur + EXT4_FC_TAG_BASE_LEN;
 		ext4_debug("Scan phase, tag:%s, blk %lld\n",
 			  tag2str(le16_to_cpu(tl.fc_tag)), bh->b_blocknr);
 		switch (le16_to_cpu(tl.fc_tag)) {
@@ -2051,13 +2052,13 @@ static int ext4_fc_replay_scan(journal_t *journal,
 		case EXT4_FC_TAG_PAD:
 			state->fc_cur_tag++;
 			state->fc_crc = ext4_chksum(sbi, state->fc_crc, cur,
-					sizeof(tl) + le16_to_cpu(tl.fc_len));
+				EXT4_FC_TAG_BASE_LEN + le16_to_cpu(tl.fc_len));
 			break;
 		case EXT4_FC_TAG_TAIL:
 			state->fc_cur_tag++;
 			memcpy(&tail, val, sizeof(tail));
 			state->fc_crc = ext4_chksum(sbi, state->fc_crc, cur,
-						sizeof(tl) +
+						EXT4_FC_TAG_BASE_LEN +
 						offsetof(struct ext4_fc_tail,
 						fc_crc));
 			if (le32_to_cpu(tail.fc_tid) == expected_tid &&
@@ -2084,7 +2085,7 @@ static int ext4_fc_replay_scan(journal_t *journal,
 			}
 			state->fc_cur_tag++;
 			state->fc_crc = ext4_chksum(sbi, state->fc_crc, cur,
-					    sizeof(tl) + le16_to_cpu(tl.fc_len));
+				EXT4_FC_TAG_BASE_LEN + le16_to_cpu(tl.fc_len));
 			break;
 		default:
 			ret = state->fc_replay_num_tags ?
@@ -2139,9 +2140,10 @@ static int ext4_fc_replay(journal_t *journal, struct buffer_head *bh,
 	start = (u8 *)bh->b_data;
 	end = (__u8 *)bh->b_data + journal->j_blocksize - 1;
 
-	for (cur = start; cur < end; cur = cur + sizeof(tl) + le16_to_cpu(tl.fc_len)) {
-		memcpy(&tl, cur, sizeof(tl));
-		val = cur + sizeof(tl);
+	for (cur = start; cur < end;
+	     cur = cur + EXT4_FC_TAG_BASE_LEN + le16_to_cpu(tl.fc_len)) {
+		memcpy(&tl, cur, EXT4_FC_TAG_BASE_LEN);
+		val = cur + EXT4_FC_TAG_BASE_LEN;
 
 		if (state->fc_replay_num_tags == 0) {
 			ret = JBD2_FC_REPLAY_STOP;
diff --git a/fs/ext4/fast_commit.h b/fs/ext4/fast_commit.h
index 1db12847a83b..a6154c3ed135 100644
--- a/fs/ext4/fast_commit.h
+++ b/fs/ext4/fast_commit.h
@@ -70,6 +70,9 @@ struct ext4_fc_tail {
 	__le32 fc_crc;
 };
 
+/* Tag base length */
+#define EXT4_FC_TAG_BASE_LEN (sizeof(struct ext4_fc_tl))
+
 /*
  * Fast commit status codes
  */
-- 
2.31.1

