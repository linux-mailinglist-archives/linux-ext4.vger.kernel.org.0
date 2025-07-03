Return-Path: <linux-ext4+bounces-8803-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2002AF7E13
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Jul 2025 18:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E7571889776
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Jul 2025 16:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F1E2580DD;
	Thu,  3 Jul 2025 16:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="i2pt2sJQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rlb/8en7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="i2pt2sJQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rlb/8en7"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90148158535
	for <linux-ext4@vger.kernel.org>; Thu,  3 Jul 2025 16:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751560916; cv=none; b=NgtdmQ1FYToLg9mjoW6RDfw+RmuWNWm44jBPvBFSVcEvJW1dlaArWanYATjCYj2MXX/HbuELpjpoUOt6kmSciH+/hzGaCR3CCZRBzodF3zxDdNHR5X3bGn3lke4pNMVMGaZFTtiDI714/DB3Rf8u52GAAv5BQ8wqz5if6Id7enY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751560916; c=relaxed/simple;
	bh=eALA3TRhYTgHttXWZ8fc2vctoM6c+mBtTseDBawNElo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SqpSbDq8olLJbju/dQShqBgD0ZwZUWn59bVYIs8IXYBc0NafItRBH33TIns0NvfPnlQk6Ml8ji88Rt0I8j7IJWa3U9xYw/2ptPXco+rW8pLCnvbu/fwvHAg/yb5Lvkv5v7IqW9hCLAn/I1kaaLhGqSsJ36vAlg35k26F4aSjCWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=i2pt2sJQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rlb/8en7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=i2pt2sJQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rlb/8en7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BEE5E210F3;
	Thu,  3 Jul 2025 16:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751560912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mL125oyuZxBODWkamkQ92+oqml0BgJm5qTBT4RYwE4Y=;
	b=i2pt2sJQwwmABuBKvGWQWILt8mnTXRKnS2GPUZvTWpvvZ9aJBWERgmGO90jXL/rJBKAozW
	OG91ItkgSuTdR2c2LBdbi2BaQxHnjGwRqvy0sXE2B6hH2CyPipcJLhg6nfdOvYz65E9JMk
	UFa5Fe/ujvAaFxo3cmUl3f+ww/7ZnDU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751560912;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mL125oyuZxBODWkamkQ92+oqml0BgJm5qTBT4RYwE4Y=;
	b=rlb/8en7amV9YFOyiv3IGCZXuvOWY2128/AKYY5SXzOVxwKlwj7+H0321phnss6iO72lRl
	UBRs4RevXDQnePBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751560912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mL125oyuZxBODWkamkQ92+oqml0BgJm5qTBT4RYwE4Y=;
	b=i2pt2sJQwwmABuBKvGWQWILt8mnTXRKnS2GPUZvTWpvvZ9aJBWERgmGO90jXL/rJBKAozW
	OG91ItkgSuTdR2c2LBdbi2BaQxHnjGwRqvy0sXE2B6hH2CyPipcJLhg6nfdOvYz65E9JMk
	UFa5Fe/ujvAaFxo3cmUl3f+ww/7ZnDU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751560912;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mL125oyuZxBODWkamkQ92+oqml0BgJm5qTBT4RYwE4Y=;
	b=rlb/8en7amV9YFOyiv3IGCZXuvOWY2128/AKYY5SXzOVxwKlwj7+H0321phnss6iO72lRl
	UBRs4RevXDQnePBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B259E13721;
	Thu,  3 Jul 2025 16:41:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PgqJK9CyZmjGDwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 03 Jul 2025 16:41:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 364BDA0A48; Thu,  3 Jul 2025 18:41:48 +0200 (CEST)
Date: Thu, 3 Jul 2025 18:41:48 +0200
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, linux-kernel@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, libaokun1@huawei.com
Subject: Re: [PATCH 2/2] ext4: preserve SB_I_VERSION on remount
Message-ID: <6zslpjdu6urzex23d45n47myfzqmksphjz4bin6tpsxi7wqey2@nbmumzwl7255>
References: <20250703073903.6952-1-libaokun@huaweicloud.com>
 <20250703073903.6952-2-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703073903.6952-2-libaokun@huaweicloud.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.80

On Thu 03-07-25 15:39:03, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> IMA testing revealed that after an ext4 remount, file accesses triggered
> full measurements even without modifications, instead of skipping as
> expected when i_version is unchanged.
> 
> Debugging showed `SB_I_VERSION` was cleared in reconfigure_super() during
> remount due to commit 1ff20307393e ("ext4: unconditionally enable the
> i_version counter") removing the fix from commit 960e0ab63b2e ("ext4: fix
> i_version handling on remount").
> 
> To rectify this, `SB_I_VERSION` is always set for `fc->sb_flags` in
> ext4_init_fs_context(), instead of `sb->s_flags` in __ext4_fill_super(),
> ensuring it persists across all mounts.
> 
> Fixes: 1ff20307393e ("ext4: unconditionally enable the i_version counter")
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/super.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 9203518786e4..ed1b36bd51c8 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1998,6 +1998,9 @@ int ext4_init_fs_context(struct fs_context *fc)
>  	fc->fs_private = ctx;
>  	fc->ops = &ext4_context_ops;
>  
> +	/* i_version is always enabled now */
> +	fc->sb_flags |= SB_I_VERSION;
> +
>  	return 0;
>  }
>  
> @@ -5316,9 +5319,6 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  	sb->s_flags = (sb->s_flags & ~SB_POSIXACL) |
>  		(test_opt(sb, POSIX_ACL) ? SB_POSIXACL : 0);
>  
> -	/* i_version is always enabled now */
> -	sb->s_flags |= SB_I_VERSION;
> -
>  	/* HSM events are allowed by default. */
>  	sb->s_iflags |= SB_I_ALLOW_HSM;
>  
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

