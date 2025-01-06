Return-Path: <linux-ext4+bounces-5905-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A439DA02B40
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Jan 2025 16:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C0D93A6231
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Jan 2025 15:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519701DB360;
	Mon,  6 Jan 2025 15:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2w4h4usE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="auQi/9Ag";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QhopUbLX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eh2iL1By"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3311C5F11;
	Mon,  6 Jan 2025 15:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736178042; cv=none; b=H2wOd/xr0UA2SA0S5GMoMgH71Hj/F3n2aRrl1/6ZzEubThYbeNTZ9/VnsH/5YH6DdsMHY0rJfK+K/WzMCGP+hr236G22OGb6ZasGNTuVBjZ7iExMf8/dGG/v9yFvh2wgH3SHByZnJBfgexGcLLsz+0g8zEMbV32sBw19XX8/+5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736178042; c=relaxed/simple;
	bh=tbb/aJsYOHhQTGONST88i+GNb73CgRVrswCJeShirOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGc17A5AUxQljjxHuqB+J+YbIeh0F9n3q2ZiIc4fs+cFX9BX3N7yQjBzxm1odTOMNz6cUQkXKDJpvQyieL9l1wq8X6/liHk60XWwIiegsGKCpYQ+3XPXmlpSjGj8mfAXOQctgPMQHMzn173HGAuNauSD3tOdxSSFXQW/V9cNdIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2w4h4usE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=auQi/9Ag; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QhopUbLX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eh2iL1By; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B73F221165;
	Mon,  6 Jan 2025 15:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736178039; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nopi+XkmTGRICSWboPG+f3YnUa2mrRVgLscdSGzOQwc=;
	b=2w4h4usECkHqkqky7OppXoCC7n1/xFkT+sSVg9dyLfpYUQ7iAntBhnpmEgk03RmfGl3TZb
	k7c72mLaMj0bbCnn0aR0UO93ikPsM4wU5o14m/b+mU9clYluD6AtcTBz30anTvaDEHbEsq
	AXzlpyAIbXZ3OhvUvZIX/tBpwP/7my0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736178039;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nopi+XkmTGRICSWboPG+f3YnUa2mrRVgLscdSGzOQwc=;
	b=auQi/9Ag5itmkrYQrMwWnSRl7UbqC0lPmcXSpyn005/UNiu8kzcW19r8Ao89yfkESfLO8k
	5qhFFgCL9xCQf/CA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=QhopUbLX;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=eh2iL1By
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736178037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nopi+XkmTGRICSWboPG+f3YnUa2mrRVgLscdSGzOQwc=;
	b=QhopUbLXm2DwMo4nG/fhYUHp7Be0Qy2KdcyK7nNqoukp7Y8+k8kLXRCNJiHP93I1KumQr7
	VqVDhdXSBb6uvuZL9krdkZYfM65tPWEJ/6Ms/Y1NvIt7CgPWAgXWyvqqvjYsL3StmNtU1s
	gLnsaphBa2bL2G1RtX6b5rX1jcyA9D8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736178037;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nopi+XkmTGRICSWboPG+f3YnUa2mrRVgLscdSGzOQwc=;
	b=eh2iL1By6ouXUIEJY8ez7lJnsqneQ10MG6kNpt0wLMjeSt9lt/YRFKquEyHCp5KSXs1V6N
	IZHOxLDyp5/bBuCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A5F95139AB;
	Mon,  6 Jan 2025 15:40:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2j6FKHX5e2ctTQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 06 Jan 2025 15:40:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 67BFFA089C; Mon,  6 Jan 2025 16:40:33 +0100 (CET)
Date: Mon, 6 Jan 2025 16:40:33 +0100
From: Jan Kara <jack@suse.cz>
To: Julian Sun <sunjunchao2870@gmail.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, boyu.mt@taobao.com, 
	tm@tao.ma
Subject: Re: [PATCH 6/7] ext4: Refactor out ext4_try_to_write_inline_data()
Message-ID: <7e5c2elo5gwxnolzjbukwwka7zdvdwdsl54utqs75nefvxpwrn@ffnsmj7m62ty>
References: <20241220151625.19769-1-sunjunchao2870@gmail.com>
 <20241220151625.19769-7-sunjunchao2870@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220151625.19769-7-sunjunchao2870@gmail.com>
X-Rspamd-Queue-Id: B73F221165
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iloc.bh:url,suse.com:email,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Fri 20-12-24 23:16:24, Julian Sun wrote:
> Refactor ext4_try_to_write_inline_data() to simplify its
> implementation by directly invoking ext4_generic_write_inline_data().
> 
> Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inline.c | 77 ++----------------------------------------------
>  1 file changed, 3 insertions(+), 74 deletions(-)
> 
> diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
> index 5dd91524b2ca..2abb35f1555d 100644
> --- a/fs/ext4/inline.c
> +++ b/fs/ext4/inline.c
> @@ -747,81 +747,10 @@ int ext4_try_to_write_inline_data(struct address_space *mapping,
>  				  loff_t pos, unsigned len,
>  				  struct folio **foliop)
>  {
> -	int ret;
> -	handle_t *handle;
> -	struct folio *folio;
> -	struct ext4_iloc iloc;
> -
>  	if (pos + len > ext4_get_max_inline_size(inode))
> -		goto convert;
> -
> -	ret = ext4_get_inode_loc(inode, &iloc);
> -	if (ret)
> -		return ret;
> -
> -	/*
> -	 * The possible write could happen in the inode,
> -	 * so try to reserve the space in inode first.
> -	 */
> -	handle = ext4_journal_start(inode, EXT4_HT_INODE, 1);
> -	if (IS_ERR(handle)) {
> -		ret = PTR_ERR(handle);
> -		handle = NULL;
> -		goto out;
> -	}
> -
> -	ret = ext4_prepare_inline_data(handle, inode, pos + len);
> -	if (ret && ret != -ENOSPC)
> -		goto out;
> -
> -	/* We don't have space in inline inode, so convert it to extent. */
> -	if (ret == -ENOSPC) {
> -		ext4_journal_stop(handle);
> -		brelse(iloc.bh);
> -		goto convert;
> -	}
> -
> -	ret = ext4_journal_get_write_access(handle, inode->i_sb, iloc.bh,
> -					    EXT4_JTR_NONE);
> -	if (ret)
> -		goto out;
> -
> -	folio = __filemap_get_folio(mapping, 0, FGP_WRITEBEGIN | FGP_NOFS,
> -					mapping_gfp_mask(mapping));
> -	if (IS_ERR(folio)) {
> -		ret = PTR_ERR(folio);
> -		goto out;
> -	}
> -
> -	*foliop = folio;
> -	down_read(&EXT4_I(inode)->xattr_sem);
> -	if (!ext4_has_inline_data(inode)) {
> -		ret = 0;
> -		folio_unlock(folio);
> -		folio_put(folio);
> -		goto out_up_read;
> -	}
> -
> -	if (!folio_test_uptodate(folio)) {
> -		ret = ext4_read_inline_folio(inode, folio);
> -		if (ret < 0) {
> -			folio_unlock(folio);
> -			folio_put(folio);
> -			goto out_up_read;
> -		}
> -	}
> -
> -	ret = 1;
> -	handle = NULL;
> -out_up_read:
> -	up_read(&EXT4_I(inode)->xattr_sem);
> -out:
> -	if (handle && (ret != 1))
> -		ext4_journal_stop(handle);
> -	brelse(iloc.bh);
> -	return ret;
> -convert:
> -	return ext4_convert_inline_data_to_extent(mapping, inode);
> +		return ext4_convert_inline_data_to_extent(mapping, inode);
> +	return ext4_generic_write_inline_data(mapping, inode, pos, len,
> +					      foliop, NULL, false);
>  }
>  
>  int ext4_write_inline_data_end(struct inode *inode, loff_t pos, unsigned len,
> -- 
> 2.39.5
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

