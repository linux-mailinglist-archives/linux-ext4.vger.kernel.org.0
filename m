Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33E06A93A9
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Mar 2023 10:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjCCJUG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 3 Mar 2023 04:20:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjCCJTw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 3 Mar 2023 04:19:52 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DADDBDB;
        Fri,  3 Mar 2023 01:19:51 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PSj9G2pD6z4f3jJ8;
        Fri,  3 Mar 2023 17:19:46 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgDnnbGyuwFkFpqfEg--.45687S2;
        Fri, 03 Mar 2023 17:19:48 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        shikemeng@huaweicloud.com
Subject: [PATCH v3 00/20] Some bugfix and cleanup to mballoc
Date:   Sat,  4 Mar 2023 01:21:00 +0800
Message-Id: <20230303172120.3800725-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDnnbGyuwFkFpqfEg--.45687S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXr4kCFWDur4kXw1fAw4rGrg_yoW5Wr1kpF
        43GwnIk34xXr12kFZxuw45X3WfJ3y8Cw1UGFyIg348Ar13Ar9aqrnrKF1ruFW5JrWvq3Zx
        ZFW2yry3Gw4kAa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2ocxC64kIII
        0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xv
        wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
        x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
        64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
        1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAq
        YI8I648v4I1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
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
V3:
-patch 01/20 "ext4: set goal start correctly in
ext4_mb_normalize_request" correctly record goal in ac_g_ex instead of
ac_f_ex, this also trigger another original bug that wanted goal maybe
out of valid data block range. Add valid range check in patch 01/20
to fully fix the bug.
-run "kvm-xfstests smoke" and all tests are passed except generic/454.
This test also failed in running kernel without this patchset, so
it's unlikely caused by this patchset. I'm trying to figure out the
reason but it may take a while as I'm not family with kvm-xfstests.
Just send this series for early review and maybe some help to pass
the failed test case.
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

 fs/ext4/mballoc.c | 111 ++++++++++++++++++----------------------------
 1 file changed, 43 insertions(+), 68 deletions(-)

-- 
2.30.0

