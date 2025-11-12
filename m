Return-Path: <linux-ext4+bounces-11827-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E7BC534E2
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Nov 2025 17:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 56B475661BB
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Nov 2025 15:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE0E3385BE;
	Wed, 12 Nov 2025 15:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JC/2mvv7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AtVOsWKT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JC/2mvv7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AtVOsWKT"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E3F27E7EC
	for <linux-ext4@vger.kernel.org>; Wed, 12 Nov 2025 15:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762963058; cv=none; b=EGgY+M/blYk/XlEeQLKtJd2h/sBnzUaOsrkabEKWDx5xm5fPbSvyU7vxQd5KwalTDdvCp73djA+FR/s5RSaS0q+x+lmhPesJTFNiROpXukN1bJwV4ECz2etZYFj7/wXZvfNqQE+6XD3rXDjrloakRAck0/AOk/pLR6uIDLTxsqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762963058; c=relaxed/simple;
	bh=8IfGrcNDfjAXTmVInxj0ypQxDSqSAByraKqszCASrWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ayKjC4W7qLBtB707KcWghAjG+4HKzH2/z43hhPI04soyMF+w+g5XDf/6jkUhFZa6prPseYWrKgssiSzjMwI07MBsyadY62bhdlZjp0nWqVO7KVSkwfaCTMmxIXpYy+sSs+sZWogc68U/RpKAN3MrI7eO8sF5jeT0Yo0sNjmXS7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JC/2mvv7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AtVOsWKT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JC/2mvv7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AtVOsWKT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3A6681F7EC;
	Wed, 12 Nov 2025 15:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762963055; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OlmEZwH04UfCIRcxPM58fl4ppWhMTD09ZsyALxO8U54=;
	b=JC/2mvv7RwK54GCW7dqWPAc8n7tVcbcQqbITh8MJppE07j52YINnsbD2JqAfeyLkyWeIOj
	Afw4LYJj/K2DykfjhVpDcI/mewwZVxuZ15ep29Tm0AQDb2IZdkO6xoN/0xOtliLTmoA/02
	pp2lmXiFQgLJ0aS+upPUGHVv8vmnvQs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762963055;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OlmEZwH04UfCIRcxPM58fl4ppWhMTD09ZsyALxO8U54=;
	b=AtVOsWKTdkHo2bgCV5byVLDXr3xeYpsuJgt2W8tmXBjTOEZ6Bjb0sRn2xHPiYuMZTA4+jo
	n+OncV322rpMc2Aw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="JC/2mvv7";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=AtVOsWKT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762963055; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OlmEZwH04UfCIRcxPM58fl4ppWhMTD09ZsyALxO8U54=;
	b=JC/2mvv7RwK54GCW7dqWPAc8n7tVcbcQqbITh8MJppE07j52YINnsbD2JqAfeyLkyWeIOj
	Afw4LYJj/K2DykfjhVpDcI/mewwZVxuZ15ep29Tm0AQDb2IZdkO6xoN/0xOtliLTmoA/02
	pp2lmXiFQgLJ0aS+upPUGHVv8vmnvQs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762963055;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OlmEZwH04UfCIRcxPM58fl4ppWhMTD09ZsyALxO8U54=;
	b=AtVOsWKTdkHo2bgCV5byVLDXr3xeYpsuJgt2W8tmXBjTOEZ6Bjb0sRn2xHPiYuMZTA4+jo
	n+OncV322rpMc2Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1D2A63EA61;
	Wed, 12 Nov 2025 15:57:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id F6gYB2+uFGnaDAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 12 Nov 2025 15:57:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AE06EA06F7; Wed, 12 Nov 2025 16:57:34 +0100 (CET)
Date: Wed, 12 Nov 2025 16:57:34 +0100
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, linux-kernel@vger.kernel.org, kernel@pankajraghav.com, 
	mcgrof@kernel.org, ebiggers@kernel.org, willy@infradead.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, chengzhihao1@huawei.com, libaokun1@huawei.com
Subject: Re: [PATCH v3 22/24] ext4: support verifying data from large folios
 with fs-verity
Message-ID: <bs3vcttp6r7bmdrwo45rx2kn2zlqmnjyeiqdmr4dlda7ti3u6v@hkv5pnk4jmew>
References: <20251111142634.3301616-1-libaokun@huaweicloud.com>
 <20251111142634.3301616-23-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111142634.3301616-23-libaokun@huaweicloud.com>
X-Rspamd-Queue-Id: 3A6681F7EC
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -0.21
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.21 / 50.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	R_DKIM_ALLOW(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,suse.com:email,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,huaweicloud.com:email]
X-Spamd-Bar: /

On Tue 11-11-25 22:26:32, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Eric Biggers already added support for verifying data from large folios
> several years ago in commit 5d0f0e57ed90 ("fsverity: support verifying
> data from large folios").
> 
> With ext4 now supporting large block sizes, the fs-verity tests
> `kvm-xfstests -c ext4/64k -g verity -x encrypt` pass without issues.
> 
> Therefore, remove the restriction and allow large folios to be enabled
> together with fs-verity.
> 
> Cc: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 613a989bf750..7b979e64f481 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5152,8 +5152,6 @@ static bool ext4_should_enable_large_folio(struct inode *inode)
>  
>  	if (!S_ISREG(inode->i_mode))
>  		return false;
> -	if (ext4_has_feature_verity(sb))
> -		return false;
>  	if (ext4_has_feature_encrypt(sb))
>  		return false;
>  
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

