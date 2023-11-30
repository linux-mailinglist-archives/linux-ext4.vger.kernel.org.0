Return-Path: <linux-ext4+bounces-239-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 837707FEF2F
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Nov 2023 13:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B553F1C20D59
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Nov 2023 12:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44FD39845;
	Thu, 30 Nov 2023 12:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1N8lw7rU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WcwFG53O"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12E8D4A;
	Thu, 30 Nov 2023 04:36:04 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4223A1FB3F;
	Thu, 30 Nov 2023 12:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1701347762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/ljrQk3BqbkodSFG46bYr4eazlX6Cxqb5pUHT95C7r8=;
	b=1N8lw7rU4uUXQy7fe3kxGnnYmL9jqMDEONqJi4/euu9FDvVp5d5BVwGYTs3NGNoPw3QeYQ
	sEONeEvUeUZglEaIPJt7j2qKxT1W/paPxfGinNzHslBgNLQYl4xjoEsV/7IYUm0rUz4v33
	D4Tu57GRj/GmtNCkIvp4+aTtjwUjwts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1701347762;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/ljrQk3BqbkodSFG46bYr4eazlX6Cxqb5pUHT95C7r8=;
	b=WcwFG53OnS6tXTduO1WdTZq2CZ6bNcbIBD//vZLIBdvx9koi3D5zpu/etzAgsfziyUkkNk
	IaL6OOFyhNZmKoCw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 34D9613A5C;
	Thu, 30 Nov 2023 12:36:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id NeTdDLKBaGV2UwAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 30 Nov 2023 12:36:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AB210A07DB; Thu, 30 Nov 2023 13:36:01 +0100 (CET)
Date: Thu, 30 Nov 2023 13:36:01 +0100
From: Jan Kara <jack@suse.cz>
To: Gou Hao <gouhao@uniontech.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
	alex@clusterfs.com, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, gouhaojake@163.com
Subject: Re: [PATCH] ext4: improving calculation of 'fe_{len|start}' in
 mb_find_extent()
Message-ID: <20231130123601.bdzyhsxqegpe5qbe@quack3>
References: <20231113082617.11258-1-gouhao@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113082617.11258-1-gouhao@uniontech.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: 4.50
X-Spamd-Result: default: False [4.50 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_SPAM(5.10)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[163.com];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email,uniontech.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[mit.edu,dilger.ca,suse.cz,clusterfs.com,vger.kernel.org,163.com];
	 RCVD_TLS_ALL(0.00)[]

On Mon 13-11-23 16:26:17, Gou Hao wrote:
> After first execution of mb_find_order_for_block():
> 
> 'fe_start' is the value of 'block' passed in mb_find_extent().
> 
> 'fe_len' is the difference between the length of order-chunk and
> remainder of the block divided by order-chunk.
> 
> And 'next' does not require initialization after above modifications.
> 
> Signed-off-by: Gou Hao <gouhao@uniontech.com>

Ah, nice simplification! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mballoc.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 454d5612641e..d3f985f7cab8 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -1958,8 +1958,7 @@ static void mb_free_blocks(struct inode *inode, struct ext4_buddy *e4b,
>  static int mb_find_extent(struct ext4_buddy *e4b, int block,
>  				int needed, struct ext4_free_extent *ex)
>  {
> -	int next = block;
> -	int max, order;
> +	int max, order, next;
>  	void *buddy;
>  
>  	assert_spin_locked(ext4_group_lock_ptr(e4b->bd_sb, e4b->bd_group));
> @@ -1977,16 +1976,12 @@ static int mb_find_extent(struct ext4_buddy *e4b, int block,
>  
>  	/* find actual order */
>  	order = mb_find_order_for_block(e4b, block);
> -	block = block >> order;
>  
> -	ex->fe_len = 1 << order;
> -	ex->fe_start = block << order;
> +	ex->fe_len = (1 << order) - (block & ((1 << order) - 1));
> +	ex->fe_start = block;
>  	ex->fe_group = e4b->bd_group;
>  
> -	/* calc difference from given start */
> -	next = next - ex->fe_start;
> -	ex->fe_len -= next;
> -	ex->fe_start += next;
> +	block = block >> order;
>  
>  	while (needed > ex->fe_len &&
>  	       mb_find_buddy(e4b, order, &max)) {
> -- 
> 2.20.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

