Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE17BA14E
	for <lists+linux-ext4@lfdr.de>; Sun, 22 Sep 2019 09:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfIVHFR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 22 Sep 2019 03:05:17 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:47010 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727548AbfIVHFR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 22 Sep 2019 03:05:17 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=xiaoguang.wang@linux.alibaba.com;NM=1;PH=DS;RN=1;SR=0;TI=SMTPD_---0Td0uxnO_1569135907;
Received: from localhost(mailfrom:xiaoguang.wang@linux.alibaba.com fp:SMTPD_---0Td0uxnO_1569135907)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 22 Sep 2019 15:05:11 +0800
From:   Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 0/2] make jbd2 support checkpoint asynchronously
Date:   Sun, 22 Sep 2019 15:04:57 +0800
Message-Id: <20190922070459.39797-1-xiaoguang.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.14.4.44.g2045bb6
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In current jbd2's implemention, jbd2 won't reclaim journal space unless
free journal space is lower than specified threshold, see logic in
add_transaction_credits():
        write_lock(&journal->j_state_lock);
        if (jbd2_log_space_left(journal) < jbd2_space_needed(journal))
            __jbd2_log_wait_for_space(journal);
        write_unlock(&journal->j_state_lock);

Indeed with this logic, we can also have many transactions queued to be
checkpointd, which means these transactions still occupy jbd2 space.

Journal space is somewhat like a global lock. In high concurrency case,
if many tasks contend for journal credits, they will easily be blocked in
waitting for free journal space, so I wonder whether we can reclaim journal
space asynchronously when free space is lower than a specified threshold,
to avoid that all applications are stalled at the same time. This will be
more useful in high speed store, journal space will be reclaimed in background
quickly, and applications will less likely to be stucked,  to improve this
case, we use workqueue to queue a work in background to reclaim journal space.

I have used fs_mark to have performance test, in most cases, we have performance
improvement, in specific case, we can have above 14.4% improvement, see patch
"ext4: add async_checkpoint mount option" for detailed test info.

Xiaoguang Wang (2):
  jbd2: checkpoint asynchronously when free journal space is lower than
    threshold
  ext4: add async_checkpoint mount option

 fs/ext4/ext4.h        |  2 ++
 fs/ext4/super.c       | 71 +++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/jbd2/checkpoint.c  | 28 +++++++++++++++++---
 fs/jbd2/journal.c     | 15 +++++++++--
 fs/jbd2/transaction.c | 16 ++++++++++++
 include/linux/jbd2.h  | 48 +++++++++++++++++++++++++++++++++-
 6 files changed, 174 insertions(+), 6 deletions(-)

-- 
1.8.3.1

