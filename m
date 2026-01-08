Return-Path: <linux-ext4+bounces-12639-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFD7D043E5
	for <lists+linux-ext4@lfdr.de>; Thu, 08 Jan 2026 17:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8A31330D489A
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Jan 2026 15:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D22F4782D3;
	Thu,  8 Jan 2026 11:58:32 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AD7477E2D;
	Thu,  8 Jan 2026 11:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767873511; cv=none; b=NOQtcqwKljVK/B1rE8g8ORoTC4flDS1+YEXcSNwrUrmz8OGpCr1VpfZQbMdkeXddwh87vQIp5gJ4dN0PtwQTjlrsCy3Ik+KLPaj/9CdhXNcNLO6pssGbh9HhCQm1RJtaw2Siu24RloJGjC4d3S9D3ig7u8cceXtvZwaIZrN4qhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767873511; c=relaxed/simple;
	bh=X0d9uClICUDkhdeIHMAC1tAG/H60cOgMkFLf71m16c8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tzq1YoV5e2Gsv62dSrf0ZN25DiXqJPRg0xvInh6qMZOVA/wQhJrf+dLVRjJh78c/R7uaj61QDkJONHTZbVFy2J42exYNjuMSiqTIzp9s6rOVDReRhti/8hESY09bYjrVcNxLYy4vGvMAeGcUQxRliFj0vzHisrcht9QwZcgfs6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dn3LX0nwbzKHLyD;
	Thu,  8 Jan 2026 19:57:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DA6EB4056E;
	Thu,  8 Jan 2026 19:58:22 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP4 (Coremail) with SMTP id gCh0CgBnFvfdm19pd3RFDA--.46908S3;
	Thu, 08 Jan 2026 19:58:22 +0800 (CST)
Message-ID: <c715795a-12d7-4d52-9f44-a7abe4b9cc56@huaweicloud.com>
Date: Thu, 8 Jan 2026 19:58:21 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] ext4: Refactor zeroout path and handle all cases
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-ext4@vger.kernel.org,
 Theodore Ts'o <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Jan Kara <jack@suse.cz>,
 libaokun1@huawei.com, linux-kernel@vger.kernel.org
References: <cover.1767528171.git.ojaswin@linux.ibm.com>
 <1ecffaf1edd7a37d90a7fcc8808b9b6e4e7a1245.1767528171.git.ojaswin@linux.ibm.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <1ecffaf1edd7a37d90a7fcc8808b9b6e4e7a1245.1767528171.git.ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBnFvfdm19pd3RFDA--.46908S3
X-Coremail-Antispam: 1UD129KBjvJXoWxtr4UZw1fGr1fXrWkWF1fXrb_yoW7Gw48pr
	9IkFn7Gr4Utw17G3yxAF47ZrnIkw10krW7u3y3K3s8Ca9Fgrn3tF18KF10gFyfKr4kG3WY
	qFWYkas8CasrCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 1/4/2026 8:19 PM, Ojaswin Mujoo wrote:
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
> - unwritten to unwritten: Zeroout everything
> - written to unwritten: Zeroout only the mapped range.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Hi, Ojaswin!

The refactor overall looks good to me. After this series, the split
logic becomes more straightforward and clear. :)

I have some comments below.

> ---
>  fs/ext4/extents.c | 287 +++++++++++++++++++++++++++++++---------------
>  1 file changed, 195 insertions(+), 92 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 460a70e6dae0..8082e1d93bbf 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c

[...]

> @@ -3365,6 +3313,115 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
>  	return path;
>  }
>  
> +static struct ext4_ext_path *
> +ext4_split_extent_zeroout(handle_t *handle, struct inode *inode,
> +			  struct ext4_ext_path *path,
> +			  struct ext4_map_blocks *map, int flags)
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
> +
> +	if (flags & EXT4_GET_BLOCKS_CONVERT) {
> +		/*
> +		 * EXT4_GET_BLOCKS_CONVERT: Caller wants the range specified by
> +		 * map to be initialized. Zeroout everything except the map
> +		 * range.
> +		 */
> +
> +		loff_t map_end = (loff_t) map->m_lblk + map->m_len;
> +		loff_t ex_end = (loff_t) ee_block + ee_len;
> +
> +		if (!is_unwrit)
> +			/* Shouldn't happen. Just exit */
> +			return ERR_PTR(-EINVAL);

For cases that are should not happen, I'd suggest adding a WARN_ON_ONCE or
a message to facilitate future problem identification. Same as below.

> +
> +		/* zeroout left */
> +		if (map->m_lblk > ee_block) {
> +			lblk = ee_block;
> +			len = map->m_lblk - ee_block;
> +			pblk = ext4_ext_pblock(ex);
> +			err = ext4_issue_zeroout(inode, lblk, pblk, len);
> +			if (err)
> +				/* ZEROOUT failed, just return original error */
> +				return ERR_PTR(err);
> +		}
> +
> +		/* zeroout right */
> +		if (map->m_lblk + map->m_len < ee_block + ee_len) {
> +			lblk = map_end;
> +			len = ex_end - map_end;
> +			pblk = ext4_ext_pblock(ex) + (map_end - ee_block);
> +			err = ext4_issue_zeroout(inode, lblk, pblk, len);
> +			if (err)
> +				/* ZEROOUT failed, just return original error */
> +				return ERR_PTR(err);
> +		}
> +	} else if (flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN) {
> +		/*
> +		 * EXT4_GET_BLOCKS_CONVERT_UNWRITTEN: Caller wants the
> +		 * range specified by map to be marked unwritten.
> +		 * Zeroout the map range leaving rest as it is.
> +		 */
> +
> +		if (is_unwrit)
> +			/* Shouldn't happen. Just exit */
> +			return ERR_PTR(-EINVAL);
> +
> +		lblk = map->m_lblk;
> +		len = map->m_len;
> +		pblk = ext4_ext_pblock(ex) + (map->m_lblk - ee_block);
> +		err = ext4_issue_zeroout(inode, lblk, pblk, len);
> +		if (err)
> +			/* ZEROOUT failed, just return original error */
> +			return ERR_PTR(err);
> +	} else if (flags & EXT4_GET_BLOCKS_UNWRIT_EXT) {
> +		/*
> +		 * EXT4_GET_BLOCKS_UNWRIT_EXT: Today, this flag
> +		 * implicitly implies that callers when wanting an
> +		 * unwritten to unwritten split. So zeroout the whole
> +		 * extent.
> +		 *
> +		 * TODO: The implicit meaning of the flag is not ideal
> +		 * and eventually we should aim for a more well defined
> +		 * behavior
> +		 */
> +

I don't think we need this branch anymore. After applying my patch "ext4:
don't split extent before submitting I/O", we will no longer encounter
situations where doing an unwritten to unwritten split. It means that at
all call sites of ext4_split_extent(), only EXT4_GET_BLOCKS_CONVERT or
EXT4_GET_BLOCKS_CONVERT_UNWRITTEN flags are passed. What do you think?

Thanks,
Yi.

> +		if (!is_unwrit)
> +			/* Shouldn't happen. Just exit */
> +			return ERR_PTR(-EINVAL);
> +
> +		lblk = ee_block;
> +		len = ee_len;
> +		pblk = ext4_ext_pblock(ex);
> +		err = ext4_issue_zeroout(inode, lblk, pblk, len);
> +		if (err)
> +			/* ZEROOUT failed, just return original error */
> +			return ERR_PTR(err);
> +	}
> +
> +	err = ext4_ext_get_access(handle, inode, path + depth);
> +	if (err)
> +		return ERR_PTR(err);
> +
> +	ext4_ext_mark_initialized(ex);
> +
> +	ext4_ext_dirty(handle, inode, path + path->p_depth);
> +	if (err)
> +		return ERR_PTR(err);
> +
> +	return 0;
> +}
> +
>  /*
>   * ext4_split_extent() splits an extent and mark extent which is covered
>   * by @map as split_flags indicates

[...]


