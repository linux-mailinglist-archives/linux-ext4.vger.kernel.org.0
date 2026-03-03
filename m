Return-Path: <linux-ext4+bounces-14487-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEAiDxm6pmk7TAAAu9opvQ
	(envelope-from <linux-ext4+bounces-14487-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Tue, 03 Mar 2026 11:38:17 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9A71ECC55
	for <lists+linux-ext4@lfdr.de>; Tue, 03 Mar 2026 11:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A11BF313C8D2
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Mar 2026 10:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B9A39D6D3;
	Tue,  3 Mar 2026 10:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mN1vbJ02";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Wp2z8Zle"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DCC25DB12
	for <linux-ext4@vger.kernel.org>; Tue,  3 Mar 2026 10:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772534094; cv=none; b=ZoPJAAMwHNFrf/gDCqF2PBy/ezQoyFdpuZSGiZyjNakG2arqsbYUSRE0/xU7NMIMCYh7cew/ZgYzqllcyXHGE6jNeD0qhFyUziYrvxnx+Je+LsVJ03MWpYgk6ZWrUZ21Ig8SCeJl+jU9zGfLUD8jAmFg6xRITm/IomTbADUoTaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772534094; c=relaxed/simple;
	bh=MUD4hvw0kKK4/k9ZuBglb9Pnr5A53izwByukHuzgvfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TwzIX/OK2Fvnqybv2/DzRYVhzMLql7Nyrcp34333JKyXLpyCnF2sP8mjUEaIdolqp4H2jCUOJOTqqWeyWunRktGufoI991yheaygmMfydBV89Cu2vM9ZCqv+QeGWqEcS+VRei9+RUPirmPe09IwFi7YB26AgbqgyZQQgbWAHfe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mN1vbJ02; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Wp2z8Zle; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C23C25BDEF;
	Tue,  3 Mar 2026 10:34:40 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772534080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pz/dKtOmFCfJ/SjA/GWn8rRYuhiNasxWQhID+bg8soY=;
	b=mN1vbJ02BkdHrkSCq7HuC2Q6UX2G3qJp8tUORVZMK7fBn5reytJyxVT+IMRNsTGMMhF8u/
	6qrlolmnA1LZpdfH2rgDIqUn5nDR8uQ6xdn5zhJN/OBtINTE0IFxWZ8TK/ag1m2FhPQEKu
	0Du+EnC3LI//Z9Frtk7a5j3NSCs8+sQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772534080;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pz/dKtOmFCfJ/SjA/GWn8rRYuhiNasxWQhID+bg8soY=;
	b=Wp2z8ZleWxA+DpAu5xfLKaK97+vNVTOV/SE9HnXdnG+Q3nif8V3IOx2rTZB6vMQytYp55i
	PhTgz3whSJee/8CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A94243EA6E;
	Tue,  3 Mar 2026 10:34:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 72tHKUC5pmnKFAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Mar 2026 10:34:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 585E4A0AAA; Tue,  3 Mar 2026 11:34:40 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@ZenIV.linux.org.uk>,
	<linux-ext4@vger.kernel.org>,
	Ted Tso <tytso@mit.edu>,
	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
	David Sterba <dsterba@suse.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	linux-mm@kvack.org,
	linux-aio@kvack.org,
	Benjamin LaHaise <bcrl@kvack.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 02/32] udf: Sync and invalidate metadata buffers from udf_evict_inode()
Date: Tue,  3 Mar 2026 11:33:51 +0100
Message-ID: <20260303103406.4355-34-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260303101717.27224-1-jack@suse.cz>
References: <20260303101717.27224-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=790; i=jack@suse.cz; h=from:subject; bh=MUD4hvw0kKK4/k9ZuBglb9Pnr5A53izwByukHuzgvfg=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpprkfiH1edR4ShwUvYoFKD7qhhaBFBhSp0KWEX 3MdhTPWkEKJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaaa5HwAKCRCcnaoHP2RA 2Y0DB/97HVCj2WXFdvCdWn1Mjn4V57ViLXdtg/UGbQxVNGIuhtxQQzjyL1R2n5SrG8WkGsbj1YK A/mndm9zIuMINZfD7Mg6eJlYoyvw+ggybLDSBgXkAIr/8iXeI8b66ztUtwFRK0eI/7aDrQ4w8Q+ OdgbRJpDE8/5HrwVjzIUWyuxJx2Yh+5MoEqUwf0tns0Y900/0YwU50KBwez2qGmrD1Q47BMn47D xk19ZaY11yAUMdI+OgBiqzd4relY9//72dN7BDz0o4neGDNsgPibXYBDf8KtVr3PiaBjuCUrEGO H8Y62jlLBbB6iEbUDBztcNYfl42hNcyprs0fj3hIkB4QbPYp
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: CD9A71ECC55
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-14487-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,ZenIV.linux.org.uk,vger.kernel.org,mit.edu,gmail.com,suse.com,mail.parknet.co.jp,linux.dev,suse.de,kvack.org,suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.cz:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[linux-ext4];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

There are only very few filesystems using generic metadata buffer head
tracking and everybody is paying the overhead. When we remove this
tracking for inode reclaim code .evict will start to see inodes with
metadata buffers attached so write them out and prune them.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 7fae8002344a..739b190ca4e9 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -154,6 +154,8 @@ void udf_evict_inode(struct inode *inode)
 		}
 	}
 	truncate_inode_pages_final(&inode->i_data);
+	if (!want_delete)
+		sync_mapping_buffers(&inode->i_data);
 	invalidate_inode_buffers(inode);
 	clear_inode(inode);
 	kfree(iinfo->i_data);
-- 
2.51.0


