Return-Path: <linux-ext4+bounces-2942-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C76329154F1
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Jun 2024 19:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 048491C21F73
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Jun 2024 17:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821F219EEBF;
	Mon, 24 Jun 2024 17:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lP2g79cn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VEUQmQYj"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBB619DF7E;
	Mon, 24 Jun 2024 17:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719248492; cv=none; b=GB8+nyobx4KqF3KVjhcTapzHtRfq7iAkDM/yBG0Qg2+OUZALS3r9Ki+oGhzgiZF8tyz/g1NdkeAkxW1zdQadqhjJPtWmwEmmfI7h7nvV6sr5e1EuGJxDZs6Ndz8HNQOYh859ySlIQw4oUdnUmuUSKXFXYyy+0YptbMulAt1CZ+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719248492; c=relaxed/simple;
	bh=NnEmCtBdW+n3T6C5nAw/DaOTt9luQR3DrIQjP/ARNgE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jFdJ1i8vgMazp1gLTG1ijShPqpjBZiT5lwgdnFgbVhgPgIeOBGzMh2jYgKs/wB7+YAs8GeBU+z+y5BhgKTdm8t3fTuWvmlyl/8tKClEqj+xuxs/jJv5/OdJOf3T+D5MUytfJouivdTvgclEvgoP89F4fMcgGtncg2XDb46Ptg2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lP2g79cn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VEUQmQYj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E3DC721A00;
	Mon, 24 Jun 2024 17:01:27 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719248487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PrZlJZZkKLRVxS70o1t/6F+VcFEZ0wDlkxQIfDUTTFY=;
	b=lP2g79cnmh25U+q6wt+8XA8o8jcP0jCC/JbCYllL7bUvnYRTVx0VPYJNrRM1Ic5XLdFA9U
	E8Ebed0nX9OsMS0X80w83imS62tnlROcS/XXIRl0cGrpT/P6+qznSAloXYDHwutN+FRrJE
	oLKVMhFgxa4n/1l+EXG3S/t0MRjrJfw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719248487;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PrZlJZZkKLRVxS70o1t/6F+VcFEZ0wDlkxQIfDUTTFY=;
	b=VEUQmQYjAPlgZs7jfT1Qs1fbMUU7jDeeU+eq0qI7WLC1m7UO9LtvkvrI80tWOHAGCjKMJc
	W2vJ60LNv6lgPlCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D7A9613AA4;
	Mon, 24 Jun 2024 17:01:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lOadNGemeWbGOAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 24 Jun 2024 17:01:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8081DA08C8; Mon, 24 Jun 2024 19:01:27 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Ted Tso <tytso@mit.edu>
Cc: <linux-ext4@vger.kernel.org>,
	Alexander Coffin <alex.coffin@maticrobots.com>,
	Jan Kara <jack@suse.cz>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/4] jbd2: Make jbd2_journal_get_max_txn_bufs() internal
Date: Mon, 24 Jun 2024 19:01:17 +0200
Message-Id: <20240624170127.3253-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240624165406.12784-1-jack@suse.cz>
References: <20240624165406.12784-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2188; i=jack@suse.cz; h=from:subject; bh=NnEmCtBdW+n3T6C5nAw/DaOTt9luQR3DrIQjP/ARNgE=; b=owGbwMvMwME4Z+4qdvsUh5uMp9WSGNIql8XKtx1aueW/n5W/j0rSXaG329RsD8kndFZdZ1H+3O/c 7f+2k9GYhYGRg0FWTJFldeRF7WvzjLq2hmrIwAxiZQKZwsDFKQATEbFg/194oiv1uMSx+QaXrJnq6m c9f2bQMnPZH4+mX10eG5hum8kx7F+6L3mZ+9fizJztCW7s32wsj6WxLZoSfPnYr+8xIqE6QlGrotsu uJXc39m4KOt4630/Np34Rw3SrL3zqqdvS/nfPt8t+UFCaU+Ee7/Udo6mjfsUGSXdV6/icbzxrmr3wQ 28UVOtYvrWhLDKazfsvJ559/K5vvi+KrPDM9tEsrS9xN/lO39hjv4XbqDlJMEvksO5h99E5e3HU/fX NReuMT3D0pzqxqZ8Kc+8X2Hdu1CtVN41P/su/aosN9vRFFAWyPLi18UDUTmNlyZULS5nnTf5+6JP/Z GieXdZ/KI+LfzF1/q8nLv6Sm4KAA==
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: E3DC721A00
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

There's no reason to have jbd2_journal_get_max_txn_bufs() public
function. Currently all users are internal and can use
journal->j_max_transaction_buffers instead. This saves some unnecessary
recomputations of the limit as a bonus which becomes important as this
function gets more complex in the following patch.

CC: stable@vger.kernel.org
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/commit.c     | 2 +-
 fs/jbd2/journal.c    | 5 +++++
 include/linux/jbd2.h | 5 -----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 75ea4e9a5cab..e7fc912693bd 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -766,7 +766,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 		if (first_block < journal->j_tail)
 			freed += journal->j_last - journal->j_first;
 		/* Update tail only if we free significant amount of space */
-		if (freed < jbd2_journal_get_max_txn_bufs(journal))
+		if (freed < journal->j_max_transaction_buffers)
 			update_tail = 0;
 	}
 	J_ASSERT(commit_transaction->t_state == T_COMMIT);
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 03c4b9214f56..1bb73750d307 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1698,6 +1698,11 @@ journal_t *jbd2_journal_init_inode(struct inode *inode)
 	return journal;
 }
 
+static int jbd2_journal_get_max_txn_bufs(journal_t *journal)
+{
+	return (journal->j_total_len - journal->j_fc_wbufsize) / 4;
+}
+
 /*
  * Given a journal_t structure, initialise the various fields for
  * startup of a new journaling session.  We use this both when creating
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index ab04c1c27fae..f91b930abe20 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1660,11 +1660,6 @@ int jbd2_wait_inode_data(journal_t *journal, struct jbd2_inode *jinode);
 int jbd2_fc_wait_bufs(journal_t *journal, int num_blks);
 int jbd2_fc_release_bufs(journal_t *journal);
 
-static inline int jbd2_journal_get_max_txn_bufs(journal_t *journal)
-{
-	return (journal->j_total_len - journal->j_fc_wbufsize) / 4;
-}
-
 /*
  * is_journal_abort
  *
-- 
2.35.3


