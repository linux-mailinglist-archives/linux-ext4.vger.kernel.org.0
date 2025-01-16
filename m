Return-Path: <linux-ext4+bounces-6135-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A43EA14157
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Jan 2025 19:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 459E4165F92
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Jan 2025 18:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202BF18C011;
	Thu, 16 Jan 2025 18:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gvNfX8ga";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dYSshP5v";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gvNfX8ga";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dYSshP5v"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB881139CFF
	for <linux-ext4@vger.kernel.org>; Thu, 16 Jan 2025 18:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737050569; cv=none; b=LDLfZBDZsR4TwoY4UEw58gZ/mD+/4Lbd0ij8/mJ0WLma2mdq991io/n7gpr5YII5lAorn2/CBWqXv3YyQC79vVDPTa1HSIduVMN26ZHf0Yd8UJ1LVtbPvv9WRR/OV/3dX1YYk1D4u+umth25u0FyRHYZGwX8RBdc8Fq4Okwz0Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737050569; c=relaxed/simple;
	bh=wVgnRrt5RGHEuWDbLbMW5Azn++tS6tdKkQi9/1jGpgY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OP+DTB8ck7E6D51cZoZfspstx2qp2c/jFANlKt7stjA7MSbhGuLte77Aaq521pw9UFvH8QPFKsT1kmOhFY4TC2mGa9IfMnTySeBbYleCJOVnoubfmUKI1H8ZZ9i2sgD3b3r+yJFNfSAH08+jMUEkfZRY/Ixljp0YrhO+JpS8iqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gvNfX8ga; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dYSshP5v; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gvNfX8ga; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dYSshP5v; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A187D21184;
	Thu, 16 Jan 2025 18:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737050565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=9VcG70dwZvDsuIshqkWLYo26EhQ5h8bM4japjbCz4us=;
	b=gvNfX8ga5xI7UD3sQVzMKCym3FGTBMGobTXno2/5QAQezh+DS79rDVDVf6W/P9nThRA21+
	X00guJVJ6/sYsKXqC8uCJMz/xFV2npEU1LEgLU0SXusc8yfkJhqyF9LIfVCjJqa2qE/erz
	Xo9yQKd+Q2Lor5vRPqK36vnTJXe4YjY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737050565;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=9VcG70dwZvDsuIshqkWLYo26EhQ5h8bM4japjbCz4us=;
	b=dYSshP5vQxi8LL5k+PQjGhvtBTNXK55Aj8sZgVa90IH5mYeWjIGMxCL282po2CDVOEiN/T
	StBrOJ2LmsfgJ4Dw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=gvNfX8ga;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=dYSshP5v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737050565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=9VcG70dwZvDsuIshqkWLYo26EhQ5h8bM4japjbCz4us=;
	b=gvNfX8ga5xI7UD3sQVzMKCym3FGTBMGobTXno2/5QAQezh+DS79rDVDVf6W/P9nThRA21+
	X00guJVJ6/sYsKXqC8uCJMz/xFV2npEU1LEgLU0SXusc8yfkJhqyF9LIfVCjJqa2qE/erz
	Xo9yQKd+Q2Lor5vRPqK36vnTJXe4YjY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737050565;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=9VcG70dwZvDsuIshqkWLYo26EhQ5h8bM4japjbCz4us=;
	b=dYSshP5vQxi8LL5k+PQjGhvtBTNXK55Aj8sZgVa90IH5mYeWjIGMxCL282po2CDVOEiN/T
	StBrOJ2LmsfgJ4Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8FD7913332;
	Thu, 16 Jan 2025 18:02:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7L26IsVJiWeQMgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 16 Jan 2025 18:02:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 142D7A08E0; Thu, 16 Jan 2025 19:02:45 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: Ted Tso <tytso@mit.edu>
Cc: <linux-ext4@vger.kernel.org>,
	Andreas Dilger <adilger@dilger.ca>,
	Alexey Zhuravlev <azhuravlev@ddn.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH] jbd2: Avoid long replay times due to high number or revoke blocks
Date: Thu, 16 Jan 2025 19:02:24 +0100
Message-ID: <20250116180223.18564-2-jack@suse.cz>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6781; i=jack@suse.cz; h=from:subject; bh=wVgnRrt5RGHEuWDbLbMW5Azn++tS6tdKkQi9/1jGpgY=; b=owGbwMvMwME4Z+4qdvsUh5uMp9WSGNI7Pdffst0hNrNqnU2ya2dJanDMfumwgk/tagrOSfU/Sq7v 37Cok9GYhYGRg0FWTJFldeRF7WvzjLq2hmrIwAxiZQKZwsDFKQATEXzI/t//9YEpi++/v1d8JtfAuU /ke0cUp9/DJ7MkRNV/v7XY5y0V4fNP4qmp6t2bmTVeN5QfriplrZ3+ileTsVndWfytm16152bDbYsV fzhqKjhOetjWtlnqydZf7U0exaEzZ4rZcU+LZXhhylT79KCa+OTgVV4fAwX4pl93evvp5pbC/U/7sk Iif7P5VN8UybnErbuTZ/ErDs/tYnnX78gtlmfysO7avWVmarmLaZmfz0PZmJeJG5Z5MR7p1jzpyLzq Sl1o2aLFwaxWLgHqG2S1p8qLejBwZMvdUJjot8qUrbzZTrvf5WNKnrB9osW7x6KXK29NjWgymlJibc 8ufq5pw7TGDTKVhz+GTj/5Ur4LAA==
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A187D21184
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.cz:mid];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Some users are reporting journal replay takes a long time when there is
excessive number of revoke blocks in the journal. Reported times are
like:

1048576 records - 95 seconds
2097152 records - 580 seconds

The problem is that hash chains in the revoke table gets excessively
long in these cases. Fix the problem by sizing the revoke table
appropriately before the revoke pass.

Thanks to Alexey Zhuravlev <azhuravlev@ddn.com> for benchmarking the patch with
large numbers of revoke blocks [1].

[1] https://lore.kernel.org/all/20250113183107.7bfef7b6@x390.bzzz77.ru

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/recovery.c   | 54 +++++++++++++++++++++++++++++++++++++-------
 fs/jbd2/revoke.c     |  8 +++----
 include/linux/jbd2.h |  2 ++
 3 files changed, 52 insertions(+), 12 deletions(-)

diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index 667f67342c52..9845f72e456a 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -39,7 +39,7 @@ struct recovery_info
 
 static int do_one_pass(journal_t *journal,
 				struct recovery_info *info, enum passtype pass);
-static int scan_revoke_records(journal_t *, struct buffer_head *,
+static int scan_revoke_records(journal_t *, enum passtype, struct buffer_head *,
 				tid_t, struct recovery_info *);
 
 #ifdef __KERNEL__
@@ -327,6 +327,12 @@ int jbd2_journal_recover(journal_t *journal)
 		  journal->j_transaction_sequence, journal->j_head);
 
 	jbd2_journal_clear_revoke(journal);
+	/* Free revoke table allocated for replay */
+	if (journal->j_revoke != journal->j_revoke_table[0] &&
+	    journal->j_revoke != journal->j_revoke_table[1]) {
+		jbd2_journal_destroy_revoke_table(journal->j_revoke);
+		journal->j_revoke = journal->j_revoke_table[1];
+	}
 	err2 = sync_blockdev(journal->j_fs_dev);
 	if (!err)
 		err = err2;
@@ -517,6 +523,31 @@ static int do_one_pass(journal_t *journal,
 	first_commit_ID = next_commit_ID;
 	if (pass == PASS_SCAN)
 		info->start_transaction = first_commit_ID;
+	else if (pass == PASS_REVOKE) {
+		/*
+		 * Would the default revoke table have too long hash chains
+		 * during replay?
+		 */
+		if (info->nr_revokes > JOURNAL_REVOKE_DEFAULT_HASH * 16) {
+			unsigned int hash_size;
+
+			/*
+			 * Aim for average chain length of 8, limit at 1M
+			 * entries to avoid problems with malicious
+			 * filesystems.
+			 */
+			hash_size = min(roundup_pow_of_two(info->nr_revokes / 8),
+					1U << 20);
+			journal->j_revoke =
+				jbd2_journal_init_revoke_table(hash_size);
+			if (!journal->j_revoke) {
+				printk(KERN_ERR
+				       "JBD2: failed to allocate revoke table for replay with %u entries. "
+				       "Journal replay may be slow.\n", hash_size);
+				journal->j_revoke = journal->j_revoke_table[1];
+			}
+		}
+	}
 
 	jbd2_debug(1, "Starting recovery pass %d\n", pass);
 
@@ -874,14 +905,16 @@ static int do_one_pass(journal_t *journal,
 				need_check_commit_time = true;
 			}
 
-			/* If we aren't in the REVOKE pass, then we can
-			 * just skip over this block. */
-			if (pass != PASS_REVOKE) {
+			/*
+			 * If we aren't in the SCAN or REVOKE pass, then we can
+			 * just skip over this block.
+			 */
+			if (pass != PASS_REVOKE && pass != PASS_SCAN) {
 				brelse(bh);
 				continue;
 			}
 
-			err = scan_revoke_records(journal, bh,
+			err = scan_revoke_records(journal, pass, bh,
 						  next_commit_ID, info);
 			brelse(bh);
 			if (err)
@@ -937,8 +970,9 @@ static int do_one_pass(journal_t *journal,
 
 /* Scan a revoke record, marking all blocks mentioned as revoked. */
 
-static int scan_revoke_records(journal_t *journal, struct buffer_head *bh,
-			       tid_t sequence, struct recovery_info *info)
+static int scan_revoke_records(journal_t *journal, enum passtype pass,
+			       struct buffer_head *bh, tid_t sequence,
+			       struct recovery_info *info)
 {
 	jbd2_journal_revoke_header_t *header;
 	int offset, max;
@@ -959,6 +993,11 @@ static int scan_revoke_records(journal_t *journal, struct buffer_head *bh,
 	if (jbd2_has_feature_64bit(journal))
 		record_len = 8;
 
+	if (pass == PASS_SCAN) {
+		info->nr_revokes += (max - offset) / record_len;
+		return 0;
+	}
+
 	while (offset + record_len <= max) {
 		unsigned long long blocknr;
 		int err;
@@ -971,7 +1010,6 @@ static int scan_revoke_records(journal_t *journal, struct buffer_head *bh,
 		err = jbd2_journal_set_revoke(journal, blocknr, sequence);
 		if (err)
 			return err;
-		++info->nr_revokes;
 	}
 	return 0;
 }
diff --git a/fs/jbd2/revoke.c b/fs/jbd2/revoke.c
index 4556e4689024..f4ac308e84c5 100644
--- a/fs/jbd2/revoke.c
+++ b/fs/jbd2/revoke.c
@@ -215,7 +215,7 @@ int __init jbd2_journal_init_revoke_table_cache(void)
 	return 0;
 }
 
-static struct jbd2_revoke_table_s *jbd2_journal_init_revoke_table(int hash_size)
+struct jbd2_revoke_table_s *jbd2_journal_init_revoke_table(int hash_size)
 {
 	int shift = 0;
 	int tmp = hash_size;
@@ -231,7 +231,7 @@ static struct jbd2_revoke_table_s *jbd2_journal_init_revoke_table(int hash_size)
 	table->hash_size = hash_size;
 	table->hash_shift = shift;
 	table->hash_table =
-		kmalloc_array(hash_size, sizeof(struct list_head), GFP_KERNEL);
+		kvmalloc_array(hash_size, sizeof(struct list_head), GFP_KERNEL);
 	if (!table->hash_table) {
 		kmem_cache_free(jbd2_revoke_table_cache, table);
 		table = NULL;
@@ -245,7 +245,7 @@ static struct jbd2_revoke_table_s *jbd2_journal_init_revoke_table(int hash_size)
 	return table;
 }
 
-static void jbd2_journal_destroy_revoke_table(struct jbd2_revoke_table_s *table)
+void jbd2_journal_destroy_revoke_table(struct jbd2_revoke_table_s *table)
 {
 	int i;
 	struct list_head *hash_list;
@@ -255,7 +255,7 @@ static void jbd2_journal_destroy_revoke_table(struct jbd2_revoke_table_s *table)
 		J_ASSERT(list_empty(hash_list));
 	}
 
-	kfree(table->hash_table);
+	kvfree(table->hash_table);
 	kmem_cache_free(jbd2_revoke_table_cache, table);
 }
 
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 8aef9bb6ad57..781615214d47 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1634,6 +1634,8 @@ extern void	   jbd2_journal_destroy_revoke_record_cache(void);
 extern void	   jbd2_journal_destroy_revoke_table_cache(void);
 extern int __init jbd2_journal_init_revoke_record_cache(void);
 extern int __init jbd2_journal_init_revoke_table_cache(void);
+struct jbd2_revoke_table_s *jbd2_journal_init_revoke_table(int hash_size);
+void jbd2_journal_destroy_revoke_table(struct jbd2_revoke_table_s *table);
 
 extern void	   jbd2_journal_destroy_revoke(journal_t *);
 extern int	   jbd2_journal_revoke (handle_t *, unsigned long long, struct buffer_head *);
-- 
2.35.3


