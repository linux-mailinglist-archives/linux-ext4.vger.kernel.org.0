Return-Path: <linux-ext4+bounces-1227-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB58D85364B
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Feb 2024 17:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1F7A282A94
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Feb 2024 16:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E6E5FBBF;
	Tue, 13 Feb 2024 16:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hvTQGP7V";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7d8bL/lF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hvTQGP7V";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7d8bL/lF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6690A182C5;
	Tue, 13 Feb 2024 16:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707842292; cv=none; b=F8rSR04A1deVsgy0L3bCmXQJF1l5jD0724frqEqvvoUreD2oNEfXEclaBbQtfQuUSs3gjFWifsuYexQqIhw3fYKfbQVbhBe9cgxYtHC8rZoetqL5OUwxmzqs+Zy7gTWCYY5iUMC7qilBmLBh9GbVty1/jkfx5hCto2pHnse7q7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707842292; c=relaxed/simple;
	bh=Lfn5hNaAPgixys2jlUPdKwIGjxTy2BVsi++9s82hWeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SwDFgSCR3p96pvjCS5HA5YJCjk0i2Ub8AIDIiBqXvktOXZO6SDUlgkl/ca0a5ujDwjgCpypIFcG/hzLtbHYFFFBOMl05bypYxmOhwLJd4sgLx65/cuqSpY1a14XFbgemfuZD6ftvHIsgtkgKnQi6XCOFrmRq5jwz3QM5UMNJ1ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hvTQGP7V; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7d8bL/lF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hvTQGP7V; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7d8bL/lF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8CB701FD58;
	Tue, 13 Feb 2024 16:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707842288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z6uDru7/wqes/0TWQjyttP5BOAJkYK+WoALHVELYZ4o=;
	b=hvTQGP7VGlLKGtXItXvk1Lt358K9nrtrrQuSeAMw3C8ywa8aZNDe5KMLwSYkVca3AyMurL
	JluiyoDyea4Tw6Z9/6rct/pa6LwgQsb8Wo0+qKHccdGzMaED2S6WhV3L9UhMU/O9MGfgYC
	c9XYJ0+YOpPGhjkn5bz30SKmhUHDkV4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707842288;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z6uDru7/wqes/0TWQjyttP5BOAJkYK+WoALHVELYZ4o=;
	b=7d8bL/lFdOmGq2sj2D+s2aU5MDuSxjTvhTwh4Ht//cWWj7r0WZObSeT8xr5kJc82VKjD3s
	PQSKXJnTd2herVDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707842288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z6uDru7/wqes/0TWQjyttP5BOAJkYK+WoALHVELYZ4o=;
	b=hvTQGP7VGlLKGtXItXvk1Lt358K9nrtrrQuSeAMw3C8ywa8aZNDe5KMLwSYkVca3AyMurL
	JluiyoDyea4Tw6Z9/6rct/pa6LwgQsb8Wo0+qKHccdGzMaED2S6WhV3L9UhMU/O9MGfgYC
	c9XYJ0+YOpPGhjkn5bz30SKmhUHDkV4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707842288;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z6uDru7/wqes/0TWQjyttP5BOAJkYK+WoALHVELYZ4o=;
	b=7d8bL/lFdOmGq2sj2D+s2aU5MDuSxjTvhTwh4Ht//cWWj7r0WZObSeT8xr5kJc82VKjD3s
	PQSKXJnTd2herVDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7EBFC1329E;
	Tue, 13 Feb 2024 16:38:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id JnyqHvCay2XYDQAAn2gu4w
	(envelope-from <jack@suse.cz>); Tue, 13 Feb 2024 16:38:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id F2CBBA0809; Tue, 13 Feb 2024 17:38:07 +0100 (CET)
Date: Tue, 13 Feb 2024 17:38:07 +0100
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: Re: [PATCH 7/7] ext4: set the type of max_zeroout to unsigned int to
 avoid overflow
Message-ID: <20240213163807.lodqvvw24namiu7g@quack3>
References: <20240126085716.1363019-1-libaokun1@huawei.com>
 <20240126085716.1363019-8-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126085716.1363019-8-libaokun1@huawei.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [1.89 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.01)[45.83%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: *
X-Spam-Score: 1.89
X-Spam-Flag: NO

On Fri 26-01-24 16:57:16, Baokun Li wrote:
> The max_zeroout is of type int and the s_extent_max_zeroout_kb is of
> type uint, and the s_extent_max_zeroout_kb can be freely modified via
> the sysfs interface. When the block size is 1024, max_zeroout may
> overflow, so declare it as unsigned int to avoid overflow.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>  fs/ext4/extents.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 01299b55a567..8653b13e8248 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3425,10 +3425,8 @@ static int ext4_ext_convert_to_initialized(handle_t *handle,
>  	struct ext4_extent zero_ex1, zero_ex2;
>  	struct ext4_extent *ex, *abut_ex;
>  	ext4_lblk_t ee_block, eof_block;
> -	unsigned int ee_len, depth, map_len = map->m_len;
> -	int allocated = 0, max_zeroout = 0;
> -	int err = 0;
> -	int split_flag = EXT4_EXT_DATA_VALID2;
> +	unsigned int ee_len, depth, map_len = map->m_len, max_zeroout = 0;
> +	int err = 0, allocated = 0, split_flag = EXT4_EXT_DATA_VALID2;

Honestly, I prefer if we keep unrelated variables on different lines,
especially when they have initializers. I find the code more readable that
way. So in this case:

	int err = 0;
	int split_flag = EXT4_EXT_DATA_VALID2;
	int allocated = 0;
	unsigned int max_zeroout = 0;

But otherwise the fix looks good!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

