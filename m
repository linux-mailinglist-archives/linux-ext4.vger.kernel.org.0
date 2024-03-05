Return-Path: <linux-ext4+bounces-1519-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 651F187212E
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Mar 2024 15:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 975AA1C21D07
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Mar 2024 14:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229368662A;
	Tue,  5 Mar 2024 14:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="R2mixKG7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lIPfLtV7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="R2mixKG7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lIPfLtV7"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEAB86122;
	Tue,  5 Mar 2024 14:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709647945; cv=none; b=m7QmT790jO419AuGovyxwPfTSG89Zo/lHtniEMadpyaLFf0wSwouK10Fv4h7VdLg+BJL6r2qBUkF9k1xO1hjhaIrCh1GN3XhzA/uyEntd89VwAGg3e8e/HsiJEEuvD109y7LKnLIAXoD2Pq/1Xe1sqLSQ9dT1U++Bse/JimNtUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709647945; c=relaxed/simple;
	bh=WMOyx1/2arZ861ZCxC5DQk646BMeZvDgyCfKFVfevyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Va18BQnZIXjBCW3+7JHXBAvaPGbQ4d1E9i0DUeY3XsRoszO8aU3VqmIG6HhRmC3B+r2L9pNkDu8WrXKboC99YjI/m2VzaiBV9xhdDF8JwfTX5gqHVB3o3oJkaV/rVDBl++aG5bYBWWaqOVrb0lghB8kEhiYlVxQVnCbDb12XiAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=R2mixKG7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lIPfLtV7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=R2mixKG7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lIPfLtV7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9A2776B3B9;
	Tue,  5 Mar 2024 14:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709647941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mVMBkO26srIvGNGxarIEl9k+TtBSK7K2iz5x0GMIPNI=;
	b=R2mixKG7Zh6QZR/Qh41CErDOndna+q/VFmZRP/msuxr/i8gbGrsUqZ9iwhPKkl5v78NzEZ
	WuKruK8UmBU4Uf3kt00M+/036KT46+co0g4T1MFJX8Rmukk/XxrVsaXb23+Wd9Z5U/Ysk/
	3QbUeHu1mp71P437KM70146pVvtdIlw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709647941;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mVMBkO26srIvGNGxarIEl9k+TtBSK7K2iz5x0GMIPNI=;
	b=lIPfLtV7U5aiOgX1FD84+no+5Dr9oyBWTCe+LcMVgXMb2DJm6O5FH80xG29ngUWag9mYE2
	sHkKBVYNTJWdHeDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709647941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mVMBkO26srIvGNGxarIEl9k+TtBSK7K2iz5x0GMIPNI=;
	b=R2mixKG7Zh6QZR/Qh41CErDOndna+q/VFmZRP/msuxr/i8gbGrsUqZ9iwhPKkl5v78NzEZ
	WuKruK8UmBU4Uf3kt00M+/036KT46+co0g4T1MFJX8Rmukk/XxrVsaXb23+Wd9Z5U/Ysk/
	3QbUeHu1mp71P437KM70146pVvtdIlw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709647941;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mVMBkO26srIvGNGxarIEl9k+TtBSK7K2iz5x0GMIPNI=;
	b=lIPfLtV7U5aiOgX1FD84+no+5Dr9oyBWTCe+LcMVgXMb2DJm6O5FH80xG29ngUWag9mYE2
	sHkKBVYNTJWdHeDA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 8CFC813A5D;
	Tue,  5 Mar 2024 14:12:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id I/BkIkUo52VtQwAAn2gu4w
	(envelope-from <jack@suse.cz>); Tue, 05 Mar 2024 14:12:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 31BF0A0650; Tue,  5 Mar 2024 15:12:21 +0100 (CET)
Date: Tue, 5 Mar 2024 15:12:21 +0100
From: Jan Kara <jack@suse.cz>
To: chengming.zhou@linux.dev
Cc: jack@suse.com, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, vbabka@suse.cz, roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH] ext2: remove SLAB_MEM_SPREAD flag usage
Message-ID: <20240305141221.um4zuvnro7tg5fgq@quack3>
References: <20240224134816.829424-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240224134816.829424-1-chengming.zhou@linux.dev>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.46 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.86)[99.42%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.46

On Sat 24-02-24 13:48:16, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
> its usage so we can delete it from slab. No functional change.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Thanks. I've added the patch to my tree.

								Honza

> ---
>  fs/ext2/super.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/ext2/super.c b/fs/ext2/super.c
> index 6d8587505cea..7162c61c0402 100644
> --- a/fs/ext2/super.c
> +++ b/fs/ext2/super.c
> @@ -213,8 +213,7 @@ static int __init init_inodecache(void)
>  {
>  	ext2_inode_cachep = kmem_cache_create_usercopy("ext2_inode_cache",
>  				sizeof(struct ext2_inode_info), 0,
> -				(SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD|
> -					SLAB_ACCOUNT),
> +				SLAB_RECLAIM_ACCOUNT|SLAB_ACCOUNT,
>  				offsetof(struct ext2_inode_info, i_data),
>  				sizeof_field(struct ext2_inode_info, i_data),
>  				init_once);
> -- 
> 2.40.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

