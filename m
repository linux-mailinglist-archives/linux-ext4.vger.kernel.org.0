Return-Path: <linux-ext4+bounces-12702-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6529D08BD6
	for <lists+linux-ext4@lfdr.de>; Fri, 09 Jan 2026 11:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51A0C3043A77
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Jan 2026 10:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5CD33A003;
	Fri,  9 Jan 2026 10:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="J1yqGkmt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="baeRpb5c";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vvs9UEtt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mSzSdXBD"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E1626E71E
	for <linux-ext4@vger.kernel.org>; Fri,  9 Jan 2026 10:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767956041; cv=none; b=APQ/nexhrG/AQxAUpu+0L3jMCzt0Cp2y4xxCgJI/xYwPFzd1IDnGBJ/Q6ZvKQEYB8XeEQBWW83ui5jwMVVlN9ptBipSzuRJ/pJ2YZ+knZRh6PXHpXlu/JnpQa49TdKAaUVnzUfRNKzW+mCtSfYNU9R17zaZo0XE6ba/E+XAxr6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767956041; c=relaxed/simple;
	bh=/4JmcVJiWXlBczobs0inDBux8exFQvMRu261N1pCOhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m7Y0nv6la1SuH7YNtDITzA/kEALbIYPd1vOUFCIFOoIkXG5BX2s2RkVgFRiPOrtaW0iRDXP80XnFiqZbj7RoAk58m20P/7qK+pDl1aTp/A791/dIimryc7C6+rXPfn7c2iQRm1djKJq+EcSy4tANYrujY8Umyv/dD667ms0KFqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=J1yqGkmt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=baeRpb5c; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vvs9UEtt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mSzSdXBD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EB7A03398F;
	Fri,  9 Jan 2026 10:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767956038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TB6GuENXMpNC5xVYqxUJyxYgsZVgpGxwfqu/xZAxYEs=;
	b=J1yqGkmtuSZNmnz39PNtxJd0wYIxDo56q3CBoCSBs5+YQGGsHNRtVtuqQDAuUMZcvwfYFT
	otY6o9EYopTLb/ItuI69yUK0fpUCBvFrww2OYasJQj6a5FFl45YmQ62KUoNPGNwg/pLUBG
	OElZr2fZcN0XHmIP3Putx+W+aX+Jpj8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767956038;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TB6GuENXMpNC5xVYqxUJyxYgsZVgpGxwfqu/xZAxYEs=;
	b=baeRpb5cXPcX/Yow2rD6pTK4oBpQahxTKeE1J7cJLH+I0oNDf73k62dc924jCNKDIg35kp
	hFMLaBt9YMuU0YCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767956037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TB6GuENXMpNC5xVYqxUJyxYgsZVgpGxwfqu/xZAxYEs=;
	b=vvs9UEttciX8cInXRX3IdH/mdBfv11/w8mx25tzryD8HfhW1vOjzG65BP3deI/6h8oiqQ3
	ZBkublxb7Z6NyuXA5SutYsenXUesV2ssmAV2fAY6x22Fn2H8CP5IG2oIfAecqxsyAsJldz
	7qOM/YyH+fl+d8vHzaA0ZcwxE7bVQkE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767956037;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TB6GuENXMpNC5xVYqxUJyxYgsZVgpGxwfqu/xZAxYEs=;
	b=mSzSdXBDSXihXOV8HsVfIzzUtg2i4c0Ie+mtZovMESbjYM4fUIhURHo9mSWmLcwp6PQb/g
	wbZ3xxmCEiPAgUBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E28BE3EA65;
	Fri,  9 Jan 2026 10:53:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GPZNN0XeYGlKVwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 09 Jan 2026 10:53:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A16C9A0A61; Fri,  9 Jan 2026 11:53:57 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: Ted Tso <tytso@mit.edu>
Cc: <linux-ext4@vger.kernel.org>,
	Baokun Li <libaokun1@huawei.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 2/2] ext4: use optimized mballoc scanning regardless of inode format
Date: Fri,  9 Jan 2026 11:53:38 +0100
Message-ID: <20260109105354.16008-4-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260109105007.27673-1-jack@suse.cz>
References: <20260109105007.27673-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1258; i=jack@suse.cz; h=from:subject; bh=/4JmcVJiWXlBczobs0inDBux8exFQvMRu261N1pCOhw=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpYN5DWu3CwgWaRj2yGYOoAbuk1Si70cUWrPFLx q9sYpAFNwiJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaWDeQwAKCRCcnaoHP2RA 2WM5CACkKGvce91PUVi3hySvk7oAplS6oXpVxfuBBhDGkFTpnmikVw6LGHXmWyY29q2NL/2YIO2 W05xcMPWi13HT+0s9pIN0IfDh3OycmKyMIjvnAh/TCua3X0uLoQA6D8BycCNTukhs89+75CD7sD +pDbaNesSvYMkuT9hqDcvb91kFtNceWdS5ZDfxm2g5ArcMSAcDzSzfqA2nyXzmFvfMpvsvKjtk+ oMd5KgTzdiFH4Us+Awy30+c8dwhdv8plX/9CdCcMaY9k+HjXEh04hFc+bvkLHjiAYGP2r9ZaiAr iJtAXlsowPC083buY2YSH1eew5MH//ADsmCWnmcTIJISUU6y
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email]
X-Spam-Level: 
X-Spam-Flag: NO

Currently we don't used mballoc optimized scanning (using max free
extent order and avg free extent order group lists) for inodes with
indirect block based format. This is confusing for users and I don't see
a good reason for that. Even with indirect block based inode format we
can spend big amount of time searching for free blocks for large
filesystems with fragmented free space. To add to the confusion before
commit 077d0c2c78df ("ext4: make mb_optimize_scan performance mount
option work with extents") optimized scanning was applied *only* to
indirect block based inodes so that commit appears as a performance
regression to some users. Just use optimized scanning whenever it is
enabled by mount options.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/mballoc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index f0e07bf11a93..cd98c472631e 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1145,8 +1145,6 @@ static inline int should_optimize_scan(struct ext4_allocation_context *ac)
 		return 0;
 	if (ac->ac_criteria >= CR_GOAL_LEN_SLOW)
 		return 0;
-	if (!ext4_test_inode_flag(ac->ac_inode, EXT4_INODE_EXTENTS))
-		return 0;
 	return 1;
 }
 
-- 
2.51.0


