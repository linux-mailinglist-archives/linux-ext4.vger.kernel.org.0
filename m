Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9C27A624F
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Sep 2023 14:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjISMQT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 Sep 2023 08:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjISMQS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 19 Sep 2023 08:16:18 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6C6E3;
        Tue, 19 Sep 2023 05:16:11 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RqgcN4kGSz4f3nqj;
        Tue, 19 Sep 2023 20:16:04 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgAnOA0DkQllO8FpAw--.40065S6;
        Tue, 19 Sep 2023 20:16:08 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, ritesh.list@gmail.com
Cc:     ojaswin@linux.ibm.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 04/12] ext4: extend ext4_mb_mark_context to support allocation under journal
Date:   Wed, 20 Sep 2023 04:15:24 +0800
Message-Id: <20230919201532.310085-5-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230919201532.310085-1-shikemeng@huaweicloud.com>
References: <20230919201532.310085-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgAnOA0DkQllO8FpAw--.40065S6
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr4DtF4rAFWDJF1ktF1DWrg_yoW7GF1Dpr
        WDAr1qkr43KrnI9FsrA342q3WfGw1Ikw1DGrWfG3s5CrWxtr95XF4fKFyFyF4YyF47Z3Z8
        XF1Yy34xGr4rG37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAv
        FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJw
        A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq
        3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8w
        Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE
        14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
        0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
        7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
        C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
        04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
        CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jstxDUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Previously, ext4_mb_mark_context is only called under fast commit
replay path, so there is no valid handle when we update block bitmap
and group descriptor. This patch try to extend ext4_mb_mark_context
to be used by code under journal. There are several improvement:
1. add "handle_t *handle" to struct ext4_mark_context to journal block
bitmap and group descriptor update inside ext4_mb_mark_context (the
added journal code is based on ext4_mb_mark_diskspace_used where
ext4_mb_mark_context is going to be used.)
2. add EXT4_MB_BITMAP_MARKED_CHECK flag to control check if bits in block
bitmap are already marked as allocation code under journal asserts that
all bits to be changed are not marked before.
3. add "ext4_grpblk_t changed" to struct ext4_mark_context to notify number
of bits in block bitmap has changed.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/mballoc.c | 64 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 49 insertions(+), 15 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index cd2fd5dbfcdd..bdf07b2904ca 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3953,26 +3953,47 @@ void ext4_exit_mballoc(void)
 	ext4_groupinfo_destroy_slabs();
 }
 
+#define EXT4_MB_BITMAP_MARKED_CHECK 0x0001
+#define EXT4_MB_SYNC_UPDATE 0x0002
 static int
-ext4_mb_mark_context(struct super_block *sb, bool state, ext4_group_t group,
-		     ext4_grpblk_t blkoff, ext4_grpblk_t len)
+ext4_mb_mark_context(handle_t *handle, struct super_block *sb, bool state,
+		     ext4_group_t group, ext4_grpblk_t blkoff,
+		     ext4_grpblk_t len, int flags, ext4_grpblk_t *ret_changed)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct buffer_head *bitmap_bh = NULL;
 	struct ext4_group_desc *gdp;
 	struct buffer_head *gdp_bh;
 	int err;
-	unsigned int i, already, changed;
+	unsigned int i, already, changed = len;
 
+	if (ret_changed)
+		*ret_changed = 0;
 	bitmap_bh = ext4_read_block_bitmap(sb, group);
 	if (IS_ERR(bitmap_bh))
 		return PTR_ERR(bitmap_bh);
 
+	if (handle) {
+		BUFFER_TRACE(bitmap_bh, "getting write access");
+		err = ext4_journal_get_write_access(handle, sb, bitmap_bh,
+						    EXT4_JTR_NONE);
+		if (err)
+			goto out_err;
+	}
+
 	err = -EIO;
 	gdp = ext4_get_group_desc(sb, group, &gdp_bh);
 	if (!gdp)
 		goto out_err;
 
+	if (handle) {
+		BUFFER_TRACE(gdp_bh, "get_write_access");
+		err = ext4_journal_get_write_access(handle, sb, gdp_bh,
+						    EXT4_JTR_NONE);
+		if (err)
+			goto out_err;
+	}
+
 	ext4_lock_group(sb, group);
 	if (ext4_has_group_desc_csum(sb) &&
 	    (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT))) {
@@ -3981,12 +4002,14 @@ ext4_mb_mark_context(struct super_block *sb, bool state, ext4_group_t group,
 			ext4_free_clusters_after_init(sb, group, gdp));
 	}
 
-	already = 0;
-	for (i = 0; i < len; i++)
-		if (mb_test_bit(blkoff + i, bitmap_bh->b_data) ==
-				state)
-			already++;
-	changed = len - already;
+	if (flags & EXT4_MB_BITMAP_MARKED_CHECK) {
+		already = 0;
+		for (i = 0; i < len; i++)
+			if (mb_test_bit(blkoff + i, bitmap_bh->b_data) ==
+					state)
+				already++;
+		changed = len - already;
+	}
 
 	if (state) {
 		mb_set_bits(bitmap_bh->b_data, blkoff, len);
@@ -4001,6 +4024,8 @@ ext4_mb_mark_context(struct super_block *sb, bool state, ext4_group_t group,
 	ext4_block_bitmap_csum_set(sb, gdp, bitmap_bh);
 	ext4_group_desc_csum_set(sb, group, gdp);
 	ext4_unlock_group(sb, group);
+	if (ret_changed)
+		*ret_changed = changed;
 
 	if (sbi->s_log_groups_per_flex) {
 		ext4_group_t flex_group = ext4_flex_group(sbi, group);
@@ -4013,15 +4038,17 @@ ext4_mb_mark_context(struct super_block *sb, bool state, ext4_group_t group,
 			atomic64_add(changed, &fg->free_clusters);
 	}
 
-	err = ext4_handle_dirty_metadata(NULL, NULL, bitmap_bh);
+	err = ext4_handle_dirty_metadata(handle, NULL, bitmap_bh);
 	if (err)
 		goto out_err;
-	err = ext4_handle_dirty_metadata(NULL, NULL, gdp_bh);
+	err = ext4_handle_dirty_metadata(handle, NULL, gdp_bh);
 	if (err)
 		goto out_err;
 
-	sync_dirty_buffer(bitmap_bh);
-	sync_dirty_buffer(gdp_bh);
+	if (flags & EXT4_MB_SYNC_UPDATE) {
+		sync_dirty_buffer(bitmap_bh);
+		sync_dirty_buffer(gdp_bh);
+	}
 
 out_err:
 	brelse(bitmap_bh);
@@ -4181,7 +4208,11 @@ void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
 			break;
 		}
 
-		err = ext4_mb_mark_context(sb, state, group, blkoff, clen);
+		err = ext4_mb_mark_context(NULL, sb, state,
+					   group, blkoff, clen,
+					   EXT4_MB_BITMAP_MARKED_CHECK |
+					   EXT4_MB_SYNC_UPDATE,
+					   NULL);
 		if (err)
 			break;
 
@@ -6398,7 +6429,10 @@ static void ext4_free_blocks_simple(struct inode *inode, ext4_fsblk_t block,
 	ext4_grpblk_t blkoff;
 
 	ext4_get_group_no_and_offset(sb, block, &group, &blkoff);
-	ext4_mb_mark_context(sb, false, group, blkoff, count);
+	ext4_mb_mark_context(NULL, sb, false, group, blkoff, count,
+			     EXT4_MB_BITMAP_MARKED_CHECK |
+			     EXT4_MB_SYNC_UPDATE,
+			     NULL);
 }
 
 /**
-- 
2.30.0

