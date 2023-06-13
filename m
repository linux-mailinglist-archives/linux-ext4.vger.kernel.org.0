Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDDB472E62B
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Jun 2023 16:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242626AbjFMOtR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 13 Jun 2023 10:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242625AbjFMOtM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 13 Jun 2023 10:49:12 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45C41981;
        Tue, 13 Jun 2023 07:49:11 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QgWfD0cZlz4f3pr8;
        Tue, 13 Jun 2023 22:49:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgDHu+njgYhkYjUjLg--.22967S2;
        Tue, 13 Jun 2023 22:49:08 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     s.l-h@gmx.de, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, shikemeng@huaweicloud.com
Subject: [PATCH] Revert "ext4: remove unnecessary check in ext4_bg_num_gdb_nometa"
Date:   Wed, 14 Jun 2023 06:50:25 +0800
Message-Id: <20230613225025.3859522-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDHu+njgYhkYjUjLg--.22967S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XFWxWw4DKrW3Ww1rZr1rXrb_yoWkKFcEka
        y7KF1rX3yaqr1Syry2grsYgr1akFW0yr98XFnxGFyfua4xtF4rC3WDXr95ZrZrWay7Z3s5
        ZryxXa4xJa1xtjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
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
        AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWU
        JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRCA
        pnUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This reverts commit ad3f09be6cfe332be8ff46c78e6ec0f8839107aa.

The reverted commit was intended to simpfy the code to get group
descriptor block number in non-meta block group by assuming
s_gdb_count is block number used for all non-meta block group descriptors.
However s_gdb_count is block number used for all meta *and* non-meta
group descriptors. So s_gdb_group will be > actual group descriptor block
number used for all non-meta block group which should be "total non-meta
block group" / "group descriptors per block", e.g. s_first_meta_bg.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/balloc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index c1edde817be8..09c75a3127c7 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -886,7 +886,10 @@ static unsigned long ext4_bg_num_gdb_nometa(struct super_block *sb,
 	if (!ext4_bg_has_super(sb, group))
 		return 0;
 
-	return EXT4_SB(sb)->s_gdb_count;
+	if (ext4_has_feature_meta_bg(sb))
+		return le32_to_cpu(EXT4_SB(sb)->s_es->s_first_meta_bg);
+	else
+		return EXT4_SB(sb)->s_gdb_count;
 }
 
 /**
-- 
2.30.0

