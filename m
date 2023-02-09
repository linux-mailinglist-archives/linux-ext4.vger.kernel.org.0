Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035676907FA
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Feb 2023 12:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjBIL5n (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 9 Feb 2023 06:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjBIL4P (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 9 Feb 2023 06:56:15 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67C45C498;
        Thu,  9 Feb 2023 03:46:32 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PCFSg6Qshz4f3k5d;
        Thu,  9 Feb 2023 19:46:27 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgAn3rEQ3eRjgb0tDQ--.53508S16;
        Thu, 09 Feb 2023 19:46:30 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 14/21] ext4: remove ac->ac_found > sbi->s_mb_min_to_scan dead check in ext4_mb_check_limits
Date:   Fri, 10 Feb 2023 03:48:18 +0800
Message-Id: <20230209194825.511043-15-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230209194825.511043-1-shikemeng@huaweicloud.com>
References: <20230209194825.511043-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAn3rEQ3eRjgb0tDQ--.53508S16
X-Coremail-Antispam: 1UD129KBjvJXoW7KrW5tF1rZrW3CryUCr17Wrg_yoW8WF4rpF
        srCFyUW34xWr1a9wsrK3Z8W3WrKw4fKF1xJryS9r1rAF17X3yqka9xtFyUZF9Fyrs3Z3Z3
        ZFyYqr4UGw4Ika7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAv
        FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3w
        A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE
        3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr2
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
        67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY
        6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aV
        CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0TqcUUUUUU==
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
---
 fs/ext4/mballoc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 0fdbf16ac180..e53f84de5018 100644
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

