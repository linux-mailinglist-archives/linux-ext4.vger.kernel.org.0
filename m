Return-Path: <linux-ext4+bounces-4629-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C679A41D5
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Oct 2024 16:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D0F9B2276D
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Oct 2024 14:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53971FF606;
	Fri, 18 Oct 2024 14:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WJRiKT+4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="i8EnI/yI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WJRiKT+4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="i8EnI/yI"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE341EE03A
	for <linux-ext4@vger.kernel.org>; Fri, 18 Oct 2024 14:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729263552; cv=none; b=oJLsfRhClAfFMjO2n9qYtY839dBOc1T8rpa3FV4NT0LrQ7fWIOpIv7LY3cAY0UsHL0gfLELhdMERn5b5u0aLNoXuTBf7xJDlc4kdRnGet6LgFUvUF6EqBXLFgr4PEWVih+Fu70D0Ou46Yi+AJsuXZxiirfBK0q7NhdfKbNZM9yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729263552; c=relaxed/simple;
	bh=LTWcJ9E1VAA0PIHygpP6qvY67w+jtiRy7ggch+mTVVE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sjmg8rEDTt+zh4A3prNP5EqoxF4mZ2ypNMEshEqvYmNVyjXZ/lSMb6TXy/krAlCmJoIT5N1ryX0iqnK+JcQfsapxr5Mj979OWJHqF2lqoTmZz9TganBqMLsYRTh1AJgb35Kcg5eUEsqbfma5srhuRSWtYR9q40a3LwEd/mnhmW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WJRiKT+4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=i8EnI/yI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WJRiKT+4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=i8EnI/yI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5772621BAA;
	Fri, 18 Oct 2024 14:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729263548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=UqWSWv+svT8ZmBEl+LEJP6j32dsFkcsQFwNTa/X9mwI=;
	b=WJRiKT+46DFc2t/jnY34KtJ/MugLDSu0U45oPK/bJvoJBXaDstGKBOwK6EqzxcYvQqQrMz
	38Joj4A3OyKBc6UvZtH8w1RmLot1LbUtsJpMek5gBbqyR5SQ0LoIKqJ2PXwgaE7+1n1YBB
	I1h2useWH88Nh3KVAWOm5yR1oaPEdxU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729263548;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=UqWSWv+svT8ZmBEl+LEJP6j32dsFkcsQFwNTa/X9mwI=;
	b=i8EnI/yIjwSkUVGSOoa2HH1EveiCHlpjpV9YUtYBD9qkfC3yC4/xqG4BhElMSL2NZzghUm
	YQlYC8VyXRDViECA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=WJRiKT+4;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="i8EnI/yI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729263548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=UqWSWv+svT8ZmBEl+LEJP6j32dsFkcsQFwNTa/X9mwI=;
	b=WJRiKT+46DFc2t/jnY34KtJ/MugLDSu0U45oPK/bJvoJBXaDstGKBOwK6EqzxcYvQqQrMz
	38Joj4A3OyKBc6UvZtH8w1RmLot1LbUtsJpMek5gBbqyR5SQ0LoIKqJ2PXwgaE7+1n1YBB
	I1h2useWH88Nh3KVAWOm5yR1oaPEdxU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729263548;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=UqWSWv+svT8ZmBEl+LEJP6j32dsFkcsQFwNTa/X9mwI=;
	b=i8EnI/yIjwSkUVGSOoa2HH1EveiCHlpjpV9YUtYBD9qkfC3yC4/xqG4BhElMSL2NZzghUm
	YQlYC8VyXRDViECA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A82513433;
	Fri, 18 Oct 2024 14:59:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +pzUEbx3EmeTQAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 18 Oct 2024 14:59:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D4890A080A; Fri, 18 Oct 2024 16:59:03 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Ted Tso <tytso@mit.edu>
Cc: <linux-ext4@vger.kernel.org>,
	Jan Kara <jack@suse.cz>,
	Baolin Liu <liubaolin@kylinos.cn>,
	Zhi Long <longzhi@sangfor.com.cn>
Subject: [PATCH v3] ext4: Make sure BH_New bit is cleared in ->write_end handler
Date: Fri, 18 Oct 2024 16:59:01 +0200
Message-Id: <20241018145901.2086-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1781; i=jack@suse.cz; h=from:subject; bh=LTWcJ9E1VAA0PIHygpP6qvY67w+jtiRy7ggch+mTVVE=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBnEnev1/r3BgU1AlgfZK5UT1XhsLGWtksPyS0RIpKp 5Atil/6JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZxJ3rwAKCRCcnaoHP2RA2dXbCA CcwW7hvCJXpPXr/pd0JFrmg4dHRiJ5kRQkubUCN7rs0Gel9YKvpd6z950ZlRbSZNJndwDmQTtrQMED fz8HTQC1cXoOKWtDrNKUBzItv9cyRw2QdP+6nj37oE8p6ynzWdU2tvG854j8jfGjOl51ktd0xaSEqB dERj4Xe0T4IjrI53JmqR/w3pmHHiD/w/ofScdUBqK+U88ln65TgQMtIdusv0eosYWhNCF/WLEi7lgD hQ1kx/9CI4UHg0naPsH/3EHrVCFkNSA3WXxwxx6fMWZB5RUMwE3+Y/p6gEOCNPmMh8kvdh8UWffx3u ArFaUuwVM7ChkXBkNZVSGibnF8wttx
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5772621BAA
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:mid,suse.cz:email];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Currently we clear BH_New bit in case of error and also in the standard
ext4_write_end() handler (in block_commit_write()). However
ext4_journalled_write_end() misses this clearing and thus we are leaving
stale BH_New bits behind. Generally ext4_block_write_begin() clears
these bits before any harm can be done but in case blocksize < pagesize
and we hit some error when processing a page with these stale bits,
we'll try to zero buffers with these stale BH_New bits and jbd2 will
complain (as buffers were not prepared for writing in this transaction).
Fix the problem by clearing BH_New bits in ext4_journalled_write_end()
and WARN if ext4_block_write_begin() sees stale BH_New bits.

Reported-and-tested-by: Baolin Liu <liubaolin@kylinos.cn>
Reported-and-tested-by: Zhi Long <longzhi@sangfor.com.cn>
Fixes: 3910b513fcdf ("ext4: persist the new uptodate buffers in ext4_journalled_zero_new_buffers")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

- changes since v1: Updated tags
- changes since v2: Fixup email address in tags

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 54bdd4884fe6..aa56af4a92ad 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1049,7 +1049,7 @@ int ext4_block_write_begin(handle_t *handle, struct folio *folio,
 			}
 			continue;
 		}
-		if (buffer_new(bh))
+		if (WARN_ON_ONCE(buffer_new(bh)))
 			clear_buffer_new(bh);
 		if (!buffer_mapped(bh)) {
 			WARN_ON(bh->b_size != blocksize);
@@ -1265,6 +1265,7 @@ static int write_end_fn(handle_t *handle, struct inode *inode,
 	ret = ext4_dirty_journalled_data(handle, bh);
 	clear_buffer_meta(bh);
 	clear_buffer_prio(bh);
+	clear_buffer_new(bh);
 	return ret;
 }
 
-- 
2.35.3


