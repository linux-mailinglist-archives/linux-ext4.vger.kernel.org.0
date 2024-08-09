Return-Path: <linux-ext4+bounces-3689-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8D994D74D
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Aug 2024 21:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 949722820E4
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Aug 2024 19:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3CD8BFC;
	Fri,  9 Aug 2024 19:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VBpBaEo/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MIAVSLvQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fBap2hUJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="d256SUWz"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F306615FA8A;
	Fri,  9 Aug 2024 19:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723231819; cv=none; b=Jjzu00G1XYaVh74EMOR7rcJDU+GIbldLSu+AtszBIaqTcn8Y/5KgxcWTlSgXe7NcERokxnuzHLd8p9023Hhr0+eUDyy1Fv4/6fpIMhUsmAnOo3/cDnOLtYuOiNBnQ5YjmuFNpus1g4l1oVcabjsY3V3V61xDkCTo/LDCWYLmf20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723231819; c=relaxed/simple;
	bh=Maf1nhtVnPgdWr0nbTaUYarpKWYv4qxD4hSoFxFwLIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tDArWTP0lt3RQ5TT8A7BvG+ygm4SgFOAT6kw+HWLPHlF71BVxMtNE0LNGouYMGMF88sbDtQJiFvM+hTNQA/XTZWIMUANzJLHwPDYu1xoGYdQ64LUe57Z1Nh9wdUslxXltq3cQbUGJXKmlZZF/VIhdr5Ve+UDbzp+tQ1HWqLh9/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VBpBaEo/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MIAVSLvQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fBap2hUJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=d256SUWz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CA7A22200C;
	Fri,  9 Aug 2024 19:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723231815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IJmmDRJLf/n1SB92KJ7qcExGr9LwUWVKk0w4wgR3HR0=;
	b=VBpBaEo/Kt0M8ftQ2Z47/1rAmb7UJYYKXCEPhAq0UO01l1zco/ZTv5wPI8etCe25DEw++9
	u/ZYWxQ6CAXhAlG0LJChynlqcf4676pYm1XFRVQrgMwCh8sFniFbXhJDkl3ceff501upJg
	qdo4JQwXDkkZyc4jLezHP6FY3/7Gfyc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723231815;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IJmmDRJLf/n1SB92KJ7qcExGr9LwUWVKk0w4wgR3HR0=;
	b=MIAVSLvQ1xP+yC4WhIC1pKpBMiJqLcnWdnBhP7P7C+Jd9EGr7qwIGCgKnecZmDhnsgKD0u
	PhEYnoE6OsqsBuCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=fBap2hUJ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=d256SUWz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723231814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IJmmDRJLf/n1SB92KJ7qcExGr9LwUWVKk0w4wgR3HR0=;
	b=fBap2hUJTGO4MnD5VmVyAmW5dypRKhszV922xfcCloQTJroKPqHwaV9lJfhV6ahJGlmx07
	0OkmGut4Zv1QXmoHIzvdfzSD7IgQAKa2YyJ5J7aXvt+G3/MIyDNVakkqGyj6gtTchwqhsJ
	ExjcNtSoXGP40qsTbbA3ZB+JFmUG+6A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723231814;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IJmmDRJLf/n1SB92KJ7qcExGr9LwUWVKk0w4wgR3HR0=;
	b=d256SUWz0crE8WT6JamJV34JcDkw3JsFg56YF3GeXE10ofrEetBrtQGdhZAeoCM9UKNGKa
	SkzW9u/nBs101zDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B7E481379A;
	Fri,  9 Aug 2024 19:30:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ImCXLEZutmZ9YwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 09 Aug 2024 19:30:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 411A6A0841; Fri,  9 Aug 2024 21:30:14 +0200 (CEST)
Date: Fri, 9 Aug 2024 21:30:14 +0200
From: Jan Kara <jack@suse.cz>
To: Zhihao Cheng <chengzhihao@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	chengzhihao1@huawei.com, yi.zhang@huawei.com
Subject: Re: [PATCH] ext4: dax: Fix overflowing extents beyond inode size
 when partially writing
Message-ID: <20240809193014.la7uj6rdxfz5p4sl@quack3>
References: <20240809121532.2105494-1-chengzhihao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809121532.2105494-1-chengzhihao@huaweicloud.com>
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.01 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.com:email];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -1.01
X-Rspamd-Queue-Id: CA7A22200C

On Fri 09-08-24 20:15:32, Zhihao Cheng wrote:
> From: Zhihao Cheng <chengzhihao1@huawei.com>
> 
> The dax_iomap_rw() does two things in each iteration: map written blocks
> and copy user data to blocks. If the process is killed by user(See signal
> handling in dax_iomap_iter()), the copied data will be returned and added
> on inode size, which means that the length of written extents may exceed
> the inode size, then fsck will fail. An example is given as:
> 
> dd if=/dev/urandom of=file bs=4M count=1
>  dax_iomap_rw
>   iomap_iter // round 1
>    ext4_iomap_begin
>     ext4_iomap_alloc // allocate 0~2M extents(written flag)
>   dax_iomap_iter // copy 2M data
>   iomap_iter // round 2
>    iomap_iter_advance
>     iter->pos += iter->processed // iter->pos = 2M
>    ext4_iomap_begin
>     ext4_iomap_alloc // allocate 2~4M extents(written flag)
>   dax_iomap_iter
>    fatal_signal_pending
>   done = iter->pos - iocb->ki_pos // done = 2M
>  ext4_handle_inode_extension
>   ext4_update_inode_size // inode size = 2M
> 
> fsck reports: Inode 13, i_size is 2097152, should be 4194304.  Fix?
> 
> Fix the problem by truncating extents if the written length is smaller
> than expected.
> 
> Fixes: 776722e85d3b ("ext4: DAX iomap write support")
> CC: stable@vger.kernel.org
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=219136
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>

Good catch! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/file.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index c89e434db6b7..be061bb64067 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -334,10 +334,10 @@ static ssize_t ext4_handle_inode_extension(struct inode *inode, loff_t offset,
>   * Clean up the inode after DIO or DAX extending write has completed and the
>   * inode size has been updated using ext4_handle_inode_extension().
>   */
> -static void ext4_inode_extension_cleanup(struct inode *inode, ssize_t count)
> +static void ext4_inode_extension_cleanup(struct inode *inode, bool need_trunc)
>  {
>  	lockdep_assert_held_write(&inode->i_rwsem);
> -	if (count < 0) {
> +	if (need_trunc) {
>  		ext4_truncate_failed_write(inode);
>  		/*
>  		 * If the truncate operation failed early, then the inode may
> @@ -586,7 +586,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  		 * writeback of delalloc blocks.
>  		 */
>  		WARN_ON_ONCE(ret == -EIOCBQUEUED);
> -		ext4_inode_extension_cleanup(inode, ret);
> +		ext4_inode_extension_cleanup(inode, ret < 0);
>  	}
>  
>  out:
> @@ -670,7 +670,7 @@ ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  
>  	if (extend) {
>  		ret = ext4_handle_inode_extension(inode, offset, ret);
> -		ext4_inode_extension_cleanup(inode, ret);
> +		ext4_inode_extension_cleanup(inode, ret < (ssize_t)count);
>  	}
>  out:
>  	inode_unlock(inode);
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

