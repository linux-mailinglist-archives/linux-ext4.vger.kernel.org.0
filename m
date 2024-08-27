Return-Path: <linux-ext4+bounces-3921-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3EB961522
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Aug 2024 19:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7C2D289E5B
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Aug 2024 17:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABF21CF2B8;
	Tue, 27 Aug 2024 17:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="G8nRby7q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zUUXx3j2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pDrsBI/x";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vb9+D3gh"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76111CF2A4
	for <linux-ext4@vger.kernel.org>; Tue, 27 Aug 2024 17:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724778502; cv=none; b=g3Q5oy2L6YZidJe7xLQd4ZH4y9/CCdPWfXrhUeSN5aAN0QBR8WqEsR02UOhr73KDD+1SKs4iFdJlJUVKSu/DqRNa4VJ+zrHpTJxK56M3R49iAZUngT/kKBNdKxB8/AKFXXE9UXKbolrVBkevWxHdsiSVT/reyeoLC3SGpUDAvzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724778502; c=relaxed/simple;
	bh=BYbyi5hQtQXP6EjhJcl5V4f9NkEvUl0qvwGAlF1XojQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bcO6+JUfJty5ki+ab6AWW0ADnW94MCRTJmAEzhp1eq4YkRxMzGXMihiPA5pfOmmW6KNSLi1nKXMidcCwOw+ZwyiQ4ls520dnlEgNa5OQKUxZgErBbVl69nxefSuJRmMrrx68U1K22IZ+cX41gnxSSB/k132L/+x65OADhCrTMqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=G8nRby7q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zUUXx3j2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pDrsBI/x; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vb9+D3gh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CC01C1FB7B;
	Tue, 27 Aug 2024 17:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724778498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ri0EzA4SfeP7fEjbPQYnGJtMQ8yxkajqv84uxnKNnwY=;
	b=G8nRby7qrNkx4z1Ud5R3aEF6LdXIt0dUVJF1dl8F85wMlcO69J+yFONE4f1AfDuG9sOcfC
	ZyfTcKkbJGP1sL89OoZWMt+iEu3lVwfdhlCJt4Kj4F/Rbhhn8IgfBW0rXzYGAW/cD+Uh/V
	Gj4kxdUt+sp1jN++o4H3uL+OItMm5Nw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724778498;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ri0EzA4SfeP7fEjbPQYnGJtMQ8yxkajqv84uxnKNnwY=;
	b=zUUXx3j2JeMOPS9BMPZ89ZEOpMDW70xhMtDKbSerk3qFjJbICVisZYeL8n9JZtr09Vd8+M
	wjYKP0onb7zOLjDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="pDrsBI/x";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=vb9+D3gh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724778497; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ri0EzA4SfeP7fEjbPQYnGJtMQ8yxkajqv84uxnKNnwY=;
	b=pDrsBI/xOblZn/yaoK/kC1mmY9uwmI6ltc302TAc9oF9EEGBLlyYsrQM4rbOhk21++B85J
	QiUAU8s57hhRMjrN0tV69I5R8MLoQh3aj6+Mo6DOmN8BmF4DJgfz+yf30C1UmScpdigJia
	3/JR07EynFExbdatbyM0kTwBQK3EqzM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724778497;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ri0EzA4SfeP7fEjbPQYnGJtMQ8yxkajqv84uxnKNnwY=;
	b=vb9+D3gheNA+7ohXK3xoYZZXLmFi+SLl8E/PwPhswCjRgfXKvIkmejsSBimuE7gakXHVZ8
	5idRSoIuSdbGesBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B38C213724;
	Tue, 27 Aug 2024 17:08:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eXrHKwEIzmZ6RQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 27 Aug 2024 17:08:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 56B54A0968; Tue, 27 Aug 2024 19:08:13 +0200 (CEST)
Date: Tue, 27 Aug 2024 19:08:13 +0200
From: Jan Kara <jack@suse.cz>
To: yangerkun <yangerkun@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
	linux-ext4@vger.kernel.org, yangerkun@huawei.com,
	chengzhihao1@huawei.com
Subject: Re: [PATCH 2/2] ext4: dax: keep orphan list before truncate overflow
 allocated blocks
Message-ID: <20240827170813.twxnsgkqp2vraavz@quack3>
References: <20240820140657.3685287-1-yangerkun@huaweicloud.com>
 <20240820140657.3685287-2-yangerkun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820140657.3685287-2-yangerkun@huaweicloud.com>
X-Rspamd-Queue-Id: CC01C1FB7B
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Tue 20-08-24 22:06:57, yangerkun wrote:
> From: yangerkun <yangerkun@huawei.com>

Thanks for debugging this. Couple of spelling fixes first:
 
> Any extended write for ext4 requires the inode to be placed on the
      ^^^ extending

> orphan list before the actual write. In addition, the inode can be
> actually removed from the orphan list only after all writes are
> completed. Otherwise, those overcommitted blocks (If the allocated
	     ^^ I'd phrase this: Otherwise we'd leave allocated blocks
beyond i_disksize if we could not copy all the data into allocated block
and e2fsck would complain.

> blocks are not written due to certain reasons, the inode size does not
> exceed the offset of these blocks) The leak status is always retained,
> and fsck reports an alarm for this scenario.
> 
> Currently, the dio and buffer IO comply with this logic. However, the
			 ^^ buffered

BTW: The only reason why direct IO doesn't have this problem is because
we don't do short writes for direct IO. We either submit all or we return
error.

> dax write will removed the inode from orphan list since
		  ^^^ remove           ^ the orphan ...

> ext4_handle_inode_extension is unconditionally called during extend
								^^ extending

> write. Fix it with this patch. We open the code from
> ext4_handle_inode_extension since we want to keep the blocks valid
> has been allocated and write success.
> 
> Signed-off-by: yangerkun <yangerkun@huawei.com>
> ---
>  fs/ext4/file.c | 35 +++++++++++++++++++++++++++++++----
>  1 file changed, 31 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index be061bb64067..fd8597eef75e 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -628,11 +628,12 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  static ssize_t
>  ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  {
> -	ssize_t ret;
> +	ssize_t ret, written;
>  	size_t count;
>  	loff_t offset;
>  	handle_t *handle;
>  	bool extend = false;
> +	bool need_trunc = true;
>  	struct inode *inode = file_inode(iocb->ki_filp);
>  
>  	if (iocb->ki_flags & IOCB_NOWAIT) {
> @@ -668,10 +669,36 @@ ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  
>  	ret = dax_iomap_rw(iocb, from, &ext4_iomap_ops);
>  
> -	if (extend) {
> -		ret = ext4_handle_inode_extension(inode, offset, ret);
> -		ext4_inode_extension_cleanup(inode, ret < (ssize_t)count);
> +	if (!extend)
> +		goto out;
> +
> +	if (ret <= 0)
> +		goto err_trunc;
> +
> +	written = ret;
> +	handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
> +	if (IS_ERR(handle)) {
> +		ret = PTR_ERR(handle);
> +		goto err_trunc;
>  	}
> +
> +	if (ext4_update_inode_size(inode, offset + written)) {
> +		ret = ext4_mark_inode_dirty(handle, inode);
> +		if (unlikely(ret)) {
> +			ext4_journal_stop(handle);
> +			goto err_trunc;
> +		}
> +	}
> +
> +	if (written == count)
> +		need_trunc = false;
> +
> +	if (inode->i_nlink)
> +		ext4_orphan_del(handle, inode);

Why did you keep ext4_orphan_del() here? I thought the whole point of this
patch is to avoid it? In fact, rather then opencoding
ext4_handle_inode_extension() I'd add argument to
ext4_handle_inode_extension() like:

ext4_handle_inode_extension(inode, pos, written, allocated)

and remove inode from the orphan list only if written == allocated. The
call site in ext4_dio_write_end_io() would call:

	/*
	 * For DIO we don't do partial writes so we must have submitted all
	 * that was allocated.
	 */
	return ext4_handle_inode_extension(inode, pos, size, size);

and the call site in ext4_dax_write_iter() would call:

	ret = ext4_handle_inode_extension(inode, offset, ret, count);

What do you think?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

