Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCA976A921
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Aug 2023 08:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbjHAGb4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 1 Aug 2023 02:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbjHAGbx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 1 Aug 2023 02:31:53 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F23F1AD;
        Mon, 31 Jul 2023 23:31:52 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RFQHk4P2Fz4f3lY3;
        Tue,  1 Aug 2023 14:31:46 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgDnjOrQpshkMcvqPA--.21719S7;
        Tue, 01 Aug 2023 14:31:49 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, ritesh.list@gmail.com,
        ojaswin@linux.ibm.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     shikemeng@huaweicloud.com
Subject: [PATCH v3 05/10] ext4: remove unnecessary return for void function
Date:   Tue,  1 Aug 2023 22:31:59 +0800
Message-Id: <20230801143204.2284343-6-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230801143204.2284343-1-shikemeng@huaweicloud.com>
References: <20230801143204.2284343-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDnjOrQpshkMcvqPA--.21719S7
X-Coremail-Antispam: 1UD129KBjvJXoW7KF17ZFWrJrW8XF4kCw47XFb_yoW8WFW7pr
        13JF18uFs5XF1Uua12gws8Gw1ayw1xWF1DJrWIgwnY9rZxJrZakFWDtF10gFyrtrZ5u3Z0
        vr4qvF4UCa1fu37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUP014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
        rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6x
        IIjxv20xvEc7CjxVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK
        6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4
        xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8
        JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20V
        AGYxC7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
        wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
        0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AK
        xVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr
        1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRiVbyDUU
        UUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        MAY_BE_FORGED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The return at end of void function is unnecessary, just remove it.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/mballoc.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index acf8e3183e47..2f26a91595ca 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4876,7 +4876,6 @@ static void ext4_mb_generate_from_freelist(struct super_block *sb, void *bitmap,
 		mb_set_bits(bitmap, entry->efd_start_cluster, entry->efd_count);
 		n = rb_next(n);
 	}
-	return;
 }
 
 /*
@@ -5630,12 +5629,10 @@ static void ext4_mb_show_ac(struct ext4_allocation_context *ac)
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
 
@@ -5876,12 +5873,9 @@ static void ext4_mb_add_n_trim(struct ext4_allocation_context *ac)
 	spin_unlock(&lg->lg_prealloc_lock);
 
 	/* Now trim the list to be not more than 8 elements */
-	if (lg_prealloc_count > 8) {
+	if (lg_prealloc_count > 8)
 		ext4_mb_discard_lg_preallocations(sb, lg,
 						  order, lg_prealloc_count);
-		return;
-	}
-	return ;
 }
 
 /*
@@ -6535,7 +6529,6 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
 error_return:
 	brelse(bitmap_bh);
 	ext4_std_error(sb, err);
-	return;
 }
 
 /**
@@ -6638,7 +6631,6 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
 	}
 
 	ext4_mb_clear_bb(handle, inode, block, count, flags);
-	return;
 }
 
 /**
-- 
2.30.0

