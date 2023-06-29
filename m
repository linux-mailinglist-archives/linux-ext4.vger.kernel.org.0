Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D83741F0A
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Jun 2023 06:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbjF2EA2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Jun 2023 00:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbjF2D7z (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 28 Jun 2023 23:59:55 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2918D2D60;
        Wed, 28 Jun 2023 20:59:53 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Qs4Td4x4vz4f3m8L;
        Thu, 29 Jun 2023 11:59:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgC3quiwAZ1kw6DMMg--.26995S12;
        Thu, 29 Jun 2023 11:59:50 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/13] ext4: use saved local variable sbi instead of EXT4_SB(sb)
Date:   Thu, 29 Jun 2023 20:00:41 +0800
Message-Id: <20230629120044.1261968-11-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230629120044.1261968-1-shikemeng@huaweicloud.com>
References: <20230629120044.1261968-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgC3quiwAZ1kw6DMMg--.26995S12
X-Coremail-Antispam: 1UD129KBjvJXoW7WFW3Jr17XF43WFW5JrWfGrg_yoW8ZrW7pF
        W3AF1rGFWIkF1DuF43Grs8Xr1F9w40y3WjgFWfuFy3XrW5J3Z3CF97ta45WF4UKrZxJw1f
        X398KrWUAr1DX37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAv
        FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJw
        A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE
        3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr2
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
        67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
        42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
        kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIL05UUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        KHOP_HELO_FCRDNS,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
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
---
 fs/ext4/resize.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index 686eee65c118..b9507e432496 100644
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

