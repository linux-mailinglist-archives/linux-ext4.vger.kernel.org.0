Return-Path: <linux-ext4+bounces-9612-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BE1B33F2A
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Aug 2025 14:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F2B5166D76
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Aug 2025 12:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A56672639;
	Mon, 25 Aug 2025 12:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Tao79EtA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5rJ/Z/Gr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Tao79EtA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5rJ/Z/Gr"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FB776026
	for <linux-ext4@vger.kernel.org>; Mon, 25 Aug 2025 12:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756124286; cv=none; b=K71mWrVSfL8VYclpGBDZA5b8IbW+GZJq4bTejmb60/1yqzHk3AX9W1hgvso22oawdVXsLIsz53+Uos1GgHYUhIcCP8uV4Fd7nmAXJqxnt7eyDhHTQYGf/96mAx9C36bv6SBvu0ty+5f4EqkSzMUe1J4ZftMcZiKUdV93HrgH6uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756124286; c=relaxed/simple;
	bh=P9ZioVmRLNZ0PRlBeWitR5wdkkEpDXbsieVIuraxilE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjam/ptOkVIx0V4UfNGmwgCiMfTvFFlyeFFPdAiiEQcSRatSXhAWJyVC8NjbtYeWHr0c+fNcSNdXnSn6et/J1igbCYdHWmzKKQt3QantTExSAXcJj2u4PtgHzVnm1zIEBHBlcwphCL0xIFh9WBiaJFfEnAj49ofBxjyJOL5PtW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Tao79EtA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5rJ/Z/Gr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Tao79EtA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5rJ/Z/Gr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4A70A211F3;
	Mon, 25 Aug 2025 12:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756124283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Avr9qQSALOT/4FAoU4o3mO7LUZ77ekSCMOcAtT98JTM=;
	b=Tao79EtAkiUvJLLkEijhojJY1EHnJXfA8BZXf+YCTwJ0QOr6o9nI8uIU/IOIvz45Er1yO/
	/530XOlTtmwzjHr9n899nIC+KUD5hOYpyHxb8aKxQbSqg5JqWmU6PKjqW86pB8c1oU2MZE
	ViqOeWEuDYowv/vH1UfE9x+pFo81juM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756124283;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Avr9qQSALOT/4FAoU4o3mO7LUZ77ekSCMOcAtT98JTM=;
	b=5rJ/Z/GrRBtFPr2meoPGPviuJqwLUCdM8lWnMgbBeRZZmkztUbDBh7n+6f9ET2u2S3Bs1+
	UfF5eaQM4wQ0hMCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756124283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Avr9qQSALOT/4FAoU4o3mO7LUZ77ekSCMOcAtT98JTM=;
	b=Tao79EtAkiUvJLLkEijhojJY1EHnJXfA8BZXf+YCTwJ0QOr6o9nI8uIU/IOIvz45Er1yO/
	/530XOlTtmwzjHr9n899nIC+KUD5hOYpyHxb8aKxQbSqg5JqWmU6PKjqW86pB8c1oU2MZE
	ViqOeWEuDYowv/vH1UfE9x+pFo81juM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756124283;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Avr9qQSALOT/4FAoU4o3mO7LUZ77ekSCMOcAtT98JTM=;
	b=5rJ/Z/GrRBtFPr2meoPGPviuJqwLUCdM8lWnMgbBeRZZmkztUbDBh7n+6f9ET2u2S3Bs1+
	UfF5eaQM4wQ0hMCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 33DF4136DB;
	Mon, 25 Aug 2025 12:18:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id B7CiDHtUrGjvEAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 25 Aug 2025 12:18:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1D1F2A0A8A; Mon, 25 Aug 2025 11:52:50 +0200 (CEST)
Date: Mon, 25 Aug 2025 11:52:50 +0200
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, linux-kernel@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, libaokun1@huawei.com
Subject: Re: [PATCH] ext4: add ext4_sb_bread_nofail() helper function for
 ext4_free_branches()
Message-ID: <clyk3sndidaz3plcvojzci7rs7sqmsegga5izrp46l23zaxtoc@sovizlltl6jd>
References: <20250821133857.80542-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821133857.80542-1-libaokun@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Thu 21-08-25 21:38:57, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> The implicit __GFP_NOFAIL flag in ext4_sb_bread() was removed in commit
> 8a83ac54940d ("ext4: call bdev_getblk() from sb_getblk_gfp()"), meaning
> the function can now fail under memory pressure.
> 
> Most callers of ext4_sb_bread() propagate the error to userspace and do not
> remount the filesystem read-only. However, ext4_free_branches() handles
> ext4_sb_bread() failure by remounting the filesystem read-only.
> 
> This implies that an ext3 filesystem (mounted via the ext4 driver) could be
> forcibly remounted read-only due to a transient page allocation failure,
> which is unacceptable.
> 
> To mitigate this, introduce a new helper function, ext4_sb_bread_nofail(),
> which explicitly uses __GFP_NOFAIL, and use it in ext4_free_branches().
> 
> Fixes: 8a83ac54940d ("ext4: call bdev_getblk() from sb_getblk_gfp()")
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks sane. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ext4.h     | 2 ++
>  fs/ext4/indirect.c | 2 +-
>  fs/ext4/super.c    | 9 +++++++++
>  3 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 106484739932..32315e51639e 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -3134,6 +3134,8 @@ extern struct buffer_head *ext4_sb_bread(struct super_block *sb,
>  					 sector_t block, blk_opf_t op_flags);
>  extern struct buffer_head *ext4_sb_bread_unmovable(struct super_block *sb,
>  						   sector_t block);
> +extern struct buffer_head *ext4_sb_bread_nofail(struct super_block *sb,
> +						sector_t block);
>  extern void ext4_read_bh_nowait(struct buffer_head *bh, blk_opf_t op_flags,
>  				bh_end_io_t *end_io, bool simu_fail);
>  extern int ext4_read_bh(struct buffer_head *bh, blk_opf_t op_flags,
> diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
> index 7de327fa7b1c..39350a18e919 100644
> --- a/fs/ext4/indirect.c
> +++ b/fs/ext4/indirect.c
> @@ -1025,7 +1025,7 @@ static void ext4_free_branches(handle_t *handle, struct inode *inode,
>  			}
>  
>  			/* Go read the buffer for the next level down */
> -			bh = ext4_sb_bread(inode->i_sb, nr, 0);
> +			bh = ext4_sb_bread_nofail(inode->i_sb, nr);
>  
>  			/*
>  			 * A read failure? Report error and clear slot
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index c7d39da7e733..a0e2b396aa76 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -265,6 +265,15 @@ struct buffer_head *ext4_sb_bread_unmovable(struct super_block *sb,
>  	return __ext4_sb_bread_gfp(sb, block, 0, gfp);
>  }
>  
> +struct buffer_head *ext4_sb_bread_nofail(struct super_block *sb,
> +					 sector_t block)
> +{
> +	gfp_t gfp = mapping_gfp_constraint(sb->s_bdev->bd_mapping,
> +			~__GFP_FS) | __GFP_MOVABLE | __GFP_NOFAIL;
> +
> +	return __ext4_sb_bread_gfp(sb, block, 0, gfp);
> +}
> +
>  void ext4_sb_breadahead_unmovable(struct super_block *sb, sector_t block)
>  {
>  	struct buffer_head *bh = bdev_getblk(sb->s_bdev, block,
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

