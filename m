Return-Path: <linux-ext4+bounces-5730-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D33C9F5EF2
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Dec 2024 07:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14F3C189599F
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Dec 2024 06:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44DB16C451;
	Wed, 18 Dec 2024 06:56:16 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B831553BC;
	Wed, 18 Dec 2024 06:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734504976; cv=none; b=Yv69GlZctphXMTmCC9z0QmRdO8DcDPDkk4o5q2RRg5lVHRN/54Ukyvc6b5+cIKxP2J9ansYstp8wQHbuPlkj/HlxqYXcx5e952Knd/6Rd8eMyX0u0sn6JaNU3jxxRa+itCh6hh3gDSSNmgNrvpgfPApnYRFFzcB3Duqvj2Fzuzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734504976; c=relaxed/simple;
	bh=7l9G64VWetpVFn2IumQ7Qjux/s1oI+woe20zsQhebLs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ouR0R+SCQkhCpS1iECEazmwp96ZclJnYO9luFuhrJn2OHbMD+2lEVIFyrbmC1qvvd8Km71dTA+HeMJ5mQwbhzJsA6UympjsFPgv05V6aLPe9rCJohapiUKMxdF1fMCA4f60IjlTUEdv9brqIdDHaNk2JMImUazi8Q2Q9L0ks+Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YCkwQ0dgHz4f3kG6;
	Wed, 18 Dec 2024 14:55:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 8DD791A06D7;
	Wed, 18 Dec 2024 14:56:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP3 (Coremail) with SMTP id _Ch0CgCnhMEHcmJnLjMnEw--.53472S3;
	Wed, 18 Dec 2024 14:56:09 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: corbet@lwn.net,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.com
Cc: dennis.lamerice@gmail.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH v2 1/3] ext4: remove unused ext4 journal callback
Date: Wed, 18 Dec 2024 22:54:12 +0800
Message-Id: <20241218145414.1422946-2-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241218145414.1422946-1-shikemeng@huaweicloud.com>
References: <20241218145414.1422946-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgCnhMEHcmJnLjMnEw--.53472S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZr4fKw1kXFW7KFy7trWUurg_yoWrKFWDpF
	y3uw1xCry8ZF17ua1xXr48XFW29wsYkFyUGryxCF9Ykw4Y9r1xtFyDta40yay5tFWruFs8
	Z3WjywnrGrWvk3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxV
	WUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUVSdy
	UUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Remove unused ext4 journal callback.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4_jbd2.h | 84 ---------------------------------------------
 fs/ext4/super.c     | 14 --------
 2 files changed, 98 deletions(-)

diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
index 0c77697d5e90..3f2596c9e5f2 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -122,90 +122,6 @@
 #define EXT4_HT_EXT_CONVERT     11
 #define EXT4_HT_MAX             12
 
-/**
- *   struct ext4_journal_cb_entry - Base structure for callback information.
- *
- *   This struct is a 'seed' structure for a using with your own callback
- *   structs. If you are using callbacks you must allocate one of these
- *   or another struct of your own definition which has this struct
- *   as it's first element and pass it to ext4_journal_callback_add().
- */
-struct ext4_journal_cb_entry {
-	/* list information for other callbacks attached to the same handle */
-	struct list_head jce_list;
-
-	/*  Function to call with this callback structure */
-	void (*jce_func)(struct super_block *sb,
-			 struct ext4_journal_cb_entry *jce, int error);
-
-	/* user data goes here */
-};
-
-/**
- * ext4_journal_callback_add: add a function to call after transaction commit
- * @handle: active journal transaction handle to register callback on
- * @func: callback function to call after the transaction has committed:
- *        @sb: superblock of current filesystem for transaction
- *        @jce: returned journal callback data
- *        @rc: journal state at commit (0 = transaction committed properly)
- * @jce: journal callback data (internal and function private data struct)
- *
- * The registered function will be called in the context of the journal thread
- * after the transaction for which the handle was created has completed.
- *
- * No locks are held when the callback function is called, so it is safe to
- * call blocking functions from within the callback, but the callback should
- * not block or run for too long, or the filesystem will be blocked waiting for
- * the next transaction to commit. No journaling functions can be used, or
- * there is a risk of deadlock.
- *
- * There is no guaranteed calling order of multiple registered callbacks on
- * the same transaction.
- */
-static inline void _ext4_journal_callback_add(handle_t *handle,
-			struct ext4_journal_cb_entry *jce)
-{
-	/* Add the jce to transaction's private list */
-	list_add_tail(&jce->jce_list, &handle->h_transaction->t_private_list);
-}
-
-static inline void ext4_journal_callback_add(handle_t *handle,
-			void (*func)(struct super_block *sb,
-				     struct ext4_journal_cb_entry *jce,
-				     int rc),
-			struct ext4_journal_cb_entry *jce)
-{
-	struct ext4_sb_info *sbi =
-			EXT4_SB(handle->h_transaction->t_journal->j_private);
-
-	/* Add the jce to transaction's private list */
-	jce->jce_func = func;
-	spin_lock(&sbi->s_md_lock);
-	_ext4_journal_callback_add(handle, jce);
-	spin_unlock(&sbi->s_md_lock);
-}
-
-
-/**
- * ext4_journal_callback_del: delete a registered callback
- * @handle: active journal transaction handle on which callback was registered
- * @jce: registered journal callback entry to unregister
- * Return true if object was successfully removed
- */
-static inline bool ext4_journal_callback_try_del(handle_t *handle,
-					     struct ext4_journal_cb_entry *jce)
-{
-	bool deleted;
-	struct ext4_sb_info *sbi =
-			EXT4_SB(handle->h_transaction->t_journal->j_private);
-
-	spin_lock(&sbi->s_md_lock);
-	deleted = !list_empty(&jce->jce_list);
-	list_del_init(&jce->jce_list);
-	spin_unlock(&sbi->s_md_lock);
-	return deleted;
-}
-
 int
 ext4_mark_iloc_dirty(handle_t *handle,
 		     struct inode *inode,
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index a09f4621b10d..8dfda41dabaa 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -502,25 +502,11 @@ static void ext4_maybe_update_superblock(struct super_block *sb)
 static void ext4_journal_commit_callback(journal_t *journal, transaction_t *txn)
 {
 	struct super_block		*sb = journal->j_private;
-	struct ext4_sb_info		*sbi = EXT4_SB(sb);
-	int				error = is_journal_aborted(journal);
-	struct ext4_journal_cb_entry	*jce;
 
 	BUG_ON(txn->t_state == T_FINISHED);
 
 	ext4_process_freed_data(sb, txn->t_tid);
 	ext4_maybe_update_superblock(sb);
-
-	spin_lock(&sbi->s_md_lock);
-	while (!list_empty(&txn->t_private_list)) {
-		jce = list_entry(txn->t_private_list.next,
-				 struct ext4_journal_cb_entry, jce_list);
-		list_del_init(&jce->jce_list);
-		spin_unlock(&sbi->s_md_lock);
-		jce->jce_func(sb, jce, error);
-		spin_lock(&sbi->s_md_lock);
-	}
-	spin_unlock(&sbi->s_md_lock);
 }
 
 /*
-- 
2.30.0


