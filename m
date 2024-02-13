Return-Path: <linux-ext4+bounces-1220-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7F0852DA4
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Feb 2024 11:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C51401C22265
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Feb 2024 10:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9CD225CD;
	Tue, 13 Feb 2024 10:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NJB3hG4i";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4UOj0wo4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XB0yQcFK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5WZpI053"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F05224FA
	for <linux-ext4@vger.kernel.org>; Tue, 13 Feb 2024 10:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707819322; cv=none; b=TysIqVF4lP3/8NmBf7iZky4Yds+NrK6GiaGtmUQAw+JbkUFZoVRGdgnm9IPyczjF3v6qB6WtYbZYzO0/ajlk+PW4w8NpG0W1tS1EHaFR/VUyIwHW81LlIGRDAaMiMeFC8uOrB1BvoNzh993RZ5nM8uUa/9VHqgjhqB99jnliYXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707819322; c=relaxed/simple;
	bh=UebRX72VTCQZYE31w2YjT/JjqN4ApY1sM71el/Rmlow=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dB3bA2znTN9TmkB2dB2REODEcmmTdNsY2B+TL5ClLbku/Qv6XCdPopDGD9uNJIFGwE0oiQKBkwLCOLa0H3hLAfQrm6wsG9uZrSlfz95DYpC+tYrzcabMe29HyxllfY4V1FlNPXn/rVTe+c21gm6KIFWrpTcISqtqw4by/fn0mUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NJB3hG4i; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4UOj0wo4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XB0yQcFK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5WZpI053; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D462F1FC84;
	Tue, 13 Feb 2024 10:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707819318; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=sNfO+juA21ttEjHctdWqInAa3VrOKGLpf9p8PRNAn9U=;
	b=NJB3hG4iTNpygMmALCiaOyif+uWrhu1EuDcvSr5a5uhXLu3AIlEvFFysEVVkRXrviSnU9A
	+0Z+Su3xTQFWmk8xXkyeRgtT77ri1FMHGCCs/ZW1bx1VZCG/zPmgKo+l67fFDQ6ZYi60qJ
	vh5luR81t8B7dsPJxheceeoZ5iYtvZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707819318;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=sNfO+juA21ttEjHctdWqInAa3VrOKGLpf9p8PRNAn9U=;
	b=4UOj0wo4kqRf7qftp9KAAF7Iht9WTSMJuQmQLmEANWvXxn6om73Y0W1yYVu8ZuauTz8wiv
	+DAMm6vJXS8pH/Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707819317; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=sNfO+juA21ttEjHctdWqInAa3VrOKGLpf9p8PRNAn9U=;
	b=XB0yQcFKmTc6mF4pTrYugZYJ5/pI5nN03yicoCHsBtZnChy3WrgNMYUx2JGN72/F/jaiqo
	Rv7NHHIrL7KrtoGqcawS4+AeZFAfR/eCvcW5ynxuzO3Ug9oKK/zA7xDEYVv1E+cNtMKEmA
	HTaAJXVvr8KZ4Lp7V/I38YHUp2C4SGA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707819317;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=sNfO+juA21ttEjHctdWqInAa3VrOKGLpf9p8PRNAn9U=;
	b=5WZpI053otZNKTnaFBZjY/2r+Etj+Pb/OWgFf2LwnvoeRST0RBRIDDx4UjuGIPh0d89Lsr
	SvuG/0IDPOnRxVDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C7CE91329E;
	Tue, 13 Feb 2024 10:15:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id y6nGMDVBy2XlLgAAn2gu4w
	(envelope-from <jack@suse.cz>); Tue, 13 Feb 2024 10:15:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1785AA0809; Tue, 13 Feb 2024 11:15:17 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: Ted Tso <tytso@mit.edu>
Cc: <linux-ext4@vger.kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH] ext4: Verify s_clusters_per_group even without bigalloc
Date: Tue, 13 Feb 2024 11:15:15 +0100
Message-Id: <20240213101515.17328-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1506; i=jack@suse.cz; h=from:subject; bh=UebRX72VTCQZYE31w2YjT/JjqN4ApY1sM71el/Rmlow=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBly0EtatGKgFgxL+6t+VC38ZQr6pacVLmOwLe0alE/ uqbA7qKJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZctBLQAKCRCcnaoHP2RA2Z1GB/ 9zGvQdDVoutkolHx3tejrrXIXc7SLCnAizrvKB/T7QF/fGYEOtHExQ2VTqfMzq7+IxOjC3V1Ms0tI8 a5HTaKSKtd+t/rghcWIPjXVT05zW2Z3M9X6v4mZ6A/yKe9YIn8Viuj8c+MRYyT844bkZb1cVdT0Pug pf5JKcrs/wCckIDt4qy1ncreZzcCQu8an2dg7FRchMz8lh+SeLj8N1WQVEhYNCovNSQCKjrcPvQPTn /X8biXeu7rXsUnRJHEAxzFUGthGh7iyxPqNmKU9HP2+TvQ+LbT36oVWYn9ix3LTI0Ivg67sug86wNs iuW0G+8RONPdENScru823LoGL+GKe5
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: ***
X-Spam-Score: 3.70
X-Spamd-Result: default: False [3.70 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[27.24%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

Currently we ignore s_clusters_per_group field in the on-disk superblock
if bigalloc feature is not enabled. However e2fsprogs don't even open
the filesystem is s_clusters_per_group is invalid. This results in an
odd state where kernel happily works with the filesystem while even
e2fsck refuses to touch it. Verify that s_clusters_per_group is valid
even if bigalloc feature is not enabled to make things consistent. Due
to current e2fsprogs behavior it is unlikely there are filesystems out
in the wild (except for intentionally fuzzed ones) with invalid
s_clusters_per_group counts.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/super.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 0f931d0c227d..522683075067 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4451,7 +4451,15 @@ static int ext4_handle_clustersize(struct super_block *sb)
 				 sbi->s_blocks_per_group);
 			return -EINVAL;
 		}
-		sbi->s_clusters_per_group = sbi->s_blocks_per_group;
+		sbi->s_clusters_per_group =
+			le32_to_cpu(es->s_clusters_per_group);
+		if (sbi->s_blocks_per_group != sbi->s_clusters_per_group) {
+			ext4_msg(sb, KERN_ERR, "blocks per group (%lu) and "
+				 "clusters per group (%lu) inconsistent",
+				 sbi->s_blocks_per_group,
+				 sbi->s_clusters_per_group);
+			return -EINVAL;
+		}
 		sbi->s_cluster_bits = 0;
 	}
 	sbi->s_cluster_ratio = clustersize / sb->s_blocksize;
-- 
2.35.3


