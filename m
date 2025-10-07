Return-Path: <linux-ext4+bounces-10649-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D392BC1905
	for <lists+linux-ext4@lfdr.de>; Tue, 07 Oct 2025 15:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF79C19A3EEA
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Oct 2025 13:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791652E0B6E;
	Tue,  7 Oct 2025 13:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HBHkYXmo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NDUoJNmw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HBHkYXmo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NDUoJNmw"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2B5EACD
	for <linux-ext4@vger.kernel.org>; Tue,  7 Oct 2025 13:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759844988; cv=none; b=JchEaWR4rg88gpwC1m0teS6Rp36IDVmJb1najCb9H1AYjMtkg+yccMtTukRxZfV43x7qI5SptvX/O1obf9IywgCZonT7D0yFuet2CgsHIEAHX9lSwliDJggJibrMIFeKQsh3OoSS/7mkxDdJd8KPLVUNJSAmu1hZFaz0URKyofM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759844988; c=relaxed/simple;
	bh=NiiRiZ4Op4aVyd5iExR2avn2rAwSL6W62Gw4k/rtg60=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kP6ZSKHqYPSd8Jyq6snywI3iLM0Lg/kATr05aLpusEQPEv3BFccTd97Z+fOcIxQQmxsBH/Sm5rvPqQ7QZaYSAqzahj3OozJ2KiAbym0+7AOWa83zZ2aBIQ7yAFd3wcxCXiazhOzJowIuDljwhIYJf4UC9W+28sdDoFPDPbyETtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HBHkYXmo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NDUoJNmw; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HBHkYXmo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NDUoJNmw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 90DCA1F7C5;
	Tue,  7 Oct 2025 13:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759844984; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=l2oUPBTs99/ZV8SuZiabo1B5Y9QYxp4YpATQ5sHiDGA=;
	b=HBHkYXmojuh4bsZ0KEUdNr+BpnVpfR2mOwwiq/ZcXbdOFYzA8gcNjdWEb+i0RU1l7pvPZl
	E2qv3Zbt4gSB7rO59Jbe0uCiA62l8n/VWJNT0PtbF0eAkMs0S6mh3sfgK0SUqIIOgaQL4e
	6l7cPJhww4gBjrx9txk4uLB0JymCOMc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759844984;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=l2oUPBTs99/ZV8SuZiabo1B5Y9QYxp4YpATQ5sHiDGA=;
	b=NDUoJNmw0OySA9j09HxxzKydP62C5kgIkZHcwUeA8RLA8nn18Lru2LcVjpNZJae7rvwIS7
	tGekILVsLca10eDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=HBHkYXmo;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=NDUoJNmw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759844984; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=l2oUPBTs99/ZV8SuZiabo1B5Y9QYxp4YpATQ5sHiDGA=;
	b=HBHkYXmojuh4bsZ0KEUdNr+BpnVpfR2mOwwiq/ZcXbdOFYzA8gcNjdWEb+i0RU1l7pvPZl
	E2qv3Zbt4gSB7rO59Jbe0uCiA62l8n/VWJNT0PtbF0eAkMs0S6mh3sfgK0SUqIIOgaQL4e
	6l7cPJhww4gBjrx9txk4uLB0JymCOMc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759844984;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=l2oUPBTs99/ZV8SuZiabo1B5Y9QYxp4YpATQ5sHiDGA=;
	b=NDUoJNmw0OySA9j09HxxzKydP62C5kgIkZHcwUeA8RLA8nn18Lru2LcVjpNZJae7rvwIS7
	tGekILVsLca10eDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 813CA13693;
	Tue,  7 Oct 2025 13:49:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tEyEH3ga5WjvLwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 07 Oct 2025 13:49:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DDF4DA0A58; Tue,  7 Oct 2025 15:49:43 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Ted Tso <tytso@mit.edu>
Cc: <linux-ext4@vger.kernel.org>,
	Jan Kara <jack@suse.cz>,
	Chris Mason <clm@meta.com>,
	stable@vger.kernel.org
Subject: [PATCH] ext4: free orphan info with kvfree
Date: Tue,  7 Oct 2025 15:49:37 +0200
Message-ID: <20251007134936.7291-2-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1066; i=jack@suse.cz; h=from:subject; bh=NiiRiZ4Op4aVyd5iExR2avn2rAwSL6W62Gw4k/rtg60=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBo5RpwB/rCWfcexwuZyzOrWB+lT4z0ESu78mdHu gHRC5G6t+uJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaOUacAAKCRCcnaoHP2RA 2YulCACix7Xw8IL22lx6ZoEemDaRwVcTlWN2ssT7WmxGY6Lz5GUPzCjBK+nj5os2CSVpFukTTCP sd+qwcVO/+n6WIWeV1JsMJwpqo5+GkpPUyCFKgCLIK+7LPtg6u2qMHXON2eCCCwNt47XcJ8CZvI YuQyKBrmYSuT7iVr6x/b+wpk24kkbUOAZQ8MvSw+xqlFAeH4d44T8i7FCP7xoMbu8mOmCCfT9kK 2RMnSF9q7d5gSUEed9W43p870ZOCSwz+BqrhuFqEjyMKxqawGR7yMGK/+pIb+U6411dXVmtueVu KQSJGJcON7mDh4E4fuenM/n/EJGFK43QBjUEY0QQ1v30wFVp
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
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 90DCA1F7C5
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

Orphan info is now getting allocated with kvmalloc_array(). Free it with
kvfree() instead of kfree() to avoid complaints from mm.

Reported-by: Chris Mason <clm@meta.com>
Fixes: 0a6ce20c1564 ("ext4: verify orphan file size is not too big")
CC: stable@vger.kernel.org
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/orphan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/orphan.c b/fs/ext4/orphan.c
index 33c3a89396b1..82d5e7501455 100644
--- a/fs/ext4/orphan.c
+++ b/fs/ext4/orphan.c
@@ -513,7 +513,7 @@ void ext4_release_orphan_info(struct super_block *sb)
 		return;
 	for (i = 0; i < oi->of_blocks; i++)
 		brelse(oi->of_binfo[i].ob_bh);
-	kfree(oi->of_binfo);
+	kvfree(oi->of_binfo);
 }
 
 static struct ext4_orphan_block_tail *ext4_orphan_block_tail(
@@ -637,7 +637,7 @@ int ext4_init_orphan_info(struct super_block *sb)
 out_free:
 	for (i--; i >= 0; i--)
 		brelse(oi->of_binfo[i].ob_bh);
-	kfree(oi->of_binfo);
+	kvfree(oi->of_binfo);
 out_put:
 	iput(inode);
 	return ret;
-- 
2.51.0


