Return-Path: <linux-ext4+bounces-3940-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBA4962645
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Aug 2024 13:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF247B215A9
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Aug 2024 11:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2DA17166E;
	Wed, 28 Aug 2024 11:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Do1vTlq4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cdx9s7VF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Do1vTlq4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cdx9s7VF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA79166F37;
	Wed, 28 Aug 2024 11:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724845518; cv=none; b=Dm8DTJ0mAV1xha0cl1SawzIjl+77NaoQfW1gXMnBZFYidwFY8tPi97mMX3zY7HiYYgGN4kVjd0Xy7lSh+ahz3Y4kbIClB2sHEIqynnuY5fLEPIUmosJPJ+NENLRFmysYYv7LOymC+iiX8WQcNgWA7KRwab4N5Um7tXWx90NmSVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724845518; c=relaxed/simple;
	bh=D1sUvkcv4jwAVZu0sYGCE612fGA8INtsVk2b2+YEUEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOor/x5V4olJ5vG+YI7Gdgn+WZcIV4Uoa//RCsHcTgurfivWtMdH1PjhUIs4aFSuTumXFDyEdNtg8D3rRNA2te6/rv9cC9B5F7BFSqwuH8ax2nktIHi2pTTN6cyJz5388JWG6MHqwvpULYlqnz2Ux9rG+B/bQI9bLqpo2jqqGjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Do1vTlq4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cdx9s7VF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Do1vTlq4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cdx9s7VF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A56CE21CCD;
	Wed, 28 Aug 2024 11:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724845514; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AXRIX8aCOJfhbfuLXD/zzxk32Vs1sSYZ9hNbcOX+qYU=;
	b=Do1vTlq4vNjkP8Q5PLqG15bjZA1a93xX10CBNXzXIlnwY8P8TpWRqG55axLW4oqaKEDHuE
	FeoGeKSV566GeFHmj4+r8gZxGpJ7wnRoZ8OQFUKlhiQC16CoCDxLfPaYIEV7lvY6NvKHaC
	0Ui84PhpPfw6jiMvbRUNu+lRInpHgdI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724845514;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AXRIX8aCOJfhbfuLXD/zzxk32Vs1sSYZ9hNbcOX+qYU=;
	b=cdx9s7VFX9DfVZUxMabIzk6xmdT8Ig9mpWUrj9pU51QEagf3pIkpxikjG3wdigmTxo/uYj
	AsXRB3rDTelx4OCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Do1vTlq4;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=cdx9s7VF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724845514; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AXRIX8aCOJfhbfuLXD/zzxk32Vs1sSYZ9hNbcOX+qYU=;
	b=Do1vTlq4vNjkP8Q5PLqG15bjZA1a93xX10CBNXzXIlnwY8P8TpWRqG55axLW4oqaKEDHuE
	FeoGeKSV566GeFHmj4+r8gZxGpJ7wnRoZ8OQFUKlhiQC16CoCDxLfPaYIEV7lvY6NvKHaC
	0Ui84PhpPfw6jiMvbRUNu+lRInpHgdI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724845514;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AXRIX8aCOJfhbfuLXD/zzxk32Vs1sSYZ9hNbcOX+qYU=;
	b=cdx9s7VFX9DfVZUxMabIzk6xmdT8Ig9mpWUrj9pU51QEagf3pIkpxikjG3wdigmTxo/uYj
	AsXRB3rDTelx4OCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 872891398F;
	Wed, 28 Aug 2024 11:45:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +F/2IMoNz2agBAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 28 Aug 2024 11:45:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7E1F8A0968; Wed, 28 Aug 2024 13:45:13 +0200 (CEST)
Date: Wed, 28 Aug 2024 13:45:13 +0200
From: Jan Kara <jack@suse.cz>
To: zhangshida <starzhangzsd@gmail.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.com,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	zhangshida@kylinos.cn, Baolin Liu <liubaolin@kylinos.cn>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 2/2] ext4: fix a potential assertion failure due to
 improperly dirtied buffer
Message-ID: <20240828114513.bzccvcalexwge4d7@quack3>
References: <20240823013329.1996741-1-zhangshida@kylinos.cn>
 <20240823013329.1996741-3-zhangshida@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823013329.1996741-3-zhangshida@kylinos.cn>
X-Rspamd-Queue-Id: A56CE21CCD
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Fri 23-08-24 09:33:29, zhangshida wrote:
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
					     ^^ and we...

 
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

Looks mostly good. Just three small comments:

> @@ -1083,11 +1090,11 @@ int ext4_block_write_begin(struct folio *folio, loff_t pos, unsigned len,
>  			err = get_block(inode, block, bh, 1);
>  			if (err)
>  				break;


> +			if (should_journal_data)
> +				do_journal_get_write_access(handle, inode, bh);

I'd move this inside the buffer_new() branch and add before it a comment:
			/*
			 * We may be zeroing partial buffers or all new
			 * buffers in case of failure. Prepare JBD2 for
			 * that.
			 */

>  			if (buffer_new(bh)) {
>  				if (folio_test_uptodate(folio)) {
> -					clear_buffer_new(bh);
>  					set_buffer_uptodate(bh);
> -					mark_buffer_dirty(bh);

Here I'd add comment:
				/*
				 * Unlike __block_write_begin() we leave
				 * dirtying of new uptodate buffers to
				 * ->write_end() time or
				 * folio_zero_new_buffers().
				 */

> @@ -1117,7 +1124,11 @@ int ext4_block_write_begin(struct folio *folio, loff_t pos, unsigned len,
>  			err = -EIO;
>  	}
>  	if (unlikely(err)) {
> -		folio_zero_new_buffers(folio, from, to);
> +		if (should_journal_data)
> +			ext4_journalled_zero_new_buffers(handle, inode, folio,
> +							 from, to);

I've realized there's a small bug in ext4_journalled_zero_new_buffers()
that it calls write_end_fn() only if it zeroed a buffer. But for new
uptodate buffers we also need to call write_end_fn() to persist the
uptodate content (similarly as folio_zero_new_buffers() does it). So we
need another preparatory patch moving write_end_fn() in
ext4_journalled_zero_new_buffers() to be called also for uptodate pages.

> +		else
> +			folio_zero_new_buffers(folio, from, to);
>  	}
>  #ifdef CONFIG_FS_ENCRYPTION
>  	else if (fscrypt_inode_uses_fs_layer_crypto(inode)) {

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

