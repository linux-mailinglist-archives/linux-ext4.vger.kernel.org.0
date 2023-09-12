Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D48979CD9E
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Sep 2023 12:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbjILKOG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 12 Sep 2023 06:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234008AbjILKNy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 12 Sep 2023 06:13:54 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D581FEB;
        Tue, 12 Sep 2023 03:13:50 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c1e780aa95so36448535ad.3;
        Tue, 12 Sep 2023 03:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694513629; x=1695118429; darn=vger.kernel.org;
        h=in-reply-to:subject:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SWJAeko3iCEhEYkXXCptMSebBvLhVfuX0P9EThmvW4Y=;
        b=TKLKSlyI2bLffU5yALMts6b1W2814D2FZPkzVcXgwWcvMJkuNa+TyCQd/EMAKH1a8H
         pDnLZRq2UhjJmO949UiOHUdljt11xIllVf015YvVegD/NR5ENnMz7a1iigHgQF6IuvAO
         Fdwv8GnBFmjekJRvSvgckjkU6+awLPFSYqMygfSom/f++WP2VcUCy+ybsCaB8jX7aj5R
         mvcnjKTfghOD6O4DDFw4Wmv+D59cwhd94i+Z3fJpCdtwba03WuL6JZf2r+qjsdG5aYv1
         cQKAqfkdIKt9mDCXG4nm70uoWDT+E320EJsdJ7qaNfSnraZ0VtPvpXmSNPpQaDgfuvkH
         mRsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694513629; x=1695118429;
        h=in-reply-to:subject:to:from:message-id:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SWJAeko3iCEhEYkXXCptMSebBvLhVfuX0P9EThmvW4Y=;
        b=UvF6FmXqRnIkgMiNpFBFYZizmK3ypNCfw46jIcvV5xHVTeNQxBdC8QNmPez8njH83C
         lgwHuJVd4Pm5iqm8E4Xq9Wc3ivhdH0+W7v3X8BMwafn61rJFYWk1H7ppZisXqkrKrwum
         oEPZ5F2Zz8Df1Hxwzi04glTiBJU4QnRL+DtBfqVSuOvsmSXXVICXtm5tDEitjs1r7Dl3
         w3fm6NNZJR27Au0MaABHITHaVoNfsOhvhZyg8sgheVmTuw1hCjCpoRbTiWpl4sbxluj1
         6OyaMtbn+wfil4K7puurwy3tRFLbAg+nHtYAeTnNpqhAuM1Nzh0pkg9zr4mcOrHtedWm
         NFtA==
X-Gm-Message-State: AOJu0YxyvA5YvcdtBZGT7c7r08ucIJQyTIDkHrGAOaESCxqlVuHjAWR4
        nwm6G+vSF4ZrF25sVTf4UhR607hJ+Gc=
X-Google-Smtp-Source: AGHT+IF8QKAQRqcLdPaVjWnTTdGyJxkXCxVdy8T812dKSp0EBgeCAT3f7hN1hJde5I+yhcWNE7dIgg==
X-Received: by 2002:a17:902:b198:b0:1bb:35b6:448f with SMTP id s24-20020a170902b19800b001bb35b6448fmr8556142plr.15.1694513628910;
        Tue, 12 Sep 2023 03:13:48 -0700 (PDT)
Received: from dw-tp ([49.207.223.191])
        by smtp.gmail.com with ESMTPSA id n9-20020a170902e54900b001c0ce518e98sm7956742plf.224.2023.09.12.03.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 03:13:48 -0700 (PDT)
Date:   Tue, 12 Sep 2023 15:43:44 +0530
Message-Id: <87wmwvbsx3.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 05/11] ext4: Separate block bitmap and buddy bitmap freeing in ext4_mb_clear_bb()
In-Reply-To: <5e2a9358-16ca-2698-f6d1-08352f72d6e9@huaweicloud.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Kemeng Shi <shikemeng@huaweicloud.com> writes:

> on 9/4/2023 11:00 AM, Kemeng Shi wrote:
>> 
>> 
>> on 9/1/2023 5:34 PM, Ritesh Harjani wrote:
>>> Kemeng Shi <shikemeng@huaweicloud.com> writes:
>>>
>>>> This patch separates block bitmap and buddy bitmap freeing in order to
>>>> udpate block bitmap with ext4_mb_mark_context in following patch.
>>> ^^^ update.
>>>
>>>>
>>>> Separated freeing is safe with concurrent allocation as long as:
>>>> 1. Firstly allocate block in buddy bitmap, and then in block bitmap.
>>>> 2. Firstly free block in block bitmap, and then buddy bitmap.
>>>> Then freed block will only be available to allocation when both buddy
>>>> bitmap and block bitmap are updated by freeing.
>>>> Allocation obeys rule 1 already, just do sperated freeing with rule 2.
>>>
>>> So we also don't need ext4_load_buddy_gfp() before freeing on-disk
>>> bitmap right. Continue below...
>>>
>>>>
>>>> Separated freeing has no race with generate_buddy as:
>>>> Once ext4_mb_load_buddy_gfp is executed successfully, the update-to-date
>>>> buddy page can be found in sbi->s_buddy_cache and no more buddy
>>>> initialization of the buddy page will be executed concurrently until
>>>> buddy page is unloaded. As we always do free in "load buddy, free,
>>>> unload buddy" sequence, separated freeing has no race with generate_buddy.
>>>>
>>>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>>>> ---
>>>>  fs/ext4/mballoc.c | 18 ++++++++----------
>>>>  1 file changed, 8 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>>>> index e650eac22237..01ad36a1cc96 100644
>>>> --- a/fs/ext4/mballoc.c
>>>> +++ b/fs/ext4/mballoc.c
>>>> @@ -6519,6 +6519,14 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
>>>>  	if (err)
>>>>  		goto error_return;
>>>
>>>
>>> Let me add the a piece of code before the added changes and continue...
>>>
>>> 	err = ext4_mb_load_buddy_gfp(sb, block_group, &e4b,
>>> 				     GFP_NOFS|__GFP_NOFAIL);
>>> 	if (err)
>>> 		goto error_return;
>>>>  
>>>> +	ext4_lock_group(sb, block_group);
>>>> +	mb_clear_bits(bitmap_bh->b_data, bit, count_clusters);
>>>> +	ret = ext4_free_group_clusters(sb, gdp) + count_clusters;
>>>> +	ext4_free_group_clusters_set(sb, gdp, ret);
>>>> +	ext4_block_bitmap_csum_set(sb, gdp, bitmap_bh);
>>>> +	ext4_group_desc_csum_set(sb, block_group, gdp);
>>>> +	ext4_unlock_group(sb, block_group);
>>>> +
>>>
>>> ...Is it required for ext4_mb_load_buddy_gfp() to be called before
>>> freeing on-disk bitmap blocks? Can you explain why please?
>>> At least it is not very clear to me that why do we need
>>> ext4_mb_load_buddy_gfp() before clearing of bitmap blocks. If it's not
>>> needed then I think we should separate out bitmap freeing logic and
>>> buddy freeing logic even further.
>> Yes, ext4_mb_load_buddy_gfp is no needed for clearing of bitmap, put

Earlier you mentioned here that there is no dependency.


>> it before bit clearing for catching error and aborting mark early
>> to reduce functional change.
> Hi Ritesh, sorry for bother. I'm going to push a new version and I perfer
> to call ext4_mb_load_buddy_gfp early to catch potential error in advance.
> Just wonder is this good to you. Like to hear any advice. Thanks!

Isn't there actually a dependency that we should first always call
ext4_mb_load_buddy_gfp() before clearing the bitmap? 

Because say if we take care of the bitmap handling first, i.e. we clear
the bitmap and also call ext4_handle_dirty_metadata() first. Now assume
we later call ext4_mb_load_buddy_gfp(). Now also assume the buddy pages
were not already loaded in memory (reclaimed due to memory pressure),
in that case we will read the block bitmap of that group from the
on-disk bitmap copy, which we already changed above.
So that means the buddy handling logic will already find the block
bitmap as cleared and should report problems right?

Then isn't there an actual dependency here, meaning
ext4_mb_load_buddy_gfp() should always be called first before bitmap
handling logic. Thoughts?

-ritesh


>>>
>>> Thoughts?
>>>
>>>>  	/*
>>>>  	 * We need to make sure we don't reuse the freed block until after the
>>>>  	 * transaction is committed. We make an exception if the inode is to be
>>>> @@ -6541,13 +6549,8 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
>>>>  		new_entry->efd_tid = handle->h_transaction->t_tid;
>>>>  
>>>>  		ext4_lock_group(sb, block_group);
>>>> -		mb_clear_bits(bitmap_bh->b_data, bit, count_clusters);
>>>>  		ext4_mb_free_metadata(handle, &e4b, new_entry);
>>>>  	} else {
>>>> -		/* need to update group_info->bb_free and bitmap
>>>> -		 * with group lock held. generate_buddy look at
>>>> -		 * them with group lock_held
>>>> -		 */
>>>>  		if (test_opt(sb, DISCARD)) {
>>>>  			err = ext4_issue_discard(sb, block_group, bit,
>>>>  						 count_clusters, NULL);
>>>> @@ -6560,14 +6563,9 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
>>>>  			EXT4_MB_GRP_CLEAR_TRIMMED(e4b.bd_info);
>>>>  
>>>>  		ext4_lock_group(sb, block_group);
>>>> -		mb_clear_bits(bitmap_bh->b_data, bit, count_clusters);
>>>>  		mb_free_blocks(inode, &e4b, bit, count_clusters);
>>>>  	}
>>>>  
>>>> -	ret = ext4_free_group_clusters(sb, gdp) + count_clusters;
>>>> -	ext4_free_group_clusters_set(sb, gdp, ret);
>>>> -	ext4_block_bitmap_csum_set(sb, gdp, bitmap_bh);
>>>> -	ext4_group_desc_csum_set(sb, block_group, gdp);
>>>>  	ext4_unlock_group(sb, block_group);
>>>>  
>>>>  	if (sbi->s_log_groups_per_flex) {
>>>
>>>
>>> Adding piece of code here...
>>>
>>> 	if (sbi->s_log_groups_per_flex) {
>>> 		ext4_group_t flex_group = ext4_flex_group(sbi, block_group);
>>> 		atomic64_add(count_clusters,
>>> 			     &sbi_array_rcu_deref(sbi, s_flex_groups,
>>> 						  flex_group)->free_clusters);
>>> 	}
>>>
>>> <...>
>>>
>>> 	/* We dirtied the bitmap block */
>>> 	BUFFER_TRACE(bitmap_bh, "dirtied bitmap block");
>>> 	err = ext4_handle_dirty_metadata(handle, NULL, bitmap_bh);
>>> 	/* And the group descriptor block */
>>> 	BUFFER_TRACE(gd_bh, "dirtied group descriptor block");
>>> 	ret = ext4_handle_dirty_metadata(handle, NULL, gd_bh);
>>> 	if (!err)
>>> 		err = ret;
>>>
>>> I was thinking even this can go around bitmap freeing logic above. So
>>> the next patch becomes very clear that all of the bitmap freeing logic
>>> is just simply moved into ext4_mb_mark_context() function.
>>>
>>> -ritesh
>>>
>> 
>> 
