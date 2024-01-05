Return-Path: <linux-ext4+bounces-727-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3D18251BA
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Jan 2024 11:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 999C01C22FE2
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Jan 2024 10:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E326224B48;
	Fri,  5 Jan 2024 10:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LfzYWoka";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dH/9dxz+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LfzYWoka";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dH/9dxz+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B536F24B47
	for <linux-ext4@vger.kernel.org>; Fri,  5 Jan 2024 10:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6BF4D21ECB;
	Fri,  5 Jan 2024 10:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704449904; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JjIlO8lYhPVMj89+Si26m00TAT9SLZit8c95fgUkiNE=;
	b=LfzYWoka5j/JjumC0j++Lwg0sR50dlkNthZHJmOmNpqNS5XVYbj4oQ68gmX+XIUC3pZZra
	BxHGqZF7FjWUu43BmbyuEBk6jHuT0DbptenTLEILVelDYUCvwvWCf/K/LtSog7+HFRTRKW
	HPr/VNlWm3MKLBAE6zKSCqAJG4ZPSi8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704449904;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JjIlO8lYhPVMj89+Si26m00TAT9SLZit8c95fgUkiNE=;
	b=dH/9dxz+viCNoRaHGkmYVDhdIoqOMGYEMeJY+ywLtDMYCi6nOlCr5bK9BN5AlBP9pQWBqy
	bgkbBZH1OnxMALAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704449904; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JjIlO8lYhPVMj89+Si26m00TAT9SLZit8c95fgUkiNE=;
	b=LfzYWoka5j/JjumC0j++Lwg0sR50dlkNthZHJmOmNpqNS5XVYbj4oQ68gmX+XIUC3pZZra
	BxHGqZF7FjWUu43BmbyuEBk6jHuT0DbptenTLEILVelDYUCvwvWCf/K/LtSog7+HFRTRKW
	HPr/VNlWm3MKLBAE6zKSCqAJG4ZPSi8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704449904;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JjIlO8lYhPVMj89+Si26m00TAT9SLZit8c95fgUkiNE=;
	b=dH/9dxz+viCNoRaHGkmYVDhdIoqOMGYEMeJY+ywLtDMYCi6nOlCr5bK9BN5AlBP9pQWBqy
	bgkbBZH1OnxMALAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B84D13C99;
	Fri,  5 Jan 2024 10:18:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LytRFnDXl2UJXQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 05 Jan 2024 10:18:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DE1B3A07EF; Fri,  5 Jan 2024 11:18:23 +0100 (CET)
Date: Fri, 5 Jan 2024 11:18:23 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: Re: [PATCH v3 5/6] ext4: make ext4_map_blocks() distinguish delalloc
 only extent
Message-ID: <20240105101823.h5ucbtlhinghhbuk@quack3>
References: <20240105033018.1665752-1-yi.zhang@huaweicloud.com>
 <20240105033018.1665752-6-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240105033018.1665752-6-yi.zhang@huaweicloud.com>
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 6BF4D21ECB
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=LfzYWoka;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="dH/9dxz+"
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.01 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 URIBL_BLOCKED(0.00)[huawei.com:email,suse.com:email,suse.cz:email,suse.cz:dkim];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,suse.cz:email,suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]

On Fri 05-01-24 11:30:17, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Add a new map flag EXT4_MAP_DELAYED to indicate the mapping range is a
> delayed allocated only (not unwritten) one, and making
> ext4_map_blocks() can distinguish it, no longer mixing it with holes.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ext4.h    | 4 +++-
>  fs/ext4/extents.c | 7 +++++--
>  fs/ext4/inode.c   | 2 ++
>  3 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index a5d784872303..55195909d32f 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -252,8 +252,10 @@ struct ext4_allocation_request {
>  #define EXT4_MAP_MAPPED		BIT(BH_Mapped)
>  #define EXT4_MAP_UNWRITTEN	BIT(BH_Unwritten)
>  #define EXT4_MAP_BOUNDARY	BIT(BH_Boundary)
> +#define EXT4_MAP_DELAYED	BIT(BH_Delay)
>  #define EXT4_MAP_FLAGS		(EXT4_MAP_NEW | EXT4_MAP_MAPPED |\
> -				 EXT4_MAP_UNWRITTEN | EXT4_MAP_BOUNDARY)
> +				 EXT4_MAP_UNWRITTEN | EXT4_MAP_BOUNDARY |\
> +				 EXT4_MAP_DELAYED)
>  
>  struct ext4_map_blocks {
>  	ext4_fsblk_t m_pblk;
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index e0b7e48c4c67..6b64319a7df8 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4076,8 +4076,11 @@ static ext4_lblk_t ext4_ext_determine_insert_hole(struct inode *inode,
>  		/*
>  		 * The delalloc extent containing lblk, it must have been
>  		 * added after ext4_map_blocks() checked the extent status
> -		 * tree, adjust the length to the delalloc extent's after
> -		 * lblk.
> +		 * tree so we are not holding i_rwsem and delalloc info is
> +		 * only stabilized by i_data_sem we are going to release
> +		 * soon. Don't modify the extent status tree and report
> +		 * extent as a hole, just adjust the length to the delalloc
> +		 * extent's after lblk.
>  		 */
>  		len = es.es_lblk + es.es_len - lblk;
>  		return len;
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 1b5e6409f958..c141bf6d8db2 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -515,6 +515,8 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
>  			map->m_len = retval;
>  		} else if (ext4_es_is_delayed(&es) || ext4_es_is_hole(&es)) {
>  			map->m_pblk = 0;
> +			map->m_flags |= ext4_es_is_delayed(&es) ?
> +					EXT4_MAP_DELAYED : 0;
>  			retval = es.es_len - (map->m_lblk - es.es_lblk);
>  			if (retval > map->m_len)
>  				retval = map->m_len;
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

