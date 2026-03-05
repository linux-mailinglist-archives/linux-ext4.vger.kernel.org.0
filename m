Return-Path: <linux-ext4+bounces-14655-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEMmMBd9qWnl8wAAu9opvQ
	(envelope-from <linux-ext4+bounces-14655-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 05 Mar 2026 13:54:47 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B58B2122A5
	for <lists+linux-ext4@lfdr.de>; Thu, 05 Mar 2026 13:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BB6D33037050
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Mar 2026 12:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E59E3A0B29;
	Thu,  5 Mar 2026 12:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="d6+fX6gq"
X-Original-To: linux-ext4@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CCF3A0E9B;
	Thu,  5 Mar 2026 12:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772715281; cv=none; b=q/SloEg+UjBx2Nide/K7u68i72PWqIaM5G4UqehO6eX8Osfz8HgWXAK+IVLuEUn3ZSRBqPx7XEVZTY2iIWYVxGyph5IDoWjuiQQE5T+FzJC8j/NlaojGoKo8jRws0Xuv/3pB8RgHlfCgdJchyLMUKtBvn47SWq/y7NiD2mSC+Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772715281; c=relaxed/simple;
	bh=GZk/N0E/wF8+Xx7ZO9AmbYjUoG01Cr7tbSFWJHf0+/k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IsVvf4sbLjgN1pgUuy6y5RskQfLBabjn1QV/ATgLmJm2nOFlaI34vJmPQmryLvw5vcoXv/dtKQGuOyrgWu/Nd+vU1BTAuYrFAcCt2X4hae1uZH15FPp7fiTq4PnjKdvzrQJxnqE+v+DoRzw1mEpLAyV6JURvfcBKvR1745nNE0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=d6+fX6gq; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=7B
	xrdldPld4NNfK57RZPi7vOl7bWXuAHdghwRK0VBzo=; b=d6+fX6gqBlNQ290tGl
	dAgPF2BaXWEALeGEJi6g2KCnD+dnO20D8wWf0j0N7gs+QGQObgCj7S6g0Fs/dYyu
	kWTR3ETRC6P9D2/otiZ7/1skBy6dPA5S9uTAFidu/gf9p0Reqf5deIxAoDGtS9JE
	yOG8qVMGuWOW16jz8EeUnwsfw=
Received: from liubaolin-VMware-Virtual-Platform.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wCnbX72fKlp1oFqPQ--.12728S2;
	Thu, 05 Mar 2026 20:54:16 +0800 (CST)
From: Baolin Liu <liubaolin12138@163.com>
To: tytso@mit.edu,
	jack@suse.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wangguanyu@vivo.com,
	Baolin Liu <liubaolin@kylinos.cn>
Subject: [PATCH v1] jbd2: check transaction state before stopping handle
Date: Thu,  5 Mar 2026 20:54:02 +0800
Message-Id: <20260305125402.71285-1-liubaolin12138@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnbX72fKlp1oFqPQ--.12728S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZry7Aw15Ar18ZF17Wr1xKrg_yoW5XF1kpr
	yrCw15Cw15Ka4jvFn7Zr4UArWYya48CryUGrZrKas3ta1agwn3t397t34jkrWDKrWrua48
	XryDCwnrGw4jka7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jY1v3UUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbCwhgi7GmpfPh70gAA35
X-Rspamd-Queue-Id: 5B58B2122A5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[163.com];
	TAGGED_FROM(0.00)[bounces-14655-lists,linux-ext4=lfdr.de];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liubaolin12138@163.com,linux-ext4@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-ext4];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Baolin Liu <liubaolin@kylinos.cn>

When a transaction enters T_FLUSH or later states,
handle->h_transaction may still point to it.
If jbd2_journal_stop() or jbd2__journal_restart() is called,
stop_this_handle() checks t_updates > 0, but t_updates is
already 0 for these states, causing a kernel BUG.

Fix by checking transaction->t_state in jbd2_journal_stop()
and jbd2__journal_restart() before calling stop_this_handle().
If the transaction is not in T_RUNNING or T_LOCKED state,
clear handle->h_transaction and skip stop_this_handle().

Crash stack:
  Call trace:
  stop_this_handle+0x148/0x158
  jbd2_journal_stop+0x198/0x388
  __ext4_journal_stop+0x70/0xf0
  ext4_create+0x12c/0x188
  lookup_open+0x214/0x6d8
  do_last+0x364/0x878
  path_openat+0x6c/0x280
  do_filp_open+0x70/0xe8
  do_sys_open+0x178/0x200
  sys_openat+0x3c/0x50
  el0_svc_naked+0x44/0x48

Signed-off-by: Baolin Liu <liubaolin@kylinos.cn>
---
 fs/jbd2/transaction.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index dca4b5d8aaaa..3779382dbb80 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -772,14 +772,25 @@ int jbd2__journal_restart(handle_t *handle, int nblocks, int revoke_records,
 	journal = transaction->t_journal;
 	tid = transaction->t_tid;
 
+	jbd2_debug(2, "restarting handle %p\n", handle);
+
+	/* Check if transaction is in invalid state */
+	if (transaction->t_state != T_RUNNING &&
+		transaction->t_state != T_LOCKED) {
+		if (current->journal_info == handle)
+			current->journal_info = NULL;
+		handle->h_transaction = NULL;
+		memalloc_nofs_restore(handle->saved_alloc_context);
+		goto skip_stop;
+	}
+
 	/*
 	 * First unlink the handle from its current transaction, and start the
 	 * commit on that.
 	 */
-	jbd2_debug(2, "restarting handle %p\n", handle);
 	stop_this_handle(handle);
 	handle->h_transaction = NULL;
-
+skip_stop:
 	/*
 	 * TODO: If we use READ_ONCE / WRITE_ONCE for j_commit_request we can
  	 * get rid of pointless j_state_lock traffic like this.
@@ -1856,6 +1867,16 @@ int jbd2_journal_stop(handle_t *handle)
 		memalloc_nofs_restore(handle->saved_alloc_context);
 		goto free_and_exit;
 	}
+	/* Check if transaction is in invalid state */
+	if (transaction->t_state != T_RUNNING &&
+		transaction->t_state != T_LOCKED) {
+		if (current->journal_info == handle)
+			current->journal_info = NULL;
+		handle->h_transaction = NULL;
+		memalloc_nofs_restore(handle->saved_alloc_context);
+		goto free_and_exit;
+	}
+
 	journal = transaction->t_journal;
 	tid = transaction->t_tid;
 
-- 
2.39.2


