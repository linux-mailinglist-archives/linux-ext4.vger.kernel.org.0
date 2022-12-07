Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAE3645471
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Dec 2022 08:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiLGHT5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Dec 2022 02:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiLGHT4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Dec 2022 02:19:56 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EC631EEE;
        Tue,  6 Dec 2022 23:19:55 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NRpZY49dDz4f3vf8;
        Wed,  7 Dec 2022 15:19:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgBniteWPpBj6qE0Bw--.52253S7;
        Wed, 07 Dec 2022 15:19:52 +0800 (CST)
From:   Ye Bin <yebin@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jack@suse.cz,
        Ye Bin <yebin10@huawei.com>
Subject: [PATCH v2 3/6] ext4: remove unnessary size check in ext4_xattr_inode_get()
Date:   Wed,  7 Dec 2022 15:40:40 +0800
Message-Id: <20221207074043.1286731-4-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221207074043.1286731-1-yebin@huaweicloud.com>
References: <20221207074043.1286731-1-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBniteWPpBj6qE0Bw--.52253S7
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw4rXF1fZw15GrWfur4xXrb_yoW3trXEya
        4qqr4UGr43Xr1xWrWDAF1ay3ZYy3W8Gr1fuF4kJFy7Z3WaqayvvrWDXrWUZr13Ww4rt3Z8
        Z34DJrW7GFyFgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbV8YFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r1rM2
        8IrcIa0xkI8VCY1x0267AKxVW8JVW5JwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK
        021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r
        4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
        0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
        JVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
        x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
        DU0xZFpf9x07jnyCJUUUUU=
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Ye Bin <yebin10@huawei.com>

As previous patch add check in ext4_xattr_check_entries(), before call
ext4_xattr_inode_get() will already do xattr entries check.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/xattr.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index eed001eee3ec..75287422c36c 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -525,14 +525,6 @@ ext4_xattr_inode_get(struct inode *inode, struct ext4_xattr_entry *entry,
 		goto out;
 	}
 
-	if (i_size_read(ea_inode) != size) {
-		ext4_warning_inode(ea_inode,
-				   "ea_inode file size=%llu entry size=%zu",
-				   i_size_read(ea_inode), size);
-		err = -EFSCORRUPTED;
-		goto out;
-	}
-
 	err = ext4_xattr_inode_read(ea_inode, buffer, size);
 	if (err)
 		goto out;
-- 
2.31.1

