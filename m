Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81EE6C2BF2
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Mar 2023 09:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjCUIJf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 Mar 2023 04:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjCUIJb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 21 Mar 2023 04:09:31 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB5330E89;
        Tue, 21 Mar 2023 01:09:27 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Pgklk6nx4z4f3p7j;
        Tue, 21 Mar 2023 16:09:22 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgDnnbEzZhlk+NQhFw--.4478S2;
        Tue, 21 Mar 2023 16:09:24 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ojaswin@linux.ibm.com, shikemeng@huaweicloud.com
Subject: [PATCH 0/8] Some fixes and cleanup to mballoc
Date:   Wed, 22 Mar 2023 00:12:12 +0800
Message-Id: <20230321161220.418652-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDnnbEzZhlk+NQhFw--.4478S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jry7Cw17WFW5ZryfCr1fXrb_yoWkuwc_ua
        4jyrykKFWxJ3Wfua9YgFySvFy8Kr4xtr1jqFyqqrs3Zr17X3ZrAa1kArW3urn3Wr45Aa43
        JrnrXr18JFn7XjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbxxFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M28lY4IEw2IIxx
        k0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK
        6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7
        xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
        FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
        0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
        x2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
        0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
        IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
        AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_
        Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjTRCA
        pnUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

We use cluster unit and block unit for different structure members. For
example, in struct ext4_prealloc_space, pa_lstart and pa_pstart are in
block unit while pa_len and pa_free are in cluster unit; in struct
ext4_free_extent, fe_logical is in block unit while fe_start and fe_len
are in cluster unit. The first five patches fix wrong unit use in
mballoc.
The rest is random bugfix and cleanup to mballoc, More details can be
found in respective patches.
Besides, "kvm-xfstest smoke" passes all test.
Thanks!

Kemeng Shi (8):
  ext4: fix wrong unit use in ext4_mb_normalize_request
  ext4: fix unit mismatch in ext4_mb_new_blocks_simple
  ext4: fix wrong unit use in ext4_mb_new_inode_pa
  ext4: fix wrong unit use in ext4_mb_find_by_goal
  ext4: treat stripe in block unit
  ext4: add EXT4_MB_HINT_GOAL_ONLY test in ext4_mb_use_preallocated
  ext4: remove ext4_block_group and ext4_block_group_offset declaration
  ext4: try all groups in ext4_mb_new_blocks_simple

 fs/ext4/ext4.h    |  4 ---
 fs/ext4/mballoc.c | 75 +++++++++++++++++++++++++++++++++++------------
 fs/ext4/super.c   | 13 ++++++++
 3 files changed, 70 insertions(+), 22 deletions(-)

-- 
2.30.0

