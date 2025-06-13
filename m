Return-Path: <linux-ext4+bounces-8412-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A10AD8824
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Jun 2025 11:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AAB418975D1
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Jun 2025 09:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA012C158A;
	Fri, 13 Jun 2025 09:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UIfsEZZi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="p1jbw5ZQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UIfsEZZi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="p1jbw5ZQ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876BA279DCD
	for <linux-ext4@vger.kernel.org>; Fri, 13 Jun 2025 09:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749807742; cv=none; b=iWhbcxpeSTSEn5CmAtlvO6ZfiZlbWFYuedRY5r8wSzMopvk1Oh4T35dMg5EzGHuYAUEchq67yivInJiJKnhojrYDaX+yvzKE7dAUvvZJlfXzySPjGOWpBDAio8Sk7ntYGMCqusOAEcAUD6HuyHF9B7jXFVbIhZ2JA9G6GyVH9hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749807742; c=relaxed/simple;
	bh=Fgb6wnysN63y1b2pgmr1er7TXwdkZlxsNrNLLAaFZ6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GtsOImRu12ASCrELPV4x3apokClpZS/6qfnEMPVJlpLKQcWcGZ30Dvttq2NOn87bPFWiGJpoQWuD0EX+78Rz/GNXQhCYiV9KfLov1vx4mzyhFXfAFPpTb7UwhXNbBvRz2ZdjzFwpciorxZT2eTTI/gDnjTeluxZA1HwTR6f2cX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UIfsEZZi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=p1jbw5ZQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UIfsEZZi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=p1jbw5ZQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A95B41F78E;
	Fri, 13 Jun 2025 09:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749807737; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lz3N8H62Scka+0A9NkxhFIl4TdftpD6QSLaVuMv/lvk=;
	b=UIfsEZZiF8yYJJuG1DFOoIUo+/kdtCLI91u/QbzaYg2jdPALNC0naI8tcsYHKuT2jiPW2N
	2Qvfe/Giw8KhwvbYeahbV/kEUIAHv4ZHJCfuheqCS3xORwTMRuBtI7m2t9FUKNxQLQpvz9
	PoxwZHgIz6CpN0qiCOJhEUVN2+TaQbc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749807737;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lz3N8H62Scka+0A9NkxhFIl4TdftpD6QSLaVuMv/lvk=;
	b=p1jbw5ZQmKflhB0NSIzqlUcvBvHz2gH7Dq8g0mk+LI8s270uPnaJaKqXpWs7cJxQoiSzQS
	i9lwEMGul7h/q7Dw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UIfsEZZi;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=p1jbw5ZQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749807737; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lz3N8H62Scka+0A9NkxhFIl4TdftpD6QSLaVuMv/lvk=;
	b=UIfsEZZiF8yYJJuG1DFOoIUo+/kdtCLI91u/QbzaYg2jdPALNC0naI8tcsYHKuT2jiPW2N
	2Qvfe/Giw8KhwvbYeahbV/kEUIAHv4ZHJCfuheqCS3xORwTMRuBtI7m2t9FUKNxQLQpvz9
	PoxwZHgIz6CpN0qiCOJhEUVN2+TaQbc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749807737;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lz3N8H62Scka+0A9NkxhFIl4TdftpD6QSLaVuMv/lvk=;
	b=p1jbw5ZQmKflhB0NSIzqlUcvBvHz2gH7Dq8g0mk+LI8s270uPnaJaKqXpWs7cJxQoiSzQS
	i9lwEMGul7h/q7Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9E3D2137FE;
	Fri, 13 Jun 2025 09:42:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7Wc+JnnyS2gpPwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 13 Jun 2025 09:42:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 436D1A09B0; Fri, 13 Jun 2025 11:42:17 +0200 (CEST)
Date: Fri, 13 Jun 2025 11:42:17 +0200
From: Jan Kara <jack@suse.cz>
To: Wei Gao <wegao@suse.com>
Cc: Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2] ext2: Handle fiemap on empty files to prevent EINVAL
Message-ID: <mxios5pbq3vq5267on4vnt5siozd4nap5w7wemsd2vlxoooexd@ia2ezhdu7ujq>
References: <20250612142855.2678267-1-wegao@suse.com>
 <20250613152402.3432135-1-wegao@suse.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613152402.3432135-1-wegao@suse.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A95B41F78E
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.01
X-Spam-Level: 

On Fri 13-06-25 11:18:38, Wei Gao wrote:
> Previously, ext2_fiemap would unconditionally apply "len = min_t(u64, len,
> i_size_read(inode));", When inode->i_size was 0 (for an empty file), this
> would reduce the requested len to 0. Passing len = 0 to iomap_fiemap could
> then result in an -EINVAL error, even for valid queries on empty files.
> 
> Link: https://github.com/linux-test-project/ltp/issues/1246
> Signed-off-by: Wei Gao <wegao@suse.com>

...

> diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
> index 30f8201c155f..591db2b4390a 100644
> --- a/fs/ext2/inode.c
> +++ b/fs/ext2/inode.c
> @@ -895,9 +895,15 @@ int ext2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  		u64 start, u64 len)
>  {
>  	int ret;
> +	u64 i_size;
>  
>  	inode_lock(inode);
> -	len = min_t(u64, len, i_size_read(inode));
> +
> +	i_size = i_size_read(inode);
> +
> +	if (i_size > 0)
> +		len = min_t(u64, len, i_size_read(inode));


Thanks! This would actually lead to excessively slow fiemap for 0-length
files. So what I've ended up with is attached modification of your patch.

> +
>  	ret = iomap_fiemap(inode, fieinfo, start, len, &ext2_iomap_ops);
>  	inode_unlock(inode);
>  
> -- 
> 2.49.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
---

From a099b09a3342a0b28ea330e405501b5b4d0424b4 Mon Sep 17 00:00:00 2001
From: Wei Gao <wegao@suse.com>
Date: Fri, 13 Jun 2025 11:18:38 -0400
Subject: [PATCH] ext2: Handle fiemap on empty files to prevent EINVAL

Previously, ext2_fiemap would unconditionally apply "len = min_t(u64, len,
i_size_read(inode));", When inode->i_size was 0 (for an empty file), this
would reduce the requested len to 0. Passing len = 0 to iomap_fiemap could
then result in an -EINVAL error, even for valid queries on empty files.

Link: https://github.com/linux-test-project/ltp/issues/1246
Signed-off-by: Wei Gao <wegao@suse.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20250613152402.3432135-1-wegao@suse.com
---
 fs/ext2/inode.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 30f8201c155f..177b1f852b63 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -895,9 +895,19 @@ int ext2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		u64 start, u64 len)
 {
 	int ret;
+	loff_t i_size;
 
 	inode_lock(inode);
-	len = min_t(u64, len, i_size_read(inode));
+	i_size = i_size_read(inode);
+	/*
+	 * iomap_fiemap() returns EINVAL for 0 length. Make sure we don't trim
+	 * length to 0 but still trim the range as much as possible since
+	 * ext2_get_blocks() iterates unmapped space block by block which is
+	 * slow.
+	 */
+	if (i_size == 0)
+		i_size = 1;
+	len = min_t(u64, len, i_size);
 	ret = iomap_fiemap(inode, fieinfo, start, len, &ext2_iomap_ops);
 	inode_unlock(inode);
 
-- 
2.43.0


