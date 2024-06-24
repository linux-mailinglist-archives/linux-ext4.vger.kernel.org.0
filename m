Return-Path: <linux-ext4+bounces-2934-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82192915287
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Jun 2024 17:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A51861C22375
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Jun 2024 15:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684CA19D062;
	Mon, 24 Jun 2024 15:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="boYr6VE2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UXUyT7Wz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="boYr6VE2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UXUyT7Wz"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F4319CD06;
	Mon, 24 Jun 2024 15:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719243206; cv=none; b=H5h9GoLndeDCeDOYLYmw9+H45jOsfNMCMtQI96euvM5T68hrmC02vlLL/l5t6PuPleG17gKmWTz2/lF8tkte+5D7GfcI8tK9EXWJNB/3iwBZNl11kvvbSORgwxlFZoMkcI9GXKedFW2RnaDxWs5hZ7hsDewH80pAj3mqnG9zRoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719243206; c=relaxed/simple;
	bh=Xrk7CoStsIaWxSr8LgAiR1wyjZyNoobU6wGq3ooGUTE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aVpIi3m5qpdjFyNuP1xTqDP0mvlGpxfZoay4Z5+TRo8biykZjeGVJfrlbJXlX3vLxCe2HNFgxtwhJCk7uPdO03jnUR5Vm1/IkUKLUTNUPgDSvLr+kWoCH+lE9jxNP8GFa6a0EUyR2CYZHm5p90YjpEPILOiZHigqxkm7QY6jH4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=boYr6VE2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UXUyT7Wz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=boYr6VE2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UXUyT7Wz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 66CBC1F826;
	Mon, 24 Jun 2024 15:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719243202; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=+uyLr7pgysg/TkWjyuqtCyZhyuml0UeDYrEoYaX2k90=;
	b=boYr6VE2NOcIASKxcltalVIl0RgyhAMdpCe1GGaXOClphQiQumWL4LuYY/dqUsoQPq9oLh
	5kIEK3xMGmUrM5DFqDBOQiy54TLdPFHR47thp55T9B6rM2rwrWCFcKk1wkXSt1pXmPX7l8
	VLrcP9tavkCIS48MbJB7k2pdXLDIS8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719243202;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=+uyLr7pgysg/TkWjyuqtCyZhyuml0UeDYrEoYaX2k90=;
	b=UXUyT7WzrxfFDRKG1EmLV7iv28OPh0/j9uqns2DVHYxHfBXqAYoSiEWzX9mGjprKiu0kcN
	J4d88lSqu2QwVzCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=boYr6VE2;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=UXUyT7Wz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719243202; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=+uyLr7pgysg/TkWjyuqtCyZhyuml0UeDYrEoYaX2k90=;
	b=boYr6VE2NOcIASKxcltalVIl0RgyhAMdpCe1GGaXOClphQiQumWL4LuYY/dqUsoQPq9oLh
	5kIEK3xMGmUrM5DFqDBOQiy54TLdPFHR47thp55T9B6rM2rwrWCFcKk1wkXSt1pXmPX7l8
	VLrcP9tavkCIS48MbJB7k2pdXLDIS8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719243202;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=+uyLr7pgysg/TkWjyuqtCyZhyuml0UeDYrEoYaX2k90=;
	b=UXUyT7WzrxfFDRKG1EmLV7iv28OPh0/j9uqns2DVHYxHfBXqAYoSiEWzX9mGjprKiu0kcN
	J4d88lSqu2QwVzCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4875413AA4;
	Mon, 24 Jun 2024 15:33:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bWeuEcKReWbfHgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 24 Jun 2024 15:33:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 961F5A08AA; Mon, 24 Jun 2024 17:33:17 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-ext4@vger.kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	stable@vger.kernel.org
Subject: [PATCH] ext2: Verify bitmap and itable block numbers before using them
Date: Mon, 24 Jun 2024 17:33:16 +0200
Message-Id: <20240624153316.25961-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1877; i=jack@suse.cz; h=from:subject; bh=Xrk7CoStsIaWxSr8LgAiR1wyjZyNoobU6wGq3ooGUTE=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBmeZGsQ2hCy82HMgv7lVWpbqGjD3B40aLm4rLwvUcM tpJP31qJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZnmRrAAKCRCcnaoHP2RA2dWDB/ 0dQQhCEdJenTogvmcF0zHYtWIbRbB86pJumKabqf1mnVJu7Uq+BDtzBuBI+VsmJ3hh0HqlQSqyRUsR iRZxSm0SvNNoTd4pQquawsj95zOlbsG4PsNwebZ6gWwlnJc9qyw9nxfk+r3b4UwiEx0BkiEofDN3rB Vzz+bV5/tCnQuP0ak1kU6SMQp/WRbImmHhVGa7DeAvN3AGUBmY1VisiRiv1hQbNwvGr1sgmp5UBIqR TppYkgkzg4sWQagNS4LeKkfclxnlxnoog/EqeMDA2qqb1D844chKXnnR2G4WuM6aoMLC0N7uWRUYiZ 0mVSEae5X4bo7FgEmTwz8aOB+2wAYh
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 66CBC1F826
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spam-Flag: NO
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
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Verify bitmap block numbers and inode table blocks are sane before using
them for checking bits in the block bitmap.

CC: stable@vger.kernel.org
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext2/balloc.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

I plan to merge this patch through my tree.

diff --git a/fs/ext2/balloc.c b/fs/ext2/balloc.c
index 1bfd6ab11038..b8cfab8f98b9 100644
--- a/fs/ext2/balloc.c
+++ b/fs/ext2/balloc.c
@@ -77,26 +77,33 @@ static int ext2_valid_block_bitmap(struct super_block *sb,
 	ext2_grpblk_t next_zero_bit;
 	ext2_fsblk_t bitmap_blk;
 	ext2_fsblk_t group_first_block;
+	ext2_grpblk_t max_bit;
 
 	group_first_block = ext2_group_first_block_no(sb, block_group);
+	max_bit = ext2_group_last_block_no(sb, block_group) - group_first_block;
 
 	/* check whether block bitmap block number is set */
 	bitmap_blk = le32_to_cpu(desc->bg_block_bitmap);
 	offset = bitmap_blk - group_first_block;
-	if (!ext2_test_bit(offset, bh->b_data))
+	if (offset < 0 || offset > max_bit ||
+	    !ext2_test_bit(offset, bh->b_data))
 		/* bad block bitmap */
 		goto err_out;
 
 	/* check whether the inode bitmap block number is set */
 	bitmap_blk = le32_to_cpu(desc->bg_inode_bitmap);
 	offset = bitmap_blk - group_first_block;
-	if (!ext2_test_bit(offset, bh->b_data))
+	if (offset < 0 || offset > max_bit ||
+	    !ext2_test_bit(offset, bh->b_data))
 		/* bad block bitmap */
 		goto err_out;
 
 	/* check whether the inode table block number is set */
 	bitmap_blk = le32_to_cpu(desc->bg_inode_table);
 	offset = bitmap_blk - group_first_block;
+	if (offset < 0 || offset > max_bit ||
+	    offset + EXT2_SB(sb)->s_itb_per_group - 1 > max_bit)
+		goto err_out;
 	next_zero_bit = ext2_find_next_zero_bit(bh->b_data,
 				offset + EXT2_SB(sb)->s_itb_per_group,
 				offset);
-- 
2.35.3


