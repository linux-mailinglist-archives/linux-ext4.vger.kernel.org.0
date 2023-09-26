Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632827AE43A
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Sep 2023 05:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbjIZDfX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 25 Sep 2023 23:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbjIZDfW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 25 Sep 2023 23:35:22 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A333EFB
        for <linux-ext4@vger.kernel.org>; Mon, 25 Sep 2023 20:35:14 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-77428e40f71so299339985a.1
        for <linux-ext4@vger.kernel.org>; Mon, 25 Sep 2023 20:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695699313; x=1696304113; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yatOIpJ9QqetGV+/ndaPDtlhpuHus9tpMGj9Um9wmuA=;
        b=e7KoLzKLTYL52yz1KXpBSnYS6hZ9BNi0Z69Xz8xTPbWKLsdUrQGRcpcI8sdVBGfXMx
         Xu/aD0lxdM3sOn4basjjM2dHQr8A8va3rJQPW/TYmnT14t3RzGXXMfwQZKofHqXyBNR8
         z3IyYP2kk1SNFAAjg4l6IAJs+p228ugqpaLDwBz/F6GNcU1YkObWHkoY2H7Lo8wor/jV
         Mx6HdNAMZaxdcNzegwuhdO3mkKNMayc3WUmXwWv8w8FV7H5agC3k7R2FA7QJa5ZbDZP8
         YeKMRtsS84BpLe5YUHfl4DY0RxpBJrrKEsYKZuZCGJEdZCciw6P4VPnPAlVsoej6ivWJ
         JDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695699313; x=1696304113;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yatOIpJ9QqetGV+/ndaPDtlhpuHus9tpMGj9Um9wmuA=;
        b=OkRt1yuPj9BFoFJPdCnAPVNJSUtyPViEEUWeUpOZMQZlr1yjOwoEMsObw7Ey/37nxC
         3ZXFpLxUNWbhkv6eJ4zzvnT6/mZIJ8huuHHlnfGIRWkzOojm1+vGhy3n85WuH5+RiIPv
         fGZ8CnMjimMaaX3GpTxGNGZAw89gqmTVUt81nNF16leNwhU/puLiemzD6UxTx/H1oXG7
         tfk4LdZCQF3m6fyGLb2JAgowtjYICHpAgJZj7Hzs0Il8V4kdRDqluz8D4oMJul3iJTYT
         AQplg+L5rZdQVme3E1AE1ZhnXvGNk6+cwvBhNrnau0P+cmZCpC/8ufUVJgzRr+LL11/e
         mZ5g==
X-Gm-Message-State: AOJu0YxJS0gjddBGCi0TcONs5UNb66DsH4BFZ7ePRdFKE1uxsHPT7cMr
        v+VTY3VVlGZS7BHqUPa5mlpbv877oqE=
X-Google-Smtp-Source: AGHT+IHFoFimEGDoTmkaCumhUcPv87eOOfKEYOcQUGREBsSaMwdAyOsz2U8RVqikd7Hl5smjPCInDw==
X-Received: by 2002:ac8:5fce:0:b0:417:8f5b:f896 with SMTP id k14-20020ac85fce000000b004178f5bf896mr9702338qta.55.1695699312966;
        Mon, 25 Sep 2023 20:35:12 -0700 (PDT)
Received: from dw-tp ([49.207.223.191])
        by smtp.gmail.com with ESMTPSA id a13-20020a63704d000000b00578f1a71a91sm8662383pgn.79.2023.09.25.20.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 20:35:12 -0700 (PDT)
Date:   Tue, 26 Sep 2023 09:05:09 +0530
Message-Id: <87msx961zm.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Bobi Jam <bobijam@hotmail.com>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3] ext4: optimize metadata allocation for hybrid LUNs
In-Reply-To: <FFAD9C6B-B0A0-4CD3-BEE8-B62D702BBEC8@dilger.ca>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Andreas Dilger <adilger@dilger.ca> writes:

> On Sep 19, 2023, at 11:39 PM, Ritesh Harjani (IBM) <ritesh.list@gmail.com> wrote:
>> 
>> Bobi Jam <bobijam@hotmail.com> writes:
>> 
>>> With LVM it is possible to create an LV with SSD storage at the
>>> beginning of the LV and HDD storage at the end of the LV, and use that
>>> to separate ext4 metadata allocations (that need small random IOs)
>>> from data allocations (that are better suited for large sequential
>>> IOs) depending on the type of underlying storage.  Between 0.5-1.0% of
>>> the filesystem capacity would need to be high-IOPS storage in order to
>>> hold all of the internal metadata.
>>> 
>>> This would improve performance for inode and other metadata access,
>>> such as ls, find, e2fsck, and in general improve file access latency,
>>> modification, truncate, unlink, transaction commit, etc.
>>> 
>>> This patch split largest free order group lists and average fragment
>>> size lists into other two lists for IOPS/fast storage groups, and
>>> cr 0 / cr 1 group scanning for metadata block allocation in following
>>> order:
>>> 
>>> if (allocate metadata blocks)
>>>      if (cr == 0)
>>>              try to find group in largest free order IOPS group list
>>>      if (cr == 1)
>>>              try to find group in fragment size IOPS group list
>>>      if (above two find failed)
>>>              fall through normal group lists as before
>> 
>> Ok, so we are agreeing that if the iops groups are full, we will
>> fallback to non-iops group for metadata.
>> 
>> 
>>> if (allocate data blocks)
>>>      try to find group in normal group lists as before
>>>      if (failed to find group in normal group && mb_enable_iops_data)
>>>              try to find group in IOPS groups
>> 
>> same here but with mb_enable_iops_data.
>
> Hi Ritesh,
> thanks for your review.
>
> Yes, this is in the case of allocating data blocks.
>
>>> Non-metadata block allocation does not allocate from the IOPS groups
>>> if non-IOPS groups are not used up.
>> 
>> Sure. At least ENOSPC use case can be handled once mb_enable_iops_data
>> is enabled. (for users who might end up using large iops disk)
>> 
>>> Add for mke2fs an option to mark which blocks are in the IOPS region
>>> of storage at format time:
>>> 
>>>  -E iops=0-1024G,4096-8192G
>>> 
>>> so the ext4 mballoc code can then use the EXT4_BG_IOPS flag in the
>>> group descriptors to decide which groups to allocate dynamic
>>> filesystem metadata.
>>> 
>>> Signed-off-by: Bobi Jam <bobijam@hotmail.com
>>> 
>>> --
>>> v2->v3: add sysfs mb_enable_iops_data to enable data block allocation
>>>        from IOPS groups.
>>> v1->v2: for metadata block allocation, search in IOPS list then normal
>>>        list.
>>> ---
>>> 
>>> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
>>> index 8104a21b001a..a8f21f63f5ff 100644
>>> --- a/fs/ext4/ext4.h
>>> +++ b/fs/ext4/ext4.h
>>> @@ -382,6 +382,7 @@ struct flex_groups {
>>> #define EXT4_BG_INODE_UNINIT	0x0001 /* Inode table/bitmap not in use */
>>> #define EXT4_BG_BLOCK_UNINIT	0x0002 /* Block bitmap not in use */
>>> #define EXT4_BG_INODE_ZEROED	0x0004 /* On-disk itable initialized to zero */
>>> +#define EXT4_BG_IOPS		0x0010 /* In IOPS/fast storage */
>> 
>> Not related to this patch. But why not 0x0008? Is it reserved for
>> anything else?
>
> That is being used by the patches to add persistent TRIM support:
>
> +#define EXT4_BG_TRIMMED		0x0008 /* block group was trimmed */
>
> https://patchwork.ozlabs.org/project/linux-ext4/patch/20230829054309.684530-1-dongyangli@ddn.com/ ("[V2] e2fsprogs: support EXT2_FLAG_BG_TRIMMED and EXT2_FLAGS_TRACK_TRIM")
> https://patchwork.ozlabs.org/project/linux-ext4/patch/20230817003504.458920-1-dongyangli@ddn.com/ ("[V2] ext4: introduce EXT4_BG_TRIMMED to optimize fstrim")
>
>>> /*
>>>  * Macro-instructions used to manage group descriptors
>>> @@ -1112,6 +1113,8 @@ struct ext4_inode_info {
>>> #define EXT2_FLAGS_UNSIGNED_HASH	0x0002  /* Unsigned dirhash in use */
>>> #define EXT2_FLAGS_TEST_FILESYS		0x0004	/* to test development code */
>>> 
>>> +#define EXT2_FLAGS_HAS_IOPS		0x0080	/* has IOPS storage */
>>> +
>> 
>> same here. Are the flag values in between 0x0004 and 0x0080 are reserved?
>
> +#define EXT2_FLAGS_TRACK_TRIM		0x0008  /* Track trim status in bg */
>
> The 0x10/20/40 flags are reserved in e2fsprogs but are not used by ext4.
>

Thanks for the info on the flags part.

>>> @@ -1009,11 +1108,37 @@ static void ext4_mb_choose_next_group(struct ext4_allocation_context *ac,
>>> 		return;
>>> 	}
>>> 
>>> +	if (alloc_metadata && sbi->s_es->s_flags & EXT2_FLAGS_HAS_IOPS) {
>>> +		if (*new_cr == 0)
>>> +			ret = ext4_mb_choose_next_iops_group_cr0(ac, group);
>>> +		if (!ret && *new_cr < 2)
>>> +			ret = ext4_mb_choose_next_iops_group_cr1(ac, group);
>
> It looks like this patch is a bit stale since Ojaswin's renaming of the
> cr0/cr1 phases to "p2_aligned" and "goal_fast" and "best_avail" names.
>

Yup. We should rebase our development effort to latest tree.

>> This is a bit confusing here. Say if *new_cr = 0 fails, then we return
>> ret = false and fallback to choosing xx_iops_group_cr1(). And say if we
>> were able to find a group which satisfies this allocation request we
>> return. But the caller never knows that we allocated using cr1 and not
>> cr0. Because we never updated *new_cr inside xx_iops_group_crX()
>
> I guess it is a bit messy, since updating new_cr might interfere with the
> use of new_cr in the fallthrough to the non-IOPS groups below? In the
> "1% IOPS groups" case, doing this extra scan for metadata blocks should
> be very fast, since the metadata allocations are almost always one block
> (excluding large xattrs), so the only time this would fail is if no IOPS
> blocks are free, in which case it is fast since the group lists are empty.
>

What I was suggesting was we never update *new_cr value when we were
able to find a suitable group. That will confuse the two for loops we
have in the caller. We might as well just update the *new_cr value once
we have identified a suitable group in cr0 or cr1 before returning.

> We _could_ have a separate (in effect) cr0_3 and cr0_6 phases before the
> non-IOPS group allocation starts to be able to distinguish these cases
> (i.e. skip IOPS group scans if they are full) and the fallthrough search
> is also having trouble to find a single free block for the metadata, but
> I think that is pretty unlikely.
>
>> 
>>> +		if (ret)
>>> +			return;
>>> +		/*
>>> +		 * Cannot get metadata group from IOPS storage, fall through
>>> +		 * to slow storage.
>>> +		 */
>>> +		cond_resched();
>> 
>> Not sure after you fix above case, do we still require cond_resched()
>> here. Note we already have one in the for loop which iterates over all
>> the groups for a given ac_criteria.
>
> The cond_resched() was here because it calls two "choose_next_groups()"
> functions above without returning to the outer loop.  However, you are
> right that the group search is probably not the CPU heavy part here, so
> this could probably be dropped?
>

Sure make sense. Since for iops group scanning we look into both cr0 &
cr1 and then we fallback to non-iops group, so we may as well keep it. 

>>> +	}
>>> +
>>> 	if (*new_cr == 0) {
>>> 		ext4_mb_choose_next_group_cr0(ac, new_cr, group, ngroups);
>>> 	} else if (*new_cr == 1) {
>>> 		ext4_mb_choose_next_group_cr1(ac, new_cr, group, ngroups);
>>> 	} else {
>>> +		/*
>>> +		 * Cannot get data group from slow storage, try IOPS storage
>>> +		 */
>>> +		if (sbi->s_es->s_flags & EXT2_FLAGS_HAS_IOPS &&
>>> +		    !alloc_metadata && sbi->s_mb_enable_iops_data &&
>>> +		    *new_cr == 3) {
>>> +			if (ac->ac_2order)
>>> +				ret = ext4_mb_choose_next_iops_group_cr0(ac,
>>> +									 group);
>>> +			if (!ret)
>>> +				ext4_mb_choose_next_iops_group_cr1(ac, group);
>>> +		}
>> 
>> We might never come here in this else case because
>> should_optimize_scan() which we check in the beginning of this function
>> will return 0 and we will chose a next linear group for CR >= 2.
>
> Hmm, you are right.  Just off the bottom of this hunk is a "WARN_ON(1)"
> that this code block should never be entered.

right.

>
> Really, the fallback to IOPS groups for regular files should only happen
> in case of if *new_cr >= CR_GOAL_ANY_FREE.  We don't want "normal" block
> allocation to fill up the IOPS groups just because the filesystem is
> fragmented and low on space, but only if out of non-IOPS space.
>

Sure, I have added some comments later on this policy part...

>>> 		/*
>>> 		 * TODO: For CR=2, we can arrange groups in an rb tree sorted by
>>> 		 * bb_free. But until that happens, we should never come here.
>>> @@ -1030,6 +1155,8 @@ static void
>>> mb_set_largest_free_order(struct super_block *sb, struct ext4_group_info *grp)
>>> {
>>> 	struct ext4_sb_info *sbi = EXT4_SB(sb);
>>> +	rwlock_t *lfo_locks;
>>> +	struct list_head *lfo_list;
>>> 	int i;
>>> 
>>> 	for (i = MB_NUM_ORDERS(sb) - 1; i >= 0; i--)
>>> @@ -1042,21 +1169,25 @@ mb_set_largest_free_order(struct super_block *sb, struct ext4_group_info *grp)
>>> 		return;
>>> 	}
>>> 
>>> +	if (sbi->s_es->s_flags & EXT2_FLAGS_HAS_IOPS &&
>>> +	    EXT4_MB_GRP_TEST_IOPS(grp)) {
>>> +		lfo_locks = sbi->s_largest_free_orders_locks_iops;
>>> +		lfo_list = sbi->s_largest_free_orders_list_iops;
>>> +	} else {
>>> +		lfo_locks = sbi->s_mb_largest_free_orders_locks;
>>> +		lfo_list = sbi->s_mb_largest_free_orders;
>>> +	}
>>> +
>>> 	if (grp->bb_largest_free_order >= 0) {
>>> -		write_lock(&sbi->s_mb_largest_free_orders_locks[
>>> -					      grp->bb_largest_free_order]);
>>> +		write_lock(&lfo_locks[grp->bb_largest_free_order]);
>>> 		list_del_init(&grp->bb_largest_free_order_node);
>>> -		write_unlock(&sbi->s_mb_largest_free_orders_locks[
>>> -					      grp->bb_largest_free_order]);
>>> +		write_unlock(&lfo_locks[grp->bb_largest_free_order]);
>>> 	}
>>> 	grp->bb_largest_free_order = i;
>>> 	if (grp->bb_largest_free_order >= 0 && grp->bb_free) {
>>> -		write_lock(&sbi->s_mb_largest_free_orders_locks[
>>> -					      grp->bb_largest_free_order]);
>>> -		list_add_tail(&grp->bb_largest_free_order_node,
>>> -		      &sbi->s_mb_largest_free_orders[grp->bb_largest_free_order]);
>>> -		write_unlock(&sbi->s_mb_largest_free_orders_locks[
>>> -					      grp->bb_largest_free_order]);
>>> +		write_lock(&lfo_locks[i]);
>>> +		list_add_tail(&grp->bb_largest_free_order_node, &lfo_list[i]);
>>> +		write_unlock(&lfo_locks[i]);
>>> 	}
>>> }
>>> 
>>> @@ -2498,6 +2629,10 @@ static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
>>> 		goto out;
>>> 	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(grp)))
>>> 		goto out;
>>> +	if (sbi->s_es->s_flags & EXT2_FLAGS_HAS_IOPS &&
>>> +	    (ac->ac_flags & EXT4_MB_HINT_DATA) && EXT4_MB_GRP_TEST_IOPS(grp) &&
>>> +	    !sbi->s_mb_enable_iops_data)
>>> +		goto out;
>> 
>> since we already have a grp information here. Then checking for s_flags
>> and is redundant here right?
>
> This is intended to stop regular data allocations in IOPS groups that are
> found by next_linear_group().

What I meant is EXT4_MB_GRP_TEST_IOPS(grp), will only be true when we
have sbi->s_es->s_flags & EXT2_FLAGS_HAS_IOPS as true right? 
So do we still need to keep both conditions here?.

>
> With the change to allow regular data to be allocated in IOPS groups,
> there might need to be an extra check added here to see what allocation
> phase this is.  Should we add *higher* CR_ phases above CR_ANY_FREE to
> allow distinguishing between IOPS->regular fallback and regular->IOPS
> fallback?
>
>
> It seems like most of the complexity/issues here have crept in since the
> addition of the fallback for regular data allocations in IOPS groups...
> I'm not sure if we want to defer that functionality to a separate patch,
> or if you have any suggestions on how to clarify this without adding a
> lot of complexity?
>

I agree that the separation is not clear. I think it would have been
better if we would have split that functionality in 2 separate patches. 
The 1st patch just adds the functionality that you intended i.e.

1. metadata allocations should happen via IOPS group and only if there
is no space left in IOPS group it will fallback to non-IOPS group. 
This 1st patch also have data allocations coming only from non-iops group.

and the second patch can have details of...
2. adding a knob which can allow users to fallback data allocations to IOPS group too.

If you think you would like to defer the second patch to later to avoid
the complexity, I am fine with that too. The reason is we should still
think upon what should be the fallback critera for that. Should we do it
when we absolutely have no space in non-IOPS group (cr >= CR_ANY_FREE)
or is it ok to fallback even earlier. I guess it will also depend upon
the information of how many groups are IOPS v/s non-IOPS.

I don't think we are keeping that information anywhere on disk right? 
(no. of IOPS v/s non-IOPS groups). That means we might have to do that
at runtime. Once we have that information, the filesystem can better
decide on when should the fallback happen.

So I agree, we need to more discussion and think it through. I guess Ted
was also suggesting the same on the call. Feel free to defer the
fallback of data allocations to non-IOPS group for a later time (If
we don't have a strong objection from others on this).

Thanks
-ritesh
