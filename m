Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78DF075C2B2
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Jul 2023 11:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjGUJNm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 21 Jul 2023 05:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjGUJNl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 21 Jul 2023 05:13:41 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47EA30E2;
        Fri, 21 Jul 2023 02:13:16 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R6kNC2nwXzrRrv;
        Fri, 21 Jul 2023 17:12:27 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 17:13:13 +0800
Message-ID: <c9cde644-f757-2d72-6ac6-d5cfb1e43da5@huawei.com>
Date:   Fri, 21 Jul 2023 17:13:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 2/4] ext4: fix BUG in ext4_mb_new_inode_pa() due to
 overflow
Content-Language: en-US
To:     <tytso@mit.edu>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        <linux-ext4@vger.kernel.org>
CC:     <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ojaswin@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yangerkun@huawei.com>, <yukuai3@huawei.com>
References: <87lef9lljt.fsf@doe.com>
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <87lef9lljt.fsf@doe.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

On 2023/7/21 16:24, Ritesh Harjani (IBM) wrote:
> Baokun Li <libaokun1@huawei.com> writes:
>
>> On 2023/7/21 3:30, Ritesh Harjani (IBM) wrote:
>>>>> I would like to carefully review all such paths. I will soon review and
>>>>> get back.
>>>> Okay, thank you very much for your careful review.
>>>> The 2nd and 3rd cases of adjusting the best extent are impossible to
>>>> overflow,
>>>> so only the first case is converted here.
>>> I noticed them too during review. I think it would be safe to make the
>>> changes in other two places as well such that in future we never
>>> trip over such overlooked overflow bugs.
>>>
>>>>>> +		BUG_ON(new_bex_end >
>>>>>> +			fex_end(sbi, &ac->ac_g_ex, &ac->ac_orig_goal_len));
>>>>> I am not sure whether using fex_end or pa_end is any helpful.
>>>>> I think we can just typecast if needed and keep it simple rather
>>>>> than adding helpers functions for addition operation.
>>>>> (because of the fact that fex_end() can take a third parameter which
>>>>> sometimes you pass as NULL. Hence it doesn't look clean, IMO)
>>>> I added the helper functions here for two reasons:
>>>> 1. restricting the type of the return value.
>>>> 2. This avoids the ugly line breaks in most cases.
>>>>
>>>> The fex_end() indeed doesn't look as clean as the pa_end(), because we
>>>> might use
>>>> the start of the free extent plus some other length to get a new end,
>>>> like right in
>>>> ext4_mb_new_inode_pa(), which makes me have to add another extra length
>>>> argument, but I think it's worth it, and even with the addition of a
>>>> parameter
>>>> that will probably be unused, it still looks a lot shorter than the
>>>> original code.
>>> IMO, we don't need pa_end() and fex_end() at all. In several places in
>>> ext4 we always have taken care by directly typecasting to avoid
>>> overflows. Also it reads much simpler rather to typecast in place than
>>> having a helper function which is also not very elegant due to a third
>>> parameter. Hence I think we should drop those helpers.
>> I still think helper is useful, but my previous thinking is problematic.
>> I shouldn't
>> make fex_end() adapt to ext4_mb_new_inode_pa(), but should make
>> ext4_mb_new_inode_pa() adapt to fex_end(). After dropping the third argument
>> of fex_end(), modify the ext4_mb_new_inode_pa() function as follows:
> No. I think we are overly complicating it by doing this. IMHO we don't need
> fex_end and pa_end at all here. With fex_end, pa_end, we are passing pointers,
> updating it's members before and after sending it to these functions,
> dereferencing them within those helpers.
>
> e.g. with your change it will look like
> <snip>
> 		struct ext4_free_extent ex = {
> 			.fe_logical = ac->ac_g_ex.fe_logical;
> 			.fe_len = ac->ac_orig_goal_len;
> 		}
>
>          loff_t orig_goal_end = fex_end(sbi, &ex);
> 		ex.fe_len = ac->ac_b_ex.fe_len;
> 		ex.fe_logical = orig_goal_end - EXT4_C2B(sbi, ex.fe_len);
> 		if (ac->ac_o_ex.fe_logical >= ex.fe_logical)
> 			goto adjust_bex;
> </snip>
>
> In above snip we introduced ex variable, updated it with
> orig_goal_len, then called fex_end() to get orig_goal_end, then we again
> updated ex.fe_len, but this time we didn't call fex_end instead we
> needed it for getting ex.fe_logical. All of this is not needed at all.
>
> e.g. we should use just use (loff_t) wherever it was missed in the code.
> <snip>
> 		ext4_lblk_t new_bex_start;
> 		loff_t new_bex_end;
>
> 		new_bex_end = (loff_t)ac->ac_g_ex.fe_logical +
> 			EXT4_C2B(sbi, ac->ac_orig_goal_len);
> 		new_bex_start = new_bex_end - EXT4_C2B(sbi, ac->ac_b_ex.fe_len);
> 		if (ac->ac_o_ex.fe_logical >= new_bex_start)
> 			goto adjust_bex;
> </snip>
>
>
> In this we just update (loff_t) and it reads better in my opinion then
> using ex, fex_end() etc.
>
> In my opinion we should simply drop the helpers. It should be obvious
> that while calculating logical end block for an inode in ext4 by doing
> lstart + len, we should use loff_t.
> Since it can be 1 more than the last block which a u32 can hold.
> So wherever such calculations are made we should ensure the data
> type of left hand operand should be loff_t and we should typecast the
> right hand side operands such that there should not be any overflow
> happening. We do at several places in ext4 already (also while doing
> left-shifting (loff_t)map.m_lblk).
>
> Doing this with helpers, IMO is not useful as we also saw above.

I still think it is necessary to add a helper to make the code more concise.


Ted, do you think the fex_end() helper function is needed here?

I think we might need your advice to end this discussion. 😅

>>
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index a2475b8c9fb5..7492ba9062f4 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -5072,8 +5072,11 @@ ext4_mb_new_inode_pa(struct
>> ext4_allocation_context *ac)
>>           pa = ac->ac_pa;
>>
>>           if (ac->ac_b_ex.fe_len < ac->ac_orig_goal_len) {
>> -               int new_bex_start;
>> -               int new_bex_end;
>> +               struct ext4_free_extent ex = {
>> +                       .fe_logical = ac->ac_g_ex.fe_logical;
>> +                       .fe_len = ac->ac_orig_goal_len;
>> +               }
>> +               loff_t orig_goal_end = fex_end(sbi, &ex);
>>
>>                   /* we can't allocate as much as normalizer wants.
>>                    * so, found space must get proper lstart
>> @@ -5092,29 +5095,23 @@ ext4_mb_new_inode_pa(struct
>> ext4_allocation_context *ac)
>>                    *    still cover original start
>>                    * 3. Else, keep the best ex at start of original request.
>>                    */
>> -               new_bex_end = ac->ac_g_ex.fe_logical +
>> -                       EXT4_C2B(sbi, ac->ac_orig_goal_len);
>> -               new_bex_start = new_bex_end - EXT4_C2B(sbi,
>> ac->ac_b_ex.fe_len);
>> -               if (ac->ac_o_ex.fe_logical >= new_bex_start)
>> -                       goto adjust_bex;
>> +               ex.fe_len = ac->ac_b_ex.fe_len;
>>
>> -               new_bex_start = ac->ac_g_ex.fe_logical;
>> -               new_bex_end =
>> -                       new_bex_start + EXT4_C2B(sbi, ac->ac_b_ex.fe_len);
>> -               if (ac->ac_o_ex.fe_logical < new_bex_end)
>> +               ex.fe_logical = orig_goal_end - EXT4_C2B(sbi, ex.fe_len);
>> +               if (ac->ac_o_ex.fe_logical >= ex.fe_logical)
>>                           goto adjust_bex;
>>
>> -               new_bex_start = ac->ac_o_ex.fe_logical;
>> -               new_bex_end =
>> -                       new_bex_start + EXT4_C2B(sbi, ac->ac_b_ex.fe_len);
>> +               ex.fe_logical = ac->ac_g_ex.fe_logical;
>> +               if (ac->ac_o_ex.fe_logical < fex_end(sbi, &ex))
>> +                       goto adjust_bex;
>>
>> +               ex.fe_logical = ac->ac_o_ex.fe_logical;
>>    adjust_bex:
>> -               ac->ac_b_ex.fe_logical = new_bex_start;
>> +               ac->ac_b_ex.fe_logical = ex.fe_logical;
>>
>>                   BUG_ON(ac->ac_o_ex.fe_logical < ac->ac_b_ex.fe_logical);
>>                   BUG_ON(ac->ac_o_ex.fe_len > ac->ac_b_ex.fe_len);
>> -               BUG_ON(new_bex_end > (ac->ac_g_ex.fe_logical +
>> -                                     EXT4_C2B(sbi, ac->ac_orig_goal_len)));
>> +               BUG_ON(fex_end(sbi, &ex) > orig_goal_end);
>>           }
>>
>>           pa->pa_lstart = ac->ac_b_ex.fe_logical;
Thanks!
-- 
With Best Regards,
Baokun Li
.
