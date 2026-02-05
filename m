Return-Path: <linux-ext4+bounces-13540-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qA+uCGZhhGng2gMAu9opvQ
	(envelope-from <linux-ext4+bounces-13540-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 05 Feb 2026 10:22:46 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE3BF095E
	for <lists+linux-ext4@lfdr.de>; Thu, 05 Feb 2026 10:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1126C30039B8
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Feb 2026 09:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100AE298CAB;
	Thu,  5 Feb 2026 09:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lqyuHKnY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Kx8+dNq/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lqyuHKnY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Kx8+dNq/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796B122301
	for <linux-ext4@vger.kernel.org>; Thu,  5 Feb 2026 09:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770283360; cv=none; b=tYV7ombxzlExyuAgbNk6efFiChQLkvBy4HNdHQuBFMniAq5NHCxJufvsQQ3VrQTtiKS/pmQTATAoPD4FHN83BXo6sEOEaaXXlSNWeVTdhx9BWpXHgfPz4sdPTZ/RmJCrBnvqmaa1br1MaGEI5SxFn4eBHEnJLF3CQzEWPSg7//M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770283360; c=relaxed/simple;
	bh=UpTP2E/A6bvegBNBPjj4DPdIN1/VGMppv8vNzKDRMWE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LbF+r7gQZrOcta2uQQ35hX7+jB4ubQ690fIREivI3MbmXLlqRueJtZemCMCOM2wEFphZGtEE7BDy0lhQjydKZvrUNQSsL1pHI585ao+ypwjTijbGIRUt+wxBWobnvNygd7RX3SMowqGeTYzUvYOf1qkKX6Dp5OF21/Z2jCeNQ8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lqyuHKnY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Kx8+dNq/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lqyuHKnY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Kx8+dNq/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 816CD3E754;
	Thu,  5 Feb 2026 09:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770283358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=xhfzFDUOEGmTkuZirYWsgJpfg7Bu5MthxL0dtJovxT4=;
	b=lqyuHKnY1TtgCt1lmL56iRXOy45rW6lDSwuNx/bAZz6f0VUeGJXezgFu86ZanZ3xG7kgal
	3Xua2flFi8a7sHYfr3XdO8qH3pPxL5aSUtZlUjwPvRm+F8GgqG1vuELa0KcU6PzMeNlqbM
	e3Ha4D8anV5DVPzj1YRSx7MLPoP6TUQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770283358;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=xhfzFDUOEGmTkuZirYWsgJpfg7Bu5MthxL0dtJovxT4=;
	b=Kx8+dNq/5FewEOV2Z3xv6B3dmyuVemvzEVmMPJvSj180PkZnHdvPdDcjj4QiTng+jqI5yP
	OwjujDpGCotF8xCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=lqyuHKnY;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="Kx8+dNq/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770283358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=xhfzFDUOEGmTkuZirYWsgJpfg7Bu5MthxL0dtJovxT4=;
	b=lqyuHKnY1TtgCt1lmL56iRXOy45rW6lDSwuNx/bAZz6f0VUeGJXezgFu86ZanZ3xG7kgal
	3Xua2flFi8a7sHYfr3XdO8qH3pPxL5aSUtZlUjwPvRm+F8GgqG1vuELa0KcU6PzMeNlqbM
	e3Ha4D8anV5DVPzj1YRSx7MLPoP6TUQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770283358;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=xhfzFDUOEGmTkuZirYWsgJpfg7Bu5MthxL0dtJovxT4=;
	b=Kx8+dNq/5FewEOV2Z3xv6B3dmyuVemvzEVmMPJvSj180PkZnHdvPdDcjj4QiTng+jqI5yP
	OwjujDpGCotF8xCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6E0D53EA63;
	Thu,  5 Feb 2026 09:22:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aBraGl5hhGlNHwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 05 Feb 2026 09:22:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 28397A09D8; Thu,  5 Feb 2026 10:22:38 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: Ted Tso <tytso@mit.edu>
Cc: <linux-ext4@vger.kernel.org>,
	Gerald Yang <gerald.yang@canonical.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH] ext4: Fix stale xarray tags after writeback
Date: Thu,  5 Feb 2026 10:22:24 +0100
Message-ID: <20260205092223.21287-2-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2222; i=jack@suse.cz; h=from:subject; bh=UpTP2E/A6bvegBNBPjj4DPdIN1/VGMppv8vNzKDRMWE=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBphGFPVkhIRAdGXgNPAWwcuasjeiZiMTit50wdJ rhbz9XBx4GJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaYRhTwAKCRCcnaoHP2RA 2b7gB/9ONnVpErI8ZVDo0epfGOHbyruG6QVIWEgFajcUjPfyd3zfDG5UBNFjs5z/ILMZhuoeMai BaRrbpKSNCjy6Ha9Xh/atkWzKrDhDhBj2JH2p2uDDzKIUJx/y/niIUIn341+vVE7KexciGgfjJ3 wMou3utJ3pNWnIuR0nS4prnkfC7qG4+LFiAqWt+Orin5jMxZhzWnUBSa586MjXXcF3wM70T/Dih Ir24KwYh0x0nibOB5vmNayvftkwNyrwkKbvGaxZj3+F32BJb0ZNl7SD7lFwAxM3YQmK4yydIAoP ViYymPtCezDSYDGM9DGQZrKWAA2ldzCqzVZSBWlycw5JJV/0
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13540-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-ext4@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.cz:email,suse.cz:dkim,suse.cz:mid,canonical.com:email];
	DKIM_TRACE(0.00)[suse.cz:+];
	TAGGED_RCPT(0.00)[linux-ext4];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9CE3BF095E
X-Rspamd-Action: no action

There are cases where ext4_bio_write_page() gets called for a page which
has no buffers to submit. This happens e.g. when the part of the file is
actually a hole, when we cannot allocate blocks due to being called from
jbd2, or in data=journal mode when checkpointing writes the buffers
earlier. In these cases we just return from ext4_bio_write_page()
however if the page didn't need redirtying, we will leave stale DIRTY
and/or TOWRITE tags in xarray because those get cleared only in
__folio_start_writeback(). As a result we can leave these tags set in
mappings even after a final sync on filesystem that's getting remounted
read-only or that's being frozen. Various assertions can then get upset
when writeback is started on such filesystems (Gerald reported assertion
in ext4_journal_check_start() firing).

Fix the problem by cycling the page through writeback state even if we
decide nothing needs to be written for it so that xarray tags get
properly updated. This is slightly silly (we could update the xarray
tags directly) but I don't think a special helper messing with xarray
tags is really worth it in this relatively rare corner case.

Reported-by: Gerald Yang <gerald.yang@canonical.com>
Link: https://lore.kernel.org/all/20260128074515.2028982-1-gerald.yang@canonical.com
Fixes: dff4ac75eeee ("ext4: move keep_towrite handling to ext4_bio_write_page()")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/page-io.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 39abfeec5f36..0a3ef9bd6803 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -523,9 +523,15 @@ int ext4_bio_write_folio(struct ext4_io_submit *io, struct folio *folio,
 		nr_to_submit++;
 	} while ((bh = bh->b_this_page) != head);
 
-	/* Nothing to submit? Just unlock the folio... */
-	if (!nr_to_submit)
+	if (!nr_to_submit) {
+		/*
+		 * We have nothing to submit. Just cycle the folio through
+		 * writeback state to properly update xarray tags.
+		 */
+		__folio_start_writeback(folio, keep_towrite);
+		folio_end_writeback(folio);
 		return 0;
+	}
 
 	bh = head = folio_buffers(folio);
 
-- 
2.51.0


