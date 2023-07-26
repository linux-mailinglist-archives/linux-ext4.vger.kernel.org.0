Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157EC762811
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Jul 2023 03:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjGZBSG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 25 Jul 2023 21:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGZBSF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 25 Jul 2023 21:18:05 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499162698;
        Tue, 25 Jul 2023 18:18:02 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R9bZf5rDpzVjf2;
        Wed, 26 Jul 2023 09:16:26 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 09:17:59 +0800
Message-ID: <d59c7b0e-2887-4823-c524-0ab001d8ef95@huawei.com>
Date:   Wed, 26 Jul 2023 09:17:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2 1/3] ext4: add two helper functions
 extent_logical_end() and pa_logical_end()
Content-Language: en-US
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ojaswin@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
        <yukuai3@huawei.com>, Baokun Li <libaokun1@huawei.com>
References: <871qgvdhnd.fsf@doe.com>
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <871qgvdhnd.fsf@doe.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2023/7/26 1:29, Ritesh Harjani (IBM) wrote:
> Baokun Li <libaokun1@huawei.com> writes:
>
>> When we use lstart + len to calculate the end of free extent or prealloc
>> space, it may exceed the maximum value of 4294967295(0xffffffff) supported
>> by ext4_lblk_t and cause overflow, which may lead to various problems.
>>
>> Therefore, we add two helper functions, extent_logical_end() and
>> pa_logical_end(), to limit the type of end to loff_t, and also convert
>> lstart to loff_t for calculation to avoid overflow.
> Sure. extent_logical_end() is not as bad after dropping the third param.
> Thanks for addressing review comments and identifying overflow issues :)
>
> Looks good to me. Feel free to add:
>
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>
Thank you very much for your patient review! 😊
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> ---
>>   fs/ext4/mballoc.c |  9 +++------
>>   fs/ext4/mballoc.h | 14 ++++++++++++++
>>   2 files changed, 17 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index 21b903fe546e..4cb13b3e41b3 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -4432,7 +4432,7 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
>>   
>>   	/* first, let's learn actual file size
>>   	 * given current request is allocated */
>> -	size = ac->ac_o_ex.fe_logical + EXT4_C2B(sbi, ac->ac_o_ex.fe_len);
>> +	size = extent_logical_end(sbi, &ac->ac_o_ex);
>>   	size = size << bsbits;
>>   	if (size < i_size_read(ac->ac_inode))
>>   		size = i_size_read(ac->ac_inode);
>> @@ -4766,7 +4766,6 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
>>   	struct ext4_inode_info *ei = EXT4_I(ac->ac_inode);
>>   	struct ext4_locality_group *lg;
>>   	struct ext4_prealloc_space *tmp_pa = NULL, *cpa = NULL;
>> -	loff_t tmp_pa_end;
>>   	struct rb_node *iter;
>>   	ext4_fsblk_t goal_block;
>>   
>> @@ -4862,9 +4861,7 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
>>   	 * pa can possibly satisfy the request hence check if it overlaps
>>   	 * original logical start and stop searching if it doesn't.
>>   	 */
>> -	tmp_pa_end = (loff_t)tmp_pa->pa_lstart + EXT4_C2B(sbi, tmp_pa->pa_len);
>> -
>> -	if (ac->ac_o_ex.fe_logical >= tmp_pa_end) {
>> +	if (ac->ac_o_ex.fe_logical >= pa_logical_end(sbi, tmp_pa)) {
>>   		spin_unlock(&tmp_pa->pa_lock);
>>   		goto try_group_pa;
>>   	}
>> @@ -5769,7 +5766,7 @@ static void ext4_mb_group_or_file(struct ext4_allocation_context *ac)
>>   
>>   	group_pa_eligible = sbi->s_mb_group_prealloc > 0;
>>   	inode_pa_eligible = true;
>> -	size = ac->ac_o_ex.fe_logical + EXT4_C2B(sbi, ac->ac_o_ex.fe_len);
>> +	size = extent_logical_end(sbi, &ac->ac_o_ex);
>>   	isize = (i_size_read(ac->ac_inode) + ac->ac_sb->s_blocksize - 1)
>>   		>> bsbits;
>>   
>> diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
>> index df6b5e7c2274..d7aeb5da7d86 100644
>> --- a/fs/ext4/mballoc.h
>> +++ b/fs/ext4/mballoc.h
>> @@ -233,6 +233,20 @@ static inline ext4_fsblk_t ext4_grp_offs_to_block(struct super_block *sb,
>>   		(fex->fe_start << EXT4_SB(sb)->s_cluster_bits);
>>   }
>>   
>> +static inline loff_t extent_logical_end(struct ext4_sb_info *sbi,
>> +					struct ext4_free_extent *fex)
>> +{
>> +	/* Use loff_t to avoid end exceeding ext4_lblk_t max. */
>> +	return (loff_t)fex->fe_logical + EXT4_C2B(sbi, fex->fe_len);
>> +}
>> +
>> +static inline loff_t pa_logical_end(struct ext4_sb_info *sbi,
>> +				    struct ext4_prealloc_space *pa)
>> +{
>> +	/* Use loff_t to avoid end exceeding ext4_lblk_t max. */
>> +	return (loff_t)pa->pa_lstart + EXT4_C2B(sbi, pa->pa_len);
>> +}
>> +
>>   typedef int (*ext4_mballoc_query_range_fn)(
>>   	struct super_block		*sb,
>>   	ext4_group_t			agno,
>> -- 
>> 2.31.1
Cheers!
-- 
With Best Regards,
Baokun Li
.
