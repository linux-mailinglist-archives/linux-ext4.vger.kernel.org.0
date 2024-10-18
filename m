Return-Path: <linux-ext4+bounces-4621-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBADE9A39B4
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Oct 2024 11:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 979EF281AA3
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Oct 2024 09:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39BA190676;
	Fri, 18 Oct 2024 09:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GJXk/kLo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ixAe/3pR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GJXk/kLo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ixAe/3pR"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A97F1E3DC5
	for <linux-ext4@vger.kernel.org>; Fri, 18 Oct 2024 09:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729242871; cv=none; b=qFniZwW+H8gnnWqlkYCq3ux0H3sMj73nNkuuHedZXDYR9mUdePF7QT/5+kahkpSnmfrfX10y2couo6ckBl5L7ftLzL10fgPERyOm0wi1UZ7jmH4qdxklnJuAMeFRqxy+M1+3SplMGnQamY84KBGQILO0TFl7xdwVIS4XFMZFlwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729242871; c=relaxed/simple;
	bh=qTCjduvwJWJoN+FVvmJK2kPgDvA7kR93xr4uLbgz37g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CSir+CHOfv3h8YRsW2vpfzt9jgj0LJ7i9o2cei3WoHgnKzNlub10jmIHkUrYossq7ROk9LI8IXbPjKm16aNT/Y7D1ZWgpbDpgAm+v5IT4kYwy+y6PxxZwQ1PsHnBOvA6ZI3LgsX3cR8R8s2oeD9QOFKCHuZxOpnM7vRsojkHRLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GJXk/kLo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ixAe/3pR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GJXk/kLo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ixAe/3pR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6EBBA1FDA2;
	Fri, 18 Oct 2024 09:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729242862; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8HtX5BmiqVcnJm6kkDA0ytdg81sW3Amjp7shqF/kT9E=;
	b=GJXk/kLoqyspQfbzt06u1gkdAp8kBNga1FdJHX1scBE9xRjQvVg6fRxHI4ZRLxczQeWesM
	/YfgWal6Rqt3HSBzbNGLL3VdsibEHN6dFMXF7scCHiAV9bN1PmtoTZAJW+4ztHhQpHqq44
	Aq8QAp8ciFJN5lDprgIAYldvGrG2H3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729242862;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8HtX5BmiqVcnJm6kkDA0ytdg81sW3Amjp7shqF/kT9E=;
	b=ixAe/3pRDygjf662XhUiuPa4zfaGjhZ3ENXIZPwmxV3gdGD3f5gPRf1Yqti2X0vXRKZrmT
	ce25cECS6zEv6vBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="GJXk/kLo";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="ixAe/3pR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729242862; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8HtX5BmiqVcnJm6kkDA0ytdg81sW3Amjp7shqF/kT9E=;
	b=GJXk/kLoqyspQfbzt06u1gkdAp8kBNga1FdJHX1scBE9xRjQvVg6fRxHI4ZRLxczQeWesM
	/YfgWal6Rqt3HSBzbNGLL3VdsibEHN6dFMXF7scCHiAV9bN1PmtoTZAJW+4ztHhQpHqq44
	Aq8QAp8ciFJN5lDprgIAYldvGrG2H3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729242862;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8HtX5BmiqVcnJm6kkDA0ytdg81sW3Amjp7shqF/kT9E=;
	b=ixAe/3pRDygjf662XhUiuPa4zfaGjhZ3ENXIZPwmxV3gdGD3f5gPRf1Yqti2X0vXRKZrmT
	ce25cECS6zEv6vBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A81513680;
	Fri, 18 Oct 2024 09:14:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id H6MRFu4mEmeaVgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 18 Oct 2024 09:14:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0869BA080A; Fri, 18 Oct 2024 11:14:22 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Ted Tso <tytso@mit.edu>
Cc: <linux-ext4@vger.kernel.org>,
	Jan Kara <jack@suse.cz>,
	Baolin Liu <liubaolin12138@163.com>,
	Zhi Long <longzhi@sangfor.com.cn>
Subject: [PATCH] ext4: Make sure BH_New bit is cleared in ->write_end handler
Date: Fri, 18 Oct 2024 11:14:15 +0200
Message-Id: <20241018091415.31791-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1676; i=jack@suse.cz; h=from:subject; bh=qTCjduvwJWJoN+FVvmJK2kPgDvA7kR93xr4uLbgz37g=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBnEibXqO/um4nOMwqnHSY3Cn6Hfy5kBmM6myEdpvTG EnazJ66JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZxIm1wAKCRCcnaoHP2RA2fzCCA DSfJD5vzjFHf+wnu5JpBKhNNOd7xWDKuG082+4e2zxNfkVuGZA98AZO85CIwllvcaFeYVBXwuCTbh0 0I+WCJe2vass3IvtbaDqZoRjIjw3F/4Y4FhWTkwunSUX10OjhOyjPROF+FORLAwF/N01tg9iLqnMdD gxMIcZgnK0pjMj9HOaT6oxRp5USR8QDARosGobSGvYLKB2y+QLOG32Qxm3bMKK9Oak/FQqg9VVfYkU RlazgAZPWkK1GUPQrcgfO7UNi7rgyPYkjebnbWZ3dI33PAUSOP3wNI+FM9bZxmU4JOvbmQSUquwdVQ QoZpkdrTjDJ3rUVSw1weV95dqIC9ZV
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6EBBA1FDA2
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,suse.cz,163.com,sangfor.com.cn];
	FREEMAIL_ENVRCPT(0.00)[163.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.cz:mid];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

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
 fs/ext4/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

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


