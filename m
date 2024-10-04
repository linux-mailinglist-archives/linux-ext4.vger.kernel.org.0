Return-Path: <linux-ext4+bounces-4512-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C61991233
	for <lists+linux-ext4@lfdr.de>; Sat,  5 Oct 2024 00:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1C0F1C22EF5
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Oct 2024 22:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60D5140E34;
	Fri,  4 Oct 2024 22:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SB+XWGmP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="E0ZVHvAp";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SB+XWGmP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="E0ZVHvAp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9004231CA2
	for <linux-ext4@vger.kernel.org>; Fri,  4 Oct 2024 22:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728080170; cv=none; b=qUDNhL1XjMXOgM64zdpfmYHUodhAZryvL7bN1REWj6YilWKPePZkfQAdEMjhsxG2TR/MlOS6evNYfwVIgCFt9bsc+BdwrkyjUWhPPg5YiQeDKn2kYL7MxYeA/StvW/cnAre0WjJEa3lWeN53ch9Yl4D7/7ktDJy/4/lCeITvv0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728080170; c=relaxed/simple;
	bh=F/24mQFW6Aly6DJ3aUiuuJZ26x9ibBMiHyQOq7QW3zU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lbQcdpoFpjA0CM4rdvbp7M7JLerqX+PBxbwG6Lu/eyEXalPph0sb8aBohlZOt8JSkpMb2V+9GfOC6OzKe6fSlb7sXvwpGLfQUf9j214Nwigji1IPLm1yRVynrMMqnfCorOn/XEK7X1G9Qp8NdOaknX2+AZ4xvwPpir3mzVTnioo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SB+XWGmP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=E0ZVHvAp; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SB+XWGmP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=E0ZVHvAp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C24441F7D3;
	Fri,  4 Oct 2024 22:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728080164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=i9MAirTg2Jf1qa0ZLqW7WdvvEc4480TlcGbhBxt6bng=;
	b=SB+XWGmPdKKGlus/uuPETsrZZi5lA8wFtkwKQKZlZCa5Imy+tjhRCeTnl9M/cYL0ElrFV0
	dILG9JH6hVyan21sOPt9wn3hxJwXmQpvN+6Gr516ZNSGM3bSTFzYUGZKsIpUvI2kmhIG1P
	wNN1IFIXrf0fUxYIVjFdVrqUavFB4PU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728080164;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=i9MAirTg2Jf1qa0ZLqW7WdvvEc4480TlcGbhBxt6bng=;
	b=E0ZVHvAp3vrMvz8wra1z6ddFJITF7yPcnRvM5xxBpiS/znTQtyOJKLwTFyDATUBKDxdQB2
	QiYAdB49RWer8TAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728080164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=i9MAirTg2Jf1qa0ZLqW7WdvvEc4480TlcGbhBxt6bng=;
	b=SB+XWGmPdKKGlus/uuPETsrZZi5lA8wFtkwKQKZlZCa5Imy+tjhRCeTnl9M/cYL0ElrFV0
	dILG9JH6hVyan21sOPt9wn3hxJwXmQpvN+6Gr516ZNSGM3bSTFzYUGZKsIpUvI2kmhIG1P
	wNN1IFIXrf0fUxYIVjFdVrqUavFB4PU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728080164;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=i9MAirTg2Jf1qa0ZLqW7WdvvEc4480TlcGbhBxt6bng=;
	b=E0ZVHvAp3vrMvz8wra1z6ddFJITF7yPcnRvM5xxBpiS/znTQtyOJKLwTFyDATUBKDxdQB2
	QiYAdB49RWer8TAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B490713883;
	Fri,  4 Oct 2024 22:16:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id br3CKyRpAGeWZgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 04 Oct 2024 22:16:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5354AA080A; Sat,  5 Oct 2024 00:16:00 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Ted Tso <tytso@mit.edu>
Cc: <linux-ext4@vger.kernel.org>,
	Jan Stancek <jstancek@redhat.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH] ext4: Avoid remount errors with 'abort' mount option
Date: Sat,  5 Oct 2024 00:15:56 +0200
Message-Id: <20241004221556.19222-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2005; i=jack@suse.cz; h=from:subject; bh=F/24mQFW6Aly6DJ3aUiuuJZ26x9ibBMiHyQOq7QW3zU=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBnAGkFtR6RDLM6k0cgFyJckOzM3H6+6cJQYqDP+jZQ NsAuGE+JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZwBpBQAKCRCcnaoHP2RA2W6sCA CJQXNTCsjJzbgxRZby5KERzqGnCmVtUixdXdk15q8CuqF+1ncp1sYaSX37220UNty77oDTohQkKTkn eLDYAFcNwboSn0BaU9Jc88Ej+IkpCP60k+QvVPCfUpd3Wcl/v29wp6AGdlwQb4mkLVoLkHewD16lbO EQOrz681QrX9abqE9P/92xwiu5TbkDkNEkyNWTKaYUfC6hvPtZ7IAZLYD6/Vh6ULjorINh05461pQ7 7gEkAI95fTZTQi/0BkNxeotiHuS7uZsuY4JYkohRPcWmusMTNbHyJ+/J0gVYUyjM09BvYeo7FhmTfG Npkic5hh3BrBaUeE6M++aAa69YVVBZ
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,gmail.com,suse.cz];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Level: 

When we remount filesystem with 'abort' mount option while changing
other mount options as well (as is LTP test doing), we can return error
from the system call after commit d3476f3dad4a ("ext4: don't set
SB_RDONLY after filesystem errors") because the application of mount
option changes detects shutdown filesystem and refuses to do anything.
The behavior of application of other mount options in presence of
'abort' mount option is currently rather arbitary as some mount option
changes are handled before 'abort' and some after it.

Move aborting of the filesystem to the end of remount handling so all
requested changes are properly applied before the filesystem is shutdown
to have a reasonably consistent behavior.

Fixes: d3476f3dad4a ("ext4: don't set SB_RDONLY after filesystem errors")
Reported-by: Jan Stancek <jstancek@redhat.com>
Link: https://lore.kernel.org/all/Zvp6L+oFnfASaoHl@t14s
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/super.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 16a4ce704460..4645f1629673 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6518,9 +6518,6 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
 		goto restore_opts;
 	}
 
-	if (test_opt2(sb, ABORT))
-		ext4_abort(sb, ESHUTDOWN, "Abort forced by user");
-
 	sb->s_flags = (sb->s_flags & ~SB_POSIXACL) |
 		(test_opt(sb, POSIX_ACL) ? SB_POSIXACL : 0);
 
@@ -6689,6 +6686,14 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
 	if (!ext4_has_feature_mmp(sb) || sb_rdonly(sb))
 		ext4_stop_mmpd(sbi);
 
+	/*
+	 * Handle aborting the filesystem as the last thing during remount to
+	 * avoid obsure errors during remount when some option changes fail to
+	 * apply due to shutdown filesystem.
+	 */
+	if (test_opt2(sb, ABORT))
+		ext4_abort(sb, ESHUTDOWN, "Abort forced by user");
+
 	return 0;
 
 restore_opts:
-- 
2.35.3


