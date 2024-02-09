Return-Path: <linux-ext4+bounces-1184-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FA884F489
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Feb 2024 12:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8C42B2A43B
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Feb 2024 11:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051DB2E85D;
	Fri,  9 Feb 2024 11:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hWNIK1X/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eFSs86cC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="G91Ee/WY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Du4I9xxF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE482E651
	for <linux-ext4@vger.kernel.org>; Fri,  9 Feb 2024 11:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707477673; cv=none; b=YzX2jOAV8j7nqJknY/JBZVlEoKzmufPzxwM9ClHKVj3cvPOHk6EppFA/wxcljVTNRFexFBBDfGdfiKBgO+8rVLJMTumTmpEB7DtI8tnS+gb1N4Hw78iJPRZqgQDO2r4ayTAUaszYbxh3OkCrhZxzOWQEy3kdmIZlK+Q3lS4E8lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707477673; c=relaxed/simple;
	bh=CiKq5OHw5QhWSwyX5BjX6EMJHAJKp56PIzdg8AfJUCU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=doRcfWZbAoMoqF1kfDe05uWkE7/SaKluJ/52iomcjxZh+GtdUp/shh0qk3EjFRFU2mEb4ljkWaSVb4GN71b9bdJMCUV8RfuvLuCHCthCJM5PrKHD36XrBHjy9AlIVHyKExP/ALTPwgJq/4rLKDLmdJTZCuI3CtBnj156ZhCqnIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hWNIK1X/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eFSs86cC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=G91Ee/WY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Du4I9xxF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D9F2D22062;
	Fri,  9 Feb 2024 11:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707477669; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WtCFmFwckQosCMn+gitRg9vbgHdj3hjTSEnL701MAXA=;
	b=hWNIK1X/UdTKe/i9euOQnZIB1UEBSBYvAn+0NMY/qn2gzL8OHSGqIiXnr0FqOhuOA7muUH
	XFajrWtd/SKL8VTn7C2zB8JqL15uC+A9gy3EqokM9NbxY1lNIrxndlFU+mxP6e5s5egHse
	J6BoA6558m9mXbL/BDHxXDO5dt4cxJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707477669;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WtCFmFwckQosCMn+gitRg9vbgHdj3hjTSEnL701MAXA=;
	b=eFSs86cCKpU7j/JKfaN+o32PWB1r8lBOua4OhT83eiqnuNV3s4CPkTO1nOkwZXtGAAjTeW
	1L/iOMkcdTnWSpBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707477667; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WtCFmFwckQosCMn+gitRg9vbgHdj3hjTSEnL701MAXA=;
	b=G91Ee/WY2fuX9lvVBH/Ow+oCmGX+ouyFOsD8FwZwClxspNFWfHJ3S36RYvcSmjXkc6mRQt
	lI8AIO+mZY9hERZSn+FteE4EgngFvWDckDvpdG/R/r5r8IVcxSBoIMCi6jD22V1iZoNRKd
	YTvM/q3qnQM0WhyKpbzHQbIVw16edt8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707477667;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WtCFmFwckQosCMn+gitRg9vbgHdj3hjTSEnL701MAXA=;
	b=Du4I9xxF7hgURVbv7Vt5ckLbdZ5gqMydm7LQowTpijr2LP7PTlk8vlEuE3DgSQxTZQkRSq
	JAzr7sdQEMI8xrCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CAC5B13A3B;
	Fri,  9 Feb 2024 11:21:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LE04MaMKxmWlNQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 09 Feb 2024 11:21:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7D048A080D; Fri,  9 Feb 2024 12:21:07 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: Ted Tso <tytso@mit.edu>
Cc: <linux-ext4@vger.kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 3/3] ext4: Drop duplicate ea_inode handling in ext4_xattr_block_set()
Date: Fri,  9 Feb 2024 12:21:01 +0100
Message-Id: <20240209112107.10585-3-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240209111418.22308-1-jack@suse.cz>
References: <20240209111418.22308-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=958; i=jack@suse.cz; h=from:subject; bh=CiKq5OHw5QhWSwyX5BjX6EMJHAJKp56PIzdg8AfJUCU=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlxgqcmibdl0gjNTQtqRx+dycA/yzOBuEJuqwSLk9v Ljz2ArSJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZcYKnAAKCRCcnaoHP2RA2YoaB/ 9QVWIddfPDQSbvrNwwGGA8NKEVHILje8IQSe3Fv+JgJxBSfHWOMIQQCPr3A/YPY9wgKuJOKGACsCz2 8I4lPG434KHZOedgdNTnIPAAl8xV9PKY1tML763nqcdukW7v0NmT2vue/rkXKSQCbYAaHveDdzNIYQ WTQSvLpGH+kqtlFVyjeuZk2BSeZA6AztHwHGjJWTSeHqWS8tWj228LxAy9bL4b5cwO+4o6aOBJKW3o izkLjy0iZHNZKjPrA7IxfF4LiY/OacCn/zr+t9Y4wsx5aqHL1Ei9E3p4v1BjLh2xuLbKQWhigeLypf CMQAAcck6EYKsQt52jzjGXyzUNYc15
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.30
X-Spamd-Result: default: False [-0.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

ext4_xattr_block_set() drops ea_inode reference in two places. Handling
it just under the 'cleanup' label is enough so drop the second
occurence.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/xattr.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index e7e1ffff8eba..040a40908f39 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2127,17 +2127,6 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
 						      ENTRY(header(s->base)+1));
 			if (error)
 				goto getblk_failed;
-			if (ea_inode) {
-				/* Drop the extra ref on ea_inode. */
-				error = ext4_xattr_inode_dec_ref(handle,
-								 ea_inode);
-				if (error)
-					ext4_warning_inode(ea_inode,
-							   "dec ref error=%d",
-							   error);
-				iput(ea_inode);
-				ea_inode = NULL;
-			}
 
 			lock_buffer(new_bh);
 			error = ext4_journal_get_create_access(handle, sb,
-- 
2.35.3


