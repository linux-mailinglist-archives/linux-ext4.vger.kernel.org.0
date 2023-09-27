Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C977AF899
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Sep 2023 05:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjI0DZd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 26 Sep 2023 23:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjI0DXd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 26 Sep 2023 23:23:33 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C3119B4
        for <linux-ext4@vger.kernel.org>; Tue, 26 Sep 2023 19:48:40 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c60f1a2652so45168915ad.0
        for <linux-ext4@vger.kernel.org>; Tue, 26 Sep 2023 19:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695782919; x=1696387719; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uKQDSslPMvpWDOGNZlp6gy5+lBzDMfPL9JFA+IHTlDA=;
        b=Z5J1X7HaAuoQdy9YNC8RwvfBP0lHui7+JCdlL2M3ChGYavaVHifVtBIQtoKh/ERo+4
         91v/q8rViEyjcc9rThyIzJ/MBjXPM7vH9dWIMM9zhb8vthocxwznd+VOBTn48fISgupj
         72q9RFOISZoSYEZ3lRrIN36xRwcyfw6MKNZjXUgYu6JpFAO/TvQRmPPO9iLm3YrS2i6Y
         FsPYG66or11ojY14hsrF9THhKg0ggEGr0o4NHrqHh0b9gPFx0K5H4sQxkzurbIv7qXkt
         u1J8yfhg/pGmP6/vTWMgmEO9350nonudbT5Crw+3uvzYeF3C2GmnLd6/Y7UGvXusW0OJ
         2PeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695782919; x=1696387719;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uKQDSslPMvpWDOGNZlp6gy5+lBzDMfPL9JFA+IHTlDA=;
        b=ZyXbDVGIpyJuwvLi+V0pI8QCb5Vr10qy1GXDsb1rkrgZWFrTms+E2OicNGpWTYM4i+
         v6SCE+YT5jUOEKBCilKYO4E0FA/Iy4rpwRC0f9cLxSHhP1oV2N1ybH85HK+6JMnpVDvF
         6t7Im4rszA0VjUXyNsPcb4pAZ2cNP1W1fWCIMjju+kY/aOIyP6DOCikmgurYGxpr1lP0
         ltvNoOUOhz6orYEnTsDO2fJUul8xKdF0Nj882mdVUXJByAq7Fpw96ET+I7VSnA16l5w7
         e65/yeeFCkDcwMj9CelvK9QgRx/oGfkwVkzAG8oCdL06RHKbiQlGVBzv0+vVDBNaxOJ/
         voSQ==
X-Gm-Message-State: AOJu0YzZafoqs0hiRo34EPquePPV6ltbNBXBIle0wCimFVC6hDqHgAuk
        6Hq6vugTXhWszH3yQqBvLgndBiRx//U=
X-Google-Smtp-Source: AGHT+IH8o3KUuJOKaxxvagan+mPjTPQN9r0rF+t6TTb4vMoTfmqjSUUkVfClENUIa10HXnD86wQJnQ==
X-Received: by 2002:a17:903:2309:b0:1b4:5699:aac1 with SMTP id d9-20020a170903230900b001b45699aac1mr1082797plh.12.1695782918683;
        Tue, 26 Sep 2023 19:48:38 -0700 (PDT)
Received: from dw-tp ([49.207.223.191])
        by smtp.gmail.com with ESMTPSA id jj19-20020a170903049300b001b9d7c8f44dsm2607213plb.182.2023.09.26.19.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 19:48:37 -0700 (PDT)
Date:   Wed, 27 Sep 2023 08:18:28 +0530
Message-Id: <87a5t8gwlf.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Andreas Dilger <adilger@dilger.ca>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     Bobi Jam <bobijam@hotmail.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH v3] ext4: optimize metadata allocation for hybrid LUNs
In-Reply-To: <A97D434D-8276-42D4-8402-4BA38B504D4F@dilger.ca>
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

> On Sep 25, 2023, at 9:35 PM, Ritesh Harjani (IBM) <ritesh.list@gmail.com> wrote:
>> 
>> Andreas Dilger <adilger@dilger.ca> writes:
>> 
>>> On Sep 19, 2023, at 11:39 PM, Ritesh Harjani (IBM) <ritesh.list@gmail.com> wrote:
>>>> 
>>>> Bobi Jam <bobijam@hotmail.com> writes:
>>>> 
>>>>> Non-metadata block allocation does not allocate from the IOPS groups
>>>>> if non-IOPS groups are not used up.
>>>> 
>>>>> Add for mke2fs an option to mark which blocks are in the IOPS region
>>>>> of storage at format time:
>>>>> 
>>>>> -E iops=0-1024G,4096-8192G
>>>>> 
>>>>> so the ext4 mballoc code can then use the EXT4_BG_IOPS flag in the
>>>>> group descriptors to decide which groups to allocate dynamic
>>>>> filesystem metadata.
>>>>> 
>>>>> Signed-off-by: Bobi Jam <bobijam@hotmail.com
>>>>> 
>>>>> --
>>>>> v2->v3: add sysfs mb_enable_iops_data to enable data block allocation
>>>>>       from IOPS groups.
>>>>> v1->v2: for metadata block allocation, search in IOPS list then normal
>>>>>       list.
>>>>> ---
>>>>> 
>> 
>>>>> @@ -1009,11 +1108,37 @@ static void ext4_mb_choose_next_group(struct ext4_allocation_context *ac,
>>>>> 		return;
>>>>> 	}
>>>>> 
>>>>> +	if (alloc_metadata && sbi->s_es->s_flags & EXT2_FLAGS_HAS_IOPS) {
>>>>> +		if (*new_cr == 0)
>>>>> +			ret = ext4_mb_choose_next_iops_group_cr0(ac, group);
>>>>> +		if (!ret && *new_cr < 2)
>>>>> +			ret = ext4_mb_choose_next_iops_group_cr1(ac, group);
>>> 
>>> It looks like this patch is a bit stale since Ojaswin's renaming of the
>>> cr0/cr1 phases to "p2_aligned" and "goal_fast" and "best_avail" names.
>>> 
>> 
>> Yup. We should rebase our development effort to latest tree.
>> 
>>>> This is a bit confusing here. Say if *new_cr = 0 fails, then we return
>>>> ret = false and fallback to choosing xx_iops_group_cr1(). And say if we
>>>> were able to find a group which satisfies this allocation request we
>>>> return. But the caller never knows that we allocated using cr1 and not
>>>> cr0. Because we never updated *new_cr inside xx_iops_group_crX()
>>> 
>>> I guess it is a bit messy, since updating new_cr might interfere with the
>>> use of new_cr in the fallthrough to the non-IOPS groups below? In the
>>> "1% IOPS groups" case, doing this extra scan for metadata blocks should
>>> be very fast, since the metadata allocations are almost always one block
>>> (excluding large xattrs), so the only time this would fail is if no IOPS
>>> blocks are free, in which case it is fast since the group lists are empty.
>>> 
>> 
>> What I was suggesting was we never update *new_cr value when we were
>> able to find a suitable group. That will confuse the two for loops we
>> have in the caller. We might as well just update the *new_cr value once
>> we have identified a suitable group in cr0 or cr1 before returning.
>> 
>>> We _could_ have a separate (in effect) cr0_3 and cr0_6 phases before the
>>> non-IOPS group allocation starts to be able to distinguish these cases
>>> (i.e. skip IOPS group scans if they are full) and the fallthrough search
>>> is also having trouble to find a single free block for the metadata, but
>>> I think that is pretty unlikely.
>
> I'm not clear which option you prefer here?
> - update *new_cr based on the scan in the IOPS groups (in which case the
>   fallback to non-IOPS groups would start at a higher CR than necessary)

This obviously won't help, since it will even further slowdown the metdata
allocations when the iops group becomes full.


> - add new phases *before* CR_POWER2_ALIGNED, e.g. "CR_IOPS_POWER2_ALIGNED"
>   "CR_IOPS_CR_GOAL_LEN_FAST" and "CR_IOPS_CR_GOAL_LEN_SLOW" to do either
>   a fast scan or a slow scan on the IOPS groups, and then fall back to
>   non-IOPS groups?  They would be skipped if no IOPS groups exist.
>
> The second option allows preserving the CR value across the loops, in case
> the group returned is not suitable for some reason, without confusing whether
> the lookup is being done for IOPS groups or not.  Also, it makes sense to
> have a "SLOW" pass on the IOPS groups, instead of just "FAST", to ensure
> that all of the IOPS groups have been tried.  This should be very rare
> since most allocations (excluding xattrs) are only one block long.

So how about we add a scan_state to allocation criteria for iops v/s
non-iops scanning. This way we don't add any new crs, but mballoc now
does a stateful scan rather than stateless scan being done today.
(because we now have two different type of groups to select, iops v/s
non-iops).

We can add a function like....
   ac->scan_state = ext4_mb_get_scan_state_policy()

...before starting the scan.

For metadata allocations it will return IOPS_SCAN and for data
allocations it can return NON_IOPS_SCAN (more policy decisions can be
added later). This way we don't have to add extra CRs to the enum
criteria. The allocation still happens using the same existing
allocation criteria. If say the allocation using IOPS_SCAN for metadata
fails, we can switch to NON_IOPS_SCAN & restart the scan from cr0 again.

We might also need to maintain some extra state or variable which tells us
which previous scan_state failed to find a suitable group. But I
will leave that as implementation details. It might be useful for data
allocations where we might have a policy to start with either IOPS_SCAN
or NON_IOPS_SCAN first. 

I believe this will be a simpler change rather than adding more crs.
Problem in adding more crs at the beginning could be when we have to
roll over from NON_IOPS criteria to IOPS allocation criteria. 

Thoughts?

>
> Ojaswin, do you have any input here?  You've been doing somework on the
> mballoc code recently, and it would be good to get this aligned with what
> you are doing/planning.
>
>>>>> 	if (*new_cr == 0) {
>>>>> 		ext4_mb_choose_next_group_cr0(ac, new_cr, group, ngroups);
>>>>> 	} else if (*new_cr == 1) {
>>>>> 		ext4_mb_choose_next_group_cr1(ac, new_cr, group, ngroups);
>>>>> 	} else {
>>>>> +		/*
>>>>> +		 * Cannot get data group from slow storage, try IOPS storage
>>>>> +		 */
>>>>> +		if (sbi->s_es->s_flags & EXT2_FLAGS_HAS_IOPS &&
>>>>> +		    !alloc_metadata && sbi->s_mb_enable_iops_data &&
>>>>> +		    *new_cr == 3) {
>>>>> +			if (ac->ac_2order)
>>>>> +				ret = ext4_mb_choose_next_iops_group_cr0(ac,
>>>>> +									 group);
>>>>> +			if (!ret)
>>>>> +				ext4_mb_choose_next_iops_group_cr1(ac, group);
>>>>> +		}
>>>> 
>>>> We might never come here in this else case because
>>>> should_optimize_scan() which we check in the beginning of this function
>>>> will return 0 and we will chose a next linear group for CR >= 2.
>>> 
>>> Hmm, you are right.  Just off the bottom of this hunk is a "WARN_ON(1)"
>>> that this code block should never be entered.
>> 
>> right.
>> 
>>> 
>>> Really, the fallback to IOPS groups for regular files should only happen
>>> in case of if *new_cr >= CR_GOAL_ANY_FREE.  We don't want "normal" block
>>> allocation to fill up the IOPS groups just because the filesystem is
>>> fragmented and low on space, but only if out of non-IOPS space.
>>> 
>> 
>> Sure, I have added some comments later on this policy part...
>> 
>>>>> 
>>>>> @@ -2498,6 +2629,10 @@ static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
>>>>> 		goto out;
>>>>> 	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(grp)))
>>>>> 		goto out;
>>>>> +	if (sbi->s_es->s_flags & EXT2_FLAGS_HAS_IOPS &&
>>>>> +	    (ac->ac_flags & EXT4_MB_HINT_DATA) && EXT4_MB_GRP_TEST_IOPS(grp) &&
>>>>> +	    !sbi->s_mb_enable_iops_data)
>>>>> +		goto out;
>>>> 
>>>> since we already have a grp information here. Then checking for s_flags
>>>> and is redundant here right?
>>> 
>>> This is intended to stop regular data allocations in IOPS groups that are
>>> found by next_linear_group().
>> 
>> What I meant is EXT4_MB_GRP_TEST_IOPS(grp), will only be true when we
>> have sbi->s_es->s_flags & EXT2_FLAGS_HAS_IOPS as true right?
>> So do we still need to keep both conditions here?
>
> Well, EXT2_FLAGS_HAS_IOPS determines whether this functionality is enabled
> or not, while the GRP_TEST_IOPS check is for the individual group.  So if
> the feature is totally disabled (no EXT2_FLAGS_HAS_IOPS) then the per-group
> bit should be ignored.
>

Ok, thanks for clarification.

>>> With the change to allow regular data to be allocated in IOPS groups,
>>> there might need to be an extra check added here to see what allocation
>>> phase this is.  Should we add *higher* CR_ phases above CR_ANY_FREE to
>>> allow distinguishing between IOPS->regular fallback and regular->IOPS
>>> fallback?
>>> 
>>> 
>>> It seems like most of the complexity/issues here have crept in since the
>>> addition of the fallback for regular data allocations in IOPS groups...
>>> I'm not sure if we want to defer that functionality to a separate patch,
>>> or if you have any suggestions on how to clarify this without adding a
>>> lot of complexity?
>> 
>> I agree that the separation is not clear. I think it would have been
>> better if we would have split that functionality in 2 separate patches.
>> The 1st patch just adds the functionality that you intended i.e.
>> 
>> 1. metadata allocations should happen via IOPS group and only if there
>> is no space left in IOPS group it will fallback to non-IOPS group.
>> This 1st patch also have data allocations coming only from non-iops group.
>> 
>> and the second patch can have details of...
>> 2. adding a knob which can allow users to fallback data allocations to IOPS group too.
>
> Sure, I would be happy with that.  My main goal is to reserve these flags
> and get this feature working in a basic fashion, and then more elaborate
> policy decisions can be added once there is a demand for it.
>

Sure make sense.

>> If you think you would like to defer the second patch to later to avoid
>> the complexity, I am fine with that too. The reason is we should still
>> think upon what should be the fallback critera for that. Should we do it
>> when we absolutely have no space in non-IOPS group (cr >= CR_ANY_FREE)
>> or is it ok to fallback even earlier. I guess it will also depend upon
>> the information of how many groups are IOPS v/s non-IOPS.
>> 
>> I don't think we are keeping that information anywhere on disk right?
>> (no. of IOPS v/s non-IOPS groups). That means we might have to do that
>> at runtime. Once we have that information, the filesystem can better
>> decide on when should the fallback happen.
>
> Mount already scans all of the groups at mount to set the IOPS flags in
> the in-memory group_info, so the count of IOPS groups vs. non-IOPS could
> be easily determined, if there is a use for this.
>

Yup.


>> So I agree, we need to more discussion and think it through. I guess Ted
>> was also suggesting the same on the call. Feel free to defer the
>> fallback of data allocations to non-IOPS group for a later time (If
>> we don't have a strong objection from others on this).
>
> Great, thanks for your review and feedback.

Thanks for helping with the queries.

-ritesh
