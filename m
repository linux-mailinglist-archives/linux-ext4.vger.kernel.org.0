Return-Path: <linux-ext4+bounces-12445-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EA1CCE175
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Dec 2025 01:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F7A53042FDA
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Dec 2025 00:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C341E0DCB;
	Fri, 19 Dec 2025 00:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="zdKXQsU1"
X-Original-To: linux-ext4@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A143B16D9C2
	for <linux-ext4@vger.kernel.org>; Fri, 19 Dec 2025 00:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766105433; cv=none; b=JaS0XuQnFFUxAX9vGhbOun6In1kgqMU5nPeDuPfAOKx9gg1GmBCpxw+6swa008eVRGMapDrslCRIX2LiG47LaNfg22JeRtezId98pnO05fdyGuefWN3X5TsHajB+H4DxrNVnGs67joN6Ky6oqKdRHvPIN8+vWLfz2BtuIeeWE3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766105433; c=relaxed/simple;
	bh=cVZw9+gQwMSbxCQq4TclTN27XHIUq/NYqe7Mb2qSsPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=J6GTbtOlbykaoUH/nl/4+fF6AW5nvgezeDeyF3ySDPOwkwTv2dAjfs3Q+0Iji+fy3Mj8PZRXgJRQ+jf/zhBGQvgXKiuR1x23HaKJb95zEgfBfDPFB0G76GbzUztskeYOIt3j/SqoTMu6SxfUqLHelxpCoOOGrNyD+FVnar/lrfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=zdKXQsU1; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=j+8J1GztUw+l62UCxkmaSTvXg2GRuki9PXpsZUslRvo=;
	b=zdKXQsU10K377vk8usgjqjLAfyy0nOzhHsRu9odaD0OJrnuEd0oreu0izxbCDYLtAVvO90+A5
	Bu9WAfQd7mozDdxmMBaU00gUH+A9l/Jitk5P9Gu7PwgkMkpGPaK7VDUOGJYrIs6ZuJnWPxD5wCh
	5XkJeHpLnqGsDU2W/0lIE04=
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4dXTQQ1chhz1K98x;
	Fri, 19 Dec 2025 08:47:26 +0800 (CST)
Received: from kwepemf200016.china.huawei.com (unknown [7.202.181.9])
	by mail.maildlp.com (Postfix) with ESMTPS id CD5901800CE;
	Fri, 19 Dec 2025 08:50:27 +0800 (CST)
Received: from [10.108.234.194] (10.108.234.194) by
 kwepemf200016.china.huawei.com (7.202.181.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 19 Dec 2025 08:50:27 +0800
Message-ID: <c83ef56d-9789-4552-ad5c-ffef6bf809ba@huawei.com>
Date: Fri, 19 Dec 2025 08:50:26 +0800
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
 <fcc21a8b-4c53-4755-9747-8e6b83036ecd@huawei.com>
 <20251218233636.GR94594@frogsfrogsfrogs>
Content-Language: en-US
From: "wangjianjian (C)" <wangjianjian3@huawei.com>
In-Reply-To: <20251218233636.GR94594@frogsfrogsfrogs>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf200016.china.huawei.com (7.202.181.9)

On 2025/12/19 7:36, Darrick J. Wong wrote:
> On Thu, Dec 18, 2025 at 09:05:57AM +0800, wangjianjian (C) wrote:
>> On 2025/12/18 0:35, Darrick J. Wong wrote:
>>> On Wed, Dec 17, 2025 at 04:47:08PM +0800, Wang Jianjian wrote:
>>>> For xattr in inode, need add inode offset in this block?
>>>> Also, there is one problem, if we have xattrs both in inode
>>>> and block, current implementation will only return xattr inode fiemap.
>>>> Is this by design?
>>>
>>> I don't think there's much value in reporting the inline xattrs via
>>> FIEMAP because user programs can't directly access that area anyway.
>>> The only reason (AFAICT) for reporting the external xattr block is for
>>> building a map of lost data given a report of localized media failure.
>> yes, I agree with this. however, current behavior is it will always
>> reporting inline xattr first. Do you think we should fix this?
> 
> Nah.  If there are no complaints, then let's leave it alone.
> It's not like the xattr structure has a meaningful byte position index.
sure, let's keep it as is.
> 
>>> (FIEMAP only being useful for debugging and after-the-shatter forensics)
>>>
>>>> Signed-off-by: Wang Jianjian <wangjianjian3@huawei.com>
>>>> ---
>>>>    fs/ext4/extents.c | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
>>>> index 2cf5759ba689..a16bfc75345d 100644
>>>> --- a/fs/ext4/extents.c
>>>> +++ b/fs/ext4/extents.c
>>>> @@ -5043,6 +5043,7 @@ static int ext4_iomap_xattr_fiemap(struct inode *inode, struct iomap *iomap)
>>>>    		if (error)
>>>>    			return error;
>>>>    		physical = (__u64)iloc.bh->b_blocknr << blockbits;
>>>> +		physical += iloc.offset;
>>>
>>> Also it doesn't make sense to add the address of the external block to
>>> the inode offset.
>> IIUC, bh is the buffer head of the inode is in and iloc.offset is its offset
>> of this block.
> 
> Oh silly me.  Yes, that's more correct, though if you really wanted to
> be pedantic, you could also add in the distance from the start of the
> inode core to wherever the xattr data actually is.
I think bh->b_blocknr << blockbits has been the offset from the very 
begin of this FS. But as above said, since nobody cares this, let's keep 
it as is. Thanks for your reply.
>   dfd
> --D
> 
>>>
>>> --D
>>>
>>>>    		offset = EXT4_GOOD_OLD_INODE_SIZE +
>>>>    				EXT4_I(inode)->i_extra_isize;
>>>>    		physical += offset;
>>>> -- 
>>>> 2.34.1
>>>>
>>>>
>> -- 
>> Regards
>>
>>
-- 
Regards


