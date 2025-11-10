Return-Path: <linux-ext4+bounces-11708-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7ECC45ABD
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Nov 2025 10:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 240184EA9E3
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Nov 2025 09:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CD02FFDF2;
	Mon, 10 Nov 2025 09:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kVT5Sil1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pXhsAYPO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kVT5Sil1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pXhsAYPO"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FE22FD7D0
	for <linux-ext4@vger.kernel.org>; Mon, 10 Nov 2025 09:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762767335; cv=none; b=K/lqlmvmsSBOdu/YiIM23zUABiqyi+vqkBXG04yEUkZHh4vR7zqOEmi3JunlUcPwBtLIi1G9WI51hTjUzVIj4XFIaVF4l07xjA9bm/7mHENmrsqvfJy2TOsdzIVhmMUjtT7c0ChTC5lLIqAMSyGC1eT7nmmY0NmyXwy1KdP3UMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762767335; c=relaxed/simple;
	bh=9kwqj9aj6lLjgNBYFTWlG1fvjyOWeyhv8PSXBDndqAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gEspBSjNQJ2TqJc2pQSJbFGNXQMkLJUCGBJ2LjLIzLmktBIxG0e9L37+ZHJOC4mCCK5gXfvqn/MXnACFq9WnavfCfHM2S+mktoLJrhNy/5F/SDP+ua8z5evFap7PbrqhQkvYvH6LQgzW2QU+JMsXqaBMEhDTYvOUwJsgTwfnOgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kVT5Sil1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pXhsAYPO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kVT5Sil1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pXhsAYPO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 11507336BE;
	Mon, 10 Nov 2025 09:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762767330; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ex35juG8y5PzLS1xEpnvhVvNW0k8CsFYy4jnd5xXWdU=;
	b=kVT5Sil13igWCO5mC4nalmbXMmRlwiORqG7pfc/MTRhc68vtwxCUAleQeVTjL5nVkcOB89
	ybB1J7NCdJSTUfFqyRlcxynm6djYoBLoht9v5AyA1q/F7cwCbEB8fCNupaqcz949lYM0qd
	iOHokN/8thg6LP+5wBHtgYc42iVUoJs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762767330;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ex35juG8y5PzLS1xEpnvhVvNW0k8CsFYy4jnd5xXWdU=;
	b=pXhsAYPOX9AJuE4CxrGAawfDIGcPE/XIVAgewrXDwAKoGUTKDxcmx/jkeIs3NkPeG3Zkxk
	0GyMFL3U07VzsrAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=kVT5Sil1;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=pXhsAYPO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762767330; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ex35juG8y5PzLS1xEpnvhVvNW0k8CsFYy4jnd5xXWdU=;
	b=kVT5Sil13igWCO5mC4nalmbXMmRlwiORqG7pfc/MTRhc68vtwxCUAleQeVTjL5nVkcOB89
	ybB1J7NCdJSTUfFqyRlcxynm6djYoBLoht9v5AyA1q/F7cwCbEB8fCNupaqcz949lYM0qd
	iOHokN/8thg6LP+5wBHtgYc42iVUoJs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762767330;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ex35juG8y5PzLS1xEpnvhVvNW0k8CsFYy4jnd5xXWdU=;
	b=pXhsAYPOX9AJuE4CxrGAawfDIGcPE/XIVAgewrXDwAKoGUTKDxcmx/jkeIs3NkPeG3Zkxk
	0GyMFL3U07VzsrAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 02FBF13BF6;
	Mon, 10 Nov 2025 09:35:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +L2wAOKxEWlxbwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 10 Nov 2025 09:35:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9DCB2A28B1; Mon, 10 Nov 2025 10:35:29 +0100 (CET)
Date: Mon, 10 Nov 2025 10:35:29 +0100
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, linux-kernel@vger.kernel.org, kernel@pankajraghav.com, 
	mcgrof@kernel.org, ebiggers@kernel.org, willy@infradead.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, chengzhihao1@huawei.com, libaokun1@huawei.com
Subject: Re: [PATCH v2 04/24] ext4: make ext4_punch_hole() support large
 block size
Message-ID: <v2gmd526vjvrjgc44abhw3jw6pyqqq4ypoo6y24umttkmlbnwf@y6ma2vz4iafb>
References: <20251107144249.435029-1-libaokun@huaweicloud.com>
 <20251107144249.435029-5-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107144249.435029-5-libaokun@huaweicloud.com>
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.21 / 50.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_DKIM_ALLOW(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email,huawei.com:email];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 11507336BE
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -0.21

On Fri 07-11-25 22:42:29, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> When preparing for bs > ps support, clean up unnecessary PAGE_SIZE
> references in ext4_punch_hole().
> 
> Previously, when a hole extended beyond i_size, we aligned the hole end
> upwards to PAGE_SIZE to handle partial folio invalidation. Now that
> truncate_inode_pages_range() already handles partial folio invalidation
> correctly, this alignment is no longer required.
> 
> However, to save pointless tail block zeroing, we still keep rounding up
> to the block size here.
> 
> In addition, as Honza pointed out, when the hole end equals i_size, it
> should also be rounded up to the block size. This patch fixes that as well.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index f7ca48729738..6fec3aa2268a 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4406,10 +4406,10 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>  
>  	/*
>  	 * If the hole extends beyond i_size, set the hole to end after
> -	 * the page that contains i_size.
> +	 * the block that contains i_size to save pointless tail block zeroing.
>  	 */
> -	if (end > inode->i_size)
> -		end = round_up(inode->i_size, PAGE_SIZE);
> +	if (end >= inode->i_size)
> +		end = round_up(inode->i_size, sb->s_blocksize);
>  	if (end > max_end)
>  		end = max_end;
>  	length = end - offset;
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

