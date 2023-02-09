Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6E66907EE
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Feb 2023 12:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjBIL5H (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 9 Feb 2023 06:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjBIL4N (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 9 Feb 2023 06:56:13 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320C85C48F;
        Thu,  9 Feb 2023 03:46:31 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PCFSf1xcwz4f3v6x;
        Thu,  9 Feb 2023 19:46:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgAn3rEQ3eRjgb0tDQ--.53508S11;
        Thu, 09 Feb 2023 19:46:28 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/21] ext4: remove unused return value of ext4_mb_try_best_found and ext4_mb_free_metadata
Date:   Fri, 10 Feb 2023 03:48:13 +0800
Message-Id: <20230209194825.511043-10-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230209194825.511043-1-shikemeng@huaweicloud.com>
References: <20230209194825.511043-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAn3rEQ3eRjgb0tDQ--.53508S11
X-Coremail-Antispam: 1UD129KBjvJXoWxJrWUZFWxZFW8KrWkZrWUJwb_yoW8uFyfpr
        srJFy8Cr1xXr1DuFZru3W5X3WF9w4xu3WUGryIgw1rCF13urWDKF47t3W0vF1FqrWkuFnx
        AFWqvr15GrsrK37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
        vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
        42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
        kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIL05UUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Return value static function ext4_mb_try_best_found and
ext4_mb_free_metadata is not used. Just remove unused return value.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/mballoc.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 17ac98c501ed..ad9e3b7d3198 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2124,7 +2124,7 @@ static void ext4_mb_measure_extent(struct ext4_allocation_context *ac,
 }
 
 static noinline_for_stack
-int ext4_mb_try_best_found(struct ext4_allocation_context *ac,
+void ext4_mb_try_best_found(struct ext4_allocation_context *ac,
 					struct ext4_buddy *e4b)
 {
 	struct ext4_free_extent ex = ac->ac_b_ex;
@@ -2135,7 +2135,7 @@ int ext4_mb_try_best_found(struct ext4_allocation_context *ac,
 	BUG_ON(ex.fe_len <= 0);
 	err = ext4_mb_load_buddy(ac->ac_sb, group, e4b);
 	if (err)
-		return err;
+		return;
 
 	ext4_lock_group(ac->ac_sb, group);
 	max = mb_find_extent(e4b, ex.fe_start, ex.fe_len, &ex);
@@ -2147,8 +2147,6 @@ int ext4_mb_try_best_found(struct ext4_allocation_context *ac,
 
 	ext4_unlock_group(ac->ac_sb, group);
 	ext4_mb_unload_buddy(e4b);
-
-	return 0;
 }
 
 static noinline_for_stack
@@ -5699,7 +5697,7 @@ static void ext4_try_merge_freed_extent(struct ext4_sb_info *sbi,
 	kmem_cache_free(ext4_free_data_cachep, entry);
 }
 
-static noinline_for_stack int
+static noinline_for_stack void
 ext4_mb_free_metadata(handle_t *handle, struct ext4_buddy *e4b,
 		      struct ext4_free_data *new_entry)
 {
@@ -5742,7 +5740,7 @@ ext4_mb_free_metadata(handle_t *handle, struct ext4_buddy *e4b,
 				EXT4_C2B(sbi, cluster),
 				"Block already on to-be-freed list");
 			kmem_cache_free(ext4_free_data_cachep, new_entry);
-			return 0;
+			return;
 		}
 	}
 
@@ -5768,7 +5766,6 @@ ext4_mb_free_metadata(handle_t *handle, struct ext4_buddy *e4b,
 	list_add_tail(&new_entry->efd_list, &sbi->s_freed_data_list);
 	sbi->s_mb_free_pending += clusters;
 	spin_unlock(&sbi->s_md_lock);
-	return 0;
 }
 
 /*
-- 
2.30.0

