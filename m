Return-Path: <linux-ext4+bounces-4321-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3FE986585
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Sep 2024 19:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2DDE2883C2
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Sep 2024 17:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF2E3BBE3;
	Wed, 25 Sep 2024 17:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2yc7n4in";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="B2tP3VzQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2yc7n4in";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="B2tP3VzQ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BB81BC59
	for <linux-ext4@vger.kernel.org>; Wed, 25 Sep 2024 17:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727284776; cv=none; b=hyuliU8loZ2KC2PCvdAWM489le/3GwbpREQEA0lN5PyhsKjGH8xog++PwQikZ+nFFGooxXsbYgPWJpuGP9DkcyVzOilleTwUfIkljbR58pgKSYH0PyNNmqNSp3Kgcrh2B/eb8WXxU/vouR2aErLeaepK8DcWKROtxjk/1kuoCQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727284776; c=relaxed/simple;
	bh=ryoE0l3Dbi93e3DsiIytuzvUJi4Da5CFtZYSnYtuFjE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QwVss6u2xOO7OzxW2L5bWYx/hxnp1apth9QT5eX1zUToqnj0rOws8LuxsMT9fXZLRwUILn5r9/KziVQ0d4UIYWZN6FwhbIzMAHIoVIsnfbWGAT8UImogbsDOUQFD2xGbRrpjott8emDLb9dvHVp94pH4NjEfEHqPLdFe4Ss9b+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2yc7n4in; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=B2tP3VzQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2yc7n4in; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=B2tP3VzQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6A0AB1FD79;
	Wed, 25 Sep 2024 17:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727284770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ak4SwAL7wQvQ8laMpiqLgn4tbUZoE6gSAbsX1OVGBTE=;
	b=2yc7n4in2qSMZ/6/0ZgZ+TY9VOD1FPBpGyvwMIKSLWmiHtQdHjjJ1F4UrAuOVYIPnEwbW/
	2frbsGqM9dGQ+Sz62imqK0Xw1fWaSR1JBS/X4vpp6MDjntfKFSZOi880VZEP6s0FcKJSFp
	VSosqv5mctWyj72ggDUxfXwHJzPqsqs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727284770;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ak4SwAL7wQvQ8laMpiqLgn4tbUZoE6gSAbsX1OVGBTE=;
	b=B2tP3VzQCMu/dB/PTCKAMf/4CSHMIxSTHejhDWg0cLCSD6j1iU1jSVRodD3drtuYr7XoBw
	iKOIt9E9/UqPAiAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=2yc7n4in;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=B2tP3VzQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727284770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ak4SwAL7wQvQ8laMpiqLgn4tbUZoE6gSAbsX1OVGBTE=;
	b=2yc7n4in2qSMZ/6/0ZgZ+TY9VOD1FPBpGyvwMIKSLWmiHtQdHjjJ1F4UrAuOVYIPnEwbW/
	2frbsGqM9dGQ+Sz62imqK0Xw1fWaSR1JBS/X4vpp6MDjntfKFSZOi880VZEP6s0FcKJSFp
	VSosqv5mctWyj72ggDUxfXwHJzPqsqs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727284770;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ak4SwAL7wQvQ8laMpiqLgn4tbUZoE6gSAbsX1OVGBTE=;
	b=B2tP3VzQCMu/dB/PTCKAMf/4CSHMIxSTHejhDWg0cLCSD6j1iU1jSVRodD3drtuYr7XoBw
	iKOIt9E9/UqPAiAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A44413793;
	Wed, 25 Sep 2024 17:19:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OU2zFSJG9GaTIgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 25 Sep 2024 17:19:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DDCC4A0810; Wed, 25 Sep 2024 19:19:29 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Ted Tso <tytso@mit.edu>
Cc: <linux-ext4@vger.kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH] resize2fs: Check number of group descriptors only if meta_bg is disabled
Date: Wed, 25 Sep 2024 19:19:26 +0200
Message-Id: <20240925171926.11354-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2048; i=jack@suse.cz; h=from:subject; bh=ryoE0l3Dbi93e3DsiIytuzvUJi4Da5CFtZYSnYtuFjE=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBm9EYXvrGsWwc+ZDgM2pJFyTG4huornus+kexHD7Qw p+w3t4GJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZvRGFwAKCRCcnaoHP2RA2QkdCA CMdgRTusH0EKq+wMeK6RgRecYInS1+mNw7AO6qi7sSfnGjONLgJLweoc0L+30D6o0fhtMzOvEfVUxT /xwh/nY7n6A/cw4lDq3MCQtIaAYl0fRFiqiZuUtVlbPbqLB+1dMKzMDYtemHy6uMEa4QxO6OXl7l+t aTiapSBUhtCfGBVuOpgMzQ/7kfmNB1+ej5rV4uq3WcALHBEwYhr17uhqMATVnKUfTtSvXsary2lHHR 3vR9Xio0IzSF4YOqZIkTjbT6m2mlmux5iw/Qtd1fTny3RKXOCk9LwLfrkjk+tm+pGZHyH3EglRrKCs 7n7FtgukR4dAkRHo9/904i1A2Kemp0
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6A0AB1FD79
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

When meta_bg feature is enabled, the total number of group descriptors
is not really limiting the filesystem size. So there's no reason to
check it in that case. This allows resize2fs to resize filesystems past
256TB boundary similarly as the kernel can do it.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 resize/main.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/resize/main.c b/resize/main.c
index f914c0507e97..08a4bbaf7c65 100644
--- a/resize/main.c
+++ b/resize/main.c
@@ -270,8 +270,6 @@ int main (int argc, char ** argv)
 	long		sysval;
 	int		len, mount_flags;
 	char		*mtpt, *undo_file = NULL;
-	dgrp_t		new_group_desc_count;
-	unsigned long	new_desc_blocks;
 
 #ifdef ENABLE_NLS
 	setlocale(LC_MESSAGES, "");
@@ -551,17 +549,22 @@ int main (int argc, char ** argv)
 		new_size &= ~((blk64_t)(1ULL << fs->cluster_ratio_bits) - 1);
 	}
 
-	new_group_desc_count = ext2fs_div64_ceil(new_size -
-				fs->super->s_first_data_block,
-						 EXT2_BLOCKS_PER_GROUP(fs->super));
-	new_desc_blocks = ext2fs_div_ceil(new_group_desc_count,
-					  EXT2_DESC_PER_BLOCK(fs->super));
-	if ((new_desc_blocks + fs->super->s_first_data_block) >
-	    EXT2_BLOCKS_PER_GROUP(fs->super)) {
-		com_err(program_name, 0,
-			_("New size results in too many block group "
-			  "descriptors.\n"));
-		goto errout;
+	if (!ext2fs_has_feature_meta_bg(fs->super)) {
+		dgrp_t		new_group_desc_count;
+		unsigned long	new_desc_blocks;
+
+		new_group_desc_count = ext2fs_div64_ceil(new_size -
+					fs->super->s_first_data_block,
+					EXT2_BLOCKS_PER_GROUP(fs->super));
+		new_desc_blocks = ext2fs_div_ceil(new_group_desc_count,
+					EXT2_DESC_PER_BLOCK(fs->super));
+		if ((new_desc_blocks + fs->super->s_first_data_block) >
+		    EXT2_BLOCKS_PER_GROUP(fs->super)) {
+			com_err(program_name, 0,
+				_("New size results in too many block group "
+				  "descriptors.\n"));
+			goto errout;
+		}
 	}
 
 	if (!force && new_size < min_size) {
-- 
2.35.3


