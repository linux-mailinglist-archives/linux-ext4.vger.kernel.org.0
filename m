Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 221818ED35
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Aug 2019 15:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732472AbfHONpA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Aug 2019 09:45:00 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:45209 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732183AbfHONpA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 15 Aug 2019 09:45:00 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=xiaoguang.wang@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0TZYSK4q_1565876692;
Received: from localhost(mailfrom:xiaoguang.wang@linux.alibaba.com fp:SMTPD_---0TZYSK4q_1565876692)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 15 Aug 2019 21:44:57 +0800
From:   Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
To:     linux-ext4@vger.kernel.org
Cc:     Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Subject: [PATCH] jbd2: add missing tracepoint for reserved handle
Date:   Thu, 15 Aug 2019 21:44:46 +0800
Message-Id: <20190815134446.28547-1-xiaoguang.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This issue was found when I use ebpf to trace every jbd2
handle's running info in dioread_nolock case.

Signed-off-by: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
---
 fs/jbd2/transaction.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 990e7b5062e7..afc06daee5bb 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -569,6 +569,9 @@ int jbd2_journal_start_reserved(handle_t *handle, unsigned int type,
 	}
 	handle->h_type = type;
 	handle->h_line_no = line_no;
+	trace_jbd2_handle_start(journal->j_fs_dev->bd_dev,
+				handle->h_transaction->t_tid, type,
+				line_no, handle->h_buffer_credits);
 	return 0;
 }
 EXPORT_SYMBOL(jbd2_journal_start_reserved);
-- 
2.17.2

