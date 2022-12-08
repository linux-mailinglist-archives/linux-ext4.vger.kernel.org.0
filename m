Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23CC4646790
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Dec 2022 04:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiLHDNk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Dec 2022 22:13:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiLHDNi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Dec 2022 22:13:38 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A9570625;
        Wed,  7 Dec 2022 19:13:37 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NSK3v48LTz4f3k6P;
        Thu,  8 Dec 2022 11:13:31 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP1 (Coremail) with SMTP id cCh0CgAn0a9cVpFjvYz4Bg--.16330S6;
        Thu, 08 Dec 2022 11:13:34 +0800 (CST)
From:   Ye Bin <yebin@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jack@suse.cz,
        Ye Bin <yebin10@huawei.com>, Eric Whitney <enwlinux@gmail.com>
Subject: [PATCH v4 2/3] ext4: record error when detect abnormal 'i_reserved_data_blocks'
Date:   Thu,  8 Dec 2022 11:34:25 +0800
Message-Id: <20221208033426.1832460-3-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221208033426.1832460-1-yebin@huaweicloud.com>
References: <20221208033426.1832460-1-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgAn0a9cVpFjvYz4Bg--.16330S6
X-Coremail-Antispam: 1UD129KBjvdXoW7GF1DXr1UJFW8Zr17uF13XFb_yoWkCFcEqw
        40yF10v3yrXw4IgFs5Gr13JFZYkF4kCr18Ww1rKF15Zw1YvF4DCw4kAry3Arn5Way8Gr90
        9rWrJryfXrWfWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbskYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r15M2
        8IrcIa0xkI8VCY1x0267AKxVW8JVW5JwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK
        021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r
        xl6s0DM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl
        6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x
        IIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_
        Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
        1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
        14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
        IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
        87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
        IFyTuYvjxU2_MaUUUUU
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Ye Bin <yebin10@huawei.com>

If 'i_reserved_data_blocks' is not cleared which mean something wrong with
code, free space accounting is likely wrong, according to Jan Kara's advice
use ext4_error() to record this abnormal let fsck to repair and also we can
capture this issue.

Signed-off-by: Ye Bin <yebin10@huawei.com>
Reviewed-by: Eric Whitney <enwlinux@gmail.com>
---
 fs/ext4/super.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 840e0a614959..4b2d257d3845 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1387,10 +1387,10 @@ static void ext4_destroy_inode(struct inode *inode)
 	}
 
 	if (EXT4_I(inode)->i_reserved_data_blocks)
-		ext4_msg(inode->i_sb, KERN_ERR,
-			 "Inode %lu (%p): i_reserved_data_blocks (%u) not cleared!",
-			 inode->i_ino, EXT4_I(inode),
-			 EXT4_I(inode)->i_reserved_data_blocks);
+		ext4_error(inode->i_sb,
+			   "Inode %lu (%p): i_reserved_data_blocks (%u) not cleared!",
+			   inode->i_ino, EXT4_I(inode),
+			   EXT4_I(inode)->i_reserved_data_blocks);
 }
 
 static void init_once(void *foo)
-- 
2.31.1

