Return-Path: <linux-ext4+bounces-1726-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E20AD885D65
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Mar 2024 17:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A1C71F25FCE
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Mar 2024 16:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B9112CDB2;
	Thu, 21 Mar 2024 16:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ns0O9nov";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GTgb3BrN"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3097012CD92
	for <linux-ext4@vger.kernel.org>; Thu, 21 Mar 2024 16:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711038422; cv=none; b=ow1DfqkA44S6+MKQ9SlWlm+OaAIhzxIUkw1O59yfgHA1mTb6OVEnvIPYfvjKcAdjN5jPVo9xJfx8Pn5QebrCfI02sPxgzh98iGl6KTBPGoPQulTYohdb/Z38gs/h/hLXippnNy/ETu9rKXhPVdaVYT1RS/6KqEQkNFrs8cbFg3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711038422; c=relaxed/simple;
	bh=ClY6cQFMnvWLVjruwU9YSCebXdQId/RvOEE/t9FoEmk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D33pkZFpiKWaLxrOcpIMUEyOsPZT1JbSw+90G/NNRxvIZr9IgPjmai+K7KBXb7jBsmDx3CLALPL1GJBxfiE/4pEf44vz1xCS9rKJNvag8DmoXw7YrxTP7TSqPCfMelcEVjun5zHW/LLe0z/WxeAx7cgeOA0Y/MVXwG+k0gJmE4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ns0O9nov; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GTgb3BrN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3EC6C5D12B;
	Thu, 21 Mar 2024 16:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711038418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kVngoSeA8RjsfEjYVya+ELfn11nCfGBON8hhUhYQ8sQ=;
	b=ns0O9novQXT0kjvXmw97iv9g7Tm6QJT7kyuIdrwAyFmbbVshkI7YprTBaa6uNxieeYcyPu
	OQTu9DXL+03KBLgdX1GWpm3JTmgmieBnIMG5lkVPeDsbUxAJ/mXBGdVFAaAmmQrKUw02Iv
	FdS9YBbZX7744rFEvKo5bUAIOY8qGxA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711038418;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kVngoSeA8RjsfEjYVya+ELfn11nCfGBON8hhUhYQ8sQ=;
	b=GTgb3BrNP19E8oyjxhqiD6MxGgSBlh85TnmzZ/eUGhmGJ8b2btQKXbwjJ5CBj2Ac0iO95v
	vD36oFkLqrCCn1BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2DE8E138A1;
	Thu, 21 Mar 2024 16:26:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0wAvC9Jf/GWyGQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 21 Mar 2024 16:26:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CCB83A0811; Thu, 21 Mar 2024 17:26:57 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: Ted Tso <tytso@mit.edu>
Cc: <linux-ext4@vger.kernel.org>,
	Jan Kara <jack@suse.cz>,
	syzbot+a43d4f48b8397d0e41a9@syzkaller.appspotmail.com
Subject: [PATCH 2/2] ext4: Do not create EA inode under buffer lock
Date: Thu, 21 Mar 2024 17:26:50 +0100
Message-Id: <20240321162657.27420-2-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240209111418.22308-1-jack@suse.cz>
References: <20240209111418.22308-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7166; i=jack@suse.cz; h=from:subject; bh=ClY6cQFMnvWLVjruwU9YSCebXdQId/RvOEE/t9FoEmk=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBl/F/KRGa3Jlh5Go0PUomyG5Al2XcWrktQ2M+wUi8X 4wUPtmGJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZfxfygAKCRCcnaoHP2RA2bOaB/ 4mgzHhzOyV3JFm4Caw1ovpK1HYEoqEzWv5BGzpL5T/RMk7yPEfX1j2U3i8EUYYdIZ8NKbhNGLzJBMT WTZ+FhlPa0RBrUp2+E/m/xAkD7ZiA7CxY5LSlk9UmIewI5ph/dNT7urDnDdvBasB+9tIDFUsw+ulqS E75nZ4FWi2Md3xet/Q8vw14d6uTbogeUNK6n5pJBpjYS0YjCtoxEmTo/EPIv2VD+BkkhFX/+HVcSL5 +95JPVsSExh8EFy/D6hXtt8wW3xae2a38qEmEGlCBkjkz21gWWgmXeSdkx5v91XBcHAyeLgzh3nGQi luv4e7n72UstHfmdvorH6x2JJLh1Av
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 TAGGED_RCPT(0.00)[a43d4f48b8397d0e41a9];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 3EC6C5D12B
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
 fs/ext4/xattr.c | 113 +++++++++++++++++++++++-------------------------
 1 file changed, 53 insertions(+), 60 deletions(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 146690c10c73..04f90df8dbae 100644
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
@@ -2209,17 +2178,16 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
 
 cleanup:
 	if (ea_inode) {
-		int error2;
-
-		error2 = ext4_xattr_inode_dec_ref(handle, ea_inode);
-		if (error2)
-			ext4_warning_inode(ea_inode, "dec ref error=%d",
-					   error2);
+		if (error) {
+			int error2;
 
-		/* If there was an error, revert the quota charge. */
-		if (error)
+			error2 = ext4_xattr_inode_dec_ref(handle, ea_inode);
+			if (error2)
+				ext4_warning_inode(ea_inode, "dec ref error=%d",
+						   error2);
 			ext4_xattr_inode_free_quota(inode, ea_inode,
 						    i_size_read(ea_inode));
+		}
 		iput(ea_inode);
 	}
 	if (ce)
@@ -2277,14 +2245,38 @@ int ext4_xattr_ibody_set(handle_t *handle, struct inode *inode,
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
+			ext4_xattr_inode_free_quota(inode, ea_inode,
+						    i_size_read(ea_inode));
+			iput(ea_inode);
+		}
 		return error;
+	}
 	header = IHDR(inode, ext4_raw_inode(&is->iloc));
 	if (!IS_LAST_ENTRY(s->first)) {
 		header->h_magic = cpu_to_le32(EXT4_XATTR_MAGIC);
@@ -2293,6 +2285,7 @@ int ext4_xattr_ibody_set(handle_t *handle, struct inode *inode,
 		header->h_magic = cpu_to_le32(0);
 		ext4_clear_inode_state(inode, EXT4_STATE_XATTR);
 	}
+	iput(ea_inode);
 	return 0;
 }
 
-- 
2.35.3


