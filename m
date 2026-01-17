Return-Path: <linux-ext4+bounces-12958-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E4FD38D48
	for <lists+linux-ext4@lfdr.de>; Sat, 17 Jan 2026 10:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 127F930230C5
	for <lists+linux-ext4@lfdr.de>; Sat, 17 Jan 2026 09:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504AC27FD45;
	Sat, 17 Jan 2026 09:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSJ/1DmD"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FE1326939
	for <linux-ext4@vger.kernel.org>; Sat, 17 Jan 2026 09:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768640461; cv=none; b=Gcg5ENX8hnswXb1Je/2sU3vDYQ+t0e6Mn5HZP5OrBEPgHNxya3ORdtnNYjh5pQRnCPcYINy3R4DE0xVirK7o+n2y6D/ulrPhAh1LXLUcBSTAr5tNoy7mdMFx3ZQbbFmb+6onRRO3N3WwSOIFWKPnuA4E3xmn6PV3w+asNEa/s3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768640461; c=relaxed/simple;
	bh=tUob8wAdVEPn2qApifwK7njb8zC7eVkp/quphUawklE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kwQK7+JHszmCUmBGOj2WWL2GvuN+UQEoqJxv5qo7xvbBlgyTCCtV4Odngcf40qPWYAOFtgXrFnIXFoi1VyZMAZHCk0MgkuTYaLDXxy8ObSDXoZh2uH8Ism5DAZQJhueXvO10aQYkpgdCwhgjpASCZO7kbA+aSt+seg9E/ixlBsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YSJ/1DmD; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-81e9d0cd082so2348333b3a.0
        for <linux-ext4@vger.kernel.org>; Sat, 17 Jan 2026 01:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768640458; x=1769245258; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yKpHnXFUGNQujDrqX6cUWKLbR/XNa8k2s2/9JU347+I=;
        b=YSJ/1DmDIsBumqcaC6xl/wBwsw/0V9kYVttj/vSXn3pklSw0YlqRE+EV/OaCCd0sDS
         R0U3qa/9reNhAqSqd/z09/Z6YtUeNBzHG6x8GvFPQWXpvrCTJjCGluQMZd/xFrJf6iqh
         vYDcBFrPgRpGnjNZX/CFLuU5qbWeAYoO/U1I+ZHJa+cSgFiWS+SKAIuJFZdPxWslE2Fg
         twQPiNGJVvJ8U4wNhJt1aa2cgfskRmAi1Nzcwlhg3wz7JNhAtzOVkjsUtG4m+FUOH7Xp
         kaq+MPY+6R7cPr2lGkQaQpmjWzPW298KVSM/rhHNuY7KXXc3At/e3S541Mmv7onw5VrN
         0viQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768640458; x=1769245258;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yKpHnXFUGNQujDrqX6cUWKLbR/XNa8k2s2/9JU347+I=;
        b=wV+tgDr/G/VPyeRGdS9nbSgczWJ+/F7fjVgzW7xL0SaKpTMRQT6avMnCCWLzHHl/Xl
         +0mLwPlr1VpxrRpDldMWtBgApFZLzd7F+RhHH3VwCJ7nhlV5IPVmoqb3UuQ068QJ+S/U
         j0oHcQ5tb26C1Z00FC6FhWEhO8BuPyD+sF+GSgLIHO52G7rAa9RpaMTyt06GPvXwq+5v
         2mAIXXW/S1OGoZXr3CZ2OGCyqkSy/TPNGNQ+rwi2v5g4mHlRZEIX05IlxZXHXKU0sFB/
         PoLzfcAKxjf+8wG/xHvzKdlL2ZIqQcLN3wVy9r1xDgMk5EH4GSLqPwXimf65ecMrn2WK
         zHkA==
X-Forwarded-Encrypted: i=1; AJvYcCW31zJ866PCU5eSqScUD5dUvWh3mr4i2fuc8yyu/J7JBEv7g5JiJfghw5JS0SKccqMK/9h6KB5ssirF@vger.kernel.org
X-Gm-Message-State: AOJu0YwMdH27RiyR9UhSNRcY3ElUNgy+ZQTDrjsq1fRoQqk+KAAHINwt
	I9r/UzjnsATy9qWDAbnkLtlR9azmLvQWEtz/ZYEtmoFbouFEq4bVQCDj
X-Gm-Gg: AY/fxX7c9cH7KpDgX47x+fibPgEVhZJkMb8IOFjScWViDVVSkfazv8Jf/O6eQzTYGR3
	7Minf9D7um1GpA4NxcBXhUG57BdsvnScbbpSct4NY1OvHpm5qjHFjzydvNsO2O7PJ3PtFyxNNo/
	/jaqVJRHtxvSmcZDJadSUsVu+BD80/7EMfRPTPcIsi12XbXlRHnVMV0lZAGmTZCrRjupQ/dYcb8
	oAYdFjOAkvThiDjN6OG3ImIa/iyoYzBBzAX16Um3ogrDdFHWhS2o16TBz1alsdCKnMPe4BlK4lU
	TBhiS/z9jpWMi4bktocB2D28v/KCXujSC8LTzv1FChYm6+9cG6FyNy5mYJxbP4FRNnM4kfgPCDj
	WBle8iNJqPRmVoDUCCVVNKQvu91GtKrtS2u2XPl8fRpCulvqnNkKMleV9I6AS4sTUFZYOxerHA5
	rYnLgPSJ/iSc6ssb/XRhHsdYLUAGArbKY6KLrK9Uu8H4/9iLWVeYg0HG9+QYPp1QV6XTBGmA==
X-Received: by 2002:a05:6a00:1ad4:b0:81f:4ce8:d641 with SMTP id d2e1a72fcca58-81fa1821d53mr5092313b3a.37.1768640458251;
        Sat, 17 Jan 2026 01:00:58 -0800 (PST)
Received: from ?IPV6:240e:390:a92:e941:6d59:490b:11d7:ea3? ([240e:390:a92:e941:6d59:490b:11d7:ea3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa1291a48sm3983090b3a.50.2026.01.17.01.00.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jan 2026 01:00:57 -0800 (PST)
Message-ID: <91115b31-4dfd-4b68-8704-4b8d65153107@gmail.com>
Date: Sat, 17 Jan 2026 17:00:53 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] ext4: Refactor split and convert extents
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-ext4@vger.kernel.org,
 Theodore Ts'o <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
 Jan Kara <jack@suse.cz>, libaokun1@huawei.com, linux-kernel@vger.kernel.org
References: <cover.1768402426.git.ojaswin@linux.ibm.com>
 <140ffcc7e0108cdf89ed3d380f6494437eb8d02a.1768402426.git.ojaswin@linux.ibm.com>
Content-Language: en-US
From: Zhang Yi <yizhang089@gmail.com>
In-Reply-To: <140ffcc7e0108cdf89ed3d380f6494437eb8d02a.1768402426.git.ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/14/2026 10:57 PM, Ojaswin Mujoo wrote:
> ext4_split_convert_extents() has been historically prone to subtle
> bugs and inconsistent behavior due to the way all the various flags
> interact with the extent split and conversion process. For example,
> callers like ext4_convert_unwritten_extents_endio() and
> convert_initialized_extents() needed to open code extent conversion
> despite passing CONVERT or CONVERT_UNWRITTEN flags because
> ext4_split_convert_extents() wasn't performing the conversion.
> 
> Hence, refactor ext4_split_convert_extents() to clearly enforce the
> semantics of each flag. The major changes here are:
> 
>   * Clearly separate the split and convert process:
>     * ext4_split_extent() and ext4_split_extent_at() are now only
>       responsible to perform the split.
>     * ext4_split_convert_extents() is now responsible to perform extent
>       conversion after calling ext4_split_extent() for splitting.
>     * This helps get rid of all the MARK_UNWRIT* flags.
> 
>   * Clearly enforce the semantics of flags passed to
>     ext4_split_convert_extents():
> 
>     * EXT4_GET_BLOCKS_CONVERT: Will convert the split extent to written
>     * EXT4_GET_BLOCKS_CONVERT_UNWRITTEN: Will convert the split extent to
>       unwritten
>     * Modify all callers to enforce the above semantics.
> 
>   * Use ext4_split_convert_extents() instead of ext4_split_extents()
>     in ext4_ext_convert_to_initialized() for uniformity.
> 
>   * Now that ext4_split_convert_extents() is handling caching to es, we
>     dont need to do it in ext4_split_extent_zeroout().
> 
>   * Cleanup all callers open coding the conversion logic. Further, modify
>     kuniy tests to pass flags based on the new semantics.
> 
>  From an end user point of view, we should not see any changes in
> behavior of ext4.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

It looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>   fs/ext4/extents.c | 279 +++++++++++++++++++---------------------------
>   1 file changed, 113 insertions(+), 166 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 70d85f007dc7..8ade9c68ddd8 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -41,8 +41,9 @@
>    */
>   #define EXT4_EXT_MAY_ZEROOUT	0x1  /* safe to zeroout if split fails \
>   					due to ENOSPC */
> -#define EXT4_EXT_MARK_UNWRIT1	0x2  /* mark first half unwritten */
> -#define EXT4_EXT_MARK_UNWRIT2	0x4  /* mark second half unwritten */
> +static struct ext4_ext_path *ext4_split_convert_extents(
> +	handle_t *handle, struct inode *inode, struct ext4_map_blocks *map,
> +	struct ext4_ext_path *path, int flags, unsigned int *allocated);
>   
>   static __le32 ext4_extent_block_csum(struct inode *inode,
>   				     struct ext4_extent_header *eh)
> @@ -84,8 +85,7 @@ static void ext4_extent_block_csum_set(struct inode *inode,
>   static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
>   						  struct inode *inode,
>   						  struct ext4_ext_path *path,
> -						  ext4_lblk_t split,
> -						  int split_flag, int flags);
> +						  ext4_lblk_t split, int flags);
>   
>   static int ext4_ext_trunc_restart_fn(struct inode *inode, int *dropped)
>   {
> @@ -333,15 +333,12 @@ ext4_force_split_extent_at(handle_t *handle, struct inode *inode,
>   			   struct ext4_ext_path *path, ext4_lblk_t lblk,
>   			   int nofail)
>   {
> -	int unwritten = ext4_ext_is_unwritten(path[path->p_depth].p_ext);
>   	int flags = EXT4_EX_NOCACHE | EXT4_GET_BLOCKS_SPLIT_NOMERGE;
>   
>   	if (nofail)
>   		flags |= EXT4_GET_BLOCKS_METADATA_NOFAIL | EXT4_EX_NOFAIL;
>   
> -	return ext4_split_extent_at(handle, inode, path, lblk, unwritten ?
> -			EXT4_EXT_MARK_UNWRIT1|EXT4_EXT_MARK_UNWRIT2 : 0,
> -			flags);
> +	return ext4_split_extent_at(handle, inode, path, lblk, flags);
>   }
>   
>   static int
> @@ -3173,17 +3170,11 @@ static int ext4_ext_zeroout(struct inode *inode, struct ext4_extent *ex)
>    * @inode: the file inode
>    * @path: the path to the extent
>    * @split: the logical block where the extent is splitted.
> - * @split_flags: indicates if the extent could be zeroout if split fails, and
> - *		 the states(init or unwritten) of new extents.
>    * @flags: flags used to insert new extent to extent tree.
>    *
>    *
>    * Splits extent [a, b] into two extents [a, @split) and [@split, b], states
> - * of which are determined by split_flag.
> - *
> - * There are two cases:
> - *  a> the extent are splitted into two extent.
> - *  b> split is not needed, and just mark the extent.
> + * of which are same as the original extent. No conversion is performed.
>    *
>    * Return an extent path pointer on success, or an error pointer on failure. On
>    * failure, the extent is restored to original state.
> @@ -3192,14 +3183,14 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
>   						  struct inode *inode,
>   						  struct ext4_ext_path *path,
>   						  ext4_lblk_t split,
> -						  int split_flag, int flags)
> +						  int flags)
>   {
>   	ext4_fsblk_t newblock;
>   	ext4_lblk_t ee_block;
>   	struct ext4_extent *ex, newex, orig_ex;
>   	struct ext4_extent *ex2 = NULL;
>   	unsigned int ee_len, depth;
> -	int err = 0, insert_err = 0;
> +	int err = 0, insert_err = 0, is_unwrit = 0;
>   
>   	/* Do not cache extents that are in the process of being modified. */
>   	flags |= EXT4_EX_NOCACHE;
> @@ -3213,39 +3204,24 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
>   	ee_block = le32_to_cpu(ex->ee_block);
>   	ee_len = ext4_ext_get_actual_len(ex);
>   	newblock = split - ee_block + ext4_ext_pblock(ex);
> +	is_unwrit = ext4_ext_is_unwritten(ex);
>   
>   	BUG_ON(split < ee_block || split >= (ee_block + ee_len));
> -	BUG_ON(!ext4_ext_is_unwritten(ex) &&
> -	       split_flag & (EXT4_EXT_MAY_ZEROOUT |
> -			     EXT4_EXT_MARK_UNWRIT1 |
> -			     EXT4_EXT_MARK_UNWRIT2));
>   
> -	err = ext4_ext_get_access(handle, inode, path + depth);
> -	if (err)
> +	/*
> +	 * No split needed
> +	 */
> +	if (split == ee_block)
>   		goto out;
>   
> -	if (split == ee_block) {
> -		/*
> -		 * case b: block @split is the block that the extent begins with
> -		 * then we just change the state of the extent, and splitting
> -		 * is not needed.
> -		 */
> -		if (split_flag & EXT4_EXT_MARK_UNWRIT2)
> -			ext4_ext_mark_unwritten(ex);
> -		else
> -			ext4_ext_mark_initialized(ex);
> -
> -		if (!(flags & EXT4_GET_BLOCKS_SPLIT_NOMERGE))
> -			ext4_ext_try_to_merge(handle, inode, path, ex);
> -
> -		err = ext4_ext_dirty(handle, inode, path + path->p_depth);
> +	err = ext4_ext_get_access(handle, inode, path + depth);
> +	if (err)
>   		goto out;
> -	}
>   
>   	/* case a */
>   	memcpy(&orig_ex, ex, sizeof(orig_ex));
>   	ex->ee_len = cpu_to_le16(split - ee_block);
> -	if (split_flag & EXT4_EXT_MARK_UNWRIT1)
> +	if (is_unwrit)
>   		ext4_ext_mark_unwritten(ex);
>   
>   	/*
> @@ -3260,7 +3236,7 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
>   	ex2->ee_block = cpu_to_le32(split);
>   	ex2->ee_len   = cpu_to_le16(ee_len - (split - ee_block));
>   	ext4_ext_store_pblock(ex2, newblock);
> -	if (split_flag & EXT4_EXT_MARK_UNWRIT2)
> +	if (is_unwrit)
>   		ext4_ext_mark_unwritten(ex2);
>   
>   	path = ext4_ext_insert_extent(handle, inode, path, &newex, flags);
> @@ -3393,20 +3369,10 @@ static int ext4_split_extent_zeroout(handle_t *handle, struct inode *inode,
>   
>   	ext4_ext_mark_initialized(ex);
>   
> -	ext4_ext_dirty(handle, inode, path + path->p_depth);
> +	ext4_ext_dirty(handle, inode, path + depth);
>   	if (err)
>   		return err;
>   
> -	/*
> -	 * The whole extent is initialized and stable now so it can be added to
> -	 * es cache
> -	 */
> -	if (!(flags & EXT4_EX_NOCACHE))
> -		ext4_es_insert_extent(inode, le32_to_cpu(ex->ee_block),
> -				      ext4_ext_get_actual_len(ex),
> -				      ext4_ext_pblock(ex),
> -				      EXTENT_STATUS_WRITTEN, false);
> -
>   	return 0;
>   }
>   
> @@ -3426,15 +3392,13 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
>   					       struct ext4_ext_path *path,
>   					       struct ext4_map_blocks *map,
>   					       int split_flag, int flags,
> -					       unsigned int *allocated)
> +					       unsigned int *allocated, bool *did_zeroout)
>   {
>   	ext4_lblk_t ee_block, orig_ee_block;
>   	struct ext4_extent *ex;
>   	unsigned int ee_len, orig_ee_len, depth;
>   	int unwritten, orig_unwritten;
> -	int split_flag1 = 0, flags1 = 0;
> -	int  orig_err = 0;
> -	int orig_flags = flags;
> +	int orig_err = 0;
>   
>   	depth = ext_depth(inode);
>   	ex = path[depth].p_ext;
> @@ -3450,12 +3414,8 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
>   	flags |= EXT4_EX_NOCACHE;
>   
>   	if (map->m_lblk + map->m_len < ee_block + ee_len) {
> -		flags1 = flags | EXT4_GET_BLOCKS_SPLIT_NOMERGE;
> -		if (unwritten)
> -			split_flag1 |= EXT4_EXT_MARK_UNWRIT1 |
> -				       EXT4_EXT_MARK_UNWRIT2;
>   		path = ext4_split_extent_at(handle, inode, path,
> -				map->m_lblk + map->m_len, split_flag1, flags1);
> +					    map->m_lblk + map->m_len, flags);
>   		if (IS_ERR(path))
>   			goto try_zeroout;
>   
> @@ -3478,13 +3438,8 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
>   	}
>   
>   	if (map->m_lblk >= ee_block) {
> -		split_flag1 = 0;
> -		if (unwritten) {
> -			split_flag1 |= EXT4_EXT_MARK_UNWRIT1;
> -			split_flag1 |= split_flag & EXT4_EXT_MARK_UNWRIT2;
> -		}
>   		path = ext4_split_extent_at(handle, inode, path, map->m_lblk,
> -					    split_flag1, flags);
> +					    flags);
>   		if (IS_ERR(path))
>   			goto try_zeroout;
>   	}
> @@ -3526,12 +3481,16 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
>   		 */
>   		goto out_free_path;
>   
> -	if (ext4_split_extent_zeroout(handle, inode, path, map, orig_flags))
> +	if (ext4_split_extent_zeroout(handle, inode, path, map, flags))
>   		/*
>   		 * Something went wrong in zeroout
>   		 */
>   		goto out_free_path;
>   
> +	/* zeroout succeeded */
> +	if (did_zeroout)
> +		*did_zeroout = true;
> +
>   success:
>   	if (allocated) {
>   		if (map->m_lblk + map->m_len > ee_block + ee_len)
> @@ -3582,7 +3541,6 @@ ext4_ext_convert_to_initialized(handle_t *handle, struct inode *inode,
>   	ext4_lblk_t ee_block, eof_block;
>   	unsigned int ee_len, depth, map_len = map->m_len;
>   	int err = 0;
> -	int split_flag = 0;
>   	unsigned int max_zeroout = 0;
>   
>   	ext_debug(inode, "logical block %llu, max_blocks %u\n",
> @@ -3734,9 +3692,7 @@ ext4_ext_convert_to_initialized(handle_t *handle, struct inode *inode,
>   	 * It is safe to convert extent to initialized via explicit
>   	 * zeroout only if extent is fully inside i_size or new_size.
>   	 */
> -	split_flag |= ee_block + ee_len <= eof_block ? EXT4_EXT_MAY_ZEROOUT : 0;
> -
> -	if (EXT4_EXT_MAY_ZEROOUT & split_flag)
> +	if (ee_block + ee_len <= eof_block)
>   		max_zeroout = sbi->s_extent_max_zeroout_kb >>
>   			(inode->i_sb->s_blocksize_bits - 10);
>   
> @@ -3791,8 +3747,8 @@ ext4_ext_convert_to_initialized(handle_t *handle, struct inode *inode,
>   	}
>   
>   fallback:
> -	path = ext4_split_extent(handle, inode, path, &split_map, split_flag,
> -				 flags | EXT4_GET_BLOCKS_CONVERT, NULL);
> +	path = ext4_split_convert_extents(handle, inode, &split_map, path,
> +					  flags | EXT4_GET_BLOCKS_CONVERT, NULL);
>   	if (IS_ERR(path))
>   		return path;
>   out:
> @@ -3842,7 +3798,8 @@ static struct ext4_ext_path *ext4_split_convert_extents(handle_t *handle,
>   	ext4_lblk_t ee_block;
>   	struct ext4_extent *ex;
>   	unsigned int ee_len;
> -	int split_flag = 0, depth;
> +	int split_flag = 0, depth, err = 0;
> +	bool did_zeroout = false;
>   
>   	ext_debug(inode, "logical block %llu, max_blocks %u\n",
>   		  (unsigned long long)map->m_lblk, map->m_len);
> @@ -3856,19 +3813,81 @@ static struct ext4_ext_path *ext4_split_convert_extents(handle_t *handle,
>   	ee_block = le32_to_cpu(ex->ee_block);
>   	ee_len = ext4_ext_get_actual_len(ex);
>   
> -	if (flags & (EXT4_GET_BLOCKS_UNWRIT_EXT |
> -			    EXT4_GET_BLOCKS_CONVERT)) {
> -		/*
> -		 * It is safe to convert extent to initialized via explicit
> -		 * zeroout only if extent is fully inside i_size or new_size.
> -		 */
> +	/* No split needed */
> +	if (ee_block == map->m_lblk && ee_len == map->m_len)
> +		goto convert;
> +
> +	/*
> +	 * We don't use zeroout fallback for written to unwritten conversion as
> +	 * it is not as critical as endio and it might take unusually long.
> +	 * Also, it is only safe to convert extent to initialized via explicit
> +	 * zeroout only if extent is fully inside i_size or new_size.
> +	 */
> +	if (!(flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN))
>   		split_flag |= ee_block + ee_len <= eof_block ?
> -			      EXT4_EXT_MAY_ZEROOUT : 0;
> -		split_flag |= EXT4_EXT_MARK_UNWRIT2;
> +				      EXT4_EXT_MAY_ZEROOUT :
> +				      0;
> +
> +	/*
> +	 * pass SPLIT_NOMERGE explicitly so we don't end up merging extents we
> +	 * just split.
> +	 */
> +	path = ext4_split_extent(handle, inode, path, map, split_flag,
> +				 flags | EXT4_GET_BLOCKS_SPLIT_NOMERGE,
> +				 allocated, &did_zeroout);
> +	if (IS_ERR(path))
> +		return path;
> +
> +convert:
> +	path = ext4_find_extent(inode, map->m_lblk, path, flags);
> +	if (IS_ERR(path))
> +		return path;
> +
> +	depth = ext_depth(inode);
> +	ex = path[depth].p_ext;
> +
> +	/*
> +	 * Conversion is already handled in case of zeroout
> +	 */
> +	if (!did_zeroout) {
> +		err = ext4_ext_get_access(handle, inode, path + depth);
> +		if (err)
> +			goto err;
> +
> +		if (flags & EXT4_GET_BLOCKS_CONVERT)
> +			ext4_ext_mark_initialized(ex);
> +		else if (flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN)
> +			ext4_ext_mark_unwritten(ex);
> +
> +		if (!(flags & EXT4_GET_BLOCKS_SPLIT_NOMERGE))
> +		       /*
> +			* note: ext4_ext_correct_indexes() isn't needed here because
> +			* borders are not changed
> +			*/
> +			ext4_ext_try_to_merge(handle, inode, path, ex);
> +
> +		err = ext4_ext_dirty(handle, inode, path + depth);
> +		if (err)
> +			goto err;
> +	}
> +
> +	/* Lets update the extent status tree after conversion */
> +	if (!(flags & EXT4_EX_NOCACHE))
> +		ext4_es_insert_extent(inode, le32_to_cpu(ex->ee_block),
> +				      ext4_ext_get_actual_len(ex),
> +				      ext4_ext_pblock(ex),
> +				      ext4_ext_is_unwritten(ex) ?
> +					      EXTENT_STATUS_UNWRITTEN :
> +					      EXTENT_STATUS_WRITTEN,
> +				      false);
> +
> +err:
> +	if (err) {
> +		ext4_free_ext_path(path);
> +		return ERR_PTR(err);
>   	}
> -	flags |= EXT4_GET_BLOCKS_SPLIT_NOMERGE;
> -	return ext4_split_extent(handle, inode, path, map, split_flag, flags,
> -				 allocated);
> +
> +	return path;
>   }
>   
>   static struct ext4_ext_path *
> @@ -3880,7 +3899,6 @@ ext4_convert_unwritten_extents_endio(handle_t *handle, struct inode *inode,
>   	ext4_lblk_t ee_block;
>   	unsigned int ee_len;
>   	int depth;
> -	int err = 0;
>   
>   	depth = ext_depth(inode);
>   	ex = path[depth].p_ext;
> @@ -3890,41 +3908,8 @@ ext4_convert_unwritten_extents_endio(handle_t *handle, struct inode *inode,
>   	ext_debug(inode, "logical block %llu, max_blocks %u\n",
>   		  (unsigned long long)ee_block, ee_len);
>   
> -	if (ee_block != map->m_lblk || ee_len > map->m_len) {
> -		path = ext4_split_convert_extents(handle, inode, map, path,
> -						  flags, NULL);
> -		if (IS_ERR(path))
> -			return path;
> -
> -		path = ext4_find_extent(inode, map->m_lblk, path, flags);
> -		if (IS_ERR(path))
> -			return path;
> -		depth = ext_depth(inode);
> -		ex = path[depth].p_ext;
> -	}
> -
> -	err = ext4_ext_get_access(handle, inode, path + depth);
> -	if (err)
> -		goto errout;
> -	/* first mark the extent as initialized */
> -	ext4_ext_mark_initialized(ex);
> -
> -	/* note: ext4_ext_correct_indexes() isn't needed here because
> -	 * borders are not changed
> -	 */
> -	ext4_ext_try_to_merge(handle, inode, path, ex);
> -
> -	/* Mark modified extent as dirty */
> -	err = ext4_ext_dirty(handle, inode, path + path->p_depth);
> -	if (err)
> -		goto errout;
> -
> -	ext4_ext_show_leaf(inode, path);
> -	return path;
> -
> -errout:
> -	ext4_free_ext_path(path);
> -	return ERR_PTR(err);
> +	return ext4_split_convert_extents(handle, inode, map, path, flags,
> +					  NULL);
>   }
>   
>   static struct ext4_ext_path *
> @@ -3938,7 +3923,6 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
>   	ext4_lblk_t ee_block;
>   	unsigned int ee_len;
>   	int depth;
> -	int err = 0;
>   
>   	/*
>   	 * Make sure that the extent is no bigger than we support with
> @@ -3955,40 +3939,11 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
>   	ext_debug(inode, "logical block %llu, max_blocks %u\n",
>   		  (unsigned long long)ee_block, ee_len);
>   
> -	if (ee_block != map->m_lblk || ee_len > map->m_len) {
> -		path = ext4_split_convert_extents(handle, inode, map, path,
> -						  flags, NULL);
> -		if (IS_ERR(path))
> -			return path;
> -
> -		path = ext4_find_extent(inode, map->m_lblk, path, flags);
> -		if (IS_ERR(path))
> -			return path;
> -		depth = ext_depth(inode);
> -		ex = path[depth].p_ext;
> -		if (!ex) {
> -			EXT4_ERROR_INODE(inode, "unexpected hole at %lu",
> -					 (unsigned long) map->m_lblk);
> -			err = -EFSCORRUPTED;
> -			goto errout;
> -		}
> -	}
> -
> -	err = ext4_ext_get_access(handle, inode, path + depth);
> -	if (err)
> -		goto errout;
> -	/* first mark the extent as unwritten */
> -	ext4_ext_mark_unwritten(ex);
> -
> -	/* note: ext4_ext_correct_indexes() isn't needed here because
> -	 * borders are not changed
> -	 */
> -	ext4_ext_try_to_merge(handle, inode, path, ex);
> +	path = ext4_split_convert_extents(handle, inode, map, path, flags,
> +					  NULL);
> +	if (IS_ERR(path))
> +		return path;
>   
> -	/* Mark modified extent as dirty */
> -	err = ext4_ext_dirty(handle, inode, path + path->p_depth);
> -	if (err)
> -		goto errout;
>   	ext4_ext_show_leaf(inode, path);
>   
>   	ext4_update_inode_fsync_trans(handle, inode, 1);
> @@ -3998,10 +3953,6 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
>   		*allocated = map->m_len;
>   	map->m_len = *allocated;
>   	return path;
> -
> -errout:
> -	ext4_free_ext_path(path);
> -	return ERR_PTR(err);
>   }
>   
>   static struct ext4_ext_path *
> @@ -5635,7 +5586,7 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
>   	struct ext4_extent *extent;
>   	ext4_lblk_t start_lblk, len_lblk, ee_start_lblk = 0;
>   	unsigned int credits, ee_len;
> -	int ret, depth, split_flag = 0;
> +	int ret, depth;
>   	loff_t start;
>   
>   	trace_ext4_insert_range(inode, offset, len);
> @@ -5706,12 +5657,8 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
>   		 */
>   		if ((start_lblk > ee_start_lblk) &&
>   				(start_lblk < (ee_start_lblk + ee_len))) {
> -			if (ext4_ext_is_unwritten(extent))
> -				split_flag = EXT4_EXT_MARK_UNWRIT1 |
> -					EXT4_EXT_MARK_UNWRIT2;
>   			path = ext4_split_extent_at(handle, inode, path,
> -					start_lblk, split_flag,
> -					EXT4_EX_NOCACHE |
> +					start_lblk, EXT4_EX_NOCACHE |
>   					EXT4_GET_BLOCKS_SPLIT_NOMERGE |
>   					EXT4_GET_BLOCKS_METADATA_NOFAIL);
>   		}


