Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB7BBC141
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Sep 2019 07:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409021AbfIXFOG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 24 Sep 2019 01:14:06 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:45853 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404357AbfIXFOF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 24 Sep 2019 01:14:05 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01451;MF=xiaoguang.wang@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0TdH-Pbr_1569302039;
Received: from localhost(mailfrom:xiaoguang.wang@linux.alibaba.com fp:SMTPD_---0TdH-Pbr_1569302039)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 24 Sep 2019 13:14:04 +0800
From:   Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
To:     linux-ext4@vger.kernel.org
Cc:     Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Subject: [PATCH 2/3] jbd2: add new tracepoint jbd2_wait_on_transaction_locked
Date:   Tue, 24 Sep 2019 13:13:49 +0800
Message-Id: <20190924051350.1740-2-xiaoguang.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190924051350.1740-1-xiaoguang.wang@linux.alibaba.com>
References: <20190924051350.1740-1-xiaoguang.wang@linux.alibaba.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Sometimes process will be stalled in wait_transaction_locked() for a while,
also add a new tracepoint to track this delay.

Trace info likes below:
fsstress-1793  [009] ....   519.967867: jbd2_wait_on_transaction_locked: dev 254,17 latency(us) 73442
fsstress-1788  [002] ....   519.967877: jbd2_wait_on_transaction_locked: dev 254,17 latency(us) 75189
fsstress-1792  [012] ....   519.967882: jbd2_wait_on_transaction_locked: dev 254,17 latency(us) 148260
fsstress-1786  [011] ....   519.967885: jbd2_wait_on_transaction_locked: dev 254,17 latency(us) 143292
fsstress-1796  [004] ....   519.967889: jbd2_wait_on_transaction_locked: dev 254,17 latency(us) 147945
fsstress-1791  [015] ....   519.967892: jbd2_wait_on_transaction_locked: dev 254,17 latency(us) 148126
fsstress-1794  [009] ....   519.967938: jbd2_wait_on_transaction_locked: dev 254,17 latency(us) 148347
fsstress-1787  [003] ....   519.967990: jbd2_wait_on_transaction_locked: dev 254,17 latency(us) 148152
fsstress-1795  [004] ....   519.967999: jbd2_wait_on_transaction_locked: dev 254,17 latency(us) 141676
fsstress-1800  [000] ....   519.968001: jbd2_wait_on_transaction_locked: dev 254,17 latency(us) 148141

Signed-off-by: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
---
 fs/jbd2/transaction.c       |  3 +++
 include/trace/events/jbd2.h | 21 +++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 5d7a96e10133..6757911a4a17 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -148,6 +148,7 @@ static void wait_transaction_locked(journal_t *journal)
 	DEFINE_WAIT(wait);
 	int need_to_start;
 	tid_t tid = journal->j_running_transaction->t_tid;
+	s64 start_us = ktime_to_us(ktime_get());
 
 	prepare_to_wait(&journal->j_wait_transaction_locked, &wait,
 			TASK_UNINTERRUPTIBLE);
@@ -158,6 +159,8 @@ static void wait_transaction_locked(journal_t *journal)
 	jbd2_might_wait_for_commit(journal);
 	schedule();
 	finish_wait(&journal->j_wait_transaction_locked, &wait);
+	trace_jbd2_wait_on_transaction_locked(journal->j_fs_dev->bd_dev,
+		ktime_to_us(ktime_get()) - start_us);
 }
 
 /*
diff --git a/include/trace/events/jbd2.h b/include/trace/events/jbd2.h
index e42072c74ce9..f2eebd839bf2 100644
--- a/include/trace/events/jbd2.h
+++ b/include/trace/events/jbd2.h
@@ -401,6 +401,27 @@ TRACE_EVENT(jbd2_wait_on_shadow,
 		__entry->wait_us)
 );
 
+TRACE_EVENT(jbd2_wait_on_transaction_locked,
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

