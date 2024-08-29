Return-Path: <linux-ext4+bounces-3966-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC2B964447
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Aug 2024 14:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C64FB20DEF
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Aug 2024 12:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C44196DA2;
	Thu, 29 Aug 2024 12:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LQaadrgm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="27mnFHXy";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OCHuhyrh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pmRrQA/R"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3063C18D63A
	for <linux-ext4@vger.kernel.org>; Thu, 29 Aug 2024 12:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724934101; cv=none; b=KmcYKwGY/j1LbJcy2LzvnCFmddH6LPLOHgMeO1AplOxp8Fe5bn6Fy1rM94SwyjOvUMhDbeXmZdE89/bqKNYMsTVf1fxExvGt9Djw2E2sqs4batL/aUS4aliGx5qSzsPMoq3YxylaqI0bwpaytTvZAiBZpCGnWTrv8mYT7+3IPCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724934101; c=relaxed/simple;
	bh=OVf8NgEsnEu6rW0p6b5jO8Bb77axLuKhnNenIABqZd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pcBgLk0O+Ed28twlvNoTrevje859+DWzKXzWJwVOCiPS59VJcUUXyiWI1rQtU61xv+j01/OKHhW4owSa8ud8wa9+ig8PT/X1ELKmZEEp0aPCY13vf0yhPtaa3hXQsnF0EwttmBuQVE6DwHw/9cJDMMkPHMZOYckqtj8lvvxs6Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LQaadrgm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=27mnFHXy; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OCHuhyrh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pmRrQA/R; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3837821B5A;
	Thu, 29 Aug 2024 12:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724934097; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KasYu8zimpERZQvF5BT79v7pHcrU7tfr9s5XLJDLdeQ=;
	b=LQaadrgmudmbZEH5fCT0RECxjF/HKJgsX4KPzIEGxlccI2CGLvQs1lJ0knKnWr0TYwofla
	ZGvziepYikEz1zEi6QK0rJMrF6JwYlb5pB0zDeuugRyRIQvkTe1Bvodo2DsiW6ZNe+f0h2
	dg2e5Ph/LEo46h7BrMnNBoGhxiSEuIA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724934097;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KasYu8zimpERZQvF5BT79v7pHcrU7tfr9s5XLJDLdeQ=;
	b=27mnFHXyzX6cCwhRMwWBMsj837J4BBxaG4s8M0ONjBq82lRSm+LSytYJaYZQHpQFF28NZg
	9ZD0MmEI7WGNfNCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=OCHuhyrh;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="pmRrQA/R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724934096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KasYu8zimpERZQvF5BT79v7pHcrU7tfr9s5XLJDLdeQ=;
	b=OCHuhyrhd7iCRcBl8Y6SfxHf3sctouJblTk/Rj2YQLKhjx1fELYK/5RjeyPlCLL5bPcHRR
	ElkygxgaRly2J5mwvxq/BEz2J4mekI0Lxe7LwItusiHQPFxf4kffmjasn5PhcJ19RtY+IZ
	ShybrGwNFPMptFkbCbQkrn2A8H7OhV0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724934096;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KasYu8zimpERZQvF5BT79v7pHcrU7tfr9s5XLJDLdeQ=;
	b=pmRrQA/RwRHyd4QMaNaEkTbWTaAO17N2kENmBWRnS8D38EVJZxqIPuye0xVPXFy1TBIOVg
	B+66jt/zbkPT/WBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 29FFE13408;
	Thu, 29 Aug 2024 12:21:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mW47CtBn0GZIKwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 29 Aug 2024 12:21:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D9374A0965; Thu, 29 Aug 2024 14:21:31 +0200 (CEST)
Date: Thu, 29 Aug 2024 14:21:31 +0200
From: Jan Kara <jack@suse.cz>
To: Yang Erkun <yangerkun@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
	linux-ext4@vger.kernel.org, yangerkun@huawei.com
Subject: Re: [PATCH v2] ext4: dax: keep orphan list before truncate overflow
 allocated blocks
Message-ID: <20240829122131.xa44p2nfwqwptmtr@quack3>
References: <20240829110222.126685-1-yangerkun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829110222.126685-1-yangerkun@huaweicloud.com>
X-Rspamd-Queue-Id: 3837821B5A
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,huawei.com:email];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu 29-08-24 19:02:22, Yang Erkun wrote:
> From: yangerkun <yangerkun@huawei.com>
> 
> Any extending write for ext4 requires the inode to be placed on the
> orphan list before the actual write. In addition, the inode can be
> actually removed from the orphan list only after all writes are
> completed. Otherwise we'd leave allocated blocks beyond i_disksize if we
> could not copy all the data into allocated block and e2fsck would
> complain.
> 
> Currently, direct IO and buffered IO comply with this logic(buffered
> IO will truncate all overflow allocated blocks that has not been
> written successfully, and direct IO will truncate all allocated blocks
> when error occurs). However, dax write break this since dax write will
> remove the inode from the orphan list by calling
> ext4_handle_inode_extension unconditionally during extending write.
> 
> We add a argument to help determine does we do a fully write, and for
> the case not fully write, we leave the inode on the orphan list, and the
> latter ext4_inode_extension_cleanup will help us truncate the overflow
> allocated blocks, and then remove the inode from the orphan list.
> 
> Signed-off-by: yangerkun <yangerkun@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/file.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index be061bb64067..f14aed14b9cf 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -306,7 +306,7 @@ static ssize_t ext4_buffered_write_iter(struct kiocb *iocb,
>  }
>  
>  static ssize_t ext4_handle_inode_extension(struct inode *inode, loff_t offset,
> -					   ssize_t count)
> +					   ssize_t written, ssize_t count)
>  {
>  	handle_t *handle;
>  
> @@ -315,7 +315,7 @@ static ssize_t ext4_handle_inode_extension(struct inode *inode, loff_t offset,
>  	if (IS_ERR(handle))
>  		return PTR_ERR(handle);
>  
> -	if (ext4_update_inode_size(inode, offset + count)) {
> +	if (ext4_update_inode_size(inode, offset + written)) {
>  		int ret = ext4_mark_inode_dirty(handle, inode);
>  		if (unlikely(ret)) {
>  			ext4_journal_stop(handle);
> @@ -323,11 +323,11 @@ static ssize_t ext4_handle_inode_extension(struct inode *inode, loff_t offset,
>  		}
>  	}
>  
> -	if (inode->i_nlink)
> +	if ((written == count) && inode->i_nlink)
>  		ext4_orphan_del(handle, inode);
>  	ext4_journal_stop(handle);
>  
> -	return count;
> +	return written;
>  }
>  
>  /*
> @@ -393,7 +393,7 @@ static int ext4_dio_write_end_io(struct kiocb *iocb, ssize_t size,
>  	if (pos + size <= READ_ONCE(EXT4_I(inode)->i_disksize) &&
>  	    pos + size <= i_size_read(inode))
>  		return size;
> -	return ext4_handle_inode_extension(inode, pos, size);
> +	return ext4_handle_inode_extension(inode, pos, size, size);
>  }
>  
>  static const struct iomap_dio_ops ext4_dio_write_ops = {
> @@ -669,7 +669,7 @@ ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  	ret = dax_iomap_rw(iocb, from, &ext4_iomap_ops);
>  
>  	if (extend) {
> -		ret = ext4_handle_inode_extension(inode, offset, ret);
> +		ret = ext4_handle_inode_extension(inode, offset, ret, count);
>  		ext4_inode_extension_cleanup(inode, ret < (ssize_t)count);
>  	}
>  out:
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

