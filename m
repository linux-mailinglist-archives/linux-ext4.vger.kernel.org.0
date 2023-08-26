Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A84A789547
	for <lists+linux-ext4@lfdr.de>; Sat, 26 Aug 2023 11:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbjHZJif (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 26 Aug 2023 05:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232320AbjHZJiG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 26 Aug 2023 05:38:06 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9450271B;
        Sat, 26 Aug 2023 02:37:54 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RXsDv4hrFz4f3k6W;
        Sat, 26 Aug 2023 17:37:51 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgA3E6bqx+lkNx57Bg--.59420S14;
        Sat, 26 Aug 2023 17:37:52 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/13] ext4: remove unnecessary check to avoid repeat update_backups for the same gdb
Date:   Sun, 27 Aug 2023 01:37:34 +0800
Message-Id: <20230826173735.4023594-13-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230826173735.4023594-1-shikemeng@huaweicloud.com>
References: <20230826173735.4023594-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgA3E6bqx+lkNx57Bg--.59420S14
X-Coremail-Antispam: 1UD129KBjvJXoW7ur15XryrZryUKF1xWF13CFg_yoW8urWfpw
        n0y3W8CrWjgr1DuF47G3WYq34Ska1xJa4UZrW7tw1jkrZxJ3Z7XF97tF1FyFWYqFZrAwn2
        qF1jvryUAw1S9aDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAv
        FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7Jw
        A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq
        3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8w
        Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE
        14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
        0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
        7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
        C0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE
        42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
        kF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU0TqcUUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        MAY_BE_FORGED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The sbi->s_group_desc contains array of bh's for block group descriptors
and continuous EXT4_DESC_PER_BLOCK(sb) bg descriptors in single block
share the same bh.
Simply call update_backups for each gdb_bh in sbi->s_group_desc will not
update same group descriptors block for multiple times.

Commit 0acdb8876fead ("ext4: don't call update_backups() multiple times for
the same bg") wrongly assumed each block group descriptor in the same block
has a individual bh and unnecessary check was added.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/ext4.h   | 1 +
 fs/ext4/resize.c | 4 ----
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 84618c46f239..37ac39711cd1 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1488,6 +1488,7 @@ struct ext4_sb_info {
 	loff_t s_bitmap_maxbytes;	/* max bytes for bitmap files */
 	struct buffer_head * s_sbh;	/* Buffer containing the super block */
 	struct ext4_super_block *s_es;	/* Pointer to the super block in the buffer */
+	/* Array of bh's for the block group descriptors */
 	struct buffer_head * __rcu *s_group_desc;
 	unsigned int s_mount_opt;
 	unsigned int s_mount_opt2;
diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index 4dc68400ba19..b35bfd4573f0 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -1594,7 +1594,6 @@ static int ext4_flex_group_add(struct super_block *sb,
 		int meta_bg = ext4_has_feature_meta_bg(sb);
 		sector_t padding_blocks = meta_bg ? 0 : sbi->s_sbh->b_blocknr -
 					 ext4_group_first_block_no(sb, 0);
-		sector_t old_gdb = 0;
 
 		update_backups(sb, ext4_group_first_block_no(sb, 0),
 			       (char *)es, sizeof(struct ext4_super_block), 0);
@@ -1603,11 +1602,8 @@ static int ext4_flex_group_add(struct super_block *sb,
 
 			gdb_bh = sbi_array_rcu_deref(sbi, s_group_desc,
 						     gdb_num);
-			if (old_gdb == gdb_bh->b_blocknr)
-				continue;
 			update_backups(sb, gdb_bh->b_blocknr - padding_blocks,
 				       gdb_bh->b_data, gdb_bh->b_size, meta_bg);
-			old_gdb = gdb_bh->b_blocknr;
 		}
 	}
 exit:
-- 
2.30.0

