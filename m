Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90046C2BFD
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Mar 2023 09:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjCUIJz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 Mar 2023 04:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjCUIJd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 21 Mar 2023 04:09:33 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6064A1BAD7;
        Tue, 21 Mar 2023 01:09:29 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Pgkln3yQVz4f3pCM;
        Tue, 21 Mar 2023 16:09:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgDnnbEzZhlk+NQhFw--.4478S10;
        Tue, 21 Mar 2023 16:09:27 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ojaswin@linux.ibm.com, shikemeng@huaweicloud.com
Subject: [PATCH 8/8] ext4: try all groups in ext4_mb_new_blocks_simple
Date:   Wed, 22 Mar 2023 00:12:20 +0800
Message-Id: <20230321161220.418652-9-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230321161220.418652-1-shikemeng@huaweicloud.com>
References: <20230321161220.418652-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDnnbEzZhlk+NQhFw--.4478S10
X-Coremail-Antispam: 1UD129KBjvJXoW7ur13Kry7uF1DAFyDurWrAFb_yoW8Ar48pr
        sxCF18Kr1fWFnF9anFg34Sq3WxJw1I9F4UWryfC34rGrZrXryfJFsrKF1Yya1jyFZ3X3ZI
        vr4Yvry3Aa1jgaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
        rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6x
        IIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xv
        wVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFc
        xC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_
        Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2
        IErcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
        W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRKfOw
        UUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

ext4_mb_new_blocks_simple ignores the group before goal, so it will fail
if free blocks reside in group before goal. Try all groups to avoid
unexpected failure.
Search finishes either if any free block is found or if no available
blocks are found. Simpliy check "i >= max" to distinguish the above
cases.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Suggested-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/mballoc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 5b837918c624..ee564e700278 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5796,7 +5796,7 @@ static ext4_fsblk_t ext4_mb_new_blocks_simple(handle_t *handle,
 	struct buffer_head *bitmap_bh;
 	struct super_block *sb = ar->inode->i_sb;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
-	ext4_group_t group;
+	ext4_group_t group, nr;
 	ext4_grpblk_t blkoff;
 	ext4_grpblk_t max = EXT4_CLUSTERS_PER_GROUP(sb);
 	ext4_grpblk_t i = 0;
@@ -5810,7 +5810,7 @@ static ext4_fsblk_t ext4_mb_new_blocks_simple(handle_t *handle,
 
 	ar->len = 0;
 	ext4_get_group_no_and_offset(sb, goal, &group, &blkoff);
-	for (; group < ext4_get_groups_count(sb); group++) {
+	for (nr = ext4_get_groups_count(sb); nr > 0; nr--) {
 		bitmap_bh = ext4_read_block_bitmap(sb, group);
 		if (IS_ERR(bitmap_bh)) {
 			*errp = PTR_ERR(bitmap_bh);
@@ -5834,10 +5834,13 @@ static ext4_fsblk_t ext4_mb_new_blocks_simple(handle_t *handle,
 		if (i < max)
 			break;
 
+		if (++group >= ext4_get_groups_count(sb))
+			group = 0;
+
 		blkoff = 0;
 	}
 
-	if (group >= ext4_get_groups_count(sb) || i >= max) {
+	if (i >= max) {
 		*errp = -ENOSPC;
 		return 0;
 	}
-- 
2.30.0

