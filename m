Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04BF6A51E9
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Feb 2023 04:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjB1DmB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 Feb 2023 22:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjB1Dll (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 27 Feb 2023 22:41:41 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB7325E22;
        Mon, 27 Feb 2023 19:41:40 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PQjpR6LJxz4f41Tm;
        Tue, 28 Feb 2023 11:41:35 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgDnjOrod_1jpDeZEQ--.58449S22;
        Tue, 28 Feb 2023 11:41:37 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        shikemeng@huaweicloud.com
Subject: [PATCH v2 20/20] ext4: simplify calculation of blkoff in ext4_mb_new_blocks_simple
Date:   Tue, 28 Feb 2023 19:43:06 +0800
Message-Id: <20230228114306.3328235-21-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230228114306.3328235-1-shikemeng@huaweicloud.com>
References: <20230228114306.3328235-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDnjOrod_1jpDeZEQ--.58449S22
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar4kWFW3Aw45ZFWrWr4rXwb_yoW8XrW3pw
        s0kFy8Gr13Wr1UuF47u340qw1ftw1kWr1UuFW3G34rCry7XryfKFyDKF4rtFy3tFW3JF9a
        qF45Z3yfZw1jka7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
        rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6x
        IIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xv
        wVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFc
        xC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_
        Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2
        IErcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
        0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRv
        JPtUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

We calculate blkoff for groups as following:
		ext4_get_group_no_and_offset(sb,
			max(ext4_group_first_block_no(sb, group), goal),
			NULL, &blkoff);

For first group, the blkoff is already calculated before loop, so this
is redundant.
For groups after first group which contains goal, the result of
max(...) above is always ext4_group_first_block_no(sb, group). The
blkoff of first block in group is always 0, so blkoff of groups after
the first group which contains goal is always 0.
So we can clean blkoff calculation as following:
1. Remove blkoff calculation above to remove repeat calculation of
first group.
2. Set blkoff to 0 to set blkoff for groups after first group.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/mballoc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index f65894bfaff2..2cc655de1853 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5769,9 +5769,6 @@ static ext4_fsblk_t ext4_mb_new_blocks_simple(handle_t *handle,
 			return 0;
 		}
 
-		ext4_get_group_no_and_offset(sb,
-			max(ext4_group_first_block_no(sb, group), goal),
-			NULL, &blkoff);
 		while (1) {
 			i = mb_find_next_zero_bit(bitmap_bh->b_data, max,
 						blkoff);
@@ -5786,6 +5783,8 @@ static ext4_fsblk_t ext4_mb_new_blocks_simple(handle_t *handle,
 		brelse(bitmap_bh);
 		if (i < max)
 			break;
+
+		blkoff = 0;
 	}
 
 	if (group >= ext4_get_groups_count(sb) || i >= max) {
-- 
2.30.0

