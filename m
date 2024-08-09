Return-Path: <linux-ext4+bounces-3688-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BFD94D538
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Aug 2024 19:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCF2E280EA8
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Aug 2024 17:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBB03AC36;
	Fri,  9 Aug 2024 17:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HQ8GrdcW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zpNT+khR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HQ8GrdcW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zpNT+khR"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2241A38384;
	Fri,  9 Aug 2024 17:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723223448; cv=none; b=G2M+ArZNzxLqhxYu79kzPUrPkNwT2yETDKb8pW0N1RtnKfOQtpsTLxJro4gMjCK/joyyu+WGRGxREbbAC1QNfaQ6qUz3kgfrF5poHsDOD49wrObTejvDIZqpTt+3GIPrV3XbUImyLhhkv3vLygZrRkc0FZIlNWWB73K2QoqeuGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723223448; c=relaxed/simple;
	bh=F2FcKpXEziOBXiJntVPncRWvB08MTzNoeBi6qdaveEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gLMPo4uiWuj25gXouYT6nK5CiEkjmKhjzVrWDqnjIkFOJyT5czvWfYUdEzZYEcLxUWnTdkHFbxogv9y0nFaOn3FsmjiC5SSDyYeTyLovagKzfXU+RuxQvCAerGLoYGzGfdk0GJRCc+htMtxAs7mT2lOJZcb9Xk410TadUam4T0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HQ8GrdcW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zpNT+khR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HQ8GrdcW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zpNT+khR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3142321FE4;
	Fri,  9 Aug 2024 17:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723223444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gkf8SBR7lhsed/B/UVyuxGuTKu2GCyr0yzZwpyJwaM8=;
	b=HQ8GrdcWQ+4Lsj1SS5M3Bs40QOI4iPHd7QKnMJ3QuRQVhA8//p41+el+VZRoYSO0s7dgS/
	cRu20KLlm+eJ6VHpbJ2jWHcco7vkInjRrvPQ3q3GcxVrWXhlcO1ex6KRum93fDqLo95Diz
	cv6yGwl4iWkZG0zzCr3iTDmRD9wOcsk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723223444;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gkf8SBR7lhsed/B/UVyuxGuTKu2GCyr0yzZwpyJwaM8=;
	b=zpNT+khR8ncrP44Z6VWv2lNCy+qwFb7wRT0yrn+JA5dVxOoy+5d4WpbyniYn0WYDQFyD0F
	o8C6PMhxtdztVIBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=HQ8GrdcW;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=zpNT+khR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723223444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gkf8SBR7lhsed/B/UVyuxGuTKu2GCyr0yzZwpyJwaM8=;
	b=HQ8GrdcWQ+4Lsj1SS5M3Bs40QOI4iPHd7QKnMJ3QuRQVhA8//p41+el+VZRoYSO0s7dgS/
	cRu20KLlm+eJ6VHpbJ2jWHcco7vkInjRrvPQ3q3GcxVrWXhlcO1ex6KRum93fDqLo95Diz
	cv6yGwl4iWkZG0zzCr3iTDmRD9wOcsk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723223444;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gkf8SBR7lhsed/B/UVyuxGuTKu2GCyr0yzZwpyJwaM8=;
	b=zpNT+khR8ncrP44Z6VWv2lNCy+qwFb7wRT0yrn+JA5dVxOoy+5d4WpbyniYn0WYDQFyD0F
	o8C6PMhxtdztVIBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 25AFC1379A;
	Fri,  9 Aug 2024 17:10:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id P3AxCZRNtmboQAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 09 Aug 2024 17:10:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D9050A084C; Fri,  9 Aug 2024 19:10:39 +0200 (CEST)
Date: Fri, 9 Aug 2024 19:10:39 +0200
From: Jan Kara <jack@suse.cz>
To: zhangshida <starzhangzsd@gmail.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.com,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	zhangshida@kylinos.cn, Baolin Liu <liubaolin@kylinos.cn>,
	Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH V2 1/2] ext4: fix a potential assertion failure due
 to improperly dirtied buffer
Message-ID: <20240809171039.nnl4bb5oe2azcggh@quack3>
References: <20240809064606.3490994-1-zhangshida@kylinos.cn>
 <20240809064606.3490994-2-zhangshida@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809064606.3490994-2-zhangshida@kylinos.cn>
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 3142321FE4
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spam-Flag: NO

On Fri 09-08-24 14:46:05, zhangshida wrote:
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

Maybe let me shorten the following part of the changelog a bit:

When blocksize < pagesize and we truncate a file, there can be buffers in
the mapping tail page beyond i_size. These buffers will be filed to
transaction's BJ_Forget list by ext4_journalled_invalidatepage() during
truncation. When the transaction doing truncate starts committing, we can
grow the file again. This calls __block_write_begin() which allocates new
blocks under these buffers in the tail page we go through the branch:

                        if (buffer_new(bh)) {
                                clean_bdev_bh_alias(bh);
                                if (folio_test_uptodate(folio)) {
                                        clear_buffer_new(bh);
                                        set_buffer_uptodate(bh);
                                        mark_buffer_dirty(bh);
                                        continue;
                                }
				...
			}

Hence buffers on BJ_Forget list of the committing transaction get marked
dirty and this triggers the jbd2 assertion.

Teach ext4_block_write_begin() to properly handle files with data
journalling by avoiding dirtying them directly. Instead of
folio_zero_new_buffers() we use ext4_journalled_zero_new_buffers() which
takes care of handling journalling. We also don't need to mark new uptodate
buffers as dirty in ext4_block_write_begin(). That will be either done
either by block_commit_write() in case of success or by
folio_zero_new_buffers() in case of failure.

> Reported-by: Baolin Liu <liubaolin@kylinos.cn>
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> ---
>  fs/ext4/inode.c | 30 ++++++++++++++++++++++++------
>  1 file changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 941c1c0d5c6e..de46c0a6842a 100644
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
> @@ -1042,7 +1047,8 @@ int do_journal_get_write_access(handle_t *handle, struct inode *inode,
>  }
>  
>  #ifdef CONFIG_FS_ENCRYPTION
> -static int ext4_block_write_begin(struct folio *folio, loff_t pos, unsigned len,
> +static int ext4_block_write_begin(handle_t *handle, struct folio *folio,
> +				  loff_t pos, unsigned len,
>  				  get_block_t *get_block)
>  {
>  	unsigned from = pos & (PAGE_SIZE - 1);
> @@ -1056,6 +1062,7 @@ static int ext4_block_write_begin(struct folio *folio, loff_t pos, unsigned len,
>  	struct buffer_head *bh, *head, *wait[2];
>  	int nr_wait = 0;
>  	int i;
> +	bool should_journal_data = ext4_should_journal_data(inode);
>  
>  	BUG_ON(!folio_test_locked(folio));
>  	BUG_ON(from > PAGE_SIZE);
> @@ -1084,11 +1091,16 @@ static int ext4_block_write_begin(struct folio *folio, loff_t pos, unsigned len,
>  			err = get_block(inode, block, bh, 1);
>  			if (err)
>  				break;
> +			if (should_journal_data)
> +				do_journal_get_write_access(handle, inode, bh);
>  			if (buffer_new(bh)) {
>  				if (folio_test_uptodate(folio)) {
>  					clear_buffer_new(bh);
>  					set_buffer_uptodate(bh);
> -					mark_buffer_dirty(bh);
> +					if (should_journal_data)
> +						ext4_dirty_journalled_data(handle, bh);
> +					else
> +						mark_buffer_dirty(bh);

This hunk is not needed. We can just do:

				if (folio_test_uptodate(folio)) {
-					clear_buffer_new(bh);
					set_buffer_uptodate(bh);
-					mark_buffer_dirty(bh);
					continue;
				}

>  					continue;
>  				}
>  				if (block_end > to || block_start < from)
> @@ -1118,7 +1130,11 @@ static int ext4_block_write_begin(struct folio *folio, loff_t pos, unsigned len,
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

This looks good.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

