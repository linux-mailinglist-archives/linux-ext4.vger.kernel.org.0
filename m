Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7303CBC140
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Sep 2019 07:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408752AbfIXFOE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 24 Sep 2019 01:14:04 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:43293 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404357AbfIXFOE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 24 Sep 2019 01:14:04 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=xiaoguang.wang@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0TdGsAAP_1569302037;
Received: from localhost(mailfrom:xiaoguang.wang@linux.alibaba.com fp:SMTPD_---0TdGsAAP_1569302037)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 24 Sep 2019 13:13:58 +0800
From:   Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
To:     linux-ext4@vger.kernel.org
Cc:     Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Subject: [PATCH 1/3] jbd2: add new tracepoint jbd2_wait_on_shadow
Date:   Tue, 24 Sep 2019 13:13:48 +0800
Message-Id: <20190924051350.1740-1-xiaoguang.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Sometimes process will be stalled in "wait_on_bit_io(&bh->b_state,
BH_Shadow, TASK_UNINTERRUPTIBLE)" for a while, and in order to analyse
app's latency thoroughly, add a new tracepoint to track this delay.

Trace info likes below:
kworker/u32:1-100   [004] ....   690.217690: jbd2_wait_on_shadow: dev 254,17 latency(us) 3363
fsstress-2139  [013] ....   690.217830: jbd2_wait_on_shadow: dev 254,17 latency(us) 2403
fsstress-2130  [005] ....   690.218241: jbd2_wait_on_shadow: dev 254,17 latency(us) 3589
fsstress-2131  [009] ....   690.230933: jbd2_wait_on_shadow: dev 254,17 latency(us) 11799
fsstress-2132  [007] ....   690.230961: jbd2_wait_on_shadow: dev 254,17 latency(us) 11540
fsstress-2130  [005] ....   690.230965: jbd2_wait_on_shadow: dev 254,17 latency(us) 3577
fsstress-2139  [005] ....   690.230979: jbd2_wait_on_shadow: dev 254,17 latency(us) 11716
fsstress-2137  [003] ....   690.230980: jbd2_wait_on_shadow: dev 254,17 latency(us) 836
fsstress-2133  [015] ....   690.230981: jbd2_wait_on_shadow: dev 254,17 latency(us) 11341
fsstress-2130  [005] ....   690.230988: jbd2_wait_on_shadow: dev 254,17 latency(us) 21

Signed-off-by: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
---
 fs/jbd2/transaction.c       |  4 ++++
 include/trace/events/jbd2.h | 21 +++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index afc06daee5bb..5d7a96e10133 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -864,6 +864,7 @@ do_get_write_access(handle_t *handle, struct journal_head *jh,
 	int error;
 	char *frozen_buffer = NULL;
 	unsigned long start_lock, time_lock;
+	s64 start_us;
 
 	if (is_handle_aborted(handle))
 		return -EROFS;
@@ -994,7 +995,10 @@ do_get_write_access(handle_t *handle, struct journal_head *jh,
 	if (buffer_shadow(bh)) {
 		JBUFFER_TRACE(jh, "on shadow: sleep");
 		jbd_unlock_bh_state(bh);
+		start_us = ktime_to_us(ktime_get());
 		wait_on_bit_io(&bh->b_state, BH_Shadow, TASK_UNINTERRUPTIBLE);
+		trace_jbd2_wait_on_shadow(bh->b_bdev->bd_dev,
+			ktime_to_us(ktime_get()) - start_us);
 		goto repeat;
 	}
 
diff --git a/include/trace/events/jbd2.h b/include/trace/events/jbd2.h
index 2310b259329f..e42072c74ce9 100644
--- a/include/trace/events/jbd2.h
+++ b/include/trace/events/jbd2.h
@@ -380,6 +380,27 @@ TRACE_EVENT(jbd2_lock_buffer_stall,
 		__entry->stall_ms)
 );
 
+TRACE_EVENT(jbd2_wait_on_shadow,
+
+	TP_PROTO(dev_t dev, unsigned long wait_us),
+
+	TP_ARGS(dev, wait_us),
+
+	TP_STRUCT__entry(
+		__field(        dev_t, dev	)
+		__field(unsigned long, wait_us	)
+	),
+
+	TP_fast_assign(
+		__entry->dev		= dev;
+		__entry->wait_us	= wait_us;
+	),
+
+	TP_printk("dev %d,%d latency(us) %lu",
+		MAJOR(__entry->dev), MINOR(__entry->dev),
+		__entry->wait_us)
+);
+
 #endif /* _TRACE_JBD2_H */
 
 /* This part must be outside protection */
-- 
2.17.2

