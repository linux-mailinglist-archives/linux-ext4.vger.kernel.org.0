Return-Path: <linux-ext4+bounces-11715-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DA8C45C9B
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Nov 2025 11:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C34DD3A3A20
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Nov 2025 10:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006C5303A0F;
	Mon, 10 Nov 2025 10:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gq1YL5Pt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="alLmBEl7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gq1YL5Pt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="alLmBEl7"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E4B30146B
	for <linux-ext4@vger.kernel.org>; Mon, 10 Nov 2025 10:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762768817; cv=none; b=cc3SaZ6tBEXyT72Hnm2Z7dsqlNud+PZkwPDbCNGoqb7tPbB2SlD1BfbCNst7d0CMJE8j6jl1H3a3fJ+AbFBBPDlk7WuUtCi9+hKV+82J8XsGnCqzthNTf/oPjCcKr0TzsrKT2kV8VSl84tzsnXZY3SKpEQ7RSCglVQDgZhyfk9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762768817; c=relaxed/simple;
	bh=1S45rXy67JOfQOgfopfl3Y9AwfCjJmREJmeNqKFTu/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pk5IaQkDhLU8KKB4R0y6zOO+BVa7/zRi2qYPdXSzQTunbbAQMt6MYuTvQrHEpRoNaQLg542vcDiE8NDQhCA//x2zRIoZ2UhKV4b2XV5Blu8dpsJYX2EbAr4mQLCD/35YRyACgIb018uKt/3EOVp3b3izuAYPr8V5hpx4ZmGGEp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gq1YL5Pt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=alLmBEl7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gq1YL5Pt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=alLmBEl7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C588421FAC;
	Mon, 10 Nov 2025 10:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762768813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ipR4VyTejIAnvTTF9cx/ky/Awfe1wSG17PtiHmQM6kk=;
	b=gq1YL5PtPapetZ895s1q1v72utsq/4OGgZHOPmpQKEBezGRYIOYsou6FvU5973eKGpiUFJ
	dQ9rAMc2iqwALSun3MlpsoFjz+nYpNl1LyEMDXl4knowCB7QeEzziTu2RqmVwgrV1wuaJx
	47nnLj3G333REQxUHuPJh3rqXan1jW0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762768813;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ipR4VyTejIAnvTTF9cx/ky/Awfe1wSG17PtiHmQM6kk=;
	b=alLmBEl7Iuin1bKZe4xkJ8sHUXku7f6JfJ8GK218aT0q8SP7IvFy6f9QbvCZ1gCsobmV1x
	VUAgPK3pJbjHXvCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=gq1YL5Pt;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=alLmBEl7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762768813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ipR4VyTejIAnvTTF9cx/ky/Awfe1wSG17PtiHmQM6kk=;
	b=gq1YL5PtPapetZ895s1q1v72utsq/4OGgZHOPmpQKEBezGRYIOYsou6FvU5973eKGpiUFJ
	dQ9rAMc2iqwALSun3MlpsoFjz+nYpNl1LyEMDXl4knowCB7QeEzziTu2RqmVwgrV1wuaJx
	47nnLj3G333REQxUHuPJh3rqXan1jW0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762768813;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ipR4VyTejIAnvTTF9cx/ky/Awfe1wSG17PtiHmQM6kk=;
	b=alLmBEl7Iuin1bKZe4xkJ8sHUXku7f6JfJ8GK218aT0q8SP7IvFy6f9QbvCZ1gCsobmV1x
	VUAgPK3pJbjHXvCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B8B501432A;
	Mon, 10 Nov 2025 10:00:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WucWLa23EWlzCAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 10 Nov 2025 10:00:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6E90EA28B1; Mon, 10 Nov 2025 11:00:13 +0100 (CET)
Date: Mon, 10 Nov 2025 11:00:13 +0100
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, linux-kernel@vger.kernel.org, kernel@pankajraghav.com, 
	mcgrof@kernel.org, ebiggers@kernel.org, willy@infradead.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, chengzhihao1@huawei.com, libaokun1@huawei.com
Subject: Re: [PATCH v2 24/24] ext4: enable block size larger than page size
Message-ID: <uhztqnoan3lnkp6tb7jtdludunzhjdrfb2ejn7ujpos6z5jalg@42yrgqimodd3>
References: <20251107144249.435029-1-libaokun@huaweicloud.com>
 <20251107144249.435029-25-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107144249.435029-25-libaokun@huaweicloud.com>
X-Rspamd-Queue-Id: C588421FAC
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
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_ALLOW(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,huaweicloud.com:email,suse.com:email]
X-Spamd-Bar: /

On Fri 07-11-25 22:42:49, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Since block device (See commit 3c20917120ce ("block/bdev: enable large
> folio support for large logical block sizes")) and page cache (See commit
> ab95d23bab220ef8 ("filemap: allocate mapping_min_order folios in the page
> cache")) has the ability to have a minimum order when allocating folio,
> and ext4 has supported large folio in commit 7ac67301e82f ("ext4: enable
> large folio for regular file"), now add support for block_size > PAGE_SIZE
> in ext4.
> 
> set_blocksize() -> bdev_validate_blocksize() already validates the block
> size, so ext4_load_super() does not need to perform additional checks.
> 
> Here we only need to add the FS_LBS bit to fs_flags.
> 
> In addition, allocation failures for large folios may trigger warn_alloc()
> warnings. Therefore, as with XFS, mark this feature as experimental.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/super.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 6735152dd219..1fbbae5a0426 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -5074,6 +5074,9 @@ static int ext4_check_large_folio(struct super_block *sb)
>  		return -EINVAL;
>  	}
>  
> +	if (sb->s_blocksize > PAGE_SIZE)
> +		ext4_msg(sb, KERN_NOTICE, "EXPERIMENTAL bs(%lu) > ps(%lu) enabled.",
> +			 sb->s_blocksize, PAGE_SIZE);
>  	return 0;
>  }
>  
> @@ -7453,7 +7456,8 @@ static struct file_system_type ext4_fs_type = {
>  	.init_fs_context	= ext4_init_fs_context,
>  	.parameters		= ext4_param_specs,
>  	.kill_sb		= ext4_kill_sb,
> -	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_MGTIME,
> +	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_MGTIME |
> +				  FS_LBS,
>  };
>  MODULE_ALIAS_FS("ext4");
>  
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

