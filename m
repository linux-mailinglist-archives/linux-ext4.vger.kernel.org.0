Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41EA975C0AB
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Jul 2023 10:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjGUICF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 21 Jul 2023 04:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjGUICA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 21 Jul 2023 04:02:00 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970F92704;
        Fri, 21 Jul 2023 01:01:55 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R6hn65hj3zVjlJ;
        Fri, 21 Jul 2023 16:00:26 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 16:01:52 +0800
Message-ID: <688c8528-f681-cd6e-d16d-5ecc2e21a75d@huawei.com>
Date:   Fri, 21 Jul 2023 16:01:52 +0800
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
References: <878rbao0zs.fsf@doe.com>
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <878rbao0zs.fsf@doe.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2023/7/21 3:07, Ritesh Harjani (IBM) wrote:
> Baokun Li <libaokun1@huawei.com> writes:
>
>> When we calculate the end position of ext4_free_extent, this position may
>> be exactly where ext4_lblk_t (i.e. uint) overflows. For example, if
>> ac_g_ex.fe_logical is 4294965248 and ac_orig_goal_len is 2048, then the
>> computed end is 0x100000000, which is 0. If ac->ac_o_ex.fe_logical is not
>> the first case of adjusting the best extent, that is, new_bex_end > 0, the
>> following BUG_ON will be triggered:
>>
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
>>
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
> 		new_bex_end = ac->ac_g_ex.fe_logical +
> 			EXT4_C2B(sbi, ac->ac_orig_goal_len);
> 		new_bex_start = new_bex_end - EXT4_C2B(sbi, ac->ac_b_ex.fe_len);
> 		if (ac->ac_o_ex.fe_logical >= new_bex_start)
> 			goto adjust_bex;
>
> 		new_bex_start = ac->ac_g_ex.fe_logical;
> 		new_bex_end =
> 			new_bex_start + EXT4_C2B(sbi, ac->ac_b_ex.fe_len);
> 		if (ac->ac_o_ex.fe_logical < new_bex_end)
> 			goto adjust_bex;
>
> 		new_bex_start = ac->ac_o_ex.fe_logical;
> 		new_bex_end =
> 			new_bex_start + EXT4_C2B(sbi, ac->ac_b_ex.fe_len);
>
> I think it will be safer if we typecast all above new_bex_end
> calculations. I understand that it might never happen here that
> fe_logical + best found extent length will make it overflow.
> Simply because we only enter here when ac_b_ex.fe_len <
> ac_orig_goal_len. But I think if we change any logic tomorrow or
> refactor any part of code, it will be much safer if we simply keep the
> typecast in place so that we avoid any future tripping caused by
> arithmatic overflow here.
>
> Also I am not finding fex_end() or pa_end() helpers very intuitive way
> of doing it. I feel typecasting in place is much simpler and reads better.
>
> -ritesh
I remove the third parameter of fex_end() and adjust the code in
ext4_mb_new_inode_pa() as follows:

                 struct ext4_free_extent ex = {
                         .fe_logical = ac->ac_g_ex.fe_logical,
                         .fe_len = ac->ac_orig_goal_len,
                 };
                 loff_t orig_goal_end = fex_end(sbi, &ex);

                 ex.fe_len = ac->ac_b_ex.fe_len;

                 ex.fe_logical = orig_goal_end - EXT4_C2B(sbi, ex.fe_len);
                 if (ac->ac_o_ex.fe_logical >= ex.fe_logical)
                         goto adjust_bex;

                 ex.fe_logical = ac->ac_g_ex.fe_logical;
                 if (ac->ac_o_ex.fe_logical < fex_end(sbi, &ex))
                         goto adjust_bex;

                 ex.fe_logical = ac->ac_o_ex.fe_logical;
adjust_bex:
                 ac->ac_b_ex.fe_logical = ex.fe_logical;

                 BUG_ON(ac->ac_o_ex.fe_logical < ac->ac_b_ex.fe_logical);
                 BUG_ON(ac->ac_o_ex.fe_len > ac->ac_b_ex.fe_len);
                 BUG_ON(fex_end(sbi, &ex) > orig_goal_end);
In this way, all new_bex_end calculations do not have overflow problems,
and the code looks much more neat than before. 😊
>> @@ -5117,8 +5116,8 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
>>   
>>   		BUG_ON(ac->ac_o_ex.fe_logical < ac->ac_b_ex.fe_logical);
>>   		BUG_ON(ac->ac_o_ex.fe_len > ac->ac_b_ex.fe_len);
>> -		BUG_ON(new_bex_end > (ac->ac_g_ex.fe_logical +
>> -				      EXT4_C2B(sbi, ac->ac_orig_goal_len)));
>> +		BUG_ON(new_bex_end >
>> +			fex_end(sbi, &ac->ac_g_ex, &ac->ac_orig_goal_len));
>>   	}
>>   
>>   	pa->pa_lstart = ac->ac_b_ex.fe_logical;
>> -- 
>> 2.31.1
Thanks!
-- 
With Best Regards,
Baokun Li
.
