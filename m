Return-Path: <linux-ext4+bounces-6346-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25928A2A502
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Feb 2025 10:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27A231888EF2
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Feb 2025 09:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF0522687C;
	Thu,  6 Feb 2025 09:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cQrQjf0q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GOB6Hw/1"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453DC22686A;
	Thu,  6 Feb 2025 09:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738835235; cv=none; b=MZypLG0mjsrbaGO3SYwzwJWlYuNHOIEb3Asf0FadgyIjSDrKD+28H4bo21vKKoUFRBOKCzcx28xxXL6REKM1udoRjjU76z/3GNRf9EVknH8//jBIYUtIbLfH/5G1wJxnBNpPPdoLHw9MCFwYWThKPz9/Ot+Bgj53PyIyqBCFoks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738835235; c=relaxed/simple;
	bh=cXtoNZR9ZbyA0O48cwnUWJcEo0o2aqtKip0VMJ96FDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GbPIUvaGOi4BtdGEqAFdt8Nf5N9dyAG9/7AIVhLJ1Y1MQmpWVqW5MxRut21QfRYjaUF3YoTrcDI0uy3XbiWVMHrBz2ZZ226nBZlt0Joknz578SL0XfGZRLTOtWi6AGgXP0qTN6GCetdi/3LdU2EuiozOS7sWbmeOqN0bLJylJAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cQrQjf0q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GOB6Hw/1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7215C1F381;
	Thu,  6 Feb 2025 09:47:11 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738835231; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BEPeDjmrM5ZAcdjrNfb2XNrp0IRWiSIclb8LCma62mQ=;
	b=cQrQjf0q3vi3oAZ2R8UXFJiUXHXXMYRnoWNg7tGAuv8lSmla2UVV2sRbiF+L2/9uJGtYvD
	OJmeNJns9ocGQRnPvoscwCsHmKVSniI8ltB+u4PkgxQyPbOp7cMzUMs6d1aYuEJL9I8/7Q
	VkLoVsE+z8rhDweAySuWOMzWGYd89CY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738835231;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BEPeDjmrM5ZAcdjrNfb2XNrp0IRWiSIclb8LCma62mQ=;
	b=GOB6Hw/1XSDw3m3hOzNLPj7HiBRD18pHuh12ImAax1LY/aEt5BrHFg8IeymcI5DU32II4A
	wHX0+LrqjX1a89DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 63B1C13AB2;
	Thu,  6 Feb 2025 09:47:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jwxOGB+FpGctTAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 06 Feb 2025 09:47:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0966FA28E9; Thu,  6 Feb 2025 10:47:11 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: Ted Tso <tytso@mit.edu>
Cc: <linux-ext4@vger.kernel.org>,
	Jan Kara <jack@suse.cz>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] jbd2: Remove wrong sb->s_sequence check
Date: Thu,  6 Feb 2025 10:46:58 +0100
Message-ID: <20250206094657.20865-3-jack@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205183930.12787-1-jack@suse.cz>
References: <20250205183930.12787-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=804; i=jack@suse.cz; h=from:subject; bh=cXtoNZR9ZbyA0O48cwnUWJcEo0o2aqtKip0VMJ96FDw=; b=owGbwMvMwME4Z+4qdvsUh5uMp9WSGNKXtAru2aB9XmfBNg7zK5nPNt+bu+DiJ+F2tliufrXKrbI7 155r72Q0ZmFg5GCQFVNkWR15UfvaPKOuraEaMjCDWJlApjBwcQrAROpmsf+zTbgsXm985tfdb3O1+w 2Ezpp+nPz5Rl2Rq3+CxqX8/S9D/14Q7JrrtM3PqHjRjW6bzZ4fvr7a13kpX+6MG18jU7GfiIzTswZt Bk75p1ISs90f7/Vx4X12LINfo+nQF8/8a5k7JLrDVb0ClCtUGJrtg6RSUj7UBt72XV6T7KnSozdtrW hY2s+Za4wvN6W1uBmeUi/N2pRc3vJJkt1jDec+Y5YpRxeJ5riataZ0TvQMPFbjsq796FFF2+1yMR8m 3i13flRgfyvz1suHpc2HXoXZmKgsSr852UZLwvZrmuPk5Pg3UZWH3j2tOz27TajKYjG7A2tZRpKqe/ cF3b7zrg7ierHGU2yepr/PCrcAAA==
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 7215C1F381
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

Journal emptiness is not determined by sb->s_sequence == 0 but rather by
sb->s_start == 0 (which is set a few lines above). Furthermore 0 is a
valid transaction ID so the check can spuriously trigger. Remove the
invalid WARN_ON.

CC: stable@vger.kernel.org
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/journal.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 7e49d912b091..354c9f691df3 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1879,7 +1879,6 @@ int jbd2_journal_update_sb_log_tail(journal_t *journal, tid_t tail_tid,
 
 	/* Log is no longer empty */
 	write_lock(&journal->j_state_lock);
-	WARN_ON(!sb->s_sequence);
 	journal->j_flags &= ~JBD2_FLUSHED;
 	write_unlock(&journal->j_state_lock);
 
-- 
2.43.0


