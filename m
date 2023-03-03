Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636556A920C
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Mar 2023 08:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjCCH6s (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 3 Mar 2023 02:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjCCH6r (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 3 Mar 2023 02:58:47 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F68F43938;
        Thu,  2 Mar 2023 23:58:45 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PSgMh2cFcz4f3lxC;
        Fri,  3 Mar 2023 15:58:40 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgCnUyGwqAFkWC0HEQ--.51341S5;
        Fri, 03 Mar 2023 15:58:42 +0800 (CST)
From:   Ye Bin <yebin@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jack@suse.cz,
        Ye Bin <yebin10@huawei.com>
Subject: [PATCH v2 1/2] ext4: introduce 'update_only' parameter for ext4_find_inline_data_nolock()
Date:   Fri,  3 Mar 2023 16:21:57 +0800
Message-Id: <20230303082158.4012809-2-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230303082158.4012809-1-yebin@huaweicloud.com>
References: <20230303082158.4012809-1-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgCnUyGwqAFkWC0HEQ--.51341S5
X-Coremail-Antispam: 1UD129KBjvJXoWxCw4UuF47Kw4DKrWxKr4xCrg_yoW5Ww1kpr
        98GFykGwsxZFykuFW0gF1UZr1a93W8Cr4UWFWSkrZ5WFykJw18KF15tF1SyF15GrWkZ3ya
        qF1Utry8uw43KrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
        A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
        0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
        17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
        C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
        73UjIFyTuYvjxUzoGQUUUUU
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

Introduce 'update_only' parameter for ext4_find_inline_data_nolock() to
use this function to update 'inline_off' only.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/ext4.h   | 2 +-
 fs/ext4/inline.c | 7 ++++---
 fs/ext4/inode.c  | 2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 4eeb02d456a9..b073976f4bf2 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3545,7 +3545,7 @@ extern loff_t ext4_llseek(struct file *file, loff_t offset, int origin);
 
 /* inline.c */
 extern int ext4_get_max_inline_size(struct inode *inode);
-extern int ext4_find_inline_data_nolock(struct inode *inode);
+extern int ext4_find_inline_data_nolock(struct inode *inode, bool update_only);
 extern int ext4_init_inline_data(handle_t *handle, struct inode *inode,
 				 unsigned int len);
 extern int ext4_destroy_inline_data(handle_t *handle, struct inode *inode);
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 2b42ececa46d..0fa8f41de3de 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -126,7 +126,7 @@ int ext4_get_max_inline_size(struct inode *inode)
  * currently only used in a code path coming form ext4_iget, before
  * the new inode has been unlocked
  */
-int ext4_find_inline_data_nolock(struct inode *inode)
+int ext4_find_inline_data_nolock(struct inode *inode, bool update_only)
 {
 	struct ext4_xattr_ibody_find is = {
 		.s = { .not_found = -ENODATA, },
@@ -159,7 +159,8 @@ int ext4_find_inline_data_nolock(struct inode *inode)
 					(void *)ext4_raw_inode(&is.iloc));
 		EXT4_I(inode)->i_inline_size = EXT4_MIN_INLINE_DATA_SIZE +
 				le32_to_cpu(is.s.here->e_value_size);
-		ext4_set_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
+		if (!update_only)
+			ext4_set_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
 	}
 out:
 	brelse(is.iloc.bh);
@@ -761,7 +762,7 @@ int ext4_write_inline_data_end(struct inode *inode, loff_t pos, unsigned len,
 		 * ext4_write_begin() called
 		 * ext4_try_to_write_inline_data()
 		 */
-		(void) ext4_find_inline_data_nolock(inode);
+		(void) ext4_find_inline_data_nolock(inode, false);
 
 		kaddr = kmap_atomic(page);
 		ext4_write_inline_data(inode, &iloc, kaddr, pos, copied);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index d251d705c276..6ecaa1bef9bb 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4798,7 +4798,7 @@ static inline int ext4_iget_extra_inode(struct inode *inode,
 	if (EXT4_INODE_HAS_XATTR_SPACE(inode)  &&
 	    *magic == cpu_to_le32(EXT4_XATTR_MAGIC)) {
 		ext4_set_inode_state(inode, EXT4_STATE_XATTR);
-		return ext4_find_inline_data_nolock(inode);
+		return ext4_find_inline_data_nolock(inode, false);
 	} else
 		EXT4_I(inode)->i_inline_off = 0;
 	return 0;
-- 
2.31.1

