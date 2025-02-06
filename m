Return-Path: <linux-ext4+bounces-6347-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 368BAA2A505
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Feb 2025 10:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3C6F1633EA
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Feb 2025 09:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82280226882;
	Thu,  6 Feb 2025 09:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tlJZ+8iW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Wv8KCXe9"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE15226548
	for <linux-ext4@vger.kernel.org>; Thu,  6 Feb 2025 09:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738835235; cv=none; b=aroPX8vHPBskNh9GllxTUvCrhPIhvKPBLmZ+8QSw9aTMM0YYyQHGPFMPYgr94L24iat24qWfurBsu8Ce9tA+qpZjCcGJCkiiozU027AyVASBB4pjondIWERorEqeA+qAfhKOx97Rd6KKq78QtK+/3Uo0RBI79+0jClQD41vFEI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738835235; c=relaxed/simple;
	bh=Y/b/p8NH1zHxzd4FRiUmFaMM7Uvu83jsZ9w7OC07+tM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nHnGYD+2Tk3AMqtQsk3Gj6MOEOT/j6GVSISmzz1n307R1PK/UaEuK4CdJwK+SrBxHSlg+TqhgGbQkJ5UDBlFLn7rP6X2FaJvJXfDoghOouE28y46+UWNUMvJEu+Y6Ho+Yuf8sFoB03CGFY7WuPSLx9IPI4hG5JVt1w4gZwRrvhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tlJZ+8iW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Wv8KCXe9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6EA2E21133;
	Thu,  6 Feb 2025 09:47:11 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738835231; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=47wPukX8ZEiy7vQI2S0lkHgc8pC/w02EErwo8lvJxPI=;
	b=tlJZ+8iWI3iyp/obWLXbdYYp7IfAGJmwBthdxo6Rf2wOIzEMWqHD6EGTJMGeL/dxxsNKcT
	XEXxoGH12m2JLRBIlNJp77lGDhZ8S1C0VXNtaG8OKfDysmwr8yhEBESdn/dsN+gqULH3Pa
	bhRxf4k9VcVR6rTlBjHYbFnDSpD/hXs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738835231;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=47wPukX8ZEiy7vQI2S0lkHgc8pC/w02EErwo8lvJxPI=;
	b=Wv8KCXe9WlaUNmmuiYmIrsi07DyAkqTzc1Oz965EsbCbxKLdHLUm5PL+Fa0oI1lxIqI9yz
	h0hRXFv+LqmGsUDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6197F13A7F;
	Thu,  6 Feb 2025 09:47:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6SMFFx+FpGcrTAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 06 Feb 2025 09:47:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0EBF4A28EB; Thu,  6 Feb 2025 10:47:11 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: Ted Tso <tytso@mit.edu>
Cc: <linux-ext4@vger.kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 2/2] jbd2: Do not try to recover wiped journal
Date: Thu,  6 Feb 2025 10:46:59 +0100
Message-ID: <20250206094657.20865-4-jack@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205183930.12787-1-jack@suse.cz>
References: <20250205183930.12787-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1581; i=jack@suse.cz; h=from:subject; bh=Y/b/p8NH1zHxzd4FRiUmFaMM7Uvu83jsZ9w7OC07+tM=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBnpIUSqcRu8aKkC4VYLYwT9rJSzp+T47XN/hHCzhNs 0dlth8+JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZ6SFEgAKCRCcnaoHP2RA2YFxB/ 92MGkz+IbBKRMweAb42PgLHTMZLAVktikoKNNiYgj4xM/upWd6kzxO4JQ6LllKI+Gf5o5S76ur+AAf 02XL8hU4lFJVqliEgq6DNzLh+S4znU3DBOHb6sWNOn5+GFuZUqdmZUlPgxQTRpP2Z7uNEiYfJiB1kr DmcViPzaLuOQ2XshpsC50icIlP8D1wzL1gqymHKPBWiEVZNl+YRbSFcanDgTbe2/OJNQKcbimNQ/ZH i12Y3RUIrjg6WadBY0XPfIrQqLgunk/rFDpoxtDsvPnodd845Ld7QFaG0rf68PwkRARCmqjZ07k6GF g3W66f6Rc72+OqUZVHXni5HjV/LIB7
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 6EA2E21133
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

If a journal is wiped, we will set journal->j_tail to 0. However if
'write' argument is not set (as it happens for read-only device or for
ocfs2), the on-disk superblock is not updated accordingly and thus
jbd2_journal_recover() cat try to recover the wiped journal. Fix the
check in jbd2_journal_recover() to use journal->j_tail for checking
empty journal instead.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/recovery.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index 9192be7c19d8..23502f1a67c1 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -287,19 +287,20 @@ static int fc_do_one_pass(journal_t *journal,
 int jbd2_journal_recover(journal_t *journal)
 {
 	int			err, err2;
-	journal_superblock_t *	sb;
-
 	struct recovery_info	info;
 
 	memset(&info, 0, sizeof(info));
-	sb = journal->j_superblock;
 
 	/*
 	 * The journal superblock's s_start field (the current log head)
 	 * is always zero if, and only if, the journal was cleanly
-	 * unmounted.
+	 * unmounted. We use its in-memory version j_tail here because
+	 * jbd2_journal_wipe() could have updated it without updating journal
+	 * superblock.
 	 */
-	if (!sb->s_start) {
+	if (!journal->j_tail) {
+		journal_superblock_t *sb = journal->j_superblock;
+
 		jbd2_debug(1, "No recovery required, last transaction %d, head block %u\n",
 			  be32_to_cpu(sb->s_sequence), be32_to_cpu(sb->s_head));
 		journal->j_transaction_sequence = be32_to_cpu(sb->s_sequence) + 1;
-- 
2.43.0


