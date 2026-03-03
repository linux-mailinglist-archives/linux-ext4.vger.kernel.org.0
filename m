Return-Path: <linux-ext4+bounces-14466-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLwXHhsypmnKMAAAu9opvQ
	(envelope-from <linux-ext4+bounces-14466-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Tue, 03 Mar 2026 01:58:03 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DF71E76E4
	for <lists+linux-ext4@lfdr.de>; Tue, 03 Mar 2026 01:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B35BB304F5C6
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Mar 2026 00:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5353B1B81CA;
	Tue,  3 Mar 2026 00:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6zxz3O0"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E3223D281
	for <linux-ext4@vger.kernel.org>; Tue,  3 Mar 2026 00:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772499319; cv=none; b=FMjRMlIyvZo1ljL4d3AE47ri9ClDfytY/H4gPMQU43L86g/VtEQNWsgeb0u39eEM+soTk5UtD9Yo9Cv0nczNUhywemzj4fCWOEbYeBAdWYt9WROuM2Z6b+uV9VPFhvd+v+/anqjm6Vn2fhwv0P0niBM6t79MVTVVHmwqSkxyvBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772499319; c=relaxed/simple;
	bh=zbyzfNx8/Pak6zoD/choS8v5s28io8lQmomT+XUdy48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C2hXealDSNC/F5IvxIFkPXqWYl5AHVopBoNDksRzBBMcyM0B10v4+G2gZCWrVTGA2PK4oCsD8sN7FzPjWvLqHRqgZV5Pt0dqr5rhzBBwmdjcJEeSq6sUHigSKc1dIVOmKyJN7TVCnG9hTsazgvveuKeGkHJ1+wpUo04UfdQMth4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6zxz3O0; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-127380532eeso2212056c88.1
        for <linux-ext4@vger.kernel.org>; Mon, 02 Mar 2026 16:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772499315; x=1773104115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJwawZM7sG51IM4V5SWWW2Cn1eGnHGmPjyUNqQUV4dM=;
        b=U6zxz3O0Xoo4xgidY5krm1cW9RuWevBQaUrU8aQmDzDH9rRuiRYOdYhG82u7KVUFk/
         h28Ymwtz1k3AJgpSxaEeisG9k7UeixaaXjyBUR/QnCuLCKQO6BdVV2l6d+Nh+xgaW1k1
         KEg2j4aITZRq72Y33kwpgqiyc3k9Pfffy5ZrStCfbUOtiMBpM3Q+dNP3KVKJIbXO7bx3
         FTn2E3GOspTAKeHqWM3+rErdh3o3+Nxl2V4kc/c3WoW99/LbCJ5CppufdBCe7XaxcWGc
         azLKx9KOKapMsVTopoe6YYrSEFmj1eLoNId3kRVc2Cymt+Gev07pjnkcPphfw7/jock1
         0qNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772499315; x=1773104115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cJwawZM7sG51IM4V5SWWW2Cn1eGnHGmPjyUNqQUV4dM=;
        b=njCvvNjdgV+AiZt9hqbGshAwB3obwWIe0NK0g1wavnvf16Wx2J3xHIeJZGwIubRmO2
         2neuIZGsNHB07GmYaeCeGvDPwEp44Acb3S2RYW1VSyHfNPQoVQpOXnLFK9OEtJMdyken
         RGOKuhQ6/Hi+QOLaWQnJ4R/rob1Qs1uyjwTlv5hw/yPmveygydW16zN7GyHNilBr38kO
         8otOjrrCj3G5yN80hJdaVmA5vxMMYA4skMlhiWUsBFv7WH9G/nXpqxJFem49JzD5KH7A
         n5PPYxGlVNLBsKP4MIGGIN+lFluVtqPiuZtmlbOG3MFLb/U+nkBdjg9+8t8JPtdLv0qN
         Uq2Q==
X-Forwarded-Encrypted: i=1; AJvYcCU+NLxFatEmNv2MKiSdoNqZAZR2s0lHpDxK3IuZrdYrMixD3fQRo72jhMb/WFLB2j51HoKCLtnQ/ma1@vger.kernel.org
X-Gm-Message-State: AOJu0YxYPCE6QPNnVIbGB3vpCL3N51oODly/A8BM4/FIaNgc0YEjPWRe
	2s0mCmtP2afv33LKvFB9pjeRjfjiOOcvd78t4P5oJex2/yC9E5DRuU/d
X-Gm-Gg: ATEYQzx17x5vWFmNPSnQlNCb8YCD6rU4Jfmqo6ob6trNBLUaJlCwkQ47juGAuz2aTam
	MU8PEu0UIjebhqwZKvF/LbigWzRdMScwZ2CF3WGzMN5zXwd1U9CQ5fYmauZAxAFTTXTCuGiBQxn
	Lbke39xCUZwl6AO2oWrO3yz0tBhiR5mYjbXARnRPmGuhMILJ2+KOBO3ici2IwIp/0eswPce6Y5N
	sLfeTQKBm1xd4eA3Cw3Ffi5GOkR5PTuTj2Ch2ZIJNpsvGpnWXKJC8pPu2DkacjSMByu0E3oyKa6
	GVTgenk+bjyrIFJdlGG8Fj7caz41j7/3ionWtvE42wjoW6k4CmugsEETHSUeDmcsk89NtdcRvWG
	FFAejwhBg+J/mUT3xi2b1kLFU1BCYQPN2uwB+t32aqWkn7i4n9+7tYIslda5wpV0hsp6MlGZtxL
	UV3FWCJ+y5kZNbA0RA0Ql6jRXB5c2Id1pRoCqZrAK2rkwukjqSnhMg/Cy2RwBBb3JbbKEdchxVS
	YNpj2GBFTGdsjGkU97udIOfgK6jbccd0FbhoGHV/RsRb/XgxzssIt5WxJleoCkClOEC4jiRcv+E
	t1iJDDkqYRCKAonzCGBSZZqzliH4
X-Received: by 2002:a05:7022:911:b0:11b:88a7:e1ac with SMTP id a92af1059eb24-1278fc6beecmr6799560c88.19.1772499315143;
        Mon, 02 Mar 2026 16:55:15 -0800 (PST)
Received: from arch.lan (c-98-51-119-100.hsd1.ca.comcast.net. [98.51.119.100])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1279cbd1993sm6552005c88.2.2026.03.02.16.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 16:55:13 -0800 (PST)
From: Milos Nikic <nikic.milos@gmail.com>
To: jack@suse.cz
Cc: tytso@mit.edu,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Milos Nikic <nikic.milos@gmail.com>
Subject: [PATCH v3 2/2] jbd2: gracefully abort on transaction state corruptions
Date: Mon,  2 Mar 2026 16:55:02 -0800
Message-ID: <20260303005502.337108-3-nikic.milos@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303005502.337108-1-nikic.milos@gmail.com>
References: <20260303005502.337108-1-nikic.milos@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 11DF71E76E4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[mit.edu,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14466-lists,linux-ext4=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikicmilos@gmail.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
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
---
 fs/jbd2/transaction.c | 108 +++++++++++++++++++++++++++++++++---------
 1 file changed, 85 insertions(+), 23 deletions(-)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 04d17a5f2a82..3cb4e524e0a6 100644
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
@@ -1531,13 +1558,15 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
 			spin_lock(&jh->b_state_lock);
 			if (jh->b_transaction == transaction &&
 			    jh->b_jlist != BJ_Metadata)
-				pr_err("JBD2: assertion failure: h_type=%u "
-				       "h_line_no=%u block_no=%llu jlist=%u\n",
+				pr_err("JBD2: assertion failure: h_type=%u h_line_no=%u block_no=%llu jlist=%u\n",
 				       handle->h_type, handle->h_line_no,
 				       (unsigned long long) bh->b_blocknr,
 				       jh->b_jlist);
-			J_ASSERT_JH(jh, jh->b_transaction != transaction ||
-					jh->b_jlist == BJ_Metadata);
+			if (WARN_ON_ONCE(jh->b_transaction == transaction &&
+					 jh->b_jlist != BJ_Metadata)) {
+				ret = -EINVAL;
+				goto out_unlock_bh;
+			}
 			spin_unlock(&jh->b_state_lock);
 		}
 		goto out;
@@ -1636,7 +1665,10 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
 	}
 
 	/* That test should have eliminated the following case: */
-	J_ASSERT_JH(jh, jh->b_frozen_data == NULL);
+	if (WARN_ON_ONCE(jh->b_frozen_data)) {
+		ret = -EINVAL;
+		goto out_unlock_bh;
+	}
 
 	JBUFFER_TRACE(jh, "file as BJ_Metadata");
 	spin_lock(&journal->j_list_lock);
@@ -1675,6 +1707,7 @@ int jbd2_journal_forget(handle_t *handle, struct buffer_head *bh)
 	int err = 0;
 	int was_modified = 0;
 	int wait_for_writeback = 0;
+	int abort_journal = 0;
 
 	if (is_handle_aborted(handle))
 		return -EROFS;
@@ -1708,7 +1741,11 @@ int jbd2_journal_forget(handle_t *handle, struct buffer_head *bh)
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
@@ -1747,8 +1784,11 @@ int jbd2_journal_forget(handle_t *handle, struct buffer_head *bh)
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
@@ -1766,7 +1806,11 @@ int jbd2_journal_forget(handle_t *handle, struct buffer_head *bh)
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
@@ -1812,6 +1856,8 @@ int jbd2_journal_forget(handle_t *handle, struct buffer_head *bh)
 drop:
 	__brelse(bh);
 	spin_unlock(&jh->b_state_lock);
+	if (abort_journal)
+		jbd2_journal_abort(journal, err);
 	if (wait_for_writeback)
 		wait_on_buffer(bh);
 	jbd2_journal_put_journal_head(jh);
@@ -2136,7 +2182,8 @@ bool jbd2_journal_try_to_free_buffers(journal_t *journal, struct folio *folio)
 	struct buffer_head *bh;
 	bool ret = false;
 
-	J_ASSERT(folio_test_locked(folio));
+	if (WARN_ON_ONCE(!folio_test_locked(folio)))
+		return false;
 
 	head = folio_buffers(folio);
 	bh = head;
@@ -2651,6 +2698,8 @@ static int jbd2_journal_file_inode(handle_t *handle, struct jbd2_inode *jinode,
 {
 	transaction_t *transaction = handle->h_transaction;
 	journal_t *journal;
+	int err = 0;
+	int abort_transaction = 0;
 
 	if (is_handle_aborted(handle))
 		return -EROFS;
@@ -2685,20 +2734,33 @@ static int jbd2_journal_file_inode(handle_t *handle, struct jbd2_inode *jinode,
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


