Return-Path: <linux-ext4+bounces-6183-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39676A17F70
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jan 2025 15:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6991C169C9A
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jan 2025 14:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6921F2C58;
	Tue, 21 Jan 2025 14:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="woQTJmPH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QixAER1V";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="d3h9L0Ml";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QafSo0pJ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1509763CF
	for <linux-ext4@vger.kernel.org>; Tue, 21 Jan 2025 14:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737468614; cv=none; b=jaqp2fr5IZ0zfH9nTBPegNpsi71SSzJuydfy+KcWHS4xAbIApd3udwK8ekDMgEbwmDxSUGHLc+0wa0tQeGRKz6cwnTg61Yf/LxRT8WDXhurI/NMWw6BL8wuq7KkG6gEj1lg5hZRuo8+MD00w6JlgBlODvTkqo5O21EaRoSfW5aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737468614; c=relaxed/simple;
	bh=5pE0o8pKxulM39n6W/nDdjDgjVKNN3N5ZhjSz+XjKyc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MqoDj7GdiGGROw2xbfvibEe7gmjl2U+mOAbKT3l6Ikyf3+ijXtH4jTJQMxFSZy11fnb3GdKcqnsmeppBYTyjdWF8yBoehgfUjj+aHC9QOBI6OPWC5c7YILjlgzC9/8M/UqVXFISNxdWPAKZ6HJgIs6Rfm5C98Xk4ka85hh9pQOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=woQTJmPH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QixAER1V; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=d3h9L0Ml; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QafSo0pJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 062741F78D;
	Tue, 21 Jan 2025 14:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737468610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FsmJP6gn9QYmoxuDUTK0wBOWFU5ur96jt1wa+xV0kp4=;
	b=woQTJmPHobDfMQx6/MyRHZu8jL9EbOvPaULSlm7aFY8APLAEBLF3truLbA0Tw4iQv4T8nm
	81clLho2oLstGSGOPilh+GaWeFGb+ROzqYHbhWIrSNAH5YhpKo/GnR0gt935j6aNjbIgHV
	MLMq8Y46GANGOwXGu4zF9CFSxXjjMg8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737468610;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FsmJP6gn9QYmoxuDUTK0wBOWFU5ur96jt1wa+xV0kp4=;
	b=QixAER1VulqnT9uA7OpnpiDa6hbQN5PM/iWM2iAH4FLZtxawgt5X50k3ACE5lRErobwUiE
	B2xRqox4NIpXscDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737468609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FsmJP6gn9QYmoxuDUTK0wBOWFU5ur96jt1wa+xV0kp4=;
	b=d3h9L0MlZtm6l8+hS5R76dDJIiCyVhPOdqWABtJmr/aX9BTGReX/kMbdp+9SnLCzcyRYEe
	z1NAfKa0OUlmhX4cbp9b8z3zco1DnmqzyZ4rMAzQFpP1A0GElsVWxlHhkYH9nT77+Ml1WE
	IG4N30zqpOILimcS43xf7EXMYkC1Pww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737468609;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FsmJP6gn9QYmoxuDUTK0wBOWFU5ur96jt1wa+xV0kp4=;
	b=QafSo0pJ6cUXEEXysMQXRXe9AgOxrMgzVMZye1yV60VkW1y++vMaJ6t4CuN/UVj5Z8TBJh
	hzklqSK0/IYt6wDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E99DB13963;
	Tue, 21 Jan 2025 14:10:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pk0FOcCqj2drWgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 21 Jan 2025 14:10:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 79C24A0889; Tue, 21 Jan 2025 15:10:08 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: Ted Tso <tytso@mit.edu>
Cc: <linux-ext4@vger.kernel.org>,
	Alexey Zhuravlev <azhuravlev@ddn.com>,
	Andreas Dilger <adilger@dilger.ca>,
	Zhang Yi <yi.zhang@huawei.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v2] jbd2: Avoid long replay times due to high number or revoke blocks
Date: Tue, 21 Jan 2025 15:09:26 +0100
Message-ID: <20250121140925.17231-2-jack@suse.cz>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7067; i=jack@suse.cz; h=from:subject; bh=5pE0o8pKxulM39n6W/nDdjDgjVKNN3N5ZhjSz+XjKyc=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBnj6qVT6RMt/cipkOEfG4a0r12vwmxJhKXe1fW/tWY M6TkGmCJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZ4+qlQAKCRCcnaoHP2RA2bEsB/ 93GaVvdY2XhGut9nLy5/q3Cd0FS14zk1ZxylkfTN0Y0FY15bWTz/6PnlIuSdqEO5zSTytvoorxUpOC b+EgATzsrl4wnzDtUZ5J7Hq1jFJOblAsPvaxrmx8/43836P19m5Cj6ZcWC5dbLOiX+Wj9JDLZjR4eA F4jJjQV5w42cYydPzEFLP3Sb5WGFixNnRIPjYdiHOAqiOz3/IjxjGQJP5kM298IB52seU4XdVcZQZ/ i5QkCWPDdRfl3YfbeXzmeZKWhgGS6cDqfgmCUtzhKlC86dBnagwnQe9VbwywCzHoJyBoDIiBkq/7eq KB9AOHV1bdXo+U9IC9UiKxxzz7xBxe
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Some users are reporting journal replay takes a long time when there is
excessive number of revoke blocks in the journal. Reported times are
like:

1048576 records - 95 seconds
2097152 records - 580 seconds

The problem is that hash chains in the revoke table gets excessively
long in these cases. Fix the problem by sizing the revoke table
appropriately before the revoke pass.

Thanks to Alexey Zhuravlev <azhuravlev@ddn.com> for benchmarking the
patch with large numbers of revoke blocks [1].

[1] https://lore.kernel.org/all/20250113183107.7bfef7b6@x390.bzzz77.ru

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/recovery.c   | 58 ++++++++++++++++++++++++++++++++++++--------
 fs/jbd2/revoke.c     |  8 +++---
 include/linux/jbd2.h |  2 ++
 3 files changed, 54 insertions(+), 14 deletions(-)

Changes since v1:
* rebased on 6.13
* move check in do_one_pass()

diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index 9192be7c19d8..7c23a8be673f 100644
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
@@ -612,6 +618,31 @@ static int do_one_pass(journal_t *journal,
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
 
@@ -851,6 +882,13 @@ static int do_one_pass(journal_t *journal,
 			continue;
 
 		case JBD2_REVOKE_BLOCK:
+			/*
+			 * If we aren't in the SCAN or REVOKE pass, then we can
+			 * just skip over this block.
+			 */
+			if (pass != PASS_REVOKE && pass != PASS_SCAN)
+				continue;
+
 			/*
 			 * Check revoke block crc in pass_scan, if csum verify
 			 * failed, check commit block time later.
@@ -863,12 +901,7 @@ static int do_one_pass(journal_t *journal,
 				need_check_commit_time = true;
 			}
 
-			/* If we aren't in the REVOKE pass, then we can
-			 * just skip over this block. */
-			if (pass != PASS_REVOKE)
-				continue;
-
-			err = scan_revoke_records(journal, bh,
+			err = scan_revoke_records(journal, pass, bh,
 						  next_commit_ID, info);
 			if (err)
 				goto failed;
@@ -922,8 +955,9 @@ static int do_one_pass(journal_t *journal,
 
 /* Scan a revoke record, marking all blocks mentioned as revoked. */
 
-static int scan_revoke_records(journal_t *journal, struct buffer_head *bh,
-			       tid_t sequence, struct recovery_info *info)
+static int scan_revoke_records(journal_t *journal, enum passtype pass,
+			       struct buffer_head *bh, tid_t sequence,
+			       struct recovery_info *info)
 {
 	jbd2_journal_revoke_header_t *header;
 	int offset, max;
@@ -944,6 +978,11 @@ static int scan_revoke_records(journal_t *journal, struct buffer_head *bh,
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
@@ -956,7 +995,6 @@ static int scan_revoke_records(journal_t *journal, struct buffer_head *bh,
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
index 50f7ea8714bf..610841635204 100644
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
2.43.0


