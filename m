Return-Path: <linux-ext4+bounces-1912-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 850C489AEEF
	for <lists+linux-ext4@lfdr.de>; Sun,  7 Apr 2024 08:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 408782820D3
	for <lists+linux-ext4@lfdr.de>; Sun,  7 Apr 2024 06:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1294F101E2;
	Sun,  7 Apr 2024 06:53:12 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CE66FC7;
	Sun,  7 Apr 2024 06:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712472791; cv=none; b=Vt5lp/jbrPuyQqOsOAoGpN16DROXGr7zJJ4FY3hNnqlR8vFYM7bDWtUvhubkMM+fQ1LHMw91jQpvu+brSBScNl4K8RHGc+8dkLC5Ai1eTEvLuTE1x5H+IN2fLBpMe+y6fPfIn3SYklYXBQKLdpYO0jPKKfDkh4RJVRGTQjZLqTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712472791; c=relaxed/simple;
	bh=9u38Kun1oRcjRxoYAlK2yvfKhQ0kguE1q9nPQjC57MI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uSAAtL1AQSy0NL62OtU835nVOJ04D2+jRkro4kovOpZjlILC3MT4kxsA2c0qqNwrP1NL39IGGEvwunpE/saQM1hcNBhJSsuS8s1Y3f2Yb1hXIyWNFojb8LF98Cw8wrzIdUPKFDg+6yEoIklsf2x5+HwZmH51uI9rjhGW6sg4aJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VC2sv41j4ztRrk;
	Sun,  7 Apr 2024 14:50:27 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id DFB87140487;
	Sun,  7 Apr 2024 14:53:06 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sun, 7 Apr
 2024 14:53:06 +0800
From: Ye Bin <yebin10@huawei.com>
To: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <jack@suse.cz>, Ye Bin
	<yebin10@huawei.com>
Subject: [PATCH v2 2/2] jbd2: add prefix 'jbd2' for 'shrink_type'
Date: Sun, 7 Apr 2024 14:53:55 +0800
Message-ID: <20240407065355.1528580-3-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240407065355.1528580-1-yebin10@huawei.com>
References: <20240407065355.1528580-1-yebin10@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500010.china.huawei.com (7.192.105.118)

As 'shrink_type' is exported. The module prefix 'jbd2' is added to
distinguish from memory reclamation.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/jbd2/checkpoint.c | 22 +++++++++++-----------
 fs/jbd2/commit.c     |  2 +-
 include/linux/jbd2.h |  4 ++--
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index 80c0ab98bc63..951f78634adf 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -348,7 +348,7 @@ int jbd2_cleanup_journal_tail(journal_t *journal)
  * Called with j_list_lock held.
  */
 static unsigned long journal_shrink_one_cp_list(struct journal_head *jh,
-						enum shrink_type type,
+						enum jbd2_shrink_type type,
 						bool *released)
 {
 	struct journal_head *last_jh;
@@ -365,12 +365,12 @@ static unsigned long journal_shrink_one_cp_list(struct journal_head *jh,
 		jh = next_jh;
 		next_jh = jh->b_cpnext;
 
-		if (type == SHRINK_DESTROY) {
+		if (type == JBD2_SHRINK_DESTROY) {
 			ret = __jbd2_journal_remove_checkpoint(jh);
 		} else {
 			ret = jbd2_journal_try_remove_checkpoint(jh);
 			if (ret < 0) {
-				if (type == SHRINK_BUSY_SKIP)
+				if (type == JBD2_SHRINK_BUSY_SKIP)
 					continue;
 				break;
 			}
@@ -437,7 +437,7 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
 		tid = transaction->t_tid;
 
 		freed = journal_shrink_one_cp_list(transaction->t_checkpoint_list,
-						   SHRINK_BUSY_SKIP, &released);
+						   JBD2_SHRINK_BUSY_SKIP, &released);
 		nr_freed += freed;
 		(*nr_to_scan) -= min(*nr_to_scan, freed);
 		if (*nr_to_scan == 0)
@@ -470,20 +470,20 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
  * journal_clean_checkpoint_list
  *
  * Find all the written-back checkpoint buffers in the journal and release them.
- * If 'type' is SHRINK_DESTROY, release all buffers unconditionally. If 'type'
- * is SHRINK_BUSY_STOP, will stop release buffers if encounters a busy buffer.
- * To avoid wasting CPU cycles scanning the buffer list in some cases, don't
- * pass SHRINK_BUSY_SKIP 'type' for this function.
+ * If 'type' is JBD2_SHRINK_DESTROY, release all buffers unconditionally. If
+ * 'type' is JBD2_SHRINK_BUSY_STOP, will stop release buffers if encounters a
+ * busy buffer. To avoid wasting CPU cycles scanning the buffer list in some
+ * cases, don't pass JBD2_SHRINK_BUSY_SKIP 'type' for this function.
  *
  * Called with j_list_lock held.
  */
 void __jbd2_journal_clean_checkpoint_list(journal_t *journal,
-					  enum shrink_type type)
+					  enum jbd2_shrink_type type)
 {
 	transaction_t *transaction, *last_transaction, *next_transaction;
 	bool released;
 
-	WARN_ON_ONCE(type == SHRINK_BUSY_SKIP);
+	WARN_ON_ONCE(type == JBD2_SHRINK_BUSY_SKIP);
 
 	transaction = journal->j_checkpoint_transactions;
 	if (!transaction)
@@ -529,7 +529,7 @@ void jbd2_journal_destroy_checkpoint(journal_t *journal)
 			spin_unlock(&journal->j_list_lock);
 			break;
 		}
-		__jbd2_journal_clean_checkpoint_list(journal, SHRINK_DESTROY);
+		__jbd2_journal_clean_checkpoint_list(journal, JBD2_SHRINK_DESTROY);
 		spin_unlock(&journal->j_list_lock);
 		cond_resched();
 	}
diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 78ebd04ac97d..65c857ab49ec 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -501,7 +501,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 	 * frees some memory
 	 */
 	spin_lock(&journal->j_list_lock);
-	__jbd2_journal_clean_checkpoint_list(journal, SHRINK_BUSY_STOP);
+	__jbd2_journal_clean_checkpoint_list(journal, JBD2_SHRINK_BUSY_STOP);
 	spin_unlock(&journal->j_list_lock);
 
 	jbd2_debug(3, "JBD2: commit phase 1\n");
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 58a961999d70..7479f64c0939 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1434,9 +1434,9 @@ void jbd2_update_log_tail(journal_t *journal, tid_t tid, unsigned long block);
 extern void jbd2_journal_commit_transaction(journal_t *);
 
 /* Checkpoint list management */
-enum shrink_type {SHRINK_DESTROY, SHRINK_BUSY_STOP, SHRINK_BUSY_SKIP};
+enum jbd2_shrink_type {JBD2_SHRINK_DESTROY, JBD2_SHRINK_BUSY_STOP, JBD2_SHRINK_BUSY_SKIP};
 
-void __jbd2_journal_clean_checkpoint_list(journal_t *journal, enum shrink_type type);
+void __jbd2_journal_clean_checkpoint_list(journal_t *journal, enum jbd2_shrink_type type);
 unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal, unsigned long *nr_to_scan);
 int __jbd2_journal_remove_checkpoint(struct journal_head *);
 int jbd2_journal_try_remove_checkpoint(struct journal_head *jh);
-- 
2.31.1


