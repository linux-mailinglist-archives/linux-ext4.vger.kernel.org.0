Return-Path: <linux-ext4+bounces-499-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3590E817F7C
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Dec 2023 02:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3BA8B231C9
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Dec 2023 01:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4E4187F;
	Tue, 19 Dec 2023 01:51:18 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47A21FAE;
	Tue, 19 Dec 2023 01:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4SvKR81wlrz1wntg;
	Tue, 19 Dec 2023 09:51:00 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 6B6E5140415;
	Tue, 19 Dec 2023 09:51:13 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Dec 2023 09:51:12 +0800
Message-ID: <e56b281b-2d23-dea7-f37e-c6cb5582a4af@huawei.com>
Date: Tue, 19 Dec 2023 09:51:12 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 1/4] ext4: fix double-free of blocks due to wrong extents
 moved_len
Content-Language: en-US
To: Jan Kara <jack@suse.cz>
CC: <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <yukuai3@huawei.com>, Wei Chen
	<harperchen1110@gmail.com>, xingwei lee <xrivendell7@gmail.com>,
	<stable@vger.kernel.org>, Baokun Li <libaokun1@huawei.com>
References: <20231218141814.1477338-1-libaokun1@huawei.com>
 <20231218141814.1477338-2-libaokun1@huawei.com>
 <20231218153227.x273h3c5t2dqgh76@quack3>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20231218153227.x273h3c5t2dqgh76@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500021.china.huawei.com (7.185.36.21)

On 2023/12/18 23:32, Jan Kara wrote:
> On Mon 18-12-23 22:18:11, Baokun Li wrote:
>> In ext4_move_extents(), moved_len is only updated when all moves are
>> successfully executed, and only discards orig_inode and donor_inode
>> preallocations when moved_len is not zero. When the loop fails to exit
>> after successfully moving some extents, moved_len is not updated and
>> remains at 0, so it does not discard the preallocations.
>>
>> If the moved extents overlap with the preallocated extents, the
>> overlapped extents are freed twice in ext4_mb_release_inode_pa() and
>> ext4_process_freed_data() (as described in commit 94d7c16cbbbd), and
>> bb_free is incremented twice. Hence when trim is executed, a zero-division
>> bug is triggered in mb_update_avg_fragment_size() because bb_free is not
>> zero and bb_fragments is zero.
>>
>> Therefore, update move_len after each extent move to avoid the issue.
>>
>> Reported-by: Wei Chen <harperchen1110@gmail.com>
>> Reported-by: xingwei lee <xrivendell7@gmail.com>
>> Closes: https://lore.kernel.org/r/CAO4mrferzqBUnCag8R3m2zf897ts9UEuhjFQGPtODT92rYyR2Q@mail.gmail.com
>> Fixes: fcf6b1b729bc ("ext4: refactor ext4_move_extents code base")
>> CC: stable@vger.kernel.org # 3.18
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> ---
>>   fs/ext4/move_extent.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
>> index 3aa57376d9c2..4b9b503c6346 100644
>> --- a/fs/ext4/move_extent.c
>> +++ b/fs/ext4/move_extent.c
>> @@ -672,7 +672,7 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
>>   		 */
>>   		ext4_double_up_write_data_sem(orig_inode, donor_inode);
>>   		/* Swap original branches with new branches */
>> -		move_extent_per_page(o_filp, donor_inode,
>> +		*moved_len += move_extent_per_page(o_filp, donor_inode,
>>   				     orig_page_index, donor_page_index,
>>   				     offset_in_page, cur_len,
>>   				     unwritten, &ret);
> Although this is currently fine, I think ext4_move_extents() should be
> careful and zero out *moved_len before it starts using it.
Totally agree, now __ext4_ioctl zeroes it out, but to avoid code logic
changes or new callers afterward,  I'll zero it out before using it in
ext4_move_extents() in the next version.
>
>> @@ -682,7 +682,6 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
>>   		o_start += cur_len;
>>   		d_start += cur_len;
>>   	}
>> -	*moved_len = o_start - orig_blk;
>>   	if (*moved_len > len)
>>   		*moved_len = len;
> So I'm not sure the *moved_len > len condition can ever trigger but if it
> does, we'd need to check it whenever we are returning moved_len. So either
> I'd delete the condition or move it to the out label.
>
> 								Honza
As the code stands now, the *moved_len > len condition never
occurs, and is supposed to be code left over from the refactoring
in [Fixes], which I'll remove in the next version.

Thank you for your review!
-- 
With Best Regards,
Baokun Li
.

