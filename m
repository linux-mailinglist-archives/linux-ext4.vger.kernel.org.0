Return-Path: <linux-ext4+bounces-703-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE2A82467E
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Jan 2024 17:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19992B22344
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Jan 2024 16:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC0A2510D;
	Thu,  4 Jan 2024 16:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1pRX82ES";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="c0+ZY7MJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1pRX82ES";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="c0+ZY7MJ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829AE24B4F
	for <linux-ext4@vger.kernel.org>; Thu,  4 Jan 2024 16:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7B747220E4;
	Thu,  4 Jan 2024 16:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704386505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8u3H2hvFJKKa8Kn4iF82h5jk6vOFGNZZusg+bDPkpx8=;
	b=1pRX82ESVKll/8YS6zJ/hE77hywuaU7A1BPYcNxisgnFyntLOn0xulQiyKwVZvQuhbnY8H
	vUpJU6YziJ10Kp/4EDsC7A9AAPtbXa38IAF6B/Beqv7tmxgTJnfGEnYxyFqmnJe5i/XpU7
	yPtor6TLqFaoAksUjlBbYZrkU65k8Bk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704386505;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8u3H2hvFJKKa8Kn4iF82h5jk6vOFGNZZusg+bDPkpx8=;
	b=c0+ZY7MJ7cqS0dzoIx7hIf86eQ2q2FbuOb3iLYk/2YEU9GdFNGxpvawcXeefEBt3RWS3m+
	aud0lramhMPItkDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704386505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8u3H2hvFJKKa8Kn4iF82h5jk6vOFGNZZusg+bDPkpx8=;
	b=1pRX82ESVKll/8YS6zJ/hE77hywuaU7A1BPYcNxisgnFyntLOn0xulQiyKwVZvQuhbnY8H
	vUpJU6YziJ10Kp/4EDsC7A9AAPtbXa38IAF6B/Beqv7tmxgTJnfGEnYxyFqmnJe5i/XpU7
	yPtor6TLqFaoAksUjlBbYZrkU65k8Bk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704386505;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8u3H2hvFJKKa8Kn4iF82h5jk6vOFGNZZusg+bDPkpx8=;
	b=c0+ZY7MJ7cqS0dzoIx7hIf86eQ2q2FbuOb3iLYk/2YEU9GdFNGxpvawcXeefEBt3RWS3m+
	aud0lramhMPItkDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6FC4B137E8;
	Thu,  4 Jan 2024 16:41:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id T29CG8nflmVlYgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 04 Jan 2024 16:41:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0C08AA07EF; Thu,  4 Jan 2024 17:41:45 +0100 (CET)
Date: Thu, 4 Jan 2024 17:41:45 +0100
From: Jan Kara <jack@suse.cz>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: Convert ext4_da_do_write_end() to take a folio
Message-ID: <20240104164145.syk7ei5ns5j2y7uy@quack3>
References: <20231214053035.1018876-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214053035.1018876-1-willy@infradead.org>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 URIBL_BLOCKED(0.00)[suse.cz:email,infradead.org:email,suse.com:email];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,infradead.org:email,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

On Thu 14-12-23 05:30:35, Matthew Wilcox (Oracle) wrote:
> There's nothing page-specific happening in ext4_da_do_write_end();
> it's merely used for its refcount & lock, both of which are folio
> properties.  Saves four calls to compound_head().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 83ee4e0f46f4..216ad9bcca45 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -2947,7 +2947,7 @@ static int ext4_da_should_update_i_disksize(struct folio *folio,
>  
>  static int ext4_da_do_write_end(struct address_space *mapping,
>  			loff_t pos, unsigned len, unsigned copied,
> -			struct page *page)
> +			struct folio *folio)
>  {
>  	struct inode *inode = mapping->host;
>  	loff_t old_size = inode->i_size;
> @@ -2958,12 +2958,13 @@ static int ext4_da_do_write_end(struct address_space *mapping,
>  	 * block_write_end() will mark the inode as dirty with I_DIRTY_PAGES
>  	 * flag, which all that's needed to trigger page writeback.
>  	 */
> -	copied = block_write_end(NULL, mapping, pos, len, copied, page, NULL);
> +	copied = block_write_end(NULL, mapping, pos, len, copied,
> +			&folio->page, NULL);
>  	new_i_size = pos + copied;
>  
>  	/*
> -	 * It's important to update i_size while still holding page lock,
> -	 * because page writeout could otherwise come in and zero beyond
> +	 * It's important to update i_size while still holding folio lock,
> +	 * because folio writeout could otherwise come in and zero beyond
>  	 * i_size.
>  	 *
>  	 * Since we are holding inode lock, we are sure i_disksize <=
> @@ -2981,14 +2982,14 @@ static int ext4_da_do_write_end(struct address_space *mapping,
>  
>  		i_size_write(inode, new_i_size);
>  		end = (new_i_size - 1) & (PAGE_SIZE - 1);
> -		if (copied && ext4_da_should_update_i_disksize(page_folio(page), end)) {
> +		if (copied && ext4_da_should_update_i_disksize(folio, end)) {
>  			ext4_update_i_disksize(inode, new_i_size);
>  			disksize_changed = true;
>  		}
>  	}
>  
> -	unlock_page(page);
> -	put_page(page);
> +	folio_unlock(folio);
> +	folio_put(folio);
>  
>  	if (old_size < pos)
>  		pagecache_isize_extended(inode, old_size, pos);
> @@ -3027,10 +3028,10 @@ static int ext4_da_write_end(struct file *file,
>  		return ext4_write_inline_data_end(inode, pos, len, copied,
>  						  folio);
>  
> -	if (unlikely(copied < len) && !PageUptodate(page))
> +	if (unlikely(copied < len) && !folio_test_uptodate(folio))
>  		copied = 0;
>  
> -	return ext4_da_do_write_end(mapping, pos, len, copied, &folio->page);
> +	return ext4_da_do_write_end(mapping, pos, len, copied, folio);
>  }
>  
>  /*
> -- 
> 2.42.0
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

