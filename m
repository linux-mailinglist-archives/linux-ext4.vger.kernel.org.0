Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6CF752FA5
	for <lists+linux-ext4@lfdr.de>; Fri, 14 Jul 2023 04:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbjGNC5l (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 13 Jul 2023 22:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbjGNC5c (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 13 Jul 2023 22:57:32 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C581D198A
        for <linux-ext4@vger.kernel.org>; Thu, 13 Jul 2023 19:57:31 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4R2GNk6RcGz4f3knh
        for <linux-ext4@vger.kernel.org>; Fri, 14 Jul 2023 10:57:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgBnHbGJubBkNcexNw--.62721S7;
        Fri, 14 Jul 2023 10:57:27 +0800 (CST)
From:   Zhang Yi <yi.zhang@huaweicloud.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yi.zhang@huaweicloud.com,
        chengzhihao1@huawei.com, yang.lee@linux.alibaba.com,
        yukuai3@huawei.com
Subject: [PATCH 3/3] jbd2: remove unused function '__cp_buffer_busy'
Date:   Fri, 14 Jul 2023 10:55:28 +0800
Message-Id: <20230714025528.564988-4-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230714025528.564988-1-yi.zhang@huaweicloud.com>
References: <20230714025528.564988-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBnHbGJubBkNcexNw--.62721S7
X-Coremail-Antispam: 1UD129KBjvdXoWrtrWfJry3JrW3AFykGrWxWFg_yoWkuFX_Za
        4vyF4DW3s5Aw1fA3WDW3y3Kr4UCw4fAr1FgaykKanrKrnrKan5XFyktrZrXryDWws0vr9x
        Zw18JFW8ArnxtjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb-kFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWwA2048vs2IY02
        0Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM2
        8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
        vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
        r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxC20s
        026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
        JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
        v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
        j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
        W8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbJ73DUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Yang Li <yang.lee@linux.alibaba.com>

The code calling function '__cp_buffer_busy' has been removed, so the
function should also be removed.
silence the warning:
fs/jbd2/checkpoint.c:48:20: warning: unused function '__cp_buffer_busy'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5518
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/checkpoint.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index f033ac807013..118699fff2f9 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -40,18 +40,6 @@ static inline void __buffer_unlink(struct journal_head *jh)
 	}
 }
 
-/*
- * Check a checkpoint buffer could be release or not.
- *
- * Requires j_list_lock
- */
-static inline bool __cp_buffer_busy(struct journal_head *jh)
-{
-	struct buffer_head *bh = jh2bh(jh);
-
-	return (jh->b_transaction || buffer_locked(bh) || buffer_dirty(bh));
-}
-
 /*
  * __jbd2_log_wait_for_space: wait until there is space in the journal.
  *
-- 
2.39.2

