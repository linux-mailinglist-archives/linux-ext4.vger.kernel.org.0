Return-Path: <linux-ext4+bounces-1629-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2AA87BB64
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Mar 2024 11:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 320071C21232
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Mar 2024 10:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399966EB6F;
	Thu, 14 Mar 2024 10:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JdnhuirQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4cSqTFJ+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JdnhuirQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4cSqTFJ+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F9060ED0;
	Thu, 14 Mar 2024 10:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710412552; cv=none; b=ZiaAMjCd5JsdB7YNqxBdWnmOpJgsyEYWUHeKs19clwl5DQrw2TpDeCaleBUzdHpQw21AJZRm8xx+pd6/HAtR8uOurWujs9PSyQQjJ/w9Jr13U1DVRt6HtYoz4zXhYsc9IETjyvc6L7m0u6FIn05RMgzk50Tr0YjGPmkUiGmgLgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710412552; c=relaxed/simple;
	bh=iVQmHZfRSgFp372oTb5qte+arj20Azd4hof81HMijXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+IochszdnbZfRIWMNznIyid5ekhx56irk9nMyN6Mnrg3zyCK0eMugIaY21yRkpotm/tuZKJZ8fsNTwAErlTkBjiVxN8NBAj4AUFgDCkKXz0ec67kDzqQ9B028Jtoxy6qElqJT/zssTayemqvgM0msURecwlGfo04ihyV/7KkIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JdnhuirQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4cSqTFJ+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JdnhuirQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4cSqTFJ+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B33C11F844;
	Thu, 14 Mar 2024 10:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710412548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+IbSwf0kLlVY+YSGAOOWzTXEUUs73aDovUc6HyI5Ht0=;
	b=JdnhuirQrz06DyYXYlRHNT80qG53FDfvwEgjgor/f8Yowq3cham85um5vUJR0os1RFup4v
	v+lPSA7yG2fGjEeKbIN3NIOytoTaJT/NPuZxJpWCbDCPCJa4zpw0IKHnadfG08XcmBusi1
	t+lexVX5oFHnYeuICsd6ECfhUwTVxiQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710412548;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+IbSwf0kLlVY+YSGAOOWzTXEUUs73aDovUc6HyI5Ht0=;
	b=4cSqTFJ+6nZERUOZLOn3wjZH9wJ/hNZq4N/WUWY5XANLs2frwKc14DsxrkAGhZdJTGRY9o
	XM/UQGjgqAv3AfCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710412548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+IbSwf0kLlVY+YSGAOOWzTXEUUs73aDovUc6HyI5Ht0=;
	b=JdnhuirQrz06DyYXYlRHNT80qG53FDfvwEgjgor/f8Yowq3cham85um5vUJR0os1RFup4v
	v+lPSA7yG2fGjEeKbIN3NIOytoTaJT/NPuZxJpWCbDCPCJa4zpw0IKHnadfG08XcmBusi1
	t+lexVX5oFHnYeuICsd6ECfhUwTVxiQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710412548;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+IbSwf0kLlVY+YSGAOOWzTXEUUs73aDovUc6HyI5Ht0=;
	b=4cSqTFJ+6nZERUOZLOn3wjZH9wJ/hNZq4N/WUWY5XANLs2frwKc14DsxrkAGhZdJTGRY9o
	XM/UQGjgqAv3AfCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A84E2139E7;
	Thu, 14 Mar 2024 10:35:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id F1cVKQTT8mVFUQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 14 Mar 2024 10:35:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 65702A07D9; Thu, 14 Mar 2024 11:35:44 +0100 (CET)
Date: Thu, 14 Mar 2024 11:35:44 +0100
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
	adobriyan@gmail.com, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 8/9] ext4: set the type of max_zeroout to unsigned int
 to avoid overflow
Message-ID: <20240314103544.s37lbhwrkhwx6l3j@quack3>
References: <20240227091148.178435-1-libaokun1@huawei.com>
 <20240227091148.178435-9-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227091148.178435-9-libaokun1@huawei.com>
X-Spamd-Bar: +
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=JdnhuirQ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4cSqTFJ+
X-Spamd-Result: default: False [1.46 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 BAYES_HAM(-0.23)[72.66%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim,huawei.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,linux.ibm.com,huawei.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: 1.46
X-Spam-Level: *
X-Rspamd-Queue-Id: B33C11F844
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Tue 27-02-24 17:11:47, Baokun Li wrote:
> The max_zeroout is of type int and the s_extent_max_zeroout_kb is of
> type uint, and the s_extent_max_zeroout_kb can be freely modified via
> the sysfs interface. When the block size is 1024, max_zeroout may
> overflow, so declare it as unsigned int to avoid overflow.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Indeed. The patch looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index e57054bdc5fd..e067f2dd0335 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3402,9 +3402,10 @@ static int ext4_ext_convert_to_initialized(handle_t *handle,
>  	struct ext4_extent *ex, *abut_ex;
>  	ext4_lblk_t ee_block, eof_block;
>  	unsigned int ee_len, depth, map_len = map->m_len;
> -	int allocated = 0, max_zeroout = 0;
>  	int err = 0;
>  	int split_flag = EXT4_EXT_DATA_VALID2;
> +	int allocated = 0;
> +	unsigned int max_zeroout = 0;
>  
>  	ext_debug(inode, "logical block %llu, max_blocks %u\n",
>  		  (unsigned long long)map->m_lblk, map_len);
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

