Return-Path: <linux-ext4+bounces-14203-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGhjK9l9oWkUtgQAu9opvQ
	(envelope-from <linux-ext4+bounces-14203-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Feb 2026 12:19:53 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0810D1B674E
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Feb 2026 12:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D18931218ED
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Feb 2026 11:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86ECB3EDAC5;
	Fri, 27 Feb 2026 11:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mNhhI/gI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/FdCIhFT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UPbM6het";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ACs6HHI6"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64A42949E0
	for <linux-ext4@vger.kernel.org>; Fri, 27 Feb 2026 11:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772191108; cv=none; b=ksQ7s41bTMp6gf0JU/00/HbH9+PCxDCipi8PFbtZS2CblIEGgnI64sHMZqe6UOTBFr+gBzH/5hhOuCJdO3bkOSiVanPco2IERPEA43DyhdFWqB1KGD/Yl5ytG10UHszy+AiEOtnXYtY8ifErL1/xA7HRI4zHwyWzRKQmaoZ2wCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772191108; c=relaxed/simple;
	bh=Unz2UlkXIBX3KJpSiMoQ/jgMwYv8NAGPIBANk6ABEAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0sBQ0D2RMetMhACAMBCzIDxvKeXIAxud+8Ahm8LCswkFRqw17QI53e0HQZtUpRXkpU8zU8kxpoSBrfOnetFxN7SBoNhjwj6jA03MD8ljMJvolMva/f2gBajqgH4So2M+tZYq7nl/kIOfZ5oYiK1Eb4QeNyZoq3svWsMA15e9qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mNhhI/gI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/FdCIhFT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UPbM6het; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ACs6HHI6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0BAF65BEEC;
	Fri, 27 Feb 2026 11:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772191105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ygO+uDLt2xHAoprp/0yBqZXrMWlyEF62K6eqdhI/05I=;
	b=mNhhI/gI+VubAXCiofiVJcolZCFARvTAbqLdE8U1OIT3CnEcCQicsgjU9Px3mqSGIeFctp
	ufFoJjdbVaUysylytzC+X/xrDAevV4pTB4XmLpr1d0kwh9S7gBg8DuRnlBvo8gbqm51J2Z
	ulwQmwe1zaZtROuNYJs/DFpWYFT8ApU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772191105;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ygO+uDLt2xHAoprp/0yBqZXrMWlyEF62K6eqdhI/05I=;
	b=/FdCIhFTbBaAy+nA7hIqJ2t3MFYYNrtGltIA11ZU9a4XhJ2ym5Vp75uZdqXrOtz0hTKQEY
	6qNK6wsShdX+1pDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UPbM6het;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ACs6HHI6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772191104; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ygO+uDLt2xHAoprp/0yBqZXrMWlyEF62K6eqdhI/05I=;
	b=UPbM6hetYCc7O40HyH6t02XFbYXit2AUItQEn6EPWDKIwRPsPJp/yNuxhxnib9fSGVnZ0n
	T9xZwImJYZCEZ8jVcf6ejPgZ/RTkCn3GaPxwyS+2zuX4wCkSI1QF6cJVpjcgDxlbeVPgng
	2Cpln2C44Ynt3cdslMIANtaELhEe91s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772191104;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ygO+uDLt2xHAoprp/0yBqZXrMWlyEF62K6eqdhI/05I=;
	b=ACs6HHI6rQtpPEyyN5hT37dT6cScxsXS9XVHjBiESv9wd3RMsd822I9bT15dS73Gt5qQj9
	BRvAYh+D64Mt+iAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 01B563EA69;
	Fri, 27 Feb 2026 11:18:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id m1ZpAIB9oWnRHQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 27 Feb 2026 11:18:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BA6E9A06D4; Fri, 27 Feb 2026 12:18:19 +0100 (CET)
Date: Fri, 27 Feb 2026 12:18:19 +0100
From: Jan Kara <jack@suse.cz>
To: Ziyi Guo <n7l8m4@u.northwestern.edu>
Cc: Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext2: avoid drop_nlink() during unlink of zero-nlink
 inode in ext2_unlink()
Message-ID: <d4mtq6nnabjwxyniamvdpdezxlhae2cshviqomhfjzt4tpkxk4@tlqaunx7i5yu>
References: <20260211022052.973114-1-n7l8m4@u.northwestern.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211022052.973114-1-n7l8m4@u.northwestern.edu>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14203-lists,linux-ext4=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DMARC_NA(0.00)[suse.cz];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0810D1B674E
X-Rspamd-Action: no action

On Wed 11-02-26 02:20:52, Ziyi Guo wrote:
> ext2_unlink() calls inode_dec_link_count() unconditionally, which
> invokes drop_nlink(). If the inode was loaded from a corrupted disk
> image with i_links_count == 0, drop_nlink()
> triggers WARN_ON(inode->i_nlink == 0)
> 
> Follow the ext4 pattern from __ext4_unlink(): check i_nlink before
> decrementing. If already zero, skip the decrement.
> 
> Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>

Thanks! I've merged the patch to my tree now.

								Honza

> ---
>  fs/ext2/namei.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext2/namei.c b/fs/ext2/namei.c
> index bde617a66cec..c746cf169a4d 100644
> --- a/fs/ext2/namei.c
> +++ b/fs/ext2/namei.c
> @@ -293,7 +293,10 @@ static int ext2_unlink(struct inode *dir, struct dentry *dentry)
>  		goto out;
>  
>  	inode_set_ctime_to_ts(inode, inode_get_ctime(dir));
> -	inode_dec_link_count(inode);
> +
> +	if (inode->i_nlink)
> +		inode_dec_link_count(inode);
> +
>  	err = 0;
>  out:
>  	return err;
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

