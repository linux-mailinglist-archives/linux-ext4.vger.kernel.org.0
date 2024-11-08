Return-Path: <linux-ext4+bounces-5005-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDE99C1B11
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Nov 2024 11:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BF5C1F236A9
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Nov 2024 10:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE531E2837;
	Fri,  8 Nov 2024 10:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sFpc/35e";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RdZ2ymFj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sFpc/35e";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RdZ2ymFj"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B2447F69;
	Fri,  8 Nov 2024 10:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731062977; cv=none; b=q5rFd3TwMnpowekR7jgKMPKgNlZ1spYYRNmQyFlvg46N1LoiqhOGqCtsQ61+yFPRUhuf0ESMICHfa5tbZzCV3vKZ8W+jZBjVXLFQRmny3lJJEJRBJixQqRWsANtANNtmi3XIk2F/YGiDOQPv7c7pamzcW7ursuQ5lvuRuXJXYFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731062977; c=relaxed/simple;
	bh=I2TcoAr6ba9SmBD1hiOkoEeZk5oREThPwPUftOKlD3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZohkcVQ0GUS2rGaWHKOWuLprq3/xqwlUWJO6FTVMIlnORzMRPaTcH0kdJsErVTvsKGIUPbqyhuy2me2FXxfHovBBfhQfZxPsDUZ4dRbqwh+vZFfR2A8JGU87EyMpm4b05jiuaixq2zsq+jzAQwV7PRaI6mkWOZyzPxZBHfUoJZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sFpc/35e; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RdZ2ymFj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sFpc/35e; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RdZ2ymFj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BC5FC1F456;
	Fri,  8 Nov 2024 10:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731062966; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=09YtlxHh/SlXtH0ER2V5eom4KI60eIvbinVvbwoqYy8=;
	b=sFpc/35eCO54m2JAT8X3xd/CuZPy2GNorPaGRzR84vUo+VbQZQBfQ2yja9ABRP1TXpbhLR
	70gHBYPidAgYqHZSAfh+MrenWd92su3zyjeeyGceG0s5ZZYcEt4dMblMgwVJLQWDc3mz9m
	/hXZiBnOqXFGClSLy4e+gVqOcIWTk14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731062966;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=09YtlxHh/SlXtH0ER2V5eom4KI60eIvbinVvbwoqYy8=;
	b=RdZ2ymFjZoq5A+HdlxnPtaSnlk/nH+o5DItkRTT2nNX1Y9SVIBRoN2npE8/VSACXRimC2+
	nxSdKg7EdXxR2HCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731062966; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=09YtlxHh/SlXtH0ER2V5eom4KI60eIvbinVvbwoqYy8=;
	b=sFpc/35eCO54m2JAT8X3xd/CuZPy2GNorPaGRzR84vUo+VbQZQBfQ2yja9ABRP1TXpbhLR
	70gHBYPidAgYqHZSAfh+MrenWd92su3zyjeeyGceG0s5ZZYcEt4dMblMgwVJLQWDc3mz9m
	/hXZiBnOqXFGClSLy4e+gVqOcIWTk14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731062966;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=09YtlxHh/SlXtH0ER2V5eom4KI60eIvbinVvbwoqYy8=;
	b=RdZ2ymFjZoq5A+HdlxnPtaSnlk/nH+o5DItkRTT2nNX1Y9SVIBRoN2npE8/VSACXRimC2+
	nxSdKg7EdXxR2HCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B03AE1394A;
	Fri,  8 Nov 2024 10:49:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FKsGK7bsLWenPAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 08 Nov 2024 10:49:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5FECAA0AF4; Fri,  8 Nov 2024 11:49:26 +0100 (CET)
Date: Fri, 8 Nov 2024 11:49:26 +0100
From: Jan Kara <jack@suse.cz>
To: Mathieu Othacehe <othacehe@gnu.org>
Cc: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	lukas.skupinski@landisgyr.com, anton.reding@landisgyr.com
Subject: Re: [PATCH 1/1] ext4: Prevent an infinite loop in the lazyinit
 thread.
Message-ID: <20241108104926.3khlr3csbculamub@quack3>
References: <20241106134741.26948-1-othacehe@gnu.org>
 <20241106134741.26948-2-othacehe@gnu.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106134741.26948-2-othacehe@gnu.org>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gnu.org:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 06-11-24 14:47:41, Mathieu Othacehe wrote:
> Use ktime_get_ns instead of ktime_get_real_ns when computing the lr_timeout
> not to be affected by system time jumps.
> 
> Use a boolean instead of the MAX_JIFFY_OFFSET value to determine whether
> the next_wakeup value has been set. Comparing elr->lr_next_sched to
> MAX_JIFFY_OFFSET can cause the lazyinit thread to loop indefinitely.
> 
> Co-developed-by: Lukas Skupinski <lukas.skupinski@landisgyr.com>
> Signed-off-by: Lukas Skupinski <lukas.skupinski@landisgyr.com>
> Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>

Nice catch! The patch looks good so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

But the analysis you've done in patch 0/1 would ideally be in the changelog
of this patch so that we can easily get back to it in the future in git logs.
Maybe Ted can handle that on commit?

								Honza

> ---
>  fs/ext4/super.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 9fcf44064c6a6..b4839ccd83ad5 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -3712,12 +3712,12 @@ static int ext4_run_li_request(struct ext4_li_request *elr)
>  		ret = 1;
>  
>  	if (!ret) {
> -		start_time = ktime_get_real_ns();
> +		start_time = ktime_get_ns();
>  		ret = ext4_init_inode_table(sb, group,
>  					    elr->lr_timeout ? 0 : 1);
>  		trace_ext4_lazy_itable_init(sb, group);
>  		if (elr->lr_timeout == 0) {
> -			elr->lr_timeout = nsecs_to_jiffies((ktime_get_real_ns() - start_time) *
> +			elr->lr_timeout = nsecs_to_jiffies((ktime_get_ns() - start_time) *
>  				EXT4_SB(elr->lr_super)->s_li_wait_mult);
>  		}
>  		elr->lr_next_sched = jiffies + elr->lr_timeout;
> @@ -3777,8 +3777,9 @@ static int ext4_lazyinit_thread(void *arg)
>  
>  cont_thread:
>  	while (true) {
> -		next_wakeup = MAX_JIFFY_OFFSET;
> +		bool next_wakeup_initialized = false;
>  
> +		next_wakeup = 0;
>  		mutex_lock(&eli->li_list_mtx);
>  		if (list_empty(&eli->li_request_list)) {
>  			mutex_unlock(&eli->li_list_mtx);
> @@ -3791,8 +3792,11 @@ static int ext4_lazyinit_thread(void *arg)
>  					 lr_request);
>  
>  			if (time_before(jiffies, elr->lr_next_sched)) {
> -				if (time_before(elr->lr_next_sched, next_wakeup))
> +				if (!next_wakeup_initialized ||
> +				    time_before(elr->lr_next_sched, next_wakeup)) {
>  					next_wakeup = elr->lr_next_sched;
> +					next_wakeup_initialized = true;
> +				}
>  				continue;
>  			}
>  			if (down_read_trylock(&elr->lr_super->s_umount)) {
> @@ -3820,16 +3824,18 @@ static int ext4_lazyinit_thread(void *arg)
>  				elr->lr_next_sched = jiffies +
>  					get_random_u32_below(EXT4_DEF_LI_MAX_START_DELAY * HZ);
>  			}
> -			if (time_before(elr->lr_next_sched, next_wakeup))
> +			if (!next_wakeup_initialized ||
> +			    time_before(elr->lr_next_sched, next_wakeup)) {
>  				next_wakeup = elr->lr_next_sched;
> +				next_wakeup_initialized = true;
> +			}
>  		}
>  		mutex_unlock(&eli->li_list_mtx);
>  
>  		try_to_freeze();
>  
>  		cur = jiffies;
> -		if ((time_after_eq(cur, next_wakeup)) ||
> -		    (MAX_JIFFY_OFFSET == next_wakeup)) {
> +		if (!next_wakeup_initialized || time_after_eq(cur, next_wakeup)) {
>  			cond_resched();
>  			continue;
>  		}
> -- 
> 2.46.0
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

