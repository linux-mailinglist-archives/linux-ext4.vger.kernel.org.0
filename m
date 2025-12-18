Return-Path: <linux-ext4+bounces-12393-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A28CC9F23
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Dec 2025 02:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF30230275D4
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Dec 2025 01:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47201DF75B;
	Thu, 18 Dec 2025 01:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Gp4kbE1P"
X-Original-To: linux-ext4@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236093A1E87
	for <linux-ext4@vger.kernel.org>; Thu, 18 Dec 2025 01:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766019965; cv=none; b=puaTh6nTeVvUqZAsNgiiLHiP0lvLZP/CcqrHs+KgryLZ0tf37uH6LUCHlEGCnovkKDUiB3kW08b5CfIByS3Ygm1GlokiOX2PU4Sld1lYynfQUjb99mcQL7mAAymqfsebtpYVB+cmcwQ18naX/0/lN3Zvq4Clo+oXwIgr4Qi/IWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766019965; c=relaxed/simple;
	bh=fGgE/Z+Jh8+6MyYiMoLwTtOaRJRey7+o44ZVdkpobrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SVS+65xCZb6n8kym+2w9UtEYgnjWEsQs9BDcx1Xs5x4MSGHgG9JY6Z36KS/N98HEhmrwRwIR6HbPRwmTnR7Q+k3tJ2uZwE6uK1HaKgIXhltWJpv4+tg+Jdci9FuyTzECvgv17dBHxMzUsYJXMQd1WxFlBlUZ9nz7TqzICJJ1lts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Gp4kbE1P; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=uTLWYm/cxvlOQ3EE61ghk609/PL4B3ntTZt9oe41ork=;
	b=Gp4kbE1PYq8RxB4ILcCF4pd1qcK3p2Kfhe0rF7xP/OysnMYcdcqpsoziFliivcb4z71HOW6Ea
	uAbUkt/+Yn4kwHKJgvC02KyMrcy1d1rTbUhOP6P7LbgEdPVjASW9PH+O5GUEf0jPz2A3voeszf7
	QvdFwkDemItPV7RQqzt9/iU=
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4dWsqj3RvJz1T4J5;
	Thu, 18 Dec 2025 09:03:45 +0800 (CST)
Received: from kwepemf200016.china.huawei.com (unknown [7.202.181.9])
	by mail.maildlp.com (Postfix) with ESMTPS id 870DB140203;
	Thu, 18 Dec 2025 09:05:58 +0800 (CST)
Received: from [10.108.234.194] (10.108.234.194) by
 kwepemf200016.china.huawei.com (7.202.181.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 18 Dec 2025 09:05:57 +0800
Message-ID: <fcc21a8b-4c53-4755-9747-8e6b83036ecd@huawei.com>
Date: Thu, 18 Dec 2025 09:05:57 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4,fiemap: Add inode offset for xattr fiemap
To: "Darrick J. Wong" <djwong@kernel.org>
CC: <tytso@mit.edu>, <linux-ext4@vger.kernel.org>, <wangjianjian0@foxmail.com>
References: <20251217084708.494396-1-wangjianjian3@huawei.com>
 <20251217163521.GO94594@frogsfrogsfrogs>
Content-Language: en-US
From: "wangjianjian (C)" <wangjianjian3@huawei.com>
In-Reply-To: <20251217163521.GO94594@frogsfrogsfrogs>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf200016.china.huawei.com (7.202.181.9)

On 2025/12/18 0:35, Darrick J. Wong wrote:
> On Wed, Dec 17, 2025 at 04:47:08PM +0800, Wang Jianjian wrote:
>> For xattr in inode, need add inode offset in this block?
>> Also, there is one problem, if we have xattrs both in inode
>> and block, current implementation will only return xattr inode fiemap.
>> Is this by design?
> 
> I don't think there's much value in reporting the inline xattrs via
> FIEMAP because user programs can't directly access that area anyway.
> The only reason (AFAICT) for reporting the external xattr block is for
> building a map of lost data given a report of localized media failure.
yes, I agree with this. however, current behavior is it will always 
reporting inline xattr first. Do you think we should fix this?
> 
> (FIEMAP only being useful for debugging and after-the-shatter forensics)
> 
>> Signed-off-by: Wang Jianjian <wangjianjian3@huawei.com>
>> ---
>>   fs/ext4/extents.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
>> index 2cf5759ba689..a16bfc75345d 100644
>> --- a/fs/ext4/extents.c
>> +++ b/fs/ext4/extents.c
>> @@ -5043,6 +5043,7 @@ static int ext4_iomap_xattr_fiemap(struct inode *inode, struct iomap *iomap)
>>   		if (error)
>>   			return error;
>>   		physical = (__u64)iloc.bh->b_blocknr << blockbits;
>> +		physical += iloc.offset;
> 
> Also it doesn't make sense to add the address of the external block to
> the inode offset.
IIUC, bh is the buffer head of the inode is in and iloc.offset is its 
offset of this block.
> 
> --D
> 
>>   		offset = EXT4_GOOD_OLD_INODE_SIZE +
>>   				EXT4_I(inode)->i_extra_isize;
>>   		physical += offset;
>> -- 
>> 2.34.1
>>
>>
-- 
Regards


