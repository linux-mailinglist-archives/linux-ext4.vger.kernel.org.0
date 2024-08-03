Return-Path: <linux-ext4+bounces-3625-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D37489466E4
	for <lists+linux-ext4@lfdr.de>; Sat,  3 Aug 2024 04:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6374C28220B
	for <lists+linux-ext4@lfdr.de>; Sat,  3 Aug 2024 02:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27151A93A;
	Sat,  3 Aug 2024 02:24:09 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAFBD2FA;
	Sat,  3 Aug 2024 02:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722651848; cv=none; b=rhW+m8DWrYrAZCQG1xPliKN8QHvgs4wvxrNH6EFPOdKN2ExVRlGofhbZ2en5vNhq9x1PlmEupU7zRin/83xquOzTGUAowqbF9A9W1QfA1DdAkGXNxL1cxyNaydNbzLhwN1EstUL/FcPEe8wiTKm1H6aB4PX4xoZvpX9c1yrfCz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722651848; c=relaxed/simple;
	bh=Lb+Stv7ELTU7gvhoeN6BV2b9qg1T+FYABxu+wg+mp3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SuSaiqLXtGL5WyAou5jLiN6qm7ozPdAr8Zs7gsaXYTrrK7FgXjHnkzGMOzBe07v6C8gyfNP/uUxfT2kooaXPMXUxMnwNtnYg5KqmEpoNA7aqjwNaFKSF2cHycQsvVK3BUq2AA+yOZllunavN+40qiBOI0oD2i40lToZ2IWSeDEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WbRMs04srz4f3jZQ;
	Sat,  3 Aug 2024 10:23:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id CA02F1A08FC;
	Sat,  3 Aug 2024 10:24:01 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP4 (Coremail) with SMTP id gCh0CgB3n4W9lK1m0kl2Ag--.36362S3;
	Sat, 03 Aug 2024 10:24:01 +0800 (CST)
Message-ID: <268fea5b-39d1-449f-90ea-85ea00866eb0@huaweicloud.com>
Date: Sat, 3 Aug 2024 10:23:57 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/20] ext4: get rid of ppath in
 ext4_force_split_extent_at()
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, Baokun Li <libaokun1@huawei.com>,
 Baokun Li <libaokun@huaweicloud.com>
References: <20240710040654.1714672-1-libaokun@huaweicloud.com>
 <20240710040654.1714672-14-libaokun@huaweicloud.com>
 <Zq07D/rySkSKxsw3@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Content-Language: en-US
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <Zq07D/rySkSKxsw3@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgB3n4W9lK1m0kl2Ag--.36362S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Kry3ur1xCrWxtry8Aw43Wrg_yoW8CrWUpr
	1fC3W3Cr10vw129FyaqF1Utr13Kw4rGF13Gryaqr1ruas8Zr1FgF1xt3WFkF95JFWxXry2
	vF40qF1fG3W3A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY
	04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQAEBWasmH08QwAAsQ

Hi Ojaswin,

On 2024/8/3 4:01, Ojaswin Mujoo wrote:
> On Wed, Jul 10, 2024 at 12:06:47PM +0800, libaokun@huaweicloud.com wrote:
>> From: Baokun Li <libaokun1@huawei.com>
>>
>> The use of path and ppath is now very confusing, so to make the code more
>> readable, pass path between functions uniformly, and get rid of ppath.
>>
>> To get rid of the ppath in ext4_force_split_extent_at(), the following is
>> done here:
>>
>>   * The ext4_find_extent() can update the extent path so it doesn't have to
>>     allocate and free path repeatedly, thus reducing the consumption of
>>     memory allocation and freeing in ext4_swap_extents().
>>
>> No functional changes.
> Looks good Baokun, feel free to add:
>
> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>
> One small comment below..
Thanks for the review!
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> ---
>>   fs/ext4/extents.c | 117 ++++++++++++++++++++++++----------------------
>>   1 file changed, 60 insertions(+), 57 deletions(-)
>>
>> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
>> index c86b1bb7720f..0bd068ed324f 100644
>> --- a/fs/ext4/extents.c
>> +++ b/fs/ext4/extents.c
> .. snip ..
>
>> @@ -5707,25 +5701,21 @@ ext4_swap_extents(handle_t *handle, struct inode *inode1,
> In ext4_swap_extents, maybe we should keep the refactoring to a separate
> patch than the changes needed to get rid of ppath in
> ext4_force_split_extent_at(), the commits would look a bit cleaner and
> easier to read that way. I don't feel too strongly about it tho and
> I'll let you take a call.
>
> Regards,
> ojaswin
Totally agree! It does seem a bit unclear now to put the refactoring
of ext4_swap_extents() into a modification to get rid of the ppath.
In the next version I will put the logic for refactoring
ext4_swap_extents() into a separate patch.

Cheers,
Baokun


