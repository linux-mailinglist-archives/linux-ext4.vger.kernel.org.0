Return-Path: <linux-ext4+bounces-452-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AB7814100
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Dec 2023 05:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 383391C20D65
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Dec 2023 04:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13503CA7B;
	Fri, 15 Dec 2023 04:36:26 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C59FCA69
	for <linux-ext4@vger.kernel.org>; Fri, 15 Dec 2023 04:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SrxHj28Rxz4f3jZH
	for <linux-ext4@vger.kernel.org>; Fri, 15 Dec 2023 12:36:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 8FBF31A0876
	for <linux-ext4@vger.kernel.org>; Fri, 15 Dec 2023 12:36:18 +0800 (CST)
Received: from [10.174.176.34] (unknown [10.174.176.34])
	by APP1 (Coremail) with SMTP id cCh0CgBntQvA13tlk_+_Dg--.49081S3;
	Fri, 15 Dec 2023 12:36:18 +0800 (CST)
Subject: Re: [RFC PATCH 3/6] ext4: correct the hole length returned by
 ext4_map_blocks()
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 ritesh.list@gmail.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com
References: <20231121093429.1827390-1-yi.zhang@huaweicloud.com>
 <20231121093429.1827390-4-yi.zhang@huaweicloud.com>
 <20231213182114.tzwsqpeonr5ok3j2@quack3>
 <52f6786a-b936-9f79-bea0-ed54a57efd62@huaweicloud.com>
 <20231214143108.36ywegeshzv4j2ut@quack3>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <39741481-6b57-2140-dfd2-473199d3f15d@huaweicloud.com>
Date: Fri, 15 Dec 2023 12:36:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231214143108.36ywegeshzv4j2ut@quack3>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBntQvA13tlk_+_Dg--.49081S3
X-Coremail-Antispam: 1UD129KBjvJXoW3XFyxKr4kuw1kXr18JF47urg_yoW7tr1fpr
	Z3CF13Gw4UWw1j9F4SqF15Xr1S9w18JF4UXrW3Gr1rAas0yF1fKF1UJF129Fy0grWxJF1j
	qF4Ut347Ca1YyrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2023/12/14 22:31, Jan Kara wrote:
> On Thu 14-12-23 17:18:45, Zhang Yi wrote:
>> On 2023/12/14 2:21, Jan Kara wrote:
>>> On Tue 21-11-23 17:34:26, Zhang Yi wrote:
>>>> From: Zhang Yi <yi.zhang@huawei.com>
>>>>
>>>> In ext4_map_blocks(), if we can't find a range of mapping in the
>>>> extents cache, we are calling ext4_ext_map_blocks() to search the real
>>>> path. But if the querying range was tail overlaped by a delayed extent,
>>>> we can't find it on the real extent path, so the returned hole length
>>>> could be larger than it really is.
>>>>
>>>>       |          querying map          |
>>>>       v                                v
>>>>       |----------{-------------}{------|----------------}-----...
>>>>       ^          ^             ^^                       ^
>>>>       | uncached | hole extent ||     delayed extent    |
>>>>
>>>> We have to adjust the mapping length to the next not hole extent's
>>>> lblk before searching the extent path.
>>>>
>>>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>>>
>>> So I agree the ext4_ext_determine_hole() does return a hole that does not
>>> reflect possible delalloc extent (it doesn't even need to be straddling the
>>> end of looked up range, does it?). But ext4_ext_put_gap_in_cache() does
>>
>> Yeah.
>>
>>> actually properly trim the hole length in the status tree so I think the
>>> problem rather is that the trimming should happen in
>>> ext4_ext_determine_hole() instead of ext4_ext_put_gap_in_cache() and that
>>> will also make ext4_map_blocks() return proper hole length? And then
>>> there's no need for this special handling? Or am I missing something?
>>>
>>
>> Thanks for your suggestions. Yeah, we can trim the hole length in
>> ext4_ext_determine_hole(), but I'm a little uneasy about the race condition.
>> ext4_da_map_blocks() only hold inode lock and i_data_sem read lock while
>> inserting delay extents, and not all query path of ext4_map_blocks() hold
>> inode lock.
> 
> That is a good point! I think something like following could happen already
> now:
> 
> Suppose we have a file 8192 bytes large containing just a hole.
> 
> Task1					Task2
> pread(f, buf, 4096, 0)			pwrite(f, buf, 4096, 4096)
>   filemap_read()
>     filemap_get_pages()
>       filemap_create_folio()
>         filemap_read_folio()
>           ext4_mpage_readpages()
>             ext4_map_blocks()
> 	      down_read(&EXT4_I(inode)->i_data_sem);
>               ext4_ext_map_blocks()
> 		- finds hole 0..8192
> 	        ext4_ext_put_gap_in_cache()
> 		  ext4_es_find_extent_range()
> 		    - finds no delalloc extent
> 					  ext4_da_write_begin()
> 					    ext4_da_get_block_prep()
> 					      ext4_da_map_blocks()
> 					        down_read(&EXT4_I(inode)->i_data_sem);
> 					        ext4_ext_map_blocks()
> 						  - nothing found
> 						ext4_insert_delayed_block()
> 						  - inserts delalloc extent
> 						    to 4096-8192
> 		  ext4_es_insert_extent()
> 		    - inserts 0..8192 a hole overwriting delalloc extent
> 
>> I guess the hole/delayed range could be raced by another new
>> delay allocation and changed after we first check in ext4_map_blocks(),
>> the querying range could be overlapped and became all or partial delayed,
>> so we also need to recheck the map type here if the start querying block
>> has became delayed, right?
> 
> I don't think think you can fix this just by rechecking. I think we need to
> hold i_data_sem in exclusive mode when inserting delalloc extents. Because
> that operation is in fact changing state of allocation tree (although not
> on disk yet). And that will fix this race because holding i_data_sem shared
> is then enough so that delalloc state cannot change.
> 
> Please do this as a separate patch because this will need to be backported
> to stable tree. Thanks!
> 

Thanks for the insightful graph，I totally agree with you. For now the absent
delayed extents could lead to inaccurate space reservation and perhaps some
other potential problems. I will send a separate patch to fix this long
standing issue.

Thanks,
Yi.

> 
>>>> ---
>>>>  fs/ext4/inode.c | 24 ++++++++++++++++++++++--
>>>>  1 file changed, 22 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>>>> index 4ce35f1c8b0a..94e7b8500878 100644
>>>> --- a/fs/ext4/inode.c
>>>> +++ b/fs/ext4/inode.c
>>>> @@ -479,6 +479,7 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
>>>>  		    struct ext4_map_blocks *map, int flags)
>>>>  {
>>>>  	struct extent_status es;
>>>> +	ext4_lblk_t next;
>>>>  	int retval;
>>>>  	int ret = 0;
>>>>  #ifdef ES_AGGRESSIVE_TEST
>>>> @@ -502,8 +503,10 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
>>>>  		return -EFSCORRUPTED;
>>>>  
>>>>  	/* Lookup extent status tree firstly */
>>>> -	if (!(EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY) &&
>>>> -	    ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es)) {
>>>> +	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
>>>> +		goto uncached;
>>>> +
>>>> +	if (ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es)) {
>>>>  		if (ext4_es_is_written(&es) || ext4_es_is_unwritten(&es)) {
>>>>  			map->m_pblk = ext4_es_pblock(&es) +
>>>>  					map->m_lblk - es.es_lblk;
>>>> @@ -532,6 +535,23 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
>>>>  #endif
>>>>  		goto found;
>>>>  	}
>>>> +	/*
>>>> +	 * Not found, maybe a hole, need to adjust the map length before
>>>> +	 * seraching the real extent path. It can prevent incorrect hole
>>>> +	 * length returned if the following entries have delayed only
>>>> +	 * ones.
>>>> +	 */
>>>> +	if (!(flags & EXT4_GET_BLOCKS_CREATE) && es.es_lblk > map->m_lblk) {
>>>> +		next = es.es_lblk;
>>>> +		if (ext4_es_is_hole(&es))
>>>> +			next = ext4_es_skip_hole_extent(inode, map->m_lblk,
>>>> +							map->m_len);
>>>> +		retval = next - map->m_lblk;
>>>> +		if (map->m_len > retval)
>>>> +			map->m_len = retval;
>>>> +	}
>>>> +
>>>> +uncached:
>>>>  	/*
>>>>  	 * In the query cache no-wait mode, nothing we can do more if we
>>>>  	 * cannot find extent in the cache.
>>>> -- 
>>>> 2.39.2
>>>>
>>


