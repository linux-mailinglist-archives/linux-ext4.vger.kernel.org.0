Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBB96C3FC7
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Mar 2023 02:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjCVBeZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 Mar 2023 21:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCVBeY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 21 Mar 2023 21:34:24 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14232F78D
        for <linux-ext4@vger.kernel.org>; Tue, 21 Mar 2023 18:34:23 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Ph9xR4pX2z4f3wYw
        for <linux-ext4@vger.kernel.org>; Wed, 22 Mar 2023 09:34:19 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.170])
        by APP4 (Coremail) with SMTP id gCh0CgD3X7MBWxpkVwFQFw--.12828S7;
        Wed, 22 Mar 2023 09:34:21 +0800 (CST)
From:   Zhang Yi <yi.zhang@huaweicloud.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yi.zhang@huaweicloud.com, yukuai3@huawei.com
Subject: [PATCH v5 3/3] ext4: update doc about journal superblock description
Date:   Wed, 22 Mar 2023 09:33:53 +0800
Message-Id: <20230322013353.1843306-4-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230322013353.1843306-1-yi.zhang@huaweicloud.com>
References: <20230322013353.1843306-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3X7MBWxpkVwFQFw--.12828S7
X-Coremail-Antispam: 1UD129KBjvdXoW7Wr4xGw17WF13KF15WryUZFb_yoWfWFXEqF
        yIyr4kZw4fAr4xWF40kFy5ury3AFs7W3WrZ3WfAa98Aw15JrZ7J3WDJryYyr4UWr4I9rZ8
        ZFZaqFWIyFnrJjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb-kFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWwA2048vs2IY02
        0Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM2
        8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
        vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
        r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxC20s
        026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
        JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
        v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
        j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
        W8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbJ73DUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Zhang Yi <yi.zhang@huawei.com>

Update the description in doc about the s_head parameter in the journal
superblock.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 Documentation/filesystems/ext4/journal.rst | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/ext4/journal.rst b/Documentation/filesystems/ext4/journal.rst
index a6bef5293a60..6e8fb2d4b46f 100644
--- a/Documentation/filesystems/ext4/journal.rst
+++ b/Documentation/filesystems/ext4/journal.rst
@@ -260,8 +260,13 @@ which is 1024 bytes long:
      - s_num_fc_blocks
      - Number of fast commit blocks in the journal.
    * - 0x58
+     - __be32
+     - s_head
+     - Block number of the head (first unused block) of the journal, only
+       up-to-date when the journal is empty.
+   * - 0x5C
      - __u32
-     - s_padding[42]
+     - s_padding[40]
      -
    * - 0xFC
      - __be32
-- 
2.31.1

