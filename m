Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6B85347ED
	for <lists+linux-ext4@lfdr.de>; Thu, 26 May 2022 03:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbiEZBQW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 25 May 2022 21:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiEZBQV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 25 May 2022 21:16:21 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F5A4EA36;
        Wed, 25 May 2022 18:16:19 -0700 (PDT)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L7qgc2f40zQkNm;
        Thu, 26 May 2022 09:13:16 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 26 May 2022 09:16:16 +0800
Message-ID: <850b644f-a5b5-48d8-8899-7de7bd944745@huawei.com>
Date:   Thu, 26 May 2022 09:16:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/2] ext4: correct the judgment of BUG in
 ext4_mb_normalize_request
To:     Jan Kara <jack@suse.cz>
CC:     <lczerner@redhat.com>, <linux-ext4@vger.kernel.org>,
        <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yebin10@huawei.com>, <yukuai3@huawei.com>,
        Baokun Li <libaokun1@huawei.com>
References: <20220521134217.312071-1-libaokun1@huawei.com>
 <20220521134217.312071-3-libaokun1@huawei.com>
 <20220523094023.e3rnile4wh7uiich@quack3.lan>
 <3755e40b-f817-83df-b239-b0697976c272@huawei.com>
 <20220524093026.qhwyibhgg6ulsw6r@quack3.lan>
 <26962b95-1129-60c4-dbde-6fea44c514a6@huawei.com>
 <20220525112932.d3gi7nynygkirdpi@quack3.lan>
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20220525112932.d3gi7nynygkirdpi@quack3.lan>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

在 2022/5/25 19:29, Jan Kara 写道:
> On Tue 24-05-22 21:44:31, Baokun Li wrote:
>> 在 2022/5/24 17:30, Jan Kara 写道:
>>> On Mon 23-05-22 21:04:16, libaokun (A) wrote:
>>>> 在 2022/5/23 17:40, Jan Kara 写道:
>>>>> On Sat 21-05-22 21:42:17, Baokun Li wrote:
>>>>>> When either of the "start + size <= ac->ac_o_ex.fe_logical" or
>>>>>> "start > ac->ac_o_ex.fe_logical" conditions is met, it indicates
>>>>>> that the fe_logical is not in the allocated range.
>>>>>> In this case, it should be bug_ON.
>>>>>>
>>>>>> Fixes: dfe076c106f6 ("ext4: get rid of code duplication")
>>>>>> Signed-off-by: Baokun Li<libaokun1@huawei.com>
>>>>> I think this is actually wrong. The original condition checks whether
>>>>> start + size does not overflow the used integer type. Your condition is
>>>>> much stronger and I don't think it always has to be true. E.g. allocation
>>>>> goal block (start variable) can be pushed to larger values by existing
>>>>> preallocation or so.
>>>>>
>>>>> 								Honza
>>>>>
>>>> I think there are two reasons for this:
>>>>
>>>> First of all, the code here is as follows.
>>>> ```
>>>>           size = end - start;
>>>>           [...]
>>>> if (start + size <= ac->ac_o_ex.fe_logical &&
>>>>                           start > ac->ac_o_ex.fe_logical) {
>>>>                   ext4_msg(ac->ac_sb, KERN_ERR,
>>>>                            "start %lu, size %lu, fe_logical %lu",
>>>>                            (unsigned long) start, (unsigned long) size,
>>>>                            (unsigned long) ac->ac_o_ex.fe_logical);
>>>> BUG();
>>>> }
>>>>           BUG_ON(size <= 0 || size > EXT4_BLOCKS_PER_GROUP(ac->ac_sb));
>>>> ```
>>>> First of all, there is no need to compare with ac_o_ex.fe_logical if it is
>>>> to determine whether there is an overflow.
>>>> Because the previous logic guarantees start < = ac_o_ex.fe_logical, and
>>> How does it guarantee that? The logic:
>>>
>>>           if (ar->pleft && start <= ar->lleft) {
>>>                   size -= ar->lleft + 1 - start;
>>>                   start = ar->lleft + 1;
>>>           }
>>>
>>> can move 'start' to further blocks...
>> This is not the case. According to the code of the preceding process,
>> ar->pleft and ar->pright are assigned values in ext4_ext_map_blocks.
>> ar->pleft is the first allocated block found to the left by map->m_lblk
>> (that is, fe_logical),
>> and ar->pright is the first allocated block found to the right.
>> ar->lleft and ar->lright are logical block numbers, so there must be
>> "ar->lleft < ac_o_ex.fe_logical < ar->lright".
> Right, I've found that out after sending my previous email. Sorry for
> confusion.
Don't be sorry. Thank you very much for your advice. It has benefited me 
a lot.
>
>>>> Secondly, the following code flow also reflects this logic.
>>>>
>>>>              ext4_mb_normalize_request
>>>>               >>> start + size <= ac->ac_o_ex.fe_logical
>>>>              ext4_mb_regular_allocator
>>>>               ext4_mb_simple_scan_group
>>>>                ext4_mb_use_best_found
>>>>                 ext4_mb_new_preallocation
>>>>                  ext4_mb_new_inode_pa
>>>>                   ext4_mb_use_inode_pa
>>>>                    >>> set ac->ac_b_ex.fe_len <= 0
>>>>              ext4_mb_mark_diskspace_used
>>>>               >>> BUG_ON(ac->ac_b_ex.fe_len <= 0);
>>>>
>>>> In ext4_mb_use_inode_pa, you have the following code.
>>>> ```
>>>> start = pa->pa_pstart + (ac->ac_o_ex.fe_logical - pa->pa_lstart);
>>>> end = min(pa->pa_pstart + EXT4_C2B(sbi, pa->pa_len), start + EXT4_C2B(sbi,
>>>> ac->ac_o_ex.fe_len));
>>>> len = EXT4_NUM_B2C(sbi, end - start);
>>>> ac->ac_b_ex.fe_len = len;
>>>> ```
>>>> The starting position in ext4_mb_mark_diskspace_used will be assert.
>>>> BUG_ON(ac->ac_b_ex.fe_len <= 0);
>>>> When end == start + EXT4_C2B(sbi, ac->ac_o_ex.fe_len) is used, the value of
>>>> end - start must be greater than 0.
>>>> However, when end == pa->pa_pstart + EXT4_C2B(sbi, pa->pa_len) occurs, this
>>>> bug_ON may be triggered.
>>>> When this bug_ON is triggered, that is,
>>>>
>>>> ac->ac_b_ex.fe_len <= 0
>>>> end - start <= 0
>>>> end <= start
>>>> pa->pa_pstart + EXT4_C2B(sbi, pa->pa_len) <= pa->pa_pstart +
>>>> (ac->ac_o_ex.fe_logical - pa->pa_lstart)
>>>> pa->pa_len <= ac->ac_o_ex.fe_logical - pa->pa_lstart
>>>> pa->pa_lstart + pa->pa_len <= ac->ac_o_ex.fe_logical
>>>> start + size <= ac->ac_o_ex.fe_logical
>>>>
>>>> So I think that "&&" here should be changed to "||".
>>> Sorry, I still disagree. After some more code reading I agree that
>>> ac->ac_o_ex.fe_logical is the logical block where we want allocated blocks
>>> to be placed in the inode so logical extent of allocated blocks should include
>>> ac->ac_o_ex.fe_logical. But I would be reluctant to make assertion you
>>> suggest unless we make sure ac->ac_o_ex.fe_logical in unallocated (in which
>>> case we can also remove some other code from ext4_mb_normalize_request()).
>>>
>>> 									Honza
>>>
>> What codes are you referring to that can be deleted?
> So I though the shifting of 'start' by lleft cannot happen but then I
> realized that if 'start' got aligned down, it can now be lower than lleft
> so the shifting is indeed needed. So all code is needed there.
>
> 								Honza

Okay, thanks again!

-- 
With Best Regards,
Baokun Li
.

