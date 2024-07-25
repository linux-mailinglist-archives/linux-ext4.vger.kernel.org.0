Return-Path: <linux-ext4+bounces-3452-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3B293C091
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jul 2024 13:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1A7F1F22419
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jul 2024 11:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75BA1991C2;
	Thu, 25 Jul 2024 11:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hxZS6nYf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oY88QIEH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hxZS6nYf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oY88QIEH"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8265E132492;
	Thu, 25 Jul 2024 11:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721905680; cv=none; b=YGKn1yWTtENY2jy1r9awW6MFWB9ezV0hRMotdE4m1gS/zY7GoCyeiV7xeCk4LsHhE49Y59mDxBtpNJDql8kACqLowEFAgjban/VwHhEf1Zj5G2X7SCBK+ltGuHznEo1rxMTIgsiyTmdNKlYinhOuomJazIhK8zCsCMj443cCf4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721905680; c=relaxed/simple;
	bh=REWD8dQEXdO6cMsdd0gwSlNZOVimBClEElYDdV3lF7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQolTRfMIv3onvoovn9o5OZbGChzvHBTxquEC2x3ornaIUCsdwb3XLxyoQwZ5bd6qAyPTginU/KUnNH2iO9zXl3GimJKFUGGOjfcfw62S2kr8UFI8HeIjujjopSK2UfRNWZOy+E456ON2iekrkN03++Ar0uTK8/lq2I1LoACZnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hxZS6nYf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oY88QIEH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hxZS6nYf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oY88QIEH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 98DE721216;
	Thu, 25 Jul 2024 11:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721905676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dwUsOoJhN81051uMj0WumGw4faJjwSqx5ZjLrkg5/SI=;
	b=hxZS6nYfiyoryeeoRj1XiJtrkHRgcS4irRzzjG5sTVOLrovHCMhEKZNg3Xe76+SXff9bNq
	K3IHo1RIFpJhELLaUr5pBYDHrVlQ5f1942AQBZahcSz7x45hU/VYknPRECa6xmJGWTq80O
	X4K5AMRNCknFRjBGok4eYaOXV5j9Wrc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721905676;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dwUsOoJhN81051uMj0WumGw4faJjwSqx5ZjLrkg5/SI=;
	b=oY88QIEHq7SbeqprDY2wiJGFgthvAXAFtoE0TMapzJp9LY2h4KSPkbutjF6kjRs0ZtFXH0
	XTc9xbXYoivtKhAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hxZS6nYf;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=oY88QIEH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721905676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dwUsOoJhN81051uMj0WumGw4faJjwSqx5ZjLrkg5/SI=;
	b=hxZS6nYfiyoryeeoRj1XiJtrkHRgcS4irRzzjG5sTVOLrovHCMhEKZNg3Xe76+SXff9bNq
	K3IHo1RIFpJhELLaUr5pBYDHrVlQ5f1942AQBZahcSz7x45hU/VYknPRECa6xmJGWTq80O
	X4K5AMRNCknFRjBGok4eYaOXV5j9Wrc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721905676;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dwUsOoJhN81051uMj0WumGw4faJjwSqx5ZjLrkg5/SI=;
	b=oY88QIEHq7SbeqprDY2wiJGFgthvAXAFtoE0TMapzJp9LY2h4KSPkbutjF6kjRs0ZtFXH0
	XTc9xbXYoivtKhAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B24D13874;
	Thu, 25 Jul 2024 11:07:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bLrzIQwyomYYVgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 25 Jul 2024 11:07:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4991DA0996; Thu, 25 Jul 2024 13:07:56 +0200 (CEST)
Date: Thu, 25 Jul 2024 13:07:56 +0200
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com,
	Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH 12/20] ext4: get rid of ppath in ext4_split_extent_at()
Message-ID: <20240725110756.fuyjfdvgbprma5ml@quack3>
References: <20240710040654.1714672-1-libaokun@huaweicloud.com>
 <20240710040654.1714672-13-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710040654.1714672-13-libaokun@huaweicloud.com>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 98DE721216
X-Spam-Score: -2.31
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.31 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:email,huawei.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email,suse.cz:dkim]

On Wed 10-07-24 12:06:46, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> The use of path and ppath is now very confusing, so to make the code more
> readable, pass path between functions uniformly, and get rid of ppath.
> 
> To get rid of the ppath in ext4_split_extent_at(), the following is done
> here:
> 
>  * Free the extents path when an error is encountered.
>  * Its caller needs to update ppath if it uses ppath.
>  * Teach ext4_ext_show_leaf() to skip error pointer.
>  * Propagate ext4_find_extent() error return value in ext4_insert_range().
> 
> No functional changes.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

One nit below:

> @@ -5596,6 +5606,7 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
>  	path = ext4_find_extent(inode, offset_lblk, NULL, 0);
>  	if (IS_ERR(path)) {
>  		up_write(&EXT4_I(inode)->i_data_sem);
> +		ret = PTR_ERR(path);
>  		goto out_stop;
>  	}

AFAICT this actually fixes a bug where we could have returned 0 although
ext4_find_extent() spotted an error? This would deserve a separate patch so
that it could be easily pulled into stable.

Otherwise looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

