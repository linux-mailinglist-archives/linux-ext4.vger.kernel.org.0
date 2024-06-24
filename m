Return-Path: <linux-ext4+bounces-2941-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C8A9154F0
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Jun 2024 19:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1F1DB23809
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Jun 2024 17:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA07619EEAE;
	Mon, 24 Jun 2024 17:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XAPz6vXx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XM5cD5ql"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF0E19AD75;
	Mon, 24 Jun 2024 17:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719248491; cv=none; b=QeSfv9YfMDithm4uzlHxXw5WhnnJ7PdT1hxWjhXrbN0N2YJid9+DfGC7lwViHiGRRsCYwC3l+FHBshYnk/fpB8W9nrvKdyipwjQwYbHyh84GBUav2e3kLbCf56SdZtOCt47SM26Mg4mwigeXzlX8WcagU6qUHQ16W5rpcOf1lnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719248491; c=relaxed/simple;
	bh=fFnyzVSlsFI0H/ML7B4e66hMjdke35wJBIr5HvuT1aM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tHNexqHm5x9nyklh/bfr/1ZJ9jfrSGkt2AVNC7JNWnNUIUPtWagdRpNxubdWgsX3N4odAxNEsP+wNtO/Huwp7Dp0v1FXzYuwVHy/zjKJCX46IlBOs5HNv9yrrbX6blDFSUGSCSBxcrt3RqXOGdxdzzmSc0Wnmbhm4xIxwAdEh0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XAPz6vXx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XM5cD5ql; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 008C61F7A4;
	Mon, 24 Jun 2024 17:01:28 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719248488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/88/KCdJCX9ftms4ntn5nwFdqwnTUZ0F408kRgBKjsU=;
	b=XAPz6vXxG+nHrVE34AZp0bJQvuOMgVbX9Kxi2QHD9aTMFHRZFtcQGL0GXCvOZI4qKP+fq4
	vBgWQL0HrHhLDkNj0iF6rZJiP5sxTYQGKxeu7uNSAOl8Sp42FkdT+W0g6Sd1qkjP74aLQS
	l2K/bb7XLOrGLqOXduX14Kq/1OJAxvw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719248488;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/88/KCdJCX9ftms4ntn5nwFdqwnTUZ0F408kRgBKjsU=;
	b=XM5cD5qlvu9lEp3GRvhWud4EEyWewE7K7EGH+4sxmS+vNBfNGI+2Ed/y3abzmOPu/yQTXr
	rsVDNQOlwI4YZiDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E5B1113ACF;
	Mon, 24 Jun 2024 17:01:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id f5XQN2emeWbKOAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 24 Jun 2024 17:01:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 87423A08CB; Mon, 24 Jun 2024 19:01:27 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Ted Tso <tytso@mit.edu>
Cc: <linux-ext4@vger.kernel.org>,
	Alexander Coffin <alex.coffin@maticrobots.com>,
	Jan Kara <jack@suse.cz>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/4] jbd2: Precompute number of transaction descriptor blocks
Date: Mon, 24 Jun 2024 19:01:18 +0200
Message-Id: <20240624170127.3253-2-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240624165406.12784-1-jack@suse.cz>
References: <20240624165406.12784-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7234; i=jack@suse.cz; h=from:subject; bh=fFnyzVSlsFI0H/ML7B4e66hMjdke35wJBIr5HvuT1aM=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBmeaZeaBxk1D7WF5ZG2Se+kZNwVKnx6Jwmq6FESV2z nFbLy5iJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZnmmXgAKCRCcnaoHP2RA2c9VB/ 9Co8ZwX8hj5Dhl2Zm1VJCjrFf56ri6xqnbc7vKDu/1yFY4oIPinhbIUcufmMT63eLqbBMihENyIW7S K2D+omImup/9kKpsh80hxv63POsBAWUXANkrsCwCCR2GkuLvdXlyURHyRajdMjKPbT/abIdKhlUvM2 fXMjP/JDd3H37naHomisP3+kvWwagU3E0Ehh3Jh5w4V6zvQlmMO8MJEZc7/g9rlmvHTJPXNkDNbpcS ZsfAGd4ivRqyBO91Pn829YUwbpqHPZIgEYEI/IE4oBZSdV4VB+2hxqx1FAL1DVsSPAHcviIjfQMCtb BgfhG8ooRHhSCt9laVJ25536M53tNH
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: 008C61F7A4
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Instead of computing the number of descriptor blocks a transaction can
have each time we need it (which is currently when starting each
transaction but will become more frequent later) precompute the number
once during journal initialization together with maximum transaction
size. We perform the precomputation whenever journal feature set is
updated similarly as for computation of
journal->j_revoke_records_per_block.

CC: stable@vger.kernel.org
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/journal.c     | 61 ++++++++++++++++++++++++++++++++-----------
 fs/jbd2/transaction.c | 24 +----------------
 include/linux/jbd2.h  |  7 +++++
 3 files changed, 54 insertions(+), 38 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 1bb73750d307..ae5b544ed0cc 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1451,6 +1451,48 @@ static int journal_revoke_records_per_block(journal_t *journal)
 	return space / record_size;
 }
 
+static int jbd2_journal_get_max_txn_bufs(journal_t *journal)
+{
+	return (journal->j_total_len - journal->j_fc_wbufsize) / 4;
+}
+
+/*
+ * Base amount of descriptor blocks we reserve for each transaction.
+ */
+static int jbd2_descriptor_blocks_per_trans(journal_t *journal)
+{
+	int tag_space = journal->j_blocksize - sizeof(journal_header_t);
+	int tags_per_block;
+
+	/* Subtract UUID */
+	tag_space -= 16;
+	if (jbd2_journal_has_csum_v2or3(journal))
+		tag_space -= sizeof(struct jbd2_journal_block_tail);
+	/* Commit code leaves a slack space of 16 bytes at the end of block */
+	tags_per_block = (tag_space - 16) / journal_tag_bytes(journal);
+	/*
+	 * Revoke descriptors are accounted separately so we need to reserve
+	 * space for commit block and normal transaction descriptor blocks.
+	 */
+	return 1 + DIV_ROUND_UP(jbd2_journal_get_max_txn_bufs(journal),
+				tags_per_block);
+}
+
+/*
+ * Initialize number of blocks each transaction reserves for its bookkeeping
+ * and maximum number of blocks a transaction can use. This needs to be called
+ * after the journal size and the fastcommit area size are initialized.
+ */
+static void jbd2_journal_init_transaction_limits(journal_t *journal)
+{
+	journal->j_revoke_records_per_block =
+				journal_revoke_records_per_block(journal);
+	journal->j_transaction_overhead_buffers =
+				jbd2_descriptor_blocks_per_trans(journal);
+	journal->j_max_transaction_buffers =
+				jbd2_journal_get_max_txn_bufs(journal);
+}
+
 /*
  * Load the on-disk journal superblock and read the key fields into the
  * journal_t.
@@ -1492,8 +1534,8 @@ static int journal_load_superblock(journal_t *journal)
 	if (jbd2_journal_has_csum_v2or3(journal))
 		journal->j_csum_seed = jbd2_chksum(journal, ~0, sb->s_uuid,
 						   sizeof(sb->s_uuid));
-	journal->j_revoke_records_per_block =
-				journal_revoke_records_per_block(journal);
+	/* After journal features are set, we can compute transaction limits */
+	jbd2_journal_init_transaction_limits(journal);
 
 	if (jbd2_has_feature_fast_commit(journal)) {
 		journal->j_fc_last = be32_to_cpu(sb->s_maxlen);
@@ -1698,11 +1740,6 @@ journal_t *jbd2_journal_init_inode(struct inode *inode)
 	return journal;
 }
 
-static int jbd2_journal_get_max_txn_bufs(journal_t *journal)
-{
-	return (journal->j_total_len - journal->j_fc_wbufsize) / 4;
-}
-
 /*
  * Given a journal_t structure, initialise the various fields for
  * startup of a new journaling session.  We use this both when creating
@@ -1748,8 +1785,6 @@ static int journal_reset(journal_t *journal)
 	journal->j_commit_sequence = journal->j_transaction_sequence - 1;
 	journal->j_commit_request = journal->j_commit_sequence;
 
-	journal->j_max_transaction_buffers = jbd2_journal_get_max_txn_bufs(journal);
-
 	/*
 	 * Now that journal recovery is done, turn fast commits off here. This
 	 * way, if fast commit was enabled before the crash but if now FS has
@@ -2290,8 +2325,6 @@ jbd2_journal_initialize_fast_commit(journal_t *journal)
 	journal->j_fc_first = journal->j_last + 1;
 	journal->j_fc_off = 0;
 	journal->j_free = journal->j_last - journal->j_first;
-	journal->j_max_transaction_buffers =
-		jbd2_journal_get_max_txn_bufs(journal);
 
 	return 0;
 }
@@ -2379,8 +2412,7 @@ int jbd2_journal_set_features(journal_t *journal, unsigned long compat,
 	sb->s_feature_ro_compat |= cpu_to_be32(ro);
 	sb->s_feature_incompat  |= cpu_to_be32(incompat);
 	unlock_buffer(journal->j_sb_buffer);
-	journal->j_revoke_records_per_block =
-				journal_revoke_records_per_block(journal);
+	jbd2_journal_init_transaction_limits(journal);
 
 	return 1;
 #undef COMPAT_FEATURE_ON
@@ -2411,8 +2443,7 @@ void jbd2_journal_clear_features(journal_t *journal, unsigned long compat,
 	sb->s_feature_compat    &= ~cpu_to_be32(compat);
 	sb->s_feature_ro_compat &= ~cpu_to_be32(ro);
 	sb->s_feature_incompat  &= ~cpu_to_be32(incompat);
-	journal->j_revoke_records_per_block =
-				journal_revoke_records_per_block(journal);
+	jbd2_journal_init_transaction_limits(journal);
 }
 EXPORT_SYMBOL(jbd2_journal_clear_features);
 
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index cb0b8d6fc0c6..a095f1a3114b 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -62,28 +62,6 @@ void jbd2_journal_free_transaction(transaction_t *transaction)
 	kmem_cache_free(transaction_cache, transaction);
 }
 
-/*
- * Base amount of descriptor blocks we reserve for each transaction.
- */
-static int jbd2_descriptor_blocks_per_trans(journal_t *journal)
-{
-	int tag_space = journal->j_blocksize - sizeof(journal_header_t);
-	int tags_per_block;
-
-	/* Subtract UUID */
-	tag_space -= 16;
-	if (jbd2_journal_has_csum_v2or3(journal))
-		tag_space -= sizeof(struct jbd2_journal_block_tail);
-	/* Commit code leaves a slack space of 16 bytes at the end of block */
-	tags_per_block = (tag_space - 16) / journal_tag_bytes(journal);
-	/*
-	 * Revoke descriptors are accounted separately so we need to reserve
-	 * space for commit block and normal transaction descriptor blocks.
-	 */
-	return 1 + DIV_ROUND_UP(journal->j_max_transaction_buffers,
-				tags_per_block);
-}
-
 /*
  * jbd2_get_transaction: obtain a new transaction_t object.
  *
@@ -109,7 +87,7 @@ static void jbd2_get_transaction(journal_t *journal,
 	transaction->t_expires = jiffies + journal->j_commit_interval;
 	atomic_set(&transaction->t_updates, 0);
 	atomic_set(&transaction->t_outstanding_credits,
-		   jbd2_descriptor_blocks_per_trans(journal) +
+		   journal->j_transaction_overhead_buffers +
 		   atomic_read(&journal->j_reserved_credits));
 	atomic_set(&transaction->t_outstanding_revokes, 0);
 	atomic_set(&transaction->t_handle_count, 0);
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index f91b930abe20..b900c642210c 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1085,6 +1085,13 @@ struct journal_s
 	 */
 	int			j_revoke_records_per_block;
 
+	/**
+	 * @j_transaction_overhead:
+	 *
+	 * Number of blocks each transaction needs for its own bookkeeping
+	 */
+	int			j_transaction_overhead_buffers;
+
 	/**
 	 * @j_commit_interval:
 	 *
-- 
2.35.3


