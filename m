Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17426A51D8
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Feb 2023 04:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjB1Dlh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 Feb 2023 22:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjB1Dlh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 27 Feb 2023 22:41:37 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61ADF24129;
        Mon, 27 Feb 2023 19:41:33 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PQjpJ1rcFz4f41Tt;
        Tue, 28 Feb 2023 11:41:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgDnjOrod_1jpDeZEQ--.58449S2;
        Tue, 28 Feb 2023 11:41:30 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        shikemeng@huaweicloud.com
Subject: [PATCH v2 00/20] Some bugfix and cleanup to mballoc
Date:   Tue, 28 Feb 2023 19:42:46 +0800
Message-Id: <20230228114306.3328235-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDnjOrod_1jpDeZEQ--.58449S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFW7CrWDKryUAFWxXryrJFb_yoW8uFykpF
        43GrnxC34xXr17CFZxuw45X3Wft3y0kw1UGFy2g348ArnrAr9IqFnrKFyruFWUJFWkt3Zx
        ZFy2yr45Grs7Ca7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2ocxC64kIII
        0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xv
        wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
        x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
        64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
        1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAq
        YI8I648v4I1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v2
        6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7sRi
        Pl1DUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi, this series contain some random cleanup patches and some bugfix
patches to make EXT4_MB_HINT_GOAL_ONLY work properly, protect pa->pa_free
from race and so on. More details can be found in git log.
Thanks!

---
V2:
-Add signed-off from Ritesh and Ojaswin to patch 3/20 "ext4: get correct
ext4_group_info in ext4_mb_prefetch_fini" as this is a duplicate of
a patch under reviewing.
-Split out original patch "ext4: avoid to use preallocated blocks if
EXT4_MB_HINT_GOAL_ONLY is set" which will be resend after improved.
-Improve log information of patch 20.
-Collect Reviewed-by from Ojaswin and Ritesh. Now only patch 3, 12 and
20 need futher review.
---

Kemeng Shi (20):
  ext4: set goal start correctly in ext4_mb_normalize_request
  ext4: allow to find by goal if EXT4_MB_HINT_GOAL_ONLY is set
  ext4: get correct ext4_group_info in ext4_mb_prefetch_fini
  ext4: correct calculation of s_mb_preallocated
  ext4: correct start of used group pa for debug in ext4_mb_use_group_pa
  ext4: protect pa->pa_free in ext4_discard_allocated_blocks
  ext4: add missed brelse in ext4_free_blocks_simple
  ext4: remove unused return value of ext4_mb_try_best_found and
    ext4_mb_free_metadata
  ext4: Remove unnecessary release when memory allocation failed in
    ext4_mb_init_cache
  ext4: remove unnecessary e4b->bd_buddy_page check in
    ext4_mb_load_buddy_gfp
  ext4: remove unnecessary check in ext4_mb_new_blocks
  ext4: remove dead check in mb_buddy_mark_free
  ext4: remove ac->ac_found > sbi->s_mb_min_to_scan dead check in
    ext4_mb_check_limits
  ext4: use best found when complex scan of group finishs
  ext4: remove unnecessary exit_meta_group_info tag
  ext4: remove unnecessary count2 in ext4_free_data_in_buddy
  ext4: remove unnecessary goto in ext4_mb_mark_diskspace_used
  ext4: remove repeat assignment to ac_f_ex
  ext4: remove comment code ext4_discard_preallocations
  ext4: simplify calculation of blkoff in ext4_mb_new_blocks_simple

 fs/ext4/mballoc.c | 104 +++++++++++++++++-----------------------------
 1 file changed, 38 insertions(+), 66 deletions(-)

-- 
2.30.0

