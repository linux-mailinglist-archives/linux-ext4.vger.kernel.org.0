Return-Path: <linux-ext4+bounces-5955-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9312CA03D15
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jan 2025 11:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0083B1886481
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jan 2025 10:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBDF1DE4F1;
	Tue,  7 Jan 2025 10:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1IODkVCM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zw9s8kQc";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1IODkVCM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zw9s8kQc"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8EE1DACA7
	for <linux-ext4@vger.kernel.org>; Tue,  7 Jan 2025 10:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736247310; cv=none; b=efzmHDwf5RG+y1+PVyR6SRq5nM4PCfijkUWmKCd6ZumGF7YqT6OKPpsC4B05NjenCItw974OQD9ynFdIefKtmGvnHCRwcaok71hMdBhmsvrfrSeugQ+2N3dSWQ0GLvPDNJA5K3i6eV5TfcfPZgjVefaT+S5NK5owrApxWO9a66M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736247310; c=relaxed/simple;
	bh=x4O75UOEa+b4wZiIMsrPHEy2SwbmNC+1F9clEFbaRQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NAdFNZlRFDqTNOyA+XEARxQxTHlOrf+Xn/RG1Bir1tsa/BBtHWFdgI5MXvWSt3gg1gGtnZ8e1RZSG16jx2tkvGeAffzyFM4UHFs5WSagexEcsYBKWn3bgFeghOeDxG+agpLb4C84jZn/qS8HK8zVhJ6e6CAvfd+rnqwfX7sylM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1IODkVCM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zw9s8kQc; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1IODkVCM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zw9s8kQc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 24F9721157;
	Tue,  7 Jan 2025 10:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736247303; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UsgS8B/0UfMHcMLcrSysf+RmqOq7WXc/jLTf40BgdL0=;
	b=1IODkVCM4VdwldA+qdsvhQH9HcSaUAQafY53qA3pbuEy6j3ZMf1JM6P4xGx73xDUGP1pLL
	CvpQoLdt9eY1MnMONLW7nm5fahUbYzKDUeUN2NHMnhooof+9ttUVsmafQLYl9EkP5bwUt6
	thqhLOzZ5W6OKdlRQOo8CPxlUbLogYU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736247303;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UsgS8B/0UfMHcMLcrSysf+RmqOq7WXc/jLTf40BgdL0=;
	b=zw9s8kQc6R22VR3EfIat7CrPPRM/m8pwGhLG4lPD3PwWVxCedtUimtrMsiR7pkAelUmeFN
	l7uInnoW64YxNqDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=1IODkVCM;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=zw9s8kQc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736247303; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UsgS8B/0UfMHcMLcrSysf+RmqOq7WXc/jLTf40BgdL0=;
	b=1IODkVCM4VdwldA+qdsvhQH9HcSaUAQafY53qA3pbuEy6j3ZMf1JM6P4xGx73xDUGP1pLL
	CvpQoLdt9eY1MnMONLW7nm5fahUbYzKDUeUN2NHMnhooof+9ttUVsmafQLYl9EkP5bwUt6
	thqhLOzZ5W6OKdlRQOo8CPxlUbLogYU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736247303;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UsgS8B/0UfMHcMLcrSysf+RmqOq7WXc/jLTf40BgdL0=;
	b=zw9s8kQc6R22VR3EfIat7CrPPRM/m8pwGhLG4lPD3PwWVxCedtUimtrMsiR7pkAelUmeFN
	l7uInnoW64YxNqDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 17D3813763;
	Tue,  7 Jan 2025 10:55:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dhbPBQcIfWcGbwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 07 Jan 2025 10:55:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BD122A09E0; Tue,  7 Jan 2025 11:54:58 +0100 (CET)
Date: Tue, 7 Jan 2025 11:54:58 +0100
From: Jan Kara <jack@suse.cz>
To: Julian Sun <sunjunchao2870@gmail.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz
Subject: Re: [PATCH v2 4/5] ext4: Replace ext4_da_write_inline_data_begin()
 with ext4_generic_write_inline_data().
Message-ID: <xgojnbtlup4oubcgkpkwtcoga4cpicqfrxo2oybldfswi3bdg6@avth2jykicg7>
References: <20250107044702.1836852-1-sunjunchao2870@gmail.com>
 <20250107045710.1837756-1-sunjunchao2870@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107045710.1837756-1-sunjunchao2870@gmail.com>
X-Rspamd-Queue-Id: 24F9721157
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	URIBL_BLOCKED(0.00)[iloc.bh:url,suse.com:email,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Tue 07-01-25 12:57:10, Julian Sun wrote:
> Replace the call to ext4_da_write_inline_data_begin() with
> ext4_generic_write_inline_data(), and delete the 
> ext4_da_write_inline_data_begin().
> 
> Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ext4.h   | 10 ++---
>  fs/ext4/inline.c | 98 +++++-------------------------------------------
>  fs/ext4/inode.c  |  4 +-
>  3 files changed, 16 insertions(+), 96 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 44b0d418143c..78dd3408ff39 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -3569,11 +3569,11 @@ extern int ext4_try_to_write_inline_data(struct address_space *mapping,
>  					 struct folio **foliop);
>  int ext4_write_inline_data_end(struct inode *inode, loff_t pos, unsigned len,
>  			       unsigned copied, struct folio *folio);
> -extern int ext4_da_write_inline_data_begin(struct address_space *mapping,
> -					   struct inode *inode,
> -					   loff_t pos, unsigned len,
> -					   struct folio **foliop,
> -					   void **fsdata);
> +extern int ext4_generic_write_inline_data(struct address_space *mapping,
> +					  struct inode *inode,
> +					  loff_t pos, unsigned len,
> +					  struct folio **foliop,
> +					  void **fsdata, bool da);
>  extern int ext4_try_add_inline_entry(handle_t *handle,
>  				     struct ext4_filename *fname,
>  				     struct inode *dir, struct inode *inode);
> diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
> index 3e103e003afb..58d8fcfbecba 100644
> --- a/fs/ext4/inline.c
> +++ b/fs/ext4/inline.c
> @@ -657,7 +657,15 @@ static int ext4_convert_inline_data_to_extent(struct address_space *mapping,
>  	return ret;
>  }
>  
> -static int ext4_generic_write_inline_data(struct address_space *mapping,
> +/*
> + * Prepare the write for the inline data.
> + * If the data can be written into the inode, we just read
> + * the page and make it uptodate, and start the journal.
> + * Otherwise read the page, makes it dirty so that it can be
> + * handle in writepages(the i_disksize update is left to the
> + * normal ext4_da_write_end).
> + */
> +int ext4_generic_write_inline_data(struct address_space *mapping,
>  					  struct inode *inode,
>  					  loff_t pos, unsigned len,
>  					  struct folio **foliop,
> @@ -967,94 +975,6 @@ static int ext4_da_convert_inline_data_to_extent(struct address_space *mapping,
>  	return ret;
>  }
>  
> -/*
> - * Prepare the write for the inline data.
> - * If the data can be written into the inode, we just read
> - * the page and make it uptodate, and start the journal.
> - * Otherwise read the page, makes it dirty so that it can be
> - * handle in writepages(the i_disksize update is left to the
> - * normal ext4_da_write_end).
> - */
> -int ext4_da_write_inline_data_begin(struct address_space *mapping,
> -				    struct inode *inode,
> -				    loff_t pos, unsigned len,
> -				    struct folio **foliop,
> -				    void **fsdata)
> -{
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
> -}
> -
>  #ifdef INLINE_DIR_DEBUG
>  void ext4_show_inline_dir(struct inode *dir, struct buffer_head *bh,
>  			  void *inline_start, int inline_size)
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 54bdd4884fe6..24a3b0ff4c8a 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -2918,8 +2918,8 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
>  	trace_ext4_da_write_begin(inode, pos, len);
>  
>  	if (ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA)) {
> -		ret = ext4_da_write_inline_data_begin(mapping, inode, pos, len,
> -						      foliop, fsdata);
> +		ret = ext4_generic_write_inline_data(mapping, inode, pos, len,
> +						     foliop, fsdata, true);
>  		if (ret < 0)
>  			return ret;
>  		if (ret == 1)
> -- 
> 2.39.5
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

