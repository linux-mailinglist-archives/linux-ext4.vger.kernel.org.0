Return-Path: <linux-ext4+bounces-497-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA758174FE
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Dec 2023 16:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47CE7288511
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Dec 2023 15:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5831C498B6;
	Mon, 18 Dec 2023 15:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="l5Ca33k+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xsNnaOhy";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vjwRspq7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="a0gdTFNl"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E56F49890;
	Mon, 18 Dec 2023 15:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0482421E0D;
	Mon, 18 Dec 2023 15:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702912497; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+cm4PMMqFmVathp7mybQaRO8gVagPOtZ+MpnGlv1cXU=;
	b=l5Ca33k+JhYUsjq1pc4mJyNHCOiPfevvqobkUCWIrNfy0oCW6WA1OVnBijQP5v9kc5QeAW
	N/ZF1IxYlnWV/EkZR/k9xfw+j6WeoHJU7hTt5LtZmnYulNliHccHFIV0CW4/Z/y4p4yeXu
	y1wedumAsRe9AiH0Ufo1II5aIFieORc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702912497;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+cm4PMMqFmVathp7mybQaRO8gVagPOtZ+MpnGlv1cXU=;
	b=xsNnaOhydrtNCt0dRF1Mv+sJ5G0Wkj6Cl6jfUkWB1s7bf7gkCP8YQYrtoNBAWKB87CtK1y
	IgnYC/HmJx53/OAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702912496; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+cm4PMMqFmVathp7mybQaRO8gVagPOtZ+MpnGlv1cXU=;
	b=vjwRspq7HpGM/ahbEvab+2ey5t7yWRduEh8THIkXUo9jisr6NH321IjTl1KHWyi7rCrK3A
	5RpKkBMnjAjL/xAvUbaFiUdnVYCuDkpa4uFFpMqpnFSJf/3DyKqv1Jm9BO27d9OHY0Z8yP
	nVy+TRHCv7hjsOcT0ZBz4/+w/WupLHE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702912496;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+cm4PMMqFmVathp7mybQaRO8gVagPOtZ+MpnGlv1cXU=;
	b=a0gdTFNlGs7CNz+hZtRVZBDbdmUUpuSR2bFG7dhpVzxVQ88zmanXide4VZ0fub9k+OGoZV
	a9UHVp9ArJS9bhDA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id D6D7013927;
	Mon, 18 Dec 2023 15:14:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id yypvNO9hgGX7eAAAn2gu4w
	(envelope-from <jack@suse.cz>); Mon, 18 Dec 2023 15:14:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 36F40A07E0; Mon, 18 Dec 2023 16:14:55 +0100 (CET)
Date: Mon, 18 Dec 2023 16:14:55 +0100
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 3/4] ext4: avoid bb_free and bb_fragments inconsistency
 in mb_free_blocks()
Message-ID: <20231218151455.yqph44iz4ihsujz5@quack3>
References: <20231218141814.1477338-1-libaokun1@huawei.com>
 <20231218141814.1477338-4-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218141814.1477338-4-libaokun1@huawei.com>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.70
X-Spamd-Result: default: False [0.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,huawei.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On Mon 18-12-23 22:18:13, Baokun Li wrote:
> After updating bb_free in mb_free_blocks, it is possible to return without
> updating bb_fragments because the block being freed is found to have
> already been freed, which leads to inconsistency between bb_free and
> bb_fragments.
> 
> Since the group may be unlocked in ext4_grp_locked_error(), this can lead
> to problems such as dividing by zero when calculating the average fragment
> length. Therefore, to ensure consistency, move the update of bb_free to
> after the block double-free check.
> 
> Fixes: eabe0444df90 ("ext4: speed-up releasing blocks on commit")
> CC: stable@vger.kernel.org # 3.10
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

I agree there's no point in updating the allocation info if the bitmap is
corrupted. We will not try to allocate (or free) blocks in that group
anymore. I'm just a bit unsure about the EXT4_FC_REPLAY state where we
don't mark the bitmap as corrupted although some blocks were already marked
as freed. So in this case the free space statistics tracking will go
permanently wrong. I'm kind of wondering in which case does fast-commit
free already freed blocks. Ted, any idea?

								Honza


> ---
>  fs/ext4/mballoc.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index a95fa6e2b0f9..2fbee0f0f5c3 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -1892,11 +1892,6 @@ static void mb_free_blocks(struct inode *inode, struct ext4_buddy *e4b,
>  	mb_check_buddy(e4b);
>  	mb_free_blocks_double(inode, e4b, first, count);
>  
> -	this_cpu_inc(discard_pa_seq);
> -	e4b->bd_info->bb_free += count;
> -	if (first < e4b->bd_info->bb_first_free)
> -		e4b->bd_info->bb_first_free = first;
> -
>  	/* access memory sequentially: check left neighbour,
>  	 * clear range and then check right neighbour
>  	 */
> @@ -1922,9 +1917,14 @@ static void mb_free_blocks(struct inode *inode, struct ext4_buddy *e4b,
>  				sb, e4b->bd_group,
>  				EXT4_GROUP_INFO_BBITMAP_CORRUPT);
>  		}
> -		goto done;
> +		return;
>  	}
>  
> +	this_cpu_inc(discard_pa_seq);
> +	e4b->bd_info->bb_free += count;
> +	if (first < e4b->bd_info->bb_first_free)
> +		e4b->bd_info->bb_first_free = first;
> +
>  	/* let's maintain fragments counter */
>  	if (left_is_free && right_is_free)
>  		e4b->bd_info->bb_fragments--;
> @@ -1949,7 +1949,6 @@ static void mb_free_blocks(struct inode *inode, struct ext4_buddy *e4b,
>  	if (first <= last)
>  		mb_buddy_mark_free(e4b, first >> 1, last >> 1);
>  
> -done:
>  	mb_set_largest_free_order(sb, e4b->bd_info);
>  	mb_update_avg_fragment_size(sb, e4b->bd_info);
>  	mb_check_buddy(e4b);
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

