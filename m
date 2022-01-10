Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64EA44899ED
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Jan 2022 14:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbiAJN27 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 10 Jan 2022 08:28:59 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:7556 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230187AbiAJN27 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 10 Jan 2022 08:28:59 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R281e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V1RirBc_1641821326;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V1RirBc_1641821326)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 10 Jan 2022 21:28:46 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     jack@suse.com
Cc:     tytso@mit.edu, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next -v2] ext4: Fix jbd2_journal_shrink_scan() and jbd2_journal_shrink_count() kernel-doc comment
Date:   Mon, 10 Jan 2022 21:28:41 +0800
Message-Id: <20220110132841.34531-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Add the description of @shrink and @sc in jbd2_journal_shrink_scan() and
jbd2_journal_shrink_count() kernel-doc comment to remove warnings found
by running scripts/kernel-doc, which is caused by using 'make W=1'.
fs/jbd2/journal.c:1296: warning: Function parameter or member 'shrink'
not described in 'jbd2_journal_shrink_scan'
fs/jbd2/journal.c:1296: warning: Function parameter or member 'sc' not
described in 'jbd2_journal_shrink_scan'
fs/jbd2/journal.c:1320: warning: Function parameter or member 'shrink'
not described in 'jbd2_journal_shrink_count'
fs/jbd2/journal.c:1320: warning: Function parameter or member 'sc' not
described in 'jbd2_journal_shrink_count'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/jbd2/journal.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index f13d548e4a7f..ad32fd92d251 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1287,6 +1287,8 @@ static int jbd2_min_tag_size(void)
 
 /**
  * jbd2_journal_shrink_scan()
+ * @shrink: shrinker to work on
+ * @sc: reclaim request to process
  *
  * Scan the checkpointed buffer on the checkpoint list and release the
  * journal_head.
@@ -1312,6 +1314,8 @@ static unsigned long jbd2_journal_shrink_scan(struct shrinker *shrink,
 
 /**
  * jbd2_journal_shrink_count()
+ * @shrink: shrinker to work on
+ * @sc: reclaim request to process
  *
  * Count the number of checkpoint buffers on the checkpoint list.
  */
-- 
2.20.1.7.g153144c

