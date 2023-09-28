Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F777B1594
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Sep 2023 10:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjI1IFE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 28 Sep 2023 04:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbjI1IE4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 28 Sep 2023 04:04:56 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D62599;
        Thu, 28 Sep 2023 01:04:53 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Rx5cK6Ph6z4f3kk6;
        Thu, 28 Sep 2023 16:04:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgC3Td2eMxVlgAtdBg--.36922S6;
        Thu, 28 Sep 2023 16:04:50 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     ritesh.list@gmail.com, tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     ojaswin@linux.ibm.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 04/12] ext4: extend ext4_mb_mark_context to support allocation under journal
Date:   Fri, 29 Sep 2023 00:03:59 +0800
Message-Id: <20230928160407.142069-5-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230928160407.142069-1-shikemeng@huaweicloud.com>
References: <20230928160407.142069-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgC3Td2eMxVlgAtdBg--.36922S6
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr4UJw4kWFyrZF4rGFWDtwb_yoW7GF15pr
        WqyF1qkr4fKrnxuF47C34aq3WfGw1Ikw1DGrWfG3s5ur47tr95XF4fKFyFyF4YyFsrZ3Z0
        qF1Yy34xGr4rG37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAv
        FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3w
        A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE
        3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr2
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
        67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
        42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
        kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIL05UUUUU
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
1. Add "handle_t *handle" to struct ext4_mark_context to journal block
bitmap and group descriptor update inside ext4_mb_mark_context (the
added journal code is based on ext4_mb_mark_diskspace_used where
ext4_mb_mark_context is going to be used.)
2. Adds a flag argument to ext4_mb_mark_context() which controls
a. EXT4_MB_BITMAP_MARKED_CHECK - whether block bitmap checking is needed.
b. EXT4_MB_SYNC_UPDATE - whether dirty buffers (bitmap and group
descriptor) needs sync.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/mballoc.c | 64 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 49 insertions(+), 15 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index f50f6fa5e65c..b3e418c0f3d5 100644
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

