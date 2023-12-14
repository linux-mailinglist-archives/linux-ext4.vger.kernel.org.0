Return-Path: <linux-ext4+bounces-445-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0E8812B7C
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Dec 2023 10:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74CC6B212B4
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Dec 2023 09:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1CE2E3F0;
	Thu, 14 Dec 2023 09:18:55 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADACB7
	for <linux-ext4@vger.kernel.org>; Thu, 14 Dec 2023 01:18:50 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SrRc45PGHz4f3kFG
	for <linux-ext4@vger.kernel.org>; Thu, 14 Dec 2023 17:18:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 4F01B1A096D
	for <linux-ext4@vger.kernel.org>; Thu, 14 Dec 2023 17:18:47 +0800 (CST)
Received: from [10.174.176.34] (unknown [10.174.176.34])
	by APP1 (Coremail) with SMTP id cCh0CgDXJg11yHplHsx1Dg--.33268S3;
	Thu, 14 Dec 2023 17:18:47 +0800 (CST)
Subject: Re: [RFC PATCH 3/6] ext4: correct the hole length returned by
 ext4_map_blocks()
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 ritesh.list@gmail.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com
References: <20231121093429.1827390-1-yi.zhang@huaweicloud.com>
 <20231121093429.1827390-4-yi.zhang@huaweicloud.com>
 <20231213182114.tzwsqpeonr5ok3j2@quack3>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <52f6786a-b936-9f79-bea0-ed54a57efd62@huaweicloud.com>
Date: Thu, 14 Dec 2023 17:18:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231213182114.tzwsqpeonr5ok3j2@quack3>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgDXJg11yHplHsx1Dg--.33268S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGw4UCF45uF4DZr17WFWxJFb_yoWrXr4xpr
	Z3CF13Gw4DWw1j9FWftF47XF1S9a18JF4UJ3yftr1rAa98AF1fKF1UAF1I9a48KrWxXF1F
	qF4Ut347Ca1YkaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2023/12/14 2:21, Jan Kara wrote:
> On Tue 21-11-23 17:34:26, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> In ext4_map_blocks(), if we can't find a range of mapping in the
>> extents cache, we are calling ext4_ext_map_blocks() to search the real
>> path. But if the querying range was tail overlaped by a delayed extent,
>> we can't find it on the real extent path, so the returned hole length
>> could be larger than it really is.
>>
>>       |          querying map          |
>>       v                                v
>>       |----------{-------------}{------|----------------}-----...
>>       ^          ^             ^^                       ^
>>       | uncached | hole extent ||     delayed extent    |
>>
>> We have to adjust the mapping length to the next not hole extent's
>> lblk before searching the extent path.
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> 
> So I agree the ext4_ext_determine_hole() does return a hole that does not
> reflect possible delalloc extent (it doesn't even need to be straddling the
> end of looked up range, does it?). But ext4_ext_put_gap_in_cache() does

Yeah.

> actually properly trim the hole length in the status tree so I think the
> problem rather is that the trimming should happen in
> ext4_ext_determine_hole() instead of ext4_ext_put_gap_in_cache() and that
> will also make ext4_map_blocks() return proper hole length? And then
> there's no need for this special handling? Or am I missing something?
> 

Thanks for your suggestions. Yeah, we can trim the hole length in
ext4_ext_determine_hole(), but I'm a little uneasy about the race condition.
ext4_da_map_blocks() only hold inode lock and i_data_sem read lock while
inserting delay extents, and not all query path of ext4_map_blocks() hold
inode lock. I guess the hole/delayed range could be raced by another new
delay allocation and changed after we first check in ext4_map_blocks(),
the querying range could be overlapped and became all or partial delayed,
so we also need to recheck the map type here if the start querying block
has became delayed, right?

Thanks,
Yi.

> 
>> ---
>>  fs/ext4/inode.c | 24 ++++++++++++++++++++++--
>>  1 file changed, 22 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index 4ce35f1c8b0a..94e7b8500878 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -479,6 +479,7 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
>>  		    struct ext4_map_blocks *map, int flags)
>>  {
>>  	struct extent_status es;
>> +	ext4_lblk_t next;
>>  	int retval;
>>  	int ret = 0;
>>  #ifdef ES_AGGRESSIVE_TEST
>> @@ -502,8 +503,10 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
>>  		return -EFSCORRUPTED;
>>  
>>  	/* Lookup extent status tree firstly */
>> -	if (!(EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY) &&
>> -	    ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es)) {
>> +	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
>> +		goto uncached;
>> +
>> +	if (ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es)) {
>>  		if (ext4_es_is_written(&es) || ext4_es_is_unwritten(&es)) {
>>  			map->m_pblk = ext4_es_pblock(&es) +
>>  					map->m_lblk - es.es_lblk;
>> @@ -532,6 +535,23 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
>>  #endif
>>  		goto found;
>>  	}
>> +	/*
>> +	 * Not found, maybe a hole, need to adjust the map length before
>> +	 * seraching the real extent path. It can prevent incorrect hole
>> +	 * length returned if the following entries have delayed only
>> +	 * ones.
>> +	 */
>> +	if (!(flags & EXT4_GET_BLOCKS_CREATE) && es.es_lblk > map->m_lblk) {
>> +		next = es.es_lblk;
>> +		if (ext4_es_is_hole(&es))
>> +			next = ext4_es_skip_hole_extent(inode, map->m_lblk,
>> +							map->m_len);
>> +		retval = next - map->m_lblk;
>> +		if (map->m_len > retval)
>> +			map->m_len = retval;
>> +	}
>> +
>> +uncached:
>>  	/*
>>  	 * In the query cache no-wait mode, nothing we can do more if we
>>  	 * cannot find extent in the cache.
>> -- 
>> 2.39.2
>>


