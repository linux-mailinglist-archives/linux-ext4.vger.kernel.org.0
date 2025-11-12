Return-Path: <linux-ext4+bounces-11807-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6A2C511DF
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Nov 2025 09:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA9D11897364
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Nov 2025 08:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A342D23BC;
	Wed, 12 Nov 2025 08:30:38 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F471F428C
	for <linux-ext4@vger.kernel.org>; Wed, 12 Nov 2025 08:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762936238; cv=none; b=SPTUWAWTzsnqfpv2vqMhCr2z1+FyAxvlHfXvaqjUqSdwxWQ4Da8Ju4WHrsJ2deZgCjCsYmjpOiwAABKWb39Hx68FtUX2gf5L3E4UYERAWVjRrtQvsptMjrKSRE/ttuQkDq6egDhtEAgZvirTwb928GFpGdj4F78nseQJWYiRWTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762936238; c=relaxed/simple;
	bh=jOAodWQOnBsaRxgRwJAkp73MDohrL3Tisxnl7DxYqnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e8Bx79h6++P8/wDRUmDggLVfAphbRPBZm2r+AZWBhxo8+sBCnAqqm10mHObGgq95PCFVSNSFJaEbnk5DOOf0bRcUrAlIvMC2+cEhkF6UmCl6x2r1Rj0Lq5s9+FOEChJqWCVYIPeBbxXNNoksN1JZHuW+EbMv3bHJKnfuOtyxvT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d5xRV6C88zKHMhp
	for <linux-ext4@vger.kernel.org>; Wed, 12 Nov 2025 16:30:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 2C3CB1A07C0
	for <linux-ext4@vger.kernel.org>; Wed, 12 Nov 2025 16:30:32 +0800 (CST)
Received: from [10.174.177.210] (unknown [10.174.177.210])
	by APP2 (Coremail) with SMTP id Syh0CgBHo3mlRRRpgG_hAQ--.56590S3;
	Wed, 12 Nov 2025 16:30:30 +0800 (CST)
Message-ID: <2385bfd4-bc58-6dd3-5d33-9a21cb36ca6e@huaweicloud.com>
Date: Wed, 12 Nov 2025 16:30:28 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 1/3] ext4: remove useless code in
 ext4_map_create_blocks
To: Zhang Yi <yi.zhang@huaweicloud.com>, Yang Erkun <yangerkun@huawei.com>,
 linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 jack@suse.cz
Cc: libaokun1@huawei.com
References: <20251107115810.47199-1-yangerkun@huawei.com>
 <72def5a4-c30a-4461-8bce-c6c2b09b044c@huaweicloud.com>
From: yangerkun <yangerkun@huaweicloud.com>
In-Reply-To: <72def5a4-c30a-4461-8bce-c6c2b09b044c@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBHo3mlRRRpgG_hAQ--.56590S3
X-Coremail-Antispam: 1UD129KBjvJXoW3GFW5Xr18tFyDJry3uryrtFb_yoW7XryxpF
	ZakF1xGr4kt3y8urWIkF1DXFyYgw1UGrW7CrW7Gw1UKa45tryS9F1Sya4F9Fy0grZ5Za1Y
	qFWFya4ku3Z8AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
	IcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUbSfO7UUUUU==
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/



在 2025/11/12 12:46, Zhang Yi 写道:
> Hi!
> 
> On 11/7/2025 7:58 PM, Yang Erkun wrote:
>> IO path with EXT4_GET_BLOCKS_PRE_IO means dio within i_size or
>> dioread_nolock buffer writeback, they all means we need a unwritten
>> extent(or this extent has already been initialized), and the split won't
>> zero the range we really write. So this check seems useless. Besides,
>> even if we repeatedly execute ext4_es_insert_extent, there won't
>> actually be any issues.
>>
>> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
>> Reviewed-by: Jan Kara <jack@suse.cz>
>> Signed-off-by: Yang Erkun <yangerkun@huawei.com>
>> ---
>>   fs/ext4/inode.c | 11 -----------
>>   1 file changed, 11 deletions(-)
>>
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index e99306a8f47c..e8bac93ca668 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -583,7 +583,6 @@ static int ext4_map_query_blocks(handle_t *handle, struct inode *inode,
>>   static int ext4_map_create_blocks(handle_t *handle, struct inode *inode,
>>   				  struct ext4_map_blocks *map, int flags)
>>   {
>> -	struct extent_status es;
>>   	unsigned int status;
>>   	int err, retval = 0;
>>   
>> @@ -644,16 +643,6 @@ static int ext4_map_create_blocks(handle_t *handle, struct inode *inode,
>>   			return err;
>>   	}
>>   
>> -	/*
>> -	 * If the extent has been zeroed out, we don't need to update
>> -	 * extent status tree.
>> -	 */
>> -	if (flags & EXT4_GET_BLOCKS_PRE_IO &&
>> -	    ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es)) {
>> -		if (ext4_es_is_written(&es))
>> -			return retval;
>> -	}
>> -
> 
> Sorry, I think I was wrong and I now realize that we need to keep this code
> snippet. Because ext4_split_extent() may convert the on-disk extent to written
> with the EXT4_EXT_MAY_ZEROOUT flag set. If we drop this check, it will add an
> unwritten extent into the extent status tree, which is inconsistent with the
> real one.
> 
> Although this might not seem like a practical issue now, it's a potential
> problem and conflicts with the ext4_es_cache_extent() extension I am currently
> developing[1], which triggers a mismatch alarm when caching extents.
> 
> Besides, I also notice there is a potential stale data issue about the
> EXT4_EXT_MAY_ZEROOUT flag.
> 
> Assume we have an unwritten file, and then DIO writes the second half.
> 
>     [UUUUUUUUUUUUUUUU] on-disk extent
>     [UUUUUUUUUUUUUUUU] extent status tree
>              |<----->| dio write
> 
> 1. ext4_iomap_alloc() call ext4_map_blocks() with EXT4_GET_BLOCKS_PRE_IO,
>     EXT4_GET_BLOCKS_UNWRIT_EXT and EXT4_GET_BLOCKS_CREATE flags set.
> 2. ext4_map_blocks() find this extent and call ext4_split_convert_extents()
>     with EXT4_GET_BLOCKS_CONVERT and the above flags set.
> 3. call ext4_split_extent() with EXT4_EXT_MAY_ZEROOUT, EXT4_EXT_MARK_UNWRIT2 and
>     EXT4_EXT_DATA_VALID2 flags set.
> 4. call ext4_split_extent_at() to split the second half with EXT4_EXT_DATA_VALID2,
>     EXT4_EXT_MARK_UNWRIT1, EXT4_EXT_MAY_ZEROOUT and EXT4_EXT_MARK_UNWRIT2 flags
>     set.
> 5. We failed to insert extent since -NOSPC in ext4_split_extent_at().
> 6. ext4_split_extent_at() zero out the first half but convert the entire on-disk
>     extent to written since the EXT4_EXT_DATA_VALID2 flag set, and left the second
>     half as unwritten in the extent status tree.
> 
>     [0000000000SSSSSS]  data
>     [WWWWWWWWWWWWWWWW]  on-disk extent
>     [WWWWWWWWWWUUUUUU]  extent status tree
> 
> 7. If the dio failed to write data to the disk, If DIO fails to write data, the
>     stale data in the second half will be exposed.
> 
> Therefore, I think we should zero out the entire extent range to zero for this
> case, and also mark the extent as written in the extent status tree (that is the
> another reason I think we should keep this code snippet). I was still confirming
> this issue and thinking about how to fix it, but I believe it would be better
> not to merge this patch for now. What do you think?


Hi,

Thank you very much for your detailed analysis!

Yes, ext4_split_extent with EXT4_EXT_DATA_VALID2 indicates that the
mapped range has been written and contains valid data. It seems correct
that ext4_convert_unwritten_extents_endio calls
ext4_split_convert_extents with EXT4_GET_BLOCKS_CONVERT. However, for
the I/O submit context, which calls ext4_split_convert_extents with
EXT4_GET_BLOCKS_CONVERT from ext4_ext_handle_unwritten_extents, the
mapped range is still an unwritten extent and does not contain valid
data. This could lead to the stale data issue you described. Therefore,
the root cause is that we cannot use EXT4_GET_BLOCKS_CONVERT in the I/O
submit context, but it appears difficult to prevent this.

Additionally, I agree with you that merging this patch should be
avoided. Thanks again for your thorough review!

Thanks,
Erkun.

> 
> [1]. https://lore.kernel.org/linux-ext4/20251031062905.4135909-1-yi.zhang@huaweicloud.com/
> 
> Thanks,
> Yi.
> 
>>   	status = map->m_flags & EXT4_MAP_UNWRITTEN ?
>>   			EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
>>   	ext4_es_insert_extent(inode, map->m_lblk, map->m_len, map->m_pblk,


