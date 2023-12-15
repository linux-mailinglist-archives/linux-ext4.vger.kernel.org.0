Return-Path: <linux-ext4+bounces-459-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E09081471E
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Dec 2023 12:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60B4CB22027
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Dec 2023 11:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE87250E6;
	Fri, 15 Dec 2023 11:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zKGXE7Yk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="i6kaN94H";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zKGXE7Yk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="i6kaN94H"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579DF24B57;
	Fri, 15 Dec 2023 11:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 34A251F82D;
	Fri, 15 Dec 2023 11:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702640496; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JZJ1QN2rr+Sep44VgaUfVWlxXl5m28S3S0Bhpavi/Wk=;
	b=zKGXE7YkFPRIXPvYfsmsz7OyIlcXiQwyh1q9Rd/gzmq5cet2D3+kySt8yh1Q4hT3fgXSww
	fU+c5LYZER94cZT7jrilQ1dkWhHobOTKN5mtYNl4nTVAP6KaNbbo4ljhLTnlLCGP7tyZz1
	8m298ehvzbmVP9ag23szA0sjnm1J2EI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702640496;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JZJ1QN2rr+Sep44VgaUfVWlxXl5m28S3S0Bhpavi/Wk=;
	b=i6kaN94H3x+t36bTBxPXK7R8p3ed6IuDLDvz1fFPhr7pxF3cjBsuQro1832qU6fk/Ztweq
	TXT2sfGFrfeFyaAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702640496; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JZJ1QN2rr+Sep44VgaUfVWlxXl5m28S3S0Bhpavi/Wk=;
	b=zKGXE7YkFPRIXPvYfsmsz7OyIlcXiQwyh1q9Rd/gzmq5cet2D3+kySt8yh1Q4hT3fgXSww
	fU+c5LYZER94cZT7jrilQ1dkWhHobOTKN5mtYNl4nTVAP6KaNbbo4ljhLTnlLCGP7tyZz1
	8m298ehvzbmVP9ag23szA0sjnm1J2EI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702640496;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JZJ1QN2rr+Sep44VgaUfVWlxXl5m28S3S0Bhpavi/Wk=;
	b=i6kaN94H3x+t36bTBxPXK7R8p3ed6IuDLDvz1fFPhr7pxF3cjBsuQro1832qU6fk/Ztweq
	TXT2sfGFrfeFyaAA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 2390C13912;
	Fri, 15 Dec 2023 11:41:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id AuWsCHA7fGUQOgAAn2gu4w
	(envelope-from <jack@suse.cz>); Fri, 15 Dec 2023 11:41:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 895DDA07E0; Fri, 15 Dec 2023 12:41:35 +0100 (CET)
Date: Fri, 15 Dec 2023 12:41:35 +0100
From: Jan Kara <jack@suse.cz>
To: Ye Bin <yebin10@huawei.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, jack@suse.cz
Subject: Re: [PATCH] ext4: fix inconsistent between segment fstrim and full
 fstrim
Message-ID: <20231215114135.qwdoscxg7myw3r6x@quack3>
References: <20231214064635.4128391-1-yebin10@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214064635.4128391-1-yebin10@huawei.com>
X-Spam-Level: 
X-Spam-Score: -3.79
X-Spam-Flag: NO
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.79
X-Spamd-Result: default: False [-3.79 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.19)[-0.962];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Thu 14-12-23 14:46:35, Ye Bin wrote:
> There will not issue discard cmd when do segment fstrim for ext4 fs, however,
> if full fstrim for the same fs will issue discard cmd.
> Above issue may happens as follows:
> Precondition:
> 1. Fstrim range [0, 15] and [16, 31];
> 2. Discard granularity is 16;
>             Range1          Range2
>       1111000000000000 0000111010101011
> There's no free space length large or equal than 16 in 'Range1' or 'Range2'.
> As ext4_try_to_trim_range() only search free space among range which user
> specified. However, there's maximum free space length 16 in 'Range1'+ 'Range2'.
> To solve above issue, we need to find the longest free space to discard.

The patch looks good so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

I'd just rephrase the changelog to make it a bit easier to read:

Suppose we issue two FITRIM ioctls for ranges [0,15] and [16,31] with
mininum length of trimmed range set to 8 blocks. If we have say a range of
blocks 10-22 free, this range will not be trimmed because it straddles the
boundary of the two FITRIM ranges and neither part is big enough. This is a
bit surprising to some users that call FITRIM on smaller ranges of blocks
to limit impact on the system. Also XFS trims all free space extents that
overlap with the specified range so we are inconsistent among filesystems.
Let's change ext4_try_to_trim_range() to consider for trimming the whole
free space extent that straddles the end of specified range, not just the
part of it within the range.

								Honza
 
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  fs/ext4/mballoc.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index d72b5e3c92ec..d195461123d8 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -6753,13 +6753,15 @@ static int ext4_try_to_trim_range(struct super_block *sb,
>  __acquires(ext4_group_lock_ptr(sb, e4b->bd_group))
>  __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
>  {
> -	ext4_grpblk_t next, count, free_count;
> +	ext4_grpblk_t next, count, free_count, last, origin_start;
>  	bool set_trimmed = false;
>  	void *bitmap;
>  
> +	last = ext4_last_grp_cluster(sb, e4b->bd_group);
>  	bitmap = e4b->bd_bitmap;
> -	if (start == 0 && max >= ext4_last_grp_cluster(sb, e4b->bd_group))
> +	if (start == 0 && max >= last)
>  		set_trimmed = true;
> +	origin_start = start;
>  	start = max(e4b->bd_info->bb_first_free, start);
>  	count = 0;
>  	free_count = 0;
> @@ -6768,7 +6770,10 @@ __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
>  		start = mb_find_next_zero_bit(bitmap, max + 1, start);
>  		if (start > max)
>  			break;
> -		next = mb_find_next_bit(bitmap, max + 1, start);
> +
> +		next = mb_find_next_bit(bitmap, last + 1, start);
> +		if (origin_start == 0 && next >= last)
> +			set_trimmed = true;
>  
>  		if ((next - start) >= minblocks) {
>  			int ret = ext4_trim_extent(sb, start, next - start, e4b);
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

