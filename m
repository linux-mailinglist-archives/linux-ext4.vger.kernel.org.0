Return-Path: <linux-ext4+bounces-1802-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B35338936AD
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Apr 2024 03:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16DC7281E60
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Apr 2024 01:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD4510F1;
	Mon,  1 Apr 2024 01:15:29 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02C6623;
	Mon,  1 Apr 2024 01:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711934128; cv=none; b=TBCKmgTOtL/Nh6Dpd3IQZBjeN4hyImksGMT5SkVmIP9N7QnLwmMHTtkGg1oowIa2qHGDWPBZudAyENmaamKf66p+dnKAZBx/6OHkQgRF16YbFX3ViIyu+u9GOjYyyESa/Dwqe2xqUHONs8KeOCAQW92m9O5tAnsUMOWi0b0uLK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711934128; c=relaxed/simple;
	bh=fgQe0/aBIES9eFP65AXme2aY3ok9U8Xyc+o1r2tMMmE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NgDnfKZWmKJeU6rMO+gEo95+SUR+bHuIVPAJzLqTmJ0AJIk8kvkfenFLyLexLC6KdfjnRlJU6kv1vUcY5dd1vTXE/P489M2nQ71EU0lvTq1QuxZSaqYpinoUCV1i40DopAHXOUDJ7KTPSQiYgOORwueHPAwteiPtCKL5CxaBQbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4V7Chx0Sd7z1wp74;
	Mon,  1 Apr 2024 09:14:25 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id 62B001402D0;
	Mon,  1 Apr 2024 09:15:16 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 1 Apr
 2024 09:15:15 +0800
From: Ye Bin <yebin10@huawei.com>
To: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <jack@suse.cz>, Ye Bin
	<yebin10@huawei.com>
Subject: [PATCH] jbd2: use shrink_type type instead of bool type for __jbd2_journal_clean_checkpoint_list()
Date: Mon, 1 Apr 2024 09:16:14 +0800
Message-ID: <20240401011614.3650958-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500010.china.huawei.com (7.192.105.118)

"enum shrink_type" can clearly express the meaning of the parameter of
__jbd2_journal_clean_checkpoint_list(), and there is no need to use the
bool type.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/jbd2/checkpoint.c | 9 +++------
 fs/jbd2/commit.c     | 2 +-
 include/linux/jbd2.h | 4 +++-
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index 1c97e64c4784..d6e8b80a4078 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -337,8 +337,6 @@ int jbd2_cleanup_journal_tail(journal_t *journal)
 
 /* Checkpoint list management */
 
-enum shrink_type {SHRINK_DESTROY, SHRINK_BUSY_STOP, SHRINK_BUSY_SKIP};
-
 /*
  * journal_shrink_one_cp_list
  *
@@ -476,17 +474,16 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
  *
  * Called with j_list_lock held.
  */
-void __jbd2_journal_clean_checkpoint_list(journal_t *journal, bool destroy)
+void __jbd2_journal_clean_checkpoint_list(journal_t *journal,
+					  enum shrink_type type)
 {
 	transaction_t *transaction, *last_transaction, *next_transaction;
-	enum shrink_type type;
 	bool released;
 
 	transaction = journal->j_checkpoint_transactions;
 	if (!transaction)
 		return;
 
-	type = destroy ? SHRINK_DESTROY : SHRINK_BUSY_STOP;
 	last_transaction = transaction->t_cpprev;
 	next_transaction = transaction;
 	do {
@@ -527,7 +524,7 @@ void jbd2_journal_destroy_checkpoint(journal_t *journal)
 			spin_unlock(&journal->j_list_lock);
 			break;
 		}
-		__jbd2_journal_clean_checkpoint_list(journal, true);
+		__jbd2_journal_clean_checkpoint_list(journal, SHRINK_DESTROY);
 		spin_unlock(&journal->j_list_lock);
 		cond_resched();
 	}
diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 5e122586e06e..78ebd04ac97d 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -501,7 +501,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 	 * frees some memory
 	 */
 	spin_lock(&journal->j_list_lock);
-	__jbd2_journal_clean_checkpoint_list(journal, false);
+	__jbd2_journal_clean_checkpoint_list(journal, SHRINK_BUSY_STOP);
 	spin_unlock(&journal->j_list_lock);
 
 	jbd2_debug(3, "JBD2: commit phase 1\n");
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 971f3e826e15..58a961999d70 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1434,7 +1434,9 @@ void jbd2_update_log_tail(journal_t *journal, tid_t tid, unsigned long block);
 extern void jbd2_journal_commit_transaction(journal_t *);
 
 /* Checkpoint list management */
-void __jbd2_journal_clean_checkpoint_list(journal_t *journal, bool destroy);
+enum shrink_type {SHRINK_DESTROY, SHRINK_BUSY_STOP, SHRINK_BUSY_SKIP};
+
+void __jbd2_journal_clean_checkpoint_list(journal_t *journal, enum shrink_type type);
 unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal, unsigned long *nr_to_scan);
 int __jbd2_journal_remove_checkpoint(struct journal_head *);
 int jbd2_journal_try_remove_checkpoint(struct journal_head *jh);
-- 
2.31.1


