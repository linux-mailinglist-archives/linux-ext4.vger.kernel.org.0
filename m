Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFCBB7B158C
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Sep 2023 10:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjI1IEz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 28 Sep 2023 04:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjI1IEy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 28 Sep 2023 04:04:54 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361C795;
        Thu, 28 Sep 2023 01:04:53 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Rx5cH6MVJz4f3n6c;
        Thu, 28 Sep 2023 16:04:47 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgC3Td2eMxVlgAtdBg--.36922S3;
        Thu, 28 Sep 2023 16:04:50 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     ritesh.list@gmail.com, tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     ojaswin@linux.ibm.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 01/12] ext4: make state in ext4_mb_mark_bb to be bool
Date:   Fri, 29 Sep 2023 00:03:56 +0800
Message-Id: <20230928160407.142069-2-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230928160407.142069-1-shikemeng@huaweicloud.com>
References: <20230928160407.142069-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgC3Td2eMxVlgAtdBg--.36922S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWw43Ww4kJr1DJF4rJFWkJFb_yoW5KFy7pa
        sxAF1rCrs5XF1Dua17Kw4UAw1jk348Kr1jyryrC3yF9FZ7JryIqFn8tFyjy3W5tFWku3Zx
        XF4jkryUCr4fG37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
        84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
        8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
        xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
        8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
        0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUsgyZUUUUU
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

As state could only be either 0 or 1, just make it bool.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/ext4.h        | 2 +-
 fs/ext4/extents.c     | 4 ++--
 fs/ext4/fast_commit.c | 8 ++++----
 fs/ext4/mballoc.c     | 4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 84618c46f239..88186ea2322f 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2918,7 +2918,7 @@ extern int ext4_group_add_blocks(handle_t *handle, struct super_block *sb,
 extern int ext4_trim_fs(struct super_block *, struct fstrim_range *);
 extern void ext4_process_freed_data(struct super_block *sb, tid_t commit_tid);
 extern void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
-		       int len, int state);
+			    int len, bool state);
 static inline bool ext4_mb_cr_expensive(enum criteria cr)
 {
 	return cr >= CR_GOAL_LEN_SLOW;
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index e4115d338f10..6338a5a2c315 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -6080,13 +6080,13 @@ int ext4_ext_clear_bb(struct inode *inode)
 				for (j = 0; j < path->p_depth; j++) {
 
 					ext4_mb_mark_bb(inode->i_sb,
-							path[j].p_block, 1, 0);
+							path[j].p_block, 1, false);
 					ext4_fc_record_regions(inode->i_sb, inode->i_ino,
 							0, path[j].p_block, 1, 1);
 				}
 				ext4_free_ext_path(path);
 			}
-			ext4_mb_mark_bb(inode->i_sb, map.m_pblk, map.m_len, 0);
+			ext4_mb_mark_bb(inode->i_sb, map.m_pblk, map.m_len, false);
 			ext4_fc_record_regions(inode->i_sb, inode->i_ino,
 					map.m_lblk, map.m_pblk, map.m_len, 1);
 		}
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index b06de728b3b6..87c009e0c59a 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1806,7 +1806,7 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
 			 * at the end of the FC replay using our array of
 			 * modified inodes.
 			 */
-			ext4_mb_mark_bb(inode->i_sb, map.m_pblk, map.m_len, 0);
+			ext4_mb_mark_bb(inode->i_sb, map.m_pblk, map.m_len, false);
 			goto next;
 		}
 
@@ -1875,7 +1875,7 @@ ext4_fc_replay_del_range(struct super_block *sb,
 		if (ret > 0) {
 			remaining -= ret;
 			cur += ret;
-			ext4_mb_mark_bb(inode->i_sb, map.m_pblk, map.m_len, 0);
+			ext4_mb_mark_bb(inode->i_sb, map.m_pblk, map.m_len, false);
 		} else {
 			remaining -= map.m_len;
 			cur += map.m_len;
@@ -1934,12 +1934,12 @@ static void ext4_fc_set_bitmaps_and_counters(struct super_block *sb)
 				if (!IS_ERR(path)) {
 					for (j = 0; j < path->p_depth; j++)
 						ext4_mb_mark_bb(inode->i_sb,
-							path[j].p_block, 1, 1);
+							path[j].p_block, 1, true);
 					ext4_free_ext_path(path);
 				}
 				cur += ret;
 				ext4_mb_mark_bb(inode->i_sb, map.m_pblk,
-							map.m_len, 1);
+							map.m_len, true);
 			} else {
 				cur = cur + (map.m_len ? map.m_len : 1);
 			}
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 1e599305d85f..d7c79217f39c 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4077,7 +4077,7 @@ ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
  * blocks in bitmaps and update counters.
  */
 void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
-			int len, int state)
+		     int len, bool state)
 {
 	struct buffer_head *bitmap_bh = NULL;
 	struct ext4_group_desc *gdp;
@@ -6130,7 +6130,7 @@ ext4_mb_new_blocks_simple(struct ext4_allocation_request *ar, int *errp)
 	}
 
 	block = ext4_group_first_block_no(sb, group) + EXT4_C2B(sbi, i);
-	ext4_mb_mark_bb(sb, block, 1, 1);
+	ext4_mb_mark_bb(sb, block, 1, true);
 	ar->len = 1;
 
 	return block;
-- 
2.30.0

