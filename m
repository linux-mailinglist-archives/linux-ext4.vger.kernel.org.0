Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E576E78954B
	for <lists+linux-ext4@lfdr.de>; Sat, 26 Aug 2023 11:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbjHZJih (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 26 Aug 2023 05:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbjHZJiI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 26 Aug 2023 05:38:08 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA33E7A;
        Sat, 26 Aug 2023 02:38:04 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RXsDt31R9z4f3lfv;
        Sat, 26 Aug 2023 17:37:50 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgA3E6bqx+lkNx57Bg--.59420S12;
        Sat, 26 Aug 2023 17:37:51 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/13] ext4: use saved local variable sbi instead of EXT4_SB(sb)
Date:   Sun, 27 Aug 2023 01:37:32 +0800
Message-Id: <20230826173735.4023594-11-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230826173735.4023594-1-shikemeng@huaweicloud.com>
References: <20230826173735.4023594-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgA3E6bqx+lkNx57Bg--.59420S12
X-Coremail-Antispam: 1UD129KBjvJXoW7WFW3Jr17XF43Wr45AFyrWFg_yoW8ZFWrpF
        W3AF15GFWIkF1DuF43Gr4DXr109w40y3WjgFWfZFyUXrW5J3ZxCF97ta45WF4UKrW5Jw1f
        Xa9xKrWUAr1DX37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAv
        FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7Jw
        A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq
        3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8w
        Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE
        14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
        0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
        7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
        C0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
        04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
        CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUIL05UUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        MAY_BE_FORGED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

We save EXT4_SB(sb) to local variable sbi at beginning of function
ext4_resize_begin. Use sbi directly instead of EXT4_SB(sb) to
remove unnecessary pointer dereference.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/resize.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index d4ab2cde0a03..e2c81b589de8 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -55,7 +55,7 @@ int ext4_resize_begin(struct super_block *sb)
 	 * If the reserved GDT blocks is non-zero, the resize_inode feature
 	 * should always be set.
 	 */
-	if (EXT4_SB(sb)->s_es->s_reserved_gdt_blocks &&
+	if (sbi->s_es->s_reserved_gdt_blocks &&
 	    !ext4_has_feature_resize_inode(sb)) {
 		ext4_error(sb, "resize_inode disabled but reserved GDT blocks non-zero");
 		return -EFSCORRUPTED;
@@ -67,9 +67,9 @@ int ext4_resize_begin(struct super_block *sb)
          * bad time to do it anyways.
          */
 	if (EXT4_B2C(sbi, sbi->s_sbh->b_blocknr) !=
-	    le32_to_cpu(EXT4_SB(sb)->s_es->s_first_data_block)) {
+	    le32_to_cpu(sbi->s_es->s_first_data_block)) {
 		ext4_warning(sb, "won't resize using backup superblock at %llu",
-			(unsigned long long)EXT4_SB(sb)->s_sbh->b_blocknr);
+			(unsigned long long)sbi->s_sbh->b_blocknr);
 		return -EPERM;
 	}
 
@@ -77,7 +77,7 @@ int ext4_resize_begin(struct super_block *sb)
 	 * We are not allowed to do online-resizing on a filesystem mounted
 	 * with error, because it can destroy the filesystem easily.
 	 */
-	if (EXT4_SB(sb)->s_mount_state & EXT4_ERROR_FS) {
+	if (sbi->s_mount_state & EXT4_ERROR_FS) {
 		ext4_warning(sb, "There are errors in the filesystem, "
 			     "so online resizing is not allowed");
 		return -EPERM;
@@ -89,7 +89,7 @@ int ext4_resize_begin(struct super_block *sb)
 	}
 
 	if (test_and_set_bit_lock(EXT4_FLAGS_RESIZING,
-				  &EXT4_SB(sb)->s_ext4_flags))
+				  &sbi->s_ext4_flags))
 		ret = -EBUSY;
 
 	return ret;
-- 
2.30.0

