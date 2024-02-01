Return-Path: <linux-ext4+bounces-1061-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE2A845E76
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Feb 2024 18:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12A93289C2C
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Feb 2024 17:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF86F6308D;
	Thu,  1 Feb 2024 17:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MiBsgeou";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LfSjgBsR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MiBsgeou";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LfSjgBsR"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E96E63063;
	Thu,  1 Feb 2024 17:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706808250; cv=none; b=EO/+4lyScEspGYzvjSodJ/FlPxbVBj4TaBZi5+LvSPyUGkiwGAU+l1Q3YZq7jj/lbxv4VGuJGuqMPCuSBCl2UeUd8Bh0PacTo417nGL3Q4fwKxxqeKFmY678QnJv6ytMZ44TfTIzcdEma+rEIdpplkeRWPLcdgRDfjNwp+wDViY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706808250; c=relaxed/simple;
	bh=2iME+aeC5MdTCFFpdOg4XL92EP7bljHw3uIS43ZYUJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=djyW9aXbUD5mvTX0bjfEXsse4Xz+nL/IQ1zqGVvdZkr0YQh4n89vZOK84zhl4AXIGL24+JYYVUHsL3Mik3mG2QkFMgbzF/23I9GiHFNe6iUOiAuBO2yKUQnfWQnfCjnCjwEMexl/ADGTQZ85+Ry0WGxKjMLnTMcasK0qEtlB8as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MiBsgeou; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LfSjgBsR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MiBsgeou; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LfSjgBsR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 66F3B1FBF0;
	Thu,  1 Feb 2024 17:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706808246; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SNNWYy+vwoGWe8udWHwmyDFPJb8JWpw+d2X0FjdZxZ0=;
	b=MiBsgeouIlhF540FepmlMK7BvKgfWzW9RowJ4xb87x002Vt7SZN79o5TkSbEI0Ia/9daw/
	TLenpWSd5KjB5wr6gJWmnLNemam1T77tUrm75z4xsCyEpOXcgYQRHMRaRS49Q/I2w/SF9R
	ICAbskQRX9QQcATRVaMG8WxDWksCxxE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706808246;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SNNWYy+vwoGWe8udWHwmyDFPJb8JWpw+d2X0FjdZxZ0=;
	b=LfSjgBsR2jPBOgs82lbddB+eOtcEKNfhxdyJUKJC1jjcbllke2oZcBSizBreCFPxJ6ULvK
	iSQCU0H2xCB6NeBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706808246; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SNNWYy+vwoGWe8udWHwmyDFPJb8JWpw+d2X0FjdZxZ0=;
	b=MiBsgeouIlhF540FepmlMK7BvKgfWzW9RowJ4xb87x002Vt7SZN79o5TkSbEI0Ia/9daw/
	TLenpWSd5KjB5wr6gJWmnLNemam1T77tUrm75z4xsCyEpOXcgYQRHMRaRS49Q/I2w/SF9R
	ICAbskQRX9QQcATRVaMG8WxDWksCxxE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706808246;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SNNWYy+vwoGWe8udWHwmyDFPJb8JWpw+d2X0FjdZxZ0=;
	b=LfSjgBsR2jPBOgs82lbddB+eOtcEKNfhxdyJUKJC1jjcbllke2oZcBSizBreCFPxJ6ULvK
	iSQCU0H2xCB6NeBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 58300139AB;
	Thu,  1 Feb 2024 17:24:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Br6CFbbTu2XEJAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 01 Feb 2024 17:24:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id F3BF0A0809; Thu,  1 Feb 2024 18:24:05 +0100 (CET)
Date: Thu, 1 Feb 2024 18:24:05 +0100
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
	linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com,
	stable@kernel.org
Subject: Re: [PATCH v2] ext4: correct best extent lstart adjustment logic
Message-ID: <20240201172405.zqeql5y2lzsi3o3y@quack3>
References: <20240201141845.1879253-1-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201141845.1879253-1-libaokun1@huawei.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [7.00 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_SPAM(5.10)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 R_RATELIMIT(0.00)[to_ip_from(RLy4jt9zmnbk4oncb1qwahh5jo)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,linux.ibm.com,huawei.com,kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: *******
X-Spam-Score: 7.00
X-Spam-Flag: NO

On Thu 01-02-24 22:18:45, Baokun Li wrote:
> When yangerkun review commit 93cdf49f6eca ("ext4: Fix best extent lstart
> adjustment logic in ext4_mb_new_inode_pa()"), it was found that the best
> extent did not completely cover the original request after adjusting the
> best extent lstart in ext4_mb_new_inode_pa() as follows:
> 
>   original request: 2/10(8)
>   normalized request: 0/64(64)
>   best extent: 0/9(9)
> 
> When we check if best ex can be kept at start of goal, ac_o_ex.fe_logical
> is 2 less than the adjusted best extent logical end 9, so we think the
> adjustment is done. But obviously 0/9(9) doesn't cover 2/10(8), so we
> should determine here if the original request logical end is less than or
> equal to the adjusted best extent logical end.
> 
> In addition, add a comment stating when adjusted best_ex will not cover
> the original request, and remove the duplicate assertion because adjusting
> lstart makes no change to b_ex.fe_len.
> 
> Link: https://lore.kernel.org/r/3630fa7f-b432-7afd-5f79-781bc3b2c5ea@huawei.com
> Fixes: 93cdf49f6eca ("ext4: Fix best extent lstart adjustment logic in ext4_mb_new_inode_pa()")
> Cc: stable@kernel.org
> Signed-off-by: yangerkun <yangerkun@huawei.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> V1->V2:
> 	Remove the problematic BUG_ON and add some comments.
> 
>  fs/ext4/mballoc.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 1ea6491b6b00..20cad0676aab 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -5148,10 +5148,16 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
>  			.fe_len = ac->ac_orig_goal_len,
>  		};
>  		loff_t orig_goal_end = extent_logical_end(sbi, &ex);
> +		loff_t o_ex_end = extent_logical_end(sbi, &ac->ac_o_ex);
>  
> -		/* we can't allocate as much as normalizer wants.
> -		 * so, found space must get proper lstart
> -		 * to cover original request */
> +		/*
> +		 * We can't allocate as much as normalizer wants, so we try
> +		 * to get proper lstart to cover the original request, except
> +		 * when the goal doesn't cover the original request as below:
> +		 *
> +		 * orig_ex:2045/2055(10), isize:8417280 -> normalized:0/2048
> +		 * best_ex:0/200(200) -> adjusted: 1848/2048(200)
> +		 */
>  		BUG_ON(ac->ac_g_ex.fe_logical > ac->ac_o_ex.fe_logical);
>  		BUG_ON(ac->ac_g_ex.fe_len < ac->ac_o_ex.fe_len);
>  
> @@ -5163,7 +5169,7 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
>  		 * 1. Check if best ex can be kept at end of goal (before
>  		 *    cr_best_avail trimmed it) and still cover original start
>  		 * 2. Else, check if best ex can be kept at start of goal and
> -		 *    still cover original start
> +		 *    still cover original end
>  		 * 3. Else, keep the best ex at start of original request.
>  		 */
>  		ex.fe_len = ac->ac_b_ex.fe_len;
> @@ -5173,7 +5179,7 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
>  			goto adjust_bex;
>  
>  		ex.fe_logical = ac->ac_g_ex.fe_logical;
> -		if (ac->ac_o_ex.fe_logical < extent_logical_end(sbi, &ex))
> +		if (o_ex_end <= extent_logical_end(sbi, &ex))
>  			goto adjust_bex;
>  
>  		ex.fe_logical = ac->ac_o_ex.fe_logical;
> @@ -5181,7 +5187,6 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
>  		ac->ac_b_ex.fe_logical = ex.fe_logical;
>  
>  		BUG_ON(ac->ac_o_ex.fe_logical < ac->ac_b_ex.fe_logical);
> -		BUG_ON(ac->ac_o_ex.fe_len > ac->ac_b_ex.fe_len);
>  		BUG_ON(extent_logical_end(sbi, &ex) > orig_goal_end);
>  	}
>  
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

