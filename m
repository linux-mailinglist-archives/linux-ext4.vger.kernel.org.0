Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3847E0106
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Nov 2023 11:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbjKCG6O (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 3 Nov 2023 02:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbjKCG6J (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 3 Nov 2023 02:58:09 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7DEE3
        for <linux-ext4@vger.kernel.org>; Thu,  2 Nov 2023 23:58:07 -0700 (PDT)
Received: from kwepemm000013.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SMBKZ739JzMmQ7;
        Fri,  3 Nov 2023 14:53:38 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm000013.china.huawei.com
 (7.193.23.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 3 Nov
 2023 14:58:01 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <tytso@mit.edu>, <jack@suse.com>
CC:     <linux-ext4@vger.kernel.org>, <chengzhihao1@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH 3/5] jbd2: Remove unused 'JBD2_CHECKPOINT_IO_ERROR' and 'j_atomic_flags'
Date:   Fri, 3 Nov 2023 22:52:48 +0800
Message-ID: <20231103145250.2995746-4-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231103145250.2995746-1-chengzhihao1@huawei.com>
References: <20231103145250.2995746-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.67]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm000013.china.huawei.com (7.193.23.81)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Since 'JBD2_CHECKPOINT_IO_ERROR' and j_atomic_flags' are not useful
anymore after fs dev's errseq is imported into jbd2, just remove them.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/jbd2/checkpoint.c | 11 -----------
 include/linux/jbd2.h | 11 -----------
 2 files changed, 22 deletions(-)

diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index 118699fff2f9..1c97e64c4784 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -556,7 +556,6 @@ int __jbd2_journal_remove_checkpoint(struct journal_head *jh)
 	struct transaction_chp_stats_s *stats;
 	transaction_t *transaction;
 	journal_t *journal;
-	struct buffer_head *bh = jh2bh(jh);
 
 	JBUFFER_TRACE(jh, "entry");
 
@@ -569,16 +568,6 @@ int __jbd2_journal_remove_checkpoint(struct journal_head *jh)
 
 	JBUFFER_TRACE(jh, "removing from transaction");
 
-	/*
-	 * If we have failed to write the buffer out to disk, the filesystem
-	 * may become inconsistent. We cannot abort the journal here since
-	 * we hold j_list_lock and we have to be careful about races with
-	 * jbd2_journal_destroy(). So mark the writeback IO error in the
-	 * journal here and we abort the journal later from a better context.
-	 */
-	if (buffer_write_io_error(bh))
-		set_bit(JBD2_CHECKPOINT_IO_ERROR, &journal->j_atomic_flags);
-
 	__buffer_unlink(jh);
 	jh->b_cp_transaction = NULL;
 	percpu_counter_dec(&journal->j_checkpoint_jh_count);
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 15798f88ade4..bdde776b90d9 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -755,11 +755,6 @@ struct journal_s
 	 */
 	unsigned long		j_flags;
 
-	/**
-	 * @j_atomic_flags: Atomic journaling state flags.
-	 */
-	unsigned long		j_atomic_flags;
-
 	/**
 	 * @j_errno:
 	 *
@@ -1403,12 +1398,6 @@ JBD2_FEATURE_INCOMPAT_FUNCS(fast_commit,	FAST_COMMIT)
 #define JBD2_JOURNAL_FLUSH_VALID	(JBD2_JOURNAL_FLUSH_DISCARD | \
 					JBD2_JOURNAL_FLUSH_ZEROOUT)
 
-/*
- * Journal atomic flag definitions
- */
-#define JBD2_CHECKPOINT_IO_ERROR	0x001	/* Detect io error while writing
-						 * buffer back to disk */
-
 /*
  * Function declarations for the journaling transaction and buffer
  * management
-- 
2.39.2

