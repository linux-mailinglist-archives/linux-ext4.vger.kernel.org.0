Return-Path: <linux-ext4+bounces-680-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F32518240DC
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Jan 2024 12:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 254981C21221
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Jan 2024 11:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BEB2135C;
	Thu,  4 Jan 2024 11:43:07 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059EB21344;
	Thu,  4 Jan 2024 11:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4T5Pp26WbpzWlj5;
	Thu,  4 Jan 2024 19:42:18 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 314DD18001C;
	Thu,  4 Jan 2024 19:43:01 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jan 2024 19:43:00 +0800
Message-ID: <ec2bb12d-2b35-25c8-740b-30a80dd56d1f@huawei.com>
Date: Thu, 4 Jan 2024 19:43:00 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2 4/8] ext4: avoid bb_free and bb_fragments inconsistency
 in mb_free_blocks()
Content-Language: en-US
To: Jan Kara <jack@suse.cz>
CC: <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <yukuai3@huawei.com>,
	<stable@vger.kernel.org>, Baokun Li <libaokun1@huawei.com>
References: <20231221150558.2740823-1-libaokun1@huawei.com>
 <20231221150558.2740823-5-libaokun1@huawei.com>
 <20240104104255.eewvmywxyqtfwzug@quack3>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20240104104255.eewvmywxyqtfwzug@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500021.china.huawei.com (7.185.36.21)

On 2024/1/4 18:42, Jan Kara wrote:
> On Thu 21-12-23 23:05:54, Baokun Li wrote:
>> After updating bb_free in mb_free_blocks, it is possible to return without
>> updating bb_fragments because the block being freed is found to have
>> already been freed, which leads to inconsistency between bb_free and
>> bb_fragments.
>>
>> Since the group may be unlocked in ext4_grp_locked_error(), this can lead
>> to problems such as dividing by zero when calculating the average fragment
>> length. Hence move the update of bb_free to after the block double-free
>> check guarantees that the corresponding statistics are updated only after
>> the core block bitmap is modified.
>>
>> Fixes: eabe0444df90 ("ext4: speed-up releasing blocks on commit")
>> CC: stable@vger.kernel.org # 3.10
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Just one nit below but regardless of that feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>
>> @@ -1941,10 +1936,16 @@ static void mb_free_blocks(struct inode *inode, struct ext4_buddy *e4b,
>>   				EXT4_GROUP_INFO_BBITMAP_CORRUPT);
>>   		} else {
>>   			mb_regenerate_buddy(e4b);
>> +			goto check;
>>   		}
>> -		goto done;
>> +		return;
>>   	}
> I think this might be more readable when we revert the condition like:
>
> 		/*
> 		 * Fastcommit replay can free already freed blocks which
> 		 * corrupts allocation info. Regenerate it.
> 		 */
> 		if (sbi->s_mount_state & EXT4_FC_REPLAY) {
> 	               	mb_regenerate_buddy(e4b);
> 			goto check;
> 		}
>                  ext4_grp_locked_error(sb, e4b->bd_group,
>                                        inode ? inode->i_ino : 0, blocknr,
>                                        "freeing already freed block (bit %u); block bitmap corrupt.",
>                                        block);
>                  ext4_mark_group_bitmap_corrupted(sb, e4b->bd_group,
>                                  EXT4_GROUP_INFO_BBITMAP_CORRUPT);
> 		return;
> 	}
>
> 								Honza
Yes, it looks much clearer that way!
I will switch to it in the next version.

Thanks a lot!
-- 
With Best Regards,
Baokun Li
.

