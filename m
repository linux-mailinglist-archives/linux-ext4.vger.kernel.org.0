Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F7E6A51ED
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Feb 2023 04:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjB1Dlz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 Feb 2023 22:41:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjB1Dli (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 27 Feb 2023 22:41:38 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1037241C1;
        Mon, 27 Feb 2023 19:41:37 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PQjpP1px5z4f3pBh;
        Tue, 28 Feb 2023 11:41:33 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgDnjOrod_1jpDeZEQ--.58449S15;
        Tue, 28 Feb 2023 11:41:35 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        shikemeng@huaweicloud.com
Subject: [PATCH v2 13/20] ext4: remove ac->ac_found > sbi->s_mb_min_to_scan dead check in ext4_mb_check_limits
Date:   Tue, 28 Feb 2023 19:42:59 +0800
Message-Id: <20230228114306.3328235-14-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230228114306.3328235-1-shikemeng@huaweicloud.com>
References: <20230228114306.3328235-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDnjOrod_1jpDeZEQ--.58449S15
X-Coremail-Antispam: 1UD129KBjvJXoW7KrW5tF1rZrW3CryUCr17Wrg_yoW8Ar1Upa
        nrCryUC34xWr1a9wsrK3Z8W3WFkw4fKFyxtryfur1rA3ZrX3yqka9xtFy8ZF9Fyrs3Z3Wf
        ZF1Yvr4UGw4Ika7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
        rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6x
        IIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xv
        wVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFc
        xC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_
        Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2
        IErcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAF
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

Only call trace of ext4_mb_check_limits is as following:
ext4_mb_complex_scan_group
	ext4_mb_measure_extent
		ext4_mb_check_limits(ac, e4b, 0);
	ext4_mb_check_limits(ac, e4b, 1);

If the first ac->ac_found > sbi->s_mb_max_to_scan check in
ext4_mb_check_limits is met, we will set ac_status to
AC_STATUS_BREAK and call ext4_mb_try_best_found to try to use
ac->ac_b_ex.
If ext4_mb_try_best_found successes, then block allocation finishs,
the removed ac->ac_found > sbi->s_mb_min_to_scan check is not reachable.
If ext4_mb_try_best_found fails, then we set EXT4_MB_HINT_FIRST and
reset ac->ac_b_ex to retry block allocation. We will use any found
free extent in ext4_mb_measure_extent before reach the removed
ac->ac_found > sbi->s_mb_min_to_scan check.
In summary, the removed ac->ac_found > sbi->s_mb_min_to_scan check is
not reachable and we can remove that dead check.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/mballoc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index f40af7430fca..07a840e8543c 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2039,8 +2039,7 @@ static void ext4_mb_check_limits(struct ext4_allocation_context *ac,
 	if (bex->fe_len < gex->fe_len)
 		return;
 
-	if ((finish_group || ac->ac_found > sbi->s_mb_min_to_scan)
-			&& bex->fe_group == e4b->bd_group) {
+	if (finish_group && bex->fe_group == e4b->bd_group) {
 		/* recheck chunk's availability - we don't know
 		 * when it was found (within this lock-unlock
 		 * period or not) */
-- 
2.30.0

