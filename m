Return-Path: <linux-ext4+bounces-5904-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FB3A02B26
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Jan 2025 16:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9144A3A6307
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Jan 2025 15:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B34153814;
	Mon,  6 Jan 2025 15:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="M+n3WLPV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OKtf1HJw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Qle35DEN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wOd/kdFG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497D0DF71;
	Mon,  6 Jan 2025 15:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736177993; cv=none; b=noz19rYh8VLM8C5P+Hk9MxRMlDHHquiPFva0lN4wwRgBYYPE/N8EyUQxs6XndvYdghgZdIpZYxXNHZo0b5nrU8x81n60z9IjlZFBU75h8Wx+xY+RzIWpNehzX1IU8YJRX4wxcJ9hZDpR9ckNJNmFOVOlHjznNCwELRScfJ4YSWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736177993; c=relaxed/simple;
	bh=H8SmARXDJEKV2WZqyrmlxQbaEkr1UwPNfqFWBYQAG+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m26JOBxXixdTTN5/XoHYLiY9d1IBjRavFWqdAzPRqXEjIeOJW1jKy2w6Mxzdt3qEcSaNEl7Shd13fo/R7B28CJ86tYlB9q/gdNCcnNhs/8VSLHvysP+WSTsFg/vUVOUbymKXEXg0B7GsPzoHJVSMx9MCVYgm3ktEiI2ciigrrt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=M+n3WLPV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OKtf1HJw; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Qle35DEN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wOd/kdFG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 63FA51F441;
	Mon,  6 Jan 2025 15:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736177989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HhkLhdtd307+c17zSwH1stKe759y7L2sIx3UcZreQ7Q=;
	b=M+n3WLPV5pTIJI1ZNx/tCyszssvYUim2u+5HbCREFz4ggaTSZJVKpdnL6V1Yo9I7zpHLga
	pUnHIa3jQYOYbGvT0xjg28lGUZBvqtIIhnJYbZmA7lJ9h1vG5MYr9mbH7whRwhhWRzBO6W
	YaMUkrgxXrrIqUNly179b8/W8kH/0Z0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736177989;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HhkLhdtd307+c17zSwH1stKe759y7L2sIx3UcZreQ7Q=;
	b=OKtf1HJwd/h1mgXWSJYpkO8jg5SYEXyxrLjQwx1CmNv1RbiV6DSm3GVABTfYp61BPnRU19
	lVly/NmNV6IM52CQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736177987; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HhkLhdtd307+c17zSwH1stKe759y7L2sIx3UcZreQ7Q=;
	b=Qle35DEN/PtKdndAlL2LAPdKsjOwdHXp/E7KRFObIxZrnUSkB25kOKfKr1qeFoqzrdZgOH
	rsLJCJMqk8ig22Z0I93boj7LTE99hAM/B0eZrJvy1ttA8dAiuOaMy2mmAElNUMSne3p+zg
	6mlAjNMzQ+T3UhwiipM01bTUwh+FN9o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736177987;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HhkLhdtd307+c17zSwH1stKe759y7L2sIx3UcZreQ7Q=;
	b=wOd/kdFGANO0epa6vNwlxMNoR1aBebhwGO8r3FWAk68+3FnflwkF7/2e9Bmmdwemp3HvP0
	6tfOP/B5ArRH8OAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 55862139AB;
	Mon,  6 Jan 2025 15:39:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cqXcFEP5e2fuTAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 06 Jan 2025 15:39:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0809CA089C; Mon,  6 Jan 2025 16:39:39 +0100 (CET)
Date: Mon, 6 Jan 2025 16:39:38 +0100
From: Jan Kara <jack@suse.cz>
To: Julian Sun <sunjunchao2870@gmail.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, boyu.mt@taobao.com, 
	tm@tao.ma
Subject: Re: [PATCH 5/7] ext4: Refactor out ext4_da_write_inline_data_begin()
Message-ID: <dwlsyn3d3fji327ocf6mg3p74lfxxqoxlmhffti5lw4bop4ihr@sseuzwi7dhkd>
References: <20241220151625.19769-1-sunjunchao2870@gmail.com>
 <20241220151625.19769-6-sunjunchao2870@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220151625.19769-6-sunjunchao2870@gmail.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[iloc.bh:url,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 20-12-24 23:16:23, Julian Sun wrote:
> Refactor ext4_da_write_inline_data_begin() to simplify its
> implementation by directly invoking ext4_generic_write_inline_data().
> 
> Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
> ---
>  fs/ext4/inline.c | 74 ++----------------------------------------------
>  1 file changed, 2 insertions(+), 72 deletions(-)
> 
> diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
> index 7eaa578e1021..5dd91524b2ca 100644
> --- a/fs/ext4/inline.c
> +++ b/fs/ext4/inline.c
> @@ -979,78 +979,8 @@ int ext4_da_write_inline_data_begin(struct address_space *mapping,
>  				    struct folio **foliop,
>  				    void **fsdata)
>  {

Since there's a single caller of this function, I guess there's no point
for this wrapper now. Just call ext4_generic_write_inline_data() directly
from the call site. Otherwise the patch looks good.

								Honza

> -	int ret;
> -	handle_t *handle;
> -	struct folio *folio;
> -	struct ext4_iloc iloc;
> -	int retries = 0;
> -
> -	ret = ext4_get_inode_loc(inode, &iloc);
> -	if (ret)
> -		return ret;
> -
> -retry_journal:
> -	handle = ext4_journal_start(inode, EXT4_HT_INODE, 1);
> -	if (IS_ERR(handle)) {
> -		ret = PTR_ERR(handle);
> -		goto out;
> -	}
> -
> -	ret = ext4_prepare_inline_data(handle, inode, pos + len);
> -	if (ret && ret != -ENOSPC)
> -		goto out_journal;
> -
> -	if (ret == -ENOSPC) {
> -		ext4_journal_stop(handle);
> -		ret = ext4_da_convert_inline_data_to_extent(mapping,
> -							    inode,
> -							    fsdata);
> -		if (ret == -ENOSPC &&
> -		    ext4_should_retry_alloc(inode->i_sb, &retries))
> -			goto retry_journal;
> -		goto out;
> -	}
> -
> -	/*
> -	 * We cannot recurse into the filesystem as the transaction
> -	 * is already started.
> -	 */
> -	folio = __filemap_get_folio(mapping, 0, FGP_WRITEBEGIN | FGP_NOFS,
> -					mapping_gfp_mask(mapping));
> -	if (IS_ERR(folio)) {
> -		ret = PTR_ERR(folio);
> -		goto out_journal;
> -	}
> -
> -	down_read(&EXT4_I(inode)->xattr_sem);
> -	if (!ext4_has_inline_data(inode)) {
> -		ret = 0;
> -		goto out_release_page;
> -	}
> -
> -	if (!folio_test_uptodate(folio)) {
> -		ret = ext4_read_inline_folio(inode, folio);
> -		if (ret < 0)
> -			goto out_release_page;
> -	}
> -	ret = ext4_journal_get_write_access(handle, inode->i_sb, iloc.bh,
> -					    EXT4_JTR_NONE);
> -	if (ret)
> -		goto out_release_page;
> -
> -	up_read(&EXT4_I(inode)->xattr_sem);
> -	*foliop = folio;
> -	brelse(iloc.bh);
> -	return 1;
> -out_release_page:
> -	up_read(&EXT4_I(inode)->xattr_sem);
> -	folio_unlock(folio);
> -	folio_put(folio);
> -out_journal:
> -	ext4_journal_stop(handle);
> -out:
> -	brelse(iloc.bh);
> -	return ret;
> +	return ext4_generic_write_inline_data(mapping, inode, pos, len,
> +					      foliop, fsdata, true);
>  }
>  
>  #ifdef INLINE_DIR_DEBUG
> -- 
> 2.39.5
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

