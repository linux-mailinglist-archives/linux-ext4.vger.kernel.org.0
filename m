Return-Path: <linux-ext4+bounces-3961-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9F2963F99
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Aug 2024 11:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C1711F25CB5
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Aug 2024 09:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09AD18CBF3;
	Thu, 29 Aug 2024 09:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wCG1BAxy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Pz0/o8SS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wCG1BAxy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Pz0/o8SS"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388A918CBEC;
	Thu, 29 Aug 2024 09:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724922778; cv=none; b=H0dxbx1gdamOQhh3z9lbmq6x2akA8yKeaE2w862eRxb78Ce7Wy4E89mbsE0J6dYSsnQcg6vfoi5luU4ZNZosnlDj3qd1SX3UH4prcLoo0zkmNL3zuGhvYdd62vePuMv94oyFL1seAVRVBYyjyHMiXlM6nmLA52uSpsGh/PbgNUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724922778; c=relaxed/simple;
	bh=LSM53NhNxhDTF6ek+fzxIzEgXvOVnjLGb2WogwMugHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUMReO2aLZU+qapaODWs4o2JKWbnBvPVRsjyeBYZIC+vtzQ1myjqxaAJTdGXQbCcCDdr47uav/CGb7iSMYsLKtv/jwvWt1DtfRm2IeoREVAMNH5dCQb+iKLtKWme85kVPgiaV6mebO3oH8AIga0gdjuxTsQy9yFgTQtqcAlBoCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wCG1BAxy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Pz0/o8SS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wCG1BAxy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Pz0/o8SS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5D102218FC;
	Thu, 29 Aug 2024 09:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724922774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yjqevO2qX2Sbaw0AZ2/k+yCZUN1hue9hbXBBQuLvsJQ=;
	b=wCG1BAxyouFSVF6pHEVnPFfAwSFbID89UCxqFb1EWtUjEL0GDwjrQfFdygZTowOu8YLLKO
	jBs3Sh5QJ/+8TLLbIJiTXmM0Z2/ZttooSmobDoOHSivhH9Ynziz7ZL620B/kVrn54iNEq7
	16NadUfo4iDMMv1DiaUQWkaZmZGDOG0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724922774;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yjqevO2qX2Sbaw0AZ2/k+yCZUN1hue9hbXBBQuLvsJQ=;
	b=Pz0/o8SSCojM8fGSxt6PEMjEzYM4M1MpnbGpDnbIYjPoR8K4CpTJoiUsQBIZK6ei39+hlQ
	vXDhO8aABrRfqyDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724922774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yjqevO2qX2Sbaw0AZ2/k+yCZUN1hue9hbXBBQuLvsJQ=;
	b=wCG1BAxyouFSVF6pHEVnPFfAwSFbID89UCxqFb1EWtUjEL0GDwjrQfFdygZTowOu8YLLKO
	jBs3Sh5QJ/+8TLLbIJiTXmM0Z2/ZttooSmobDoOHSivhH9Ynziz7ZL620B/kVrn54iNEq7
	16NadUfo4iDMMv1DiaUQWkaZmZGDOG0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724922774;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yjqevO2qX2Sbaw0AZ2/k+yCZUN1hue9hbXBBQuLvsJQ=;
	b=Pz0/o8SSCojM8fGSxt6PEMjEzYM4M1MpnbGpDnbIYjPoR8K4CpTJoiUsQBIZK6ei39+hlQ
	vXDhO8aABrRfqyDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5204113408;
	Thu, 29 Aug 2024 09:12:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5mAFFJY70GaMbQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 29 Aug 2024 09:12:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 15F5BA0965; Thu, 29 Aug 2024 11:12:50 +0200 (CEST)
Date: Thu, 29 Aug 2024 11:12:50 +0200
From: Jan Kara <jack@suse.cz>
To: zhangshida <starzhangzsd@gmail.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.com,
	ebiggers@kernel.org, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, zhangshida@kylinos.cn,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 2/3] ext4: hoist ext4_block_write_begin and replace the
 __block_write_begin
Message-ID: <20240829091250.gq2cgkfubbvlysxy@quack3>
References: <20240829085407.3331490-1-zhangshida@kylinos.cn>
 <20240829085407.3331490-3-zhangshida@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240829085407.3331490-3-zhangshida@kylinos.cn>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Thu 29-08-24 16:54:06, zhangshida wrote:
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
> fscrypt related code. Remove the unnecessary #ifdef since
> fscrypt_inode_uses_fs_layer_crypto() returns false (and it's known at
> compile time) when !CONFIG_FS_ENCRYPTION.
> 
> And hoist the ext4_block_write_begin so that it can be used in other
> files.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Suggested-by: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>

I think I've given my Reviewed-by on this already in previous version - you
can keep those tags unless the patch significantly changes. Anyway: feel
free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ext4.h   |  2 ++
>  fs/ext4/inline.c | 10 +++++-----
>  fs/ext4/inode.c  | 24 +++++-------------------
>  3 files changed, 12 insertions(+), 24 deletions(-)
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
> index a0a55cb8db53..4964c67e029e 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -1024,10 +1024,10 @@ int do_journal_get_write_access(handle_t *handle, struct inode *inode,
>  	if (!buffer_mapped(bh) || buffer_freed(bh))
>  		return 0;
>  	/*
> -	 * __block_write_begin() could have dirtied some buffers. Clean
> +	 * ext4_block_write_begin() could have dirtied some buffers. Clean
>  	 * the dirty bit as jbd2_journal_get_write_access() could complain
>  	 * otherwise about fs integrity issues. Setting of the dirty bit
> -	 * by __block_write_begin() isn't a real problem here as we clear
> +	 * by ext4_block_write_begin() isn't a real problem here as we clear
>  	 * the bit before releasing a page lock and thus writeback cannot
>  	 * ever write the buffer.
>  	 */
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
> @@ -1134,7 +1133,6 @@ static int ext4_block_write_begin(struct folio *folio, loff_t pos, unsigned len,
>  
>  	return err;
>  }
> -#endif
>  
>  /*
>   * To preserve ordering, it is essential that the hole instantiation and
> @@ -1216,19 +1214,11 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
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
> @@ -1241,7 +1231,7 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
>  
>  		folio_unlock(folio);
>  		/*
> -		 * __block_write_begin may have instantiated a few blocks
> +		 * ext4_block_write_begin may have instantiated a few blocks
>  		 * outside i_size.  Trim these off again. Don't need
>  		 * i_size_read because we hold i_rwsem.
>  		 *
> @@ -2961,11 +2951,7 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
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

