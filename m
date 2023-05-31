Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409BB717EE5
	for <lists+linux-ext4@lfdr.de>; Wed, 31 May 2023 13:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235627AbjEaLvS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 31 May 2023 07:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235591AbjEaLvQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 31 May 2023 07:51:16 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B80184
        for <linux-ext4@vger.kernel.org>; Wed, 31 May 2023 04:51:11 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QWSJq0X3bz4f3kKt
        for <linux-ext4@vger.kernel.org>; Wed, 31 May 2023 19:51:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.170])
        by APP2 (Coremail) with SMTP id Syh0CgA33eqkNHdkE8UXKg--.13786S4;
        Wed, 31 May 2023 19:51:06 +0800 (CST)
From:   Zhang Yi <yi.zhang@huaweicloud.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yi.zhang@huaweicloud.com, yukuai3@huawei.com,
        chengzhihao1@huawei.com
Subject: [PATCH 0/5] jbd2: fix several checkpoint inconsistent issues
Date:   Wed, 31 May 2023 19:50:55 +0800
Message-Id: <20230531115100.2779605-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgA33eqkNHdkE8UXKg--.13786S4
X-Coremail-Antispam: 1UD129KBjvdXoW7Xr47Xr1kGF1kAr1UZw4Dtwb_yoWfurX_Ca
        y8tFZ8G3s2qF1UAFs3Ar17JrnrCa1fGF15ZF1ktrW7Crn3Ar4UG3Z5ArsIqw1xXayq9ryD
        JryrCrWFqrnFqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbz8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxG
        rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
        vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
        x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
        xKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
        67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
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

Hello,

The first three patches are from [1] and are not changed, appending
another two (it depends on the first three) to fix another three race
issues in the checkpoint procedure which could also lead to inconsistent
results.

[1] https://lore.kernel.org/linux-ext4/20230516020226.2813588-1-yi.zhang@huaweicloud.com/

Thanks,
Yi.

Zhang Yi (4):
  jbd2: recheck chechpointing non-dirty buffer
  jbd2: remove t_checkpoint_io_list
  jbd2: remove released parameter in journal_shrink_one_cp_list()
  jbd2: fix a race when checking checkpoint buffer busy

Zhihao Cheng (1):
  jbd2: Fix wrongly judgement for buffer head removing while doing
    checkpoint

 fs/jbd2/checkpoint.c  | 186 +++++++++++-------------------------------
 fs/jbd2/commit.c      |   3 +-
 fs/jbd2/transaction.c |   4 +-
 include/linux/jbd2.h  |   9 +-
 4 files changed, 55 insertions(+), 147 deletions(-)

-- 
2.31.1

