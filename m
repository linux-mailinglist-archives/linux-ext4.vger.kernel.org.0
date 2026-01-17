Return-Path: <linux-ext4+bounces-12952-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A483D38D29
	for <lists+linux-ext4@lfdr.de>; Sat, 17 Jan 2026 09:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CCA4130082CB
	for <lists+linux-ext4@lfdr.de>; Sat, 17 Jan 2026 08:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6180F3112B3;
	Sat, 17 Jan 2026 08:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZbUE9fP"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775BE279324
	for <linux-ext4@vger.kernel.org>; Sat, 17 Jan 2026 08:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768636838; cv=none; b=rYuC+spnN4jPGm02d538YcAEDUxq+T3b7L4PNNUrtfF4eqjXJ6vdzWePE/YwcfqQZA18ABw/w6KLDNbnA+lyVu9AD2r4K6XwuHUZelkW5umEz+ENhbPq4MyFQygSvGgXp6SfIkXGfLgc9XMyAmqjkSkm9/xhqj9yh4e7UivjLig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768636838; c=relaxed/simple;
	bh=ufzK/3gcpzCmX8IMNzgWUxrJQXtayIxhsLyvlbbDgBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b3LDSqLOff0Kq8ULbcj2fFqkyXhJ9Se2yxUO0WnyooA1ZOl6yMEYE1dB1e9Svg552ro5hjGfUDimRpz89/gHOeoCHxL68mQ9PWWt3+WG1l4v/AnIqB1Vhx5I7QO/EVzU9d0mwmzMlDaKFb5dWYw7UpjNKzMqW0iyfUllGfvm03o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZbUE9fP; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-bc17d39ccd2so1082751a12.3
        for <linux-ext4@vger.kernel.org>; Sat, 17 Jan 2026 00:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768636836; x=1769241636; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V058Ze9pDtb7RGJ63QBd0Kf9HM9/S0wxDt1M2zrIMwc=;
        b=lZbUE9fPdS/pMKv1a4rqkQCqB5Z0jcP4SA85NZ/zs+kspEXdVD/Lyrp09XLb4PH/np
         C7vtpOhRkrV7UqX4EK11ByCdwseGWR/hKB1atfGcAHczYEzFwwyuHUA0JuzsB9hwvAc1
         KreDqJ1Vn5EadL1Qze7ISGjwhMZ2vjQoCjK2BMmAI4NcmxTYEjDutLbyKvObdwqlP9dk
         QX/Z1NDH120jal42kSkAaM2zgF8YKtXW7qXVxjLlwAPoyuIGl5wp5cqcK4+aqlVedWMk
         IKqNOmH+x/26qV/slVutR1Pb/EiMOP063pKHurRzlSTmBCeIl0JzYmQ5iP8/bfDeidXs
         JfLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768636836; x=1769241636;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V058Ze9pDtb7RGJ63QBd0Kf9HM9/S0wxDt1M2zrIMwc=;
        b=sSFYKj2xD6a0fEO3wdWFxSa5jl9aL0MivUoTXCmKuNOaYnPM6JcdBWFMxIqq6IFo7J
         gqPguvqeJrdg9NnXhPfdUvf0fJF9Y01t9l/sWjf6/TECF/aGvU6FNy6Vz/xjyfaD7rpP
         Kc5gyarlEmiqDJ/Dh4lUpruV6T4+p18kdyyUkhaSxSMaZDNdOBAkyKnswa4Qqy09gkWJ
         FHmWNqb8eVZnz9cxjQISyAHR/6ST7REBmzeHlrGN7NK2CKFD89n7yXB/Mv6dnmlYibT0
         SfiJuiynf9Z0FD8/3UBWMgqmpO5YwsyyW750Iy6BAFgshgKuKsw3rDjuN56VKnyzc8nF
         korQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCMJL5wJ0n6T8kPjmHz3Tu7S1HpZTovmopbNjropDefwbppzJ9jhEz9Nf8CGMbcgnMOtAdnMzCxEUN@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi+KYF2oj9Ff5WWQ2eTDVr+CkQ6GuSDD4pUK/te35W3ziyKqgb
	fFvCHBV4PDOsMrKba6tFQ9BVIliACanuzhHuDgFV+aggLlUFQI1apDuo
X-Gm-Gg: AY/fxX74LsGDFNnTF0zwsREkPrEyZPvameKjpc7mmKqMC+DtdwDhhT3C9AvX9kVdkF6
	C+KkfdsbxPw4pVU/C4MDMMiejvmUxMkRmwT+S6hVtoEetzdHhZCHbWX+kIERvPcKe6pqfeY1+GD
	ebwIP8zqTSUbPgxYp10W0GnWnUtNkoIOXeTyhd/9gEI/0gQHWw6fTr/WYYokaRKr6T82D19DDKb
	FPOHWq0gXf9gXCBKzrF26c2ogzwx1BXikisPWr7dL/Gn9LJP3p1nVZms61AQS3JMEVA+8bz4CKq
	nS94NDD/pn1/NTjkzGb/F3dko/ARan2GaI0eSHEUrNRxJdAvVclzX15EjMBzBdE+5d6OfOzUAqb
	ndiDxNar3gFf6V7X53lFhX1nyFRe2zp4baw/SmnNjn4SYrL4PnVjinr/CIWlZa0CXZriBhUd1LE
	CX2bB9KDWxGAvTDy7MOqu2b7TleSfGK9Wku+pkkOIM6ppfEY0lBsPRrjlTIbo=
X-Received: by 2002:a17:90b:5787:b0:32e:e18a:3691 with SMTP id 98e67ed59e1d1-35272fa9236mr4659380a91.35.1768636835431;
        Sat, 17 Jan 2026 00:00:35 -0800 (PST)
Received: from ?IPV6:240e:390:a92:e941:6d59:490b:11d7:ea3? ([240e:390:a92:e941:6d59:490b:11d7:ea3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa1291fbcsm3808073b3a.55.2026.01.17.00.00.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jan 2026 00:00:34 -0800 (PST)
Message-ID: <7752893e-720b-4dd6-878c-1d5087057a55@gmail.com>
Date: Sat, 17 Jan 2026 16:00:30 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] ext4: Refactor zeroout path and handle all cases
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-ext4@vger.kernel.org,
 Theodore Ts'o <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
 Jan Kara <jack@suse.cz>, libaokun1@huawei.com, linux-kernel@vger.kernel.org
References: <cover.1768402426.git.ojaswin@linux.ibm.com>
 <3a63beac9855f41efcdb11b839b4cb6fdc9fb3a4.1768402426.git.ojaswin@linux.ibm.com>
Content-Language: en-US
From: Zhang Yi <yizhang089@gmail.com>
In-Reply-To: <3a63beac9855f41efcdb11b839b4cb6fdc9fb3a4.1768402426.git.ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/14/2026 10:57 PM, Ojaswin Mujoo wrote:
> Currently, zeroout is used as a fallback in case we fail to
> split/convert extents in the "traditional" modify-the-extent-tree way.
> This is essential to mitigate failures in critical paths like extent
> splitting during endio. However, the logic is very messy and not easy to
> follow. Further, the fragile use of various flags has made it prone to
> errors.
> 
> Refactor zeroout out logic by moving it up to ext4_split_extents().
> Further, zeroout correctly based on the type of conversion we want, ie:
> - unwritten to written: Zeroout everything around the mapped range.
> - written to unwritten: Zeroout only the mapped range.
> 
> Also, ext4_ext_convert_to_initialized() now passes
> EXT4_GET_BLOCKS_CONVERT to make the intention clear.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Overall looks good to me besides one comment below. Feel free to add 
after fixing it:

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>   fs/ext4/extents.c | 286 ++++++++++++++++++++++++++++++----------------
>   1 file changed, 188 insertions(+), 98 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 54f45b40fe73..70d85f007dc7 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -44,14 +44,6 @@
>   #define EXT4_EXT_MARK_UNWRIT1	0x2  /* mark first half unwritten */
>   #define EXT4_EXT_MARK_UNWRIT2	0x4  /* mark second half unwritten */
>   
> -/* first half contains valid data */
> -#define EXT4_EXT_DATA_ENTIRE_VALID1	0x8   /* has entirely valid data */
> -#define EXT4_EXT_DATA_PARTIAL_VALID1	0x10  /* has partially valid data */
> -#define EXT4_EXT_DATA_VALID1		(EXT4_EXT_DATA_ENTIRE_VALID1 | \
> -					 EXT4_EXT_DATA_PARTIAL_VALID1)
> -
> -#define EXT4_EXT_DATA_VALID2	0x20 /* second half contains valid data */
> -
>   static __le32 ext4_extent_block_csum(struct inode *inode,
>   				     struct ext4_extent_header *eh)
>   {
> @@ -3193,7 +3185,8 @@ static int ext4_ext_zeroout(struct inode *inode, struct ext4_extent *ex)
>    *  a> the extent are splitted into two extent.
>    *  b> split is not needed, and just mark the extent.
>    *
> - * Return an extent path pointer on success, or an error pointer on failure.
> + * Return an extent path pointer on success, or an error pointer on failure. On
> + * failure, the extent is restored to original state.
>    */
>   static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
>   						  struct inode *inode,
> @@ -3203,14 +3196,10 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
>   {
>   	ext4_fsblk_t newblock;
>   	ext4_lblk_t ee_block;
> -	struct ext4_extent *ex, newex, orig_ex, zero_ex;
> +	struct ext4_extent *ex, newex, orig_ex;
>   	struct ext4_extent *ex2 = NULL;
>   	unsigned int ee_len, depth;
> -	int err = 0;
> -
> -	BUG_ON((split_flag & EXT4_EXT_DATA_VALID1) == EXT4_EXT_DATA_VALID1);
> -	BUG_ON((split_flag & EXT4_EXT_DATA_VALID1) &&
> -	       (split_flag & EXT4_EXT_DATA_VALID2));
> +	int err = 0, insert_err = 0;
>   
>   	/* Do not cache extents that are in the process of being modified. */
>   	flags |= EXT4_EX_NOCACHE;
> @@ -3276,11 +3265,10 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
>   
>   	path = ext4_ext_insert_extent(handle, inode, path, &newex, flags);
>   	if (!IS_ERR(path))
> -		goto out;
> +		return path;
>   
> -	err = PTR_ERR(path);
> -	if (err != -ENOSPC && err != -EDQUOT && err != -ENOMEM)
> -		goto out_path;
> +	insert_err = PTR_ERR(path);
> +	err = 0;
>   
>   	/*
>   	 * Get a new path to try to zeroout or fix the extent length.
> @@ -3296,72 +3284,130 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
>   				 split, PTR_ERR(path));
>   		goto out_path;
>   	}
> +
> +	err = ext4_ext_get_access(handle, inode, path + depth);
> +	if (err)
> +		goto out;
> +
>   	depth = ext_depth(inode);
>   	ex = path[depth].p_ext;
>   
> -	if (EXT4_EXT_MAY_ZEROOUT & split_flag) {
> -		if (split_flag & EXT4_EXT_DATA_VALID1)
> -			memcpy(&zero_ex, ex2, sizeof(zero_ex));
> -		else if (split_flag & EXT4_EXT_DATA_VALID2)
> -			memcpy(&zero_ex, ex, sizeof(zero_ex));
> -		else
> -			memcpy(&zero_ex, &orig_ex, sizeof(zero_ex));
> -		ext4_ext_mark_initialized(&zero_ex);
> +fix_extent_len:
> +	ex->ee_len = orig_ex.ee_len;
> +	err = ext4_ext_dirty(handle, inode, path + path->p_depth);
> +out:
> +	if (err || insert_err) {
> +		ext4_free_ext_path(path);
> +		path = err ? ERR_PTR(err) : ERR_PTR(insert_err);
> +	}
> +out_path:
> +	if (IS_ERR(path))
> +		/* Remove all remaining potentially stale extents. */
> +		ext4_es_remove_extent(inode, ee_block, ee_len);
> +	ext4_ext_show_leaf(inode, path);
> +	return path;
> +}
>   
> -		err = ext4_ext_zeroout(inode, &zero_ex);
> -		if (err)
> -			goto fix_extent_len;
> +static int ext4_split_extent_zeroout(handle_t *handle, struct inode *inode,
> +				     struct ext4_ext_path *path,
> +				     struct ext4_map_blocks *map, int flags)
> +{
> +	struct ext4_extent *ex;
> +	unsigned int ee_len, depth;
> +	ext4_lblk_t ee_block;
> +	uint64_t lblk, pblk, len;
> +	int is_unwrit;
> +	int err = 0;
> +
> +	depth = ext_depth(inode);
> +	ex = path[depth].p_ext;
> +	ee_block = le32_to_cpu(ex->ee_block);
> +	ee_len = ext4_ext_get_actual_len(ex);
> +	is_unwrit = ext4_ext_is_unwritten(ex);
>   
> +	if (flags & EXT4_GET_BLOCKS_CONVERT) {
>   		/*
> -		 * The first half contains partially valid data, the splitting
> -		 * of this extent has not been completed, fix extent length
> -		 * and ext4_split_extent() split will the first half again.
> +		 * EXT4_GET_BLOCKS_CONVERT: Caller wants the range specified by
> +		 * map to be initialized. Zeroout everything except the map
> +		 * range.
>   		 */
> -		if (split_flag & EXT4_EXT_DATA_PARTIAL_VALID1) {
> -			/*
> -			 * Drop extent cache to prevent stale unwritten
> -			 * extents remaining after zeroing out.
> -			 */
> -			ext4_es_remove_extent(inode,
> -					le32_to_cpu(zero_ex.ee_block),
> -					ext4_ext_get_actual_len(&zero_ex));
> -			goto fix_extent_len;
> +
> +		loff_t map_end = (loff_t) map->m_lblk + map->m_len;
> +		loff_t ex_end = (loff_t) ee_block + ee_len;
> +
> +		if (!is_unwrit)
> +			/* Shouldn't happen. Just exit */
> +			return -EINVAL;
> +
> +		/* zeroout left */
> +		if (map->m_lblk > ee_block) {
> +			lblk = ee_block;
> +			len = map->m_lblk - ee_block;
> +			pblk = ext4_ext_pblock(ex);
> +			err = ext4_issue_zeroout(inode, lblk, pblk, len);
> +			if (err)
> +				/* ZEROOUT failed, just return original error */
> +				return err;
>   		}
>   
> -		/* update the extent length and mark as initialized */
> -		ex->ee_len = cpu_to_le16(ee_len);
> -		ext4_ext_try_to_merge(handle, inode, path, ex);
> -		err = ext4_ext_dirty(handle, inode, path + path->p_depth);
> -		if (!err)
> -			/* update extent status tree */
> -			ext4_zeroout_es(inode, &zero_ex);
> +		/* zeroout right */
> +		if (map->m_lblk + map->m_len < ee_block + ee_len) {
> +			lblk = map_end;
> +			len = ex_end - map_end;
> +			pblk = ext4_ext_pblock(ex) + (map_end - ee_block);
> +			err = ext4_issue_zeroout(inode, lblk, pblk, len);
> +			if (err)
> +				/* ZEROOUT failed, just return original error */
> +				return err;
> +		}
> +	} else if (flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN) {
>   		/*
> -		 * If we failed at this point, we don't know in which
> -		 * state the extent tree exactly is so don't try to fix
> -		 * length of the original extent as it may do even more
> -		 * damage.
> +		 * EXT4_GET_BLOCKS_CONVERT_UNWRITTEN: Caller wants the
> +		 * range specified by map to be marked unwritten.
> +		 * Zeroout the map range leaving rest as it is.
>   		 */
> -		goto out;
> +
> +		if (is_unwrit)
> +			/* Shouldn't happen. Just exit */
> +			return -EINVAL;
> +
> +		lblk = map->m_lblk;
> +		len = map->m_len;
> +		pblk = ext4_ext_pblock(ex) + (map->m_lblk - ee_block);
> +		err = ext4_issue_zeroout(inode, lblk, pblk, len);
> +		if (err)
> +			/* ZEROOUT failed, just return original error */
> +			return err;
> +	} else {
> +		/*
> +		 * We no longer perform unwritten to unwritten splits in IO paths.
> +		 * Hence this should not happen.
> +		 */
> +		WARN_ON_ONCE(true);
> +		return -EINVAL;
>   	}
>   
> -fix_extent_len:
> -	ex->ee_len = orig_ex.ee_len;
> +	err = ext4_ext_get_access(handle, inode, path + depth);
> +	if (err)
> +		return err;
> +
> +	ext4_ext_mark_initialized(ex);
> +
> +	ext4_ext_dirty(handle, inode, path + path->p_depth);
> +	if (err)
> +		return err;
> +
>   	/*
> -	 * Ignore ext4_ext_dirty return value since we are already in error path
> -	 * and err is a non-zero error code.
> +	 * The whole extent is initialized and stable now so it can be added to
> +	 * es cache
>   	 */
> -	ext4_ext_dirty(handle, inode, path + path->p_depth);
> -out:
> -	if (err) {
> -		ext4_free_ext_path(path);
> -		path = ERR_PTR(err);
> -	}
> -out_path:
> -	if (IS_ERR(path))
> -		/* Remove all remaining potentially stale extents. */
> -		ext4_es_remove_extent(inode, ee_block, ee_len);
> -	ext4_ext_show_leaf(inode, path);
> -	return path;
> +	if (!(flags & EXT4_EX_NOCACHE))
> +		ext4_es_insert_extent(inode, le32_to_cpu(ex->ee_block),
> +				      ext4_ext_get_actual_len(ex),
> +				      ext4_ext_pblock(ex),
> +				      EXTENT_STATUS_WRITTEN, false);
> +
> +	return 0;
>   }
>   
>   /*
> @@ -3382,11 +3428,13 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
>   					       int split_flag, int flags,
>   					       unsigned int *allocated)
>   {
> -	ext4_lblk_t ee_block;
> +	ext4_lblk_t ee_block, orig_ee_block;
>   	struct ext4_extent *ex;
> -	unsigned int ee_len, depth;
> -	int unwritten;
> -	int split_flag1, flags1;
> +	unsigned int ee_len, orig_ee_len, depth;
> +	int unwritten, orig_unwritten;
> +	int split_flag1 = 0, flags1 = 0;
> +	int  orig_err = 0;
> +	int orig_flags = flags;
>   
>   	depth = ext_depth(inode);
>   	ex = path[depth].p_ext;
> @@ -3394,30 +3442,31 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
>   	ee_len = ext4_ext_get_actual_len(ex);
>   	unwritten = ext4_ext_is_unwritten(ex);
>   
> +	orig_ee_block = ee_block;
> +	orig_ee_len = ee_len;
> +	orig_unwritten = unwritten;
> +
>   	/* Do not cache extents that are in the process of being modified. */
>   	flags |= EXT4_EX_NOCACHE;
>   
>   	if (map->m_lblk + map->m_len < ee_block + ee_len) {
> -		split_flag1 = split_flag & EXT4_EXT_MAY_ZEROOUT;
>   		flags1 = flags | EXT4_GET_BLOCKS_SPLIT_NOMERGE;
>   		if (unwritten)
>   			split_flag1 |= EXT4_EXT_MARK_UNWRIT1 |
>   				       EXT4_EXT_MARK_UNWRIT2;
> -		if (split_flag & EXT4_EXT_DATA_VALID2)
> -			split_flag1 |= map->m_lblk > ee_block ?
> -				       EXT4_EXT_DATA_PARTIAL_VALID1 :
> -				       EXT4_EXT_DATA_ENTIRE_VALID1;
>   		path = ext4_split_extent_at(handle, inode, path,
>   				map->m_lblk + map->m_len, split_flag1, flags1);
>   		if (IS_ERR(path))
> -			return path;
> +			goto try_zeroout;
> +
>   		/*
>   		 * Update path is required because previous ext4_split_extent_at
>   		 * may result in split of original leaf or extent zeroout.
>   		 */
>   		path = ext4_find_extent(inode, map->m_lblk, path, flags);
>   		if (IS_ERR(path))
> -			return path;
> +			goto try_zeroout;
> +
>   		depth = ext_depth(inode);
>   		ex = path[depth].p_ext;
>   		if (!ex) {
> @@ -3426,22 +3475,64 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
>   			ext4_free_ext_path(path);
>   			return ERR_PTR(-EFSCORRUPTED);
>   		}
> -		unwritten = ext4_ext_is_unwritten(ex);

We need to update the 'orig_ee_len' parameter here, otherwise
it would trigger WARN_ON(ee_len != orig_ee_len) below.

Thanks,
Yi.

>   	}
>   
>   	if (map->m_lblk >= ee_block) {
> -		split_flag1 = split_flag & EXT4_EXT_DATA_VALID2;
> +		split_flag1 = 0;
>   		if (unwritten) {
>   			split_flag1 |= EXT4_EXT_MARK_UNWRIT1;
> -			split_flag1 |= split_flag & (EXT4_EXT_MAY_ZEROOUT |
> -						     EXT4_EXT_MARK_UNWRIT2);
> +			split_flag1 |= split_flag & EXT4_EXT_MARK_UNWRIT2;
>   		}
> -		path = ext4_split_extent_at(handle, inode, path,
> -				map->m_lblk, split_flag1, flags);
> +		path = ext4_split_extent_at(handle, inode, path, map->m_lblk,
> +					    split_flag1, flags);
>   		if (IS_ERR(path))
> -			return path;
> +			goto try_zeroout;
>   	}
>   
> +	goto success;
> +
> +try_zeroout:
> +	/*
> +	 * There was an error in splitting the extent. So instead, just zeroout
> +	 * unwritten portions and convert it to initialize as a last resort. If
> +	 * there is any failure here we just return the original error
> +	 */
> +
> +	orig_err = PTR_ERR(path);
> +	if (orig_err != -ENOSPC && orig_err != -EDQUOT && orig_err != -ENOMEM)
> +		goto out_orig_err;
> +
> +	if (!(split_flag & EXT4_EXT_MAY_ZEROOUT))
> +		/* There's an error and we can't zeroout, just return the
> +		 * original err
> +		 */
> +		goto out_orig_err;
> +
> +	path = ext4_find_extent(inode, map->m_lblk, NULL, flags);
> +	if (IS_ERR(path))
> +		goto out_orig_err;
> +
> +	depth = ext_depth(inode);
> +	ex = path[depth].p_ext;
> +	ee_block = le32_to_cpu(ex->ee_block);
> +	ee_len = ext4_ext_get_actual_len(ex);
> +	unwritten = ext4_ext_is_unwritten(ex);
> +
> +	if (WARN_ON(ee_block != orig_ee_block || ee_len != orig_ee_len ||
> +		    unwritten != orig_unwritten))
> +		/*
> +		 * The extent to zeroout should have been unchanged
> +		 * but its not.
> +		 */
> +		goto out_free_path;
> +
> +	if (ext4_split_extent_zeroout(handle, inode, path, map, orig_flags))
> +		/*
> +		 * Something went wrong in zeroout
> +		 */
> +		goto out_free_path;
> +
> +success:
>   	if (allocated) {
>   		if (map->m_lblk + map->m_len > ee_block + ee_len)
>   			*allocated = ee_len - (map->m_lblk - ee_block);
> @@ -3450,6 +3541,12 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
>   	}
>   	ext4_ext_show_leaf(inode, path);
>   	return path;
> +
> +out_free_path:
> +	ext4_free_ext_path(path);
> +out_orig_err:
> +	return ERR_PTR(orig_err);
> +
>   }
>   
>   /*
> @@ -3485,7 +3582,7 @@ ext4_ext_convert_to_initialized(handle_t *handle, struct inode *inode,
>   	ext4_lblk_t ee_block, eof_block;
>   	unsigned int ee_len, depth, map_len = map->m_len;
>   	int err = 0;
> -	int split_flag = EXT4_EXT_DATA_VALID2;
> +	int split_flag = 0;
>   	unsigned int max_zeroout = 0;
>   
>   	ext_debug(inode, "logical block %llu, max_blocks %u\n",
> @@ -3695,7 +3792,7 @@ ext4_ext_convert_to_initialized(handle_t *handle, struct inode *inode,
>   
>   fallback:
>   	path = ext4_split_extent(handle, inode, path, &split_map, split_flag,
> -				 flags, NULL);
> +				 flags | EXT4_GET_BLOCKS_CONVERT, NULL);
>   	if (IS_ERR(path))
>   		return path;
>   out:
> @@ -3759,11 +3856,7 @@ static struct ext4_ext_path *ext4_split_convert_extents(handle_t *handle,
>   	ee_block = le32_to_cpu(ex->ee_block);
>   	ee_len = ext4_ext_get_actual_len(ex);
>   
> -	/* Convert to unwritten */
> -	if (flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN) {
> -		split_flag |= EXT4_EXT_DATA_ENTIRE_VALID1;
> -	/* Split the existing unwritten extent */
> -	} else if (flags & (EXT4_GET_BLOCKS_UNWRIT_EXT |
> +	if (flags & (EXT4_GET_BLOCKS_UNWRIT_EXT |
>   			    EXT4_GET_BLOCKS_CONVERT)) {
>   		/*
>   		 * It is safe to convert extent to initialized via explicit
> @@ -3772,9 +3865,6 @@ static struct ext4_ext_path *ext4_split_convert_extents(handle_t *handle,
>   		split_flag |= ee_block + ee_len <= eof_block ?
>   			      EXT4_EXT_MAY_ZEROOUT : 0;
>   		split_flag |= EXT4_EXT_MARK_UNWRIT2;
> -		/* Convert to initialized */
> -		if (flags & EXT4_GET_BLOCKS_CONVERT)
> -			split_flag |= EXT4_EXT_DATA_VALID2;
>   	}
>   	flags |= EXT4_GET_BLOCKS_SPLIT_NOMERGE;
>   	return ext4_split_extent(handle, inode, path, map, split_flag, flags,


