Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD635E8943
	for <lists+linux-ext4@lfdr.de>; Sat, 24 Sep 2022 09:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbiIXHmB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 24 Sep 2022 03:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233567AbiIXHl4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 24 Sep 2022 03:41:56 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDB711E5C1;
        Sat, 24 Sep 2022 00:41:52 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MZLTJ1H7szlXPP;
        Sat, 24 Sep 2022 15:37:40 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 24 Sep
 2022 15:41:50 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <jack@suse.cz>,
        Ye Bin <yebin10@huawei.com>
Subject: [PATCH -next 3/3] ext4: fix potential out of bound read in ext4_fc_replay_scan()
Date:   Sat, 24 Sep 2022 15:52:33 +0800
Message-ID: <20220924075233.2315259-4-yebin10@huawei.com>
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

For scan loop must ensure that at least EXT4_FC_TAG_BASE_LEN space. If remain
space less than EXT4_FC_TAG_BASE_LEN which will lead to out of bound read
when mounting corrupt file system image.
ADD_RANGE/HEAD/TAIL is needed to add extra check when do journal scan, as this
three tags will read data during scan, tag length couldn't less than data length
which will read.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/fast_commit.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 54622005a0c8..ef05bfa87798 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1976,6 +1976,34 @@ void ext4_fc_replay_cleanup(struct super_block *sb)
 	kfree(sbi->s_fc_replay_state.fc_modified_inodes);
 }
 
+static inline bool ext4_fc_tag_len_isvalid(struct ext4_fc_tl *tl,
+					   u8 *val, u8 *end)
+{
+	if (val + tl->fc_len > end)
+		return false;
+
+	/* Here only check ADD_RANGE/TAIL/HEAD which will read data when do
+	 * journal rescan before do CRC check. Other tags length check will
+	 * rely on CRC check.
+	 */
+	switch (tl->fc_tag) {
+	case EXT4_FC_TAG_ADD_RANGE:
+		return (sizeof(struct ext4_fc_add_range) == tl->fc_len);
+	case EXT4_FC_TAG_TAIL:
+		return (sizeof(struct ext4_fc_tail) <= tl->fc_len);
+	case EXT4_FC_TAG_HEAD:
+		return (sizeof(struct ext4_fc_head) == tl->fc_len);
+	case EXT4_FC_TAG_DEL_RANGE:
+	case EXT4_FC_TAG_LINK:
+	case EXT4_FC_TAG_UNLINK:
+	case EXT4_FC_TAG_CREAT:
+	case EXT4_FC_TAG_INODE:
+	case EXT4_FC_TAG_PAD:
+	default:
+		return true;
+	}
+}
+
 /*
  * Recovery Scan phase handler
  *
@@ -2032,10 +2060,15 @@ static int ext4_fc_replay_scan(journal_t *journal,
 	}
 
 	state->fc_replay_expected_off++;
-	for (cur = start; cur < end;
+	for (cur = start; cur < end - EXT4_FC_TAG_BASE_LEN;
 	     cur = cur + EXT4_FC_TAG_BASE_LEN + tl.fc_len) {
 		ext4_fc_get_tl(&tl, cur);
 		val = cur + EXT4_FC_TAG_BASE_LEN;
+		if (!ext4_fc_tag_len_isvalid(&tl, val, end)) {
+			ret = state->fc_replay_num_tags ?
+				JBD2_FC_REPLAY_STOP : -ECANCELED;
+			goto out_err;
+		}
 		ext4_debug("Scan phase, tag:%s, blk %lld\n",
 			   tag2str(tl.fc_tag), bh->b_blocknr);
 		switch (tl.fc_tag) {
@@ -2146,7 +2179,7 @@ static int ext4_fc_replay(journal_t *journal, struct buffer_head *bh,
 	start = (u8 *)bh->b_data;
 	end = (__u8 *)bh->b_data + journal->j_blocksize - 1;
 
-	for (cur = start; cur < end;
+	for (cur = start; cur < end - EXT4_FC_TAG_BASE_LEN;
 	     cur = cur + EXT4_FC_TAG_BASE_LEN + tl.fc_len) {
 		ext4_fc_get_tl(&tl, cur);
 		val = cur + EXT4_FC_TAG_BASE_LEN;
@@ -2156,6 +2189,7 @@ static int ext4_fc_replay(journal_t *journal, struct buffer_head *bh,
 			ext4_fc_set_bitmaps_and_counters(sb);
 			break;
 		}
+
 		ext4_debug("Replay phase, tag:%s\n", tag2str(tl.fc_tag));
 		state->fc_replay_num_tags--;
 		switch (tl.fc_tag) {
-- 
2.31.1

