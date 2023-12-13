Return-Path: <linux-ext4+bounces-421-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CD08107E4
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Dec 2023 02:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB31B1C20E65
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Dec 2023 01:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C7B10EA;
	Wed, 13 Dec 2023 01:55:31 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A74BB0
	for <linux-ext4@vger.kernel.org>; Tue, 12 Dec 2023 17:55:28 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4SqdLB1NCkz1wngB;
	Wed, 13 Dec 2023 09:33:54 +0800 (CST)
Received: from kwepemm000013.china.huawei.com (unknown [7.193.23.81])
	by mail.maildlp.com (Postfix) with ESMTPS id CF2F01800C9;
	Wed, 13 Dec 2023 09:34:00 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm000013.china.huawei.com
 (7.193.23.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 13 Dec
 2023 09:33:58 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <tytso@mit.edu>, <jack@suse.com>
CC: <linux-ext4@vger.kernel.org>, <yi.zhang@huawei.com>
Subject: [PATCH v2 3/5] jbd2: Remove unused 'JBD2_CHECKPOINT_IO_ERROR' and 'j_atomic_flags'
Date: Wed, 13 Dec 2023 09:32:22 +0800
Message-ID: <20231213013224.2100050-4-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231213013224.2100050-1-chengzhihao1@huawei.com>
References: <20231213013224.2100050-1-chengzhihao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm000013.china.huawei.com (7.193.23.81)

Since 'JBD2_CHECKPOINT_IO_ERROR' and j_atomic_flags' are not useful
anymore after fs dev's errseq is imported into jbd2, just remove them.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
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
index cea1aa70ae36..971f3e826e15 100644
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
@@ -1406,12 +1401,6 @@ JBD2_FEATURE_INCOMPAT_FUNCS(fast_commit,	FAST_COMMIT)
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


