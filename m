Return-Path: <linux-ext4+bounces-1560-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D236A874F0B
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Mar 2024 13:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FB711F246D6
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Mar 2024 12:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC87F12B172;
	Thu,  7 Mar 2024 12:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TaPlHnAu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KyuIC4NN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TaPlHnAu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KyuIC4NN"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C644A12B144
	for <linux-ext4@vger.kernel.org>; Thu,  7 Mar 2024 12:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709814566; cv=none; b=js1MoTf9P05iUU3qklOJm0adK4vuX9azsUiaQjNc73dpTwK28Qu0B3C82XnUKDS+zbyHgR3vM8PoNMaYMi6FdW1HprriN2eRv0oeNTbQjzFCcRndMCXbNySs++ij8imjco+zUb1moiFk+aJHbLEOn9n0k9lF29EHTm2NzgN7avc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709814566; c=relaxed/simple;
	bh=saovLpb0Jb7nLNrJPgJVGh8IRCqIc5I7C0IwbtIMBXM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aaawsjLkcdhK3HBlSqWnfmUiO9/kmr7L+BL9MZi2069qeVwg8jBvETJUH0TWdUedM0KdoW0cYbfMYoAQ+IQwwNV0+bZdRFh52J/qFyG2PfurwQTYZoxlpEaWftZ61pGMpCog7O0V1Lb8nzDHmMSZXbD1UHSIj6hPdrZ6G7r/zjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TaPlHnAu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KyuIC4NN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TaPlHnAu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KyuIC4NN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5C84838707;
	Thu,  7 Mar 2024 11:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709812406; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=URhnTQA8MoG1Fc6A1aixy+GBy/15DG4TUcY4DJtPzts=;
	b=TaPlHnAuBPxasBKU/Y2i+DlStjCTqBvJgYQoVYBaTbTTpocuHj5/q9B/5TqYZtFBDe0IDE
	pUaBLaL57SodvvwlYoXh1pmK2AoYBjqC+iUpOaZ/oLstMDT0QAaO9hhHJEgxnzPoP45M9C
	zb5VPG3zlwSn78KKLelxDw6xgrSSgqk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709812406;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=URhnTQA8MoG1Fc6A1aixy+GBy/15DG4TUcY4DJtPzts=;
	b=KyuIC4NNpyj5dIP7Wv5avW9BIIt/+x30KZN0GVdvAhyeNbjE1cLd04ru/cLaES1mobg03q
	e7dE38+D7S84W6Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709812406; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=URhnTQA8MoG1Fc6A1aixy+GBy/15DG4TUcY4DJtPzts=;
	b=TaPlHnAuBPxasBKU/Y2i+DlStjCTqBvJgYQoVYBaTbTTpocuHj5/q9B/5TqYZtFBDe0IDE
	pUaBLaL57SodvvwlYoXh1pmK2AoYBjqC+iUpOaZ/oLstMDT0QAaO9hhHJEgxnzPoP45M9C
	zb5VPG3zlwSn78KKLelxDw6xgrSSgqk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709812406;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=URhnTQA8MoG1Fc6A1aixy+GBy/15DG4TUcY4DJtPzts=;
	b=KyuIC4NNpyj5dIP7Wv5avW9BIIt/+x30KZN0GVdvAhyeNbjE1cLd04ru/cLaES1mobg03q
	e7dE38+D7S84W6Cw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 534C6132A4;
	Thu,  7 Mar 2024 11:53:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id CE9PFLaq6WW8PAAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 07 Mar 2024 11:53:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 03D43A0803; Thu,  7 Mar 2024 12:53:21 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: Ted Tso <tytso@mit.edu>
Cc: <linux-ext4@vger.kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH] ext4: Avoid excessive credit estimate in ext4_tmpfile()
Date: Thu,  7 Mar 2024 12:53:20 +0100
Message-Id: <20240307115320.28949-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1509; i=jack@suse.cz; h=from:subject; bh=saovLpb0Jb7nLNrJPgJVGh8IRCqIc5I7C0IwbtIMBXM=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBl6aqbTRRXBdZSGTIs0Qgk/nF1Uw4c8Ja2kETBwCJS BbOMbqaJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZemqmwAKCRCcnaoHP2RA2eR5CA C4rnn4cgcy1Xe+A/j3HjH6K/NbWkU527IqdswnifBQbBzlKqr6AKswLmkZr8IzdnKxCiwAyYoGGj6l KxMZknQeiqARixyv5kMpS+ZAlIwIw2G2kP1Mo9GjXu4mVd0UTA17apWw0nV5vb/oFAJ9aFVAh189H9 jQv7n9p5JCcECnsjIaZ0VW1i6bOQqPuj+vPouGyJcV1ibdcNLLzsJd5K5FQMqrZCY11qUYsAi5Ugl5 HFrqCB40cexV2bLOrxR+i3H/DmBIiquHhebbrl30P/NT+8wL9aaWBgIWiPFDc4mB4BytFs1ESel6rs 0nC+Z/GlltZc5FC+8TtypZwRuJzfti
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: ***
X-Spam-Score: 3.68
X-Spamd-Result: default: False [3.68 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.02)[53.71%]
X-Spam-Flag: NO

A user with minimum journal size (1024 blocks these days) complained
about the following error triggered by generic/697 test in
ext4_tmpfile():

run fstests generic/697 at 2024-02-28 05:34:46
JBD2: vfstest wants too many credits credits:260 rsv_credits:0 max:256
EXT4-fs error (device loop0) in __ext4_new_inode:1083: error 28

Indeed the credit estimate in ext4_tmpfile() is huge.
EXT4_MAXQUOTAS_INIT_BLOCKS() is 219, then 10 credits from ext4_tmpfile()
itself and then ext4_xattr_credits_for_new_inode() adds more credits
needed for security attributes and ACLs. Now the
EXT4_MAXQUOTAS_INIT_BLOCKS() is in fact unnecessary because we've
already initialized quotas with dquot_init() shortly before and so
EXT4_MAXQUOTAS_TRANS_BLOCKS() is enough (which boils down to 3 credits).

Fixes: af51a2ac36d1 ("ext4: ->tmpfile() support")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 05b647e6bc19..58fee3c6febc 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2898,7 +2898,7 @@ static int ext4_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 	inode = ext4_new_inode_start_handle(idmap, dir, mode,
 					    NULL, 0, NULL,
 					    EXT4_HT_DIR,
-			EXT4_MAXQUOTAS_INIT_BLOCKS(dir->i_sb) +
+			EXT4_MAXQUOTAS_TRANS_BLOCKS(dir->i_sb) +
 			  4 + EXT4_XATTR_TRANS_BLOCKS);
 	handle = ext4_journal_current_handle();
 	err = PTR_ERR(inode);
-- 
2.35.3


