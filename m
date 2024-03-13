Return-Path: <linux-ext4+bounces-1608-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2844787B0E7
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Mar 2024 20:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 765521F21CF2
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Mar 2024 19:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CAB6BFBA;
	Wed, 13 Mar 2024 18:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Rkzru4SG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SigSCt3t";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Rkzru4SG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SigSCt3t"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63BA6BFB0
	for <linux-ext4@vger.kernel.org>; Wed, 13 Mar 2024 18:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710353688; cv=none; b=Pxm9w5uJ6Yj6pWuLfKeEIhXLNlOBjFp+1EXkcLAAN+IK6wGwCWUT73K4llRWKt1JNDJvLkttT4LqSPyBfN+3eFB+2/1UygB/FwRYgS7kyjJlXZCwFDX4A3ifNz0Mg1qvrsFb4NVf85RZvmbmNLAaWSCtcVPGXXM2xIA+685lYdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710353688; c=relaxed/simple;
	bh=BANLva09jaSGqHimtTGct7WtSecUwJ2DSe7VDtABGxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EypjI/5Xce1aFVFX6NaRAudStDkyfyvlbiAyKajsOtA7pvDo2lW8f1SljSa/3bR9SkiLtxiFHhRpKmwP3TLfX5cZfWQAeZMXDj8ULpPrmjBJOfO4GlSPUY8vqghxblc1gutaQY5HBVaDoQA5Ou+NcP5leqDmoyXpcVN4ijNxdSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Rkzru4SG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SigSCt3t; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Rkzru4SG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SigSCt3t; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BF47421CAB;
	Wed, 13 Mar 2024 18:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710353684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O1E9XCa2aZWVC3y2LL8Tf1FxJVNzZKJ6pqhtOyQ/Atk=;
	b=Rkzru4SGNiWb6kMGz05vnnnZwffvIKkME9Fxw3KFa6CelP2PQe+vus38yvlKvhSi/zxL8O
	muNCAgInIrcN9TDxHSLO8HhqJA2Cj67f8uZ+UcorDIZhkUxH6YgOM4j+8gjOPLbegYHNi4
	Tl934DbyYSbQEDvWel51FZB+G30Aox4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710353684;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O1E9XCa2aZWVC3y2LL8Tf1FxJVNzZKJ6pqhtOyQ/Atk=;
	b=SigSCt3tPZZgDJTGhMABZb7RNb9m15UwJdDd9y5weNlyqibQ/w3IJnwun5TpdZRSTgJ+tp
	/0T0POXnVX63srBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710353684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O1E9XCa2aZWVC3y2LL8Tf1FxJVNzZKJ6pqhtOyQ/Atk=;
	b=Rkzru4SGNiWb6kMGz05vnnnZwffvIKkME9Fxw3KFa6CelP2PQe+vus38yvlKvhSi/zxL8O
	muNCAgInIrcN9TDxHSLO8HhqJA2Cj67f8uZ+UcorDIZhkUxH6YgOM4j+8gjOPLbegYHNi4
	Tl934DbyYSbQEDvWel51FZB+G30Aox4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710353684;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O1E9XCa2aZWVC3y2LL8Tf1FxJVNzZKJ6pqhtOyQ/Atk=;
	b=SigSCt3tPZZgDJTGhMABZb7RNb9m15UwJdDd9y5weNlyqibQ/w3IJnwun5TpdZRSTgJ+tp
	/0T0POXnVX63srBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B10C01397F;
	Wed, 13 Mar 2024 18:14:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0Vw2KxTt8WUBLgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 13 Mar 2024 18:14:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2C2B9A07D9; Wed, 13 Mar 2024 19:14:44 +0100 (CET)
Date: Wed, 13 Mar 2024 19:14:44 +0100
From: Jan Kara <jack@suse.cz>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] ext2: set FMODE_CAN_ODIRECT instead of a dummy
 direct_IO method
Message-ID: <20240313181444.3m2px4k74eq3e27y@quack3>
References: <e5797bb597219a49043e53e4e90aa494b97dc328.1709215665.git.ritesh.list@gmail.com>
 <94f78492f55c3f421359fb6e0d8fab6e79ea17b2.1709215665.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94f78492f55c3f421359fb6e0d8fab6e79ea17b2.1709215665.git.ritesh.list@gmail.com>
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Rkzru4SG;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=SigSCt3t
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.48 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.01)[46.11%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: 0.48
X-Rspamd-Queue-Id: BF47421CAB
X-Spam-Flag: NO

On Thu 29-02-24 19:54:13, Ritesh Harjani (IBM) wrote:
> Since commit a2ad63daa88b ("VFS: add FMODE_CAN_ODIRECT file flag") file
> systems can just set the FMODE_CAN_ODIRECT flag at open time instead of
> wiring up a dummy direct_IO method to indicate support for direct I/O.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Thanks. I'll take this into my tree once the merge window closes.

								Honza

> ---
>  fs/ext2/file.c  | 8 +++++++-
>  fs/ext2/inode.c | 2 --
>  2 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext2/file.c b/fs/ext2/file.c
> index 4ddc36f4dbd4..10b061ac5bc0 100644
> --- a/fs/ext2/file.c
> +++ b/fs/ext2/file.c
> @@ -302,6 +302,12 @@ static ssize_t ext2_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  	return generic_file_write_iter(iocb, from);
>  }
>  
> +static int ext2_file_open(struct inode *inode, struct file *filp)
> +{
> +	filp->f_mode |= FMODE_CAN_ODIRECT;
> +	return dquot_file_open(inode, filp);
> +}
> +
>  const struct file_operations ext2_file_operations = {
>  	.llseek		= generic_file_llseek,
>  	.read_iter	= ext2_file_read_iter,
> @@ -311,7 +317,7 @@ const struct file_operations ext2_file_operations = {
>  	.compat_ioctl	= ext2_compat_ioctl,
>  #endif
>  	.mmap		= ext2_file_mmap,
> -	.open		= dquot_file_open,
> +	.open		= ext2_file_open,
>  	.release	= ext2_release_file,
>  	.fsync		= ext2_fsync,
>  	.get_unmapped_area = thp_get_unmapped_area,
> diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
> index 5a4272b2c6b0..6f719d784eb9 100644
> --- a/fs/ext2/inode.c
> +++ b/fs/ext2/inode.c
> @@ -965,7 +965,6 @@ const struct address_space_operations ext2_aops = {
>  	.write_begin		= ext2_write_begin,
>  	.write_end		= ext2_write_end,
>  	.bmap			= ext2_bmap,
> -	.direct_IO		= noop_direct_IO,
>  	.writepages		= ext2_writepages,
>  	.migrate_folio		= buffer_migrate_folio,
>  	.is_partially_uptodate	= block_is_partially_uptodate,
> @@ -974,7 +973,6 @@ const struct address_space_operations ext2_aops = {
>  
>  static const struct address_space_operations ext2_dax_aops = {
>  	.writepages		= ext2_dax_writepages,
> -	.direct_IO		= noop_direct_IO,
>  	.dirty_folio		= noop_dirty_folio,
>  };
>  
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

