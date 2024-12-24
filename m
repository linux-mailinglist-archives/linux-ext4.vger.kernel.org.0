Return-Path: <linux-ext4+bounces-5841-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 486F39FBD19
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Dec 2024 13:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAA5F161FCD
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Dec 2024 12:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4061B85E2;
	Tue, 24 Dec 2024 12:10:48 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB2E18EFDE;
	Tue, 24 Dec 2024 12:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735042247; cv=none; b=o+gb6nK/IyInW1v4zo7rXciwjaIYBQZfC4XfUchyxP6cDTC2deVP+AoLpEbyW7xBPQHeO2CIa8MuwirFDOZZl5vx+awoUiF/hZow8q/uy1deJxDmHP6YqeSO4I71yNEz3GBRLFEi9ycvERkAfUHdirRZ3kdv/VMbQkHq0b3ZynE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735042247; c=relaxed/simple;
	bh=yuw+JzziFwPgyEuGIaKZp6gpK56ljp/4Xm0B+VhWYL4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ZrVqXa24FyjzLpQ+2DZwhB6qylCcFoWPjFsGTyerp0oYgeF4FEdzHUOC9e98tXTCJFWFWqclkJp3yaGQ1QW45nvI/+zFqxUtgVPUJrsg313KmFPbX8vLWO5Uwup+/kqj5kZv9CUbnXIsAj4H7+jX3HjyBYu6DoJeqsVYdnEu410=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YHYcX39J9z4f3lfp;
	Tue, 24 Dec 2024 20:10:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 3661A1A07BA;
	Tue, 24 Dec 2024 20:10:41 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP1 (Coremail) with SMTP id cCh0CgCHMbPApGpn68d9FQ--.12264S2;
	Tue, 24 Dec 2024 20:10:41 +0800 (CST)
Subject: Re: [PATCH 4/6] ext4: remove unneeded check in get_dx_countlimit
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241219110027.1440876-1-shikemeng@huaweicloud.com>
 <20241219110027.1440876-5-shikemeng@huaweicloud.com>
 <Z2VoSwYw+sFTzMx0@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <e24299f8-d60d-7760-cb33-26598f3dff69@huaweicloud.com>
Date: Tue, 24 Dec 2024 20:10:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Z2VoSwYw+sFTzMx0@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgCHMbPApGpn68d9FQ--.12264S2
X-Coremail-Antispam: 1UD129KBjvdXoWruw43Kw1xAFWrtr48GFy3urg_yoWkJrb_Xa
	4UZrnrZF43Zrn7J3W5K3sxJFsxK3Z5AF45JF9YqrW2vwn0q39Yvw1kJrySyas8Gr47JrZI
	kF95ZF1avFykZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1yE_t
	UUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 12/20/2024 8:51 PM, Ojaswin Mujoo wrote:
> On Thu, Dec 19, 2024 at 07:00:25PM +0800, Kemeng Shi wrote:
>> The "offset" is always non-NULL, remove unneeded NULL check of "offset".
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> 
> Hi Kemeng,
> 
> I know the current callers don't pass NULL but I think we should still
> keep the check around just in case, to avoid NULL dereferences in
> future. I don't think there's any harm in keeping it
> 
Sure, no insistant on this and will drop this in next version.

Thanks,
Kemeng

> Regards,
> ojaswin
> 
>> ---
>>  fs/ext4/namei.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
>> index 33670cebdedc..07a1bb570deb 100644
>> --- a/fs/ext4/namei.c
>> +++ b/fs/ext4/namei.c
>> @@ -434,8 +434,7 @@ static struct dx_countlimit *get_dx_countlimit(struct inode *inode,
>>  	} else
>>  		return NULL;
>>  
>> -	if (offset)
>> -		*offset = count_offset;
>> +	*offset = count_offset;
>>  	return (struct dx_countlimit *)(((void *)dirent) + count_offset);
>>  }
>>  
>> -- 
>> 2.30.0
>>
> 


