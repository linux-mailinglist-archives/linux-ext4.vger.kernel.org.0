Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3EF36BE502
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Mar 2023 10:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjCQJKM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Mar 2023 05:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbjCQJJw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Mar 2023 05:09:52 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C442E144A8
        for <linux-ext4@vger.kernel.org>; Fri, 17 Mar 2023 02:09:34 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PdJGx0VZmz4f3l79
        for <linux-ext4@vger.kernel.org>; Fri, 17 Mar 2023 17:09:29 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.170])
        by APP4 (Coremail) with SMTP id gCh0CgAHcLNGLhRk8RgkFg--.44000S4;
        Fri, 17 Mar 2023 17:09:29 +0800 (CST)
From:   Zhang Yi <yi.zhang@huaweicloud.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yi.zhang@huaweicloud.com, yukuai3@huawei.com
Subject: [PATCH v4 0/2] ext4, jbd2: journal cycled record transactions between each mount
Date:   Fri, 17 Mar 2023 17:09:24 +0800
Message-Id: <20230317090926.4149399-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHcLNGLhRk8RgkFg--.44000S4
X-Coremail-Antispam: 1UD129KBjvJXoW7tFy7ZFy7ArWfXFykGw1kGrg_yoW8ur4kpF
        W3t3yY9rykXFyxAwsaka17XrWFqw40yFW7Wrnxu34Fyw45AF1Igw4fKFyY9F1DtrWSga1F
        qr1UtF45Ga4jy37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vI
        r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
        AvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
        xVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbE_M3UUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Zhang Yi <yi.zhang@huawei.com>

v3->v4:
 - Remove journal_cycle_record mount option, always enable it on ext4.
v2->v3:
 - Prevent warning if mount old image with journal_cycle_record enabled.
 - Limit this mount option into ext4 iamge only.
v1->v2:
 - Fix the format type warning.
 - Add more check of journal_cycle_record mount options in remount.

Hello!

This patch set is the fourth edition of the journal_cycle_record mount
option. It save journal head for a clean unmounted file system in the
journal super block, which could let us record journal transactions
between each mount continuously. It could help us to do journal
backtrack and find root cause from a corrupted filesystem. Current
filesystem's corruption analysis is difficult and less useful
information, especially on the real products. It is useful to some
extent, especially for the cases of doing fuzzy tests and deploy in
some shout-runing products.

I will send out the corresponding e2fsprogs part v2 separately, all of
these have done below test cases and also passed xfstests in auto mode.
 - Mount a filesystem with empty journal.
 - Mount a filesystem with journal ended in an unrecovered complete
   transaction.
 - Mount a filesystem with journal ended in an incomplete transaction.
 - Mount a corrupted filesystem with out of bound journal s_head.
 - Mount old filesystem without journal s_head set.

Any comments are welcome.

Thanks!
Yi.

v3: https://lore.kernel.org/linux-ext4/20230314140522.3266591-1-yi.zhang@huaweicloud.com/
v2: https://lore.kernel.org/linux-ext4/20230202142224.3679549-1-yi.zhang@huawei.com/
v1: https://lore.kernel.org/linux-ext4/20230119034600.3431194-3-yi.zhang@huaweicloud.com/

Zhang Yi (2):
  jbd2: continue to record log between each mount
  ext4: add journal cycled recording support

 fs/ext4/super.c      |  5 +++++
 fs/jbd2/journal.c    | 18 ++++++++++++++++--
 fs/jbd2/recovery.c   | 22 +++++++++++++++++-----
 include/linux/jbd2.h |  9 +++++++--
 4 files changed, 45 insertions(+), 9 deletions(-)

-- 
2.31.1

