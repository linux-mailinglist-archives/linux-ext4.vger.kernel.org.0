Return-Path: <linux-ext4+bounces-11643-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF79DC3FD2B
	for <lists+linux-ext4@lfdr.de>; Fri, 07 Nov 2025 12:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 844A13B7D35
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Nov 2025 11:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE422D879F;
	Fri,  7 Nov 2025 11:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="H9672jNI"
X-Original-To: linux-ext4@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32D721CFF6
	for <linux-ext4@vger.kernel.org>; Fri,  7 Nov 2025 11:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762516455; cv=none; b=bJYuvgwvbNQRRfSgQgqDAEuLFqtTmJp1+P6lTJAMAWE1st4vgBlHPVeGUxj5wt3qWLtfvMxBF0Ub0hEa32lDdjseOIv1HsBZwlBEhgHC47k+ql3jgg19YindIGCZ1W//9T9I8VCXOZYGzTDpwUGHGYYUCMYY6e6RrjrSuJynBwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762516455; c=relaxed/simple;
	bh=MgnREU5m1VvmFkCUpGaDOrfLko49J7uQ5+NoDTZ8sRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MZmZ/rIK9IGJLpUuSkCRlruu5LIi+Wnrt0XuHV/OapIW5D9KhrEurNUUwGDqWcVFpnRxtNg+zUQHiOyLGbhWXB7MY+Q9oeNKQvgTL3y2lvrS4hiMiRrtEMjmyi1zCLaPCAknevR9+DUDIDefsNdbca1wfF+dK0G7i8bS4914CPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=H9672jNI; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=We6WbmQQI5ZYA5roSv66eiKJVEkwXTsx2+JOWJ0OKD8=;
	b=H9672jNI4T0UmuK78GkXwS9Uaa5M3ASQgjruUS4imLXQn8EOhOsLb/y3sB3aXLWxnWO7HLmxa
	6VUIokN8lNYF+LlSEsBRx6IUQnduN/mOzsPBDFf1JqmxEEU9fcmX3tXWSnDKt4Uf49PmtR5ImXp
	hPzzn9O1/Tykdh9xPADe/ac=
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4d2y962WMNz1cyPm;
	Fri,  7 Nov 2025 19:52:26 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id 3305B140295;
	Fri,  7 Nov 2025 19:54:03 +0800 (CST)
Received: from [10.174.177.210] (10.174.177.210) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 7 Nov 2025 19:54:02 +0800
Message-ID: <0600ebcc-d7dd-3586-b855-a94985d3b3da@huawei.com>
Date: Fri, 7 Nov 2025 19:54:02 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 4/4] ext4: order mode should not take effect for DIO
To: Jan Kara <jack@suse.cz>
CC: <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<yi.zhang@huawei.com>, <libaokun1@huawei.com>, <yangerkun@huaweicloud.com>
References: <20251104131750.1581541-1-yangerkun@huawei.com>
 <20251104131750.1581541-4-yangerkun@huawei.com>
 <m4alrnslmj753wmjmvzydo3w2vq66plzkjj3rff4k2fqfc53mx@mvtip26su7d7>
From: yangerkun <yangerkun@huawei.com>
In-Reply-To: <m4alrnslmj753wmjmvzydo3w2vq66plzkjj3rff4k2fqfc53mx@mvtip26su7d7>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf100006.china.huawei.com (7.202.181.220)



在 2025/11/4 23:07, Jan Kara 写道:
> On Tue 04-11-25 21:17:50, Yang Erkun wrote:
>> Since the size will be updated after the DIO completes, the data
>> will not be shown to userspace before that.
>>
>> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
>> Signed-off-by: Yang Erkun <yangerkun@huawei.com>
> 
> Hum, is there some measurable performance benefit from this? If yes, it
> would be good to mention it in the changelog. If not, then why bother?

Hi,

I discovered this while debugging. Today, I also conducted some
performance tests on this patch, but it appears that there is no
noticeable improvement. Therefore, I agree with your suggestion and will
remove it in the next version!


Thanks,
Erkun.

> 
> 								Honza
> 
>> ---
>>   fs/ext4/ext4.h              | 2 ++
>>   fs/ext4/inode.c             | 5 +++--
>>   include/trace/events/ext4.h | 1 +
>>   3 files changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
>> index 96d7d649ccb0..d0331697467d 100644
>> --- a/fs/ext4/ext4.h
>> +++ b/fs/ext4/ext4.h
>> @@ -715,6 +715,8 @@ enum {
>>   #define EXT4_GET_BLOCKS_METADATA_NOFAIL		0x0020
>>   	/* Don't normalize allocation size (used for fallocate) */
>>   #define EXT4_GET_BLOCKS_NO_NORMALIZE		0x0040
>> +	/* Get blocks from DIO */
>> +#define EXT4_GET_BLOCKS_DIO			0x0080
>>   	/* Convert written extents to unwritten */
>>   #define EXT4_GET_BLOCKS_CONVERT_UNWRITTEN	0x0100
>>   	/* Write zeros to newly created written extents */
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index 3d8ada26d5cd..168dbcc9e921 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -818,6 +818,7 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
>>   		if (map->m_flags & EXT4_MAP_NEW &&
>>   		    !(map->m_flags & EXT4_MAP_UNWRITTEN) &&
>>   		    !(flags & EXT4_GET_BLOCKS_ZERO) &&
>> +		    !(flags & EXT4_GET_BLOCKS_DIO) &&
>>   		    !ext4_is_quota_file(inode) &&
>>   		    ext4_should_order_data(inode)) {
>>   			loff_t start_byte =
>> @@ -3729,9 +3730,9 @@ static int ext4_iomap_alloc(struct inode *inode, struct ext4_map_blocks *map,
>>   	 * happening and thus expose allocated blocks to direct I/O reads.
>>   	 */
>>   	else if (((loff_t)map->m_lblk << blkbits) >= i_size_read(inode))
>> -		m_flags = EXT4_GET_BLOCKS_CREATE;
>> +		m_flags = EXT4_GET_BLOCKS_CREATE | EXT4_GET_BLOCKS_DIO;
>>   	else if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
>> -		m_flags = EXT4_GET_BLOCKS_IO_CREATE_EXT;
>> +		m_flags = EXT4_GET_BLOCKS_IO_CREATE_EXT | EXT4_GET_BLOCKS_DIO;
>>   
>>   	if (flags & IOMAP_ATOMIC)
>>   		ret = ext4_map_blocks_atomic_write(handle, inode, map, m_flags,
>> diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
>> index ada2b9223df5..de6d848f2e37 100644
>> --- a/include/trace/events/ext4.h
>> +++ b/include/trace/events/ext4.h
>> @@ -43,6 +43,7 @@ struct partial_cluster;
>>   	{ EXT4_GET_BLOCKS_CONVERT,		"CONVERT" },		\
>>   	{ EXT4_GET_BLOCKS_METADATA_NOFAIL,	"METADATA_NOFAIL" },	\
>>   	{ EXT4_GET_BLOCKS_NO_NORMALIZE,		"NO_NORMALIZE" },	\
>> +	{ EXT4_GET_BLOCKS_DIO,			"DIO" },		\
>>   	{ EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,	"CONVERT_UNWRITTEN" },  \
>>   	{ EXT4_GET_BLOCKS_ZERO,			"ZERO" },		\
>>   	{ EXT4_GET_BLOCKS_IO_SUBMIT,		"IO_SUBMIT" },		\
>> -- 
>> 2.39.2
>>

