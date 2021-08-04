Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD9A3E0433
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Aug 2021 17:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239075AbhHDPaL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Aug 2021 11:30:11 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:42058 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239060AbhHDP36 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 Aug 2021 11:29:58 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 94CB0221A4;
        Wed,  4 Aug 2021 15:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628090984; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H6HksWZbE1lXkCQKoHfRaXs/4eEYfjaU+trmhkerZK4=;
        b=uZnfpLmWgh+aSXslqQ7QHtrGIGKM3LNB4gT+ti4O0MlyDLCtqtuv93mQHDEUvrOAYyzo+Y
        XJ4YLT9Ri+glK+qzHBO3ufowK/v70uG5hGfdT/aJi3v/PwHl8FQKNbZ2LMickwXZVpA28W
        OKj44Q6vxMXzfvgXUN3h6V6hRu9jJcQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628090984;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H6HksWZbE1lXkCQKoHfRaXs/4eEYfjaU+trmhkerZK4=;
        b=lxbV2C+Uo7s+ocTaet5DfD+Li+3C6y02MPAaYirkZVay1Cg0CLMYTXPBkO5M2PPa36+ggF
        DbF5KCTHEdSPIdDQ==
Received: from quack2.suse.cz (jack.udp.ovpn2.nue.suse.de [10.163.43.118])
        by relay2.suse.de (Postfix) with ESMTP id 80D6BA3B8C;
        Wed,  4 Aug 2021 15:29:44 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 60BDA1F2B83; Wed,  4 Aug 2021 17:29:44 +0200 (CEST)
Date:   Wed, 4 Aug 2021 17:29:44 +0200
From:   Jan Kara <jack@suse.cz>
To:     Wang Jianchao <jianchao.wan9@gmail.com>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        tytso@mit.edu, adilger.kernel@dilger.ca
Subject: Re: [PATCH V3 2/5] ext4: add new helper interface
 ext4_try_to_trim_range()
Message-ID: <20210804152944.GJ4578@quack2.suse.cz>
References: <20210724074124.25731-1-jianchao.wan9@gmail.com>
 <20210724074124.25731-3-jianchao.wan9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210724074124.25731-3-jianchao.wan9@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 24-07-21 15:41:21, Wang Jianchao wrote:
> From: Wang Jianchao <wangjianchao@kuaishou.com>
> 
> There is no functional change in this patch but just split the
> codes, which serachs free block and does trim, into a new function
> ext4_try_to_trim_range. This is preparing for the following async
> backgroup discard.
> 
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>
> Signed-off-by: Wang Jianchao <wangjianchao@kuaishou.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mballoc.c | 102 ++++++++++++++++++++++++++--------------------
>  1 file changed, 57 insertions(+), 45 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 018d5d3c6eeb..e3844152a643 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -6218,6 +6218,54 @@ __acquires(bitlock)
>  	return ret;
>  }
>  
> +static int ext4_try_to_trim_range(struct super_block *sb,
> +		struct ext4_buddy *e4b, ext4_grpblk_t start,
> +		ext4_grpblk_t max, ext4_grpblk_t minblocks)
> +{
> +	ext4_grpblk_t next, count, free_count;
> +	void *bitmap;
> +	int ret = 0;
> +
> +	bitmap = e4b->bd_bitmap;
> +	start = (e4b->bd_info->bb_first_free > start) ?
> +		e4b->bd_info->bb_first_free : start;
> +	count = 0;
> +	free_count = 0;
> +
> +	while (start <= max) {
> +		start = mb_find_next_zero_bit(bitmap, max + 1, start);
> +		if (start > max)
> +			break;
> +		next = mb_find_next_bit(bitmap, max + 1, start);
> +
> +		if ((next - start) >= minblocks) {
> +			ret = ext4_trim_extent(sb, start, next - start, e4b);
> +			if (ret && ret != -EOPNOTSUPP)
> +				break;
> +			ret = 0;
> +			count += next - start;
> +		}
> +		free_count += next - start;
> +		start = next + 1;
> +
> +		if (fatal_signal_pending(current)) {
> +			count = -ERESTARTSYS;
> +			break;
> +		}
> +
> +		if (need_resched()) {
> +			ext4_unlock_group(sb, e4b->bd_group);
> +			cond_resched();
> +			ext4_lock_group(sb, e4b->bd_group);
> +		}
> +
> +		if ((e4b->bd_info->bb_free - free_count) < minblocks)
> +			break;
> +	}
> +
> +	return count;
> +}
> +
>  /**
>   * ext4_trim_all_free -- function to trim all free space in alloc. group
>   * @sb:			super block for file system
> @@ -6241,10 +6289,8 @@ ext4_trim_all_free(struct super_block *sb, ext4_group_t group,
>  		   ext4_grpblk_t start, ext4_grpblk_t max,
>  		   ext4_grpblk_t minblocks)
>  {
> -	void *bitmap;
> -	ext4_grpblk_t next, count = 0, free_count = 0;
>  	struct ext4_buddy e4b;
> -	int ret = 0;
> +	int ret;
>  
>  	trace_ext4_trim_all_free(sb, group, start, max);
>  
> @@ -6254,57 +6300,23 @@ ext4_trim_all_free(struct super_block *sb, ext4_group_t group,
>  			     ret, group);
>  		return ret;
>  	}
> -	bitmap = e4b.bd_bitmap;
>  
>  	ext4_lock_group(sb, group);
> -	if (EXT4_MB_GRP_WAS_TRIMMED(e4b.bd_info) &&
> -	    minblocks >= atomic_read(&EXT4_SB(sb)->s_last_trim_minblks))
> -		goto out;
> -
> -	start = (e4b.bd_info->bb_first_free > start) ?
> -		e4b.bd_info->bb_first_free : start;
>  
> -	while (start <= max) {
> -		start = mb_find_next_zero_bit(bitmap, max + 1, start);
> -		if (start > max)
> -			break;
> -		next = mb_find_next_bit(bitmap, max + 1, start);
> -
> -		if ((next - start) >= minblocks) {
> -			ret = ext4_trim_extent(sb, start, next - start, &e4b);
> -			if (ret && ret != -EOPNOTSUPP)
> -				break;
> -			ret = 0;
> -			count += next - start;
> -		}
> -		free_count += next - start;
> -		start = next + 1;
> -
> -		if (fatal_signal_pending(current)) {
> -			count = -ERESTARTSYS;
> -			break;
> -		}
> -
> -		if (need_resched()) {
> -			ext4_unlock_group(sb, group);
> -			cond_resched();
> -			ext4_lock_group(sb, group);
> -		}
> -
> -		if ((e4b.bd_info->bb_free - free_count) < minblocks)
> -			break;
> +	if (!EXT4_MB_GRP_WAS_TRIMMED(e4b.bd_info) ||
> +	    minblocks < atomic_read(&EXT4_SB(sb)->s_last_trim_minblks)) {
> +		ret = ext4_try_to_trim_range(sb, &e4b, start, max, minblocks);
> +		if (ret >= 0)
> +			EXT4_MB_GRP_SET_TRIMMED(e4b.bd_info);
> +	} else {
> +		ret = 0;
>  	}
>  
> -	if (!ret) {
> -		ret = count;
> -		EXT4_MB_GRP_SET_TRIMMED(e4b.bd_info);
> -	}
> -out:
>  	ext4_unlock_group(sb, group);
>  	ext4_mb_unload_buddy(&e4b);
>  
>  	ext4_debug("trimmed %d blocks in the group %d\n",
> -		count, group);
> +		ret, group);
>  
>  	return ret;
>  }
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
