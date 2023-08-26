Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697EE789476
	for <lists+linux-ext4@lfdr.de>; Sat, 26 Aug 2023 09:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbjHZHvU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 26 Aug 2023 03:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjHZHut (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 26 Aug 2023 03:50:49 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527E42137;
        Sat, 26 Aug 2023 00:50:45 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RXpsC11T5z4f3jMZ;
        Sat, 26 Aug 2023 15:50:39 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgDXZajPrulkChN1Bg--.43571S5;
        Sat, 26 Aug 2023 15:50:42 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, ritesh.list@gmail.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 03/11] ext4: extent ext4_mb_mark_context to support allocation under journal
Date:   Sat, 26 Aug 2023 23:50:20 +0800
Message-Id: <20230826155028.4019470-4-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230826155028.4019470-1-shikemeng@huaweicloud.com>
References: <20230826155028.4019470-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDXZajPrulkChN1Bg--.43571S5
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr4DtF4rZw4xtF4DAFyxXwb_yoW7KrykpF
        yDAr1qkr4fJFnI9FsFk342qF1fKw18C3WUGrWfGryFkryxtryrZF4xKFyFyFWYyF47ZFn8
        Zr1Yy3y7Wa1fK37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUWwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
        84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
        8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
        xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF
        04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
        CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxU3-txDUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Previously, ext4_mb_mark_context is only called under fast commit
replay path, so there is no valid handle when we update block bitmap
and group descriptor. This patch try to extent ext4_mb_mark_context
to be used by code under journal. There are several improves:
1. add "handle_t *handle" to struct ext4_mark_context to accept handle
to journal block bitmap and group descriptor update inside
ext4_mb_mark_context (the added journal caode is based on journal
code in ext4_mb_mark_diskspace_used where ext4_mb_mark_context
is going to be used.)
2. add EXT4_MB_BITMAP_MARKED_CHECK flag to control check if bits in block
bitmap are already marked as allocation code under journal asserts that
all bits to be changed are not marked before.
3. add "ext4_grpblk_t changed" to struct ext4_mark_context to notify number
of bits in block bitmap has changed.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/mballoc.c | 65 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 49 insertions(+), 16 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index c803f74aaf63..b066ee018cdb 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3952,6 +3952,8 @@ void ext4_exit_mballoc(void)
 	ext4_groupinfo_destroy_slabs();
 }
 
+#define EXT4_MB_BITMAP_MARKED_CHECK 0x0001
+#define EXT4_MB_SYNC_UPDATE 0x0002
 /*
  * Collect global setting to reduce the number of variable passing to
  * ext4_mb_mark_context. Pass target group blocks range directly to
@@ -3959,39 +3961,61 @@ void ext4_exit_mballoc(void)
  * to show clearly the specific block range will be marked.
  */
 struct ext4_mark_context {
+	handle_t *handle;
 	struct super_block *sb;
 	int state;
+	ext4_grpblk_t changed;
 };
 
 static inline void ext4_mb_prepare_mark_context(struct ext4_mark_context *mc,
+						handle_t *handle,
 						struct super_block *sb,
 						int state)
 {
+	mc->handle = handle;
 	mc->sb = sb;
 	mc->state = state;
 }
 
 static int
 ext4_mb_mark_context(struct ext4_mark_context *mc, ext4_group_t group,
-		     ext4_grpblk_t blkoff, ext4_grpblk_t len)
+		     ext4_grpblk_t blkoff, ext4_grpblk_t len, int flags)
 {
+	handle_t *handle = mc->handle;
 	struct super_block *sb = mc->sb;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct buffer_head *bitmap_bh = NULL;
 	struct ext4_group_desc *gdp;
 	struct buffer_head *gdp_bh;
 	int err;
-	unsigned int i, already, changed;
+	unsigned int i, already, changed = len;
 
+	mc->changed = 0;
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
@@ -4000,12 +4024,14 @@ ext4_mb_mark_context(struct ext4_mark_context *mc, ext4_group_t group,
 			ext4_free_clusters_after_init(sb, group, gdp));
 	}
 
-	already = 0;
-	for (i = 0; i < len; i++)
-		if (mb_test_bit(blkoff + i, bitmap_bh->b_data) ==
-				mc->state)
-			already++;
-	changed = len - already;
+	if (flags & EXT4_MB_BITMAP_MARKED_CHECK) {
+		already = 0;
+		for (i = 0; i < len; i++)
+			if (mb_test_bit(blkoff + i, bitmap_bh->b_data) ==
+					mc->state)
+				already++;
+		changed = len - already;
+	}
 
 	if (mc->state) {
 		mb_set_bits(bitmap_bh->b_data, blkoff, len);
@@ -4020,6 +4046,7 @@ ext4_mb_mark_context(struct ext4_mark_context *mc, ext4_group_t group,
 	ext4_block_bitmap_csum_set(sb, gdp, bitmap_bh);
 	ext4_group_desc_csum_set(sb, group, gdp);
 	ext4_unlock_group(sb, group);
+	mc->changed = changed;
 
 	if (sbi->s_log_groups_per_flex) {
 		ext4_group_t flex_group = ext4_flex_group(sbi, group);
@@ -4032,15 +4059,17 @@ ext4_mb_mark_context(struct ext4_mark_context *mc, ext4_group_t group,
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
@@ -4179,7 +4208,7 @@ void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
 	int err = 0;
 	unsigned int clen, thisgrp_len;
 
-	ext4_mb_prepare_mark_context(&mc, sb, state);
+	ext4_mb_prepare_mark_context(&mc, NULL, sb, state);
 	while (len > 0) {
 		ext4_get_group_no_and_offset(sb, block, &group, &blkoff);
 
@@ -4202,7 +4231,9 @@ void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
 			break;
 		}
 
-		err = ext4_mb_mark_context(&mc, group, blkoff, clen);
+		err = ext4_mb_mark_context(&mc, group, blkoff, clen,
+					   EXT4_MB_BITMAP_MARKED_CHECK |
+					   EXT4_MB_SYNC_UPDATE);
 		if (err)
 			break;
 
@@ -6419,9 +6450,11 @@ static void ext4_free_blocks_simple(struct inode *inode, ext4_fsblk_t block,
 	ext4_group_t group;
 	ext4_grpblk_t blkoff;
 
-	ext4_mb_prepare_mark_context(&mc, sb, 0);
+	ext4_mb_prepare_mark_context(&mc, NULL, sb, 0);
 	ext4_get_group_no_and_offset(sb, block, &group, &blkoff);
-	ext4_mb_mark_context(&mc, group, blkoff, count);
+	ext4_mb_mark_context(&mc, group, blkoff, count,
+			     EXT4_MB_BITMAP_MARKED_CHECK |
+			     EXT4_MB_SYNC_UPDATE);
 }
 
 /**
-- 
2.30.0

