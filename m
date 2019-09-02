Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE02A59EE
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Sep 2019 16:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731731AbfIBO4I (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 2 Sep 2019 10:56:08 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:46049 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731676AbfIBO4I (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 2 Sep 2019 10:56:08 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=xiaoguang.wang@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0TbBQeIs_1567436137;
Received: from localhost(mailfrom:xiaoguang.wang@linux.alibaba.com fp:SMTPD_---0TbBQeIs_1567436137)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 02 Sep 2019 22:55:40 +0800
From:   Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
To:     linux-ext4@vger.kernel.org
Cc:     Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Subject: [PATCH 1/2] jbd2: add new tracepoint jbd2_sleep_on_shadow
Date:   Mon,  2 Sep 2019 22:54:41 +0800
Message-Id: <20190902145442.1921-1-xiaoguang.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Sometimes process will be stalled in "wait_on_bit_io(&bh->b_state,
BH_Shadow, TASK_UNINTERRUPTIBLE)" for a while, and in order to analyse
app's latency thoroughly, add a new tracepoint to track this delay.

Trace info likes below:
fsstress-5068  [008] .... 11007.757543: jbd2_sleep_on_shadow: dev 254,17 sleep 1
fsstress-5070  [007] .... 11007.757544: jbd2_sleep_on_shadow: dev 254,17 sleep 2
fsstress-5069  [009] .... 11007.757548: jbd2_sleep_on_shadow: dev 254,17 sleep 2
fsstress-5067  [011] .... 11007.757569: jbd2_sleep_on_shadow: dev 254,17 sleep 1
fsstress-5063  [007] .... 11007.757651: jbd2_sleep_on_shadow: dev 254,17 sleep 2
fsstress-5070  [007] .... 11007.757792: jbd2_sleep_on_shadow: dev 254,17 sleep 0
fsstress-5071  [011] .... 11007.763493: jbd2_sleep_on_shadow: dev 254,17 sleep 1

Signed-off-by: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
---
 fs/jbd2/transaction.c       |  3 +++
 include/trace/events/jbd2.h | 21 +++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 990e7b5062e7..84974fb9d4f9 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -991,7 +991,10 @@ do_get_write_access(handle_t *handle, struct journal_head *jh,
 	if (buffer_shadow(bh)) {
 		JBUFFER_TRACE(jh, "on shadow: sleep");
 		jbd_unlock_bh_state(bh);
+		start_lock = jiffies;
 		wait_on_bit_io(&bh->b_state, BH_Shadow, TASK_UNINTERRUPTIBLE);
+		trace_jbd2_sleep_on_shadow(bh->b_bdev->bd_dev,
+			jiffies_to_msecs(jiffies - start_lock));
 		goto repeat;
 	}
 
diff --git a/include/trace/events/jbd2.h b/include/trace/events/jbd2.h
index 2310b259329f..2f048fdb63c6 100644
--- a/include/trace/events/jbd2.h
+++ b/include/trace/events/jbd2.h
@@ -380,6 +380,27 @@ TRACE_EVENT(jbd2_lock_buffer_stall,
 		__entry->stall_ms)
 );
 
+TRACE_EVENT(jbd2_sleep_on_shadow,
+
+	TP_PROTO(dev_t dev, unsigned long stall_ms),
+
+	TP_ARGS(dev, stall_ms),
+
+	TP_STRUCT__entry(
+		__field(        dev_t, dev	)
+		__field(unsigned long, stall_ms	)
+	),
+
+	TP_fast_assign(
+		__entry->dev		= dev;
+		__entry->stall_ms	= stall_ms;
+	),
+
+	TP_printk("dev %d,%d sleep %lu",
+		MAJOR(__entry->dev), MINOR(__entry->dev),
+		__entry->stall_ms)
+);
+
 #endif /* _TRACE_JBD2_H */
 
 /* This part must be outside protection */
-- 
2.17.2

