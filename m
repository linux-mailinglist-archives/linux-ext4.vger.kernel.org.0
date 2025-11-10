Return-Path: <linux-ext4+bounces-11714-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54657C45C8C
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Nov 2025 11:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E8D43A2C53
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Nov 2025 09:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA472FDC22;
	Mon, 10 Nov 2025 09:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="baRxYAos";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5ASf5xM5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="I18YSwyG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vqhc/3k6"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28112EA485
	for <linux-ext4@vger.kernel.org>; Mon, 10 Nov 2025 09:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762768764; cv=none; b=CJoNksg+c/0EGK9mEZjCkcThPOU4yavWA/HYzHMSFiLYVoIisyGnPMGasQemzJfqQl2f9IrzAw0YVehL6cLCiV9t/g1uFu+i+nXpIJxFgEkv7sfw4oY/fa2zJOIDPqwg071KWA/sVfO1+28OmOtLlo3YYvBUs5kLkrvsajMNJdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762768764; c=relaxed/simple;
	bh=cpc1EGzcXDrKoFHGwbK7Dq0lojsSqayNgTXC1mobsTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0OuyQHIkMNWvmVf0xKLJNW/e+GAP2rQdoFOt3AOiq8/JsTr+LSxGVFn5Yh+LNa43YLQOuv7lehA2oNPpOgaDXgenwp/DMTvfIQ6sx8ldTPuIyvUbn2wBFdlnDVrtQBsL581qF6yxUq71I3uMx1fqmfUzOCVMX1S0+75//y9/q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=baRxYAos; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5ASf5xM5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=I18YSwyG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vqhc/3k6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EE80321EA3;
	Mon, 10 Nov 2025 09:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762768761; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V/e4bTMfw3VQWxMm+DwPiO0Zmnu9hLW5L1cpLKGBNoM=;
	b=baRxYAosjp1S0vueMbMCX0HnKgBXtrEMcfRYGzImpDVDK8vMD1nokzStfRLAZhwr0Z8Y8N
	XB4ZFbRb3W4Yiw5pPUvm486zHXE1cm6byJm2aobh/SLbQYTiVByCBZB0MQjgMCvRRWwxIV
	wCzGJ8eNjrQRHLh1QA5luO2++0xuk84=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762768761;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V/e4bTMfw3VQWxMm+DwPiO0Zmnu9hLW5L1cpLKGBNoM=;
	b=5ASf5xM5s6vw7lJjmxsOdtW6XduqK7mLgvb0IT5nKQyL+WzYH/3BkiuhU0M7c2Zq+lOr+t
	c6gC0jUtCLpjxBDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762768760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V/e4bTMfw3VQWxMm+DwPiO0Zmnu9hLW5L1cpLKGBNoM=;
	b=I18YSwyGXX963oaGNa+QwH4BBsNILyejeYMABrU8LzO0M7T5uoLgPo8Frruq1fBzwbX1ZQ
	NgfGowosNHJBgAeMhnoWETJJgM/HyoFMSw7KhZrXdOXB9bWVTFb6G9rxG3I2qtNOaNVOPR
	UZ4YzNI/QIeECxC27GZdVCmKYg/njrQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762768760;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V/e4bTMfw3VQWxMm+DwPiO0Zmnu9hLW5L1cpLKGBNoM=;
	b=vqhc/3k6gZJ8B3uW6VQFsH9MyaI8ir6YeItKmvQ4oH6F9rtTzrmQorNnmltPpy9ffgF+vb
	7yRGRoc9umMjzhBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE05514329;
	Mon, 10 Nov 2025 09:59:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nu4/Nni3EWmSBwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 10 Nov 2025 09:59:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8972EA28B1; Mon, 10 Nov 2025 10:59:20 +0100 (CET)
Date: Mon, 10 Nov 2025 10:59:20 +0100
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, linux-kernel@vger.kernel.org, kernel@pankajraghav.com, 
	mcgrof@kernel.org, ebiggers@kernel.org, willy@infradead.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, chengzhihao1@huawei.com, libaokun1@huawei.com
Subject: Re: [PATCH v2 23/24] ext4: add checks for large folio
 incompatibilities when BS > PS
Message-ID: <gjlwnhyoqbecpmfqqt5c5gefw5eegaecccr4iwhvgyezmayrvy@vxvj7lvpnkex>
References: <20251107144249.435029-1-libaokun@huaweicloud.com>
 <20251107144249.435029-24-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107144249.435029-24-libaokun@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-0.30 / 50.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	URIBL_BLOCKED(0.00)[suse.cz:email,huaweicloud.com:email,imap1.dmz-prg2.suse.org:helo,suse.com:email,huawei.com:email];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,huaweicloud.com:email,suse.cz:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -0.30

On Fri 07-11-25 22:42:48, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Supporting a block size greater than the page size (BS > PS) requires
> support for large folios. However, several features (e.g., encrypt)
> do not yet support large folios.
> 
> To prevent conflicts, this patch adds checks at mount time to prohibit
> these features from being used when BS > PS. Since these features cannot
> be changed on remount, there is no need to check on remount.
> 
> This patch adds s_max_folio_order, initialized during mount according to
> filesystem features and mount options. If s_max_folio_order is 0, large
> folios are disabled.
> 
> With this in place, ext4_set_inode_mapping_order() can be simplified by
> checking s_max_folio_order, avoiding redundant checks.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ext4.h  |  4 +++-
>  fs/ext4/inode.c | 39 ++++++++++-----------------------------
>  fs/ext4/super.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 54 insertions(+), 30 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 4bc0b2b7288a..79dc231d6e22 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1696,7 +1696,9 @@ struct ext4_sb_info {
>  	unsigned long s_last_trim_minblks;
>  
>  	/* minimum folio order of a page cache allocation */
> -	unsigned int s_min_folio_order;
> +	u16 s_min_folio_order;
> +	/* supported maximum folio order, 0 means not supported */
> +	u16 s_max_folio_order;
>  
>  	/* Precomputed FS UUID checksum for seeding other checksums */
>  	__u32 s_csum_seed;
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index b95826e4a419..d53dc5b794d4 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5146,42 +5146,23 @@ static int check_igot_inode(struct inode *inode, ext4_iget_flags flags,
>  	return -EFSCORRUPTED;
>  }
>  
> -static bool ext4_should_enable_large_folio(struct inode *inode)
> +void ext4_set_inode_mapping_order(struct inode *inode)
>  {
>  	struct super_block *sb = inode->i_sb;
> +	u16 min_order, max_order;
>  
> -	if (!S_ISREG(inode->i_mode))
> -		return false;
> -	if (ext4_has_feature_encrypt(sb))
> -		return false;
> -
> -	return true;
> -}
> -
> -/*
> - * Limit the maximum folio order to 2048 blocks to prevent overestimation
> - * of reserve handle credits during the folio writeback in environments
> - * where the PAGE_SIZE exceeds 4KB.
> - */
> -#define EXT4_MAX_PAGECACHE_ORDER(i)		\
> -		umin(MAX_PAGECACHE_ORDER, (11 + (i)->i_blkbits - PAGE_SHIFT))
> -void ext4_set_inode_mapping_order(struct inode *inode)
> -{
> -	u32 max_order;
> +	max_order = EXT4_SB(sb)->s_max_folio_order;
> +	if (!max_order)
> +		return;
>  
> -	if (!ext4_should_enable_large_folio(inode))
> +	min_order = EXT4_SB(sb)->s_min_folio_order;
> +	if (!min_order && !S_ISREG(inode->i_mode))
>  		return;
>  
> -	if (test_opt(inode->i_sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA ||
> -	    ext4_test_inode_flag(inode, EXT4_INODE_JOURNAL_DATA) ||
> -	    ext4_has_feature_verity(inode->i_sb))
> -		max_order = EXT4_SB(inode->i_sb)->s_min_folio_order;
> -	else
> -		max_order = EXT4_MAX_PAGECACHE_ORDER(inode);
> +	if (ext4_test_inode_flag(inode, EXT4_INODE_JOURNAL_DATA))
> +		max_order = min_order;
>  
> -	mapping_set_folio_order_range(inode->i_mapping,
> -				      EXT4_SB(inode->i_sb)->s_min_folio_order,
> -				      max_order);
> +	mapping_set_folio_order_range(inode->i_mapping, min_order, max_order);
>  }
>  
>  struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 0d32370a459a..6735152dd219 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -5040,6 +5040,43 @@ static const char *ext4_has_journal_option(struct super_block *sb)
>  	return NULL;
>  }
>  
> +/*
> + * Limit the maximum folio order to 2048 blocks to prevent overestimation
> + * of reserve handle credits during the folio writeback in environments
> + * where the PAGE_SIZE exceeds 4KB.
> + */
> +#define EXT4_MAX_PAGECACHE_ORDER(sb)		\
> +		umin(MAX_PAGECACHE_ORDER, (11 + (sb)->s_blocksize_bits - PAGE_SHIFT))
> +static void ext4_set_max_mapping_order(struct super_block *sb)
> +{
> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
> +
> +	if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA)
> +		sbi->s_max_folio_order = sbi->s_min_folio_order;
> +	else if (ext4_has_feature_verity(sb))
> +		sbi->s_max_folio_order = sbi->s_min_folio_order;
> +	else
> +		sbi->s_max_folio_order = EXT4_MAX_PAGECACHE_ORDER(sb);
> +}
> +
> +static int ext4_check_large_folio(struct super_block *sb)
> +{
> +	const char *err_str = NULL;
> +
> +	if (ext4_has_feature_encrypt(sb))
> +		err_str = "encrypt";
> +
> +	if (!err_str) {
> +		ext4_set_max_mapping_order(sb);
> +	} else if (sb->s_blocksize > PAGE_SIZE) {
> +		ext4_msg(sb, KERN_ERR, "bs(%lu) > ps(%lu) unsupported for %s",
> +			 sb->s_blocksize, PAGE_SIZE, err_str);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  static int ext4_load_super(struct super_block *sb, ext4_fsblk_t *lsb,
>  			   int silent)
>  {
> @@ -5316,6 +5353,10 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  
>  	ext4_apply_options(fc, sb);
>  
> +	err = ext4_check_large_folio(sb);
> +	if (err < 0)
> +		goto failed_mount;
> +
>  	err = ext4_encoding_init(sb, es);
>  	if (err)
>  		goto failed_mount;
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

