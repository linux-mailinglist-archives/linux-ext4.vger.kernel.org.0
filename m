Return-Path: <linux-ext4+bounces-4626-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BD29A3E8A
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Oct 2024 14:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A33F8B216E7
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Oct 2024 12:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA9918E025;
	Fri, 18 Oct 2024 12:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="P2Fyfivk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fdU0MgUy";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="P2Fyfivk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fdU0MgUy"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A00615B12F
	for <linux-ext4@vger.kernel.org>; Fri, 18 Oct 2024 12:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729255037; cv=none; b=dborIUINuX5bUOe8jyE8jW1wvaCVK3Nf/3ClWDc+0oGMtv4fnSXWiwujCWxxsF7wXLW8ykhfVCTSMw/YkX4W2i1WxEIyU98dNEVA5gA+A9FtGR9IGKiQmkCfXLO5NCJPTPVj2dJXoDKVdDFyincMXJqO5JgJeZrSYo8PZXIGjlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729255037; c=relaxed/simple;
	bh=ckLaGrqmDDTu7r+cHt+YVYtb+sVV/KWvuZj17ZqMK/g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ql6gaRQgknjbAVmVXBxCsOuaqMV0eVUSxLV8cYEHoPVpaGONAIQsUFAlZ2ddb48aCHTIneJAtQSirh57NFSTTEvTQTh/B+mYJNCAxwNFSAkE6TAqLavhf01RY0A15Dw8duqGMkOVU10XnRCrRXajcixilZsTWEOJHwSTRJvE1QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=P2Fyfivk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fdU0MgUy; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=P2Fyfivk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fdU0MgUy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6DFF61FB4B;
	Fri, 18 Oct 2024 12:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729255034; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cZ+DkhmE5CTEub8c3PcItrIX2AtThiFeJbPb4DIgHu4=;
	b=P2FyfivkBS3lKw+3gx+ffaQSen8JV/6EjTQuy+dF7wKIxMTB+dIZRaxZ/akO6OFX3H4Rwa
	uySzSk3YDSfTgqQfs1DB7XsAMQG4W869FxZ8zF8SdJQu629YE5noeUZ5eyOyRYBPGT/1At
	rRCdG3jTK9j9SnrUPJRPcgOsM7+Kjrk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729255034;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cZ+DkhmE5CTEub8c3PcItrIX2AtThiFeJbPb4DIgHu4=;
	b=fdU0MgUypX++oVJBkIwHzZlbl4cYewtOgNcwusbf90G0N/PFvxJr29v+2jQO1j51l/KwO2
	6Ncun6PE5KaPREAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729255034; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cZ+DkhmE5CTEub8c3PcItrIX2AtThiFeJbPb4DIgHu4=;
	b=P2FyfivkBS3lKw+3gx+ffaQSen8JV/6EjTQuy+dF7wKIxMTB+dIZRaxZ/akO6OFX3H4Rwa
	uySzSk3YDSfTgqQfs1DB7XsAMQG4W869FxZ8zF8SdJQu629YE5noeUZ5eyOyRYBPGT/1At
	rRCdG3jTK9j9SnrUPJRPcgOsM7+Kjrk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729255034;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cZ+DkhmE5CTEub8c3PcItrIX2AtThiFeJbPb4DIgHu4=;
	b=fdU0MgUypX++oVJBkIwHzZlbl4cYewtOgNcwusbf90G0N/PFvxJr29v+2jQO1j51l/KwO2
	6Ncun6PE5KaPREAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 639EA13433;
	Fri, 18 Oct 2024 12:37:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UGtJGHpWEmdiFQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 18 Oct 2024 12:37:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2A471A080A; Fri, 18 Oct 2024 14:37:10 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Ted Tso <tytso@mit.edu>
Cc: <linux-ext4@vger.kernel.org>,
	Jan Kara <jack@suse.cz>,
	Baolin Liu <liubaolin12138@163.com>,
	Zhi Long <longzhi@sangfor.com.cn>
Subject: [PATCH v2] ext4: Make sure BH_New bit is cleared in ->write_end handler
Date: Fri, 18 Oct 2024 14:37:07 +0200
Message-Id: <20241018123707.19371-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1734; i=jack@suse.cz; h=from:subject; bh=ckLaGrqmDDTu7r+cHt+YVYtb+sVV/KWvuZj17ZqMK/g=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBnElZtk7VKHVYzLx//+CXaZbLizJVlBdGMn3f7Pkb4 W4jbJbmJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZxJWbQAKCRCcnaoHP2RA2dCuB/ 0attPEIKIvahBx32flZOwWyFEDsToNIJsETFoVFv3QtB3Ryd6XAJ7ibS4jKZbmuilBASHrUvjRRyji 0EL1AOmeuDV23FQrbTAdcTmuE25771j7VwxNlrBDKCWold8QsWpjNaod2YNlQJkPuWXmigYZMme7X9 r3UrjYGna0pUox028vlH1KmHBXCHOF9IjoMqJzTnCe7JQHppN6SAYwbsCRZZvwpCiVwxai/ZJTaKyS 6VaUk55P0Mgal8SkRxPQMsIEsY6TiUL2lCwvwXGZdGSoL7rCK/Gq/1Fdc1SfdGdOfT2JivV4nHAtzt 90NzxVo8edAyhV0ZYmcooiqgkLqE3h
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,suse.cz,163.com,sangfor.com.cn];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[163.com]
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

Reported-and-tested-by: Baolin Liu <liubaolin12138@163.com>
Reported-and-tested-by: Zhi Long <longzhi@sangfor.com.cn>
Fixes: 3910b513fcdf ("ext4: persist the new uptodate buffers in ext4_journalled_zero_new_buffers")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

- changes since v1: Updated tags

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


