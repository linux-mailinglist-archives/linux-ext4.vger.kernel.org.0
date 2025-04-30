Return-Path: <linux-ext4+bounces-7572-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD1DAA44AA
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Apr 2025 10:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CB51171FDD
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Apr 2025 08:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0F020E334;
	Wed, 30 Apr 2025 08:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1JTzKuaw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tByTKZ6B";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pkIaEELL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yhYIwOU/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF69020D516
	for <linux-ext4@vger.kernel.org>; Wed, 30 Apr 2025 08:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746000122; cv=none; b=N60zfJt4HP/9WhFVRtuJkMnWb11l8Lvndde446xwjMlcaKKkXk5BTUbjAlqaPmQ08J0xpK4OBEnhGkXzAMLy1MfJSMWKtrTmypuY3xOW0+KSnq47TaZgZc5ApGR52/7tiBTfQqdmMMScpXsLmQae7d2vOfSwR69Kpk05UTHchRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746000122; c=relaxed/simple;
	bh=imNZM0y0X2Zh0glJewNR4M0/mnywvZ7XPAeuRNJmlBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJogQfxUO9oS8Q97WW41GvRb8Fc/HFgz0k3T9+6d1q0onuGwN7QRT88JZ0sk8szXtl/31KsYch2ucU/o5wt2d1moe/Q7Lnq4uxxLLxggkN+kCzxw+9DYzdLOsoK+Fw1s+jbXXJEtPQQDk7yciw0qbSC8f+XP9v33UDITKTcTZoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1JTzKuaw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tByTKZ6B; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pkIaEELL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yhYIwOU/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EC10521227;
	Wed, 30 Apr 2025 08:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746000118; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=03W5YtvlVGgcHBJCGX1MqxQSc7zu2MhPizkqenI0Lt0=;
	b=1JTzKuawdTXdtZE6wr6Tsza1zxtzz5sm9FdR75lY8OGRZXygGd95d9ktIw83NGOjceoG02
	dPj5NeTQilr2ZXPzmIYodkEJk3bGYn/U5H73VM2dJK03OCu3HPVbEl0t1DfqMQwvDWyB5A
	NckY7raho18q3GNH4yK9yQfe3KAEMlc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746000118;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=03W5YtvlVGgcHBJCGX1MqxQSc7zu2MhPizkqenI0Lt0=;
	b=tByTKZ6BT9NweKRTkFuTjFHUjKCcB2k+QFFmmT9tYw5vtekUJj3VBS2zaYgHuobY9U5Ofa
	oPjq0cxzfg84/1BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746000117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=03W5YtvlVGgcHBJCGX1MqxQSc7zu2MhPizkqenI0Lt0=;
	b=pkIaEELLDx7JOFPt2lPzQfQIp5d2ZWuF159NU3qm1Q6Zrm3Ux0HeQp0pklRVspKkY9aCDn
	FpN92g8vEX4JQWVZhhk9mZ1PxA/pVwq9iuo+9sQZ1IO9hacCtHH8SResJQqhvqM7fiQmci
	6P9cGnMIL4g64C/cB/x5GFDzXJLb+/s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746000117;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=03W5YtvlVGgcHBJCGX1MqxQSc7zu2MhPizkqenI0Lt0=;
	b=yhYIwOU/ehkbYQO1rCtFM8R6X8hONytUkXhGN1FtTx/1AnfdRwzf0ulDzPdJqKjBJwD42q
	vFJedRKAVd6A/UBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DC562139E7;
	Wed, 30 Apr 2025 08:01:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xs/CNfXYEWiECAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 30 Apr 2025 08:01:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8B961A0AF0; Wed, 30 Apr 2025 10:01:53 +0200 (CEST)
Date: Wed, 30 Apr 2025 10:01:53 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, 
	wanghaichi0403@gmail.com, yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com, 
	yangerkun@huawei.com
Subject: Re: [PATCH 4/4] ext4: ensure i_size is smaller than maxbytes
Message-ID: <ou367b36z65wilppck3eyeah445gbr4623irp4k4kuzypnhdkr@jouh63bmmy4r>
References: <20250430011301.1106457-1-yi.zhang@huaweicloud.com>
 <20250430011301.1106457-4-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430011301.1106457-4-yi.zhang@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,huawei.com:email,suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Wed 30-04-25 09:13:01, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> The inode i_size cannot be larger than maxbytes, check it while loading
> inode from the disk.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 9f32af1241ff..2bd2a4f4d9d7 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4916,7 +4916,8 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
>  		ei->i_file_acl |=
>  			((__u64)le16_to_cpu(raw_inode->i_file_acl_high)) << 32;
>  	inode->i_size = ext4_isize(sb, raw_inode);
> -	if ((size = i_size_read(inode)) < 0) {
> +	size = i_size_read(inode);
> +	if (size < 0 || size > ext4_get_maxbytes(inode)) {
>  		ext4_error_inode(inode, function, line, 0,
>  				 "iget: bad i_size value: %lld", size);
>  		ret = -EFSCORRUPTED;
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

