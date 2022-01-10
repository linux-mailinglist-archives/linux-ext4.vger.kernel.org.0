Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1BEB488ECF
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Jan 2022 04:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbiAJDCe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 9 Jan 2022 22:02:34 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:60161 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232735AbiAJDCd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 9 Jan 2022 22:02:33 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V1L7Dv1_1641783751;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V1L7Dv1_1641783751)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 10 Jan 2022 11:02:31 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     tytso@mit.edu
Cc:     jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] ext4: Fix jbd2_journal_shrink_scan() and jbd2_journal_shrink_count() kernel-doc comment
Date:   Mon, 10 Jan 2022 11:02:29 +0800
Message-Id: <20220110030229.19864-1-yang.lee@linux.alibaba.com>
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
index f13d548e4a7f..951e6382a884 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1287,6 +1287,8 @@ static int jbd2_min_tag_size(void)
 
 /**
  * jbd2_journal_shrink_scan()
+ * @shrink: A callback you can register to apply pressure to ageable caches.
+ * @sc: pass information from page reclaim to the shrinkers.
  *
  * Scan the checkpointed buffer on the checkpoint list and release the
  * journal_head.
@@ -1312,6 +1314,8 @@ static unsigned long jbd2_journal_shrink_scan(struct shrinker *shrink,
 
 /**
  * jbd2_journal_shrink_count()
+ * @shrink: A callback you can register to apply pressure to ageable caches.
+ * @sc: pass information from page reclaim to the shrinkers.
  *
  * Count the number of checkpoint buffers on the checkpoint list.
  */
-- 
2.20.1.7.g153144c

