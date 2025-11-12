Return-Path: <linux-ext4+bounces-11800-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72605C508E7
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Nov 2025 05:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C370188EB0F
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Nov 2025 04:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01145242D7C;
	Wed, 12 Nov 2025 04:46:39 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB071F2380
	for <linux-ext4@vger.kernel.org>; Wed, 12 Nov 2025 04:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762922798; cv=none; b=tOZUzxacIsyLmMg8HnFpn3eU81OhEOntfV9Luzk3LGTKNrqvKD7FUOVBXRYOO/dUCempFjVcv6irZNWYHatf+iuUvo4MGKQPqsSPJ63QQmIZQpaWCWt7qtoneh9ZXo0WohwVXGwoK2oQt08QnW8NSnAnz9UcTvxAYDx1aQgGnUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762922798; c=relaxed/simple;
	bh=F/hsCm9U31sSJWbWnQq2WaMzV0WG8sVLO7ZZKKBMevo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I7jy83u9Zbsn/K9eTU8VASeTVJDI+xgJV5pkhlUrMvr/eR3C8lPyFzGal5R0tTh8kwPQnkslRufOBD660krAbGD6KTm6MfR5NQrsUuAULS4FM2mJfo/FOMmiZSEBQXIr83Bv1pWdn2rfLFlY5b8B2PI7x5UBPoVX16FL2ZzVxIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d5rT31h1DzKHMW0
	for <linux-ext4@vger.kernel.org>; Wed, 12 Nov 2025 12:46:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 51FD51A1697
	for <linux-ext4@vger.kernel.org>; Wed, 12 Nov 2025 12:46:32 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP2 (Coremail) with SMTP id Syh0CgAHZXsiERRplUDPAQ--.610S3;
	Wed, 12 Nov 2025 12:46:28 +0800 (CST)
Message-ID: <72def5a4-c30a-4461-8bce-c6c2b09b044c@huaweicloud.com>
Date: Wed, 12 Nov 2025 12:46:26 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] ext4: remove useless code in
 ext4_map_create_blocks
To: Yang Erkun <yangerkun@huawei.com>, linux-ext4@vger.kernel.org,
 tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz
Cc: libaokun1@huawei.com, yangerkun@huaweicloud.com
References: <20251107115810.47199-1-yangerkun@huawei.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20251107115810.47199-1-yangerkun@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgAHZXsiERRplUDPAQ--.610S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGw1ruFW8Zw4fGF1fXF1DZFb_yoWrWFy5pF
	Z3CF1xGr4kt3y8u3yxCF1DXry29w15JrW7Ary7Ww1UKa45JrySkF1fA3yfuF1IgrZ5Za1Y
	qF4Fka40kaykA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUymb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
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
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UK2NtUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

Hi!

On 11/7/2025 7:58 PM, Yang Erkun wrote:
> IO path with EXT4_GET_BLOCKS_PRE_IO means dio within i_size or
> dioread_nolock buffer writeback, they all means we need a unwritten
> extent(or this extent has already been initialized), and the split won't
> zero the range we really write. So this check seems useless. Besides,
> even if we repeatedly execute ext4_es_insert_extent, there won't
> actually be any issues.
> 
> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Yang Erkun <yangerkun@huawei.com>
> ---
>  fs/ext4/inode.c | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index e99306a8f47c..e8bac93ca668 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -583,7 +583,6 @@ static int ext4_map_query_blocks(handle_t *handle, struct inode *inode,
>  static int ext4_map_create_blocks(handle_t *handle, struct inode *inode,
>  				  struct ext4_map_blocks *map, int flags)
>  {
> -	struct extent_status es;
>  	unsigned int status;
>  	int err, retval = 0;
>  
> @@ -644,16 +643,6 @@ static int ext4_map_create_blocks(handle_t *handle, struct inode *inode,
>  			return err;
>  	}
>  
> -	/*
> -	 * If the extent has been zeroed out, we don't need to update
> -	 * extent status tree.
> -	 */
> -	if (flags & EXT4_GET_BLOCKS_PRE_IO &&
> -	    ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es)) {
> -		if (ext4_es_is_written(&es))
> -			return retval;
> -	}
> -

Sorry, I think I was wrong and I now realize that we need to keep this code
snippet. Because ext4_split_extent() may convert the on-disk extent to written
with the EXT4_EXT_MAY_ZEROOUT flag set. If we drop this check, it will add an
unwritten extent into the extent status tree, which is inconsistent with the
real one.

Although this might not seem like a practical issue now, it's a potential
problem and conflicts with the ext4_es_cache_extent() extension I am currently
developing[1], which triggers a mismatch alarm when caching extents.

Besides, I also notice there is a potential stale data issue about the
EXT4_EXT_MAY_ZEROOUT flag.

Assume we have an unwritten file, and then DIO writes the second half.

   [UUUUUUUUUUUUUUUU] on-disk extent
   [UUUUUUUUUUUUUUUU] extent status tree
            |<----->| dio write

1. ext4_iomap_alloc() call ext4_map_blocks() with EXT4_GET_BLOCKS_PRE_IO,
   EXT4_GET_BLOCKS_UNWRIT_EXT and EXT4_GET_BLOCKS_CREATE flags set.
2. ext4_map_blocks() find this extent and call ext4_split_convert_extents()
   with EXT4_GET_BLOCKS_CONVERT and the above flags set.
3. call ext4_split_extent() with EXT4_EXT_MAY_ZEROOUT, EXT4_EXT_MARK_UNWRIT2 and
   EXT4_EXT_DATA_VALID2 flags set.
4. call ext4_split_extent_at() to split the second half with EXT4_EXT_DATA_VALID2,
   EXT4_EXT_MARK_UNWRIT1, EXT4_EXT_MAY_ZEROOUT and EXT4_EXT_MARK_UNWRIT2 flags
   set.
5. We failed to insert extent since -NOSPC in ext4_split_extent_at().
6. ext4_split_extent_at() zero out the first half but convert the entire on-disk
   extent to written since the EXT4_EXT_DATA_VALID2 flag set, and left the second
   half as unwritten in the extent status tree.

   [0000000000SSSSSS]  data
   [WWWWWWWWWWWWWWWW]  on-disk extent
   [WWWWWWWWWWUUUUUU]  extent status tree

7. If the dio failed to write data to the disk, If DIO fails to write data, the
   stale data in the second half will be exposed.

Therefore, I think we should zero out the entire extent range to zero for this
case, and also mark the extent as written in the extent status tree (that is the
another reason I think we should keep this code snippet). I was still confirming
this issue and thinking about how to fix it, but I believe it would be better
not to merge this patch for now. What do you think?

[1]. https://lore.kernel.org/linux-ext4/20251031062905.4135909-1-yi.zhang@huaweicloud.com/

Thanks,
Yi.

>  	status = map->m_flags & EXT4_MAP_UNWRITTEN ?
>  			EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
>  	ext4_es_insert_extent(inode, map->m_lblk, map->m_len, map->m_pblk,


