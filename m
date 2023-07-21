Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8DB375C288
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Jul 2023 11:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjGUJJo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 21 Jul 2023 05:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjGUJJm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 21 Jul 2023 05:09:42 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366F630C2;
        Fri, 21 Jul 2023 02:09:41 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4R6kJx5XJjz4f3kpt;
        Fri, 21 Jul 2023 17:09:37 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgAHvrFPS7pkqi7fOQ--.527S7;
        Fri, 21 Jul 2023 17:09:38 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, ritesh.list@gmail.com,
        ojaswin@linux.ibm.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     shikemeng@huaweicloud.com
Subject: [PATCH 05/10] ext4: remove unnecessary return for void function
Date:   Sat, 22 Jul 2023 01:10:02 +0800
Message-Id: <20230721171007.2065423-6-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230721171007.2065423-1-shikemeng@huaweicloud.com>
References: <20230721171007.2065423-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHvrFPS7pkqi7fOQ--.527S7
X-Coremail-Antispam: 1UD129KBjvJXoW7AF18Wr17Xr1UAry5Kr1kAFb_yoW8Gr43pr
        4DJF18urs3W3WDuF42gwn8WwnIvw1xWFyDJryIgwnYkFy3ArZ2kFWDtF10gFyfKFZ5uanI
        vF4qvFW5CF4fu37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
        wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
        4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRvJPtU
        UUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        KHOP_HELO_FCRDNS,MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The return at end of void function is nunecessary, just remove it.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/mballoc.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index b838944b5f09..78160bf5b533 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4880,7 +4880,6 @@ static void ext4_mb_generate_from_freelist(struct super_block *sb, void *bitmap,
 		mb_set_bits(bitmap, entry->efd_start_cluster, entry->efd_count);
 		n = rb_next(n);
 	}
-	return;
 }
 
 /*
@@ -5634,12 +5633,10 @@ static void ext4_mb_show_ac(struct ext4_allocation_context *ac)
 #else
 static inline void ext4_mb_show_pa(struct super_block *sb)
 {
-	return;
 }
 static inline void ext4_mb_show_ac(struct ext4_allocation_context *ac)
 {
 	ext4_mb_show_pa(ac->ac_sb);
-	return;
 }
 #endif
 
@@ -5885,7 +5882,6 @@ static void ext4_mb_add_n_trim(struct ext4_allocation_context *ac)
 						  order, lg_prealloc_count);
 		return;
 	}
-	return ;
 }
 
 /*
@@ -6470,7 +6466,6 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
 	}
 error_return:
 	ext4_std_error(sb, err);
-	return;
 }
 
 /**
@@ -6573,7 +6568,6 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
 	}
 
 	ext4_mb_clear_bb(handle, inode, block, count, flags);
-	return;
 }
 
 /**
-- 
2.30.0

