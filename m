Return-Path: <linux-ext4+bounces-3021-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9136D91C0B4
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Jun 2024 16:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E187BB24924
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Jun 2024 14:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEAC1BF317;
	Fri, 28 Jun 2024 14:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Rw+4iapz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kKzUN1sq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="A3HbFTHs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wCKTRyxE"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2891E517
	for <linux-ext4@vger.kernel.org>; Fri, 28 Jun 2024 14:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719584330; cv=none; b=jCqAjLOyUP0NeGsV3mroeTDWBQCw/yrU8UhebUBi0bpuo2h5c1l/CIo6VDF+JAlJ6tAHXpILC4JwiXUnPz6iDPIMMKphZgR2OyfiFNSZOWaMi4E70JcTMKzyHVs03WQ/KCFICm+T+B4V5WaACvgHIlfB7N8t47JxZMhvxBgil9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719584330; c=relaxed/simple;
	bh=MNKr60GXiC11DFrlWJd3IXK02rhn5gMdSA6aKMSKSdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z7CiuqvtBkC9sg8gJwcGpmQ+65sePFbPAyDzMLWXQMtUlnxjCPUifzq2S8HdrO6JVo4nDV3KgoJwZ3jTpxwuQc7pBC2Rl7yv9jSwBO0MR0cDiu4LhqRERsdIMi4JyS9Bfc5cMa6R3v5k9x6OSJGEFiWG65WE1KoCgFcygdeFfgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Rw+4iapz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kKzUN1sq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=A3HbFTHs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wCKTRyxE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D2AEF21BAC;
	Fri, 28 Jun 2024 14:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719584327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dB5WrwuT+XvYpjR+Rf8lygfB/HoG3c3lc/VS9ZBlnpg=;
	b=Rw+4iapzjtTqbaakL6Nvpysl5phklPYoKr3proZwEyd6AM0SI0BNnil/axgm6RS9EJPs/D
	sgbvriyA1tARCnNs9iYDpB67pUoNjmHOXCS30GVzM23l9IYprPdhkfnb8VOhA9j+PVPomr
	/RZaYxUwqg1TthQ/siclIeThYAlXK+k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719584327;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dB5WrwuT+XvYpjR+Rf8lygfB/HoG3c3lc/VS9ZBlnpg=;
	b=kKzUN1sqRoey3kmd+WQWameDGKrDnM1ymWixm8oeM+0YABINv3cwTfw0z1TV1bv6DltM8E
	pSJmLzuhR6gTTcAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719584326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dB5WrwuT+XvYpjR+Rf8lygfB/HoG3c3lc/VS9ZBlnpg=;
	b=A3HbFTHsIyrB77H31f1APaVJB1OEGlQOF39Uvg2eIKED9qPp8HvfgjDNIsuklG9SnVgHH8
	RfQnfhiLxhu5rVKahPo9C6ekgWTSehEZsdora9mN019xza7kfNwVcbeYYVCoizQ3ygDt6l
	wsGGQQiYkbiE0s43NJF9C3RXLF2gvcg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719584326;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dB5WrwuT+XvYpjR+Rf8lygfB/HoG3c3lc/VS9ZBlnpg=;
	b=wCKTRyxErgWvRxb38SLFl0EBf+IG2hTQ3BCa2aXOlMWlbE9cV/CfWTCxDdJyfMCMwnub8c
	yacgEnlgEzuLwcBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B514913375;
	Fri, 28 Jun 2024 14:18:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pOEoLEbGfmZcEAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 28 Jun 2024 14:18:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E7B9CA088E; Fri, 28 Jun 2024 16:18:37 +0200 (CEST)
Date: Fri, 28 Jun 2024 16:18:37 +0200
From: Jan Kara <jack@suse.cz>
To: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, saukad@google.com,
	harshads@google.com
Subject: Re: [PATCH v6 07/10] ext4: add nolock mode to ext4_map_blocks()
Message-ID: <20240628141837.iu3knuvzb7kc7qag@quack3>
References: <20240529012003.4006535-1-harshadshirwadkar@gmail.com>
 <20240529012003.4006535-8-harshadshirwadkar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529012003.4006535-8-harshadshirwadkar@gmail.com>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]

On Wed 29-05-24 01:20:00, Harshad Shirwadkar wrote:
> Add nolock flag to ext4_map_blocks() which skips grabbing
> i_data_sem in ext4_map_blocks. In FC commit path, we first
> mark the inode as committing and thereby prevent any mutations
> on it. Thus, it should be safe to call ext4_map_blocks()
> without i_data_sem in this case. This is a workaround to
> the problem mentioned in RFC V4 version cover letter[1] of this
> patch series which pointed out that there is in incosistency between
> ext4_map_blocks() behavior when EXT4_GET_BLOCKS_CACHED_NOWAIT is
> passed. This patch gets rid of the need to call ext4_map_blocks()
> with EXT4_GET_BLOCKS_CACHED_NOWAIT and instead call it with
> EXT4_GET_BLOCKS_NOLOCK. I verified that generic/311 which failed
> in cached_nowait mode passes with nolock mode.
> 
> [1] https://lwn.net/Articles/902022/
> 
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

I'm sorry I forgot since last time - can you remind me why we cannot we
grab i_data_sem from ext4_fc_write_inode_data()? Because as you write
above, nobody should really be holding that lock while inode is
EXT4_STATE_FC_COMMITTING anyway...

								Honza

> ---
>  fs/ext4/ext4.h        |  1 +
>  fs/ext4/fast_commit.c | 16 ++++++++--------
>  fs/ext4/inode.c       | 14 ++++++++++++--
>  3 files changed, 21 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index d802040e94df..196c513f82dd 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -720,6 +720,7 @@ enum {
>  #define EXT4_GET_BLOCKS_IO_SUBMIT		0x0400
>  	/* Caller is in the atomic contex, find extent if it has been cached */
>  #define EXT4_GET_BLOCKS_CACHED_NOWAIT		0x0800
> +#define EXT4_GET_BLOCKS_NOLOCK			0x1000
>  
>  /*
>   * The bit position of these flags must not overlap with any of the
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index b81b0292aa59..0b7064f8dfa5 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -559,13 +559,6 @@ void ext4_fc_track_inode(handle_t *handle, struct inode *inode)
>  		!list_empty(&ei->i_fc_list))
>  		return;
>  
> -	/*
> -	 * If we come here, we may sleep while waiting for the inode to
> -	 * commit. We shouldn't be holding i_data_sem in write mode when we go
> -	 * to sleep since the commit path needs to grab the lock while
> -	 * committing the inode.
> -	 */
> -	WARN_ON(lockdep_is_held_type(&ei->i_data_sem, 1));
>  
>  	while (ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING)) {
>  #if (BITS_PER_LONG < 64)
> @@ -898,7 +891,14 @@ static int ext4_fc_write_inode_data(struct inode *inode, u32 *crc)
>  	while (cur_lblk_off <= new_blk_size) {
>  		map.m_lblk = cur_lblk_off;
>  		map.m_len = new_blk_size - cur_lblk_off + 1;
> -		ret = ext4_map_blocks(NULL, inode, &map, 0);
> +		/*
> +		 * Given that this inode is being committed,
> +		 * EXT4_STATE_FC_COMMITTING is already set on this inode.
> +		 * Which means all the mutations on the inode are paused
> +		 * until the commit operation is complete. Thus it is safe
> +		 * call ext4_map_blocks() in no lock mode.
> +		 */
> +		ret = ext4_map_blocks(NULL, inode, &map, EXT4_GET_BLOCKS_NOLOCK);
>  		if (ret < 0)
>  			return -ECANCELED;
>  
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 61ffbdc2fb16..f00408017c7a 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -546,7 +546,8 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
>  	 * Try to see if we can get the block without requesting a new
>  	 * file system block.
>  	 */
> -	down_read(&EXT4_I(inode)->i_data_sem);
> +	if (!(flags & EXT4_GET_BLOCKS_NOLOCK))
> +		down_read(&EXT4_I(inode)->i_data_sem);
>  	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
>  		retval = ext4_ext_map_blocks(handle, inode, map, 0);
>  	} else {
> @@ -573,7 +574,15 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
>  		ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
>  				      map->m_pblk, status);
>  	}
> -	up_read((&EXT4_I(inode)->i_data_sem));
> +	/*
> +	 * We should never call ext4_map_blocks() in nolock mode outside
> +	 * of fast commit path.
> +	 */
> +	WARN_ON((flags & EXT4_GET_BLOCKS_NOLOCK) &&
> +		!ext4_test_inode_state(inode,
> +				       EXT4_STATE_FC_COMMITTING));
> +	if (!(flags & EXT4_GET_BLOCKS_NOLOCK))
> +		up_read((&EXT4_I(inode)->i_data_sem));
>  
>  found:
>  	if (retval > 0 && map->m_flags & EXT4_MAP_MAPPED) {
> @@ -614,6 +623,7 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
>  	 * the write lock of i_data_sem, and call get_block()
>  	 * with create == 1 flag.
>  	 */
> +	WARN_ON((flags & EXT4_GET_BLOCKS_NOLOCK) != 0);
>  	down_write(&EXT4_I(inode)->i_data_sem);
>  
>  	/*
> -- 
> 2.45.1.288.g0e0cd299f1-goog
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

