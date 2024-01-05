Return-Path: <linux-ext4+bounces-729-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CEE82529F
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Jan 2024 12:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EE70284DC7
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Jan 2024 11:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8020528DDD;
	Fri,  5 Jan 2024 11:17:21 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D2A28E12
	for <linux-ext4@vger.kernel.org>; Fri,  5 Jan 2024 11:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4T61Bc6j8mz4f3k64
	for <linux-ext4@vger.kernel.org>; Fri,  5 Jan 2024 19:17:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id BBFC71A0483
	for <linux-ext4@vger.kernel.org>; Fri,  5 Jan 2024 19:17:14 +0800 (CST)
Received: from [10.174.176.34] (unknown [10.174.176.34])
	by APP1 (Coremail) with SMTP id cCh0CgBnaQ855ZdlNO1gFg--.51224S3;
	Fri, 05 Jan 2024 19:17:14 +0800 (CST)
Subject: Re: [PATCH v3 3/6] ext4: correct the hole length returned by
 ext4_map_blocks()
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
References: <20240105033018.1665752-1-yi.zhang@huaweicloud.com>
 <20240105033018.1665752-4-yi.zhang@huaweicloud.com>
 <20240105101723.gl5ew2mkhtn4nyyg@quack3>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <e4e6b356-c7fb-f696-b0a9-58c26174f32a@huaweicloud.com>
Date: Fri, 5 Jan 2024 19:17:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240105101723.gl5ew2mkhtn4nyyg@quack3>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgBnaQ855ZdlNO1gFg--.51224S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Wr48ZFy7WrykZr48Ar15XFb_yoWxAw48pF
	WfuF15Gw45W34j9rWxZF45Zr1F93W8CrW7ArWftr1Syas0yr48WF18GF129FZ7trWrG3WY
	vr4jya47Can0kFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/1/5 18:17, Jan Kara wrote:
> On Fri 05-01-24 11:30:15, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> In ext4_map_blocks(), if we can't find a range of mapping in the
>> extents cache, we are calling ext4_ext_map_blocks() to search the real
>> path and ext4_ext_determine_hole() to determine the hole range. But if
>> the querying range was partially or completely overlaped by a delalloc
>> extent, we can't find it in the real extent path, so the returned hole
>> length could be incorrect.
>>
>> Fortunately, ext4_ext_put_gap_in_cache() have already handle delalloc
>> extent, but it searches start from the expanded hole_start, doesn't
>> start from the querying range, so the delalloc extent found could not be
>> the one that overlaped the querying range, plus, it also didn't adjust
>> the hole length. Let's just remove ext4_ext_put_gap_in_cache(), handle
>> delalloc and insert adjusted hole extent in ext4_ext_determine_hole().
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>> Suggested-by: Jan Kara <jack@suse.cz>
> 
> Thanks! Looks good. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 

Thanks a lot for your review!

Yi.

> 
>> ---
>>  fs/ext4/extents.c | 111 +++++++++++++++++++++++++++++-----------------
>>  1 file changed, 70 insertions(+), 41 deletions(-)
>>
>> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
>> index d5efe076d3d3..e0b7e48c4c67 100644
>> --- a/fs/ext4/extents.c
>> +++ b/fs/ext4/extents.c
>> @@ -2229,7 +2229,7 @@ static int ext4_fill_es_cache_info(struct inode *inode,
>>  
>>  
>>  /*
>> - * ext4_ext_determine_hole - determine hole around given block
>> + * ext4_ext_find_hole - find hole around given block according to the given path
>>   * @inode:	inode we lookup in
>>   * @path:	path in extent tree to @lblk
>>   * @lblk:	pointer to logical block around which we want to determine hole
>> @@ -2241,9 +2241,9 @@ static int ext4_fill_es_cache_info(struct inode *inode,
>>   * The function returns the length of a hole starting at @lblk. We update @lblk
>>   * to the beginning of the hole if we managed to find it.
>>   */
>> -static ext4_lblk_t ext4_ext_determine_hole(struct inode *inode,
>> -					   struct ext4_ext_path *path,
>> -					   ext4_lblk_t *lblk)
>> +static ext4_lblk_t ext4_ext_find_hole(struct inode *inode,
>> +				      struct ext4_ext_path *path,
>> +				      ext4_lblk_t *lblk)
>>  {
>>  	int depth = ext_depth(inode);
>>  	struct ext4_extent *ex;
>> @@ -2270,30 +2270,6 @@ static ext4_lblk_t ext4_ext_determine_hole(struct inode *inode,
>>  	return len;
>>  }
>>  
>> -/*
>> - * ext4_ext_put_gap_in_cache:
>> - * calculate boundaries of the gap that the requested block fits into
>> - * and cache this gap
>> - */
>> -static void
>> -ext4_ext_put_gap_in_cache(struct inode *inode, ext4_lblk_t hole_start,
>> -			  ext4_lblk_t hole_len)
>> -{
>> -	struct extent_status es;
>> -
>> -	ext4_es_find_extent_range(inode, &ext4_es_is_delayed, hole_start,
>> -				  hole_start + hole_len - 1, &es);
>> -	if (es.es_len) {
>> -		/* There's delayed extent containing lblock? */
>> -		if (es.es_lblk <= hole_start)
>> -			return;
>> -		hole_len = min(es.es_lblk - hole_start, hole_len);
>> -	}
>> -	ext_debug(inode, " -> %u:%u\n", hole_start, hole_len);
>> -	ext4_es_insert_extent(inode, hole_start, hole_len, ~0,
>> -			      EXTENT_STATUS_HOLE);
>> -}
>> -
>>  /*
>>   * ext4_ext_rm_idx:
>>   * removes index from the index block.
>> @@ -4062,6 +4038,69 @@ static int get_implied_cluster_alloc(struct super_block *sb,
>>  	return 0;
>>  }
>>  
>> +/*
>> + * Determine hole length around the given logical block, first try to
>> + * locate and expand the hole from the given @path, and then adjust it
>> + * if it's partially or completely converted to delayed extents, insert
>> + * it into the extent cache tree if it's indeed a hole, finally return
>> + * the length of the determined extent.
>> + */
>> +static ext4_lblk_t ext4_ext_determine_insert_hole(struct inode *inode,
>> +						  struct ext4_ext_path *path,
>> +						  ext4_lblk_t lblk)
>> +{
>> +	ext4_lblk_t hole_start, len;
>> +	struct extent_status es;
>> +
>> +	hole_start = lblk;
>> +	len = ext4_ext_find_hole(inode, path, &hole_start);
>> +again:
>> +	ext4_es_find_extent_range(inode, &ext4_es_is_delayed, hole_start,
>> +				  hole_start + len - 1, &es);
>> +	if (!es.es_len)
>> +		goto insert_hole;
>> +
>> +	/*
>> +	 * There's a delalloc extent in the hole, handle it if the delalloc
>> +	 * extent is in front of, behind and straddle the queried range.
>> +	 */
>> +	if (lblk >= es.es_lblk + es.es_len) {
>> +		/*
>> +		 * The delalloc extent is in front of the queried range,
>> +		 * find again from the queried start block.
>> +		 */
>> +		len -= lblk - hole_start;
>> +		hole_start = lblk;
>> +		goto again;
>> +	} else if (in_range(lblk, es.es_lblk, es.es_len)) {
>> +		/*
>> +		 * The delalloc extent containing lblk, it must have been
>> +		 * added after ext4_map_blocks() checked the extent status
>> +		 * tree, adjust the length to the delalloc extent's after
>> +		 * lblk.
>> +		 */
>> +		len = es.es_lblk + es.es_len - lblk;
>> +		return len;
>> +	} else {
>> +		/*
>> +		 * The delalloc extent is partially or completely behind
>> +		 * the queried range, update hole length until the
>> +		 * beginning of the delalloc extent.
>> +		 */
>> +		len = min(es.es_lblk - hole_start, len);
>> +	}
>> +
>> +insert_hole:
>> +	/* Put just found gap into cache to speed up subsequent requests */
>> +	ext_debug(inode, " -> %u:%u\n", hole_start, len);
>> +	ext4_es_insert_extent(inode, hole_start, len, ~0, EXTENT_STATUS_HOLE);
>> +
>> +	/* Update hole_len to reflect hole size after lblk */
>> +	if (hole_start != lblk)
>> +		len -= lblk - hole_start;
>> +
>> +	return len;
>> +}
>>  
>>  /*
>>   * Block allocation/map/preallocation routine for extents based files
>> @@ -4179,22 +4218,12 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
>>  	 * we couldn't try to create block if create flag is zero
>>  	 */
>>  	if ((flags & EXT4_GET_BLOCKS_CREATE) == 0) {
>> -		ext4_lblk_t hole_start, hole_len;
>> +		ext4_lblk_t len;
>>  
>> -		hole_start = map->m_lblk;
>> -		hole_len = ext4_ext_determine_hole(inode, path, &hole_start);
>> -		/*
>> -		 * put just found gap into cache to speed up
>> -		 * subsequent requests
>> -		 */
>> -		ext4_ext_put_gap_in_cache(inode, hole_start, hole_len);
>> +		len = ext4_ext_determine_insert_hole(inode, path, map->m_lblk);
>>  
>> -		/* Update hole_len to reflect hole size after map->m_lblk */
>> -		if (hole_start != map->m_lblk)
>> -			hole_len -= map->m_lblk - hole_start;
>>  		map->m_pblk = 0;
>> -		map->m_len = min_t(unsigned int, map->m_len, hole_len);
>> -
>> +		map->m_len = min_t(unsigned int, map->m_len, len);
>>  		goto out;
>>  	}
>>  
>> -- 
>> 2.39.2
>>


