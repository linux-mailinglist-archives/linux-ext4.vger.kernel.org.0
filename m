Return-Path: <linux-ext4+bounces-14643-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGYJM4RqqGnouQAAu9opvQ
	(envelope-from <linux-ext4+bounces-14643-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 04 Mar 2026 18:23:16 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 756772051AC
	for <lists+linux-ext4@lfdr.de>; Wed, 04 Mar 2026 18:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7DC7301E227
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Mar 2026 17:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01F0390205;
	Wed,  4 Mar 2026 17:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhQ84KBh"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94C537F75C
	for <linux-ext4@vger.kernel.org>; Wed,  4 Mar 2026 17:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772644830; cv=none; b=CqdHUj0bGsswMf0P/FMfCUUoQhf5/BhipqUFK4A2hmglqJnsx+WCi22MzWrjU0/TaxVyZZEM4OblzXs7nVXHYicXR3jYfDxt+nmZLdl1f3zaL5ApvbHIm/zAvyYISJ//H+KRxLILXx+uCcP8idGH9FKpY8WVxSTXzl/ddpJ1Oh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772644830; c=relaxed/simple;
	bh=IsGPWWvvkOUT1FXmXSiLtN0ytGG+JGmWtURklycoIzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZTy7n6fuXLgvD9FL+9/vNvZLmAVcACuNvmg0iuOTxEx0O8vvzusuIW0zYeBEPUFnD9jt70DmJHppG/entXHru6cSB700wCMl9K2fMlEkPOojWKI1916rQN94kzLXuN7m9s1srV+/ClVc+81WCtPRzuPdn2kusnirB1EEwRjOK0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VhQ84KBh; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2b4520f6b32so8134053eec.0
        for <linux-ext4@vger.kernel.org>; Wed, 04 Mar 2026 09:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772644824; x=1773249624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bcwc2mN4WEeD/fkNgmAj/JdrJxpBvDldziQSiyUANd4=;
        b=VhQ84KBhsuWpaULDdjayadGlivpevZo3bhZ1Q6kisulhHuhALruXCgRVvQNmBb5hSG
         1WWaEA3DV6ycX/dYXrBQz9nkA7je4qaBUNHDVjFkvfoq+JVTQnd8dSIUxURTBUQzHiXc
         JkXO7P603RnBVkFe5yBc7acqTFaeJRgsG1uSSAXBPvMmTFeVfHRf+RQwG+Gth3r1OT3n
         tVV7kKhcqw1nNWNq6a5t3dwTeZYux96WgQgx8AKkObhlHuoQTuA7poclPTVJB3SBLsfK
         zCQ2YvOqjNydSJslZfLq/JMxAziDEra7kmOmxEAw/vOK57yh6QiN1w4OLU1N98e/nuED
         aadQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772644824; x=1773249624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bcwc2mN4WEeD/fkNgmAj/JdrJxpBvDldziQSiyUANd4=;
        b=Le1bjt/BBRATgZAoeeiWMB2YUo0NddAsv8xV2GUyQHDdYjR8VT8IRMjsIKRHDTm1rm
         BC7fawtijI3fdBox9pDVRwZ+tM03/o/TyW1LXxW9hlzqyHarfFGL6yfvUqGWpOvs+8dW
         iPAp8uX+6t8/NpittQOzTZ7Hy5s8nSYi6rKZMbtzHWdtqlIVSUPjEeOOROFA5+R3oAA/
         75TPH36wipHR4CXQQNMn/wyKlTRx4B5VonGn0vFYJaNFMzJEQq+5lUBpy2PDudz0Dmg3
         iuFXfxxqnGF/voSMEayIwd8gOKEaK5hegaBLddJ1esnZDOPngDWfuvaa5GZtvhRNyv3U
         QDeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGJnEdVBYUkI4wEj3MJKlOYBvy3ZMrFDUKyjfMZXO/6A7v1N/tj7Fpg6b28z+8HDRqzB/WtTx5xTKb@vger.kernel.org
X-Gm-Message-State: AOJu0YwAY4962uH7uPC/PNENbJec16VYJ/9TsZ6wByW28UnOHcsnfnlF
	udYELyIX86mqWsMHIbRhIUVuD0HZFjSjFZRDzh1mMv2mjFa5dTB+VvMW
X-Gm-Gg: ATEYQzyhb9AW+oBces5cTpqX/THWsLS2920rwB6wUC8zLfYZL74JfvStr+uJokWHc4Z
	6m2qp3eODx6rCvG3Qp1PiRDYxwIfxOXvSTZC4QQuc1buGS0SNYJuw3a81bw9mU9wR8GXmuDY28Z
	6Gzjer5mygbrQjN+iD+SYHUtFWjC3t5BGTbj34r/z+1VhRaUvZjUWLAW6NmMDkTCiTvV7vhQXU3
	b4hpp61Z9JiChNC6fEoLa1+QHF4yb4ImailNBUdZWy2bi5kLXCZ0UhfP9p3W6ic0H4mfen8YHGx
	6sVqcVXmzEXOrcxqdFP/kD3ZTWSPq/YyC0fhOkjbXhYKpx9sa6axzhF29trbonV/vhmZvC8Rki5
	81hB5RXcADKrKOmmrmct5PpWx1HzaEuV8YAey3KhRqS6BPqIHOqsp+uxpEjtFxZ526dwwTOCrBP
	UR26Hrhw5VoTeuazndvUPvCi5sjGGpJIvejp1hauoI/mRcgL8uZleHtgTzSgPsvb1kzEvK5bVyA
	Zq+rEUg6mHuR9HoiGMEUzIBMVgseD3eNUuQe9+80UOevAQA99qVgAm/9TZs+hP15SB7kom/t8kL
X-Received: by 2002:a05:7301:1692:b0:2ba:a60a:15e6 with SMTP id 5a478bee46e88-2be30fef278mr1118461eec.16.1772644823438;
        Wed, 04 Mar 2026 09:20:23 -0800 (PST)
Received: from arch.guest.box.net ([8.39.49.133])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be2800c89asm2904789eec.31.2026.03.04.09.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 09:20:23 -0800 (PST)
From: Milos Nikic <nikic.milos@gmail.com>
To: jack@suse.cz
Cc: tytso@mit.edu,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Milos Nikic <nikic.milos@gmail.com>,
	Zhang Yi <yi.zhang@huawei.com>,
	Andreas Dilger <adilger@dilger.ca>
Subject: [PATCH v5 2/2] jbd2: gracefully abort on transaction state corruptions
Date: Wed,  4 Mar 2026 09:20:16 -0800
Message-ID: <20260304172016.23525-3-nikic.milos@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304172016.23525-1-nikic.milos@gmail.com>
References: <20260304172016.23525-1-nikic.milos@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 756772051AC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-14643-lists,linux-ext4=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[mit.edu,vger.kernel.org,gmail.com,huawei.com,dilger.ca];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikicmilos@gmail.com,linux-ext4@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-ext4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Auditing the jbd2 codebase reveals several legacy J_ASSERT calls
that enforce internal state machine invariants (e.g., verifying
jh->b_transaction or jh->b_next_transaction pointers).

When these invariants are broken, the journal is in a corrupted
state. However, triggering a fatal panic brings down the entire
system for a localized filesystem error.

This patch targets a specific class of these asserts: those
residing inside functions that natively return integer error codes,
booleans, or error pointers. It replaces the hard J_ASSERTs with
WARN_ON_ONCE to capture the offending stack trace, safely drops
any held locks, gracefully aborts the journal, and returns -EINVAL.

This prevents a catastrophic kernel panic while ensuring the
corrupted journal state is safely contained and upstream callers
(like ext4 or ocfs2) can gracefully handle the aborted handle.

Functions modified in fs/jbd2/transaction.c:
- jbd2__journal_start()
- do_get_write_access()
- jbd2_journal_dirty_metadata()
- jbd2_journal_forget()
- jbd2_journal_try_to_free_buffers()
- jbd2_journal_file_inode()

Signed-off-by: Milos Nikic <nikic.milos@gmail.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
---
 fs/jbd2/transaction.c | 114 +++++++++++++++++++++++++++++++-----------
 1 file changed, 86 insertions(+), 28 deletions(-)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 04d17a5f2a82..02cb87dc6fa8 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -474,7 +474,8 @@ handle_t *jbd2__journal_start(journal_t *journal, int nblocks, int rsv_blocks,
 		return ERR_PTR(-EROFS);
 
 	if (handle) {
-		J_ASSERT(handle->h_transaction->t_journal == journal);
+		if (WARN_ON_ONCE(handle->h_transaction->t_journal != journal))
+			return ERR_PTR(-EINVAL);
 		handle->h_ref++;
 		return handle;
 	}
@@ -1036,7 +1037,13 @@ do_get_write_access(handle_t *handle, struct journal_head *jh,
 	 */
 	if (!jh->b_transaction) {
 		JBUFFER_TRACE(jh, "no transaction");
-		J_ASSERT_JH(jh, !jh->b_next_transaction);
+		if (WARN_ON_ONCE(jh->b_next_transaction)) {
+			spin_unlock(&jh->b_state_lock);
+			unlock_buffer(bh);
+			error = -EINVAL;
+			jbd2_journal_abort(journal, error);
+			goto out;
+		}
 		JBUFFER_TRACE(jh, "file as BJ_Reserved");
 		/*
 		 * Make sure all stores to jh (b_modified, b_frozen_data) are
@@ -1069,13 +1076,27 @@ do_get_write_access(handle_t *handle, struct journal_head *jh,
 	 */
 	if (jh->b_frozen_data) {
 		JBUFFER_TRACE(jh, "has frozen data");
-		J_ASSERT_JH(jh, jh->b_next_transaction == NULL);
+		if (WARN_ON_ONCE(jh->b_next_transaction)) {
+			spin_unlock(&jh->b_state_lock);
+			error = -EINVAL;
+			jbd2_journal_abort(journal, error);
+			goto out;
+		}
 		goto attach_next;
 	}
 
 	JBUFFER_TRACE(jh, "owned by older transaction");
-	J_ASSERT_JH(jh, jh->b_next_transaction == NULL);
-	J_ASSERT_JH(jh, jh->b_transaction == journal->j_committing_transaction);
+	if (WARN_ON_ONCE(jh->b_next_transaction ||
+			 jh->b_transaction !=
+			 journal->j_committing_transaction)) {
+		pr_err("JBD2: %s: assertion failure: b_next_transaction=%p b_transaction=%p j_committing_transaction=%p\n",
+		       journal->j_devname, jh->b_next_transaction,
+		       jh->b_transaction, journal->j_committing_transaction);
+		spin_unlock(&jh->b_state_lock);
+		error = -EINVAL;
+		jbd2_journal_abort(journal, error);
+		goto out;
+	}
 
 	/*
 	 * There is one case we have to be very careful about.  If the
@@ -1496,7 +1517,7 @@ void jbd2_buffer_abort_trigger(struct journal_head *jh,
 int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
 {
 	transaction_t *transaction = handle->h_transaction;
-	journal_t *journal;
+	journal_t *journal = transaction->t_journal;
 	struct journal_head *jh;
 	int ret = 0;
 
@@ -1520,8 +1541,14 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
 	if (data_race(jh->b_transaction != transaction &&
 	    jh->b_next_transaction != transaction)) {
 		spin_lock(&jh->b_state_lock);
-		J_ASSERT_JH(jh, jh->b_transaction == transaction ||
-				jh->b_next_transaction == transaction);
+		if (WARN_ON_ONCE(jh->b_transaction != transaction &&
+				 jh->b_next_transaction != transaction)) {
+			pr_err("JBD2: %s: assertion failure: b_transaction=%p transaction=%p b_next_transaction=%p\n",
+			       journal->j_devname, jh->b_transaction,
+			       transaction, jh->b_next_transaction);
+			ret = -EINVAL;
+			goto out_unlock_bh;
+		}
 		spin_unlock(&jh->b_state_lock);
 	}
 	if (data_race(jh->b_modified == 1)) {
@@ -1529,15 +1556,15 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
 		if (data_race(jh->b_transaction == transaction &&
 		    jh->b_jlist != BJ_Metadata)) {
 			spin_lock(&jh->b_state_lock);
-			if (jh->b_transaction == transaction &&
-			    jh->b_jlist != BJ_Metadata)
-				pr_err("JBD2: assertion failure: h_type=%u "
-				       "h_line_no=%u block_no=%llu jlist=%u\n",
+			if (WARN_ON_ONCE(jh->b_transaction == transaction &&
+					 jh->b_jlist != BJ_Metadata)) {
+				pr_err("JBD2: assertion failure: h_type=%u h_line_no=%u block_no=%llu jlist=%u\n",
 				       handle->h_type, handle->h_line_no,
 				       (unsigned long long) bh->b_blocknr,
 				       jh->b_jlist);
-			J_ASSERT_JH(jh, jh->b_transaction != transaction ||
-					jh->b_jlist == BJ_Metadata);
+				ret = -EINVAL;
+				goto out_unlock_bh;
+			}
 			spin_unlock(&jh->b_state_lock);
 		}
 		goto out;
@@ -1557,8 +1584,6 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
 		goto out_unlock_bh;
 	}
 
-	journal = transaction->t_journal;
-
 	if (jh->b_modified == 0) {
 		/*
 		 * This buffer's got modified and becoming part
@@ -1636,7 +1661,10 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
 	}
 
 	/* That test should have eliminated the following case: */
-	J_ASSERT_JH(jh, jh->b_frozen_data == NULL);
+	if (WARN_ON_ONCE(jh->b_frozen_data)) {
+		ret = -EINVAL;
+		goto out_unlock_bh;
+	}
 
 	JBUFFER_TRACE(jh, "file as BJ_Metadata");
 	spin_lock(&journal->j_list_lock);
@@ -1675,6 +1703,7 @@ int jbd2_journal_forget(handle_t *handle, struct buffer_head *bh)
 	int err = 0;
 	int was_modified = 0;
 	int wait_for_writeback = 0;
+	int abort_journal = 0;
 
 	if (is_handle_aborted(handle))
 		return -EROFS;
@@ -1708,7 +1737,11 @@ int jbd2_journal_forget(handle_t *handle, struct buffer_head *bh)
 	jh->b_modified = 0;
 
 	if (jh->b_transaction == transaction) {
-		J_ASSERT_JH(jh, !jh->b_frozen_data);
+		if (WARN_ON_ONCE(jh->b_frozen_data)) {
+			err = -EINVAL;
+			abort_journal = 1;
+			goto drop;
+		}
 
 		/* If we are forgetting a buffer which is already part
 		 * of this transaction, then we can just drop it from
@@ -1747,8 +1780,11 @@ int jbd2_journal_forget(handle_t *handle, struct buffer_head *bh)
 		}
 		spin_unlock(&journal->j_list_lock);
 	} else if (jh->b_transaction) {
-		J_ASSERT_JH(jh, (jh->b_transaction ==
-				 journal->j_committing_transaction));
+		if (WARN_ON_ONCE(jh->b_transaction != journal->j_committing_transaction)) {
+			err = -EINVAL;
+			abort_journal = 1;
+			goto drop;
+		}
 		/* However, if the buffer is still owned by a prior
 		 * (committing) transaction, we can't drop it yet... */
 		JBUFFER_TRACE(jh, "belongs to older transaction");
@@ -1766,7 +1802,11 @@ int jbd2_journal_forget(handle_t *handle, struct buffer_head *bh)
 			jh->b_next_transaction = transaction;
 			spin_unlock(&journal->j_list_lock);
 		} else {
-			J_ASSERT(jh->b_next_transaction == transaction);
+			if (WARN_ON_ONCE(jh->b_next_transaction != transaction)) {
+				err = -EINVAL;
+				abort_journal = 1;
+				goto drop;
+			}
 
 			/*
 			 * only drop a reference if this transaction modified
@@ -1812,6 +1852,8 @@ int jbd2_journal_forget(handle_t *handle, struct buffer_head *bh)
 drop:
 	__brelse(bh);
 	spin_unlock(&jh->b_state_lock);
+	if (abort_journal)
+		jbd2_journal_abort(journal, err);
 	if (wait_for_writeback)
 		wait_on_buffer(bh);
 	jbd2_journal_put_journal_head(jh);
@@ -2136,7 +2178,8 @@ bool jbd2_journal_try_to_free_buffers(journal_t *journal, struct folio *folio)
 	struct buffer_head *bh;
 	bool ret = false;
 
-	J_ASSERT(folio_test_locked(folio));
+	if (WARN_ON_ONCE(!folio_test_locked(folio)))
+		return false;
 
 	head = folio_buffers(folio);
 	bh = head;
@@ -2651,6 +2694,8 @@ static int jbd2_journal_file_inode(handle_t *handle, struct jbd2_inode *jinode,
 {
 	transaction_t *transaction = handle->h_transaction;
 	journal_t *journal;
+	int err = 0;
+	int abort_transaction = 0;
 
 	if (is_handle_aborted(handle))
 		return -EROFS;
@@ -2685,20 +2730,33 @@ static int jbd2_journal_file_inode(handle_t *handle, struct jbd2_inode *jinode,
 	/* On some different transaction's list - should be
 	 * the committing one */
 	if (jinode->i_transaction) {
-		J_ASSERT(jinode->i_next_transaction == NULL);
-		J_ASSERT(jinode->i_transaction ==
-					journal->j_committing_transaction);
+		if (WARN_ON_ONCE(jinode->i_next_transaction ||
+				 jinode->i_transaction !=
+				 journal->j_committing_transaction)) {
+			pr_err("JBD2: %s: assertion failure: i_next_transaction=%p i_transaction=%p j_committing_transaction=%p\n",
+			       journal->j_devname, jinode->i_next_transaction,
+			       jinode->i_transaction,
+			       journal->j_committing_transaction);
+			err = -EINVAL;
+			abort_transaction = 1;
+			goto done;
+		}
 		jinode->i_next_transaction = transaction;
 		goto done;
 	}
 	/* Not on any transaction list... */
-	J_ASSERT(!jinode->i_next_transaction);
+	if (WARN_ON_ONCE(jinode->i_next_transaction)) {
+		err = -EINVAL;
+		abort_transaction = 1;
+		goto done;
+	}
 	jinode->i_transaction = transaction;
 	list_add(&jinode->i_list, &transaction->t_inode_list);
 done:
 	spin_unlock(&journal->j_list_lock);
-
-	return 0;
+	if (abort_transaction)
+		jbd2_journal_abort(journal, err);
+	return err;
 }
 
 int jbd2_journal_inode_ranged_write(handle_t *handle,
-- 
2.53.0


