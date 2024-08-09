Return-Path: <linux-ext4+bounces-3687-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8CC94D51B
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Aug 2024 18:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A682287061
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Aug 2024 16:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9243770D;
	Fri,  9 Aug 2024 16:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FZkER0zs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4lrjnf0z";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FZkER0zs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4lrjnf0z"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD9D2940D;
	Fri,  9 Aug 2024 16:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723222565; cv=none; b=nQXlHhT0qrQJxNELvCtEZK4GPyFPvrQZfCW4V4pv4gOlVweibAl8ucBfQ3sCEn/uf8UqL4b1KVr11ZqWPtzKDK6hAhThppAtdEUNCKkGgHnZ3a/5tU/lMLduVFuQEzHRk78TQWWRQUn2Qem/QF4q2JiQ2BSTWggddi2RLuO+S9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723222565; c=relaxed/simple;
	bh=XsYfTSEFGm7MRDOgLGo+4usD7dTJHctVvyp56GmC11Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nm22eQFNB2LeNnIRNVLw6torRjtO5xMbe5L+MQkLUGnUxSgLiwjJ88yaIYbkw0mrSYr0KRM7a3Y4gqtmTvfwbmW1+nLlO0LbD0cfDbbxzjIezYiOPaGUaGGHASpyDWnQebb7gCTwTFr5smqL8HCdcxruGJFGTakvMQhZL+rOLkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FZkER0zs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4lrjnf0z; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FZkER0zs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4lrjnf0z; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0764221E37;
	Fri,  9 Aug 2024 16:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723222553; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qpsLrP3CPpD0n7dQtsWffHlUALpNhZUbBKs6DWmYf3I=;
	b=FZkER0zs8p2WhdWUZA7zbhyEF+JS2F1F08vYDUAAntzA54Mv/Sixd/bf4ow4S2FSxbvCNC
	TgH0goTVIdjsMt1lWVrJNVYMpQ/vCEBR+2tixiBPo2utTH8Qob/vPEdFErtIvnwspJ2+Zn
	QlvXPm0N9fvSazYCcOKUHzzEennHl3c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723222553;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qpsLrP3CPpD0n7dQtsWffHlUALpNhZUbBKs6DWmYf3I=;
	b=4lrjnf0zj11sJ/0WfhLVlKO9uWdXVZR5E21EGOIjAbHu/7UrjxgZl9ojXtqOhHJjBXpikn
	CXa7GkNUTpxx5iAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FZkER0zs;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4lrjnf0z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723222553; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qpsLrP3CPpD0n7dQtsWffHlUALpNhZUbBKs6DWmYf3I=;
	b=FZkER0zs8p2WhdWUZA7zbhyEF+JS2F1F08vYDUAAntzA54Mv/Sixd/bf4ow4S2FSxbvCNC
	TgH0goTVIdjsMt1lWVrJNVYMpQ/vCEBR+2tixiBPo2utTH8Qob/vPEdFErtIvnwspJ2+Zn
	QlvXPm0N9fvSazYCcOKUHzzEennHl3c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723222553;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qpsLrP3CPpD0n7dQtsWffHlUALpNhZUbBKs6DWmYf3I=;
	b=4lrjnf0zj11sJ/0WfhLVlKO9uWdXVZR5E21EGOIjAbHu/7UrjxgZl9ojXtqOhHJjBXpikn
	CXa7GkNUTpxx5iAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB5241379A;
	Fri,  9 Aug 2024 16:55:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dHVtORhKtmaYPAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 09 Aug 2024 16:55:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 73CC7A084C; Fri,  9 Aug 2024 18:55:48 +0200 (CEST)
Date: Fri, 9 Aug 2024 18:55:48 +0200
From: Jan Kara <jack@suse.cz>
To: zhangshida <starzhangzsd@gmail.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.com,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	zhangshida@kylinos.cn, Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH V2 2/2] ext4: Replace the __block_write_begin with
 ext4_block_write_begin
Message-ID: <20240809165548.nlhsovccmn3kmouw@quack3>
References: <20240809064606.3490994-1-zhangshida@kylinos.cn>
 <20240809064606.3490994-3-zhangshida@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240809064606.3490994-3-zhangshida@kylinos.cn>
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 0764221E37
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spam-Flag: NO

On Fri 09-08-24 14:46:06, zhangshida wrote:
> From: Shida Zhang <zhangshida@kylinos.cn>
> 
> Using __block_write_begin() make it inconvenient to journal the
> user data dirty process. We can't tell the block layer maintainer,
> ‘Hey, we want to trace the dirty user data in ext4, can we add some
> special code for ext4 in __block_write_begin?’:P
> 
> So use ext4_block_write_begin() instead.
> 
> The two functions are basically doing the same thing except for the
> fscrypt related code. Narrow the scope of CONFIG_FS_ENCRYPTION
> so as to allow ext4_block_write_begin() to function like
> __block_write_begin when the config is disabled.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>

There are three more calls to __block_write_begin() in fs/ext4/inline.c.
Please convert them as well. We don't allow inline data and data
journalling combination but it is unexpected surprise that those places
still use __block_write_begin().

								Honza

> ---
>  fs/ext4/inode.c | 19 ++++---------------
>  1 file changed, 4 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index de46c0a6842a..31389633086a 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -1046,7 +1046,6 @@ int do_journal_get_write_access(handle_t *handle, struct inode *inode,
>  	return ret;
>  }
>  
> -#ifdef CONFIG_FS_ENCRYPTION
>  static int ext4_block_write_begin(handle_t *handle, struct folio *folio,
>  				  loff_t pos, unsigned len,
>  				  get_block_t *get_block)
> @@ -1135,7 +1134,9 @@ static int ext4_block_write_begin(handle_t *handle, struct folio *folio,
>  							 from, to);
>  		else
>  			folio_zero_new_buffers(folio, from, to);
> -	} else if (fscrypt_inode_uses_fs_layer_crypto(inode)) {
> +	}
> +#ifdef CONFIG_FS_ENCRYPTION
> +	else if (fscrypt_inode_uses_fs_layer_crypto(inode)) {
>  		for (i = 0; i < nr_wait; i++) {
>  			int err2;
>  
> @@ -1147,10 +1148,10 @@ static int ext4_block_write_begin(handle_t *handle, struct folio *folio,
>  			}
>  		}
>  	}
> +#endif
>  
>  	return err;
>  }
> -#endif
>  
>  /*
>   * To preserve ordering, it is essential that the hole instantiation and
> @@ -1232,20 +1233,12 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
>  	/* In case writeback began while the folio was unlocked */
>  	folio_wait_stable(folio);
>  
> -#ifdef CONFIG_FS_ENCRYPTION
>  	if (ext4_should_dioread_nolock(inode))
>  		ret = ext4_block_write_begin(handle, folio, pos, len,
>  					     ext4_get_block_unwritten);
>  	else
>  		ret = ext4_block_write_begin(handle, folio, pos, len,
>  					     ext4_get_block);
> -#else
> -	if (ext4_should_dioread_nolock(inode))
> -		ret = __block_write_begin(&folio->page, pos, len,
> -					  ext4_get_block_unwritten);
> -	else
> -		ret = __block_write_begin(&folio->page, pos, len, ext4_get_block);
> -#endif
>  	if (!ret && ext4_should_journal_data(inode)) {
>  		ret = ext4_walk_page_buffers(handle, inode,
>  					     folio_buffers(folio), from, to,
> @@ -2978,12 +2971,8 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
>  	if (IS_ERR(folio))
>  		return PTR_ERR(folio);
>  
> -#ifdef CONFIG_FS_ENCRYPTION
>  	ret = ext4_block_write_begin(NULL, folio, pos, len,
>  				     ext4_da_get_block_prep);
> -#else
> -	ret = __block_write_begin(&folio->page, pos, len, ext4_da_get_block_prep);
> -#endif
>  	if (ret < 0) {
>  		folio_unlock(folio);
>  		folio_put(folio);
> -- 
> 2.33.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

