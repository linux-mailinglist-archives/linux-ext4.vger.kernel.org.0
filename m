Return-Path: <linux-ext4+bounces-5137-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 273F99C7722
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Nov 2024 16:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FA93B31E94
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Nov 2024 14:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02ED738389;
	Wed, 13 Nov 2024 14:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="e144gidM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jBScefVv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="e144gidM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jBScefVv"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DDC13A268
	for <linux-ext4@vger.kernel.org>; Wed, 13 Nov 2024 14:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731509277; cv=none; b=GPKCtl1jeO/UX+qkcD+vLK0snbDuvvZ2VWQmoP2vKtejh3czxUVZ1/liP1uhERaU2tdm4GDvAu+ukSXMeXXbFpSwns1IrdFg32hiCxbug3T9RCaZFUOGRTItvW88GiociyeH6b/mL/jkbMlBCVucRKFtk4GowCIU3JiTGkGJsvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731509277; c=relaxed/simple;
	bh=K4/rgzPZqSycAWPLt++mnpxvyyajiDxL/SwIPaPcahI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWU0CG5Kv+gQm9ftoPcXJbYjQitcQpwWhn0EsRctsl2wd7oSsxwjJU52leXoxGsff0zYF4fNFUt7+HvPPYF7jUBuFwMdtJL/QBSJG0o8uUhVSw4cUAe/Eo/dlwRFE4KwEEXIHotFKFaQAw52cPbJQNSBN4xFlYR3Zj9zIXKyIrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=e144gidM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jBScefVv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=e144gidM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jBScefVv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7B2411F37C;
	Wed, 13 Nov 2024 14:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731509273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tohMNwhRZSPet+P4+lXwFf49oeqbVMa19PP/PnZQV+c=;
	b=e144gidM1AjZbLJwJ+2hnAKlQwMJDaw8OQPt79VYJSk/z+bUtOBNNrCfuxOFrH/SdqESC2
	t4q/dEMaqgueSYdqe1YiDZ4ZNjH+KbcHwgs48Zg49QhpIBtDhrpeG1Iq1d1x72giwON4rS
	7ZxVe6jotKx204g5qUKsY9/ImmrOpvY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731509273;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tohMNwhRZSPet+P4+lXwFf49oeqbVMa19PP/PnZQV+c=;
	b=jBScefVvjl+NDsoocXqesX5NjnPqrvwWLhLnB/KMFFxHXFfcNnd4VJn9rO1jj1QC2BcRx4
	VZ8kJ5IBf6U6b+BA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=e144gidM;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=jBScefVv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731509273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tohMNwhRZSPet+P4+lXwFf49oeqbVMa19PP/PnZQV+c=;
	b=e144gidM1AjZbLJwJ+2hnAKlQwMJDaw8OQPt79VYJSk/z+bUtOBNNrCfuxOFrH/SdqESC2
	t4q/dEMaqgueSYdqe1YiDZ4ZNjH+KbcHwgs48Zg49QhpIBtDhrpeG1Iq1d1x72giwON4rS
	7ZxVe6jotKx204g5qUKsY9/ImmrOpvY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731509273;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tohMNwhRZSPet+P4+lXwFf49oeqbVMa19PP/PnZQV+c=;
	b=jBScefVvjl+NDsoocXqesX5NjnPqrvwWLhLnB/KMFFxHXFfcNnd4VJn9rO1jj1QC2BcRx4
	VZ8kJ5IBf6U6b+BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6BC4213301;
	Wed, 13 Nov 2024 14:47:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zldHGhm8NGcnfgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 13 Nov 2024 14:47:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0FBFCA08D0; Wed, 13 Nov 2024 15:47:53 +0100 (CET)
Date: Wed, 13 Nov 2024 15:47:52 +0100
From: Jan Kara <jack@suse.cz>
To: Andreas Dilger <adilger@dilger.ca>
Cc: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
	Li Dongyang <dongyangli@ddn.com>, linux-ext4@vger.kernel.org,
	Alex Zhuravlev <bzzz@whamcloud.com>
Subject: Re: [PATCH V2] jbd2: use rhashtable for revoke records during replay
Message-ID: <20241113144752.3hzcbrhvh4znrcf7@quack3>
References: <20241105034428.578701-1-dongyangli@ddn.com>
 <20241108103358.ziocxsyapli2pexv@quack3>
 <20241108161118.GA42603@mit.edu>
 <11AF8D3C-411F-436C-AC8D-B1C057D02091@dilger.ca>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="gdczihxayn6t35kx"
Content-Disposition: inline
In-Reply-To: <11AF8D3C-411F-436C-AC8D-B1C057D02091@dilger.ca>
X-Rspamd-Queue-Id: 7B2411F37C
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO


--gdczihxayn6t35kx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue 12-11-24 11:44:11, Andreas Dilger wrote:
> On Nov 8, 2024, at 9:11 AM, Theodore Ts'o <tytso@mit.edu> wrote:
> > 
> > On Fri, Nov 08, 2024 at 11:33:58AM +0100, Jan Kara wrote:
> >>> 1048576 records - 95 seconds
> >>> 2097152 records - 580 seconds
> >> 
> >> These are really high numbers of revoke records. Deleting couple GB of
> >> metadata doesn't happen so easily. Are they from a real workload or just
> >> a stress test?
> > 
> > For context, the background of this is that this has been an
> > out-of-tree that's been around for a very long time, for use with
> > Lustre servers where apparently, this very large number of revoke
> > records is a real thing.
> 
> Yes, we've seen this in production if there was a crash after deleting
> many millions of log records.  This causes remount to take potentially
> several hours before completing (and this was made worse by HA causing
> failovers due to mount being "stuck" doing the journal replay).

Thanks for clarification!

> >> If my interpretation is correct, then rhashtable is unnecessarily
> >> huge hammer for this. Firstly, as the big hash is needed only during
> >> replay, there's no concurrent access to the data
> >> structure. Secondly, we just fill the data structure in the
> >> PASS_REVOKE scan and then use it. Thirdly, we know the number of
> >> elements we need to store in the table in advance (well, currently
> >> we don't but it's trivial to modify PASS_SCAN to get that number).
> >> 
> >> So rather than playing with rhashtable, I'd modify PASS_SCAN to sum
> >> up number of revoke records we're going to process and then prepare
> >> a static hash of appropriate size for replay (we can just use the
> >> standard hashing fs/jbd2/revoke.c uses, just with differently sized
> >> hash table allocated for replay and point journal->j_revoke to
> >> it). And once recovery completes jbd2_journal_clear_revoke() can
> >> free the table and point journal->j_revoke back to the original
> >> table. What do you think?
> > 
> > Hmm, that's a really nice idea; Andreas, what do you think?
> 
> Implementing code to manually count and resize the recovery hashtable
> will also have its own complexity, including possible allocation size
> limits for a huge hash table.  That could be worked around by kvmalloc(),
> but IMHO this essentially starts "open coding" something rhashtable was
> exactly designed to avoid.

Well, I'd say the result is much simpler than rhashtable code since you
don't need all that dynamic reallocation and complex locking. Attached is a
patch that implements my suggestion. I'd say it is simpler than having two
types of revoke block hashing depending on whether we are doing recovery or
running the journal. I've tested it and it seems to work fine (including
replay of a journal with sufficiently many revoke blocks) but I'm not sure
I can do a meaningful performance testing (I cannot quite reproduce the
slow replay times even when shutting down the filesystem after deleting
1000000 directories). So can you please give it a spin?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--gdczihxayn6t35kx
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-jbd2-Avoid-long-replay-times-due-to-high-number-or-r.patch"

From db87b1d2cac01bc8336b70a32616388e6ff9fa8f Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Wed, 13 Nov 2024 11:53:13 +0100
Subject: [PATCH] jbd2: Avoid long replay times due to high number or revoke
 blocks

Some users are reporting journal replay takes a long time when there is
excessive number of revoke blocks in the journal. Reported times are
like:

1048576 records - 95 seconds
2097152 records - 580 seconds

The problem is that hash chains in the revoke table gets excessively
long in these cases. Fix the problem by sizing the revoke table
appropriately before the revoke pass.

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


--gdczihxayn6t35kx--

