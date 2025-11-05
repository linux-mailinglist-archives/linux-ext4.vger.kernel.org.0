Return-Path: <linux-ext4+bounces-11464-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F026C33AED
	for <lists+linux-ext4@lfdr.de>; Wed, 05 Nov 2025 02:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5967E4E5CF5
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Nov 2025 01:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC8022127A;
	Wed,  5 Nov 2025 01:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="5mv2i+Lg"
X-Original-To: linux-ext4@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720F228DC4
	for <linux-ext4@vger.kernel.org>; Wed,  5 Nov 2025 01:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762306753; cv=none; b=Q8d6ywh+BWm+26/0FsY+3cBgpztN3WUIipCyDp5WB05HNZ9eEcHoM0f+1UytL+s5PDyUpxhV6wkdQoPkWjE7jjwhYERnBHBr/K8wyxECDoII1HVcFdGEtu0916sDsdlXdIFp+PtsqmF2BkMUDOzlYmOUvZv3ohEub2m41s53hQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762306753; c=relaxed/simple;
	bh=L0ilZKX29ZJ2iH3epKctEou+1MP4s1hcBqaZQbzjkdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=p1C5skKxvY1JxfjYMQMk5Z3vIp1dxLTP7R7Vt5W2/3ldFBCckiw9T5ndBcdG9JP+0zjNGLyRnK9MseWItiudZ0r7LFiRy7Q4H8vnDIwDeL+iGkXFj4hP2/U3ggx2sTQvfSDEY/kozZdSYpicyl0XQrborIiRZA0r0N+iAn32WY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=5mv2i+Lg; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=/wkCPjEUqSdB3HKsy7A+Wmr+BsWOJm/T3Y87LFtNb+I=;
	b=5mv2i+LgmihkDrkrSdk7FmIkTb06pVsFFPwGx3AwdZSfxJU5xnUL0C3T4gQvvU1X2KIW5Rrio
	fTTaXh9ZCPcKzmqL9zTHsgb5P1ck86rlbYuju9MkGq0G8qcvWT5wDsS6O9NMEl4LrGLhaSU4RhZ
	Oz+0N7x2vVBiV6llH5SRvJs=
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4d1ScQ2qj2zcZxy;
	Wed,  5 Nov 2025 09:37:26 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id 6FAA8180491;
	Wed,  5 Nov 2025 09:39:02 +0800 (CST)
Received: from [10.174.177.210] (10.174.177.210) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 5 Nov 2025 09:39:01 +0800
Message-ID: <09cae118-2ee1-745f-afb8-6c6723b59e7d@huawei.com>
Date: Wed, 5 Nov 2025 09:39:01 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 1/4] ext4: remove useless code in
 ext4_map_create_blocks
To: Jan Kara <jack@suse.cz>
CC: <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<yi.zhang@huawei.com>, <libaokun1@huawei.com>, <yangerkun@huaweicloud.com>
References: <20251104131750.1581541-1-yangerkun@huawei.com>
 <j7hzyzb6ounq5tofuxg6mwmb4w5c2ldmkat6ngaf2ijt3rgsfc@fdty7kn7bdjn>
From: yangerkun <yangerkun@huawei.com>
In-Reply-To: <j7hzyzb6ounq5tofuxg6mwmb4w5c2ldmkat6ngaf2ijt3rgsfc@fdty7kn7bdjn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf100006.china.huawei.com (7.202.181.220)



在 2025/11/4 22:28, Jan Kara 写道:
> On Tue 04-11-25 21:17:47, Yang Erkun wrote:
>> IO path with EXT4_GET_BLOCKS_PRE_IO means dio within i_size or
>> dioread_nolock buffer writeback, they all means we need a unwritten
>> extent(or this extent has already been initialized), and the split won't
>> zero the range we really write. So this check seems useless. Besides,
>> even if we repeatedly execute ext4_es_insert_extent, there won't
>> actually be any issues.
>>
>> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
>> Signed-off-by: Yang Erkun <yangerkun@huawei.com>
> 
> I agree the check isn't needed for correctness but it seems to be
> reasonable performance optimization for a common case of writing back
> already written data in dioread_nolock mode?

Hi!

Thank you for your detailed review! I believe you are referring to
writing back a block within the written extent in dioread_nolock mode.
If that's the case, we might never enter ext4_map_create_blocks because
ext4_map_query_blocks will return the block as MAPPED. Please correct me
if I misunderstood!

Thanks,
Erkun.

> 
> 								Honza
> 
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
>>   	status = map->m_flags & EXT4_MAP_UNWRITTEN ?
>>   			EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
>>   	ext4_es_insert_extent(inode, map->m_lblk, map->m_len, map->m_pblk,
>> -- 
>> 2.39.2
>>

