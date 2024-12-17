Return-Path: <linux-ext4+bounces-5679-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AE19F4187
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Dec 2024 05:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44D0D7A2BD5
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Dec 2024 04:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEF3149DE8;
	Tue, 17 Dec 2024 04:05:54 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43BB82488;
	Tue, 17 Dec 2024 04:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734408354; cv=none; b=VyBJIy2d2Bxja6TvvzNotAlFOZs5E6AfcTCP0ZVn3jQkXRJ/9K5kghOdOVR/0pGQODGC8soPr8IpnUBSmOrisqJYre9gqtZtdfzC+EH00xWaZWVX/3PyeblJc/ME/MgowYQbhvK9QulOPD0vKERq2MgdaSbmUnmmvWUr0qcMVIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734408354; c=relaxed/simple;
	bh=zsBjrPBlWT7LN4DqDUcHUI9bIz2oiMq7jJqKNSEpNRM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lzqtnYYWNuQnGdyOaGNCdct+29mEu+LPhuBpGlAJl8v8A1gZcS+cvFZ0tU4fjEz9akIhWceNchTIoOB3ucp2j5LOXQEuwumdMOXfyTZwUHPa3d1I63z6ZHaqR4aXzYswQVAVVaXPYpXPD+HkX3ts3E1GSpjWEBqjxtmAHxFr+Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YC3BH5Jdzz4f3lWG;
	Tue, 17 Dec 2024 12:05:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 3CC161A0359;
	Tue, 17 Dec 2024 12:05:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP3 (Coremail) with SMTP id _Ch0CgB3VsOb+GBnwxC_Eg--.2804S3;
	Tue, 17 Dec 2024 12:05:48 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.com
Cc: dennis.lamerice@gmail.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH 1/3] ext4: remove unused ext4 journal callback
Date: Tue, 17 Dec 2024 20:03:54 +0800
Message-Id: <20241217120356.1399443-2-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241217120356.1399443-1-shikemeng@huaweicloud.com>
References: <20241217120356.1399443-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgB3VsOb+GBnwxC_Eg--.2804S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAF48Cw4fCFW8WF4rtw17GFg_yoWrKrWDpr
	y3uw1xCrW8ZF17ua1xJr48XFW29wsYkFyUGryxCF9Ykws09w1xtFyDta40yFW5tFWruFs8
	Z3WjywnrGrWvk3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxV
	WUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jV_M-U
	UUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Remove unused ext4 journal callback.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
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


