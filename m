Return-Path: <linux-ext4+bounces-8704-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08962AED62F
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Jun 2025 09:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C958B167FFE
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Jun 2025 07:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828522397B0;
	Mon, 30 Jun 2025 07:53:06 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0B4238D49;
	Mon, 30 Jun 2025 07:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751269986; cv=none; b=Nkr/ymAjXtEdwTaEeWx//clgzZxXw9kddWFX4s5OKg5tP4YNrwdgJdvj+l1QNhrUsMvJ8a7Hwu0/vU7dsv20LXWFX/Fq/ZLyrPWiMn3wFSvOD55aqO9TRvsa/bXwHiCYv884iU1IpWsjJ8oMCXau4dCaIDZjAKhOMwiWoiXXp+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751269986; c=relaxed/simple;
	bh=jLG1g68Fzf6UnSPXgYxIdIwcEV5BFxcNl48BpGZSf4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZsCSEDQwx/3BMR9BLGq7LKRp2/pr2znBQgYAd8yl8CyDNwq89W3oEVL65UzowxyAYYEOSdoXx73970CW1yXpmu6R8pmpi9wVe7DBddP91SkCf2Tu8ULHkjs93WpFjQWJfAIaD+rbsOehRazdDjRf0XJlZjZYVF4kJSUjcDa9TWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bVyzX3qgHztSdd;
	Mon, 30 Jun 2025 15:51:52 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id B9FB11402C8;
	Mon, 30 Jun 2025 15:53:00 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 30 Jun
 2025 15:52:59 +0800
Message-ID: <c12d955b-d1d2-4e54-b972-8455d20ae637@huawei.com>
Date: Mon, 30 Jun 2025 15:52:58 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/16] ext4: remove unnecessary s_mb_last_start
To: Jan Kara <jack@suse.cz>
CC: <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<ojaswin@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, Baokun Li
	<libaokun1@huawei.com>
References: <20250623073304.3275702-1-libaokun1@huawei.com>
 <20250623073304.3275702-3-libaokun1@huawei.com>
 <3p5udvc7fgd73kruz563pi4dmc6vjxvszmnegyym2xhuuauw5j@sjudcmk7idht>
 <0bcfc7c6-003f-4b4d-ac65-e01308a74f3b@huawei.com>
 <mztj3kc4slq3j6gxfk77omt4tdphg55jophea2j2dw5vj5hixq@ppj5lfxz2svk>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <mztj3kc4slq3j6gxfk77omt4tdphg55jophea2j2dw5vj5hixq@ppj5lfxz2svk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025/6/30 15:31, Jan Kara wrote:
> On Mon 30-06-25 11:32:16, Baokun Li wrote:
>> On 2025/6/28 2:15, Jan Kara wrote:
>>> On Mon 23-06-25 15:32:50, Baokun Li wrote:
>>>> ac->ac_g_ex.fe_start is only used in ext4_mb_find_by_goal(), but STREAM
>>>> ALLOC is activated after ext4_mb_find_by_goal() fails, so there's no need
>>>> to update ac->ac_g_ex.fe_start, remove the unnecessary s_mb_last_start.
>>>>
>>>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>>> I'd just note that ac->ac_g_ex.fe_start is also used in
>>> ext4_mb_collect_stats() so this change may impact the statistics gathered
>>> there. OTOH it is questionable whether we even want to account streaming
>>> allocation as a goal hit... Anyway, I'm fine with this, I'd just mention it
>>> in the changelog.
>> Yes, I missed ext4_mb_collect_stats(). However, instead of explaining
>> it in the changelog, I think it would be better to move the current
>> s_bal_goals update to inside or after ext4_mb_find_by_goal().
>>
>> Then, we could add another variable, such as s_bal_stream_goals, to
>> represent the hit count for global goals. This kind of statistic would
>> help us fine-tune the logic for optimizing inode goals and global goals.
>>
>> What are your thoughts on this?
> Sure that sounds good to me.

Ok, I will add a patch to implement that logic in the next version.

>
>>>> @@ -2849,7 +2848,6 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
>>>>    		/* TBD: may be hot point */
>>>>    		spin_lock(&sbi->s_md_lock);
>>>>    		ac->ac_g_ex.fe_group = sbi->s_mb_last_group;
>>>> -		ac->ac_g_ex.fe_start = sbi->s_mb_last_start;
>>> Maybe reset ac->ac_g_ex.fe_start to 0 instead of leaving it at some random
>>> value? Just for the sake of defensive programming...
>>>
>> ac->ac_g_ex.fe_start holds the inode goal's start position, not a random
>> value. It's unused after ext4_mb_find_by_goal() (if s_bal_stream_goals is
>> added). Thus, I see no need for further modification. We can always re-add
>> it if future requirements change.
> Yeah, I was imprecise. It is not a random value. But it is not an offset in
> the group we are now setting. Therefore I'd still prefer to reset fe_start
> to 0 (or some invalid value like -1 to catch unexpected use).
>
> 								Honza

When ext4_mb_regular_allocator() fails, it might retry and get called
again. In this scenario, we can't reliably determine if ac_g_ex has
already been modified. Therefore, it might be more appropriate to set
ac_g_ex.fe_start to -1 after ext4_mb_find_by_goal() fails. We can then
skip ext4_mb_find_by_goal() when ac_g_ex.fe_start < 0.


Cheers,
Baokun


