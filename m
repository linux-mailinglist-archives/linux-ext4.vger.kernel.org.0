Return-Path: <linux-ext4+bounces-5901-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 863F1A02976
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Jan 2025 16:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 444EF1644E3
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Jan 2025 15:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BEB1514F6;
	Mon,  6 Jan 2025 15:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3Kq0H6ir";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ziAZx9Nu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zSnvWLek";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VCYq173y"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163BE146D6B;
	Mon,  6 Jan 2025 15:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736177013; cv=none; b=uRPbsZXu94j6ZUn22BKtWTtAmkwGQMFT2ansjtWu7Dc180gTkML4IBIq6s1EBvIAHwLH9VZrjpr2U86V5RnVtZJV+AfAaWDU+jmeFOn69LjoV4ecQopt0duxu9HteThba2rXG98R+uBsBwYvi/rn3jZEb65jFFoFg6LL/mR4Yh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736177013; c=relaxed/simple;
	bh=DuCVioIjkhjKdXfDPKFLYQquBR618kg8K0Bjtz11vEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vFgc16Q9F7A+Kb7JDYzYgh3qo9wm2NlbsynU6joOjUbrO91SCA3JO5U7Jjunb7EO3/0diHIz/1IwLE1YNz7ZYf4vYbg45xMqGl/OBjpvXI4xV21dRK9fzlT7a8YuRrYFxDZ7FRnD1zSE9LI8mfj0U6wDQAi1rHPd79XT81CvdB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3Kq0H6ir; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ziAZx9Nu; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zSnvWLek; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VCYq173y; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E6E9B2115D;
	Mon,  6 Jan 2025 15:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736177010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AeMPO/f7X86SFXMIJvTHKjimp0TdI2XXkUBQevyGBvs=;
	b=3Kq0H6irTkz/MPBckvpmx/6EO8o9nmm9M7+EGxm4NPyM/2BMumiw7ipyDfLWbFmhMd9oAP
	cYLW3Dlfz7R7UReJTp7p/KLfbSzg4jpq2mmZMuot9G3TarWpkTZEVncEh9nSgiM7VH/lnD
	qDHhJTt5XZCg+M1xpWy/J432TiQjiGY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736177010;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AeMPO/f7X86SFXMIJvTHKjimp0TdI2XXkUBQevyGBvs=;
	b=ziAZx9NuTBKk929ZSQ4ChZxazPPV+DTRrRnfWUyY0T5ah4mIP3ce/QgumqZaedEJbmp9dq
	CnF66PyVCrb7TrCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736177008; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AeMPO/f7X86SFXMIJvTHKjimp0TdI2XXkUBQevyGBvs=;
	b=zSnvWLekhw9N2uR+htN8SneHmRy34pEPRctmsZSCkhTEOnHwJlUZV+xRa67xVhMsL+Y3Fc
	p/Np1Gzd4w29i7MG5j7FrXtR9HlZp2R6z9JfBch+xDLNOWuuLg8MCJ1Z0S60hslUqJ4VY4
	MJE5KdSjisWRo00kXrSDpll1zu/31JE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736177008;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AeMPO/f7X86SFXMIJvTHKjimp0TdI2XXkUBQevyGBvs=;
	b=VCYq173yCLNvIw7/LwML3PF1nwvOZ9IRZaSFngA0H7wpkpA3YhPvI49+OTbGZ3m2JtzmEM
	GPi0orru8Dvk3fAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D4437139AB;
	Mon,  6 Jan 2025 15:23:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lhzQM3D1e2f7SAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 06 Jan 2025 15:23:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 80CC5A089C; Mon,  6 Jan 2025 16:23:28 +0100 (CET)
Date: Mon, 6 Jan 2025 16:23:28 +0100
From: Jan Kara <jack@suse.cz>
To: Julian Sun <sunjunchao2870@gmail.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, boyu.mt@taobao.com, 
	tm@tao.ma
Subject: Re: [PATCH 3/7] ext4: Don't set EXT4_STATE_MAY_INLINE_DATA for ea
 inodes
Message-ID: <7rqsgaocwcorxqe4rghhgpwy4nmmbn6r2jjmposxuqk5i7g237@r2gbucnrlep6>
References: <20241220151625.19769-1-sunjunchao2870@gmail.com>
 <20241220151625.19769-4-sunjunchao2870@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220151625.19769-4-sunjunchao2870@gmail.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 20-12-24 23:16:21, Julian Sun wrote:
> Setting the EXT4_STATE_MAY_INLINE_DATA flag for ea inodes
> is meaningless because ea inodes do not use functions
> like ext4_write_begin().
> 
> Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ialloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
> index 7f1a5f90dbbd..49b112bfbd93 100644
> --- a/fs/ext4/ialloc.c
> +++ b/fs/ext4/ialloc.c
> @@ -1297,7 +1297,7 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
>  	ei->i_extra_isize = sbi->s_want_extra_isize;
>  	ei->i_inline_off = 0;
>  	if (ext4_has_feature_inline_data(sb) &&
> -	    (!(ei->i_flags & EXT4_DAX_FL) || S_ISDIR(mode)))
> +	    (!(ei->i_flags & (EXT4_DAX_FL|EXT4_EA_INODE_FL)) || S_ISDIR(mode)))
>  		ext4_set_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
>  	ret = inode;
>  	err = dquot_alloc_inode(inode);
> -- 
> 2.39.5
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

