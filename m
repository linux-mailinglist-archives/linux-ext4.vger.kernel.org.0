Return-Path: <linux-ext4+bounces-1185-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2339784F488
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Feb 2024 12:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD608280E2D
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Feb 2024 11:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DF73172D;
	Fri,  9 Feb 2024 11:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="N61BollO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hCokTXSr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0gM6P8zZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OjaWi0LD"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B848728DD3
	for <linux-ext4@vger.kernel.org>; Fri,  9 Feb 2024 11:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707477673; cv=none; b=AT4DLLY0CdywdBFbHAKh9BcZ1EUyXDlitPlNKlMjxNB9xY23QSE0nblFzWvUTbXGQj4OGPqMevVzITBWwVqksQVNl/5SW0SXjMMioPkL2bAblhhQ42fmXj50gm6+hD30kRUW4jdda4cgoj5GdMdtU4rLphOkoejgXvEYEOsg/xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707477673; c=relaxed/simple;
	bh=ZgRv1RrMMFV6faDFZQFNQFHk5qVSnLyeFhbw92ycZq0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SnO1DYys6NPDnOS0Jqntna/XMwnIjOXtIHaK7/oO2EIrDrxxj9AmM9a6/zyEtw9+0tuPoex6NdMv4SEwas3E+g4LLWK/iLYq+uEmJ8pM0Sn2Cv70OCMlhKiuQZoOrK7RLsouK11HoC7owfEU9qXvS3BlzH+KVlVhqcrJYDZLxok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=N61BollO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hCokTXSr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0gM6P8zZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OjaWi0LD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DF7421FD2F;
	Fri,  9 Feb 2024 11:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707477669; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Da2/tGFN9bdRp/05tWdng5jMOLZLXJ7tgdGIrOAFmU=;
	b=N61BollOaTuLhwIGqGTDUPD7dDMBClwHZa8YuTF2Kpxu2FmKHrdV/USJxpySEDRKb2Q3yt
	a+DEoA82m/aiZzdszJqWY7E+N4UQbV4BYlRLxJRaFWgBYHUX/BO/lpzpUUtRWjd/WmXUYz
	Miv/CnRsAyS1r9LY0TbcrJ1pyA9hYqY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707477669;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Da2/tGFN9bdRp/05tWdng5jMOLZLXJ7tgdGIrOAFmU=;
	b=hCokTXSrhq0x4p5dCd1qEFAURv/PWIytVbsnywEwrMneJyAgZtI31qukEMx25wpToRmrNu
	M5Zw32gj2Wi7NhAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707477667; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Da2/tGFN9bdRp/05tWdng5jMOLZLXJ7tgdGIrOAFmU=;
	b=0gM6P8zZoxKszGF3Lbr4sj6qbaPyKp9b8aCJ5nATYJcxCyvyj7Hzjd9j4rRssN+Iwj9dx5
	lYce5wG8AjW/naCrGlnIkO90qRx9V3KfivFu2EclKMIUBPQLHQShMKArzZVN+WJobPfHTw
	aV8kN8k1dhK6FothpnMZDYo/DVOZh3o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707477667;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Da2/tGFN9bdRp/05tWdng5jMOLZLXJ7tgdGIrOAFmU=;
	b=OjaWi0LDsF0GVZJ9FT+MKXGaUtNgNqQYJAqbrCoNnBvJ9WmRAYXxzvAA3j30xj8kZh9hCK
	+oVfhaVdD/DYXpBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C3FF913A29;
	Fri,  9 Feb 2024 11:21:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CdWnL6MKxmWeNQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 09 Feb 2024 11:21:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 766F7A080C; Fri,  9 Feb 2024 12:21:07 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: Ted Tso <tytso@mit.edu>
Cc: <linux-ext4@vger.kernel.org>,
	Jan Kara <jack@suse.cz>,
	syzbot+a43d4f48b8397d0e41a9@syzkaller.appspotmail.com
Subject: [PATCH 2/3] ext4: Do not create EA inode under buffer lock
Date: Fri,  9 Feb 2024 12:21:00 +0100
Message-Id: <20240209112107.10585-2-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240209111418.22308-1-jack@suse.cz>
References: <20240209111418.22308-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6571; i=jack@suse.cz; h=from:subject; bh=ZgRv1RrMMFV6faDFZQFNQFHk5qVSnLyeFhbw92ycZq0=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlxgqb2BgHtBFi5DGZU5bWz0IXQgIkSasoGo/hX3of Pitq9ByJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZcYKmwAKCRCcnaoHP2RA2TW/B/ 4504jDDokl0RjfekhrYuVnOrWasFHWdnL933l7aXbfkZmWe30FTwrKTrTeCbzJHn5QUi5W05nqTegV kd+wq3XhnmKhga8rxxvIZpDBmSp4qyExrB8N7hNLEniMKM1f8KzxDieG+qmg2PUgtgLWNr1611tX2A T5dIKvH7OesN0YqJVs0EtZ2oaDMxK6g4EJsqJvgTAe67lfuc1oWmSsKVDtw6xzKt3AbCQp4ai8HvZ9 IeUPtmr4Yuz6124JZZh8JP9ZqppQ/RJ/KlpB+Exi99Yqw6sgZQN1mu9oXUjpKFcKd691qif3dJFi1F /duOXopbUU09SplGB9s9bqRpFqnnTj
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.80
X-Spamd-Result: default: False [-1.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[a43d4f48b8397d0e41a9];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,appspotmail.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

ext4_xattr_set_entry() creates new EA inodes while holding buffer lock
on the external xattr block. This is problematic as it nests all the
allocation locking (which acquires locks on other buffers) under the
buffer lock. This can even deadlock when the filesystem is corrupted and
e.g. quota file is setup to contain xattr block as data block. Move the
allocation of EA inode out of ext4_xattr_set_entry() into the callers.

Reported-by: syzbot+a43d4f48b8397d0e41a9@syzkaller.appspotmail.com
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/xattr.c | 100 +++++++++++++++++++++++-------------------------
 1 file changed, 48 insertions(+), 52 deletions(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 146690c10c73..e7e1ffff8eba 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1619,6 +1619,7 @@ static struct inode *ext4_xattr_inode_lookup_create(handle_t *handle,
 static int ext4_xattr_set_entry(struct ext4_xattr_info *i,
 				struct ext4_xattr_search *s,
 				handle_t *handle, struct inode *inode,
+				struct inode *new_ea_inode,
 				bool is_block)
 {
 	struct ext4_xattr_entry *last, *next;
@@ -1626,7 +1627,6 @@ static int ext4_xattr_set_entry(struct ext4_xattr_info *i,
 	size_t min_offs = s->end - s->base, name_len = strlen(i->name);
 	int in_inode = i->in_inode;
 	struct inode *old_ea_inode = NULL;
-	struct inode *new_ea_inode = NULL;
 	size_t old_size, new_size;
 	int ret;
 
@@ -1711,38 +1711,11 @@ static int ext4_xattr_set_entry(struct ext4_xattr_info *i,
 			old_ea_inode = NULL;
 			goto out;
 		}
-	}
-	if (i->value && in_inode) {
-		WARN_ON_ONCE(!i->value_len);
-
-		new_ea_inode = ext4_xattr_inode_lookup_create(handle, inode,
-					i->value, i->value_len);
-		if (IS_ERR(new_ea_inode)) {
-			ret = PTR_ERR(new_ea_inode);
-			new_ea_inode = NULL;
-			goto out;
-		}
-	}
 
-	if (old_ea_inode) {
 		/* We are ready to release ref count on the old_ea_inode. */
 		ret = ext4_xattr_inode_dec_ref(handle, old_ea_inode);
-		if (ret) {
-			/* Release newly required ref count on new_ea_inode. */
-			if (new_ea_inode) {
-				int err;
-
-				err = ext4_xattr_inode_dec_ref(handle,
-							       new_ea_inode);
-				if (err)
-					ext4_warning_inode(new_ea_inode,
-						  "dec ref new_ea_inode err=%d",
-						  err);
-				ext4_xattr_inode_free_quota(inode, new_ea_inode,
-							    i->value_len);
-			}
+		if (ret)
 			goto out;
-		}
 
 		ext4_xattr_inode_free_quota(inode, old_ea_inode,
 					    le32_to_cpu(here->e_value_size));
@@ -1866,7 +1839,6 @@ static int ext4_xattr_set_entry(struct ext4_xattr_info *i,
 	ret = 0;
 out:
 	iput(old_ea_inode);
-	iput(new_ea_inode);
 	return ret;
 }
 
@@ -1929,9 +1901,21 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
 	size_t old_ea_inode_quota = 0;
 	unsigned int ea_ino;
 
-
 #define header(x) ((struct ext4_xattr_header *)(x))
 
+	/* If we need EA inode, prepare it before locking the buffer */
+	if (i->value && i->in_inode) {
+		WARN_ON_ONCE(!i->value_len);
+
+		ea_inode = ext4_xattr_inode_lookup_create(handle, inode,
+					i->value, i->value_len);
+		if (IS_ERR(ea_inode)) {
+			error = PTR_ERR(ea_inode);
+			ea_inode = NULL;
+			goto cleanup;
+		}
+	}
+
 	if (s->base) {
 		int offset = (char *)s->here - bs->bh->b_data;
 
@@ -1940,6 +1924,7 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
 						      EXT4_JTR_NONE);
 		if (error)
 			goto cleanup;
+
 		lock_buffer(bs->bh);
 
 		if (header(s->base)->h_refcount == cpu_to_le32(1)) {
@@ -1966,7 +1951,7 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
 			}
 			ea_bdebug(bs->bh, "modifying in-place");
 			error = ext4_xattr_set_entry(i, s, handle, inode,
-						     true /* is_block */);
+					     ea_inode, true /* is_block */);
 			ext4_xattr_block_csum_set(inode, bs->bh);
 			unlock_buffer(bs->bh);
 			if (error == -EFSCORRUPTED)
@@ -2034,29 +2019,13 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
 		s->end = s->base + sb->s_blocksize;
 	}
 
-	error = ext4_xattr_set_entry(i, s, handle, inode, true /* is_block */);
+	error = ext4_xattr_set_entry(i, s, handle, inode, ea_inode,
+				     true /* is_block */);
 	if (error == -EFSCORRUPTED)
 		goto bad_block;
 	if (error)
 		goto cleanup;
 
-	if (i->value && s->here->e_value_inum) {
-		/*
-		 * A ref count on ea_inode has been taken as part of the call to
-		 * ext4_xattr_set_entry() above. We would like to drop this
-		 * extra ref but we have to wait until the xattr block is
-		 * initialized and has its own ref count on the ea_inode.
-		 */
-		ea_ino = le32_to_cpu(s->here->e_value_inum);
-		error = ext4_xattr_inode_iget(inode, ea_ino,
-					      le32_to_cpu(s->here->e_hash),
-					      &ea_inode);
-		if (error) {
-			ea_inode = NULL;
-			goto cleanup;
-		}
-	}
-
 inserted:
 	if (!IS_LAST_ENTRY(s->first)) {
 		new_bh = ext4_xattr_block_cache_find(inode, header(s->base),
@@ -2277,14 +2246,40 @@ int ext4_xattr_ibody_set(handle_t *handle, struct inode *inode,
 {
 	struct ext4_xattr_ibody_header *header;
 	struct ext4_xattr_search *s = &is->s;
+	struct inode *ea_inode = NULL;
 	int error;
 
 	if (!EXT4_INODE_HAS_XATTR_SPACE(inode))
 		return -ENOSPC;
 
-	error = ext4_xattr_set_entry(i, s, handle, inode, false /* is_block */);
-	if (error)
+	/* If we need EA inode, prepare it before locking the buffer */
+	if (i->value && i->in_inode) {
+		WARN_ON_ONCE(!i->value_len);
+
+		ea_inode = ext4_xattr_inode_lookup_create(handle, inode,
+					i->value, i->value_len);
+		if (IS_ERR(ea_inode))
+			return PTR_ERR(ea_inode);
+	}
+	error = ext4_xattr_set_entry(i, s, handle, inode, ea_inode,
+				     false /* is_block */);
+	if (error) {
+		if (ea_inode) {
+			int error2;
+
+			error2 = ext4_xattr_inode_dec_ref(handle, ea_inode);
+			if (error2)
+				ext4_warning_inode(ea_inode, "dec ref error=%d",
+						   error2);
+
+			/* If there was an error, revert the quota charge. */
+			if (error)
+				ext4_xattr_inode_free_quota(inode, ea_inode,
+						    i_size_read(ea_inode));
+			iput(ea_inode);
+		}
 		return error;
+	}
 	header = IHDR(inode, ext4_raw_inode(&is->iloc));
 	if (!IS_LAST_ENTRY(s->first)) {
 		header->h_magic = cpu_to_le32(EXT4_XATTR_MAGIC);
@@ -2293,6 +2288,7 @@ int ext4_xattr_ibody_set(handle_t *handle, struct inode *inode,
 		header->h_magic = cpu_to_le32(0);
 		ext4_clear_inode_state(inode, EXT4_STATE_XATTR);
 	}
+	iput(ea_inode);
 	return 0;
 }
 
-- 
2.35.3


