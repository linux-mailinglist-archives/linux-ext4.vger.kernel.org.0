Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB69723761
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Jun 2023 08:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234826AbjFFGPB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Jun 2023 02:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235059AbjFFGO7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Jun 2023 02:14:59 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9723183
        for <linux-ext4@vger.kernel.org>; Mon,  5 Jun 2023 23:14:57 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Qb0Z53dm8z4f3nKG
        for <linux-ext4@vger.kernel.org>; Tue,  6 Jun 2023 14:14:53 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.170])
        by APP2 (Coremail) with SMTP id Syh0CgA33erXzn5kkHrZKw--.1805S4;
        Tue, 06 Jun 2023 14:14:50 +0800 (CST)
From:   Zhang Yi <yi.zhang@huaweicloud.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yi.zhang@huaweicloud.com, yukuai3@huawei.com,
        chengzhihao1@huawei.com
Subject: [PATCH v2 0/6] jbd2: fix several checkpoint inconsistent issues
Date:   Tue,  6 Jun 2023 14:14:41 +0800
Message-Id: <20230606061447.1125036-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgA33erXzn5kkHrZKw--.1805S4
X-Coremail-Antispam: 1UD129KBjvJXoW7ury5Jr1fZFyrJw47KFyrXrb_yoW8JF43pF
        Z3K34fK395C397Wrn2ga1UAr40yF48ur47KF9xK3WkAF47uF4IqrZrWF10y348KFZ3Ka98
        tr1UWrWrW3yjya7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vI
        r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
        AvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
        xVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VU1a9aPUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Zhang Yi <yi.zhang@huawei.com>

v1->v2:
 - Drop the last patch in [1].
 - Merge journal_clean_one_cp_list() into journal_shrink_one_cp_list().
 - Fix the race issues through trying to hold buffer lock and check
   dirty state under the lock.
 - Append a cleanup patch, remove __journal_try_to_free_buffer().

Hello,

The first two patches are from [1] and are not changed, appending
another four (it depends on the first three) to fix another three race
issues in the checkpoint procedure which could also lead to inconsistent
results.

[1] https://lore.kernel.org/linux-ext4/20230516020226.2813588-1-yi.zhang@huaweicloud.com/

Thanks,
Yi.

Zhang Yi (5):
  jbd2: recheck chechpointing non-dirty buffer
  jbd2: remove t_checkpoint_io_list
  jbd2: remove journal_clean_one_cp_list()
  jbd2: fix a race when checking checkpoint buffer busy
  jbd2: remove __journal_try_to_free_buffer()

Zhihao Cheng (1):
  jbd2: Fix wrongly judgement for buffer head removing while doing
    checkpoint

 fs/jbd2/checkpoint.c        | 276 ++++++++++++------------------------
 fs/jbd2/commit.c            |   3 +-
 fs/jbd2/transaction.c       |  40 ++----
 include/linux/jbd2.h        |   7 +-
 include/trace/events/jbd2.h |  12 +-
 5 files changed, 107 insertions(+), 231 deletions(-)

-- 
2.31.1

