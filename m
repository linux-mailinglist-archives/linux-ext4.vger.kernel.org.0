Return-Path: <linux-ext4+bounces-3963-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E44964026
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Aug 2024 11:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8595E1F261E4
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Aug 2024 09:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12A018D622;
	Thu, 29 Aug 2024 09:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yU5ujVmH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PnHgnoho";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yU5ujVmH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PnHgnoho"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F777189F58;
	Thu, 29 Aug 2024 09:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724923817; cv=none; b=F/nwe05TWAZe6ENRo7/a8lOP1+wOZMXc3hJ/Iq0ILgET8uQRiWvpSvxMgoeRjNsfrHrMjkwcCfmIA0+ym3Y4TMvhJUpapEcLBfMMWwDTQAxojKFI8IlSfE9d3paOTZdv/2gicEtxx1HNOXU7AQRubX/xF8zQcAAOzLmWslavxa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724923817; c=relaxed/simple;
	bh=BtKcAuvPcDwdMi5XKnyaKHLnIln7w5O5GYzMFXaXGX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vBwaccKaYMq+JE0pTTK70nc3oUlkcxAG981CwFFO6vwOg/IMJh/RWwheNTFahH7VViRyrVIio7fvp8Fl4mTu+a+reER66whPqhBq2sfjsDWo7e+l4tAK9bAq6i09QabFyJiv1vsE4PSDVro7Sl1FonIOWJz8gPy45tdS17/ZyL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yU5ujVmH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PnHgnoho; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yU5ujVmH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PnHgnoho; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AEB751FD10;
	Thu, 29 Aug 2024 09:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724923813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Fo6B0lIRPTOp6ALSoLnjxwCjoV66wjkNliJjuaGzXU=;
	b=yU5ujVmHXpyaWxZ24D1bkI4D0AWLkbWp5Nuzz+MZw6B9fNAbS3487kRLhp2t9721KJdJze
	8SkcUGAKpp/poGEo32QkCg+4SKjX2p/3JvsVluADtqu0isgLA5ByqFjyqhIeoPFwqAO8Hl
	fMpAANkqB0fl/2J4OiAILwKykj4eZ/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724923813;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Fo6B0lIRPTOp6ALSoLnjxwCjoV66wjkNliJjuaGzXU=;
	b=PnHgnohosgP8cZn2nwIEQ3SpzkKwtDDip4/hiBfJvwsBA7xGyLqUYyK3cwn0YpGeFVreuA
	X3Bow7NaOut0TsCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=yU5ujVmH;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=PnHgnoho
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724923813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Fo6B0lIRPTOp6ALSoLnjxwCjoV66wjkNliJjuaGzXU=;
	b=yU5ujVmHXpyaWxZ24D1bkI4D0AWLkbWp5Nuzz+MZw6B9fNAbS3487kRLhp2t9721KJdJze
	8SkcUGAKpp/poGEo32QkCg+4SKjX2p/3JvsVluADtqu0isgLA5ByqFjyqhIeoPFwqAO8Hl
	fMpAANkqB0fl/2J4OiAILwKykj4eZ/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724923813;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Fo6B0lIRPTOp6ALSoLnjxwCjoV66wjkNliJjuaGzXU=;
	b=PnHgnohosgP8cZn2nwIEQ3SpzkKwtDDip4/hiBfJvwsBA7xGyLqUYyK3cwn0YpGeFVreuA
	X3Bow7NaOut0TsCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A3F3713408;
	Thu, 29 Aug 2024 09:30:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UVMEKKU/0Ga+cgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 29 Aug 2024 09:30:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 55703A0965; Thu, 29 Aug 2024 11:30:13 +0200 (CEST)
Date: Thu, 29 Aug 2024 11:30:13 +0200
From: Jan Kara <jack@suse.cz>
To: zhangshida <starzhangzsd@gmail.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.com,
	ebiggers@kernel.org, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, zhangshida@kylinos.cn,
	Baolin Liu <liubaolin@kylinos.cn>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 3/3] ext4: fix a potential assertion failure due to
 improperly dirtied buffer
Message-ID: <20240829093013.nxwi4axz3hvelmti@quack3>
References: <20240829085407.3331490-1-zhangshida@kylinos.cn>
 <20240829085407.3331490-4-zhangshida@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829085407.3331490-4-zhangshida@kylinos.cn>
X-Rspamd-Queue-Id: AEB751FD10
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,kylinos.cn:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu 29-08-24 16:54:07, zhangshida wrote:
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

One small comment below but regardless whether you decide to address it or
not, feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> @@ -1083,11 +1090,22 @@ int ext4_block_write_begin(struct folio *folio, loff_t pos, unsigned len,
>  			err = get_block(inode, block, bh, 1);
>  			if (err)
>  				break;
> +			/*
> +			 * We may be zeroing partial buffers or all new
> +			 * buffers in case of failure. Prepare JBD2 for
> +			 * that.
> +			 */
> +			if (should_journal_data)
> +				do_journal_get_write_access(handle, inode, bh);

Thanks for adding comments! I also mentioned this hunk can be moved inside
the if (buffer_new(bh)) check below to make it more obvious that this is
indeed about handling of newly allocated buffers. But this is just a nit
and the comment explains is well enough so I don't insist.

>  			if (buffer_new(bh)) {
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

Thanks!

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

