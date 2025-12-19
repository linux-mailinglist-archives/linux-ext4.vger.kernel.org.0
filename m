Return-Path: <linux-ext4+bounces-12447-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD462CD0311
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Dec 2025 15:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A58BF30813E2
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Dec 2025 14:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8930326955;
	Fri, 19 Dec 2025 14:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lAhjUBpV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="x0mBA8v/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2/L3cRQW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hWmpeQlN"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF0023E342
	for <linux-ext4@vger.kernel.org>; Fri, 19 Dec 2025 14:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766152928; cv=none; b=XTtRDp4DfuilgP58MlCVu63w51799gwcBYlSZo//sq3Bd34+3btYqXg5qsQhbzuuhA8AXOuTrEeJTtMbYh4HByJkBHN0Gveaj+Ily1Y0DYqPu0+8KJLA18r23xxjtFInN4IDhrI+MRYjvzQsxj+jLhpycgcKvuKclZzk8ZdX3/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766152928; c=relaxed/simple;
	bh=A5GbuFRCm3mwsY14ZTsh2LlJwqd7lQqulCT5y172BzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPiqgGYYlNJDxlfAxkEnKdPnNRBsG1QSKaP5ni53GIDKD5OVcQmMPRn6eeLPj8K1kQVtEbVZHqJktRHxhFqLFggSbPaKa6GoHgKmwb3Ig/uMEf4hztjl3XvhKfJYzk+3PnuR/r23kVf0AD50FN3sr0yN5mX/Qgd397uNtxgAHo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lAhjUBpV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=x0mBA8v/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2/L3cRQW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hWmpeQlN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 45F2E33700;
	Fri, 19 Dec 2025 14:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766152924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6iI0EiIs8RjcnzLZOdSBovvVnxNVdr/LwsCJUOIga3w=;
	b=lAhjUBpVBtpy89U8a2S1yrypm/kg0A8zFhFHrbJnLB9TCltK944vhZLW+QcvCBBZqcMNth
	0Y8o0DCFopJmd0ZVfDIi3k9vcd+mRDad2yI/iAWL5j5walYBqgHsjJwdHs44UKMIplJsv+
	NcpIRV4/S+SFqEhjCRElPPtbY8jJrTY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766152924;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6iI0EiIs8RjcnzLZOdSBovvVnxNVdr/LwsCJUOIga3w=;
	b=x0mBA8v/Wz50iqk3jcrqMzWrxuBgtcn2vHqJxZC3yOmWYQLKl15B9i3vjIzIU2L4uPvk0+
	IMMo+SP1AJoGVzBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="2/L3cRQW";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=hWmpeQlN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766152923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6iI0EiIs8RjcnzLZOdSBovvVnxNVdr/LwsCJUOIga3w=;
	b=2/L3cRQWUcj6YzxW1YtUYlf40PJ4AzI+ogRdCAfpyCwAO92sM3O/OMhEP8GEn6LFptd9mG
	ZsfhEjg6RZoNSoibeLq9zYtchYmEkZQI2EKlZRSNMSzNbdfkGUILuLwoDfTJShbQn6oaLL
	tyGJBo9FF2P2/ukYkpM0xBWJQWZn1gE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766152923;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6iI0EiIs8RjcnzLZOdSBovvVnxNVdr/LwsCJUOIga3w=;
	b=hWmpeQlNjoKsc1/MPabcBVn43r8ucVTB37acBgGnV9+jHjbpks2Qp1kaVbG571DOdxKSNn
	xDrAlY9zEthEesBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3DACF3EA63;
	Fri, 19 Dec 2025 14:02:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pWkHD9taRWlTNQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 19 Dec 2025 14:02:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EDD27A090B; Fri, 19 Dec 2025 15:01:47 +0100 (CET)
Date: Fri, 19 Dec 2025 15:01:47 +0100
From: Jan Kara <jack@suse.cz>
To: Ziran Zhang <zhangcoder@yeah.net>
Cc: jack@suse.com, corbet@lwn.net, linux-ext4@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc : fix a broken link in ext2.rst
Message-ID: <lno54eb5wbiw7pztxu5ol3xgy5rauvutfuzq7tjvzv5usk3vrc@tebpi4q4y2se>
References: <20251217061737.6079-1-zhangcoder@yeah.net>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217061737.6079-1-zhangcoder@yeah.net>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[yeah.net];
	FREEMAIL_ENVRCPT(0.00)[yeah.net];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[yipton.net:url,unc.edu:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,tu-clausthal.de:url,suse.com:email,yeah.net:email,suse.cz:dkim];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: 45F2E33700
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Wed 17-12-25 14:17:37, Ziran Zhang wrote:
> The original link returns a 404, so I update it to the latest
> accessible url.
> 
> No functional change to any code, only documentation updates.
> 
> Signed-off-by: Ziran Zhang <zhangcoder@yeah.net>

Thanks! Added to my tree.

								Honza

> ---
>  Documentation/filesystems/ext2.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/filesystems/ext2.rst b/Documentation/filesystems/ext2.rst
> index 92aae683e16a..95f48c1fc6fb 100644
> --- a/Documentation/filesystems/ext2.rst
> +++ b/Documentation/filesystems/ext2.rst
> @@ -388,7 +388,7 @@ Implementations for:
>  
>  =======================	===========================================================
>  Windows 95/98/NT/2000	http://www.chrysocome.net/explore2fs
> -Windows 95 [1]_		http://www.yipton.net/content.html#FSDEXT2
> +Windows 95 [1]_		http://www.yipton.net/content/fsdext2/
>  DOS client [1]_		ftp://metalab.unc.edu/pub/Linux/system/filesystems/ext2/
>  OS/2 [2]_		ftp://metalab.unc.edu/pub/Linux/system/filesystems/ext2/
>  RISC OS client		http://www.esw-heim.tu-clausthal.de/~marco/smorbrod/IscaFS/
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

