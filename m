Return-Path: <linux-ext4+bounces-14452-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLIXJQUNpmlkJgAAu9opvQ
	(envelope-from <linux-ext4+bounces-14452-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Mar 2026 23:19:49 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7E91E532E
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Mar 2026 23:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C138326821F
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Mar 2026 21:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB7538238F;
	Mon,  2 Mar 2026 21:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gr5HHC1x"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B73C38238A
	for <linux-ext4@vger.kernel.org>; Mon,  2 Mar 2026 21:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772487280; cv=none; b=saEdrqbo/Qcv5l9KM+28e404gN5c9gGNH7puO4D7JfzV+xm4YI/AW9f0RaLDZRU+MOPEMARe3spgxTTR8ltT7F9cOL/gmXbZY6Vl7x7GfdK9YEiseVBYdoFW2mmZeNTyFGmgUbrDXHDpbJ3kr73fRLdpeie3q861rpc6BFM6HIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772487280; c=relaxed/simple;
	bh=2w4NYmNXC6W52+BIHCjdUycts2WYUcggQH+JBNiF3n8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gdfHd2niFTZeIR0NaEn8LCR+egv9+UoL2CakbTg43P0+3QHuwcg1TRyURcBRRe+iQGes6PcnfmymgJUMizr9tHjN4rI0C12cD+n97/BF9phkKYtXMCtGdmlpIxrDz9zr3YBNRkuYGZkRrVuI49Ir5b3f+zRXbZF5cGcvQ3wHD/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gr5HHC1x; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-12713e56abdso2979720c88.1
        for <linux-ext4@vger.kernel.org>; Mon, 02 Mar 2026 13:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772487278; x=1773092078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MWiykqLPzQ0xTr9Kr/6ehg+AMSjO73dUzFgcIu/BQ7Q=;
        b=gr5HHC1x3VJoLIRJ2IRTbXmgJJSE9n/S4H1nau267HZydpHJLIl/S315Dd1C1R5O8p
         HQHTrCFU+87nQgZGR6vOvFq/Kmr1GHxSdoqaWSlRNfi/9cXTEFs6tmDpuLX5kwJhRzWS
         C5vQaw8iBSdkXLiF84D0FU60QSTGyXK7qPu4WpP29By89cY9T1VSwFAbTr6o+drMLYiK
         YwS0LP36YVg3ndOOYxdSD4nl8eD4quDxXAKPF1MFc1SU6M6ht5SHyV8FFYqR8VwzkgNN
         ZjOC3OrNkyIdGPkMnHCulTmw8Ek3TaHCaBjC4d+KowxKn5H9RjS6isTmXpmKu5kIQFVH
         kM8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772487278; x=1773092078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MWiykqLPzQ0xTr9Kr/6ehg+AMSjO73dUzFgcIu/BQ7Q=;
        b=WLU4OibMPsyBiaY1NyquzBBzo9PFx0nYqi7RZKOIxfDYV9R96GJoZ9Se4koCbDfbkb
         F+LCeKDrU1+eGSdeFY0OIhfHj3lKk1DlhlOI6tbLmir5RQNQnItobW1xL1SjwKaODOK8
         wcuVNfhqwievUr5/cMDEBE26REXxfO8OvKpGhykxkOF6XZTJ/zbr299dgyX5F2w+82Vv
         0GF4K4XIkcEMOUM2BFM/uJQblk4UjV9VpBGETfNrwo2WXuYCaXNyTIl7zNQSXx56ZuzQ
         LJn403EfdoyjkEsYp04B++PdB//8mQwAzBdnPq7ODSnyvU74dqC5NKTOTBoBJfejFjBA
         sRIA==
X-Forwarded-Encrypted: i=1; AJvYcCWPMnF7fqp9uwp+veR6YxIgyq6cig4U855CLSkpijUbyFKFO5UvJHZ1p7gnBuEkoFdiZF6T5rZHQMkJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwOjd6L3irUJdrjtL+pyK1XyVAOceFZ1UuPnkW98fZm45P8oZv0
	N9KDhYaOiea+Wf6qwWBg5RL76QtVSRrL55HtlP2i7cytGmVUBQr0QCDO
X-Gm-Gg: ATEYQzzNfl35Dc6bJQ5hvPXe0AB6uugDNfijdBCsIAUup79mRRM/4k8Ym6RRIqdT7Q2
	osAZzsfo2KlPdSIsXqj5ONyUpMDU5GvcpsCCEEXgCLafGDS5DtIlmF4VvlzGhNBNo20ckjWC923
	Ia7Jq6LfQrG65OUi+Rv0bOkSMaGhjYsy4T3/95yKwG8pwCUcFxka3g+0pCzy3qANwIzzd/KEByK
	TR0/BB+Rpzxdl38f3ERiBLX9b+swgNr+L7LB0oOQdMNimJyiZfDTLB7Brj6438bR+kZeENdV+FC
	ZBlbK5IAYgdHSbPnUn8ks+GmISNgswfLzgDRaX0vhMwtPUoBim+SKjZwGBWLa7V1TY86CXiZk6c
	HOF5TgWN9sXW9NO14wuoMeFdxMkVXhBodD717CKZBMZyYOahDkMNPcJS+/iOekfzKcKWql8O+sW
	R94M+mmrinUKKLzMjcJQKka/Ek3sDUF5xKnFwZJfzg8kRot3gzoUzeO7V5SIb0sR26Leme3BHdH
	zskCsvWUHLeX0YRWpmvR5RCtXqZpUdIW6rGsKyUDTdfW5M5MCjdHmWswMRgW04Brro+GFm9X3GD
	jXJ4OXTGt4Ix970THfLcxctN0FFJ
X-Received: by 2002:a05:7022:ba0:b0:119:e569:f86c with SMTP id a92af1059eb24-1278f79f1fcmr5552563c88.9.1772487278309;
        Mon, 02 Mar 2026 13:34:38 -0800 (PST)
Received: from arch.lan (c-98-51-119-100.hsd1.ca.comcast.net. [98.51.119.100])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12789a52ab0sm20032605c88.15.2026.03.02.13.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 13:34:37 -0800 (PST)
From: Milos Nikic <nikic.milos@gmail.com>
To: jack@suse.cz
Cc: tytso@mit.edu,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Milos Nikic <nikic.milos@gmail.com>
Subject: [PATCH v2 2/2] jbd2: gracefully abort on transaction state corruptions
Date: Mon,  2 Mar 2026 13:34:25 -0800
Message-ID: <20260302213425.273187-3-nikic.milos@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302213425.273187-1-nikic.milos@gmail.com>
References: <20260302213425.273187-1-nikic.milos@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3E7E91E532E
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
	TAGGED_FROM(0.00)[bounces-14452-lists,linux-ext4=lfdr.de];
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
 fs/jbd2/transaction.c | 95 +++++++++++++++++++++++++++++++++----------
 1 file changed, 74 insertions(+), 21 deletions(-)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 04d17a5f2a82..85e9338ed999 100644
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
@@ -1069,13 +1076,24 @@ do_get_write_access(handle_t *handle, struct journal_head *jh,
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
+		spin_unlock(&jh->b_state_lock);
+		error = -EINVAL;
+		jbd2_journal_abort(journal, error);
+		goto out;
+	}
 
 	/*
 	 * There is one case we have to be very careful about.  If the
@@ -1520,8 +1538,11 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
 	if (data_race(jh->b_transaction != transaction &&
 	    jh->b_next_transaction != transaction)) {
 		spin_lock(&jh->b_state_lock);
-		J_ASSERT_JH(jh, jh->b_transaction == transaction ||
-				jh->b_next_transaction == transaction);
+		if (WARN_ON_ONCE(jh->b_transaction != transaction &&
+				 jh->b_next_transaction != transaction)) {
+			ret = -EINVAL;
+			goto out_unlock_bh;
+		}
 		spin_unlock(&jh->b_state_lock);
 	}
 	if (data_race(jh->b_modified == 1)) {
@@ -1536,8 +1557,11 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
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
@@ -1636,7 +1660,10 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
 	}
 
 	/* That test should have eliminated the following case: */
-	J_ASSERT_JH(jh, jh->b_frozen_data == NULL);
+	if (WARN_ON_ONCE(jh->b_frozen_data)) {
+		ret = -EINVAL;
+		goto out_unlock_bh;
+	}
 
 	JBUFFER_TRACE(jh, "file as BJ_Metadata");
 	spin_lock(&journal->j_list_lock);
@@ -1675,6 +1702,7 @@ int jbd2_journal_forget(handle_t *handle, struct buffer_head *bh)
 	int err = 0;
 	int was_modified = 0;
 	int wait_for_writeback = 0;
+	int abort_journal = 0;
 
 	if (is_handle_aborted(handle))
 		return -EROFS;
@@ -1708,7 +1736,11 @@ int jbd2_journal_forget(handle_t *handle, struct buffer_head *bh)
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
@@ -1747,8 +1779,11 @@ int jbd2_journal_forget(handle_t *handle, struct buffer_head *bh)
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
@@ -1766,7 +1801,11 @@ int jbd2_journal_forget(handle_t *handle, struct buffer_head *bh)
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
@@ -1812,6 +1851,8 @@ int jbd2_journal_forget(handle_t *handle, struct buffer_head *bh)
 drop:
 	__brelse(bh);
 	spin_unlock(&jh->b_state_lock);
+	if (abort_journal)
+		jbd2_journal_abort(journal, err);
 	if (wait_for_writeback)
 		wait_on_buffer(bh);
 	jbd2_journal_put_journal_head(jh);
@@ -2136,7 +2177,8 @@ bool jbd2_journal_try_to_free_buffers(journal_t *journal, struct folio *folio)
 	struct buffer_head *bh;
 	bool ret = false;
 
-	J_ASSERT(folio_test_locked(folio));
+	if (WARN_ON_ONCE(!folio_test_locked(folio)))
+		return false;
 
 	head = folio_buffers(folio);
 	bh = head;
@@ -2651,6 +2693,8 @@ static int jbd2_journal_file_inode(handle_t *handle, struct jbd2_inode *jinode,
 {
 	transaction_t *transaction = handle->h_transaction;
 	journal_t *journal;
+	int err = 0;
+	int abort_transaction = 0;
 
 	if (is_handle_aborted(handle))
 		return -EROFS;
@@ -2685,20 +2729,29 @@ static int jbd2_journal_file_inode(handle_t *handle, struct jbd2_inode *jinode,
 	/* On some different transaction's list - should be
 	 * the committing one */
 	if (jinode->i_transaction) {
-		J_ASSERT(jinode->i_next_transaction == NULL);
-		J_ASSERT(jinode->i_transaction ==
-					journal->j_committing_transaction);
+		if (WARN_ON_ONCE(jinode->i_next_transaction ||
+				 jinode->i_transaction !=
+				 journal->j_committing_transaction)) {
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


