Return-Path: <linux-ext4+bounces-1183-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE7D84F487
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Feb 2024 12:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 998DF1F2A08E
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Feb 2024 11:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C382E858;
	Fri,  9 Feb 2024 11:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="S5rqwisB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="w8PUnKa/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84B82D04F
	for <linux-ext4@vger.kernel.org>; Fri,  9 Feb 2024 11:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707477673; cv=none; b=DZqXYBEjU1YtA1rj6t+HIdfX44JTQ+q4py4QeuGnkhlN3W6iFjEFFLKDWyvUuMFnLueEQJbmWnZm8685Ckh9S95+3TOHqXHSvpY2dXpN/JHvqAD1YNzTxGzasO3pnw51aNKd+x2t0jfaFUE1O6aMnTAsB9xNA6u3F39GcjhWgrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707477673; c=relaxed/simple;
	bh=QKsz8+4nVeQbBno3VOSz24JxTTH1VtojewFqvVVQ7ek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AG9HUEW3uAAki3/0amxsXZtZ4y4vUfT6PylO7CQKjYZhYKkRmQUC7QxA/AsEw6WLGyoM0H42Ccyz//CrPLTTTXOQ6kFZHLlUDGUvTRWYlua+UUqVFWz353VtCXjbarP7Ac5onAToNrswqKUs9bNM/7Ffj+/yOtUgjFSqmmWqqiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=S5rqwisB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=w8PUnKa/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D33EB1F7F9;
	Fri,  9 Feb 2024 11:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707477667; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gNrqiNAaZMWCvNANNKTPlOJbjUtw7A2fXJ/3W2rPMWw=;
	b=S5rqwisBgsFtNHcwRMP5Zg5GRJ/gyBWREuK7jNRGspjU6JE6lL69bwCZ/c+6xQ0wOeNE4s
	izJcyVVlWJ6qwQvBPECHh33s7Ze/FlGX5msZP6tPMslaJcSO5OzyjjlLeX2IrRWtDfRkSW
	Rr27mJY4Tc7fpdg8dI/xHXjGOAHbW74=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707477667;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gNrqiNAaZMWCvNANNKTPlOJbjUtw7A2fXJ/3W2rPMWw=;
	b=w8PUnKa/I2ae5M1MxrY5pJGatJBTncwpd2YTNosXHy9iJ70jI/OicdxG0a3X0KWxgVRlaB
	FnT5P9BeXbZ82iAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB699139E7;
	Fri,  9 Feb 2024 11:21:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EDi7LaMKxmWcNQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 09 Feb 2024 11:21:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6F973A05C4; Fri,  9 Feb 2024 12:21:07 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: Ted Tso <tytso@mit.edu>
Cc: <linux-ext4@vger.kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 1/3] ext4: Fold quota accounting into ext4_xattr_inode_lookup_create()
Date: Fri,  9 Feb 2024 12:20:59 +0100
Message-Id: <20240209112107.10585-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240209111418.22308-1-jack@suse.cz>
References: <20240209111418.22308-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3247; i=jack@suse.cz; h=from:subject; bh=QKsz8+4nVeQbBno3VOSz24JxTTH1VtojewFqvVVQ7ek=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlxgqac55kL12p7NCMxxSulcKzF7ADQLTzretxdZOC nfs+IEKJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZcYKmgAKCRCcnaoHP2RA2b9TCA C/AAYpEJqDNOP0I1OxWVmRhy0cfNVHJI9RPWty8FKADxAyd+35YqwAB24fOmRr9uarLwsOjaRuzV4j aBDMynb3esRzDIWCFnFRtusKNQnqAAwFXo+EJH7as7C5QyBbtQ2Be08uEW1WTgF8ejr8zoIo9nh0gc Lz96AaIvvZ1f7H/DeqZV82QY3a5F40X6d43OsTC6Me8coiZs1DQTcYwgmABoPpwK0X/xfYWf/G7qzN LZxb2K/czv7NEoD+GkCCk/u3uAM9WDSO+0wgRimQYoG2a0MHLeb8IyLNuI+Vv66ck/Um73MGARVtp3 qQOtI+6f8dv17M87Ja+uoxq0wQDzBA
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D33EB1F7F9
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spam-Flag: NO

When allocating EA inode, quota accounting is done just before
ext4_xattr_inode_lookup_create(). Logically these two operations belong
together so just fold quota accounting into
ext4_xattr_inode_lookup_create(). We also make
ext4_xattr_inode_lookup_create() return the looked up / created inode to
convert the function to a more standard calling convention.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/xattr.c | 50 ++++++++++++++++++++++++-------------------------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 82dc5e673d5c..146690c10c73 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1565,46 +1565,49 @@ ext4_xattr_inode_cache_find(struct inode *inode, const void *value,
 /*
  * Add value of the EA in an inode.
  */
-static int ext4_xattr_inode_lookup_create(handle_t *handle, struct inode *inode,
-					  const void *value, size_t value_len,
-					  struct inode **ret_inode)
+static struct inode *ext4_xattr_inode_lookup_create(handle_t *handle,
+		struct inode *inode, const void *value, size_t value_len)
 {
 	struct inode *ea_inode;
 	u32 hash;
 	int err;
 
+	/* Account inode & space to quota even if sharing... */
+	err = ext4_xattr_inode_alloc_quota(inode, value_len);
+	if (err)
+		return ERR_PTR(err);
+
 	hash = ext4_xattr_inode_hash(EXT4_SB(inode->i_sb), value, value_len);
 	ea_inode = ext4_xattr_inode_cache_find(inode, value, value_len, hash);
 	if (ea_inode) {
 		err = ext4_xattr_inode_inc_ref(handle, ea_inode);
-		if (err) {
-			iput(ea_inode);
-			return err;
-		}
-
-		*ret_inode = ea_inode;
-		return 0;
+		if (err)
+			goto out_err;
+		return ea_inode;
 	}
 
 	/* Create an inode for the EA value */
 	ea_inode = ext4_xattr_inode_create(handle, inode, hash);
-	if (IS_ERR(ea_inode))
-		return PTR_ERR(ea_inode);
+	if (IS_ERR(ea_inode)) {
+		ext4_xattr_inode_free_quota(inode, NULL, value_len);
+		return ea_inode;
+	}
 
 	err = ext4_xattr_inode_write(handle, ea_inode, value, value_len);
 	if (err) {
 		if (ext4_xattr_inode_dec_ref(handle, ea_inode))
 			ext4_warning_inode(ea_inode, "cleanup dec ref error %d", err);
-		iput(ea_inode);
-		return err;
+		goto out_err;
 	}
 
 	if (EA_INODE_CACHE(inode))
 		mb_cache_entry_create(EA_INODE_CACHE(inode), GFP_NOFS, hash,
 				      ea_inode->i_ino, true /* reusable */);
-
-	*ret_inode = ea_inode;
-	return 0;
+	return ea_inode;
+out_err:
+	iput(ea_inode);
+	ext4_xattr_inode_free_quota(inode, NULL, value_len);
+	return ERR_PTR(err);
 }
 
 /*
@@ -1712,16 +1715,11 @@ static int ext4_xattr_set_entry(struct ext4_xattr_info *i,
 	if (i->value && in_inode) {
 		WARN_ON_ONCE(!i->value_len);
 
-		ret = ext4_xattr_inode_alloc_quota(inode, i->value_len);
-		if (ret)
-			goto out;
-
-		ret = ext4_xattr_inode_lookup_create(handle, inode, i->value,
-						     i->value_len,
-						     &new_ea_inode);
-		if (ret) {
+		new_ea_inode = ext4_xattr_inode_lookup_create(handle, inode,
+					i->value, i->value_len);
+		if (IS_ERR(new_ea_inode)) {
+			ret = PTR_ERR(new_ea_inode);
 			new_ea_inode = NULL;
-			ext4_xattr_inode_free_quota(inode, NULL, i->value_len);
 			goto out;
 		}
 	}
-- 
2.35.3


