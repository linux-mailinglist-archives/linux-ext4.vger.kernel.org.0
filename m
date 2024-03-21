Return-Path: <linux-ext4+bounces-1727-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBA6885D66
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Mar 2024 17:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0DC71C21A43
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Mar 2024 16:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B928212CDB5;
	Thu, 21 Mar 2024 16:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="f1R0fp9z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1OzO8CBR"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5AD12CD98
	for <linux-ext4@vger.kernel.org>; Thu, 21 Mar 2024 16:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711038423; cv=none; b=gWY4PFCuaJsCcM8cbTNm0qzd3OGgkBX0qea+Jiu8RRc7PS6VkMdcD2tM/mXmtBgLpj0i/9a6h6ihArQrC2SeHsoNCoieX0PYwA37UNAfRAhJq3yrUC3MB2UKAp4VrP3iZSRUO0xE6QG3VMuflbNOKKmbcoBJc0RW3Jlh3HhkHmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711038423; c=relaxed/simple;
	bh=UZHj9XNcXaTmklSR/AIinK6Iy7OvYagbPS3mKBpmG0w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DG1EXMeh8b0/EogZBzfb/AIkay2ZtErdXuAe+prNtXizxhnztXFc/YEhlqkvGMWHZ+iyrkfCtMFK7opIuuneDkuEVS0fMiChIh9fvD9Lo1M750DXZHbarAvFQGeSr8Hm4oIWmvG4EVv8Fp3y5QNDFty126/xY2Tu5IFMI3TY2tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=f1R0fp9z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1OzO8CBR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3B7935D12A;
	Thu, 21 Mar 2024 16:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711038418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lNDwYy8q7k5nfMJQt3W2N8aT3pxFWbMxuOHZJXqTovc=;
	b=f1R0fp9zFKNsCImFrml5OelOqFFP2Ffx2QyDeKj/87i7wMUgiRdgUK/3uq21VLdpe68de5
	/BKSpUN6fcQO76IwjFi4CN0TewMj1RPC7NvpEzea9pEPPlv1nchaPzkuLlVfbCVFbm+ZtA
	o7dj5lfP2YX8EVXYeC/tH8VLm2Y4Ntw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711038418;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lNDwYy8q7k5nfMJQt3W2N8aT3pxFWbMxuOHZJXqTovc=;
	b=1OzO8CBR6qy/NIZj84EqdwCC4wRXN97z1Za455REwEnmAobw/009Oj93ma3JUt/yEeQp4K
	25mYyxdOnMz/icAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 30EE8138A7;
	Thu, 21 Mar 2024 16:26:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YIGoC9Jf/GWzGQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 21 Mar 2024 16:26:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C7AC4A080F; Thu, 21 Mar 2024 17:26:57 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: Ted Tso <tytso@mit.edu>
Cc: <linux-ext4@vger.kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 1/2] Revert "ext4: drop duplicate ea_inode handling in ext4_xattr_block_set()"
Date: Thu, 21 Mar 2024 17:26:49 +0100
Message-Id: <20240321162657.27420-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240209111418.22308-1-jack@suse.cz>
References: <20240209111418.22308-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1004; i=jack@suse.cz; h=from:subject; bh=UZHj9XNcXaTmklSR/AIinK6Iy7OvYagbPS3mKBpmG0w=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBl/F/JEQpASIrBmgIl1yadrmeSM4FCW9tUmqOj2GNU pFjln02JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZfxfyQAKCRCcnaoHP2RA2QNqCA CITa2f+DB0anFA51G2+L4Z/AM/NmbqYOJ55HukNCVRF8xE1AGg6dVc7t/oMAgG+8X+07jd9pVog+B4 JrU6KYkm0DspAm1NWZhykabdblKVBv8z51ehlxkmI+3mmWgS7jJtu5do2u8p1vsaZ6R/JM9/S8LWOd XamY9kDhSsIbHjqNVP9CpcWaZaREhBi14XSoptY0u3sYAd9e4GUUAkh1mLvEqkSv6WG1FyuQEIQUjI ZvAA21VGY1FJcNzMFQXTFeNbzNC7ApiGj1cshHyTiRncpQgOGPxDIr21lJn7Cnqv73yolHSSTbCYPV 6EN//cyI0wi/XvIRwmngmKuvbWx9hA
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.00
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Queue-Id: 3B7935D12A

This reverts commit 7f48212678e91a057259b3e281701f7feb1ee397. We will
need the special cleanup handling once we move allocation of EA inode
outside of the buffer lock in the following patch.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/xattr.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index b67a176bfcf9..146690c10c73 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2158,6 +2158,17 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
 						      ENTRY(header(s->base)+1));
 			if (error)
 				goto getblk_failed;
+			if (ea_inode) {
+				/* Drop the extra ref on ea_inode. */
+				error = ext4_xattr_inode_dec_ref(handle,
+								 ea_inode);
+				if (error)
+					ext4_warning_inode(ea_inode,
+							   "dec ref error=%d",
+							   error);
+				iput(ea_inode);
+				ea_inode = NULL;
+			}
 
 			lock_buffer(new_bh);
 			error = ext4_journal_get_create_access(handle, sb,
-- 
2.35.3


