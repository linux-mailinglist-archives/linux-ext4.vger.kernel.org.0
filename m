Return-Path: <linux-ext4+bounces-3506-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8480693F401
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Jul 2024 13:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D4DA2814C3
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Jul 2024 11:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E51145B12;
	Mon, 29 Jul 2024 11:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="w3fPnfNX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="k9E/dqw2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="w3fPnfNX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="k9E/dqw2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82BE1DA24;
	Mon, 29 Jul 2024 11:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722252486; cv=none; b=n3QVSF9bUq9ysI8weWdyH/FIXMSY8qhnT/IgEs1RW0ebeHeEYJOQkxm9hozVCV5/rXwNHhFfEnsSTi6r9FD6nwuqPQgfAU5TKQFSwcPIQR5sjiYtyrv3fdKzm782GiDmJ7sVQtioVXeoY0CCneQ4+v5S42b8qazSI2nqIEO11ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722252486; c=relaxed/simple;
	bh=64wCMHSRx+3w86acTbFol7vjqbpkywyn79By4+qP8vI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gchDuK7ZoSjc4gDVgnrUtBGted3g46+bcrrEoeGCoqRt/x0pto78ElNeBC5fph4MQmylJb+2lSJRUYQ0yihvo50XhJDOm8V/a1ONGR0oTLBsnhNAW8lDADIhZnZg3beH8Z1s20xl6qnsTR1wHbh8dkli/smT2Fr2iDdPsZr+aHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=w3fPnfNX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=k9E/dqw2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=w3fPnfNX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=k9E/dqw2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C9C3C1F78D;
	Mon, 29 Jul 2024 11:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722252482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zHUy40S81Hi4I9W9Ak/AUgKQ+mpmORJOALnG2nRnuZM=;
	b=w3fPnfNXR7uSSln120H+4F0BucM5UqvqvxvUAQ4OQduS4RA5+TwUjEHWI5i6oCBJEH9FtN
	LesNzcVoghICMVYj0tqTu2X9hzFlGlRU1W50Ws092evHeJU5nA32m5y8AQQn9JXJcm8C7q
	hmXV6o2fBXjIl4iIiHiAmO6RLBtpRFg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722252482;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zHUy40S81Hi4I9W9Ak/AUgKQ+mpmORJOALnG2nRnuZM=;
	b=k9E/dqw2MvhFlDgqEBRwJ38Ig/L5V33Nz87eZTwStImN3ZRmR+Vv+po62CMaLMCUbLMtVx
	OAodIzr8smLBsLAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722252482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zHUy40S81Hi4I9W9Ak/AUgKQ+mpmORJOALnG2nRnuZM=;
	b=w3fPnfNXR7uSSln120H+4F0BucM5UqvqvxvUAQ4OQduS4RA5+TwUjEHWI5i6oCBJEH9FtN
	LesNzcVoghICMVYj0tqTu2X9hzFlGlRU1W50Ws092evHeJU5nA32m5y8AQQn9JXJcm8C7q
	hmXV6o2fBXjIl4iIiHiAmO6RLBtpRFg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722252482;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zHUy40S81Hi4I9W9Ak/AUgKQ+mpmORJOALnG2nRnuZM=;
	b=k9E/dqw2MvhFlDgqEBRwJ38Ig/L5V33Nz87eZTwStImN3ZRmR+Vv+po62CMaLMCUbLMtVx
	OAodIzr8smLBsLAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD3FF1368A;
	Mon, 29 Jul 2024 11:28:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DsgtLsJ8p2YjMQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 29 Jul 2024 11:28:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6F770A099C; Mon, 29 Jul 2024 13:28:02 +0200 (CEST)
Date: Mon, 29 Jul 2024 13:28:02 +0200
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun@huaweicloud.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, ritesh.list@gmail.com,
	linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH 08/20] ext4: get rid of ppath in ext4_find_extent()
Message-ID: <20240729112802.eqkmgf66ebnc22u5@quack3>
References: <20240710040654.1714672-1-libaokun@huaweicloud.com>
 <20240710040654.1714672-9-libaokun@huaweicloud.com>
 <20240725103823.fvvinixcctacf4fx@quack3>
 <0046d3b3-24ce-4cdb-a40a-4022b79a5a7b@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0046d3b3-24ce-4cdb-a40a-4022b79a5a7b@huaweicloud.com>
X-Spamd-Result: default: False [-2.10 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,mit.edu,dilger.ca,gmail.com,huawei.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,huawei.com:email,suse.cz:email,suse.com:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.10

On Sat 27-07-24 14:18:33, Baokun Li wrote:
> On 2024/7/25 18:38, Jan Kara wrote:
> > On Wed 10-07-24 12:06:42, libaokun@huaweicloud.com wrote:
> > > From: Baokun Li <libaokun1@huawei.com>
> > > 
> > > The use of path and ppath is now very confusing, so to make the code more
> > > readable, pass path between functions uniformly, and get rid of ppath.
> > > 
> > > Getting rid of ppath in ext4_find_extent() requires its caller to update
> > > ppath. These ppaths will also be dropped later. No functional changes.
> > > 
> > > Signed-off-by: Baokun Li <libaokun1@huawei.com>
> > One nit below, otherwise feel free to add:
> > 
> > Reviewed-by: Jan Kara <jack@suse.cz>
> > 
> > > @@ -3260,11 +3257,12 @@ static int ext4_split_extent_at(handle_t *handle,
> > >   	 * WARN_ON may be triggered in ext4_da_update_reserve_space() due to
> > >   	 * an incorrect ee_len causing the i_reserved_data_blocks exception.
> > >   	 */
> > > -	path = ext4_find_extent(inode, ee_block, ppath,
> > > +	path = ext4_find_extent(inode, ee_block, *ppath,
> > >   				flags | EXT4_EX_NOFAIL);
> > >   	if (IS_ERR(path)) {
> > >   		EXT4_ERROR_INODE(inode, "Failed split extent on %u, err %ld",
> > >   				 split, PTR_ERR(path));
> > > +		*ppath = NULL;
> > >   		return PTR_ERR(path);
> > >   	}
> > I think here you forgot to update ppath on success case. It will go away by
> > the end of the series but still it's good to keep thing consistent...
> > 
> > 								Honza
> 
> Hi Honza,
> 
> Thank you for your review！
> 
> In patch 5, the ppath is already updated in case of success, so there
> is no need to add it here. This update was not shown when the patch
> was made and it looks like this：
> 
> -       path = ext4_find_extent(inode, ee_block, ppath,
> +       path = ext4_find_extent(inode, ee_block, *ppath,
>                                 flags | EXT4_EX_NOFAIL);
>         if (IS_ERR(path)) {
>                 EXT4_ERROR_INODE(inode, "Failed split extent on %u, err
> %ld",
>                                  split, PTR_ERR(path));
> +               *ppath = NULL;
>                 return PTR_ERR(path);
>         }
>         depth = ext_depth(inode);
>         ex = path[depth].p_ext;
>         *ppath = path;

Yes, you are right. I didn't realize the update was already there. So I
withdraw my comment :)

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

