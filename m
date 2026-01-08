Return-Path: <linux-ext4+bounces-12640-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F59D02EF1
	for <lists+linux-ext4@lfdr.de>; Thu, 08 Jan 2026 14:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D959030124F5
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Jan 2026 13:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E0C4F4C7B;
	Thu,  8 Jan 2026 12:34:59 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE5A4F2994;
	Thu,  8 Jan 2026 12:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767875699; cv=none; b=Qg941B4GwW1MQWUOKW3xG2QDx7kNciQYzPzlcTOKsyUBTdN2Uz+3Mgf4RXKGhddnRePN3JZX29tL/EJHkwPHYVhko54vcFfW9Bqb6Vdty++ueGTFDtiMkjEXAdKhZwDAd9QDGNd7etdWAh4JesSumvmY5n5FXWuuFEEFIai+y+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767875699; c=relaxed/simple;
	bh=hcbWR8G3tt9bvuyUkGGV2bvJA809eYncRJ5mFFrviT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f8948HAnFFRx2fm0h/qamEZ6UVmveqiCZlKaE+91AIBSWEalb/+tba3M1C7kv6Aqo5gJU5kBcYViiyVPvUTnkpA2oTwEQtrr4CwsjLIXqKf/TgdSVdMYt+QRif5bJ+dLDH/fG5UE/8kFrs+ZEwdtZytFefzxYh3J3T1wGLVpwzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dn49P6rlWzYQtxH;
	Thu,  8 Jan 2026 20:34:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8A7774056D;
	Thu,  8 Jan 2026 20:34:53 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP4 (Coremail) with SMTP id gCh0CgAXePhrpF9p3X5IDA--.50438S3;
	Thu, 08 Jan 2026 20:34:53 +0800 (CST)
Message-ID: <e93751dc-bc58-4808-b36c-40618b510d20@huaweicloud.com>
Date: Thu, 8 Jan 2026 20:34:51 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] ext4: Refactor split and convert extents
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-ext4@vger.kernel.org,
 Theodore Ts'o <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Jan Kara <jack@suse.cz>,
 libaokun1@huawei.com, linux-kernel@vger.kernel.org
References: <cover.1767528171.git.ojaswin@linux.ibm.com>
 <8c318aa0eeb0c5c4ad0b5f620de3a7f4df596b82.1767528171.git.ojaswin@linux.ibm.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <8c318aa0eeb0c5c4ad0b5f620de3a7f4df596b82.1767528171.git.ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAXePhrpF9p3X5IDA--.50438S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Zr4fXry3Zw48Cry7XrW3trb_yoWkXFykpF
	nrurn3Cr4UKwn0grWxAF4UZr1a93W5Gr47AFW3K3yFya9FqFnYgFyYy3WFkFWrKrW8XayY
	yFW0y34UCasrWaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHDUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 1/4/2026 8:19 PM, Ojaswin Mujoo wrote:
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
>  * Clearly separate the split and convert process:
>    * ext4_split_extent() and ext4_split_extent_at() are now only
>      responsible to perform the split.
>    * ext4_split_convert_extents() is now responsible to perform extent
>      conversion after calling ext4_split_extent() for splitting.
>    * This helps get rid of all the MARK_UNWRIT* flags.
> 
>  * Clearly enforce the semantics of flags passed to
>    ext4_split_convert_extents():
> 
>    * EXT4_GET_BLOCKS_CONVERT: Will convert the split extent to written
>    * EXT4_GET_BLOCKS_CONVERT_UNWRITTEN: Will convert the split extent to
>      unwritten
>    * Passing neither of the above means we only want a split.
>    * Modify all callers to enforce the above semantics.
> 
>  * Use ext4_split_convert_extents() instead of ext4_split_extents()
>  * in ext4_ext_convert_to_initialized() for uniformity.
> 
>  * Cleanup all callers open coding the conversion logic.
>  * Further, modify kuniy tests to pass flags based on the new semantics.
> 
> From an end user point of view, we should not see any changes in
> behavior of ext4.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Some comments below.

> ---
>  fs/ext4/extents-test.c |  12 +-
>  fs/ext4/extents.c      | 299 +++++++++++++++++++----------------------
>  2 files changed, 145 insertions(+), 166 deletions(-)
> 

[..]

> @@ -3820,6 +3786,26 @@ ext4_ext_convert_to_initialized(handle_t *handle, struct inode *inode,
>  	return ERR_PTR(err);
>  }
>  
> +static bool ext4_ext_needs_conv(struct inode *inode, struct ext4_ext_path *path,
> +				int flags)
> +{
> +	struct ext4_extent *ex;
> +	bool is_unwrit;
> +	int depth;
> +
> +	depth = ext_depth(inode);
> +	ex = path[depth].p_ext;
> +	is_unwrit = ext4_ext_is_unwritten(ex);
> +
> +	if (is_unwrit && (flags & EXT4_GET_BLOCKS_CONVERT))
> +		return true;
> +
> +	if (!is_unwrit && (flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN))
> +		return true;
> +
> +	return false;
> +}
> +
>  /*
>   * This function is called by ext4_ext_map_blocks() from
>   * ext4_get_blocks_dio_write() when DIO to write
> @@ -3856,7 +3842,9 @@ static struct ext4_ext_path *ext4_split_convert_extents(handle_t *handle,
>  	ext4_lblk_t ee_block;
>  	struct ext4_extent *ex;
>  	unsigned int ee_len;
> -	int split_flag = 0, depth;
> +	int split_flag = 0, depth, err = 0;
> +	bool did_zeroout = false;
> +	bool needs_conv = ext4_ext_needs_conv(inode, path, flags);

As I described in Patch 05, there is currently no situation where
splitting occurs without conversion, so I don't think we need this check.
Is it right?

>  
>  	ext_debug(inode, "logical block %llu, max_blocks %u\n",
>  		  (unsigned long long)map->m_lblk, map->m_len);
> @@ -3870,19 +3858,81 @@ static struct ext4_ext_path *ext4_split_convert_extents(handle_t *handle,
>  	ee_block = le32_to_cpu(ex->ee_block);
>  	ee_len = ext4_ext_get_actual_len(ex);
>  
> -	if (flags & (EXT4_GET_BLOCKS_UNWRIT_EXT |
> -			    EXT4_GET_BLOCKS_CONVERT)) {
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
> +		split_flag |= ee_block + ee_len <= eof_block ?
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
> +
> +convert:
> +	/*
> +	 * We don't need a conversion if:
> +	 * 1. There was an error in split.
> +	 * 2. We split via zeroout.
> +	 * 3. None of the convert flags were passed.
> +	 */
> +	if (IS_ERR(path) || did_zeroout || !needs_conv)
> +		return path;
> +
> +	path = ext4_find_extent(inode, map->m_lblk, path, flags);
> +	if (IS_ERR(path))
> +		return path;
> +
> +	depth = ext_depth(inode);
> +	ex = path[depth].p_ext;
> +
> +	err = ext4_ext_get_access(handle, inode, path + depth);
> +	if (err)
> +		goto err;
> +
> +	if (flags & EXT4_GET_BLOCKS_CONVERT)
> +		ext4_ext_mark_initialized(ex);
> +	else if (flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN)
> +		ext4_ext_mark_unwritten(ex);
> +
> +	if (!(flags & EXT4_GET_BLOCKS_SPLIT_NOMERGE))
>  		/*
> -		 * It is safe to convert extent to initialized via explicit
> -		 * zeroout only if extent is fully inside i_size or new_size.
> +		 * note: ext4_ext_correct_indexes() isn't needed here because
> +		 * borders are not changed
>  		 */
> -		split_flag |= ee_block + ee_len <= eof_block ?
> -			      EXT4_EXT_MAY_ZEROOUT : 0;
> -		split_flag |= EXT4_EXT_MARK_UNWRIT2;
> +		ext4_ext_try_to_merge(handle, inode, path, ex);
> +
> +	err = ext4_ext_dirty(handle, inode, path + depth);
> +	if (err)
> +		goto err;
> +
> +	/* Lets update the extent status tree after conversion */
> +	ext4_es_insert_extent(inode, le32_to_cpu(ex->ee_block),
> +			      ext4_ext_get_actual_len(ex), ext4_ext_pblock(ex),
> +			      ext4_ext_is_unwritten(ex) ?
> +				      EXTENT_STATUS_UNWRITTEN :
> +				      EXTENT_STATUS_WRITTEN,
> +			      false);

I think the did_zeroout case also should update the extent status tree (and
it should be better to be added in the previous patch). Otherwise, this
would lead to residual stale unwritten extents in the zeroed range.

We should be careful about the extent status tree. I'd suggest that pay
close attention to the following error output when running tests,

 EXT4-fs warning (device pmem2s): ext4_es_cache_extent:1079: inode #718: comm 108573.fsstress: ES cache extent failed: add [55,22,12260,0x1] conflict with existing [75,2,12280,0x2]

or directly add a WARN_ON_ONCE(1) at the end of ext4_es_cache_extent().
There may be other problems related to the stale extents that could
arise.

Thanks,
Yi.

> +
> +err:
> +	if (err) {
> +		ext4_free_ext_path(path);
> +		return ERR_PTR(err);
>  	}
> -	flags |= EXT4_GET_BLOCKS_SPLIT_NOMERGE;
> -	return ext4_split_extent(handle, inode, path, map, split_flag, flags,
> -				 allocated);
> +
> +	return path;
>  }
>  
>  static struct ext4_ext_path *
> @@ -3894,7 +3944,6 @@ ext4_convert_unwritten_extents_endio(handle_t *handle, struct inode *inode,
>  	ext4_lblk_t ee_block;
>  	unsigned int ee_len;
>  	int depth;
> -	int err = 0;
>  
>  	depth = ext_depth(inode);
>  	ex = path[depth].p_ext;
> @@ -3904,41 +3953,8 @@ ext4_convert_unwritten_extents_endio(handle_t *handle, struct inode *inode,
>  	ext_debug(inode, "logical block %llu, max_blocks %u\n",
>  		  (unsigned long long)ee_block, ee_len);
>  
> -	if (ee_block != map->m_lblk || ee_len > map->m_len) {
> -		path = ext4_split_convert_extents(handle, inode, map, path,
> -						  flags, NULL);
> -		if (IS_ERR(path))
> -			return path;
> -
> -		path = ext4_find_extent(inode, map->m_lblk, path, 0);
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
>  }
>  
>  static struct ext4_ext_path *
> @@ -3952,7 +3968,6 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
>  	ext4_lblk_t ee_block;
>  	unsigned int ee_len;
>  	int depth;
> -	int err = 0;
>  
>  	/*
>  	 * Make sure that the extent is no bigger than we support with
> @@ -3969,40 +3984,12 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
>  	ext_debug(inode, "logical block %llu, max_blocks %u\n",
>  		  (unsigned long long)ee_block, ee_len);
>  
> -	if (ee_block != map->m_lblk || ee_len > map->m_len) {
> -		path = ext4_split_convert_extents(handle, inode, map, path,
> -				flags | EXT4_GET_BLOCKS_CONVERT_UNWRITTEN, NULL);
> -		if (IS_ERR(path))
> -			return path;
> -
> -		path = ext4_find_extent(inode, map->m_lblk, path, 0);
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
> +	path = ext4_split_convert_extents(
> +		handle, inode, map, path,
> +		flags | EXT4_GET_BLOCKS_CONVERT_UNWRITTEN, NULL);
> +	if (IS_ERR(path))
> +		return path;
>  
> -	/* Mark modified extent as dirty */
> -	err = ext4_ext_dirty(handle, inode, path + path->p_depth);
> -	if (err)
> -		goto errout;
>  	ext4_ext_show_leaf(inode, path);
>  
>  	ext4_update_inode_fsync_trans(handle, inode, 1);
> @@ -4012,10 +3999,6 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
>  		*allocated = map->m_len;
>  	map->m_len = *allocated;
>  	return path;
> -
> -errout:
> -	ext4_free_ext_path(path);
> -	return ERR_PTR(err);
>  }
>  
>  static struct ext4_ext_path *
> @@ -5649,7 +5632,7 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
>  	struct ext4_extent *extent;
>  	ext4_lblk_t start_lblk, len_lblk, ee_start_lblk = 0;
>  	unsigned int credits, ee_len;
> -	int ret, depth, split_flag = 0;
> +	int ret, depth;
>  	loff_t start;
>  
>  	trace_ext4_insert_range(inode, offset, len);
> @@ -5720,12 +5703,8 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
>  		 */
>  		if ((start_lblk > ee_start_lblk) &&
>  				(start_lblk < (ee_start_lblk + ee_len))) {
> -			if (ext4_ext_is_unwritten(extent))
> -				split_flag = EXT4_EXT_MARK_UNWRIT1 |
> -					EXT4_EXT_MARK_UNWRIT2;
>  			path = ext4_split_extent_at(handle, inode, path,
> -					start_lblk, split_flag,
> -					EXT4_EX_NOCACHE |
> +					start_lblk, EXT4_EX_NOCACHE |
>  					EXT4_GET_BLOCKS_SPLIT_NOMERGE |
>  					EXT4_GET_BLOCKS_METADATA_NOFAIL);
>  		}


