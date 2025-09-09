Return-Path: <linux-ext4+bounces-9876-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08423B4ABB6
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Sep 2025 13:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA52A16E25C
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Sep 2025 11:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F92F23D7FC;
	Tue,  9 Sep 2025 11:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cDubGLpH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fYbFzi4P";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bluy31Mg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="I++AyJPt"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF3623D28B
	for <linux-ext4@vger.kernel.org>; Tue,  9 Sep 2025 11:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416942; cv=none; b=Tlg7vsRkhmrFpLGKrhP3hywJmHWWayIOMF4TxaBOBDqEmdXYXwHFt1FpS7dipI5If+ZBIrYvvUvOiIbxcZtMV6lc+dwgTKrppHZxmwB5qnH88C/jIkD96fRwYZRgHtU+Nr9/KHoNWuCPovx0w5IEVBGyJ5SQ4nTtvB409vNlENM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416942; c=relaxed/simple;
	bh=CZTZkaz8fFGpJwAUtovxj3cZqwvM3fv76AdbS15IbjM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=htQ3uh4iNCVnaqXgrqgLESI6g0E1N6+44evZdAsk4OLgSzVca78If6HFQjZ8MNhzII776EMtr4215pja+29Scmga2n4bv8KkxC6XVn9aPTme+WzQS4mOI+cE2fDeWdQx4LV/eQGJDHCUm1dHyLwaAq5bSd+SIb1NciFzUBTwynE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cDubGLpH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fYbFzi4P; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bluy31Mg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=I++AyJPt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7DB9A34297;
	Tue,  9 Sep 2025 11:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757416938; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=QMCnoAoqwqhwGN5LF/XEwoPmt27NEegOFn3hOBNgeLM=;
	b=cDubGLpHC2XzgZXwQLmCTTqPzQWDvWUpHJqQ7myCxKvrhqkX7bQIBhdfUMK1Wvn0mreWEi
	tQvvvSD5MHD4KAuZ6YsmRAIkdfz8mkmBOibw27YM9izK8AcUZM4npWiLOHDRT0o/ttaMnH
	qZKKHnbrVzRzR8fH8Xh08B+jxun9yA8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757416938;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=QMCnoAoqwqhwGN5LF/XEwoPmt27NEegOFn3hOBNgeLM=;
	b=fYbFzi4PXWBunxwZIZkqtzLznEGYAa84t1vtUTRZR6pGuZZEVS3bhYsmMW2HSXfN0ddggK
	1rqHNyLAAHkgwNDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757416937; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=QMCnoAoqwqhwGN5LF/XEwoPmt27NEegOFn3hOBNgeLM=;
	b=bluy31MgIVJrmAKV+pgiOcQe+z701nJyVtWBEp9FkcBzypwNgTZZJZ+58rJmP1hu9L0S++
	tIBe9qXng8/xGnRKqgyiyRCVsDh8CZu9MGdlNlGyxXHbSVWtz89ho5Fc1x8feaJsCnqaN0
	inNQVfLwueOghIdlDN3zgSnuerTu/sY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757416937;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=QMCnoAoqwqhwGN5LF/XEwoPmt27NEegOFn3hOBNgeLM=;
	b=I++AyJPtnHYsaf9Evi83y7uBsFRlg276cU5I2DrSRw1SfDMAYy/cGV7geElXAuqzSFwBcv
	sYgqdgzaBgMFLxAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7339E1365E;
	Tue,  9 Sep 2025 11:22:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id knsXHOkNwGipMwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 09 Sep 2025 11:22:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 280EFA0A2D; Tue,  9 Sep 2025 13:22:17 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Ted Tso <tytso@mit.edu>
Cc: <linux-ext4@vger.kernel.org>,
	Jan Kara <jack@suse.cz>,
	syzbot+0b92850d68d9b12934f5@syzkaller.appspotmail.com
Subject: [PATCH] ext4: verify orphan file size is not too big
Date: Tue,  9 Sep 2025 13:22:07 +0200
Message-ID: <20250909112206.10459-2-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1654; i=jack@suse.cz; h=from:subject; bh=CZTZkaz8fFGpJwAUtovxj3cZqwvM3fv76AdbS15IbjM=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBowA3e9Y8r53DBi5JIKg2JiwZlNB5F+aF303vZJ pt7XSY1tZqJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaMAN3gAKCRCcnaoHP2RA 2XqtCAC6VhA2tgnzpehzcFviVKlD6av5lIVzD4EgLsCOft31hB8carpDCHRw7bFiYkZsaL/DgQM RDGeFdbKyHgTF7HExwWPxy+m6sBg/CW5VWcZAOO1BlCmf5nj2cIztNRDU0wWxeO9Pz3+ra92kxC bfeFqkSOzEbwVq7AWL+SGAlh7k36kA3YSNn3DM3IzAr03/vNSKx39DGEpesTGmYfhDf7jQ0faDB fmclGdiBL6JmMtP1Od+lAzOi9/zs+x4dGVIwVi+hvveUt5y2Th10UwHDu/66rAp+Qaca722TG0n hv7nzHqf+BaWP2fTKa0W3PvDpfT56Fzn/x6HGNLrgJCq4Z/V
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[0b92850d68d9b12934f5];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -1.30

In principle orphan file can be arbitrarily large. However orphan replay
needs to traverse it all and we also pin all its buffers in memory. Thus
filesystems with absurdly large orphan files can lead to big amounts of
memory consumed. Limit orphan file size to a sane value and also use
kvmalloc() for allocating array of block descriptor structures to avoid
large order allocations for sane but large orphan files.

Reported-by: syzbot+0b92850d68d9b12934f5@syzkaller.appspotmail.com
Fixes: 02f310fcf47f ("ext4: Speedup ext4 orphan inode handling")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/orphan.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/orphan.c b/fs/ext4/orphan.c
index 524d4658fa40..7e4f48c15c2e 100644
--- a/fs/ext4/orphan.c
+++ b/fs/ext4/orphan.c
@@ -587,9 +587,20 @@ int ext4_init_orphan_info(struct super_block *sb)
 		ext4_msg(sb, KERN_ERR, "get orphan inode failed");
 		return PTR_ERR(inode);
 	}
+	/*
+	 * This is just an artificial limit to prevent corrupted fs from
+	 * consuming absurd amounts of memory when pinning blocks of orphan
+	 * file in memory.
+	 */
+	if (inode->i_size > 8 << 20) {
+		ext4_msg(sb, KERN_ERR, "orphan file too big: %llu",
+			 (unsigned long long)inode->i_size);
+		ret = -EFSCORRUPTED;
+		goto out_put;
+	}
 	oi->of_blocks = inode->i_size >> sb->s_blocksize_bits;
 	oi->of_csum_seed = EXT4_I(inode)->i_csum_seed;
-	oi->of_binfo = kmalloc_array(oi->of_blocks,
+	oi->of_binfo = kvmalloc_array(oi->of_blocks,
 				     sizeof(struct ext4_orphan_block),
 				     GFP_KERNEL);
 	if (!oi->of_binfo) {
-- 
2.51.0


