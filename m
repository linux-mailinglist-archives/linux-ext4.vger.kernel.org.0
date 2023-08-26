Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18476789500
	for <lists+linux-ext4@lfdr.de>; Sat, 26 Aug 2023 11:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjHZJFC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 26 Aug 2023 05:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbjHZJEj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 26 Aug 2023 05:04:39 -0400
X-Greylist: delayed 425 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 26 Aug 2023 02:04:35 PDT
Received: from ustc.edu.cn (email.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0814C2691
        for <linux-ext4@vger.kernel.org>; Sat, 26 Aug 2023 02:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:MIME-Version:Content-Transfer-Encoding; bh=1+UCs/nnni
        U7jXVcF6LiZNTfYZQMr6ipgF1Av6/S/XA=; b=Uonaz6vkM38mpEiZ1uArF8rQIF
        /Nsb9paDJZIR8lUKQF5Ck5Ylo3JuYrLjowyiLdhmOD8TlN3GLq7hWnsFWPsUs8Ih
        V1W3LBTInWS6NsFI2U9x8MTId4TVRviqg5PusaUrINMnOSwCyclW8hkR9tAKeHux
        2uukOb02jDuhdy69U=
Received: from localhost.localdomain (unknown [101.88.124.132])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygCXcUhuvulkKdcYAQ--.2901S2;
        Sat, 26 Aug 2023 16:57:29 +0800 (CST)
From:   Chunhui He <hchunhui@mail.ustc.edu.cn>
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chunhui He <hchunhui@mail.ustc.edu.cn>
Subject: [PATCH 2/2] ext4: trivial: add semicolon after label attributes
Date:   Sat, 26 Aug 2023 08:56:58 +0000
Message-Id: <20230826085658.69769-1-hchunhui@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LkAmygCXcUhuvulkKdcYAQ--.2901S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZF43AFy5uF1UWr13Aw1DWrg_yoWfWFgE9a
        1xJrZrWrZxGFyS9a48Ca9xtw4Yv3s2vr18uFsYywn5W3Z0qa15Wr1DGr97uF9xWrWrZ3s8
        Ar1kJFy0vrWfWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbz8FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJV
        W0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxG
        rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
        vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IY
        x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26c
        xKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
        14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUozVbDUUUU
X-CM-SenderInfo: pkfk30xkxlqzxdloh3xvwfhvlgxou0/
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The gcc document says label attributes are ambiguous if they are
not immediately followed by a semicolon. Although the ambiguity
does not arise in C90/99, it would be better to add it.

Link: https://gcc.gnu.org/onlinedocs/gcc/Attribute-Syntax.html#Label-Attributes-2
Signed-off-by: Chunhui He <hchunhui@mail.ustc.edu.cn>
---
 fs/ext4/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index c94ebf704616..f5fa9815a86e 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5609,7 +5609,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 
 failed_mount10:
 	ext4_quotas_off(sb, EXT4_MAXQUOTAS);
-failed_mount9: __maybe_unused
+failed_mount9: __maybe_unused;
 	ext4_release_orphan_info(sb);
 failed_mount8:
 	ext4_unregister_sysfs(sb);
-- 
2.39.2


