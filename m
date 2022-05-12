Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF23524775
	for <lists+linux-ext4@lfdr.de>; Thu, 12 May 2022 09:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351184AbiELHys (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 May 2022 03:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348169AbiELHys (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 12 May 2022 03:54:48 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAF945067;
        Thu, 12 May 2022 00:54:46 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VCzpi4s_1652342074;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VCzpi4s_1652342074)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 12 May 2022 15:54:34 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     tytso@mit.edu
Cc:     jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] fs: Fix jbd2_journal_try_to_free_buffers() kernel-doc comment
Date:   Thu, 12 May 2022 15:54:32 +0800
Message-Id: <20220512075432.31763-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Add the description of @folio and remove @page in function kernel-doc
comment to remove warnings found by running scripts/kernel-doc, which
is caused by using 'make W=1'.

fs/jbd2/transaction.c:2149: warning: Function parameter or member
'folio' not described in 'jbd2_journal_try_to_free_buffers'
fs/jbd2/transaction.c:2149: warning: Excess function parameter 'page'
description in 'jbd2_journal_try_to_free_buffers'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/jbd2/transaction.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index e49bb0938376..e9c308ae475f 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -2114,7 +2114,7 @@ __journal_try_to_free_buffer(journal_t *journal, struct buffer_head *bh)
 /**
  * jbd2_journal_try_to_free_buffers() - try to free page buffers.
  * @journal: journal for operation
- * @page: to try and free
+ * @folio: Folio to detach data from.
  *
  * For all the buffers on this page,
  * if they are fully written out ordered data, move them onto BUF_CLEAN
-- 
2.20.1.7.g153144c

