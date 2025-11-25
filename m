Return-Path: <linux-ext4+bounces-12027-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 69750C8467A
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Nov 2025 11:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 88ABC4E893D
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Nov 2025 10:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9162EE274;
	Tue, 25 Nov 2025 10:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PdK0Za54";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iAQOoq5Z";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XfNg74mh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Nr/UR34u"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3A72EDD41
	for <linux-ext4@vger.kernel.org>; Tue, 25 Nov 2025 10:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764065659; cv=none; b=eL0jzDweq/+IrLttlYQ/roAdDYR/VScpG0/0Elg7fG1Go/3RwJlmC2ajy3UPmyZxV9TOAxUdWqFBv+1gz/rDzuLU/LHz/L1qI9yyHG6TIUy9FPBneLjKVO9PvGiu8uPhb6mmAZA5SBQOf6J0mGXWKxXm7uiO7T+f9ohJiNAYlo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764065659; c=relaxed/simple;
	bh=Q+g4bzdc7lKYS1qIIzXcVpd1KTXMnYPFkyjSyCP1/14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lsugdYjHrl369PhxcD1ZudKyNVU6t+MIL0j74mIBH8/vb0CbL1jmlAcOCbswI10181Ur/LolLJQRh1NXJfq00yvcHXRz+4TlVeWwlmW+kqze9QkWkQutkETi8MVBkzMLXjBkSl2+V9Gr+Jh78vaP6z0o+1tTZTA1SkoLVoEqHN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PdK0Za54; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iAQOoq5Z; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XfNg74mh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Nr/UR34u; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BEFCC2227F;
	Tue, 25 Nov 2025 10:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764065655; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=posuyBeyFseLIL9YqX/GjI2Aj1qaYkpfeB7iN+ayoF4=;
	b=PdK0Za54JGH/ZTspXGlsG7BTvdIXoxMbYRw4Fgc6gU0HzCSovXMeJ1KjU5KNqYki5WGAz9
	x8k9mDT2XQIImzSwNxjIgT2HfxhE8aU6d1uWqxBdzvP7XvzSmXVaFWm6CVQqt4RMIN7RdU
	U8j25+2VfhcQFVuPe595H9oykA7NGlg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764065655;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=posuyBeyFseLIL9YqX/GjI2Aj1qaYkpfeB7iN+ayoF4=;
	b=iAQOoq5Z41vZZzCTtr3SVini0PeVW+VsJlgNQZtbI4g5ePi/b1BV8KlH8ZCHi2Og7HFKCy
	iPDsuiyIq6aVzCAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=XfNg74mh;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="Nr/UR34u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764065654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=posuyBeyFseLIL9YqX/GjI2Aj1qaYkpfeB7iN+ayoF4=;
	b=XfNg74mh0YfxYnbyTvJ10vRWbZqAKm/sbd2vQ46i1vzDj4hatdu7OpIOde/YZNwJ03ZxIl
	q99HoY0V9+xPThtARZ6E43xhtg2Ipr/A4kBHdI2lv1Z6+zk5BwOlGxMttL6fq4iyqpmbDs
	w4GCiRCr79MUULHV+X6LJKX0G+MrJaE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764065654;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=posuyBeyFseLIL9YqX/GjI2Aj1qaYkpfeB7iN+ayoF4=;
	b=Nr/UR34u5iU/1v8GJ1DqfMiJ0D7iNvdqonmopy7yjVkTiL1akGwD/2F2iMgtuEMYynOdH5
	ZKzAV7XaqD5T4jBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B4CD13EA63;
	Tue, 25 Nov 2025 10:14:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ksweLHaBJWlSbAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 25 Nov 2025 10:14:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 67D65A0C7D; Tue, 25 Nov 2025 11:14:14 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: Ted Tso <tytso@mit.edu>
Cc: <linux-ext4@vger.kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] ext4: Mark inodes without acls in __ext4_iget()
Date: Tue, 25 Nov 2025 11:13:41 +0100
Message-ID: <20251125101340.24276-2-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1361; i=jack@suse.cz; h=from:subject; bh=Q+g4bzdc7lKYS1qIIzXcVpd1KTXMnYPFkyjSyCP1/14=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpJYFU2HExgsZZoSn8Gbbv1HIPH+r8R1oWqnowL XSXsGp6l2yJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaSWBVAAKCRCcnaoHP2RA 2Tr/CAC/qH9xSDDnig4RdpEfvRwqFPuqE93pLWJ2PgHz/pkQTAa5LIQGjWTKJvZlzhNJrOuodhG K233DXvRJ7BtHCfVds3Rn4G3H6D0aa+G23ipTj+HTtN82zqwKw2LSb4lyCV09kPM2fSOrYW1MWB dlGlZV3k6AZCOpo2R6P0AduPTdpRLdFM0DtApAER9dcYbhSxNyYtpF2/WjjXFAE3rpf/U1/XlS7 5zYTSOInmjtRsGAO/VGIZnxf2gI2Wp7k323ZGOO1+miF9Q17oP0bG09XWSUc3rpGyyc8wrz5Iqt ZxxNBukmgjFl+t7n4uV4YU8AKymI3iUfB8qu9qzzld/5mJNk
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BEFCC2227F
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,suse.cz,linux-foundation.org];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

Mark inodes without acls with cache_no_acl() in __ext4_iget() so that
path lookup can run in RCU mode from the start. This is interesting in
particular for the case where the file owner does the lookup because in
that case end up constantly hitting the slow path otherwise. We drop out
from the fast path (because ACL state is unknown) but never end up calling
check_acl() to cache ACL state.

The problem was originally analyzed by Linus and fix tested by Matheusz,
I'm just putting it into mergeable form :).

Link: https://lore.kernel.org/all/CAHk-=whSzc75TLLPWskV0xuaHR4tpWBr=LduqhcCFr4kCmme_w@mail.gmail.com
Reported-by: Mateusz Guzik <mjguzik@gmail.com>
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index e99306a8f47c..2b68d0651652 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5521,7 +5521,9 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	if (ret)
 		goto bad_inode;
 	brelse(iloc.bh);
-
+	/* Initialize the "no ACL's" state for the simple cases */
+	if (!ext4_test_inode_state(inode, EXT4_STATE_XATTR) && !ei->i_file_acl)
+		cache_no_acl(inode);
 	unlock_new_inode(inode);
 	return inode;
 
-- 
2.51.0


