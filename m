Return-Path: <linux-ext4+bounces-4005-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A82C09688F5
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Sep 2024 15:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD7691C22B50
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Sep 2024 13:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C0120127D;
	Mon,  2 Sep 2024 13:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="E+9OiDME";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="N8LbdYF3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c5OmyQrF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YMZvMgBB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A0815E81;
	Mon,  2 Sep 2024 13:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725284091; cv=none; b=gxPvUnjI0m+1DRTYYNMrHz9ft3r8W/FnClJtEvGZDdns7TvAMw4V+jMeVSiR89gKlr/YqW+FdCwzmhHOHDMu3C2rKAZfhKoCzKQp8B+vZuC0gI+WCyRzqugk5MekabFXOm/j371GcMCc+jjnxVQzzs1iJFMRvPqhRiyVcHd11yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725284091; c=relaxed/simple;
	bh=rtgVHAHyztwBeHXMc3TzGqsuYobvtpTSetjX2nY+MPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWrarXU8IdAT2F8skSks0iIFAkZEZDFnHZGSj0HJL2RCx8VpZP+pcacBLNPf8uNRcZDZt6MtMFHYycmQMuaCNrcVIS28qh5YeZTpCh25G1F+3i0U9WX2PG6RDs/pvPBrIARYEP4N9F38iDh0SExpcKoB9ozKuzEw3PngNo7902s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=E+9OiDME; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=N8LbdYF3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c5OmyQrF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YMZvMgBB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D06371FBAD;
	Mon,  2 Sep 2024 13:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725284088; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fCewZ7fxvBwsfhzTIUsYfGaZMDHsUfFzR6NVCEJw5sE=;
	b=E+9OiDMEwA6smP79ED+1iycn8Lkk4rBbGjv+r0Y5qk8ZI4Dmj+U5A/Z+lzl/VRo4kQxXd7
	hSqQ5yPVFLfxhRJ6fEnTjhI6svFx/cuj9IU8AQiFNWAi3lLCIkaoLkNigSrWX0RiddSgbu
	U0WUm+Pt6WxUjFlTy4K+kzFikpAaeck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725284088;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fCewZ7fxvBwsfhzTIUsYfGaZMDHsUfFzR6NVCEJw5sE=;
	b=N8LbdYF31yNsfNHCPW3gilulELY1ja3CW6pVlCFXD8r5sxfaROapyz9X6lPU6qBB8rPyDx
	Kj9Sn4UI+sV9pRBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725284087; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fCewZ7fxvBwsfhzTIUsYfGaZMDHsUfFzR6NVCEJw5sE=;
	b=c5OmyQrF6yWoUPhbtltX4sWZtI0dri35yiFwa9xzbpcO+osumdWYBNOlDroE1IT5S0eLXU
	ilPnYm3bHbGO1Xauz5GPkbVfLPjdwL+1OsU217uLfTDcEd7dYkz+uc5+ZTOyC4MiwAhZYd
	myAgQk0wUyPUVXz1kWSRIeDRfA1uMFs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725284087;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fCewZ7fxvBwsfhzTIUsYfGaZMDHsUfFzR6NVCEJw5sE=;
	b=YMZvMgBBJmucl/oqLUE+iC9tpyJgGR2QnDaIr/0jbIDJCwhMRgaBOsDBT5RRCzyvKw3Vhw
	2XDUNjj7iQ0gGrCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C35B713A7C;
	Mon,  2 Sep 2024 13:34:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OtCvL/e+1WZnJAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 02 Sep 2024 13:34:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6A0DEA0965; Mon,  2 Sep 2024 15:34:32 +0200 (CEST)
Date: Mon, 2 Sep 2024 15:34:32 +0200
From: Jan Kara <jack@suse.cz>
To: zhangshida <starzhangzsd@gmail.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.com,
	ebiggers@kernel.org, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, zhangshida@kylinos.cn,
	Baolin Liu <liubaolin@kylinos.cn>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 3/4] ext4: fix a potential assertion failure due to
 improperly dirtied buffer
Message-ID: <20240902133432.f7rm3dcmd6w5knrh@quack3>
References: <20240830053739.3588573-1-zhangshida@kylinos.cn>
 <20240830053739.3588573-4-zhangshida@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830053739.3588573-4-zhangshida@kylinos.cn>
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
	RCPT_COUNT_SEVEN(0.00)[10];
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

On Fri 30-08-24 13:37:38, zhangshida wrote:
> From: Shida Zhang <zhangshida@kylinos.cn>
> 
> On an old kernel version(4.19, ext3, data=journal, pagesize=64k),
> an assertion failure will occasionally be triggered by the line below:
> -----------
> jbd2_journal_commit_transaction
> {
> ...
> J_ASSERT_BH(bh, !buffer_dirty(bh));
> /*
> * The buffer on BJ_Forget list and not jbddirty means
> ...
> }
> -----------
> 
> The same condition may also be applied to the lattest kernel version.
> 
> When blocksize < pagesize and we truncate a file, there can be buffers in
> the mapping tail page beyond i_size. These buffers will be filed to
> transaction's BJ_Forget list by ext4_journalled_invalidatepage() during
> truncation. When the transaction doing truncate starts committing, we can
> grow the file again. This calls __block_write_begin() which allocates new
> blocks under these buffers in the tail page we go through the branch:
> 
>                         if (buffer_new(bh)) {
>                                 clean_bdev_bh_alias(bh);
>                                 if (folio_test_uptodate(folio)) {
>                                         clear_buffer_new(bh);
>                                         set_buffer_uptodate(bh);
>                                         mark_buffer_dirty(bh);
>                                         continue;
>                                 }
>                                 ...
>                         }
> 
> Hence buffers on BJ_Forget list of the committing transaction get marked
> dirty and this triggers the jbd2 assertion.
> 
> Teach ext4_block_write_begin() to properly handle files with data
> journalling by avoiding dirtying them directly. Instead of
> folio_zero_new_buffers() we use ext4_journalled_zero_new_buffers() which
> takes care of handling journalling. We also don't need to mark new uptodate
> buffers as dirty in ext4_block_write_begin(). That will be either done
> either by block_commit_write() in case of success or by
> folio_zero_new_buffers() in case of failure.
> 
> Reported-by: Baolin Liu <liubaolin@kylinos.cn>
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ext4.h   |  3 ++-
>  fs/ext4/inline.c |  7 ++++---
>  fs/ext4/inode.c  | 42 ++++++++++++++++++++++++++++++++++--------
>  3 files changed, 40 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 5f8257b68190..b653bd423b11 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -3851,7 +3851,8 @@ static inline int ext4_buffer_uptodate(struct buffer_head *bh)
>  	return buffer_uptodate(bh);
>  }
>  
> -extern int ext4_block_write_begin(struct folio *folio, loff_t pos, unsigned len,
> +extern int ext4_block_write_begin(handle_t *handle, struct folio *folio,
> +				  loff_t pos, unsigned len,
>  				  get_block_t *get_block);
>  #endif	/* __KERNEL__ */
>  
> diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
> index 0a1a8431e281..8d5599d5af27 100644
> --- a/fs/ext4/inline.c
> +++ b/fs/ext4/inline.c
> @@ -601,10 +601,11 @@ static int ext4_convert_inline_data_to_extent(struct address_space *mapping,
>  		goto out;
>  
>  	if (ext4_should_dioread_nolock(inode)) {
> -		ret = ext4_block_write_begin(folio, from, to,
> +		ret = ext4_block_write_begin(handle, folio, from, to,
>  					     ext4_get_block_unwritten);
>  	} else
> -		ret = ext4_block_write_begin(folio, from, to, ext4_get_block);
> +		ret = ext4_block_write_begin(handle, folio, from, to,
> +					     ext4_get_block);
>  
>  	if (!ret && ext4_should_journal_data(inode)) {
>  		ret = ext4_walk_page_buffers(handle, inode,
> @@ -856,7 +857,7 @@ static int ext4_da_convert_inline_data_to_extent(struct address_space *mapping,
>  			goto out;
>  	}
>  
> -	ret = ext4_block_write_begin(folio, 0, inline_size,
> +	ret = ext4_block_write_begin(NULL, folio, 0, inline_size,
>  				     ext4_da_get_block_prep);
>  	if (ret) {
>  		up_read(&EXT4_I(inode)->xattr_sem);
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 4964c67e029e..a28f279fd02f 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -49,6 +49,11 @@
>  
>  #include <trace/events/ext4.h>
>  
> +static void ext4_journalled_zero_new_buffers(handle_t *handle,
> +					    struct inode *inode,
> +					    struct folio *folio,
> +					    unsigned from, unsigned to);
> +
>  static __u32 ext4_inode_csum(struct inode *inode, struct ext4_inode *raw,
>  			      struct ext4_inode_info *ei)
>  {
> @@ -1041,7 +1046,8 @@ int do_journal_get_write_access(handle_t *handle, struct inode *inode,
>  	return ret;
>  }
>  
> -int ext4_block_write_begin(struct folio *folio, loff_t pos, unsigned len,
> +int ext4_block_write_begin(handle_t *handle, struct folio *folio,
> +			   loff_t pos, unsigned len,
>  			   get_block_t *get_block)
>  {
>  	unsigned from = pos & (PAGE_SIZE - 1);
> @@ -1055,6 +1061,7 @@ int ext4_block_write_begin(struct folio *folio, loff_t pos, unsigned len,
>  	struct buffer_head *bh, *head, *wait[2];
>  	int nr_wait = 0;
>  	int i;
> +	bool should_journal_data = ext4_should_journal_data(inode);
>  
>  	BUG_ON(!folio_test_locked(folio));
>  	BUG_ON(from > PAGE_SIZE);
> @@ -1084,10 +1091,22 @@ int ext4_block_write_begin(struct folio *folio, loff_t pos, unsigned len,
>  			if (err)
>  				break;
>  			if (buffer_new(bh)) {
> +				/*
> +				 * We may be zeroing partial buffers or all new
> +				 * buffers in case of failure. Prepare JBD2 for
> +				 * that.
> +				 */
> +				if (should_journal_data)
> +					do_journal_get_write_access(handle,
> +								    inode, bh);
>  				if (folio_test_uptodate(folio)) {
> -					clear_buffer_new(bh);
> +					/*
> +					 * Unlike __block_write_begin() we leave
> +					 * dirtying of new uptodate buffers to
> +					 * ->write_end() time or
> +					 * folio_zero_new_buffers().
> +					 */
>  					set_buffer_uptodate(bh);
> -					mark_buffer_dirty(bh);
>  					continue;
>  				}
>  				if (block_end > to || block_start < from)
> @@ -1117,7 +1136,11 @@ int ext4_block_write_begin(struct folio *folio, loff_t pos, unsigned len,
>  			err = -EIO;
>  	}
>  	if (unlikely(err)) {
> -		folio_zero_new_buffers(folio, from, to);
> +		if (should_journal_data)
> +			ext4_journalled_zero_new_buffers(handle, inode, folio,
> +							 from, to);
> +		else
> +			folio_zero_new_buffers(folio, from, to);
>  	} else if (fscrypt_inode_uses_fs_layer_crypto(inode)) {
>  		for (i = 0; i < nr_wait; i++) {
>  			int err2;
> @@ -1215,10 +1238,11 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
>  	folio_wait_stable(folio);
>  
>  	if (ext4_should_dioread_nolock(inode))
> -		ret = ext4_block_write_begin(folio, pos, len,
> +		ret = ext4_block_write_begin(handle, folio, pos, len,
>  					     ext4_get_block_unwritten);
>  	else
> -		ret = ext4_block_write_begin(folio, pos, len, ext4_get_block);
> +		ret = ext4_block_write_begin(handle, folio, pos, len,
> +					     ext4_get_block);
>  	if (!ret && ext4_should_journal_data(inode)) {
>  		ret = ext4_walk_page_buffers(handle, inode,
>  					     folio_buffers(folio), from, to,
> @@ -2951,7 +2975,8 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
>  	if (IS_ERR(folio))
>  		return PTR_ERR(folio);
>  
> -	ret = ext4_block_write_begin(folio, pos, len, ext4_da_get_block_prep);
> +	ret = ext4_block_write_begin(NULL, folio, pos, len,
> +				     ext4_da_get_block_prep);
>  	if (ret < 0) {
>  		folio_unlock(folio);
>  		folio_put(folio);
> @@ -6205,7 +6230,8 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
>  		if (folio_pos(folio) + len > size)
>  			len = size - folio_pos(folio);
>  
> -		err = __block_write_begin(&folio->page, 0, len, ext4_get_block);
> +		err = ext4_block_write_begin(handle, folio, 0, len,
> +					     ext4_get_block);
>  		if (!err) {
>  			ret = VM_FAULT_SIGBUS;
>  			if (ext4_journal_folio_buffers(handle, folio, len))
> -- 
> 2.33.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

