Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAAF4BC142
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Sep 2019 07:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409024AbfIXFOL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 24 Sep 2019 01:14:11 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:49765 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404357AbfIXFOK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 24 Sep 2019 01:14:10 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=xiaoguang.wang@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0TdH8ZPI_1569302045;
Received: from localhost(mailfrom:xiaoguang.wang@linux.alibaba.com fp:SMTPD_---0TdH8ZPI_1569302045)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 24 Sep 2019 13:14:06 +0800
From:   Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
To:     linux-ext4@vger.kernel.org
Cc:     Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Subject: [PATCH 3/3] jbd2: add new tracepoint jbd2_wait_on_credits
Date:   Tue, 24 Sep 2019 13:13:50 +0800
Message-Id: <20190924051350.1740-3-xiaoguang.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190924051350.1740-1-xiaoguang.wang@linux.alibaba.com>
References: <20190924051350.1740-1-xiaoguang.wang@linux.alibaba.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In current jbd2's implemention, jbd2 won't reclaim journal space unless
free journal space is lower than specified threshold, sometimes there'll
be many processes blocked on waiting for free journal space, so here
also add a tracepoint to trace this delay:

Trace info likes below:
rm-1609  [012] ....   232.134012: jbd2_wait_on_credits: dev 254,17 latency(us) 30249
rm-1609  [012] ....   232.540123: jbd2_wait_on_credits: dev 254,17 latency(us) 45491
rm-1609  [012] ....   233.074011: jbd2_wait_on_credits: dev 254,17 latency(us) 111308
rm-1609  [012] ....   233.798669: jbd2_wait_on_credits: dev 254,17 latency(us) 54398
rm-1609  [011] ....   234.311211: jbd2_wait_on_credits: dev 254,17 latency(us) 48049
rm-1609  [011] ....   234.917501: jbd2_wait_on_credits: dev 254,17 latency(us) 51491
rm-1609  [011] ....   235.776268: jbd2_wait_on_credits: dev 254,17 latency(us) 51248

Signed-off-by: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
---
 fs/jbd2/transaction.c       |  6 +++++-
 include/trace/events/jbd2.h | 20 ++++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 6757911a4a17..15f613ae32de 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -266,8 +266,12 @@ static int add_transaction_credits(journal_t *journal, int blocks,
 		read_unlock(&journal->j_state_lock);
 		jbd2_might_wait_for_commit(journal);
 		write_lock(&journal->j_state_lock);
-		if (jbd2_log_space_left(journal) < jbd2_space_needed(journal))
+		if (jbd2_log_space_left(journal) < jbd2_space_needed(journal)) {
+			s64 start_us = ktime_to_us(ktime_get());
 			__jbd2_log_wait_for_space(journal);
+			trace_jbd2_wait_on_credits(journal->j_fs_dev->bd_dev,
+				ktime_to_us(ktime_get()) - start_us);
+		}
 		write_unlock(&journal->j_state_lock);
 		return 1;
 	}
diff --git a/include/trace/events/jbd2.h b/include/trace/events/jbd2.h
index f2eebd839bf2..108f320ef362 100644
--- a/include/trace/events/jbd2.h
+++ b/include/trace/events/jbd2.h
@@ -422,6 +422,26 @@ TRACE_EVENT(jbd2_wait_on_transaction_locked,
 		__entry->wait_us)
 );
 
+TRACE_EVENT(jbd2_wait_on_credits,
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
 #endif /* _TRACE_JBD2_H */
 
 /* This part must be outside protection */
-- 
2.17.2

