Return-Path: <linux-ext4+bounces-3461-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB08F93C217
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jul 2024 14:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47C472839EE
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jul 2024 12:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496A626281;
	Thu, 25 Jul 2024 12:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="F65fnkTD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YPXZ35gn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NRyMuP/x";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mtE6PClM"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD85DA93A;
	Thu, 25 Jul 2024 12:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721910679; cv=none; b=VzEJfcQJK5ck9LuO2JAwIOqSTRJvf0lYYz/OzuwZEvH8CltAB4xnvyPSGZeGvpN+0sGxv9vQYfVE7dBXDXnMv1bXXDPH+x7WZ9jp6Hn7gO9FiyAW719Cmhwg7w8UUhj0C3Af4FJVvcz8fx7Wu/0NVh/TDs4LysngKobMd0R+AXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721910679; c=relaxed/simple;
	bh=Dv4Hud+hmskRvT72IElhXnZL8hukRCIq+6v1YhqxzjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rgJADoRGqsCowrsQnYiR8Axd15uj2FxtUh3Tshm8wHQrud5kCpqjD6i7tv/G4EFC0YWCTaSVuhSFK2aEvZlrgBacAzCF+MuG6p3gBXpPgqT023tvq2ZMZ76kU1o5n+7Zor0nPt1728f6C4XTiuMc3pWqrv4gk6U0WfNwO2peOUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=F65fnkTD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YPXZ35gn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NRyMuP/x; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mtE6PClM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E70C4219D8;
	Thu, 25 Jul 2024 12:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721910676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fhpm3SfUTHtJxZ0NCHm56efWNqfzGYlyAzLVnNDvFAY=;
	b=F65fnkTDdjjVIHwzF30ZECQPjFZa6rYUOo0Gsjhj2naES9f+pqw4HaMvj/GoOhsJChMEor
	j9NI5T2009GhuyExdPtRni4SIY+36hHa3zcfzRf4a0CaJx9QpSpvWl5rrM8HA5uIWb6l2k
	tXya9VccZ1pspnC8nZ15NLJsFsqJMDQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721910676;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fhpm3SfUTHtJxZ0NCHm56efWNqfzGYlyAzLVnNDvFAY=;
	b=YPXZ35gnJmeUVOu8ejENXT4gWRj4KS6QokEhqHEa3IRyJDqmPzeiuyfQz8SIds9zkDBfmZ
	1mLrGTFHLzmwAnCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="NRyMuP/x";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=mtE6PClM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721910675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fhpm3SfUTHtJxZ0NCHm56efWNqfzGYlyAzLVnNDvFAY=;
	b=NRyMuP/xBJXvWO5BuSafBw5PAXlSe2554oVZbEPXr6IUIqjnBR01EHzBg9mGJi5RnTl4lO
	pmrd9flSNQ2aof4mJejKcjDoUh0l4aZGCVnhVVLTnOaVOB2xeI7xEh28BFeMXrDzN8H2U7
	o9Ag/MuQC1R/f54ppF6hGaW3yJ4T3Ec=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721910675;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fhpm3SfUTHtJxZ0NCHm56efWNqfzGYlyAzLVnNDvFAY=;
	b=mtE6PClMO3QYOUxwEH4JtJVg8ILou8Fd6jZHdW/Q7qCXX3zCtrM/ha8w4aghqG1VicDnhq
	5NibBWcH/Aa53lAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D521C1368A;
	Thu, 25 Jul 2024 12:31:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZpfEM5NFomZabwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 25 Jul 2024 12:31:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7C9BBA0996; Thu, 25 Jul 2024 14:31:11 +0200 (CEST)
Date: Thu, 25 Jul 2024 14:31:11 +0200
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com,
	Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH 20/20] ext4: avoid unnecessary extent path frees and
 allocations
Message-ID: <20240725123111.n5vqnqw2ie3z4a3c@quack3>
References: <20240710040654.1714672-1-libaokun@huaweicloud.com>
 <20240710040654.1714672-21-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710040654.1714672-21-libaokun@huaweicloud.com>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: E70C4219D8
X-Spam-Score: -2.31
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.31 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,suse.com:email,suse.cz:email,suse.cz:dkim,huaweicloud.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]

On Wed 10-07-24 12:06:54, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> The ext4_find_extent() can update the extent path so that it does not have
> to allocate and free the path repeatedly, thus reducing the consumption of
> memory allocation and freeing in the following functions:
> 
>     ext4_ext_clear_bb
>     ext4_ext_replay_set_iblocks
>     ext4_fc_replay_add_range
>     ext4_fc_set_bitmaps_and_counters
> 
> No functional changes. Note that ext4_find_extent() does not support error
> pointers, so in this case set path to NULL first.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents.c     | 51 +++++++++++++++++++------------------------
>  fs/ext4/fast_commit.c | 11 ++++++----
>  2 files changed, 29 insertions(+), 33 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 737432bb316e..5ff92cd50dc8 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -6068,12 +6068,9 @@ int ext4_ext_replay_set_iblocks(struct inode *inode)
>  	if (IS_ERR(path))
>  		return PTR_ERR(path);
>  	ex = path[path->p_depth].p_ext;
> -	if (!ex) {
> -		ext4_free_ext_path(path);
> +	if (!ex)
>  		goto out;
> -	}
>  	end = le32_to_cpu(ex->ee_block) + ext4_ext_get_actual_len(ex);
> -	ext4_free_ext_path(path);
>  
>  	/* Count the number of data blocks */
>  	cur = 0;
> @@ -6099,32 +6096,28 @@ int ext4_ext_replay_set_iblocks(struct inode *inode)
>  	ret = skip_hole(inode, &cur);
>  	if (ret < 0)
>  		goto out;
> -	path = ext4_find_extent(inode, cur, NULL, 0);
> +	path = ext4_find_extent(inode, cur, path, 0);
>  	if (IS_ERR(path))
>  		goto out;
>  	numblks += path->p_depth;
> -	ext4_free_ext_path(path);
>  	while (cur < end) {
> -		path = ext4_find_extent(inode, cur, NULL, 0);
> +		path = ext4_find_extent(inode, cur, path, 0);
>  		if (IS_ERR(path))
>  			break;
>  		ex = path[path->p_depth].p_ext;
> -		if (!ex) {
> -			ext4_free_ext_path(path);
> -			return 0;
> -		}
> +		if (!ex)
> +			goto cleanup;
> +
>  		cur = max(cur + 1, le32_to_cpu(ex->ee_block) +
>  					ext4_ext_get_actual_len(ex));
>  		ret = skip_hole(inode, &cur);
> -		if (ret < 0) {
> -			ext4_free_ext_path(path);
> +		if (ret < 0)
>  			break;
> -		}
> -		path2 = ext4_find_extent(inode, cur, NULL, 0);
> -		if (IS_ERR(path2)) {
> -			ext4_free_ext_path(path);
> +
> +		path2 = ext4_find_extent(inode, cur, path2, 0);
> +		if (IS_ERR(path2))
>  			break;
> -		}
> +
>  		for (i = 0; i <= max(path->p_depth, path2->p_depth); i++) {
>  			cmp1 = cmp2 = 0;
>  			if (i <= path->p_depth)
> @@ -6136,13 +6129,14 @@ int ext4_ext_replay_set_iblocks(struct inode *inode)
>  			if (cmp1 != cmp2 && cmp2 != 0)
>  				numblks++;
>  		}
> -		ext4_free_ext_path(path);
> -		ext4_free_ext_path(path2);
>  	}
>  
>  out:
>  	inode->i_blocks = numblks << (inode->i_sb->s_blocksize_bits - 9);
>  	ext4_mark_inode_dirty(NULL, inode);
> +cleanup:
> +	ext4_free_ext_path(path);
> +	ext4_free_ext_path(path2);
>  	return 0;
>  }
>  
> @@ -6163,12 +6157,9 @@ int ext4_ext_clear_bb(struct inode *inode)
>  	if (IS_ERR(path))
>  		return PTR_ERR(path);
>  	ex = path[path->p_depth].p_ext;
> -	if (!ex) {
> -		ext4_free_ext_path(path);
> -		return 0;
> -	}
> +	if (!ex)
> +		goto out;
>  	end = le32_to_cpu(ex->ee_block) + ext4_ext_get_actual_len(ex);
> -	ext4_free_ext_path(path);
>  
>  	cur = 0;
>  	while (cur < end) {
> @@ -6178,16 +6169,16 @@ int ext4_ext_clear_bb(struct inode *inode)
>  		if (ret < 0)
>  			break;
>  		if (ret > 0) {
> -			path = ext4_find_extent(inode, map.m_lblk, NULL, 0);
> -			if (!IS_ERR_OR_NULL(path)) {
> +			path = ext4_find_extent(inode, map.m_lblk, path, 0);
> +			if (!IS_ERR(path)) {
>  				for (j = 0; j < path->p_depth; j++) {
> -
>  					ext4_mb_mark_bb(inode->i_sb,
>  							path[j].p_block, 1, false);
>  					ext4_fc_record_regions(inode->i_sb, inode->i_ino,
>  							0, path[j].p_block, 1, 1);
>  				}
> -				ext4_free_ext_path(path);
> +			} else {
> +				path = NULL;
>  			}
>  			ext4_mb_mark_bb(inode->i_sb, map.m_pblk, map.m_len, false);
>  			ext4_fc_record_regions(inode->i_sb, inode->i_ino,
> @@ -6196,5 +6187,7 @@ int ext4_ext_clear_bb(struct inode *inode)
>  		cur = cur + map.m_len;
>  	}
>  
> +out:
> +	ext4_free_ext_path(path);
>  	return 0;
>  }
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index 1dee40477727..1426d595fab7 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -1766,7 +1766,7 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
>  
>  		if (ret == 0) {
>  			/* Range is not mapped */
> -			path = ext4_find_extent(inode, cur, NULL, 0);
> +			path = ext4_find_extent(inode, cur, path, 0);
>  			if (IS_ERR(path))
>  				goto out;
>  			memset(&newex, 0, sizeof(newex));
> @@ -1782,7 +1782,6 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
>  			up_write((&EXT4_I(inode)->i_data_sem));
>  			if (IS_ERR(path))
>  				goto out;
> -			ext4_free_ext_path(path);
>  			goto next;
>  		}
>  
> @@ -1830,6 +1829,7 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
>  	ext4_ext_replay_shrink_inode(inode, i_size_read(inode) >>
>  					sb->s_blocksize_bits);
>  out:
> +	ext4_free_ext_path(path);
>  	iput(inode);
>  	return 0;
>  }
> @@ -1930,12 +1930,13 @@ static void ext4_fc_set_bitmaps_and_counters(struct super_block *sb)
>  				break;
>  
>  			if (ret > 0) {
> -				path = ext4_find_extent(inode, map.m_lblk, NULL, 0);
> +				path = ext4_find_extent(inode, map.m_lblk, path, 0);
>  				if (!IS_ERR(path)) {
>  					for (j = 0; j < path->p_depth; j++)
>  						ext4_mb_mark_bb(inode->i_sb,
>  							path[j].p_block, 1, true);
> -					ext4_free_ext_path(path);
> +				} else {
> +					path = NULL;
>  				}
>  				cur += ret;
>  				ext4_mb_mark_bb(inode->i_sb, map.m_pblk,
> @@ -1946,6 +1947,8 @@ static void ext4_fc_set_bitmaps_and_counters(struct super_block *sb)
>  		}
>  		iput(inode);
>  	}
> +
> +	ext4_free_ext_path(path);
>  }
>  
>  /*
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

