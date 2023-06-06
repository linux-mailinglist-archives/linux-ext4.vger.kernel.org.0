Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8652A724512
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Jun 2023 15:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237485AbjFFN7q (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Jun 2023 09:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237003AbjFFN7m (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Jun 2023 09:59:42 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EF010C6
        for <linux-ext4@vger.kernel.org>; Tue,  6 Jun 2023 06:59:39 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QbBtG46lSz4f3mKx
        for <linux-ext4@vger.kernel.org>; Tue,  6 Jun 2023 21:59:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.170])
        by APP2 (Coremail) with SMTP id Syh0CgAXB+XBO39kUFbyKw--.11143S4;
        Tue, 06 Jun 2023 21:59:34 +0800 (CST)
From:   Zhang Yi <yi.zhang@huaweicloud.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yi.zhang@huaweicloud.com, yukuai3@huawei.com,
        chengzhihao1@huawei.com
Subject: [PATCH v3 0/6] jbd2: fix several checkpoint inconsistent issues
Date:   Tue,  6 Jun 2023 21:59:22 +0800
Message-Id: <20230606135928.434610-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgAXB+XBO39kUFbyKw--.11143S4
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF1xWw4DuryDWr1kur1rZwb_yoW8Gw45pF
        Zag34fG395C3yxWr1I9a1UAr40yF48ur47JF98G3WkAF47uF4IqrZrGF10y34UKF93Kay3
        tr1UWrWrGw4jy37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUym14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxG
        rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
        vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
        x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26c
        xKx2IYs7xG6r4j6FyUMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
        wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Zhang Yi <yi.zhang@huawei.com>

v2->v3:
 - Init released parameter in journal_shrink_one_cp_list() instead of
   __jbd2_journal_clean_checkpoint_list() in patch 3.
 - Fix a comment in patch 5.
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

 fs/jbd2/checkpoint.c        | 277 ++++++++++++------------------------
 fs/jbd2/commit.c            |   3 +-
 fs/jbd2/transaction.c       |  40 ++----
 include/linux/jbd2.h        |   7 +-
 include/trace/events/jbd2.h |  12 +-
 5 files changed, 108 insertions(+), 231 deletions(-)

-- 
2.31.1

