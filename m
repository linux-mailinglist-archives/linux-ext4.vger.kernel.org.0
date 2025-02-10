Return-Path: <linux-ext4+bounces-6399-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E704EA2F401
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Feb 2025 17:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B715F1889772
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Feb 2025 16:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B88257458;
	Mon, 10 Feb 2025 16:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jan3slyd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yIQz3bkY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rjgwgED4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="J9StZ2VT"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB24725744C
	for <linux-ext4@vger.kernel.org>; Mon, 10 Feb 2025 16:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739205944; cv=none; b=PH7rdQk6vxIwmYB71+Ka2hXCE1Z14fboWbAKCux1slvnJqQN8Ve/Fot5BWmk9TfFiECwMj+ihTuRsZyzrFmSmiM176CeltuR/SQRRKn/DhvtYhF/EpuJFVfEA+mKENBPbdSSaqmc9fU/Xn6SVVjk6zRW5mkpC8yeVTTL5+TfzKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739205944; c=relaxed/simple;
	bh=mFmW354excnYvqNYG6WMJA9TuCEmT/y0YDqXfw4lKis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HHGZNP3a4yggcXOj6VwfA248iFRhff6a5qZ3mujhZJM0GOM2VcdJm8fqZhV3yezfTrRg4IeIfB15A7uvBAhQsFsJBu8KyFSoiraj9Loj4cOYoNMMJ93v7zRNvZjoEx8GsW74lDvAy/Q0p08/iiNtZoYeJcmvTCAK26FfbqoReWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jan3slyd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yIQz3bkY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rjgwgED4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=J9StZ2VT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D6C751F38F;
	Mon, 10 Feb 2025 16:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739205941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3O7asunnzhLLKP0mHcBrFObg1YFRVPmMqFNvMUV6g6g=;
	b=jan3slydqYiqQ+zEaKqNqFbZMEDmqIUyOt72MkwdJ1RMMN07sB+FTKqWf36/1K9lGT68iu
	4ONzBiZRNHmElhRv4fWBbcDkeGGN1ZmK/HLsxllyW+9lx8Cauw2T06hBKK3CFqKqd4q/i+
	frFPEj5xxOsTJQiUnqh9Ad93FlVh+k4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739205941;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3O7asunnzhLLKP0mHcBrFObg1YFRVPmMqFNvMUV6g6g=;
	b=yIQz3bkYQHWOwshy8nI8cv42anoF0OnsbkZnpn7ef9CwZblPFvCQ4mJWgOCP3l98YLboqi
	WBlR7f7D6pulsgBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739205940; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3O7asunnzhLLKP0mHcBrFObg1YFRVPmMqFNvMUV6g6g=;
	b=rjgwgED4UzGKoWSY9+NFZy9eM0hmQJOaoXuU2pw/Db+hF+TL2k2h6q9ty7Q1giNq7XGEDc
	bSdiIsJVfVfdIRVduTCj5fK/FWSDHaeyw3USCbpMy/KHGJywOLKxPT+WHEzvOzOBfrDpZb
	O4l7OQkAfBBzenXQUoqhbcm8L+4Fdwc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739205940;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3O7asunnzhLLKP0mHcBrFObg1YFRVPmMqFNvMUV6g6g=;
	b=J9StZ2VTE/ZNqmUA5dODI50fgOTtFbR6QNLtnT3uLxZgcTQ4bAZXG8U/Q1Nbn2Ekzmz1fy
	mYbn3lck1tT9H3CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BE17D13707;
	Mon, 10 Feb 2025 16:45:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2CBbLjQtqmd2UgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 10 Feb 2025 16:45:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 72024A095C; Mon, 10 Feb 2025 17:45:36 +0100 (CET)
Date: Mon, 10 Feb 2025 17:45:36 +0100
From: Jan Kara <jack@suse.cz>
To: Ye Bin <yebin@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	jack@suse.cz
Subject: Re: [PATCH v2 1/2] ext4: introduce ITAIL helper
Message-ID: <bzmyqn5mi3kwuzu43mntb525hlzg5uwp5n3vfyzmrctyrdsogn@3heqqo3zj26u>
References: <20250208063141.1539283-1-yebin@huaweicloud.com>
 <20250208063141.1539283-2-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250208063141.1539283-2-yebin@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,huawei.com:email,suse.cz:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Sat 08-02-25 14:31:40, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> Introduce ITAIL helper to get the bound of xattr in inode.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/xattr.c | 10 +++++-----
>  fs/ext4/xattr.h |  3 +++
>  2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 7647e9f6e190..0e4494863d15 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -649,7 +649,7 @@ ext4_xattr_ibody_get(struct inode *inode, int name_index, const char *name,
>  		return error;
>  	raw_inode = ext4_raw_inode(&iloc);
>  	header = IHDR(inode, raw_inode);
> -	end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
> +	end = ITAIL(inode, raw_inode);
>  	error = xattr_check_inode(inode, header, end);
>  	if (error)
>  		goto cleanup;
> @@ -793,7 +793,7 @@ ext4_xattr_ibody_list(struct dentry *dentry, char *buffer, size_t buffer_size)
>  		return error;
>  	raw_inode = ext4_raw_inode(&iloc);
>  	header = IHDR(inode, raw_inode);
> -	end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
> +	end = ITAIL(inode, raw_inode);
>  	error = xattr_check_inode(inode, header, end);
>  	if (error)
>  		goto cleanup;
> @@ -879,7 +879,7 @@ int ext4_get_inode_usage(struct inode *inode, qsize_t *usage)
>  			goto out;
>  		raw_inode = ext4_raw_inode(&iloc);
>  		header = IHDR(inode, raw_inode);
> -		end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
> +		end = ITAIL(inode, raw_inode);
>  		ret = xattr_check_inode(inode, header, end);
>  		if (ret)
>  			goto out;
> @@ -2235,7 +2235,7 @@ int ext4_xattr_ibody_find(struct inode *inode, struct ext4_xattr_info *i,
>  	header = IHDR(inode, raw_inode);
>  	is->s.base = is->s.first = IFIRST(header);
>  	is->s.here = is->s.first;
> -	is->s.end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
> +	is->s.end = ITAIL(inode, raw_inode);
>  	if (ext4_test_inode_state(inode, EXT4_STATE_XATTR)) {
>  		error = xattr_check_inode(inode, header, is->s.end);
>  		if (error)
> @@ -2786,7 +2786,7 @@ int ext4_expand_extra_isize_ea(struct inode *inode, int new_extra_isize,
>  	 */
>  
>  	base = IFIRST(header);
> -	end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
> +	end = ITAIL(inode, raw_inode);
>  	min_offs = end - base;
>  	total_ino = sizeof(struct ext4_xattr_ibody_header) + sizeof(u32);
>  
> diff --git a/fs/ext4/xattr.h b/fs/ext4/xattr.h
> index b25c2d7b5f99..5197f17ffd9a 100644
> --- a/fs/ext4/xattr.h
> +++ b/fs/ext4/xattr.h
> @@ -67,6 +67,9 @@ struct ext4_xattr_entry {
>  		((void *)raw_inode + \
>  		EXT4_GOOD_OLD_INODE_SIZE + \
>  		EXT4_I(inode)->i_extra_isize))
> +#define ITAIL(inode, raw_inode) \
> +	((void *)(raw_inode) + \
> +	 EXT4_SB((inode)->i_sb)->s_inode_size)
>  #define IFIRST(hdr) ((struct ext4_xattr_entry *)((hdr)+1))
>  
>  /*
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

