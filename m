Return-Path: <linux-ext4+bounces-3939-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB52962572
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Aug 2024 13:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C20B328573F
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Aug 2024 11:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B341016B3BA;
	Wed, 28 Aug 2024 11:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0tBK1UVU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7fHWZT4r";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0tBK1UVU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7fHWZT4r"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7414E5A79B;
	Wed, 28 Aug 2024 11:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724843088; cv=none; b=M6oFsBCpZNO424Yzj5hMoexzI+IAavJM7xT8DXJ+AKEcRevoqNW8LlyzIY4GkaR54Qhd8kIZHS/LSk9RvBjL4r9gARtS/uaqzgdu63VG305lLK3UxFcU9KQ1ZhxumtECGLYko5w2U5K/7WjXI0V97H6BolRRKR8JXujJXRdJvGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724843088; c=relaxed/simple;
	bh=IYw/5jfec3G9EL5cIvBTKWMPYFfAUAmYIUT55trKI1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GaJIkU6YVchqqVYf9OzcbGBlc7u02/qvC8Auz6G42AXOtxWF6ZkF+3Ov1ic/E/vHKIJU9jbRRAsAGKOKeYkL4cpLBXG7dCBZmfbULT4FFgc2WR/Xt7rsoJo5puhjPxVr/DmOaI5bFZeAtNrXkdvgrnTMtA6B4+Nm1fiazYqveSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0tBK1UVU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7fHWZT4r; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0tBK1UVU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7fHWZT4r; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A72531FC06;
	Wed, 28 Aug 2024 11:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724843084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IcJrGrxrJ3Kg3x9BNXw8QcolNjCA/gMiIrvdnowUhvM=;
	b=0tBK1UVU1kCEphLWsOeXcQ7WWVlkGlXeBwpmEEOUEzq2dzkskt4XhLK9LiWcsVEEGRlUch
	0XWRsIG90rEfGRYyz9NTuQVZkRPPU39LAauOgoY4QkJJawU8sdtP6FzKPxxI2v56xpdS/N
	a/5x2mejLjpMRv1BppeyZAp5JrMikj4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724843084;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IcJrGrxrJ3Kg3x9BNXw8QcolNjCA/gMiIrvdnowUhvM=;
	b=7fHWZT4r/JR3XVe7abGcoESf7/W+kl6X37LThY+dsAeNvc5n9x0TgNrbP8fZE88tk/Dfgx
	VH9YQAomMQNMBUDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724843084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IcJrGrxrJ3Kg3x9BNXw8QcolNjCA/gMiIrvdnowUhvM=;
	b=0tBK1UVU1kCEphLWsOeXcQ7WWVlkGlXeBwpmEEOUEzq2dzkskt4XhLK9LiWcsVEEGRlUch
	0XWRsIG90rEfGRYyz9NTuQVZkRPPU39LAauOgoY4QkJJawU8sdtP6FzKPxxI2v56xpdS/N
	a/5x2mejLjpMRv1BppeyZAp5JrMikj4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724843084;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IcJrGrxrJ3Kg3x9BNXw8QcolNjCA/gMiIrvdnowUhvM=;
	b=7fHWZT4r/JR3XVe7abGcoESf7/W+kl6X37LThY+dsAeNvc5n9x0TgNrbP8fZE88tk/Dfgx
	VH9YQAomMQNMBUDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D7C1138D2;
	Wed, 28 Aug 2024 11:04:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rANtJkwEz2Y2dgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 28 Aug 2024 11:04:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4C4AAA0968; Wed, 28 Aug 2024 13:04:44 +0200 (CEST)
Date: Wed, 28 Aug 2024 13:04:44 +0200
From: Jan Kara <jack@suse.cz>
To: zhangshida <starzhangzsd@gmail.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.com,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	zhangshida@kylinos.cn, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 1/2] ext4: hoist ext4_block_write_begin and replace the
 __block_write_begin
Message-ID: <20240828110444.7wvo4ev32m5pewo7@quack3>
References: <20240823013329.1996741-1-zhangshida@kylinos.cn>
 <20240823013329.1996741-2-zhangshida@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240823013329.1996741-2-zhangshida@kylinos.cn>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 23-08-24 09:33:28, zhangshida wrote:
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
> fscrypt related code. Narrow the scope of CONFIG_FS_ENCRYPTION so as
> to allow ext4_block_write_begin() to function like __block_write_begin
> when the config is disabled.
> And hoist the ext4_block_write_begin so that it can be used in other
> files.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>

Looks good to me! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ext4.h   |  2 ++
>  fs/ext4/inline.c | 10 +++++-----
>  fs/ext4/inode.c  | 23 ++++++-----------------
>  3 files changed, 13 insertions(+), 22 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 08acd152261e..5f8257b68190 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -3851,6 +3851,8 @@ static inline int ext4_buffer_uptodate(struct buffer_head *bh)
>  	return buffer_uptodate(bh);
>  }
>  
> +extern int ext4_block_write_begin(struct folio *folio, loff_t pos, unsigned len,
> +				  get_block_t *get_block);
>  #endif	/* __KERNEL__ */
>  
>  #define EFSBADCRC	EBADMSG		/* Bad CRC detected */
> diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
> index e7a09a99837b..0a1a8431e281 100644
> --- a/fs/ext4/inline.c
> +++ b/fs/ext4/inline.c
> @@ -601,10 +601,10 @@ static int ext4_convert_inline_data_to_extent(struct address_space *mapping,
>  		goto out;
>  
>  	if (ext4_should_dioread_nolock(inode)) {
> -		ret = __block_write_begin(&folio->page, from, to,
> -					  ext4_get_block_unwritten);
> +		ret = ext4_block_write_begin(folio, from, to,
> +					     ext4_get_block_unwritten);
>  	} else
> -		ret = __block_write_begin(&folio->page, from, to, ext4_get_block);
> +		ret = ext4_block_write_begin(folio, from, to, ext4_get_block);
>  
>  	if (!ret && ext4_should_journal_data(inode)) {
>  		ret = ext4_walk_page_buffers(handle, inode,
> @@ -856,8 +856,8 @@ static int ext4_da_convert_inline_data_to_extent(struct address_space *mapping,
>  			goto out;
>  	}
>  
> -	ret = __block_write_begin(&folio->page, 0, inline_size,
> -				  ext4_da_get_block_prep);
> +	ret = ext4_block_write_begin(folio, 0, inline_size,
> +				     ext4_da_get_block_prep);
>  	if (ret) {
>  		up_read(&EXT4_I(inode)->xattr_sem);
>  		folio_unlock(folio);
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 941c1c0d5c6e..6b15805ca88b 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -1041,9 +1041,8 @@ int do_journal_get_write_access(handle_t *handle, struct inode *inode,
>  	return ret;
>  }
>  
> -#ifdef CONFIG_FS_ENCRYPTION
> -static int ext4_block_write_begin(struct folio *folio, loff_t pos, unsigned len,
> -				  get_block_t *get_block)
> +int ext4_block_write_begin(struct folio *folio, loff_t pos, unsigned len,
> +			   get_block_t *get_block)
>  {
>  	unsigned from = pos & (PAGE_SIZE - 1);
>  	unsigned to = from + len;
> @@ -1119,7 +1118,9 @@ static int ext4_block_write_begin(struct folio *folio, loff_t pos, unsigned len,
>  	}
>  	if (unlikely(err)) {
>  		folio_zero_new_buffers(folio, from, to);
> -	} else if (fscrypt_inode_uses_fs_layer_crypto(inode)) {
> +	}
> +#ifdef CONFIG_FS_ENCRYPTION
> +	else if (fscrypt_inode_uses_fs_layer_crypto(inode)) {
>  		for (i = 0; i < nr_wait; i++) {
>  			int err2;
>  
> @@ -1131,10 +1132,10 @@ static int ext4_block_write_begin(struct folio *folio, loff_t pos, unsigned len,
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
> @@ -1216,19 +1217,11 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
>  	/* In case writeback began while the folio was unlocked */
>  	folio_wait_stable(folio);
>  
> -#ifdef CONFIG_FS_ENCRYPTION
>  	if (ext4_should_dioread_nolock(inode))
>  		ret = ext4_block_write_begin(folio, pos, len,
>  					     ext4_get_block_unwritten);
>  	else
>  		ret = ext4_block_write_begin(folio, pos, len, ext4_get_block);
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
> @@ -2961,11 +2954,7 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
>  	if (IS_ERR(folio))
>  		return PTR_ERR(folio);
>  
> -#ifdef CONFIG_FS_ENCRYPTION
>  	ret = ext4_block_write_begin(folio, pos, len, ext4_da_get_block_prep);
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

