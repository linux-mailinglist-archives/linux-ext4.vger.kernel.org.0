Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513476BE554
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Mar 2023 10:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjCQJRo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Mar 2023 05:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbjCQJRn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Mar 2023 05:17:43 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBFE5C9DE
        for <linux-ext4@vger.kernel.org>; Fri, 17 Mar 2023 02:17:29 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PdJS53S8dz4f3lXK
        for <linux-ext4@vger.kernel.org>; Fri, 17 Mar 2023 17:17:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.170])
        by APP4 (Coremail) with SMTP id gCh0CgAHcLMcMBRkQ24kFg--.44440S4;
        Fri, 17 Mar 2023 17:17:27 +0800 (CST)
From:   Zhang Yi <yi.zhang@huaweicloud.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yi.zhang@huaweicloud.com, yukuai3@huawei.com
Subject: [PATCH v2 0/3] e2fsprogs: journal cycled record transactions between each mount
Date:   Fri, 17 Mar 2023 17:17:13 +0800
Message-Id: <20230317091716.4150992-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHcLMcMBRkQ24kFg--.44440S4
X-Coremail-Antispam: 1UD129KBjvdXoWrZw47XFykAw4DCFyxCF4fuFg_yoWDuFbEyw
        40vFyrX3yfXF4SyayfKr4UuryYkFsrCr1rGFyxtFW29r18ArWxWF4DKr15Zr1UXr1vkrs8
        Jr18tryvqrn7XjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbzkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxG
        rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
        vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IY
        x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26c
        xKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
        xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUp6wZUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Zhang Yi <yi.zhang@huawei.com>

v1->v2:
 - Remove the document about journal_cycle_record mount option.

Hello!

This is the e2fsprogs part of the ext4 journal cycled record
transactions option feature(corresponding kernel part is at [1]). It
add a new parameter to record the journal head of a clean filesystem,
mke2fs initialize it to the start of journal area, and e2fsck check and
fix it if it's bad, and also update it after recovering journal. Passed
functional tests.

Thanks,
Yi.

[1] https://lore.kernel.org/linux-ext4/20230317090926.4149399-1-yi.zhang@huaweicloud.com/

Zhang Yi (3):
  lib/ext2fs: record and show journal head block
  debugfs/e2fsck: update the journal head block after recovery
  debugfs/e2fsck: check bad s_head block number

 debugfs/journal.c       | 10 +++++++++-
 e2fsck/journal.c        | 15 ++++++++++++++-
 e2fsck/recovery.c       | 21 +++++++++++++++++----
 lib/e2p/ljs.c           |  3 +++
 lib/ext2fs/kernel-jbd.h |  6 ++++--
 lib/ext2fs/mkjournal.c  |  1 +
 6 files changed, 48 insertions(+), 8 deletions(-)

-- 
2.31.1

