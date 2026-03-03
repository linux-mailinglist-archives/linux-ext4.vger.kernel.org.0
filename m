Return-Path: <linux-ext4+bounces-14572-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCWaN2wip2mMegAAu9opvQ
	(envelope-from <linux-ext4+bounces-14572-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Tue, 03 Mar 2026 19:03:24 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE491F4EA4
	for <lists+linux-ext4@lfdr.de>; Tue, 03 Mar 2026 19:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 901C33085B47
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Mar 2026 18:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F580377EA6;
	Tue,  3 Mar 2026 18:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2nY9GbK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FE0377EB0
	for <linux-ext4@vger.kernel.org>; Tue,  3 Mar 2026 18:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772560927; cv=none; b=XsYxyMWjrEQv6b/xRtPh7IaHt9rZId7tu/4N5TJpvX/LYgJJfpTNIzaLmx9+bl7Zx22YGaiI8aculpcW9LqnddW6RSgohr7/xFncIARlCiULdSI8jISXzkj2TfDU5OT8MHHHD5XWQG9XDLARv5YbICJ8zRJ8JDweWm1sk5wknQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772560927; c=relaxed/simple;
	bh=+qGADK3hc8JKCWj7GguvVBLxpYgnyMyBrv5MYiGxtCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dldhlb0fPkNsh9+mYlyofsxc3e5V3VvHktis2k3IE3VN5Rr4rStfPYUQ6+TZwaQMynodV5jlNytNsvyUpVzfkyO5CL1dFvOfPYa3E9EkTzo/N0W2RCul9KpKw2D26yI8bU8V5jreD3dnI6/MBHgt6Z0gxeykTp4F9pl2A9Sn86s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2nY9GbK; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso5564044eec.1
        for <linux-ext4@vger.kernel.org>; Tue, 03 Mar 2026 10:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772560925; x=1773165725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lDaZthny2THuP7ev8syfJWkMisufRuRYdnb675O2Q98=;
        b=S2nY9GbKNZVyzqT/I69R2PUe8eaiP7SNkzrIvFP6Q9L+W6TatUrGV2FzTWT0kusXnC
         zPtiHaAgLmaVJf9OlceDPzj1nVVzMr2TJKmsHTdhGg2NZA7i9cEZonQspM8eCU4mbXrq
         icksx+tq1XKjFKs81k4yDTChRGlD7uwmNDBx/8jo99weU/wlQHAPimlu/eGg/EP7pCwJ
         hdzZVfcLDehSNPjsXsO55CLUMSPyBq6o+AwACJSzdz074JUfjuwsKqFW13XpI62Bs2q0
         lEH5YmTZ7ISN+MaPuHlsv0RqPjEIxtChRS3PUs3C5Y6XTWnsbH+37wQxyQCxx+mXuScR
         xaGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772560925; x=1773165725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lDaZthny2THuP7ev8syfJWkMisufRuRYdnb675O2Q98=;
        b=O0N+tjFUE9qsYbI+3b/zNbl+zIad+PEZ6da/ew8RQkbD+8HoJu7SQly6GRYb5RKs63
         wRCC9JN4/Ux+enljkRPEQWjD1VLQ8AAkL99QenR8goaKbOULPMlJfX1uyWJwjQZZsBAR
         nY3E32q5/VZLViBVAQf5+1cHB9V1rv2KKdyGPLpD600Nkc9zRanykRjSmGI7uo3Wk8pX
         kRMVLWZXbAl2Oyh8vqstuvYIvmy6AX71D5ftgWirLxFdTKt/NRwLjgRbqmEtsfI+FqVx
         R5e6HCncpgVjLFcPYQExwlFI/rrhAnliA6/o7SH9B/6H8kOJMglbEHXpJ28ar3zNUbXB
         8rrA==
X-Forwarded-Encrypted: i=1; AJvYcCWmIhVhzcx6uOX5bP0rMzFcb/m5Ii8/dkY0IFjmKKu+iZ1WPjoE3YHRfBmIc2sTTeOzDHchaOhkInOg@vger.kernel.org
X-Gm-Message-State: AOJu0YyiaDAhGGKzZeP78oPtTL1NDgSjTE3SXNJlElFbr34t2apHkCi2
	2yC2QGUjKnS6jo/erBst621Qwz6nIuWmh0zGqt37a64WhH7apRgViH4U
X-Gm-Gg: ATEYQzxqHu/6nZKEEUkBBqHWnchvBGz1V7YnKn2+w0fZyUN6s5zprfuqNthsqfN+IIC
	oXdQhMGY88wL1qOoVeScHBWBruwko479nPCMka/utMSPUejvc0q/5xpCKgrDjBogpPCiguLzHGZ
	0/KDrJExleQIGRNzk5jxoxXUOP52OnOKZjTG1JTcodNfIvAKrND0ArHThIE60DP12ecUXgDuIfc
	yWlMWjWA4DKjxvuJs4h6KwXRrg2zK81mrstU0CDinzyFPC/3j6bJvJyaAQwJb3LOLDh/cLzy2LB
	I8ifruJ3j4s/fxlBImH0DDIn4eX14s9z6pbZvBaibWoWykkqTVtBlOAvcteDWCW99Yy8kjy3yB2
	9hyfMme0nDQmVGQMLmcAtcnSw3K3pBhYXsqBInKsgU/OUb8Txj8qMjnVtkpnVMsXsH3ZEFay2ow
	xp89tuMNnD9lZbQqOaqbW4O2II8rxxZaieY+T4FtOb/UyKSu7o68Jxt0+IzrbQ/XyRmLj7cgzQH
	U5fTm+g5z4nBCiJa4EQNM7JGKPg2df3xfUq1sGu4v9oKs+DB3tKb85d9uXSZfuByWPmRPMsy8Qa
X-Received: by 2002:a05:693c:4084:b0:2ba:9115:2fab with SMTP id 5a478bee46e88-2bde1bb8214mr4781726eec.12.1772560924929;
        Tue, 03 Mar 2026 10:02:04 -0800 (PST)
Received: from arch.guest.box.net ([8.39.49.136])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdfba0df2fsm9506612eec.7.2026.03.03.10.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 10:02:04 -0800 (PST)
From: Milos Nikic <nikic.milos@gmail.com>
To: jack@suse.cz
Cc: tytso@mit.edu,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Milos Nikic <nikic.milos@gmail.com>
Subject: [PATCH v4 2/2] jbd2: gracefully abort on transaction state corruptions
Date: Tue,  3 Mar 2026 10:01:57 -0800
Message-ID: <20260303180157.53061-3-nikic.milos@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303180157.53061-1-nikic.milos@gmail.com>
References: <20260303180157.53061-1-nikic.milos@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5EE491F4EA4
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
	TAGGED_FROM(0.00)[bounces-14572-lists,linux-ext4=lfdr.de];
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
 fs/jbd2/transaction.c | 112 ++++++++++++++++++++++++++++++++----------
 1 file changed, 86 insertions(+), 26 deletions(-)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 04d17a5f2a82..bae6c99d635c 100644
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
@@ -1557,8 +1586,6 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
 		goto out_unlock_bh;
 	}
 
-	journal = transaction->t_journal;
-
 	if (jh->b_modified == 0) {
 		/*
 		 * This buffer's got modified and becoming part
@@ -1636,7 +1663,10 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
 	}
 
 	/* That test should have eliminated the following case: */
-	J_ASSERT_JH(jh, jh->b_frozen_data == NULL);
+	if (WARN_ON_ONCE(jh->b_frozen_data)) {
+		ret = -EINVAL;
+		goto out_unlock_bh;
+	}
 
 	JBUFFER_TRACE(jh, "file as BJ_Metadata");
 	spin_lock(&journal->j_list_lock);
@@ -1675,6 +1705,7 @@ int jbd2_journal_forget(handle_t *handle, struct buffer_head *bh)
 	int err = 0;
 	int was_modified = 0;
 	int wait_for_writeback = 0;
+	int abort_journal = 0;
 
 	if (is_handle_aborted(handle))
 		return -EROFS;
@@ -1708,7 +1739,11 @@ int jbd2_journal_forget(handle_t *handle, struct buffer_head *bh)
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
@@ -1747,8 +1782,11 @@ int jbd2_journal_forget(handle_t *handle, struct buffer_head *bh)
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
@@ -1766,7 +1804,11 @@ int jbd2_journal_forget(handle_t *handle, struct buffer_head *bh)
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
@@ -1812,6 +1854,8 @@ int jbd2_journal_forget(handle_t *handle, struct buffer_head *bh)
 drop:
 	__brelse(bh);
 	spin_unlock(&jh->b_state_lock);
+	if (abort_journal)
+		jbd2_journal_abort(journal, err);
 	if (wait_for_writeback)
 		wait_on_buffer(bh);
 	jbd2_journal_put_journal_head(jh);
@@ -2136,7 +2180,8 @@ bool jbd2_journal_try_to_free_buffers(journal_t *journal, struct folio *folio)
 	struct buffer_head *bh;
 	bool ret = false;
 
-	J_ASSERT(folio_test_locked(folio));
+	if (WARN_ON_ONCE(!folio_test_locked(folio)))
+		return false;
 
 	head = folio_buffers(folio);
 	bh = head;
@@ -2651,6 +2696,8 @@ static int jbd2_journal_file_inode(handle_t *handle, struct jbd2_inode *jinode,
 {
 	transaction_t *transaction = handle->h_transaction;
 	journal_t *journal;
+	int err = 0;
+	int abort_transaction = 0;
 
 	if (is_handle_aborted(handle))
 		return -EROFS;
@@ -2685,20 +2732,33 @@ static int jbd2_journal_file_inode(handle_t *handle, struct jbd2_inode *jinode,
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


