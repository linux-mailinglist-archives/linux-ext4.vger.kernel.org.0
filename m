Return-Path: <linux-ext4+bounces-3612-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 265FF945E55
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Aug 2024 15:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBBA91F2241F
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Aug 2024 13:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6630F1E3CDC;
	Fri,  2 Aug 2024 13:07:35 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C8817547;
	Fri,  2 Aug 2024 13:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722604055; cv=none; b=ixHs5rMJm82gNOu0d41GNHVHIqYm7hZwWW907AVUhkOSH/Rn4P1Uj//cPKxB9BCe9Hq2Pz0+zq++yhQefRflC6y0ejx5UkJUCmHn58q6SwOTwb0gXZQYDrZVLQIj2geyYzhq2bwgcgkfVgh3sqW2WA15Rf3eyKxqbNHpf/26WhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722604055; c=relaxed/simple;
	bh=ng0IcaXPaHLvdetCJAhGczVFHBRtogBlyNPpK2y3Yj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lLIVjpTOT7GDgdn3hL+l7s3SeJ38aWQkd47SRmPj+PWT9z5bkgNwJXiSDj7YwCegpmPeeufuSBn6EayvXUy5GXG+N3TEDMxpIs8Cttq0O+xXntvtG2tmGlaSs9Q7+ADDG0u7IVBFsN57yfXdprqgmnnbJFqyGc2ft1MkwPf9Ays=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wb5hk39xyz4f3jkq;
	Fri,  2 Aug 2024 21:07:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 38A1A1A018D;
	Fri,  2 Aug 2024 21:07:27 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP4 (Coremail) with SMTP id gCh0CgCHr4UL2qxm7ChBAg--.9954S3;
	Fri, 02 Aug 2024 21:07:27 +0800 (CST)
Message-ID: <182c4b0b-6c69-4119-90ca-4e52bcad0409@huaweicloud.com>
Date: Fri, 2 Aug 2024 21:07:23 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/20] ext4: get rid of ppath in
 ext4_ext_create_new_leaf()
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, Baokun Li <libaokun1@huawei.com>,
 Baokun Li <libaokun@huaweicloud.com>
References: <20240710040654.1714672-1-libaokun@huaweicloud.com>
 <20240710040654.1714672-11-libaokun@huaweicloud.com>
 <ZqyL6rmtwl6N4MWR@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Content-Language: en-US
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <ZqyL6rmtwl6N4MWR@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHr4UL2qxm7ChBAg--.9954S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Kry3ur1xCrWrCry5Gry5XFb_yoW8Ar4Dpa
	4Syw4Duw1Dta1j9FZrtF45tFyFva1fGa4UGFW5Wry8uasFqF1rZFyfKFWj9rs8XFs7GFy2
	vrWxWa1ftr12y3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQADBWasmH0ZsQAAsA

On 2024/8/2 15:34, Ojaswin Mujoo wrote:
> On Wed, Jul 10, 2024 at 12:06:44PM +0800, libaokun@huaweicloud.com wrote:
>> From: Baokun Li <libaokun1@huawei.com>
>>
>> The use of path and ppath is now very confusing, so to make the code more
>> readable, pass path between functions uniformly, and get rid of ppath.
>>
>> To get rid of the ppath in ext4_ext_create_new_leaf(), the following is
>> done here:
>>
>>   * Free the extents path when an error is encountered.
>>   * Its caller needs to update ppath if it uses ppath.
>>
>> No functional changes.
>>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Hi Baokun,
Hey Ojaswin,
> The changes look good to me, feel free to add:
>
> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Thank you very much for your review!
>
> That being said, IIUC i think this patchset also fixes a potential UAF
> bug. Below is a sample trace with dummy values:
>
> ext4_ext_insert_extent
>    path = *ppath = 2000
>    ext4_ext_create_new_leaf(ppath)
>      path = *ppath = 2000
>      ext4_find_extent(path = 2000)
>        if (depth > path[0].p_maxdepth)
>              kfree(path = 2000);
>              path = NULL;
>        path = kcalloc() = 3000
>        ...
>        return path;
>    path = 3000
>    *ppath = 3000;
>    return;
> /* here path is still 2000 *, UAF! */
> eh = path[depth].p_hdr
>
> I'm not completely sure if we can hit (depth > path[0].p_maxdepth) in the
> above codepath but I think the flow is still a bit fragile. Maybe this
> should be fixed in a separate patch first. What do you think?
>
> Regards,
> ojaswin
Nice catch!

This is indeed a potential UAF issue, and while it seems hard to
trigger (depth > path[0].p_maxdepth), it does deserve a separate
patch, and I'll be adding a separate quick fix for this in the next version.

Regards,
Baokun


