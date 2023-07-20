Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C212275B047
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Jul 2023 15:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjGTNmL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Jul 2023 09:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjGTNmL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 20 Jul 2023 09:42:11 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60D7198D;
        Thu, 20 Jul 2023 06:42:08 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4R6DLs2BX8zLnpY;
        Thu, 20 Jul 2023 21:39:33 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 21:42:01 +0800
Message-ID: <d75562f3-62fc-c54b-967b-0c2e9571b914@huawei.com>
Date:   Thu, 20 Jul 2023 21:42:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 2/4] ext4: fix BUG in ext4_mb_new_inode_pa() due to
 overflow
Content-Language: en-US
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ojaswin@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
        <yukuai3@huawei.com>, Baokun Li <libaokun1@huawei.com>
References: <87edl2oipn.fsf@doe.com>
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <87edl2oipn.fsf@doe.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2023/7/20 20:44, Ritesh Harjani (IBM) wrote:
> Baokun Li <libaokun1@huawei.com> writes:
>
>> When we calculate the end position of ext4_free_extent, this position may
>> be exactly where ext4_lblk_t (i.e. uint) overflows. For example, if
>> ac_g_ex.fe_logical is 4294965248 and ac_orig_goal_len is 2048, then the
>> computed end is 0x100000000, which is 0. If ac->ac_o_ex.fe_logical is not
>> the first case of adjusting the best extent, that is, new_bex_end > 0, the
>> following BUG_ON will be triggered:
> Nice spotting.
>
>> =========================================================
>> kernel BUG at fs/ext4/mballoc.c:5116!
>> invalid opcode: 0000 [#1] PREEMPT SMP PTI
>> CPU: 3 PID: 673 Comm: xfs_io Tainted: G E 6.5.0-rc1+ #279
>> RIP: 0010:ext4_mb_new_inode_pa+0xc5/0x430
>> Call Trace:
>>   <TASK>
>>   ext4_mb_use_best_found+0x203/0x2f0
>>   ext4_mb_try_best_found+0x163/0x240
>>   ext4_mb_regular_allocator+0x158/0x1550
>>   ext4_mb_new_blocks+0x86a/0xe10
>>   ext4_ext_map_blocks+0xb0c/0x13a0
>>   ext4_map_blocks+0x2cd/0x8f0
>>   ext4_iomap_begin+0x27b/0x400
>>   iomap_iter+0x222/0x3d0
>>   __iomap_dio_rw+0x243/0xcb0
>>   iomap_dio_rw+0x16/0x80
>> =========================================================
>>
>> A simple reproducer demonstrating the problem:
>>
>> 	mkfs.ext4 -F /dev/sda -b 4096 100M
>> 	mount /dev/sda /tmp/test
>> 	fallocate -l1M /tmp/test/tmp
>> 	fallocate -l10M /tmp/test/file
>> 	fallocate -i -o 1M -l16777203M /tmp/test/file
>> 	fsstress -d /tmp/test -l 0 -n 100000 -p 8 &
>> 	sleep 10 && killall -9 fsstress
>> 	rm -f /tmp/test/tmp
>> 	xfs_io -c "open -ad /tmp/test/file" -c "pwrite -S 0xff 0 8192"
>
> Could you please also add it into xfstests?
Sure！I'll try to push this test case to xfstests.
> I think it's a nice test which can check the boundary conditions for
> start and end of data types used in mballoc. I think it should even work
> if you don't do fsstress but instead just fallocate some remaining space
> in filesystem, so that when you open and try to write it to 0th offset,
> if automatically hits this error in ext4_mb_new_inode_pa().
Yes, the fsstress here is just to fill up the remaining space on the disk.
>
>> We declare new_bex_start and new_bex_end as correct types and use fex_end()
>> to avoid the problems caused by the ext4_lblk_t overflow above.
>>
>> Fixes: 93cdf49f6eca ("ext4: Fix best extent lstart adjustment logic in ext4_mb_new_inode_pa()")
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> ---
>>   fs/ext4/mballoc.c | 11 +++++------
>>   1 file changed, 5 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index eb7f5d35ef96..2090e5e7ba58 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -5076,8 +5076,8 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
>>   	pa = ac->ac_pa;
>>   
>>   	if (ac->ac_b_ex.fe_len < ac->ac_orig_goal_len) {
>> -		int new_bex_start;
>> -		int new_bex_end;
>> +		ext4_lblk_t new_bex_start;
>> +		loff_t new_bex_end;
>>   
>>   		/* we can't allocate as much as normalizer wants.
>>   		 * so, found space must get proper lstart
>> @@ -5096,8 +5096,7 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
>>   		 *    still cover original start
>>   		 * 3. Else, keep the best ex at start of original request.
>>   		 */
>> -		new_bex_end = ac->ac_g_ex.fe_logical +
>> -			EXT4_C2B(sbi, ac->ac_orig_goal_len);
>> +		new_bex_end = fex_end(sbi, &ac->ac_g_ex, &ac->ac_orig_goal_len);
>>   		new_bex_start = new_bex_end - EXT4_C2B(sbi, ac->ac_b_ex.fe_len);
>>   		if (ac->ac_o_ex.fe_logical >= new_bex_start)
>>   			goto adjust_bex;
>> @@ -5117,8 +5116,8 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
>>   
>>   		BUG_ON(ac->ac_o_ex.fe_logical < ac->ac_b_ex.fe_logical);
>>   		BUG_ON(ac->ac_o_ex.fe_len > ac->ac_b_ex.fe_len);
>> -		BUG_ON(new_bex_end > (ac->ac_g_ex.fe_logical +
>> -				      EXT4_C2B(sbi, ac->ac_orig_goal_len)));
> Ok so the right hand becomes 0 (because then end can go upto 1<<32 which
> will be 0 for unsigned int). And the left (new_bex_end) might be
> negative due to some operations above as I see it.
> And comparing an int with unsigned int, it will promote new_bex_end to
> unsigned int which will make it's value too large and will hit the
> bug_on.
Exactly!
>
> I would like to carefully review all such paths. I will soon review and
> get back.
Okay, thank you very much for your careful review.
The 2nd and 3rd cases of adjusting the best extent are impossible to 
overflow,
so only the first case is converted here.
>
>
>> +		BUG_ON(new_bex_end >
>> +			fex_end(sbi, &ac->ac_g_ex, &ac->ac_orig_goal_len));
> I am not sure whether using fex_end or pa_end is any helpful.
> I think we can just typecast if needed and keep it simple rather
> than adding helpers functions for addition operation.
> (because of the fact that fex_end() can take a third parameter which
> sometimes you pass as NULL. Hence it doesn't look clean, IMO)
I added the helper functions here for two reasons:
1. restricting the type of the return value.
2. This avoids the ugly line breaks in most cases.

The fex_end() indeed doesn't look as clean as the pa_end(), because we 
might use
the start of the free extent plus some other length to get a new end, 
like right in
ext4_mb_new_inode_pa(), which makes me have to add another extra length
argument, but I think it's worth it, and even with the addition of a 
parameter
that will probably be unused, it still looks a lot shorter than the 
original code.
>>   	}
>>   
>>   	pa->pa_lstart = ac->ac_b_ex.fe_logical;
>> -- 
>> 2.31.1
> -ritesh


Thanks again!
-- 
With Best Regards,
Baokun Li
.
