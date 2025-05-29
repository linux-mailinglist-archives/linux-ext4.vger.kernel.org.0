Return-Path: <linux-ext4+bounces-8230-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA200AC7E36
	for <lists+linux-ext4@lfdr.de>; Thu, 29 May 2025 14:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F5434E5040
	for <lists+linux-ext4@lfdr.de>; Thu, 29 May 2025 12:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E5C2253A8;
	Thu, 29 May 2025 12:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DOQMk1d3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4F7Wb77v";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DOQMk1d3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4F7Wb77v"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEDB224AEF
	for <linux-ext4@vger.kernel.org>; Thu, 29 May 2025 12:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748523448; cv=none; b=Tc0MlRQ9aqDe7bKpB4WTs5Pn+0HlSrMJ3fIl/sdGnVaGy71RFlTTBsQug1bH8mzFNAwZ1odlgbDx4pJdnXwluRAV34LaTe95s2trsRjLmOMCZAefqOE6soBGOcR0E08Hso5TnWh2SZocmVpz+yiHByniDsovGM3auA1Cu1YD8D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748523448; c=relaxed/simple;
	bh=cjoP8NS62TCo5JunwZXrBlLNfTl5heZZKd1x9Ef7AjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ip3y6QxydHSmxgdS8PPa7qwe0Y3UbgkwiCUur2hMY35WXgADsljRudNyzJGAhOMCk+IU1mD4Z/YctmjQ5Tz4A8J1FMkSNCkWD684bxnkLNlmScGM/oF1jKzlBvD8pcgQKQP/Sq3ymGqqXZWqgTWjx9unL+K2PWAJuhVe3a/UrJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DOQMk1d3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4F7Wb77v; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DOQMk1d3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4F7Wb77v; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 387DD21EC0;
	Thu, 29 May 2025 12:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748523444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=slwQZWUmU/HRceMI+dTrKNEShtzUoW7J/FQrUfwzvBc=;
	b=DOQMk1d3cM9LPyJkEcFYQ2aBxZXbcIjG7d4mF3ilSnPdn8P8xSPZ4cTmI2sINSChyH1NIg
	wh8a0+ee49TB6lj2JMGCwgADZqcg7wx95krY9XAsPYeOzIEaSQ642uzu09XDBxpY3ZB+Ha
	K+w22bO1lZuHU9nGeeU/jBKC6klsZ6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748523444;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=slwQZWUmU/HRceMI+dTrKNEShtzUoW7J/FQrUfwzvBc=;
	b=4F7Wb77v38d1bPM8SwjYRzJ725TvantNm8KZGCKCX16DKVfz7emmsnYVLkYS2ZwGFIoGb2
	CPlr5bWOwOSl0VAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=DOQMk1d3;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4F7Wb77v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748523444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=slwQZWUmU/HRceMI+dTrKNEShtzUoW7J/FQrUfwzvBc=;
	b=DOQMk1d3cM9LPyJkEcFYQ2aBxZXbcIjG7d4mF3ilSnPdn8P8xSPZ4cTmI2sINSChyH1NIg
	wh8a0+ee49TB6lj2JMGCwgADZqcg7wx95krY9XAsPYeOzIEaSQ642uzu09XDBxpY3ZB+Ha
	K+w22bO1lZuHU9nGeeU/jBKC6klsZ6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748523444;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=slwQZWUmU/HRceMI+dTrKNEShtzUoW7J/FQrUfwzvBc=;
	b=4F7Wb77v38d1bPM8SwjYRzJ725TvantNm8KZGCKCX16DKVfz7emmsnYVLkYS2ZwGFIoGb2
	CPlr5bWOwOSl0VAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2EDA1136E0;
	Thu, 29 May 2025 12:57:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lbxtC7RZOGjCLQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 29 May 2025 12:57:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E9DDCA09B5; Thu, 29 May 2025 14:57:23 +0200 (CEST)
Date: Thu, 29 May 2025 14:57:23 +0200
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, linux-kernel@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, libaokun1@huawei.com
Subject: Re: [PATCH 3/4] ext4: get rid of some obsolete EXT4_MB_HINT flags
Message-ID: <tjjoxmdseo6o6a6mb7h3jjqwcgbwmmfdjoom6zhtpkqlnorv6t@bkx2hixqtqcx>
References: <20250523085821.1329392-1-libaokun@huaweicloud.com>
 <20250523085821.1329392-4-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523085821.1329392-4-libaokun@huaweicloud.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 387DD21EC0
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:email,suse.com:email,huawei.com:email];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01
X-Spam-Level: 

On Fri 23-05-25 16:58:20, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Since nobody has used these EXT4_MB_HINT flags for ages,
> let's remove them.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ext4.h              | 6 ------
>  include/trace/events/ext4.h | 3 ---
>  2 files changed, 9 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 16c14dd09df6..f6d01702423d 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -185,14 +185,8 @@ enum criteria {
>  
>  /* prefer goal again. length */
>  #define EXT4_MB_HINT_MERGE		0x0001
> -/* blocks already reserved */
> -#define EXT4_MB_HINT_RESERVED		0x0002
> -/* metadata is being allocated */
> -#define EXT4_MB_HINT_METADATA		0x0004
>  /* first blocks in the file */
>  #define EXT4_MB_HINT_FIRST		0x0008
> -/* search for the best chunk */
> -#define EXT4_MB_HINT_BEST		0x0010
>  /* data is being allocated */
>  #define EXT4_MB_HINT_DATA		0x0020
>  /* don't preallocate (for tails) */
> diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
> index 156908641e68..33b204165cc0 100644
> --- a/include/trace/events/ext4.h
> +++ b/include/trace/events/ext4.h
> @@ -23,10 +23,7 @@ struct partial_cluster;
>  
>  #define show_mballoc_flags(flags) __print_flags(flags, "|",	\
>  	{ EXT4_MB_HINT_MERGE,		"HINT_MERGE" },		\
> -	{ EXT4_MB_HINT_RESERVED,	"HINT_RESV" },		\
> -	{ EXT4_MB_HINT_METADATA,	"HINT_MDATA" },		\
>  	{ EXT4_MB_HINT_FIRST,		"HINT_FIRST" },		\
> -	{ EXT4_MB_HINT_BEST,		"HINT_BEST" },		\
>  	{ EXT4_MB_HINT_DATA,		"HINT_DATA" },		\
>  	{ EXT4_MB_HINT_NOPREALLOC,	"HINT_NOPREALLOC" },	\
>  	{ EXT4_MB_HINT_GROUP_ALLOC,	"HINT_GRP_ALLOC" },	\
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

