Return-Path: <linux-ext4+bounces-4358-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C44988374
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Sep 2024 13:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CA491C2292A
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Sep 2024 11:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85E6189532;
	Fri, 27 Sep 2024 11:47:18 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBF0134B6;
	Fri, 27 Sep 2024 11:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727437638; cv=none; b=flMOyLy9fnpgw6V0irZ3Lg6v/9MI4tc8B4jNduLY4aUq11IsoR0YhNCdLQoXwDq4XhgNeCI1QRJNflPoMvJo4LR5a1k1sHk7/3QUHcfFJBZjVtrKI91/d48MZ2D/pepWCrort7wgGs6UsGQePHZn996f/IcFOS5u5uzDXKc6XdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727437638; c=relaxed/simple;
	bh=j92rsiIbEWMMELRMTDH6YAThdZ90ZGygnnhsKlETf6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NWU8Oc/Tx00KVe2bkIFMvPAsZLcCcfnL3UtAeNddZRIG2zOPsVcdIPNAhHdoBYHXW6r4Sozo2/z5Pfk8VoM19O42ed0Lx/NYwNw/nIx1lxLs8Jqo2oPV1B7a4nonZntemDRLm6ZYTa2F3oEB1M+iJPSHLjvi9NMU5iLIZJvZKs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XFTG573wdz4f3lVd;
	Fri, 27 Sep 2024 19:46:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 071EC1A07B6;
	Fri, 27 Sep 2024 19:47:11 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP4 (Coremail) with SMTP id gCh0CgDHR8Q4m_ZmomD6CQ--.44127S3;
	Fri, 27 Sep 2024 19:47:08 +0800 (CST)
Message-ID: <1851168d-3a64-45f2-9711-02f12e98ecca@huaweicloud.com>
Date: Fri, 27 Sep 2024 19:47:04 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: fix off by one issue in alloc_flex_gd()
To: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 jack@suse.cz, linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
 yangerkun@huawei.com, Baokun Li <libaokun1@huawei.com>,
 Wesley Hershberger <wesley.hershberger@canonical.com>,
 =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>,
 Eric Sandeen <sandeen@redhat.com>, stable@vger.kernel.org,
 Yang Erkun <yangerkun@huawei.com>
References: <20240927063620.2630898-1-libaokun@huaweicloud.com>
 <CAEivzxej-DiXpkcQeYrVVPXbXXnCf=4d3EWyhw8euwBjuB8S9w@mail.gmail.com>
Content-Language: en-US
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <CAEivzxej-DiXpkcQeYrVVPXbXXnCf=4d3EWyhw8euwBjuB8S9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHR8Q4m_ZmomD6CQ--.44127S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXrW3GFW5Jw13Jw4rGw43trb_yoW5Kr1UpF
	93ta4xGryYqryUCr4xJ34qgF18K34kJr17XrWxXr18XFy7ZF13Gr1xKry8CFyDCF93Cr15
	JFs0vF1qyrnrXaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQATBWb1GwNKSAADsd

On 2024/9/27 16:22, Aleksandr Mikhalitsyn wrote:
> On Fri, Sep 27, 2024 at 8:39 AM <libaokun@huaweicloud.com> wrote:
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
>>
>> Reported-by: Wesley Hershberger <wesley.hershberger@canonical.com>
>> Closes: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2081231
>> Reported-by: Stéphane Graber <stgraber@stgraber.org>
>> Closes: https://lore.kernel.org/all/20240925143325.518508-1-aleksandr.mikhalitsyn@canonical.com/
>> Tested-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
>> Tested-by: Eric Sandeen <sandeen@redhat.com>
>> Fixes: 665d3e0af4d3 ("ext4: reduce unnecessary memory allocation in alloc_flex_gd()")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Thanks, Baokun!
>
> JFYI, I'm on the way to submit a test to xfstests suite.
>
> Kind regards,
> Alex
Okay. Thanks for doing this.

Cheers,
Baokun
>> ---
>>   fs/ext4/resize.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
>> index e04eb08b9060..397970121d43 100644
>> --- a/fs/ext4/resize.c
>> +++ b/fs/ext4/resize.c
>> @@ -253,9 +253,9 @@ static struct ext4_new_flex_group_data *alloc_flex_gd(unsigned int flexbg_size,
>>          /* Avoid allocating large 'groups' array if not needed */
>>          last_group = o_group | (flex_gd->resize_bg - 1);
>>          if (n_group <= last_group)
>> -               flex_gd->resize_bg = 1 << fls(n_group - o_group + 1);
>> +               flex_gd->resize_bg = 1 << fls(n_group - o_group);
>>          else if (n_group - last_group < flex_gd->resize_bg)
>> -               flex_gd->resize_bg = 1 << max(fls(last_group - o_group + 1),
>> +               flex_gd->resize_bg = 1 << max(fls(last_group - o_group),
>>                                                fls(n_group - last_group));
>>
>>          flex_gd->groups = kmalloc_array(flex_gd->resize_bg,
>> --
>> 2.46.0
>>

-- 
With Best Regards,
Baokun Li


