Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9D954749D
	for <lists+linux-ext4@lfdr.de>; Sat, 11 Jun 2022 14:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbiFKMvW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 11 Jun 2022 08:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233328AbiFKMvV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 11 Jun 2022 08:51:21 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8415AD9
        for <linux-ext4@vger.kernel.org>; Sat, 11 Jun 2022 05:51:20 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LKyMT4MM0zgYSK;
        Sat, 11 Jun 2022 20:49:25 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 11 Jun
 2022 20:51:18 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH] jbd2: fix outstanding credits assert in jbd2_journal_commit_transaction()
Date:   Sat, 11 Jun 2022 21:04:26 +0800
Message-ID: <20220611130426.2013258-1-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

We catch an assert problem in jbd2_journal_commit_transaction() when
doing fsstress and request falut injection tests. The problem is
happened in a race condition between jbd2_journal_commit_transaction()
and ext4_end_io_end(). Firstly, ext4_writepages() writeback dirty pages
and start reserved handle, and then the journal was aborted due to some
previous metadata IO error, jbd2_journal_abort() start to commit current
running transaction, the committing procedure could be raced by
ext4_end_io_end() and lead to subtract j_reserved_credits twice from
commit_transaction->t_outstanding_credits, finally the
t_outstanding_credits is mistakenly smaller than t_nr_buffers and
trigger assert.

kjournald2           kworker

jbd2_journal_commit_transaction()
 write_unlock(&journal->j_state_lock);
 atomic_sub(j_reserved_credits, t_outstanding_credits); //sub once

     	             jbd2_journal_start_reserved()
     	              start_this_handle()  //detect aborted journal
     	              jbd2_journal_free_reserved()  //get running transaction
                       read_lock(&journal->j_state_lock)
     	                __jbd2_journal_unreserve_handle()
     	               atomic_sub(j_reserved_credits, t_outstanding_credits);
                       //sub again
                       read_unlock(&journal->j_state_lock);

 journal->j_running_transaction = NULL;
 J_ASSERT(t_nr_buffers <= t_outstanding_credits) //bomb!!!

Fix this issue by using journal->j_state_lock to protect the subtraction
in jbd2_journal_commit_transaction().

Fixes: 96f1e0974575 ("jbd2: avoid long hold times of j_state_lock while committing a transaction")
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/jbd2/commit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index eb315e81f1a6..af1a9191368c 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -553,13 +553,13 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 	 */
 	jbd2_journal_switch_revoke_table(journal);
 
+	write_lock(&journal->j_state_lock);
 	/*
 	 * Reserved credits cannot be claimed anymore, free them
 	 */
 	atomic_sub(atomic_read(&journal->j_reserved_credits),
 		   &commit_transaction->t_outstanding_credits);
 
-	write_lock(&journal->j_state_lock);
 	trace_jbd2_commit_flushing(journal, commit_transaction);
 	stats.run.rs_flushing = jiffies;
 	stats.run.rs_locked = jbd2_time_diff(stats.run.rs_locked,
-- 
2.31.1

