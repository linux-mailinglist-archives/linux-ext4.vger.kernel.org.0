Return-Path: <linux-ext4+bounces-8902-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D129CAFE321
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Jul 2025 10:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE44A3A5F72
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Jul 2025 08:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAA2280308;
	Wed,  9 Jul 2025 08:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PP3waaJf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nmRra7xs";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PP3waaJf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nmRra7xs"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C24027EC7C
	for <linux-ext4@vger.kernel.org>; Wed,  9 Jul 2025 08:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752050945; cv=none; b=KkCXZ2WH1FcLkYoX3haRK7ACJjeI2S0jlMUuZxRpnHyha9VD+73v1q14y2bUv60aT2XC2KzDyt1kJ2C3UqKOy1qCTpIRnO4HFk97/P79JuNexplZ3i1dmWa2QlDWTUUUIpCRC4QbhY9eBvE38+h79npUSHsLvBgjTTLDEuoiCUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752050945; c=relaxed/simple;
	bh=4ODZanswgrYQG5OA9IzTa9E2LQFRsS+RoJ+X0cbEXL0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q9Xz+oCtDWsz6Uc9xBsc6u5iWE4meA1NmKaIfx2+No43k9edHKgY5gqv9LYMflIm3hSTbvLntvGXxtFbAUGdEhfXjwo5ZEPdi2a3L9NCE6VkIH7NK3tbEbzmjmRSrefP/SUXwSEgTc8RbzN8se/J1nRjS8UWMJDaDUk+KXYMB8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PP3waaJf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nmRra7xs; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PP3waaJf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nmRra7xs; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 596EE1F455;
	Wed,  9 Jul 2025 08:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752050940; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=MRKJ1ixeOLyaSLzVhMbH2GLj8DfHL3951lwOdPjryXk=;
	b=PP3waaJfajSO1SmeUGpWD7ATOct9loIXgBHNo60Svow71x0S7gVCrf51u0zVDHgbNpqGht
	hWmNX/ChzhoulDXqPYqyMYE7fZHQplvwaZlYgEY7D9OZ5lxflNyQeA9+ADUVnBCwrTZqPO
	scaeJq32wkMnGC+nqRZuw5qSSBZfqAI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752050940;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=MRKJ1ixeOLyaSLzVhMbH2GLj8DfHL3951lwOdPjryXk=;
	b=nmRra7xs1GchQ2OWkojrleEtr4cHkjmxAY0QlAYmQW84jJvSq0O0IxtKQWKJvAVi3aKd8Y
	D6V2namf/QneiQCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752050940; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=MRKJ1ixeOLyaSLzVhMbH2GLj8DfHL3951lwOdPjryXk=;
	b=PP3waaJfajSO1SmeUGpWD7ATOct9loIXgBHNo60Svow71x0S7gVCrf51u0zVDHgbNpqGht
	hWmNX/ChzhoulDXqPYqyMYE7fZHQplvwaZlYgEY7D9OZ5lxflNyQeA9+ADUVnBCwrTZqPO
	scaeJq32wkMnGC+nqRZuw5qSSBZfqAI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752050940;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=MRKJ1ixeOLyaSLzVhMbH2GLj8DfHL3951lwOdPjryXk=;
	b=nmRra7xs1GchQ2OWkojrleEtr4cHkjmxAY0QlAYmQW84jJvSq0O0IxtKQWKJvAVi3aKd8Y
	D6V2namf/QneiQCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 40DDD13757;
	Wed,  9 Jul 2025 08:49:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zULRD/wsbmhSfwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 09 Jul 2025 08:49:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DEE6BA09D7; Wed,  9 Jul 2025 10:48:59 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Ted Tso <tytso@mit.edu>
Cc: <linux-ext4@vger.kernel.org>,
	Baolin Liu <liubaolin12138@163.com>,
	Zhi Long <longzhi@sangfor.com.cn>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v4 RESEND] ext4: Make sure BH_New bit is cleared in ->write_end handler
Date: Wed,  9 Jul 2025 10:48:32 +0200
Message-ID: <20250709084831.23876-2-jack@suse.cz>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2773; i=jack@suse.cz; h=from:subject; bh=4ODZanswgrYQG5OA9IzTa9E2LQFRsS+RoJ+X0cbEXL0=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBobizfAeh0C9lgkyny+JJs7UdNlOoS41aHsIREAAEU /IZTChWJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaG4s3wAKCRCcnaoHP2RA2adtB/ wMrIUj2i4pLCq500sxoFMHjrVth0EFvZIK48A/nrGu6DDIDoD40Y++fgoeibnNO8fOrpWNAfuoOxOx EowST4UkVyHEWRSUYRyAyYA0i34xgASnGS9xeztk2vp0NPrrjGudEF7a3Tl6J8RTZcXRSszlzZKr8n +dElYtvcgrwWbxBEWDYBPc2fwLHr9Lwbtr59ApRUzTmmZndF77eUq8VDPV+d4Ji7Bgsq2bTF0oL7/q 2ROnqYMFuTw8RgRu3nSPQGHconr8H/De8MVLvr4L/lsWwV0v1A2gUjUjxMOVfxMO+c3LN+v3KmNTzS 0bqOilbUtKsJ2Y+pnbsGZm5ZlHn+E5
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,163.com,sangfor.com.cn,suse.cz];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[163.com]
X-Spam-Flag: NO
X-Spam-Score: -2.80

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

Reported-by: Baolin Liu <liubaolin12138@163.com>
Reported-by: Zhi Long <longzhi@sangfor.com.cn>
Fixes: 3910b513fcdf ("ext4: persist the new uptodate buffers in ext4_journalled_zero_new_buffers")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inline.c | 2 ++
 fs/ext4/inode.c  | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

Hello Ted,

when clearing branches in my devel tree I've found this fix which I think
has fallen through the cracks so I'm resending it.

Changes since v3 (https://lore.kernel.org/all/20241113175550.GA462442@mit.edu):
  * Clear stale BH_New flags resulting from inline->extent data conversion

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 3536ca7e4fcc..0d3cf0ca5c2a 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -606,6 +606,7 @@ static int ext4_convert_inline_data_to_extent(struct address_space *mapping,
 	} else
 		ret = ext4_block_write_begin(handle, folio, from, to,
 					     ext4_get_block);
+	clear_buffer_new(folio_buffers(folio));
 
 	if (!ret && ext4_should_journal_data(inode)) {
 		ret = ext4_walk_page_buffers(handle, inode,
@@ -867,6 +868,7 @@ static int ext4_da_convert_inline_data_to_extent(struct address_space *mapping,
 		return ret;
 	}
 
+	clear_buffer_new(folio_buffers(folio));
 	folio_mark_dirty(folio);
 	folio_mark_uptodate(folio);
 	ext4_clear_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
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


