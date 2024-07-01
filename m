Return-Path: <linux-ext4+bounces-3052-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C89991E0B3
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Jul 2024 15:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B1D51F2373A
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Jul 2024 13:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5ED15E5BA;
	Mon,  1 Jul 2024 13:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="x37O6IDt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yqgzfKsO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="x37O6IDt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yqgzfKsO"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BD215532E
	for <linux-ext4@vger.kernel.org>; Mon,  1 Jul 2024 13:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719840493; cv=none; b=dBmGyzh0Jyk6jwcHmvqThsq4EkXX8z/QgTbbRkWY85gCNT4ADp5KHd3qS9Ms47b2JbsKYKTt9qY9I7O+DYiE0ra5I16/7Fw4HeYcAsHzAs8y2DOq4i4zKIXN6CF3L5/f+9N8KsH17CxfOX68S8mThmK/xIcdaUbs8PT6hmQOqMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719840493; c=relaxed/simple;
	bh=TOQqCCCsmVhB9wUwD05+zD0p6Jvxnhhi5sXM+lmZHuI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U4Ib8XkZG1/Uar2fqC3H+AvEbrGK/kiYwi6FUgeFAQr/lcMHUw0uWIA4Rw9IoA5KSCctY9BJUN+hXqnsRKCTKH0Uq9zKXM4jXaoc6G+DU2fa1IIZVBv4r5xhRKHsS5uVyt0PfoD11KUijUGk1dmtFYYeSVOkzOULDFzIIhYmGjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=x37O6IDt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yqgzfKsO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=x37O6IDt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yqgzfKsO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1413921AA6;
	Mon,  1 Jul 2024 13:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719840489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=zsWBbdkOV0YCCxAgZ8SJZpYJf6nixVUmkGp0FuapMkM=;
	b=x37O6IDtAT63Q8rapWHQ4FbL2qyXxGESMk/nAewS2Qac0BKsFxUgGUGI/Ee54kYpZxL4zb
	l3E4eiJ+nb050s5oizNDGeTxLn+twumAWISAh5sEm8AcZzq5pJ6VIPLXxGgDTgrQMQfZOf
	5rfU2AzPzJ3ZYniGOJkjpnlpdPX6pIY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719840489;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=zsWBbdkOV0YCCxAgZ8SJZpYJf6nixVUmkGp0FuapMkM=;
	b=yqgzfKsOnCYps9G4iarlBQvL/ovqPnAwj5oTsxNFDm+vQb8IlwFR7zBd66hpL+27+ZT2rm
	f8WkL2hgPWsiUuCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=x37O6IDt;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=yqgzfKsO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719840489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=zsWBbdkOV0YCCxAgZ8SJZpYJf6nixVUmkGp0FuapMkM=;
	b=x37O6IDtAT63Q8rapWHQ4FbL2qyXxGESMk/nAewS2Qac0BKsFxUgGUGI/Ee54kYpZxL4zb
	l3E4eiJ+nb050s5oizNDGeTxLn+twumAWISAh5sEm8AcZzq5pJ6VIPLXxGgDTgrQMQfZOf
	5rfU2AzPzJ3ZYniGOJkjpnlpdPX6pIY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719840489;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=zsWBbdkOV0YCCxAgZ8SJZpYJf6nixVUmkGp0FuapMkM=;
	b=yqgzfKsOnCYps9G4iarlBQvL/ovqPnAwj5oTsxNFDm+vQb8IlwFR7zBd66hpL+27+ZT2rm
	f8WkL2hgPWsiUuCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 08D7E13800;
	Mon,  1 Jul 2024 13:28:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id M5cfAumugmZXXAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 01 Jul 2024 13:28:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9C3CEA08A6; Mon,  1 Jul 2024 15:28:04 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Ted Tso <tytso@mit.edu>
Cc: <linux-ext4@vger.kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH] jbd2: Increase maximum transaction size
Date: Mon,  1 Jul 2024 15:28:00 +0200
Message-Id: <20240701132800.7158-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1221; i=jack@suse.cz; h=from:subject; bh=TOQqCCCsmVhB9wUwD05+zD0p6Jvxnhhi5sXM+lmZHuI=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBmgq7atmh1ThlUsIIs7R5LlhsD2kMY+ScmNuSizi2d KQgHImOJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZoKu2gAKCRCcnaoHP2RA2bl9B/ 9MWXUKHvvuC5atjVC8dfMSZANGkYDhz0ScQqS9D+U1fN4F+B9Je3Eqy+EIflOJdw+puPLLGXCwMKVx x+mgWUsiTfT6xKgcPeLWMcdk6Hk4ObfOhwYZkVRScDAZVbaP2DecSrosjHI/v0eZHj0P6z75ZgwmhL tifGQ2ecrOSpU6Br1DYwwoyoSAbPK5ZWHJQEuGMEP3gEGP43C/ma7w7JEk5re3tvxORe0ShsDXuFy6 dCR93Ss+asCSufzH1fYs1U+6BxPdMKH+cIOmLkx6VG3RCDpwzCeTmfZxwH67xOFeb/QT+e4NLGweA6 RXMKFuXNVjduEFq5U9FZhD28Qa2oDi
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 1413921AA6
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

Originally, we were quite conservative in limiting maximum transaction
size to a quarter of the journal because we were not accounting
transaction descriptor and revoke blocks. These days we do properly
account them and reserve space for them from the total transaction
credits. Thus there's no need to be so conservative and we can increase
the maximum transaction size to one third of the journal (even half
should work fine in principle but the performance will likely suffer in
that case). This also fixes failures to grow filesystems with tiny
journals.

Link: CA+hUFcuGs04JHZ_WzA1zGN57+ehL2qmHOt5a7RMpo+rv6Vyxtw@mail.gmail.com
Signed-off-by: Jan Kara <jack@suse.cz>
---
 include/linux/jbd2.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index ab04c1c27fae..7273ef1732bf 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1662,7 +1662,7 @@ int jbd2_fc_release_bufs(journal_t *journal);
 
 static inline int jbd2_journal_get_max_txn_bufs(journal_t *journal)
 {
-	return (journal->j_total_len - journal->j_fc_wbufsize) / 4;
+	return (journal->j_total_len - journal->j_fc_wbufsize) / 3;
 }
 
 /*
-- 
2.35.3


