Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4490A7A6250
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Sep 2023 14:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjISMQU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 Sep 2023 08:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbjISMQT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 19 Sep 2023 08:16:19 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC47F2;
        Tue, 19 Sep 2023 05:16:11 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RqgcM5SfNz4f4Pks;
        Tue, 19 Sep 2023 20:16:03 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgAnOA0DkQllO8FpAw--.40065S3;
        Tue, 19 Sep 2023 20:16:07 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, ritesh.list@gmail.com
Cc:     ojaswin@linux.ibm.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 01/12] ext4: make state in ext4_mb_mark_bb to be bool
Date:   Wed, 20 Sep 2023 04:15:21 +0800
Message-Id: <20230919201532.310085-2-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230919201532.310085-1-shikemeng@huaweicloud.com>
References: <20230919201532.310085-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgAnOA0DkQllO8FpAw--.40065S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWw4DJFWUWF1UAFWUWrWDCFg_yoW5Gryrpa
        sxCF1rCFs5XF1Dua17Gw18Jw1jg34kKF18tryru34F9rZ3tryIqan8tFyjy3W5trWku3W3
        XF4jkryUArWfGa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
        z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
        xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
        6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwI
        xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
        Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7
        IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
        6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j-Oz3UUUUU=
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
 fs/ext4/fast_commit.c | 8 ++++----
 fs/ext4/mballoc.c     | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

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
index 1e599305d85f..cf09adfbaf11 100644
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
-- 
2.30.0

