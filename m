Return-Path: <linux-ext4+bounces-3024-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9DE91C167
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Jun 2024 16:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72191B2391C
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Jun 2024 14:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB4B1A2579;
	Fri, 28 Jun 2024 14:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GhKFwNbc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uKiX/CY8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GhKFwNbc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uKiX/CY8"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72331E532
	for <linux-ext4@vger.kernel.org>; Fri, 28 Jun 2024 14:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719585959; cv=none; b=Aw3Pd+wUxHZJU3FWtHxtyg6LGqjz72/9eoRd6hrAOwXezGc3SuZiRrUmXHscnXwMAO0rbJL2u196dXl5NlLlf4CdIF3nlLFGn9/HPzsEa3QFgLztVv9Wyto2Ffh6sL4mNTGkISCbTSt/UaUWZhGaXNVh+NxsUCrhlvCzY0cLEmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719585959; c=relaxed/simple;
	bh=4PUDlM5z5lICl6iRIKCyNwNNrNGjvkDoN5PCqcWwdCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZeMNe13p/kTNjLasIk1mNjG7GshhiuJOcYFbGAHMIitQkn5DaVG5ATYb4jfzTBNzc7ZsjhvmALVqHzaHfaT/z0CAamBX6z7bnNpbr7nyf/nnYcbtYs4lJTRUBae2T0L8GdOIPfLut7n2NwMme3o+pYCUMwjvVJz5A96Gwu0dGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GhKFwNbc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uKiX/CY8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GhKFwNbc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uKiX/CY8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C5D8C1FCF5;
	Fri, 28 Jun 2024 14:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719585955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fPnKrGaXkDycrJRRput+tlbgWuSYtUFrtmdcHL5DABw=;
	b=GhKFwNbcAC1cffGbt7ldgExedgIX7AGU+BFqLTtkNgNnqHd2UZS2otJtNgsMc5M+h2A2wd
	q6w1CHhtCs+vEvD+FaILffJMK1v2GfgpI3BgXfzWi/SZX/wMLt+URZ+hNo8mOFpyBRbpbU
	kA/CdR4ohQVnkt0G+6Ib3HmaRncnjsU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719585955;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fPnKrGaXkDycrJRRput+tlbgWuSYtUFrtmdcHL5DABw=;
	b=uKiX/CY8J9s/IR31V6zrt7Z7UiMmUH4ch4xIt/rXGu63yhmDw3SK8QytYzSI4GdQm9U+Nc
	tc4IO+WV3bNf2bCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719585955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fPnKrGaXkDycrJRRput+tlbgWuSYtUFrtmdcHL5DABw=;
	b=GhKFwNbcAC1cffGbt7ldgExedgIX7AGU+BFqLTtkNgNnqHd2UZS2otJtNgsMc5M+h2A2wd
	q6w1CHhtCs+vEvD+FaILffJMK1v2GfgpI3BgXfzWi/SZX/wMLt+URZ+hNo8mOFpyBRbpbU
	kA/CdR4ohQVnkt0G+6Ib3HmaRncnjsU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719585955;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fPnKrGaXkDycrJRRput+tlbgWuSYtUFrtmdcHL5DABw=;
	b=uKiX/CY8J9s/IR31V6zrt7Z7UiMmUH4ch4xIt/rXGu63yhmDw3SK8QytYzSI4GdQm9U+Nc
	tc4IO+WV3bNf2bCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B966C1373E;
	Fri, 28 Jun 2024 14:45:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QTtDLaPMfmaBGAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 28 Jun 2024 14:45:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1AD2DA0887; Fri, 28 Jun 2024 16:45:55 +0200 (CEST)
Date: Fri, 28 Jun 2024 16:45:55 +0200
From: Jan Kara <jack@suse.cz>
To: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, saukad@google.com,
	harshads@google.com
Subject: Re: [PATCH v6 02/10] ext4: for committing inode, make
 ext4_fc_track_inode wait
Message-ID: <20240628144555.6a2jdc4d2lmbfiy7@quack3>
References: <20240529012003.4006535-1-harshadshirwadkar@gmail.com>
 <20240529012003.4006535-3-harshadshirwadkar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529012003.4006535-3-harshadshirwadkar@gmail.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Wed 29-05-24 01:19:55, Harshad Shirwadkar wrote:
> If the inode that's being requested to track using ext4_fc_track_inode
> is being committed, then wait until the inode finishes the
> commit. Also, add calls to ext4_fc_track_inode at the right places.
> 
> With this patch, now calling ext4_reserve_inode_write() results in
> inode being tracked for next fast commit. A subtle lock ordering
> requirement with i_data_sem (which is documented in the code) requires
> that ext4_fc_track_inode() be called before grabbing i_data_sem. So,
> this patch also adds explicit ext4_fc_track_inode() calls in places
> where i_data_sem grabbed.
> 
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

One more thing I've noticed:

> @@ -5727,6 +5730,7 @@ ext4_reserve_inode_write(handle_t *handle, struct inode *inode,
>  			brelse(iloc->bh);
>  			iloc->bh = NULL;
>  		}
> +		ext4_fc_track_inode(handle, inode);
>  	}
>  	ext4_std_error(inode->i_sb, err);
>  	return err;

Calling ext4_fc_track_inode() when ext4_get_write_access() failed is
pointless (inode isn't going to be written) and confusing. We should do
that only in the success case.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

