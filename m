Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340D779D005
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Sep 2023 13:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234743AbjILLcx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 12 Sep 2023 07:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234773AbjILLcL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 12 Sep 2023 07:32:11 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D331706;
        Tue, 12 Sep 2023 04:32:07 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RlLym1ZRFz4f3jJ9;
        Tue, 12 Sep 2023 19:32:00 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP1 (Coremail) with SMTP id cCh0CgBH0LAyTABlYC0PAQ--.55607S2;
        Tue, 12 Sep 2023 19:32:04 +0800 (CST)
Subject: Re: [PATCH v6 05/11] ext4: Separate block bitmap and buddy bitmap
 freeing in ext4_mb_clear_bb()
To:     Ritesh Harjani <ritesh.list@gmail.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <87wmwvbsx3.fsf@doe.com>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <4cff9b35-5da4-56ee-8712-204d592b1f5b@huaweicloud.com>
Date:   Tue, 12 Sep 2023 19:32:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <87wmwvbsx3.fsf@doe.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: cCh0CgBH0LAyTABlYC0PAQ--.55607S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKF18Zw17uw1rWw15Ww17ZFb_yoWxZw4Dpr
        9Fk3WDCrn8Jrn09r1Ivw1jq3Wxtw48GF4UXrW3u34rCrnrtF93KF1xGF1UuF1DtFsrJF1q
        qw45urZ7Cr1xZa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



on 9/12/2023 6:13 PM, Ritesh Harjani wrote:
> Kemeng Shi <shikemeng@huaweicloud.com> writes:
> 
>> on 9/4/2023 11:00 AM, Kemeng Shi wrote:
>>>
>>>
>>> on 9/1/2023 5:34 PM, Ritesh Harjani wrote:
>>>> Kemeng Shi <shikemeng@huaweicloud.com> writes:
>>>>
>>>>> This patch separates block bitmap and buddy bitmap freeing in order to
>>>>> udpate block bitmap with ext4_mb_mark_context in following patch.
>>>> ^^^ update.
>>>>
>>>>>
>>>>> Separated freeing is safe with concurrent allocation as long as:
>>>>> 1. Firstly allocate block in buddy bitmap, and then in block bitmap.
>>>>> 2. Firstly free block in block bitmap, and then buddy bitmap.
>>>>> Then freed block will only be available to allocation when both buddy
>>>>> bitmap and block bitmap are updated by freeing.
>>>>> Allocation obeys rule 1 already, just do sperated freeing with rule 2.
>>>>
>>>> So we also don't need ext4_load_buddy_gfp() before freeing on-disk
>>>> bitmap right. Continue below...
>>>>
>>>>>
>>>>> Separated freeing has no race with generate_buddy as:
>>>>> Once ext4_mb_load_buddy_gfp is executed successfully, the update-to-date
>>>>> buddy page can be found in sbi->s_buddy_cache and no more buddy
>>>>> initialization of the buddy page will be executed concurrently until
>>>>> buddy page is unloaded. As we always do free in "load buddy, free,
>>>>> unload buddy" sequence, separated freeing has no race with generate_buddy.
>>>>>
>>>>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>>>>> ---
>>>>>  fs/ext4/mballoc.c | 18 ++++++++----------
>>>>>  1 file changed, 8 insertions(+), 10 deletions(-)
>>>>>
>>>>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>>>>> index e650eac22237..01ad36a1cc96 100644
>>>>> --- a/fs/ext4/mballoc.c
>>>>> +++ b/fs/ext4/mballoc.c
>>>>> @@ -6519,6 +6519,14 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
>>>>>  	if (err)
>>>>>  		goto error_return;
>>>>
>>>>
>>>> Let me add the a piece of code before the added changes and continue...
>>>>
>>>> 	err = ext4_mb_load_buddy_gfp(sb, block_group, &e4b,
>>>> 				     GFP_NOFS|__GFP_NOFAIL);
>>>> 	if (err)
>>>> 		goto error_return;
>>>>>  
>>>>> +	ext4_lock_group(sb, block_group);
>>>>> +	mb_clear_bits(bitmap_bh->b_data, bit, count_clusters);
>>>>> +	ret = ext4_free_group_clusters(sb, gdp) + count_clusters;
>>>>> +	ext4_free_group_clusters_set(sb, gdp, ret);
>>>>> +	ext4_block_bitmap_csum_set(sb, gdp, bitmap_bh);
>>>>> +	ext4_group_desc_csum_set(sb, block_group, gdp);
>>>>> +	ext4_unlock_group(sb, block_group);
>>>>> +
>>>>
>>>> ...Is it required for ext4_mb_load_buddy_gfp() to be called before
>>>> freeing on-disk bitmap blocks? Can you explain why please?
>>>> At least it is not very clear to me that why do we need
>>>> ext4_mb_load_buddy_gfp() before clearing of bitmap blocks. If it's not
>>>> needed then I think we should separate out bitmap freeing logic and
>>>> buddy freeing logic even further.
>>> Yes, ext4_mb_load_buddy_gfp is no needed for clearing of bitmap, put
> 
> Earlier you mentioned here that there is no dependency.
> 
> 
>>> it before bit clearing for catching error and aborting mark early
>>> to reduce functional change.
>> Hi Ritesh, sorry for bother. I'm going to push a new version and I perfer
>> to call ext4_mb_load_buddy_gfp early to catch potential error in advance.
>> Just wonder is this good to you. Like to hear any advice. Thanks!
> 
> Isn't there actually a dependency that we should first always call
> ext4_mb_load_buddy_gfp() before clearing the bitmap? 
> 
> Because say if we take care of the bitmap handling first, i.e. we clear
> the bitmap and also call ext4_handle_dirty_metadata() first. Now assume
> we later call ext4_mb_load_buddy_gfp(). Now also assume the buddy pages
> were not already loaded in memory (reclaimed due to memory pressure),
> in that case we will read the block bitmap of that group from the
> on-disk bitmap copy, which we already changed above.
> So that means the buddy handling logic will already find the block
> bitmap as cleared and should report problems right?
> 
> Then isn't there an actual dependency here, meaning
> ext4_mb_load_buddy_gfp() should always be called first before bitmap
> handling logic. Thoughts?
> 
My fault, ext4_mb_load_buddy_gfp should be called before on-disk bitmap
handling if buddy page was not loaded...

> -ritesh
> 
> 
>>>>
>>>> Thoughts?
>>>>
>>>>>  	/*
>>>>>  	 * We need to make sure we don't reuse the freed block until after the
>>>>>  	 * transaction is committed. We make an exception if the inode is to be
>>>>> @@ -6541,13 +6549,8 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
>>>>>  		new_entry->efd_tid = handle->h_transaction->t_tid;
>>>>>  
>>>>>  		ext4_lock_group(sb, block_group);
>>>>> -		mb_clear_bits(bitmap_bh->b_data, bit, count_clusters);
>>>>>  		ext4_mb_free_metadata(handle, &e4b, new_entry);
>>>>>  	} else {
>>>>> -		/* need to update group_info->bb_free and bitmap
>>>>> -		 * with group lock held. generate_buddy look at
>>>>> -		 * them with group lock_held
>>>>> -		 */
>>>>>  		if (test_opt(sb, DISCARD)) {
>>>>>  			err = ext4_issue_discard(sb, block_group, bit,
>>>>>  						 count_clusters, NULL);
>>>>> @@ -6560,14 +6563,9 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
>>>>>  			EXT4_MB_GRP_CLEAR_TRIMMED(e4b.bd_info);
>>>>>  
>>>>>  		ext4_lock_group(sb, block_group);
>>>>> -		mb_clear_bits(bitmap_bh->b_data, bit, count_clusters);
>>>>>  		mb_free_blocks(inode, &e4b, bit, count_clusters);
>>>>>  	}
>>>>>  
>>>>> -	ret = ext4_free_group_clusters(sb, gdp) + count_clusters;
>>>>> -	ext4_free_group_clusters_set(sb, gdp, ret);
>>>>> -	ext4_block_bitmap_csum_set(sb, gdp, bitmap_bh);
>>>>> -	ext4_group_desc_csum_set(sb, block_group, gdp);
>>>>>  	ext4_unlock_group(sb, block_group);
>>>>>  
>>>>>  	if (sbi->s_log_groups_per_flex) {
>>>>
>>>>
>>>> Adding piece of code here...
>>>>
>>>> 	if (sbi->s_log_groups_per_flex) {
>>>> 		ext4_group_t flex_group = ext4_flex_group(sbi, block_group);
>>>> 		atomic64_add(count_clusters,
>>>> 			     &sbi_array_rcu_deref(sbi, s_flex_groups,
>>>> 						  flex_group)->free_clusters);
>>>> 	}
>>>>
>>>> <...>
>>>>
>>>> 	/* We dirtied the bitmap block */
>>>> 	BUFFER_TRACE(bitmap_bh, "dirtied bitmap block");
>>>> 	err = ext4_handle_dirty_metadata(handle, NULL, bitmap_bh);
>>>> 	/* And the group descriptor block */
>>>> 	BUFFER_TRACE(gd_bh, "dirtied group descriptor block");
>>>> 	ret = ext4_handle_dirty_metadata(handle, NULL, gd_bh);
>>>> 	if (!err)
>>>> 		err = ret;
>>>>
>>>> I was thinking even this can go around bitmap freeing logic above. So
>>>> the next patch becomes very clear that all of the bitmap freeing logic
>>>> is just simply moved into ext4_mb_mark_context() function.
>>>>
>>>> -ritesh
>>>>
>>>
>>>
> 

