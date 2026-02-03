Return-Path: <linux-ext4+bounces-13508-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sO0GLsHHgWl1JwMAu9opvQ
	(envelope-from <linux-ext4+bounces-13508-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Tue, 03 Feb 2026 11:02:41 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFE5D741F
	for <lists+linux-ext4@lfdr.de>; Tue, 03 Feb 2026 11:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE34C30DDA10
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Feb 2026 09:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB0E399026;
	Tue,  3 Feb 2026 09:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QI0mA7F+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tnQQIRd5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QI0mA7F+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tnQQIRd5"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECE0395DB3
	for <linux-ext4@vger.kernel.org>; Tue,  3 Feb 2026 09:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770112755; cv=none; b=ShMZsqD/pGSm9BpAWkVdGQ9yQnV8NoFrbxL9XvjDnW7g8DZ26XS44VAEmlI5oYBpropDBTcidxWIyWD7Jg7QArxZgJOBkjsml87TwgGzZ5EewG32tJxT7NnEFJB0EdRGEAgCyGk0F9L21gIJRKkneyD9YTw3nSMzuFwqe+T5zp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770112755; c=relaxed/simple;
	bh=JzxGlbAqWJguO/brDfWBiPpZifs77eJ7VtxL7GT6jH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tfq26L4HS+Q1MsEHWqcKKuXIESTGexpwZgZ8mC8WMPAiKY3mMF1MOY2cfrG0UoGFz5v7ZU0jLOE4wSDM91zHCKtTXSemMJ4h9HrBv/8BWU/JK5QHOtgXfVTkCrGZl7BhNK+t+z8XgKHRhOii1EkPY56nAUMo6zxcvPSLeya5I+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QI0mA7F+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tnQQIRd5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QI0mA7F+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tnQQIRd5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 72CAF5BCC3;
	Tue,  3 Feb 2026 09:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770112751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EmU1bMf85qYOnBafAe0nQ9ZZaSRn0hZPJl49++fUnGM=;
	b=QI0mA7F+bHBAK/qqdGj78Hjd9BVT8niQOV8o+YBW5+T91JjpYrjpyZJv7cgyxqp/HInipR
	68ROMzLMAMv+RxXxE0EF3lQJjqg57b5MAKllAafGrfQx7peZ33suwIo4xr/5R0FlqufxQk
	fjVVd+P1tR3rnwfCibZdocyVc6+GSGE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770112751;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EmU1bMf85qYOnBafAe0nQ9ZZaSRn0hZPJl49++fUnGM=;
	b=tnQQIRd5KZAJAETGYi9KOi64CqIh5f3x3HupIwoqFmNx4z3nmz9sMHZoHD4wCu6g38q31v
	kXN5Fd16IQ7VEoCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=QI0mA7F+;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=tnQQIRd5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770112751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EmU1bMf85qYOnBafAe0nQ9ZZaSRn0hZPJl49++fUnGM=;
	b=QI0mA7F+bHBAK/qqdGj78Hjd9BVT8niQOV8o+YBW5+T91JjpYrjpyZJv7cgyxqp/HInipR
	68ROMzLMAMv+RxXxE0EF3lQJjqg57b5MAKllAafGrfQx7peZ33suwIo4xr/5R0FlqufxQk
	fjVVd+P1tR3rnwfCibZdocyVc6+GSGE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770112751;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EmU1bMf85qYOnBafAe0nQ9ZZaSRn0hZPJl49++fUnGM=;
	b=tnQQIRd5KZAJAETGYi9KOi64CqIh5f3x3HupIwoqFmNx4z3nmz9sMHZoHD4wCu6g38q31v
	kXN5Fd16IQ7VEoCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5AFFC3EA62;
	Tue,  3 Feb 2026 09:59:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id idoyFu/GgWlZMQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Feb 2026 09:59:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1D3E6A08F8; Tue,  3 Feb 2026 10:59:07 +0100 (CET)
Date: Tue, 3 Feb 2026 10:59:07 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huawei.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, 
	ojaswin@linux.ibm.com, ritesh.list@gmail.com, hch@infradead.org, djwong@kernel.org, 
	yi.zhang@huaweicloud.com, yizhang089@gmail.com, libaokun1@huawei.com, yangerkun@huawei.com, 
	yukuai@fnnas.com
Subject: Re: [PATCH -next v2 03/22] ext4: only order data when partially
 block truncating down
Message-ID: <jgotl7vzzuzm6dvz5zfgk6haodxvunb4hq556pzh4hqqwvnhxq@lr3jiedhqh7c>
References: <20260203062523.3869120-1-yi.zhang@huawei.com>
 <20260203062523.3869120-4-yi.zhang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203062523.3869120-4-yi.zhang@huawei.com>
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13508-lists,linux-ext4=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.cz:dkim,suse.com:email];
	DMARC_NA(0.00)[suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,linux.ibm.com,gmail.com,infradead.org,kernel.org,huaweicloud.com,huawei.com,fnnas.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1AFE5D741F
X-Rspamd-Action: no action

On Tue 03-02-26 14:25:03, Zhang Yi wrote:
> Currently, __ext4_block_zero_page_range() is called in the following
> four cases to zero out the data in partial blocks:
> 
> 1. Truncate down.
> 2. Truncate up.
> 3. Perform block allocation (e.g., fallocate) or append writes across a
>    range extending beyond the end of the file (EOF).
> 4. Partial block punch hole.
> 
> If the default ordered data mode is used, __ext4_block_zero_page_range()
> will write back the zeroed data to the disk through the order mode after
> zeroing out.
> 
> Among the cases 1,2 and 3 described above, only case 1 actually requires
> this ordered write. Assuming no one intentionally bypasses the file
> system to write directly to the disk. When performing a truncate down
> operation, ensuring that the data beyond the EOF is zeroed out before
> updating i_disksize is sufficient to prevent old data from being exposed
> when the file is later extended. In other words, as long as the on-disk
> data in case 1 can be properly zeroed out, only the data in memory needs
> to be zeroed out in cases 2 and 3, without requiring ordered data.

Hum, I'm not sure this is correct. The tail block of the file is not
necessarily zeroed out beyond EOF (as mmap writes can race with page
writeback and modify the tail block contents beyond EOF before we really
submit it to the device). Thus after this commit if you truncate up, just
zero out the newly exposed contents in the page cache and dirty it, then
the transaction with the i_disksize update commits (I see nothing
preventing it) and then you crash, you can observe file with the new size
but non-zero content in the newly exposed area. Am I missing something?

> Case 4 does not require ordered data because the entire punch hole
> operation does not provide atomicity guarantees. Therefore, it's safe to
> move the ordered data operation from __ext4_block_zero_page_range() to
> ext4_truncate().

I agree hole punching can already expose intermediate results in case of
crash so there removing the ordered mode handling is safe.

								Honza

> It should be noted that after this change, we can only determine whether
> to perform ordered data operations based on whether the target block has
> been zeroed, rather than on the state of the buffer head. Consequently,
> unnecessary ordered data operations may occur when truncating an
> unwritten dirty block. However, this scenario is relatively rare, so the
> overall impact is minimal.
> 
> This is prepared for the conversion to the iomap infrastructure since it
> doesn't use ordered data mode and requires active writeback, which
> reduces the complexity of the conversion.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  fs/ext4/inode.c | 32 +++++++++++++++++++-------------
>  1 file changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index f856ea015263..20b60abcf777 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4106,19 +4106,10 @@ static int __ext4_block_zero_page_range(handle_t *handle,
>  	folio_zero_range(folio, offset, length);
>  	BUFFER_TRACE(bh, "zeroed end of block");
>  
> -	if (ext4_should_journal_data(inode)) {
> +	if (ext4_should_journal_data(inode))
>  		err = ext4_dirty_journalled_data(handle, bh);
> -	} else {
> +	else
>  		mark_buffer_dirty(bh);
> -		/*
> -		 * Only the written block requires ordered data to prevent
> -		 * exposing stale data.
> -		 */
> -		if (!buffer_unwritten(bh) && !buffer_delay(bh) &&
> -		    ext4_should_order_data(inode))
> -			err = ext4_jbd2_inode_add_write(handle, inode, from,
> -					length);
> -	}
>  	if (!err && did_zero)
>  		*did_zero = true;
>  
> @@ -4578,8 +4569,23 @@ int ext4_truncate(struct inode *inode)
>  		goto out_trace;
>  	}
>  
> -	if (inode->i_size & (inode->i_sb->s_blocksize - 1))
> -		ext4_block_truncate_page(handle, mapping, inode->i_size);
> +	if (inode->i_size & (inode->i_sb->s_blocksize - 1)) {
> +		unsigned int zero_len;
> +
> +		zero_len = ext4_block_truncate_page(handle, mapping,
> +						    inode->i_size);
> +		if (zero_len < 0) {
> +			err = zero_len;
> +			goto out_stop;
> +		}
> +		if (zero_len && !IS_DAX(inode) &&
> +		    ext4_should_order_data(inode)) {
> +			err = ext4_jbd2_inode_add_write(handle, inode,
> +					inode->i_size, zero_len);
> +			if (err)
> +				goto out_stop;
> +		}
> +	}
>  
>  	/*
>  	 * We add the inode to the orphan list, so that if this
> -- 
> 2.52.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

