Return-Path: <linux-ext4+bounces-4359-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB2098837B
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Sep 2024 13:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 390CC1C22722
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Sep 2024 11:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5FF18A93F;
	Fri, 27 Sep 2024 11:51:30 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DB31891BB;
	Fri, 27 Sep 2024 11:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727437890; cv=none; b=pqMPCbTAq0XNNtFwEtbo+ngBVOGyKfn03+OomiJFffznFs4bzNQHStSKkqIOlKAZCy8RFntmnblBd/BJlzraOHU80iglmDyk0fjmzDT8k3Io/tcbWiUqKf+YkIl0SKJAgGXQGndjb2PZX67aAo6Bm95przJbufBmhql5hj1s2DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727437890; c=relaxed/simple;
	bh=p0EpKaiQEk2mfuQTju8wuPxLLsmdbZ6WYKGoBITiEM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UfT4UYcHXh1tNCN7tzTjG6gjSJcYVajwT0IqxlaxB++I635np4NKNrw50wUc9JOH6ch8HIabX+o+L10gS6Yuegome5zVHZZHLnloezEOZ+1rlzs4M57JeqLEC+06TOKdAgzrfY4cxDSGlybwPUm+I4+ijkqExzL2p/tsaYnFztw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XFTLz3kTBz4f3lDc;
	Fri, 27 Sep 2024 19:51:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8AA011A092F;
	Fri, 27 Sep 2024 19:51:24 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP4 (Coremail) with SMTP id gCh0CgDH+8c7nPZmBKv6CQ--.23275S3;
	Fri, 27 Sep 2024 19:51:24 +0800 (CST)
Message-ID: <6203edb1-3d23-478c-9522-53dd9400caec@huaweicloud.com>
Date: Fri, 27 Sep 2024 19:51:23 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: fix off by one issue in alloc_flex_gd()
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 Baokun Li <libaokun1@huawei.com>,
 Wesley Hershberger <wesley.hershberger@canonical.com>,
 =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
 Eric Sandeen <sandeen@redhat.com>, stable@vger.kernel.org,
 Yang Erkun <yangerkun@huawei.com>
References: <20240927063620.2630898-1-libaokun@huaweicloud.com>
 <20240927105643.h4b4zunjivv4nkzu@quack3>
Content-Language: en-US
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <20240927105643.h4b4zunjivv4nkzu@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDH+8c7nPZmBKv6CQ--.23275S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXrW3GFW5Jw13Jw45uFykXwb_yoW5KFy7pF
	9xKa4xCryYqryUCr47J34qgF18K34kJr17XrWxXr18XFy7ZFnxGr1IgFy8CFyjkF93Cr13
	JFs0vF1qyrnrXaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUOB
	MKDUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgATBWb2bRwQYAAAsF

On 2024/9/27 18:56, Jan Kara wrote:
> On Fri 27-09-24 14:36:20, libaokun@huaweicloud.com wrote:
>> From: Baokun Li <libaokun1@huawei.com>
>>
>> Wesley reported an issue:
>>
>> ==================================================================
>> EXT4-fs (dm-5): resizing filesystem from 7168 to 786432 blocks
>> ------------[ cut here ]------------
>> kernel BUG at fs/ext4/resize.c:324!
>> CPU: 9 UID: 0 PID: 3576 Comm: resize2fs Not tainted 6.11.0+ #27
>> RIP: 0010:ext4_resize_fs+0x1212/0x12d0
>> Call Trace:
>>   __ext4_ioctl+0x4e0/0x1800
>>   ext4_ioctl+0x12/0x20
>>   __x64_sys_ioctl+0x99/0xd0
>>   x64_sys_call+0x1206/0x20d0
>>   do_syscall_64+0x72/0x110
>>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> ==================================================================
>>
>> While reviewing the patch, Honza found that when adjusting resize_bg in
>> alloc_flex_gd(), it was possible for flex_gd->resize_bg to be bigger than
>> flexbg_size.
>>
>> The reproduction of the problem requires the following:
>>
>>   o_group = flexbg_size * 2 * n;
>>   o_size = (o_group + 1) * group_size;
>>   n_group: [o_group + flexbg_size, o_group + flexbg_size * 2)
>>   o_size = (n_group + 1) * group_size;
>>
>> Take n=0,flexbg_size=16 as an example:
>>
>>                last:15
>> |o---------------|--------------n-|
>> o_group:0    resize to      n_group:30
>>
>> The corresponding reproducer is:
>>
>> img=test.img
>> truncate -s 600M $img
>> mkfs.ext4 -F $img -b 1024 -G 16 8M
>> dev=`losetup -f --show $img`
>> mkdir -p /tmp/test
>> mount $dev /tmp/test
>> resize2fs $dev 248M
>>
>> Delete the problematic plus 1 to fix the issue, and add a WARN_ON_ONCE()
>> to prevent the issue from happening again.
> I don't think you are adding WARN_ON_ONCE() :). Otherwise feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>
> 								Honza

Oh no, I forgot to add the added modifications! 😅

Thank you for your review!

I will send out v2. soon.


Thanks,
Baokun
>> Reported-by: Wesley Hershberger <wesley.hershberger@canonical.com>
>> Closes: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2081231
>> Reported-by: Stéphane Graber <stgraber@stgraber.org>
>> Closes: https://lore.kernel.org/all/20240925143325.518508-1-aleksandr.mikhalitsyn@canonical.com/
>> Tested-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
>> Tested-by: Eric Sandeen <sandeen@redhat.com>
>> Fixes: 665d3e0af4d3 ("ext4: reduce unnecessary memory allocation in alloc_flex_gd()")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> ---
>>   fs/ext4/resize.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
>> index e04eb08b9060..397970121d43 100644
>> --- a/fs/ext4/resize.c
>> +++ b/fs/ext4/resize.c
>> @@ -253,9 +253,9 @@ static struct ext4_new_flex_group_data *alloc_flex_gd(unsigned int flexbg_size,
>>   	/* Avoid allocating large 'groups' array if not needed */
>>   	last_group = o_group | (flex_gd->resize_bg - 1);
>>   	if (n_group <= last_group)
>> -		flex_gd->resize_bg = 1 << fls(n_group - o_group + 1);
>> +		flex_gd->resize_bg = 1 << fls(n_group - o_group);
>>   	else if (n_group - last_group < flex_gd->resize_bg)
>> -		flex_gd->resize_bg = 1 << max(fls(last_group - o_group + 1),
>> +		flex_gd->resize_bg = 1 << max(fls(last_group - o_group),
>>   					      fls(n_group - last_group));
>>   
>>   	flex_gd->groups = kmalloc_array(flex_gd->resize_bg,
>> -- 
>> 2.46.0
>>
-- 
With Best Regards,
Baokun Li


