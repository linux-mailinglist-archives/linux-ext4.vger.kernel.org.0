Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF3772F11B
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Jun 2023 02:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241664AbjFNApB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 13 Jun 2023 20:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241553AbjFNAoy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 13 Jun 2023 20:44:54 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0091996;
        Tue, 13 Jun 2023 17:44:47 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R301e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vl42ewq_1686703484;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0Vl42ewq_1686703484)
          by smtp.aliyun-inc.com;
          Wed, 14 Jun 2023 08:44:44 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     tytso@mit.edu
Cc:     jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] jbd2: remove unused function '__cp_buffer_busy'
Date:   Wed, 14 Jun 2023 08:44:43 +0800
Message-Id: <20230614004443.56937-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The code calling function '__cp_buffer_busy' has been removed, so the
function should also be removed.
silence the warning:
fs/jbd2/checkpoint.c:48:20: warning: unused function '__cp_buffer_busy'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5518
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/jbd2/checkpoint.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index 9ec91017a7f3..ba4ae74c7167 100644
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
2.20.1.7.g153144c

