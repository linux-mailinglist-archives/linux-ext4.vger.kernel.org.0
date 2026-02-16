Return-Path: <linux-ext4+bounces-13704-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kI3tCI9Kk2mi3AEAu9opvQ
	(envelope-from <linux-ext4+bounces-13704-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Feb 2026 17:49:19 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E57146651
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Feb 2026 17:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F20673004D8D
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Feb 2026 16:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D87E2C11DB;
	Mon, 16 Feb 2026 16:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Lgj3BKMp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3JgzI6jQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Lgj3BKMp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3JgzI6jQ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C1726158C
	for <linux-ext4@vger.kernel.org>; Mon, 16 Feb 2026 16:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771260549; cv=none; b=DFm+YVdDntgUmys5ubUz3xtCDXMneTCv3mjCOj8MUGgsLuXuyfj5xoPeSK3BWna7ZAA99WN7ycP0KWP6E6cp79tog7Pk3e6PSsIOFTaiUqu6xYdAioAzPHgk0FJi+9JdbEoGdKLOUDzShKqHNZJvLzkn2UUuyzG5xyE/6CT5grE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771260549; c=relaxed/simple;
	bh=EyVfk7kc7IUyAx9FDCTTFQc9c2d0o7d0LH41JVigUpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c5MPEwnJFp0stE9piWPE6+W6cKx9fE0+715tl3Vp/N77zq7MD9WrrB9ufJxG/fNiLnrKq9zGlF2FIDa3zTsqEkX9ACkz074F6DgG4t/enz6XI2OdZZiTC6hHBBb8MpKBFVE9c1y6MaKNW7TIrU56k0PZ6wm0pibKnez4l0c/XLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Lgj3BKMp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3JgzI6jQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Lgj3BKMp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3JgzI6jQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C96365BCEA;
	Mon, 16 Feb 2026 16:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771260546; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=01nxir/3+7GsKUDaBYxk8lSADm6R4S3Kuu6Y6vZ83OI=;
	b=Lgj3BKMp4PEzMdP0brvodzUGXmTUHfkj0Oz7FJCPBQDbPGcZwhOBLyZbY2psk45/DfnYCc
	Qh3jU9B/Y/ebrs7nyho2XHtFrLGTNib/4ChQ/T+eHX2Wk1UEvoUZVePfXg9C9uFAcGYu+X
	JnsSCwd3IsCiiD6eQUR8PM6OUjPA8NM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771260546;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=01nxir/3+7GsKUDaBYxk8lSADm6R4S3Kuu6Y6vZ83OI=;
	b=3JgzI6jQuZmHXGhY3yj9tr2C+x6Zrnz5lL6ghasVYTddeVcwJvH38E5y9oVpFYuIIeRzug
	U6mIVQY36xhDdfDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771260546; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=01nxir/3+7GsKUDaBYxk8lSADm6R4S3Kuu6Y6vZ83OI=;
	b=Lgj3BKMp4PEzMdP0brvodzUGXmTUHfkj0Oz7FJCPBQDbPGcZwhOBLyZbY2psk45/DfnYCc
	Qh3jU9B/Y/ebrs7nyho2XHtFrLGTNib/4ChQ/T+eHX2Wk1UEvoUZVePfXg9C9uFAcGYu+X
	JnsSCwd3IsCiiD6eQUR8PM6OUjPA8NM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771260546;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=01nxir/3+7GsKUDaBYxk8lSADm6R4S3Kuu6Y6vZ83OI=;
	b=3JgzI6jQuZmHXGhY3yj9tr2C+x6Zrnz5lL6ghasVYTddeVcwJvH38E5y9oVpFYuIIeRzug
	U6mIVQY36xhDdfDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 00C753EA64;
	Mon, 16 Feb 2026 16:49:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SgwuAIFKk2n3OwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 16 Feb 2026 16:49:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 96919A0AD8; Mon, 16 Feb 2026 17:48:53 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: Ted Tso <tytso@mit.edu>
Cc: <linux-ext4@vger.kernel.org>,
	Free Ekanayaka <free.ekanayaka@gmail.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 1/2] ext4: Make recently_deleted() properly work with lazy itable initialization
Date: Mon, 16 Feb 2026 17:48:43 +0100
Message-ID: <20260216164848.3074-3-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260211140209.30337-1-jack@suse.cz>
References: <20260211140209.30337-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1272; i=jack@suse.cz; h=from:subject; bh=EyVfk7kc7IUyAx9FDCTTFQc9c2d0o7d0LH41JVigUpU=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpk0pw6xXOhuJ7CfTxy/PKkhLTv7u9S45hhzbAg BlS1DkAXl+JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaZNKcAAKCRCcnaoHP2RA 2Y1AB/9EZ5S0FWV/0o63hAITW0H3W4vMCugML/gI8Olyn5FqXcBU1g+BNd8qEJfdPT/H080mDuQ w/TKhrXjlxYW5jCNzmevbJKbbiRwERaiF/5DDffPWTiefcpAZ95hKkVWkcklono1ZwObStnoQSr kxQtwT7uweZ8NU6CWDlbajG7yhsmf3OiPSWStpgnkHuTz+PjBlmO6wFGYhTdFjo2UM39SZpSofe 32w3foBIaAA7GVjRu+PyzXGmS2B3YZFUKHOMLfooT3w1NRKb9EA+oSoktdqKnjxrtc4Jg/HGyb8 Zq7BTgkrXpLQHWZirBIlZED4ZXRg34Mkm3sTY2rZOn8ndpxK
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -5.30
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13704-lists,linux-ext4=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,suse.cz];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.cz:mid,suse.cz:dkim,suse.cz:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 44E57146651
X-Rspamd-Action: no action

recently_deleted() checks whether inode has been used in the near past.
However this can give false positive result when inode table is not
initialized yet and we are in fact comparing to random garbage (or stale
itable block of a filesystem before mkfs). Ultimately this results in
uninitialized inodes being skipped during inode allocation and possibly
they are never initialized and thus e2fsck complains.  Verify if the
inode has been initialized before checking for dtime.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ialloc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index b20a1bf866ab..d858ae10a329 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -686,6 +686,12 @@ static int recently_deleted(struct super_block *sb, ext4_group_t group, int ino)
 	if (unlikely(!gdp))
 		return 0;
 
+	/* Inode was never used in this filesystem? */
+	if (ext4_has_group_desc_csum(sb) && 
+	    (gdp->bg_flags & cpu_to_le16(EXT4_BG_INODE_UNINIT) ||
+	     ino >= EXT4_INODES_PER_GROUP(sb) - ext4_itable_unused_count(sb, gdp)))
+		return 0;
+
 	bh = sb_find_get_block(sb, ext4_inode_table(sb, gdp) +
 		       (ino / inodes_per_block));
 	if (!bh || !buffer_uptodate(bh))
-- 
2.51.0


