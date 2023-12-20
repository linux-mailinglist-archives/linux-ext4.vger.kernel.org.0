Return-Path: <linux-ext4+bounces-509-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED46C81A00B
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Dec 2023 14:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B14A1C228FA
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Dec 2023 13:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C237364B5;
	Wed, 20 Dec 2023 13:43:58 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB7538DDF;
	Wed, 20 Dec 2023 13:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SwFBn673FzsSWt;
	Wed, 20 Dec 2023 21:43:29 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 149001402DE;
	Wed, 20 Dec 2023 21:43:47 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Dec 2023 21:43:46 +0800
Message-ID: <253f741f-7ec8-1adb-1efe-a93d33ec6e12@huawei.com>
Date: Wed, 20 Dec 2023 21:43:46 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 4/4] ext4: avoid dividing by 0 in
 mb_update_avg_fragment_size() when block bitmap corrupt
Content-Language: en-US
To: Jan Kara <jack@suse.cz>
CC: <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <yukuai3@huawei.com>,
	<stable@vger.kernel.org>, Baokun Li <libaokun1@huawei.com>
References: <20231218141814.1477338-1-libaokun1@huawei.com>
 <20231218141814.1477338-5-libaokun1@huawei.com>
 <20231218144342.2we3j2dtyedulfga@quack3>
 <20231218150905.llu5tgjgen4nxthq@quack3>
 <9db31834-cbd3-c60a-3048-ef57143d8e55@huawei.com>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <9db31834-cbd3-c60a-3048-ef57143d8e55@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500021.china.huawei.com (7.185.36.21)

On 2023/12/19 16:02, Baokun Li wrote:
> On 2023/12/18 23:09, Jan Kara wrote:
>> On Mon 18-12-23 15:43:42, Jan Kara wrote:
>>> On Mon 18-12-23 22:18:14, Baokun Li wrote:
>>>> When bb_free is not 0 but bb_fragments is 0, return directly to avoid
>>>> system crash due to division by zero.
>>> How could this possibly happen? bb_fragments is the number of free 
>>> space
>>> extents and bb_free is the number of free blocks. No free space 
>>> extents =>
>>> no free blocks seems pretty obvious? You can see the logic in
>>> ext4_mb_generate_buddy()...
>> Oh, I see. This is probably about "bitmap corrupted case". But still 
>> both
>> allocation and freeing of blocks shouldn't operate on bitmaps marked as
>> corrupted so this should not happen?
>>
>>                                 Honza
> Yes, we should make sure that we don't allocate or free blocks in
> groups where the block bitmap has been marked as corrupt, but
> there are still some issues here:
>
> 1. When a block bitmap is found to be corrupted, ext4_grp_locked_error()
> is always called first, and only after that the block bitmap of the group
> is marked as corrupted. In ext4_grp_locked_error(), the group may
> be unlocked, and then other processes may be able to access the
> corrupted bitmap. In this case, we can just put the marking of
> corruption before ext4_grp_locked_error().
>
> 2. ext4_free_blocks() finds a corrupt bitmap can just return and do
> nothing, because there is no problem with not freeing an exception
> block. But mb_mark_used() has no logic for determining if a block
> bitmap is corrupt, and its caller has no error handling logic, so
> mb_mark_used() needs its caller to make sure that it doesn't allocate
> blocks in a group with a corrupted block bitmap (which is why it
> added the judgment in patch 2). However, it is possible to unlock group
> between determining whether the group is corrupt and actually calling
> mb_mark_used() to use those blocks. For example, when calling
> mb_mark_used() in ext4_mb_try_best_found(), we are determining
> whether the group's block bitmap is corrupted or not in the previous
> ext4_mb_good_group(), but we are not determining it again when using
> the blocks in ext4_mb_try_best_found(), at which point we may be
> modifying the corrupted block bitmap.
>
> 3. Determine if a block bitmap is corrupted outside of a group lock
> in ext4_mb_find_by_goal().
>
> 4. In ext4_mb_check_limits(), it may be possible to use the ac_b_ex
> found in group 0 while holding a lock in group 1.

I'm very sorry that the fourth point was wrong, I read "||" as "&&" in
ext4_mb_check_limits() ：

  if (finish_group || ac->ac_found > sbi->s_mb_min_to_scan)

>
> In addition to the above, there may be some corner cases that cause
> inconsistencies, so here we determine if bb_fragments is 0 to avoid a
> crash due to division by zero. Perhaps we could just replace
> grp->bb_free == 0 with grp->bb_fragments == 0, which wouldn't look
> so strange.

Thanks!
-- 
With Best Regards,
Baokun Li
.

