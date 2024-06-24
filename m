Return-Path: <linux-ext4+bounces-2940-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B309154EF
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Jun 2024 19:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 365611F244A6
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Jun 2024 17:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D517519EEA7;
	Mon, 24 Jun 2024 17:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q4msYm1M";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dT5CYQQp";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q4msYm1M";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dT5CYQQp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE6D129A7B;
	Mon, 24 Jun 2024 17:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719248491; cv=none; b=K37ANGLXjzgS02WM78ca4RUc0gISSXpC3cjZCPHeU21RsSCn5vpdOMyGFVupBor7VWXkuvysCGDNIy6gtXud+7FJ2knQL1TkD+XS+bYgxGCGSJwGIWsrPOw8RQHkLLC/cN/tfbULNHDvnP9JuRwAkMwVvzQ9DlTkPYua7csTETE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719248491; c=relaxed/simple;
	bh=dSrX3jOEJ/rI55MZPygNhQemTao0WXPsuAVGKsikvk4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kUkHwRhZsts7YBPgDXBmymFcDLvYKK9lVxa1gF00Wh/LSFknKrrTQ82ASVFld97ZAu23aZPDs6su3SRoeGQWTRKE7Mp4fqEjPbRXIQia0h/mqwn42j4/blQRF5tSZ5POkEAjsIWUoQHwzQZJjFSyhq3bVYKHFQwnSbblwuka5EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q4msYm1M; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dT5CYQQp; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q4msYm1M; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dT5CYQQp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 09B621F829;
	Mon, 24 Jun 2024 17:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719248488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GGPcikoJeqEjh8jCx4uqqoCKPQi5MgHji8CVnlHlX1Q=;
	b=Q4msYm1MjevP+JbVzxYV9st+qw2TwSeb3ES7+RovjkwkstVl0ebr+vAvg3E22H/fTccSnd
	/o6DVH/ggVVkPj3rfq1CcilcITB3GIKZf3OpyYaBNN5W4dBTvf7TBMkS4E55Ho7ok+n7UY
	14IzEt2amVQ0Iv3a5YKfNFrAWFew9HA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719248488;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GGPcikoJeqEjh8jCx4uqqoCKPQi5MgHji8CVnlHlX1Q=;
	b=dT5CYQQp8gw85l9WMiBSVx9B2LS2yIN2HCmjLL4aWQ3KrX8lLOPQYk8sLdmXQ3MYQ7iS0X
	z0eVIk1pjiQ0ZdCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719248488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GGPcikoJeqEjh8jCx4uqqoCKPQi5MgHji8CVnlHlX1Q=;
	b=Q4msYm1MjevP+JbVzxYV9st+qw2TwSeb3ES7+RovjkwkstVl0ebr+vAvg3E22H/fTccSnd
	/o6DVH/ggVVkPj3rfq1CcilcITB3GIKZf3OpyYaBNN5W4dBTvf7TBMkS4E55Ho7ok+n7UY
	14IzEt2amVQ0Iv3a5YKfNFrAWFew9HA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719248488;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GGPcikoJeqEjh8jCx4uqqoCKPQi5MgHji8CVnlHlX1Q=;
	b=dT5CYQQp8gw85l9WMiBSVx9B2LS2yIN2HCmjLL4aWQ3KrX8lLOPQYk8sLdmXQ3MYQ7iS0X
	z0eVIk1pjiQ0ZdCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EEBBD13AD6;
	Mon, 24 Jun 2024 17:01:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id n3ddOmemeWbQOAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 24 Jun 2024 17:01:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8F273A091A; Mon, 24 Jun 2024 19:01:27 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Ted Tso <tytso@mit.edu>
Cc: <linux-ext4@vger.kernel.org>,
	Alexander Coffin <alex.coffin@maticrobots.com>,
	Jan Kara <jack@suse.cz>,
	stable@vger.kernel.org
Subject: [PATCH v2 3/4] jbd2: Avoid infinite transaction commit loop
Date: Mon, 24 Jun 2024 19:01:19 +0200
Message-Id: <20240624170127.3253-3-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240624165406.12784-1-jack@suse.cz>
References: <20240624165406.12784-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4172; i=jack@suse.cz; h=from:subject; bh=dSrX3jOEJ/rI55MZPygNhQemTao0WXPsuAVGKsikvk4=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBmeaZf5kY5LZWAgUrXbM7qJn/XKKkWRFcnCv+bTmdq 7rXQmPWJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZnmmXwAKCRCcnaoHP2RA2cUnB/ 9LJIp7N0ferYaIQQ05itKkuAnyFzVkMcnK0bmvM/fPM/8r0Pq8SdHefcSXBfd6kmVRc7xH4YehEqUw WXJYNviYuIZ/87grKXpOjH/0JKb0zbdwHsrQQAnXvnbCGLcVKwVpI97cQi078OBGyeR241lp2OC6Nl c8eu3jKbok+kRNGbkW3QVd/naOdxQ3TBZPs5sqWvFTJxVbTjRoC+1RhpgW8Uo4gDlRvvFeU62yC1eK kFV2Lafuw2V6QGDykkqAQftlBE4lyyVRcp5DPCeXclsJXBOnVophglJQncc2QThTlHeivcQRAR1Vn8 myRMblL+C4qZy9WdAg7VO8JwMbtNCi
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Score: -6.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

Commit 9f356e5a4f12 ("jbd2: Account descriptor blocks into
t_outstanding_credits") started to account descriptor blocks into
transactions outstanding credits. However it didn't appropriately
decrease the maximum amount of credits available to userspace. Thus if
the filesystem requests a transaction smaller than
j_max_transaction_buffers but large enough that when descriptor blocks
are added the size exceeds j_max_transaction_buffers, we confuse
add_transaction_credits() into thinking previous handles have grown the
transaction too much and enter infinite journal commit loop in
start_this_handle() -> add_transaction_credits() trying to create
transaction with enough credits available.

Fix the problem by properly accounting for transaction space reserved
for descriptor blocks when verifying requested transaction handle size.

CC: stable@vger.kernel.org
Fixes: 9f356e5a4f12 ("jbd2: Account descriptor blocks into t_outstanding_credits")
Reported-by: Alexander Coffin <alex.coffin@maticrobots.com>
Link: https://lore.kernel.org/all/CA+hUFcuGs04JHZ_WzA1zGN57+ehL2qmHOt5a7RMpo+rv6Vyxtw@mail.gmail.com
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/transaction.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index a095f1a3114b..66513c18ca29 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -191,6 +191,13 @@ static void sub_reserved_credits(journal_t *journal, int blocks)
 	wake_up(&journal->j_wait_reserved);
 }
 
+/* Maximum number of blocks for user transaction payload */
+static int jbd2_max_user_trans_buffers(journal_t *journal)
+{
+	return journal->j_max_transaction_buffers -
+				journal->j_transaction_overhead_buffers;
+}
+
 /*
  * Wait until we can add credits for handle to the running transaction.  Called
  * with j_state_lock held for reading. Returns 0 if handle joined the running
@@ -240,12 +247,12 @@ __must_hold(&journal->j_state_lock)
 		 * big to fit this handle? Wait until reserved credits are freed.
 		 */
 		if (atomic_read(&journal->j_reserved_credits) + total >
-		    journal->j_max_transaction_buffers) {
+		    jbd2_max_user_trans_buffers(journal)) {
 			read_unlock(&journal->j_state_lock);
 			jbd2_might_wait_for_commit(journal);
 			wait_event(journal->j_wait_reserved,
 				   atomic_read(&journal->j_reserved_credits) + total <=
-				   journal->j_max_transaction_buffers);
+				   jbd2_max_user_trans_buffers(journal));
 			__acquire(&journal->j_state_lock); /* fake out sparse */
 			return 1;
 		}
@@ -285,14 +292,14 @@ __must_hold(&journal->j_state_lock)
 
 	needed = atomic_add_return(rsv_blocks, &journal->j_reserved_credits);
 	/* We allow at most half of a transaction to be reserved */
-	if (needed > journal->j_max_transaction_buffers / 2) {
+	if (needed > jbd2_max_user_trans_buffers(journal) / 2) {
 		sub_reserved_credits(journal, rsv_blocks);
 		atomic_sub(total, &t->t_outstanding_credits);
 		read_unlock(&journal->j_state_lock);
 		jbd2_might_wait_for_commit(journal);
 		wait_event(journal->j_wait_reserved,
 			 atomic_read(&journal->j_reserved_credits) + rsv_blocks
-			 <= journal->j_max_transaction_buffers / 2);
+			 <= jbd2_max_user_trans_buffers(journal) / 2);
 		__acquire(&journal->j_state_lock); /* fake out sparse */
 		return 1;
 	}
@@ -322,12 +329,12 @@ static int start_this_handle(journal_t *journal, handle_t *handle,
 	 * size and limit the number of total credits to not exceed maximum
 	 * transaction size per operation.
 	 */
-	if ((rsv_blocks > journal->j_max_transaction_buffers / 2) ||
-	    (rsv_blocks + blocks > journal->j_max_transaction_buffers)) {
+	if (rsv_blocks > jbd2_max_user_trans_buffers(journal) / 2 ||
+	    rsv_blocks + blocks > jbd2_max_user_trans_buffers(journal)) {
 		printk(KERN_ERR "JBD2: %s wants too many credits "
 		       "credits:%d rsv_credits:%d max:%d\n",
 		       current->comm, blocks, rsv_blocks,
-		       journal->j_max_transaction_buffers);
+		       jbd2_max_user_trans_buffers(journal));
 		WARN_ON(1);
 		return -ENOSPC;
 	}
-- 
2.35.3


