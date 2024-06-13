Return-Path: <linux-ext4+bounces-2876-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FD79075F0
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Jun 2024 17:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA8831C22A95
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Jun 2024 15:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EF4149006;
	Thu, 13 Jun 2024 15:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vsQ6UjU5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gYM8a8+P";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EFQqZ1tT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Bx/wcvOy"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE233146A67
	for <linux-ext4@vger.kernel.org>; Thu, 13 Jun 2024 15:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718290968; cv=none; b=mZMPbCL8WUL5GlZ7DTl5LHYjpBhZHHXwkuAiKPCqkVP/95tDb5W/piDhMES4O6fOvXjOmHyqTO4q4wN199sOfLb/+YJ622N2zdw3uV91t4p7tz7XLXaj5hMH05UBRPWLhP17liQpAyofME9ZDJd9cRzXUD5J4DetND2kOkLD5u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718290968; c=relaxed/simple;
	bh=fAqjK5O1c8mIp8p6SwbPnUCT2Xqi3fFywkvYhHxu9D4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XZtJBD1ezaQUZZj8528TkUnOeocwFurb4f2AsGhK2BnxplvIMulDk3qHrC1bILtCWyG5WIr0wPvo5rAZjYPDyrIZfCRZ74UhaLPgRVgfBk7cCmU5UkTqZ+iUjap6geLbxsbetPZs6d7mtsjjN4MTqNYm9Wkq3ILqk4/mi3dvUaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vsQ6UjU5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gYM8a8+P; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EFQqZ1tT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Bx/wcvOy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C87B1372E1;
	Thu, 13 Jun 2024 15:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718290965; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=SD6jIpupBdBHUAMwJsF533Ss0oyAQrgLXeA5Z7ZQvMI=;
	b=vsQ6UjU5BUAF+d42WvVY+TCF81cZlyvGAxnbbitZprEyl8pK7KSBwI77ZSJxFDRaj1G0kk
	JJdqIE/8XzoEvb/KHgGf332KVF3SZaZA3dJCHljYO+Am+6OGUeWjRezmwOoASF15kRqJsi
	j/lb4jPIKulabjpZisVJWCaFSjDOvKs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718290965;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=SD6jIpupBdBHUAMwJsF533Ss0oyAQrgLXeA5Z7ZQvMI=;
	b=gYM8a8+PaSDxXnB6bf+VKawP7p9Z1GfRWm3fdUa4qP4piHFCAqnf73fkXfgvRCmsJxbZ+P
	DFBGgdIRSYUbXhDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=EFQqZ1tT;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="Bx/wcvOy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718290964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=SD6jIpupBdBHUAMwJsF533Ss0oyAQrgLXeA5Z7ZQvMI=;
	b=EFQqZ1tTSyfj/lhKPb54wYYDnkWG37Gw8itl6s7zINXbd2/NdHc6xqlKXAqlhnSJfauHwC
	4XEOjbEQX8QegIY5MycMG4b+fatp8DfzKfxEnMp9rg1cls74Z43sEwqAp0CkP5G6e1bTGH
	b+TvR+bOECU2DUC6TqBm/Xk8Af4YHTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718290964;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=SD6jIpupBdBHUAMwJsF533Ss0oyAQrgLXeA5Z7ZQvMI=;
	b=Bx/wcvOyoWWVbRNjEks4PslLhllbl+7gGW2WH9VPH92czO2GjR35cOEUgtrYdKMylRt9Qk
	Ril74twlwsYsjkDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BDD9513A7F;
	Thu, 13 Jun 2024 15:02:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fZ1TLhQKa2afWgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 13 Jun 2024 15:02:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6CC0CA0869; Thu, 13 Jun 2024 17:02:44 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Ted Tso <tytso@mit.edu>
Cc: <linux-ext4@vger.kernel.org>,
	Jan Kara <jack@suse.cz>,
	syzbot+9c1fe13fcb51574b249b@syzkaller.appspotmail.com,
	Hugh Dickins <hughd@google.com>
Subject: [PATCH] ext4: Avoid writing unitialized memory to disk in EA inodes
Date: Thu, 13 Jun 2024 17:02:34 +0200
Message-Id: <20240613150234.25176-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1189; i=jack@suse.cz; h=from:subject; bh=fAqjK5O1c8mIp8p6SwbPnUCT2Xqi3fFywkvYhHxu9D4=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBmawoEn85IpjKYBZsoB4Nigkrt07q/+/iFBP54bscq pIME9nCJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZmsKBAAKCRCcnaoHP2RA2YShCA CbtaAwljq93evKtXYyn8f/VkItKMhSDGDJw1fdVH8apBnwDuC2xYBb+1kBOfItzMJsp4tbhqaNcMm3 bdAvjajy/mVkmR6NHb+lRrHz71lfbnf3Gp6PJrNWt9SPss3mVDFAVJ18y7H3+dgObqH+GEFjQHp7UU +Sh71PNg+rk5+kVeG88vwikh4AbNJOVivpCzLkJygJ6F9oJJrb8QGwVmrl9bBnfgvubZ9IR/57jpEE t6sdhsnw9wY11tOu0mYdKnnzyjo9UTfHh4h4z6HuVHVb18wxgkw8QZvRni2HnArPn6O885r41shTLJ w/n6H7sXY64J7lc1XUbPP1eVWdoOag
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C87B1372E1
X-Spam-Score: -1.51
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.51 / 50.00];
	BAYES_HAM(-3.00)[99.98%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TAGGED_RCPT(0.00)[9c1fe13fcb51574b249b];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

If the extended attribute size is not a multiple of block size, the last
block in the EA inode will have uninitialized tail which will get
written to disk. We will never expose the data to userspace but still
this is not a good practice so just zero out the tail of the block as it
isn't going to cause a noticeable performance overhead.

Fixes: e50e5129f384 ("ext4: xattr-in-inode support")
Reported-by: syzbot+9c1fe13fcb51574b249b@syzkaller.appspotmail.com
Reported-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/xattr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 6460879b9fcb..46ce2f21fef9 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1433,6 +1433,12 @@ static int ext4_xattr_inode_write(handle_t *handle, struct inode *ea_inode,
 			goto out;
 
 		memcpy(bh->b_data, buf, csize);
+		/*
+		 * Zero out block tail to avoid writing uninitialized memory
+		 * to disk.
+		 */
+		if (csize < blocksize)
+			memset(bh->b_data + csize, 0, blocksize - csize);
 		set_buffer_uptodate(bh);
 		ext4_handle_dirty_metadata(handle, ea_inode, bh);
 
-- 
2.35.3


