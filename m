Return-Path: <linux-ext4+bounces-5603-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 657D99EFEDD
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Dec 2024 22:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78E6F16A2C9
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Dec 2024 21:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732CB1D7E5F;
	Thu, 12 Dec 2024 21:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ydn21Auo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3brbvC+N";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ydn21Auo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3brbvC+N"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203471547F5
	for <linux-ext4@vger.kernel.org>; Thu, 12 Dec 2024 21:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734040664; cv=none; b=HJULm+sw2P7fJYrAt3pZifwv9pRqDxlK1+/7sLOQnc8CZmJtsw4mFEuPJd/EWlH91smttFDaW21BJhLlqIqnBJXN8O/AYbclc685bwDTpM79j8pOUZI0mQCEMDMlzAQKhv2kHu8gGMOeMCjPlLzbztO/xBpfu89e18S71njge8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734040664; c=relaxed/simple;
	bh=BvPFXpm+e8W2fmlNrYbN0uwLTLOMgfkKJ9HzPLm2kw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WFaP2fAhhi3AJIDhQz2He5dbh4quXEpxzqKrVWydx4oIf0wAY44ioyU9JI5VhrxnLlaJ/RWRctJsa21Y7pv9jfaUj+OlCsqQkmAWxAPeRsROVvN324Zt+NCadF7Ip5oc4kI0DHZSPEl1TScVHD3Ga29xHX0zDCf7J98P14jp06Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ydn21Auo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3brbvC+N; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ydn21Auo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3brbvC+N; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4DD931F443;
	Thu, 12 Dec 2024 21:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734040660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OxRJh3S3gJKVbj4JLvlssLKaA1BHBXrm3QTCPs9oayg=;
	b=ydn21AuoQ7wqNmIhXKp5KguRLM0S43+UfgtGjKiGj/IxoVgbaNxI62MxNRi+/sXEu+p+/B
	X03vapXsnJlGbfMFTUlqDxAOOh4QHEVBL7tWTWthc13lx1GukC/ckp8OqGi3NI8cq7Ojdu
	DFC4JylNGGqb3ahT4p4BJyDciJWM9Ao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734040660;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OxRJh3S3gJKVbj4JLvlssLKaA1BHBXrm3QTCPs9oayg=;
	b=3brbvC+NQarBPYPVKlSKaHV1tMjNsEstxaFUKSipGyZWXaq3LcH0+Pxoh85b1muDHnD00V
	09y0QD5zwbWc+vAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734040660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OxRJh3S3gJKVbj4JLvlssLKaA1BHBXrm3QTCPs9oayg=;
	b=ydn21AuoQ7wqNmIhXKp5KguRLM0S43+UfgtGjKiGj/IxoVgbaNxI62MxNRi+/sXEu+p+/B
	X03vapXsnJlGbfMFTUlqDxAOOh4QHEVBL7tWTWthc13lx1GukC/ckp8OqGi3NI8cq7Ojdu
	DFC4JylNGGqb3ahT4p4BJyDciJWM9Ao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734040660;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OxRJh3S3gJKVbj4JLvlssLKaA1BHBXrm3QTCPs9oayg=;
	b=3brbvC+NQarBPYPVKlSKaHV1tMjNsEstxaFUKSipGyZWXaq3LcH0+Pxoh85b1muDHnD00V
	09y0QD5zwbWc+vAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4128B13939;
	Thu, 12 Dec 2024 21:57:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EFSXD1RcW2fIcQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 12 Dec 2024 21:57:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CB441A0894; Thu, 12 Dec 2024 22:57:35 +0100 (CET)
Date: Thu, 12 Dec 2024 22:57:35 +0100
From: Jan Kara <jack@suse.cz>
To: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.cz,
	harshads@google.com
Subject: Re: [PATCH v7 3/9] ext4: mark inode dirty before grabbing i_data_sem
 in ext4_setattr
Message-ID: <20241212215735.dc4ytlkf6mzbnrzd@quack3>
References: <20240818040356.241684-1-harshadshirwadkar@gmail.com>
 <20240818040356.241684-5-harshadshirwadkar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240818040356.241684-5-harshadshirwadkar@gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.992];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Sun 18-08-24 04:03:50, Harshad Shirwadkar wrote:
> Mark inode dirty first and then grab i_data_sem in ext4_setattr().
> 
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
...

> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index e11f00ff8..c82eba178 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5489,12 +5489,13 @@ int ext4_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  					(attr->ia_size > 0 ? attr->ia_size - 1 : 0) >>
>  					inode->i_sb->s_blocksize_bits);
>  
> -			down_write(&EXT4_I(inode)->i_data_sem);
> -			old_disksize = EXT4_I(inode)->i_disksize;
> -			EXT4_I(inode)->i_disksize = attr->ia_size;
>  			rc = ext4_mark_inode_dirty(handle, inode);
>  			if (!error)
>  				error = rc;
> +			down_write(&EXT4_I(inode)->i_data_sem);
> +			old_disksize = EXT4_I(inode)->i_disksize;
> +			EXT4_I(inode)->i_disksize = attr->ia_size;

Well, but this doesn't really work, does it? If you modify inode metadata
*after* calling ext4_mark_inode_dirty() the new metadata will not be copied
into the inode buffer and thus will not be written out... You can move the
ext4_mark_inode_dirty() call to the point where i_data_sem is already
released though. That is perfectly fine.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

