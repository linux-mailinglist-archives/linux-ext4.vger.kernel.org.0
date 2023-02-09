Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEF96907E2
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Feb 2023 12:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjBIL4u (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 9 Feb 2023 06:56:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjBIL4J (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 9 Feb 2023 06:56:09 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C14857745;
        Thu,  9 Feb 2023 03:46:28 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PCFSb3Tmfz4f3tDd;
        Thu,  9 Feb 2023 19:46:23 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgAn3rEQ3eRjgb0tDQ--.53508S2;
        Thu, 09 Feb 2023 19:46:25 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/21] Some bugfix and cleanup to mballoc
Date:   Fri, 10 Feb 2023 03:48:04 +0800
Message-Id: <20230209194825.511043-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAn3rEQ3eRjgb0tDQ--.53508S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFW7CrWDKryUAFWxWF4Durg_yoW8AF47pF
        sxGrnxG34xXr17Ca9xuw45G3WfJ3y0kw1UGFy2g348AFnrAryaqFnrKFyruFW5JrZ7tFnx
        ZFy7Ar45Grs7ua7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E
        3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r
        xl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv
        0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z2
        80aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28I
        cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42
        IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
        87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j-6pPUUUUU=
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

Kemeng Shi (21):
  ext4: set goal start correctly in ext4_mb_normalize_request
  ext4: allow to find by goal if EXT4_MB_HINT_GOAL_ONLY is set
  ext4: avoid to use preallocated blocks if EXT4_MB_HINT_GOAL_ONLY is
    set
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

 fs/ext4/mballoc.c | 105 ++++++++++++++++++----------------------------
 1 file changed, 40 insertions(+), 65 deletions(-)

-- 
2.30.0

