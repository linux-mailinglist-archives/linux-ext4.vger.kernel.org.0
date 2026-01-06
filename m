Return-Path: <linux-ext4+bounces-12594-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3972ACF91EE
	for <lists+linux-ext4@lfdr.de>; Tue, 06 Jan 2026 16:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 437C0301D94E
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Jan 2026 15:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022C034028F;
	Tue,  6 Jan 2026 15:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mMD//ElT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5bEWF9N7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mMD//ElT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5bEWF9N7"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186B51FE46D
	for <linux-ext4@vger.kernel.org>; Tue,  6 Jan 2026 15:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767714068; cv=none; b=aTQps+alriaR+jzPjDwStRv20b6MzdtaDgsiwkL+iNLFI7mzYpg/1R0tS3htahxyh3k5ui/OdquCWPstdd0XrxUqteLPYNB4r5LGnHdl+uVrzWwiunQAconCxklbJHoHo0qtlsJx0nNZ1KT9E+AHKAVwQXMtD4PLL9REcQM0vN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767714068; c=relaxed/simple;
	bh=xkpteOhnLreiF6azgFaWKhX+9/1ODntaw1LmxKZQDgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PhOtGABNjyFGMLheWOCr1/zZ09VcgbI/TY12widb0x6ew06CqPCXfLkxoumG5RjjRT0tjzke7gH+blWsH3vUwCpBo+8LeuzdLX0XJX8kEes8H3gEFx3twr7HGxBR2h5KnVjYHIhoFtVW/Xno/Y6S8z95W/UQMS9KBB43e8QAPNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mMD//ElT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5bEWF9N7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mMD//ElT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5bEWF9N7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 52FF15BCCC;
	Tue,  6 Jan 2026 15:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767714065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m2ZHGFAcA3SFs9hG7urOslc9ILrN2JhMz9XXwyJwGUo=;
	b=mMD//ElThQjUGGAAZVfKrgVU9wZvEsmQzRR7U6pGh6GxNZ22CDHr3/+wwnvnxGQ8VPfrXy
	ufDLZzV86IlPu4Q+F8m2Oo/dbG/p8thSmMw5XIEVmnW4dNB22OhPKqC29RPuXXdwelJc7F
	oNbbvp6L9/4VfvW1q7pCN89wSHTj/RA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767714065;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m2ZHGFAcA3SFs9hG7urOslc9ILrN2JhMz9XXwyJwGUo=;
	b=5bEWF9N7JY3r3dfJMBsZzCaq8zKAksjdsOcUB67R0qMnHPqzWqbySIBcLyYkN1u2taUJN2
	abHato8Iago137DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767714065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m2ZHGFAcA3SFs9hG7urOslc9ILrN2JhMz9XXwyJwGUo=;
	b=mMD//ElThQjUGGAAZVfKrgVU9wZvEsmQzRR7U6pGh6GxNZ22CDHr3/+wwnvnxGQ8VPfrXy
	ufDLZzV86IlPu4Q+F8m2Oo/dbG/p8thSmMw5XIEVmnW4dNB22OhPKqC29RPuXXdwelJc7F
	oNbbvp6L9/4VfvW1q7pCN89wSHTj/RA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767714065;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m2ZHGFAcA3SFs9hG7urOslc9ILrN2JhMz9XXwyJwGUo=;
	b=5bEWF9N7JY3r3dfJMBsZzCaq8zKAksjdsOcUB67R0qMnHPqzWqbySIBcLyYkN1u2taUJN2
	abHato8Iago137DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 477233EA63;
	Tue,  6 Jan 2026 15:41:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vtFvEREtXWllNQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 06 Jan 2026 15:41:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 060E2A0A4A; Tue,  6 Jan 2026 16:41:04 +0100 (CET)
Date: Tue, 6 Jan 2026 16:41:04 +0100
From: Jan Kara <jack@suse.cz>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, 
	Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>, Jan Kara <jack@suse.cz>, 
	libaokun1@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] ext4: Allow zeroout when doing written to unwritten
 split
Message-ID: <j5yxjikerrahb2yjvr3zkqktdycmdzetyk2kj2opqj3pakhu4b@ledyhgijmkqu>
References: <cover.1767528171.git.ojaswin@linux.ibm.com>
 <bd83af6cd845ac1567900f84c754fc2c0ffd40b3.1767528171.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd83af6cd845ac1567900f84c754fc2c0ffd40b3.1767528171.git.ojaswin@linux.ibm.com>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,gmail.com,huawei.com,suse.cz];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.30

On Sun 04-01-26 17:49:20, Ojaswin Mujoo wrote:
> Currently, when we are doing an extent split and convert operation of
> written to unwritten extent (example, as done by ZERO_RANGE), we don't
> allow the zeroout fallback in case the extent tree manipulation fails.
> This is mostly because zeroout might take unsually long and the fact that
> this code path is more tolerant to failures than endio.
> 
> Since we have zeroout machinery in place, we might as well use it hence
> lift this restriction. To mitigate zeroout taking too long respect the
> max zeroout limit here so that the operation finishes relatively fast.
> 
> Also, add kunit tests for this case.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents-test.c | 33 +++++++++++++++++++++++++++++++++
>  fs/ext4/extents.c      | 23 +++++++++++++++--------
>  2 files changed, 48 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/ext4/extents-test.c b/fs/ext4/extents-test.c
> index 725d5e79be96..3b5274297fe9 100644
> --- a/fs/ext4/extents-test.c
> +++ b/fs/ext4/extents-test.c
> @@ -685,6 +685,39 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
>  	  .is_zeroout_test = 1,
>  	  .nr_exp_data_segs = 1,
>  	  .exp_data_state = { { .exp_char = 0, .off_blk = 0, .len_blk = 3 } } },
> +
> +	/* writ to unwrit splits */
> +	{ .desc = "split writ extent to 2 extents and convert 1st half unwrit (zeroout)",
> +	  .is_unwrit_at_start = 0,
> +	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
> +	  .split_map = { .m_lblk = 10, .m_len = 1 },
> +	  .nr_exp_ext = 1,
> +	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 3, .is_unwrit = 0 } },
> +	  .is_zeroout_test = 1,
> +	  .nr_exp_data_segs = 2,
> +	  .exp_data_state = { { .exp_char = 0, .off_blk = 0, .len_blk = 1 },
> +			      { .exp_char = 'X', .off_blk = 1, .len_blk = 2 }}},
> +	{ .desc = "split writ extent to 2 extents and convert 2nd half unwrit (zeroout)",
> +	  .is_unwrit_at_start = 0,
> +	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
> +	  .split_map = { .m_lblk = 11, .m_len = 2 },
> +	  .nr_exp_ext = 1,
> +	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 3, .is_unwrit = 0 } },
> +	  .is_zeroout_test = 1,
> +	  .nr_exp_data_segs = 2,
> +	  .exp_data_state = { { .exp_char = 'X', .off_blk = 0, .len_blk = 1 },
> +			      { .exp_char = 0, .off_blk = 1, .len_blk = 2 } } },
> +	{ .desc = "split writ extent to 3 extents and convert 2nd half unwrit (zeroout)",
> +	  .is_unwrit_at_start = 0,
> +	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
> +	  .split_map = { .m_lblk = 11, .m_len = 1 },
> +	  .nr_exp_ext = 1,
> +	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 3, .is_unwrit = 0 } },
> +	  .is_zeroout_test = 1,
> +	  .nr_exp_data_segs = 3,
> +	  .exp_data_state = { { .exp_char = 'X', .off_blk = 0, .len_blk = 1 },
> +			      { .exp_char = 0, .off_blk = 1, .len_blk = 1 },
> +			      { .exp_char = 'X', .off_blk = 2, .len_blk = 1 }}},
>  };
>  
>  static const struct kunit_ext_test_param
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 9fb8a3220ae2..95dd88df8fe4 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3485,7 +3485,19 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
>  	 * to initialize as a last resort
>  	 */
>  	if (split_flag & EXT4_EXT_MAY_ZEROOUT) {
> -		path = ext4_find_extent(inode, map->m_lblk, NULL, flags);
> +		int max_zeroout_blks =
> +			EXT4_SB(inode->i_sb)->s_extent_max_zeroout_kb >>
> +			(inode->i_sb->s_blocksize_bits - 10);
> +		if (flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN &&
> +		    map->m_len > max_zeroout_blks)
> +			/*
> +			 * Written to unwritten extent is not a critical path so
> +			 * lets respect the max zeroout
> +			 */
> +			return ERR_PTR(orig_err);
> +
> +		path = ext4_find_extent(inode, map->m_lblk, NULL,
> +						flags);
>  		if (IS_ERR(path))
>  			return path;
>  
> @@ -3863,15 +3875,10 @@ static struct ext4_ext_path *ext4_split_convert_extents(handle_t *handle,
>  		goto convert;
>  
>  	/*
> -	 * We don't use zeroout fallback for written to unwritten conversion as
> -	 * it is not as critical as endio and it might take unusually long.
> -	 * Also, it is only safe to convert extent to initialized via explicit
> +	 * It is only safe to convert extent to initialized via explicit
>  	 * zeroout only if extent is fully inside i_size or new_size.
>  	 */
> -	if (!(flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN))
> -		split_flag |= ee_block + ee_len <= eof_block ?
> -				      EXT4_EXT_MAY_ZEROOUT :
> -				      0;
> +	split_flag |= ee_block + ee_len <= eof_block ? EXT4_EXT_MAY_ZEROOUT : 0;
>  
>  	/*
>  	 * pass SPLIT_NOMERGE explicitly so we don't end up merging extents we
> -- 
> 2.51.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

