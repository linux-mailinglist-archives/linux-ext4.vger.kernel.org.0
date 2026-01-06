Return-Path: <linux-ext4+bounces-12591-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9D7CF8CCE
	for <lists+linux-ext4@lfdr.de>; Tue, 06 Jan 2026 15:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D068830245D7
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Jan 2026 14:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F63313E2A;
	Tue,  6 Jan 2026 14:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QU14dtjX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4O3iJeNi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QU14dtjX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4O3iJeNi"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45182313529
	for <linux-ext4@vger.kernel.org>; Tue,  6 Jan 2026 14:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767709991; cv=none; b=VMKdbmcxaDVdaqklmNi268pPdi3C7uhU/0G0GN3PmV5xx1EsPbrNNg+UByxSQdz7rgkymKTZ3WYTWtP24vkXY/F2quSUIzuDInqoiYCKOrq9WRhF3ZkRdrAHsI5EBZqdIs+ETkzpfO2Y0ZN+3iWFcKzN3F0vfdlzrd6VD/M1wio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767709991; c=relaxed/simple;
	bh=FwDaNs5vxGRlfF5NScpjRLU4MXQwtkD91U6l8Mgp8cI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dloZex5Rw8R4OMDLzP6vJAH1+3MeYVygAt4l5HZyOjefDLSxvonl6eqy0Hbr8PEXWaYdceSAxC19ZTb06mSFxejXg9Mfbtmpz/DLXqsDOrBPdZfI5rviyp5S015746x9ADBNW2I7dtcwHFqU+e9akU87J5taaC93d/o7fB0/XxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QU14dtjX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4O3iJeNi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QU14dtjX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4O3iJeNi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 55D603368E;
	Tue,  6 Jan 2026 14:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767709988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gyQs/5mw6JnAmTJv1nUrqUsjmTTzDRbefLmBpqPsv4I=;
	b=QU14dtjX1+scQpvSubZ+EtBKcktRpNocsxr5HNmZi+/LBGZGkUtGIyOaECUARyNOjdVrcS
	js2jfnekSMpj+0LOQC8WxDUaDEMsqL6AjUcNw6Z8zzJ97N3g3GW+PWIePcmPX+3uz8O9VU
	/BsAa9fTzlDW/n8kLKNeYIoRlN7Lbp4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767709988;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gyQs/5mw6JnAmTJv1nUrqUsjmTTzDRbefLmBpqPsv4I=;
	b=4O3iJeNiSzEbTzttCvV/2ueHlOIf3vcMg/rclIejWdFE6eBnhYXuT4eOUtbrHwELh3HX3/
	Aa7YN809Zj11j5CA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767709988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gyQs/5mw6JnAmTJv1nUrqUsjmTTzDRbefLmBpqPsv4I=;
	b=QU14dtjX1+scQpvSubZ+EtBKcktRpNocsxr5HNmZi+/LBGZGkUtGIyOaECUARyNOjdVrcS
	js2jfnekSMpj+0LOQC8WxDUaDEMsqL6AjUcNw6Z8zzJ97N3g3GW+PWIePcmPX+3uz8O9VU
	/BsAa9fTzlDW/n8kLKNeYIoRlN7Lbp4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767709988;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gyQs/5mw6JnAmTJv1nUrqUsjmTTzDRbefLmBpqPsv4I=;
	b=4O3iJeNiSzEbTzttCvV/2ueHlOIf3vcMg/rclIejWdFE6eBnhYXuT4eOUtbrHwELh3HX3/
	Aa7YN809Zj11j5CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A9523EA63;
	Tue,  6 Jan 2026 14:33:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id B9PlESQdXWnzdgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 06 Jan 2026 14:33:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 05B59A0A4F; Tue,  6 Jan 2026 15:33:07 +0100 (CET)
Date: Tue, 6 Jan 2026 15:33:07 +0100
From: Jan Kara <jack@suse.cz>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, 
	Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>, Jan Kara <jack@suse.cz>, 
	libaokun1@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] ext4: propagate flags to convert_initialized_extent()
Message-ID: <dibws2hdldmuefxvotoeo2gitzxie6oc6uinfl33fh73jizh2w@t3us4sfqcb7l>
References: <cover.1767528171.git.ojaswin@linux.ibm.com>
 <a8078155d7d97e0fcaae1c576112033c84968aec.1767528171.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8078155d7d97e0fcaae1c576112033c84968aec.1767528171.git.ojaswin@linux.ibm.com>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,gmail.com,huawei.com,suse.cz];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.30

On Sun 04-01-26 17:49:16, Ojaswin Mujoo wrote:
> Currently, ext4_zero_range passes EXT4_EX_NOCACHE flag to avoid caching
> extents however this is not respected by convert_initialized_extent().
> Hence, modify it to accept flags from the caller and to pass the flags
> on to other extent manipulation functions it calls. This makes
> sure the NOCACHE flag is respected throughout the code path.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>  fs/ext4/extents-test.c | 2 +-
>  fs/ext4/extents.c      | 5 +++--
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/extents-test.c b/fs/ext4/extents-test.c
> index 4fb94d3c8a1e..54aed3eabfe2 100644
> --- a/fs/ext4/extents-test.c
> +++ b/fs/ext4/extents-test.c
> @@ -422,7 +422,7 @@ static void test_convert_initialized(struct kunit *test)
>  
>  	map.m_lblk = param->split_map.m_lblk;
>  	map.m_len = param->split_map.m_len;
> -	convert_initialized_extent(NULL, inode, &map, path, &allocated);
> +	convert_initialized_extent(NULL, inode, &map, path, 0, &allocated);
>  
>  	path = ext4_find_extent(inode, EX_DATA_LBLK, NULL, 0);
>  	ex = path->p_ext;
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 0ad0a9f2e3d4..5228196f5ad4 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3845,6 +3845,7 @@ static struct ext4_ext_path *
>  convert_initialized_extent(handle_t *handle, struct inode *inode,
>  			   struct ext4_map_blocks *map,
>  			   struct ext4_ext_path *path,
> +			   int flags,
>  			   unsigned int *allocated)
>  {
>  	struct ext4_extent *ex;
> @@ -3870,7 +3871,7 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
>  
>  	if (ee_block != map->m_lblk || ee_len > map->m_len) {
>  		path = ext4_split_convert_extents(handle, inode, map, path,
> -				EXT4_GET_BLOCKS_CONVERT_UNWRITTEN, NULL);
> +				flags | EXT4_GET_BLOCKS_CONVERT_UNWRITTEN, NULL);

No need to keep EXT4_GET_BLOCKS_CONVERT_UNWRITTEN here as the caller has
it in flags already? Otherwise the patch looks good.

								Honza

>  		if (IS_ERR(path))
>  			return path;
>  
> @@ -4264,7 +4265,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
>  			if ((!ext4_ext_is_unwritten(ex)) &&
>  			    (flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN)) {
>  				path = convert_initialized_extent(handle,
> -					inode, map, path, &allocated);
> +					inode, map, path, flags, &allocated);
>  				if (IS_ERR(path))
>  					err = PTR_ERR(path);
>  				goto out;
> -- 
> 2.51.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

