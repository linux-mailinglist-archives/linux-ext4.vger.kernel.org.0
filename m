Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590C96E3DDF
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Apr 2023 05:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjDQDEX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 16 Apr 2023 23:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjDQDED (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 16 Apr 2023 23:04:03 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698712689;
        Sun, 16 Apr 2023 20:04:01 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Q0Bhs0jWRz4f3yqm;
        Mon, 17 Apr 2023 11:03:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP1 (Coremail) with SMTP id cCh0CgAXODIXtzxkfzJgHA--.17426S16;
        Mon, 17 Apr 2023 11:03:58 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, ojaswin@linux.ibm.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        shikemeng@huaweicloud.com
Subject: [PATCH v3 14/19] ext4: extent ext4_mb_mark_group_bb to support allocation under journal
Date:   Mon, 17 Apr 2023 19:06:12 +0800
Message-Id: <20230417110617.2664129-15-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230417110617.2664129-1-shikemeng@huaweicloud.com>
References: <20230417110617.2664129-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgAXODIXtzxkfzJgHA--.17426S16
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr4Dtw17Gw1rWr17XryUGFg_yoW7GrWDpr
        WDAr1qkr4fKrnF9F47C34aqF1rKw10k3WUGrWfGrySkr4xtryfXFWxKF1FyF1YyF47Z3Zx
        Xr1Yy347uF4fG37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
        rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6x
        IIjxv20xvEc7CjxVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK
        6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4
        xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8
        JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20V
        AGYxC7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
        wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
        0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AK
        xVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F
        4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRvJPtU
        UUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        KHOP_HELO_FCRDNS,MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Previously, ext4_mb_mark_group_bb is only called under fast commit
replay path, so there is no valid handle when we update block bitmap
and group descriptor. This patch try to extent ext4_mb_mark_group_bb
to be used by code under journal. There are several improves:
1. add "handle_t *handle" to struct ext4_mark_context to accept handle
to journal block bitmap and group descriptor update inside
ext4_mb_mark_group_bb (the added journal caode is based on journal
code in ext4_mb_mark_diskspace_used where ext4_mb_mark_group_bb
is going to be used.)
2. add EXT4_MB_BITMAP_MARKED_CHECK flag to control check if bits in block
bitmap are already marked as allocation code under journal asserts that
all bits to be changed are not marked before.
3. add "ext4_grpblk_t changed" to struct ext4_mark_context to notify number
of bits in block bitmap has changed.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/mballoc.c | 59 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 45 insertions(+), 14 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 623508115d98..c3e620f6eded 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3730,32 +3730,54 @@ void ext4_exit_mballoc(void)
 	ext4_groupinfo_destroy_slabs();
 }
 
+#define EXT4_MB_BITMAP_MARKED_CHECK 0x0001
+#define EXT4_MB_SYNC_UPDATE 0x0002
 struct ext4_mark_context {
+	handle_t *handle;
 	struct super_block *sb;
 	int state;
+	ext4_grpblk_t changed;
 };
 
 static int
 ext4_mb_mark_group_bb(struct ext4_mark_context *mc, ext4_group_t group,
-		      ext4_grpblk_t blkoff, ext4_grpblk_t len)
+		      ext4_grpblk_t blkoff, ext4_grpblk_t len, int flags)
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
@@ -3764,12 +3786,14 @@ ext4_mb_mark_group_bb(struct ext4_mark_context *mc, ext4_group_t group,
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
@@ -3784,6 +3808,7 @@ ext4_mb_mark_group_bb(struct ext4_mark_context *mc, ext4_group_t group,
 	ext4_block_bitmap_csum_set(sb, gdp, bitmap_bh);
 	ext4_group_desc_csum_set(sb, group, gdp);
 	ext4_unlock_group(sb, group);
+	mc->changed = changed;
 
 	if (sbi->s_log_groups_per_flex) {
 		ext4_group_t flex_group = ext4_flex_group(sbi, group);
@@ -3796,15 +3821,17 @@ ext4_mb_mark_group_bb(struct ext4_mark_context *mc, ext4_group_t group,
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
@@ -3968,7 +3995,9 @@ void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
 			break;
 		}
 
-		err = ext4_mb_mark_group_bb(&mc, group, blkoff, clen);
+		err = ext4_mb_mark_group_bb(&mc, group, blkoff, clen,
+					    EXT4_MB_BITMAP_MARKED_CHECK |
+					    EXT4_MB_SYNC_UPDATE);
 		if (err)
 			break;
 
@@ -6072,7 +6101,9 @@ static void ext4_free_blocks_simple(struct inode *inode, ext4_fsblk_t block,
 	ext4_grpblk_t blkoff;
 
 	ext4_get_group_no_and_offset(sb, block, &group, &blkoff);
-	ext4_mb_mark_group_bb(&mc, group, blkoff, count);
+	ext4_mb_mark_group_bb(&mc, group, blkoff, count,
+			      EXT4_MB_BITMAP_MARKED_CHECK |
+			      EXT4_MB_SYNC_UPDATE);
 }
 
 /**
-- 
2.30.0

