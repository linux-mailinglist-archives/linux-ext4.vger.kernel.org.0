Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460E975C28C
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Jul 2023 11:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjGUJJr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 21 Jul 2023 05:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjGUJJm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 21 Jul 2023 05:09:42 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB45F30C4;
        Fri, 21 Jul 2023 02:09:41 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4R6kJw4R6Rz4f3s67;
        Fri, 21 Jul 2023 17:09:36 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgAHvrFPS7pkqi7fOQ--.527S9;
        Fri, 21 Jul 2023 17:09:39 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, ritesh.list@gmail.com,
        ojaswin@linux.ibm.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     shikemeng@huaweicloud.com
Subject: [PATCH 07/10] ext4: remove unused ext4_{set}/{clear}_bit_atomic
Date:   Sat, 22 Jul 2023 01:10:04 +0800
Message-Id: <20230721171007.2065423-8-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230721171007.2065423-1-shikemeng@huaweicloud.com>
References: <20230721171007.2065423-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHvrFPS7pkqi7fOQ--.527S9
X-Coremail-Antispam: 1UD129KBjvdXoWruFyUXr1kGF15Zr4kAFy8Grg_yoWfXFb_J3
        4Iva1kGryYk3Z7KFs5u3WkJF1ktrnxtr18uFWrJr18uFyYqan8Ar4kCryjvw1rWr45XFy8
        Arn2qr1YqFykXjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbDAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M28IrcIa0xkI8V
        A2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJ
        M28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2I
        x0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK
        6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4
        xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8
        JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20V
        AGYxC7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
        wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
        0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AK
        xVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
        4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRvJPtU
        UUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Remove ext4_set_bit_atomic and ext4_clear_bit_atomic which are defined but not
used.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/ext4.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 0a2d55faa095..7166edb2e4a7 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1252,10 +1252,8 @@ struct ext4_inode_info {
 
 #define ext4_test_and_set_bit		__test_and_set_bit_le
 #define ext4_set_bit			__set_bit_le
-#define ext4_set_bit_atomic		ext2_set_bit_atomic
 #define ext4_test_and_clear_bit		__test_and_clear_bit_le
 #define ext4_clear_bit			__clear_bit_le
-#define ext4_clear_bit_atomic		ext2_clear_bit_atomic
 #define ext4_test_bit			test_bit_le
 #define ext4_find_next_zero_bit		find_next_zero_bit_le
 #define ext4_find_next_bit		find_next_bit_le
-- 
2.30.0

