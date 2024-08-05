Return-Path: <linux-ext4+bounces-3629-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB6B947BD4
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Aug 2024 15:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4190280FE3
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Aug 2024 13:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B78215A863;
	Mon,  5 Aug 2024 13:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="X2zkOerG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jmGZV7AY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="X2zkOerG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jmGZV7AY"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD4C155C8D
	for <linux-ext4@vger.kernel.org>; Mon,  5 Aug 2024 13:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722864572; cv=none; b=qM27aHax62bTlHDhn4Jg/2wYj1UTGVZvnU7Op1b8DrDL3t6yKatpe7rfVf9wy/7JWc8mK48sT54LHf/4hwLRmgCvkL4FLU92ya0s/8e1N8mQHgzRnEGd2xbpog8nSagw9tezZBE4gd0c6gh4xMARPTHn3JIAWLmWRgurQ5y2/Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722864572; c=relaxed/simple;
	bh=lYRYPP+GNpYpFaX8kaEraIck5i4osb33WKymxoRLJls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o5ESUvHXxvry8tUJrXgsGLMCb2YiDdkZ1SkQfgmRe7wElVVBf8JKLC6tFKT8EA4fIsUePChb+nT8dcFRVnF6/0XqkgHr8YjcM4NTK83zIbsi0URVQT/iDiUYfZc5/cUR9xqCjitw4ixAmxb4l1BoousJro4fuM9SvSzGRRIQ0eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=X2zkOerG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jmGZV7AY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=X2zkOerG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jmGZV7AY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2A5882198F;
	Mon,  5 Aug 2024 13:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722864568; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m70c90CKsmBjtFQAHWm9AdaeV7dcct4Snr9QludE5tI=;
	b=X2zkOerG9r5lIC1rffw3BVr8qLrthsWVFj5FPJsJUx52YFBaFXwF5rlzrbJzc1yVNGhaBO
	KCg7TJsB7K436iL5BErSynUhC52UDzPMUlxzJHqricPOdlBIBobzsyP0ueHG6Nr0emO/N2
	X7AUpd6+u9B2bO7haH5JZEu13yIUXug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722864568;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m70c90CKsmBjtFQAHWm9AdaeV7dcct4Snr9QludE5tI=;
	b=jmGZV7AYZnX9KNgzK2lZv0bJmkFWDs5H1oCYG5woZc7CFw9u/BmIFnZq2t3Wjeymu+A1/Q
	LsTcuVjfvYYNWQDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=X2zkOerG;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=jmGZV7AY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722864568; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m70c90CKsmBjtFQAHWm9AdaeV7dcct4Snr9QludE5tI=;
	b=X2zkOerG9r5lIC1rffw3BVr8qLrthsWVFj5FPJsJUx52YFBaFXwF5rlzrbJzc1yVNGhaBO
	KCg7TJsB7K436iL5BErSynUhC52UDzPMUlxzJHqricPOdlBIBobzsyP0ueHG6Nr0emO/N2
	X7AUpd6+u9B2bO7haH5JZEu13yIUXug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722864568;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m70c90CKsmBjtFQAHWm9AdaeV7dcct4Snr9QludE5tI=;
	b=jmGZV7AYZnX9KNgzK2lZv0bJmkFWDs5H1oCYG5woZc7CFw9u/BmIFnZq2t3Wjeymu+A1/Q
	LsTcuVjfvYYNWQDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F1C413ACF;
	Mon,  5 Aug 2024 13:29:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZSWQB7jTsGbkOQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 05 Aug 2024 13:29:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CC5B0A0897; Mon,  5 Aug 2024 15:29:19 +0200 (CEST)
Date: Mon, 5 Aug 2024 15:29:19 +0200
From: Jan Kara <jack@suse.cz>
To: Shibu Kumar <shibukumar.bit@gmail.com>
Cc: tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] correct the variable name of structure in comment in
 order to remove warning, seen while building Documentation using make
 htmldocs command
Message-ID: <20240805132919.fywsxq4h2agro24v@quack3>
References: <20240803165755.29560-1-shibukumar.bit@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240803165755.29560-1-shibukumar.bit@gmail.com>
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Rspamd-Queue-Id: 2A5882198F


This has been already fixed by Randy here [1]. Ted just needs to pickup the
fix. Ted?

								Honza

[1] https://lore.kernel.org/all/20240723051647.3053491-1-rdunlap@infradead.org

On Sat 03-08-24 22:27:37, Shibu Kumar wrote:
> ---
>  include/linux/jbd2.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 5157d92b6f23..17662eae408f 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -1086,7 +1086,7 @@ struct journal_s
>  	int			j_revoke_records_per_block;
>  
>  	/**
> -	 * @j_transaction_overhead:
> +	 * @j_transaction_overhead_buffers:
>  	 *
>  	 * Number of blocks each transaction needs for its own bookkeeping
>  	 */
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

