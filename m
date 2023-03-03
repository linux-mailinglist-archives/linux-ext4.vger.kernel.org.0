Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0CD6A93AA
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Mar 2023 10:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjCCJUJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 3 Mar 2023 04:20:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjCCJTz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 3 Mar 2023 04:19:55 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D382634301;
        Fri,  3 Mar 2023 01:19:53 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PSj9K0zbqz4f3nTW;
        Fri,  3 Mar 2023 17:19:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgDnnbGyuwFkFpqfEg--.45687S10;
        Fri, 03 Mar 2023 17:19:50 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        shikemeng@huaweicloud.com
Subject: [PATCH v3 08/20] ext4: remove unused return value of ext4_mb_try_best_found and ext4_mb_free_metadata
Date:   Sat,  4 Mar 2023 01:21:08 +0800
Message-Id: <20230303172120.3800725-9-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230303172120.3800725-1-shikemeng@huaweicloud.com>
References: <20230303172120.3800725-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDnnbGyuwFkFpqfEg--.45687S10
X-Coremail-Antispam: 1UD129KBjvJXoWxJrWUZFWxZFW8tF18XF48tFb_yoW8tr47pF
        srJFy8Cr1xXrn8uFZrua15X3ZY9w4xua4UGryIgw1rCF13urWDKF47t3W0vFyFqrWkuFnx
        AFWqvr15GrsrK37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
        rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6x
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
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Return value static function ext4_mb_try_best_found and
ext4_mb_free_metadata is not used. Just remove unused return value.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/mballoc.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index fca11be28fcb..df76f859f3ff 100644
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

