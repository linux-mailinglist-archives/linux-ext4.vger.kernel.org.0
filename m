Return-Path: <linux-ext4+bounces-8696-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DFFAED2EF
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Jun 2025 05:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA0BF1707E9
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Jun 2025 03:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265D31A2381;
	Mon, 30 Jun 2025 03:32:30 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11D312CDAE;
	Mon, 30 Jun 2025 03:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751254349; cv=none; b=GsHeafdBU5AAjizeNEh9BltLRtd3++sjpLVJD19yeAnCpQLnj/6pT+X5Md85UIl0MgT985D6fj0fhYO+hoTwJ15E5VbV9CqJYaIR1xgSMMhPtgMvUuZiVdHAQH53hfjrj7mt9tVVLxnHSiazs8VbtN/voI1bQI2swjKHZVsg3P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751254349; c=relaxed/simple;
	bh=iqndf9zm7GIRyLdCT5XBDzJBmVTL0GUfiigxCwjbVEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hzGKbKmQrDrztclGh5K4a0ozYRNyehkw3j2hp7K15gtyuWTnjeXW5L+6sQLFgHvNI8Ztc/eDscumNmBuRKaXFezOBHb/0jq9LwEjSn7HKstL4cOC1CCLJuQ3+rtWz3iZSmWpOdYuyVUy/X3zC8sIpxsEMBJnvH9jxvisY6ySr1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bVs7Q31zyz2Cfcw;
	Mon, 30 Jun 2025 11:28:18 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 1DD4E1A016C;
	Mon, 30 Jun 2025 11:32:18 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 30 Jun
 2025 11:32:17 +0800
Message-ID: <0bcfc7c6-003f-4b4d-ac65-e01308a74f3b@huawei.com>
Date: Mon, 30 Jun 2025 11:32:16 +0800
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
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <3p5udvc7fgd73kruz563pi4dmc6vjxvszmnegyym2xhuuauw5j@sjudcmk7idht>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025/6/28 2:15, Jan Kara wrote:
> On Mon 23-06-25 15:32:50, Baokun Li wrote:
>> ac->ac_g_ex.fe_start is only used in ext4_mb_find_by_goal(), but STREAM
>> ALLOC is activated after ext4_mb_find_by_goal() fails, so there's no need
>> to update ac->ac_g_ex.fe_start, remove the unnecessary s_mb_last_start.
>>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> I'd just note that ac->ac_g_ex.fe_start is also used in
> ext4_mb_collect_stats() so this change may impact the statistics gathered
> there. OTOH it is questionable whether we even want to account streaming
> allocation as a goal hit... Anyway, I'm fine with this, I'd just mention it
> in the changelog.
Yes, I missed ext4_mb_collect_stats(). However, instead of explaining
it in the changelog, I think it would be better to move the current
s_bal_goals update to inside or after ext4_mb_find_by_goal().

Then, we could add another variable, such as s_bal_stream_goals, to
represent the hit count for global goals. This kind of statistic would
help us fine-tune the logic for optimizing inode goals and global goals.

What are your thoughts on this?
> Also one nit below but feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
Thanks for your review!
>
>> @@ -2849,7 +2848,6 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
>>   		/* TBD: may be hot point */
>>   		spin_lock(&sbi->s_md_lock);
>>   		ac->ac_g_ex.fe_group = sbi->s_mb_last_group;
>> -		ac->ac_g_ex.fe_start = sbi->s_mb_last_start;
> Maybe reset ac->ac_g_ex.fe_start to 0 instead of leaving it at some random
> value? Just for the sake of defensive programming...
>
> 								Honza

ac->ac_g_ex.fe_start holds the inode goal's start position, not a random
value. It's unused after ext4_mb_find_by_goal() (if s_bal_stream_goals is
added). Thus, I see no need for further modification. We can always re-add
it if future requirements change.


Thanks,
Baokun


