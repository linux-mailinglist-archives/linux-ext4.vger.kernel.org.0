Return-Path: <linux-ext4+bounces-650-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C180822A0C
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Jan 2024 10:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BEC51F23E9D
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Jan 2024 09:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25972182BF;
	Wed,  3 Jan 2024 09:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JOY7H+0K";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tZ4FWm4i";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NzrKbS7j";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="b2dZL8mE"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EC218623;
	Wed,  3 Jan 2024 09:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 034301FD0B;
	Wed,  3 Jan 2024 09:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704273277; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=62QMAVOIeETc0lprwmhI1LD09b6GbIfO2eMEU/Mvyic=;
	b=JOY7H+0KsFGTrHBJiMO6wDVuqLJGOy8xNiICVQjV1c2fFTAs3Q7TuldTnejeeRry9NDtCL
	ZOy4CVBfX3EuXtQjG18ZQ7bDpsyfDqLKub0LUqlLF/vUW5IFnwN8zg0WKVIijshZWj6dd8
	Ql8CJLqzxzmS6zfVzzBFPUkZP4VOqcc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704273277;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=62QMAVOIeETc0lprwmhI1LD09b6GbIfO2eMEU/Mvyic=;
	b=tZ4FWm4ipV052N+/nuQPll6PPHCXYHZOWo26e7jxoc4pfGQ3BjROB7L4dgABBLU5A/TruO
	VsXA7ddvCmqbFVAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704273275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=62QMAVOIeETc0lprwmhI1LD09b6GbIfO2eMEU/Mvyic=;
	b=NzrKbS7jUZpPls/KaEgv5JYt1c4DEq0pgHi1PZLUFcpeqjd6zo8OdX6XZRPXST/uV2y0u+
	s9phGsc6f0mpgakoQZenRljRqRHQRUQylseqjxTJX7r5ioCZs2fAjyma/WBsfvMDIakb4o
	3E7tNN9zP6vZul94xX6q/DznyPXh/cs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704273275;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=62QMAVOIeETc0lprwmhI1LD09b6GbIfO2eMEU/Mvyic=;
	b=b2dZL8mErc7RAfSq1l7sypkvHjSemTb6yD+VXqA/GHidD/kGqFSs7kd87UI7fzb7x0KOEm
	Nr5SVbKrwu2VCDCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EABEC13AA6;
	Wed,  3 Jan 2024 09:14:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EoNLOXollWU9awAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 03 Jan 2024 09:14:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 767D0A07EF; Wed,  3 Jan 2024 10:14:34 +0100 (CET)
Date: Wed, 3 Jan 2024 10:14:34 +0100
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 9/9] ext4: remove 'needed' in
 trace_ext4_discard_preallocations
Message-ID: <20240103091434.lzsaxlplfeeypwly@quack3>
References: <20240103102821.448134-1-shikemeng@huaweicloud.com>
 <20240103102821.448134-10-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103102821.448134-10-shikemeng@huaweicloud.com>
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.31 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,huaweicloud.com:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:106:10:150:64:167:received];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=NzrKbS7j;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=b2dZL8mE
X-Spam-Score: -4.31
X-Rspamd-Queue-Id: 034301FD0B

On Wed 03-01-24 18:28:21, Kemeng Shi wrote:
> As 'needed' to trace_ext4_discard_preallocations is always 0 which
> is meaningless. Just remove it.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> Suggested-by: Jan Kara <jack@suse.cz>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mballoc.c           |  5 ++---
>  include/trace/events/ext4.h | 11 ++++-------
>  2 files changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 0e6beb3b4..091a832a8 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -5481,9 +5481,8 @@ void ext4_discard_preallocations(struct inode *inode)
>  	struct rb_node *iter;
>  	int err;
>  
> -	if (!S_ISREG(inode->i_mode)) {
> +	if (!S_ISREG(inode->i_mode))
>  		return;
> -	}
>  
>  	if (EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY)
>  		return;
> @@ -5491,7 +5490,7 @@ void ext4_discard_preallocations(struct inode *inode)
>  	mb_debug(sb, "discard preallocation for inode %lu\n",
>  		 inode->i_ino);
>  	trace_ext4_discard_preallocations(inode,
> -			atomic_read(&ei->i_prealloc_active), 0);
> +			atomic_read(&ei->i_prealloc_active));
>  
>  repeat:
>  	/* first, collect all pa's in the inode */
> diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
> index 65029dfb9..a697f4b77 100644
> --- a/include/trace/events/ext4.h
> +++ b/include/trace/events/ext4.h
> @@ -772,15 +772,14 @@ TRACE_EVENT(ext4_mb_release_group_pa,
>  );
>  
>  TRACE_EVENT(ext4_discard_preallocations,
> -	TP_PROTO(struct inode *inode, unsigned int len, unsigned int needed),
> +	TP_PROTO(struct inode *inode, unsigned int len),
>  
> -	TP_ARGS(inode, len, needed),
> +	TP_ARGS(inode, len),
>  
>  	TP_STRUCT__entry(
>  		__field(	dev_t,		dev		)
>  		__field(	ino_t,		ino		)
>  		__field(	unsigned int,	len		)
> -		__field(	unsigned int,	needed		)
>  
>  	),
>  
> @@ -788,13 +787,11 @@ TRACE_EVENT(ext4_discard_preallocations,
>  		__entry->dev	= inode->i_sb->s_dev;
>  		__entry->ino	= inode->i_ino;
>  		__entry->len	= len;
> -		__entry->needed	= needed;
>  	),
>  
> -	TP_printk("dev %d,%d ino %lu len: %u needed %u",
> +	TP_printk("dev %d,%d ino %lu len: %u",
>  		  MAJOR(__entry->dev), MINOR(__entry->dev),
> -		  (unsigned long) __entry->ino, __entry->len,
> -		  __entry->needed)
> +		  (unsigned long) __entry->ino, __entry->len)
>  );
>  
>  TRACE_EVENT(ext4_mb_discard_preallocations,
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

