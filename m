Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3656916EA
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Feb 2023 03:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjBJC5K (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 9 Feb 2023 21:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjBJC5G (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 9 Feb 2023 21:57:06 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C6066EEF;
        Thu,  9 Feb 2023 18:57:04 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PCdgH4XyGz4f3l7T;
        Fri, 10 Feb 2023 10:56:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgCHgR96suVjIkgqDA--.35208S8;
        Fri, 10 Feb 2023 10:57:01 +0800 (CST)
From:   Ye Bin <yebin@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jack@suse.cz,
        Ye Bin <yebin10@huawei.com>
Subject: [PATCH v2 4/6] ext4: remove backup for super block when recovery journal
Date:   Fri, 10 Feb 2023 11:20:42 +0800
Message-Id: <20230210032044.146115-5-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230210032044.146115-1-yebin@huaweicloud.com>
References: <20230210032044.146115-1-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgCHgR96suVjIkgqDA--.35208S8
X-Coremail-Antispam: 1UD129KBjvdXoWrZFW3XFWDGry3ZF43CF4DJwb_yoWDuFbEga
        yxJFWfXrnxJw4agFZYkws2qa1Fvrs2vr1rG3s3twsY9FyUXrsxGwnFyrW0vr1ruF4rKr98
        Ar4UJFy8trykWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbVAYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s
        0DM28IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
        Y2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14
        v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAF
        wI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
        WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
        bVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
        WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
        67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
        IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
        0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
        VjvjDU0xZFpf9x07UZo7tUUUUU=
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Ye Bin <yebin10@huawei.com>

As previous commit "jbd2: do extra handle when do journal recovery"
already do extra handle for super block. There's no need to do in
ext4_load_journal(), so remove it.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/super.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index ea0fea04907c..d86ee5af2db9 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5916,17 +5916,8 @@ static int ext4_load_journal(struct super_block *sb,
 
 	if (!ext4_has_feature_journal_needs_recovery(sb))
 		err = jbd2_journal_wipe(journal, !really_read_only);
-	if (!err) {
-		char *save = kmalloc(EXT4_S_ERR_LEN, GFP_KERNEL);
-		if (save)
-			memcpy(save, ((char *) es) +
-			       EXT4_S_ERR_START, EXT4_S_ERR_LEN);
+	if (!err)
 		err = jbd2_journal_load(journal);
-		if (save)
-			memcpy(((char *) es) + EXT4_S_ERR_START,
-			       save, EXT4_S_ERR_LEN);
-		kfree(save);
-	}
 
 	if (err) {
 		ext4_msg(sb, KERN_ERR, "error loading journal");
-- 
2.31.1

