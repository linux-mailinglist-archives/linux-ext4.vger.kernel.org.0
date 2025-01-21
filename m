Return-Path: <linux-ext4+bounces-6180-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA0FA17E9F
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jan 2025 14:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4E43188213C
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jan 2025 13:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA861F2399;
	Tue, 21 Jan 2025 13:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rjeTVmWO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tPzeuX6O";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rjeTVmWO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tPzeuX6O"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194BD1F2398;
	Tue, 21 Jan 2025 13:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737465186; cv=none; b=lISaLnaNMgo4aNxHojUPO85Awww0J22mNBy7v9r26EpOmbtQq9ZER+bKdEztrGs44tH61AxDvDcn8e/pP4kemJVqcuBQG+WAbhBeifXAZsVx040rArRLtJqMaERKhro+2MftFYAfZwydCBU84C/twKisbnh7RVS8dK3RaDmIf3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737465186; c=relaxed/simple;
	bh=DOr2ejCYR1sqe66iC85Od2J1zNLZvhlwtmRE7NP9q8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nz/NHiZZFCY89mxTjv1F8rUdhrZQxYZw0klVRbJ9fmi56FTbMgln4oWZUWpH1Rcqvr1i4+8eSmAMfNEzFPZc9qwK5SM+5aCYbPvYZbnvNc/yeWdJmJTK4MfPedHlj30tw03INyaX/IsVLVyETGahtBFaYuaMxeghWL5ZJo2KEi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rjeTVmWO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tPzeuX6O; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rjeTVmWO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tPzeuX6O; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F0370211CF;
	Tue, 21 Jan 2025 13:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737465183; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2fQEZrztLiyHDXCbjP5cv3PNHxmMx6mSCntWGbhFBsA=;
	b=rjeTVmWOOTwupFnIlvH/NCmuiGOzIUxysP7fXM8PrgD7io/sCfNZmwFEvUlqI+n9+QuBgI
	KuJB5JwAv6TYnPNQ/RMiHWfBMbFohu5P6zn1hL2aFNBQ7S9PRKCcX172muMWerWH2siJTL
	sNSf+6SPxsqQKECGhcRiBLq5PZkwgY4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737465183;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2fQEZrztLiyHDXCbjP5cv3PNHxmMx6mSCntWGbhFBsA=;
	b=tPzeuX6OubS51GF7NqE/J0n6DuEkkk/0DFix8UtYm3EwogagIIkugCmmZXmV5f8JEfW7jn
	8QHpBNUJdCxFpNAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=rjeTVmWO;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=tPzeuX6O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737465183; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2fQEZrztLiyHDXCbjP5cv3PNHxmMx6mSCntWGbhFBsA=;
	b=rjeTVmWOOTwupFnIlvH/NCmuiGOzIUxysP7fXM8PrgD7io/sCfNZmwFEvUlqI+n9+QuBgI
	KuJB5JwAv6TYnPNQ/RMiHWfBMbFohu5P6zn1hL2aFNBQ7S9PRKCcX172muMWerWH2siJTL
	sNSf+6SPxsqQKECGhcRiBLq5PZkwgY4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737465183;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2fQEZrztLiyHDXCbjP5cv3PNHxmMx6mSCntWGbhFBsA=;
	b=tPzeuX6OubS51GF7NqE/J0n6DuEkkk/0DFix8UtYm3EwogagIIkugCmmZXmV5f8JEfW7jn
	8QHpBNUJdCxFpNAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E5DF61387C;
	Tue, 21 Jan 2025 13:13:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id liEdOF6dj2fZJgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 21 Jan 2025 13:13:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id ADC03A0889; Tue, 21 Jan 2025 14:13:02 +0100 (CET)
Date: Tue, 21 Jan 2025 14:13:02 +0100
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, linux-kernel@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH 6/7] ext4: show 'emergency_ro' when
 EXT4_FLAGS_EMERGENCY_RO is set
Message-ID: <mujtxh55om7ykgngu47ujkweevk73fkaqjctkbpboh256boqmd@ortnetu3opdr>
References: <20250117082315.2869996-1-libaokun@huaweicloud.com>
 <20250117082315.2869996-7-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117082315.2869996-7-libaokun@huaweicloud.com>
X-Rspamd-Queue-Id: F0370211CF
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Fri 17-01-25 16:23:14, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> After commit d3476f3dad4a ("ext4: don't set SB_RDONLY after filesystem
> errors") in v6.12-rc1, the 'errors=remount-ro' mode no longer sets
> SB_RDONLY on errors, which results in us seeing the filesystem is still
> in rw state after errors.
> 
> Therefore, after setting EXT4_FLAGS_EMERGENCY_RO, display the emergency_ro
> option so that users can query whether the current file system has become
> emergency read-only due to errors through commands such as 'mount' or
> 'cat /proc/fs/ext4/sdx/options'.
> 
> Fixes: d3476f3dad4a ("ext4: don't set SB_RDONLY after filesystem errors")
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/super.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 8d9ac8770764..2377ebf0aff1 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -3029,6 +3029,9 @@ static int _ext4_show_options(struct seq_file *seq, struct super_block *sb,
>  	if (nodefs && !test_opt(sb, NO_PREFETCH_BLOCK_BITMAPS))
>  		SEQ_OPTS_PUTS("prefetch_block_bitmaps");
>  
> +	if (ext4_emergency_ro(sb))
> +		SEQ_OPTS_PUTS("emergency_ro");
> +
>  	ext4_show_quota_options(seq, sb);
>  	return 0;
>  }
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

