Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA567B20A3
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Sep 2023 17:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbjI1PMZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 28 Sep 2023 11:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbjI1PMY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 28 Sep 2023 11:12:24 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0095194
        for <linux-ext4@vger.kernel.org>; Thu, 28 Sep 2023 08:12:21 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SEW8Rb015419;
        Thu, 28 Sep 2023 15:12:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=DTVSBan3t6ULnpIcNz5+tJkTl7o4/A9Zr2byn4Wc3ZU=;
 b=GA86erQMC02+rDY2SxmuI+PXtBcOusO3f8o9XCM6a7CRM+jtLspvT/WmwPUExWcH3iet
 ERQrdDro0YY2gxEMu7rPhNrjFooSDvriFT9nYUS7T0sMa8dw5yZ3DeOGto61/4tS9Wyu
 lTrme+oyjQ/zJGxVAwecQFdGKFZViHTxjCDjjNYMsqA4yBrUGLimwA6mifkVATDuZT9j
 wnyXwck+hH5XMQTkg4TeCw6F4oXJSSYa7nuQP3Jc0iOZ0yY8r1kVl9gOsHaF6Zm9JLN4
 BY/eJl8OFOnhqBuHXVCkKgSGnWV6A5jmsuSOs6dB/JSrwISOzS1O5lSmrdnRvt0bSMUk oQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tdbathkkw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 15:12:17 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38SEWSo1017555;
        Thu, 28 Sep 2023 15:12:16 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tdbathkk9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 15:12:16 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38SDg6uA011010;
        Thu, 28 Sep 2023 15:12:15 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tabukw57r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 15:12:15 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38SFCDVn26542608
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 15:12:13 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 511AC20040;
        Thu, 28 Sep 2023 15:12:13 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5225220043;
        Thu, 28 Sep 2023 15:12:12 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.109.253.169])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu, 28 Sep 2023 15:12:12 +0000 (GMT)
Date:   Thu, 28 Sep 2023 20:42:09 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Andreas Dilger <adilger@dilger.ca>, Bobi Jam <bobijam@hotmail.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH v3] ext4: optimize metadata allocation for hybrid LUNs
Message-ID: <ZRWXyYhk+Im5cz4E@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <A97D434D-8276-42D4-8402-4BA38B504D4F@dilger.ca>
 <87a5t8gwlf.fsf@doe.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5t8gwlf.fsf@doe.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aW4uRx2Aik3RiCxqeG82JQ_8cy1mrIbB
X-Proofpoint-ORIG-GUID: G9CcvGtLifDySGLBWtHLY-4LluM_f47D
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_14,2023-09-28_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309280130
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Sep 27, 2023 at 08:18:28AM +0530, Ritesh Harjani wrote:
> Andreas Dilger <adilger@dilger.ca> writes:
> 
> > On Sep 25, 2023, at 9:35 PM, Ritesh Harjani (IBM) <ritesh.list@gmail.com> wrote:
> >> 
> >> Andreas Dilger <adilger@dilger.ca> writes:
> >> 
> >>> On Sep 19, 2023, at 11:39 PM, Ritesh Harjani (IBM) <ritesh.list@gmail.com> wrote:
> >>>> 
> >>>> Bobi Jam <bobijam@hotmail.com> writes:
> >>>> 
> >>>>> Non-metadata block allocation does not allocate from the IOPS groups
> >>>>> if non-IOPS groups are not used up.
> >>>> 
> >>>>> Add for mke2fs an option to mark which blocks are in the IOPS region
> >>>>> of storage at format time:
> >>>>> 
> >>>>> -E iops=0-1024G,4096-8192G
> >>>>> 
> >>>>> so the ext4 mballoc code can then use the EXT4_BG_IOPS flag in the
> >>>>> group descriptors to decide which groups to allocate dynamic
> >>>>> filesystem metadata.
> >>>>> 
> >>>>> Signed-off-by: Bobi Jam <bobijam@hotmail.com
> >>>>> 
> >>>>> --
> >>>>> v2->v3: add sysfs mb_enable_iops_data to enable data block allocation
> >>>>>       from IOPS groups.
> >>>>> v1->v2: for metadata block allocation, search in IOPS list then normal
> >>>>>       list.
> >>>>> ---
> >>>>> 
> >> 
> >>>>> @@ -1009,11 +1108,37 @@ static void ext4_mb_choose_next_group(struct ext4_allocation_context *ac,
> >>>>> 		return;
> >>>>> 	}
> >>>>> 
> >>>>> +	if (alloc_metadata && sbi->s_es->s_flags & EXT2_FLAGS_HAS_IOPS) {
> >>>>> +		if (*new_cr == 0)
> >>>>> +			ret = ext4_mb_choose_next_iops_group_cr0(ac, group);
> >>>>> +		if (!ret && *new_cr < 2)
> >>>>> +			ret = ext4_mb_choose_next_iops_group_cr1(ac, group);
> >>> 
> >>> It looks like this patch is a bit stale since Ojaswin's renaming of the
> >>> cr0/cr1 phases to "p2_aligned" and "goal_fast" and "best_avail" names.
> >>> 
> >> 
> >> Yup. We should rebase our development effort to latest tree.
> >> 
> >>>> This is a bit confusing here. Say if *new_cr = 0 fails, then we return
> >>>> ret = false and fallback to choosing xx_iops_group_cr1(). And say if we
> >>>> were able to find a group which satisfies this allocation request we
> >>>> return. But the caller never knows that we allocated using cr1 and not
> >>>> cr0. Because we never updated *new_cr inside xx_iops_group_crX()
> >>> 
> >>> I guess it is a bit messy, since updating new_cr might interfere with the
> >>> use of new_cr in the fallthrough to the non-IOPS groups below? In the
> >>> "1% IOPS groups" case, doing this extra scan for metadata blocks should
> >>> be very fast, since the metadata allocations are almost always one block
> >>> (excluding large xattrs), so the only time this would fail is if no IOPS
> >>> blocks are free, in which case it is fast since the group lists are empty.
> >>> 
> >> 
> >> What I was suggesting was we never update *new_cr value when we were
> >> able to find a suitable group. That will confuse the two for loops we
> >> have in the caller. We might as well just update the *new_cr value once
> >> we have identified a suitable group in cr0 or cr1 before returning.
> >> 
> >>> We _could_ have a separate (in effect) cr0_3 and cr0_6 phases before the
> >>> non-IOPS group allocation starts to be able to distinguish these cases
> >>> (i.e. skip IOPS group scans if they are full) and the fallthrough search
> >>> is also having trouble to find a single free block for the metadata, but
> >>> I think that is pretty unlikely.
> >
> > I'm not clear which option you prefer here?
> > - update *new_cr based on the scan in the IOPS groups (in which case the
> >   fallback to non-IOPS groups would start at a higher CR than necessary)
> 
> This obviously won't help, since it will even further slowdown the metdata
> allocations when the iops group becomes full.
> 
> 
> > - add new phases *before* CR_POWER2_ALIGNED, e.g. "CR_IOPS_POWER2_ALIGNED"
> >   "CR_IOPS_CR_GOAL_LEN_FAST" and "CR_IOPS_CR_GOAL_LEN_SLOW" to do either
> >   a fast scan or a slow scan on the IOPS groups, and then fall back to
> >   non-IOPS groups?  They would be skipped if no IOPS groups exist.
> >
> > The second option allows preserving the CR value across the loops, in case
> > the group returned is not suitable for some reason, without confusing whether
> > the lookup is being done for IOPS groups or not.  Also, it makes sense to
> > have a "SLOW" pass on the IOPS groups, instead of just "FAST", to ensure
> > that all of the IOPS groups have been tried.  This should be very rare
> > since most allocations (excluding xattrs) are only one block long.
> 
> So how about we add a scan_state to allocation criteria for iops v/s
> non-iops scanning. This way we don't add any new crs, but mballoc now
> does a stateful scan rather than stateless scan being done today.
> (because we now have two different type of groups to select, iops v/s
> non-iops).
> 
> We can add a function like....
>    ac->scan_state = ext4_mb_get_scan_state_policy()
> 
> ...before starting the scan.
> 
> For metadata allocations it will return IOPS_SCAN and for data
> allocations it can return NON_IOPS_SCAN (more policy decisions can be
> added later). This way we don't have to add extra CRs to the enum
> criteria. The allocation still happens using the same existing
> allocation criteria. If say the allocation using IOPS_SCAN for metadata
> fails, we can switch to NON_IOPS_SCAN & restart the scan from cr0 again.
> 
> We might also need to maintain some extra state or variable which tells us
> which previous scan_state failed to find a suitable group. But I
> will leave that as implementation details. It might be useful for data
> allocations where we might have a policy to start with either IOPS_SCAN
> or NON_IOPS_SCAN first. 
> 
> I believe this will be a simpler change rather than adding more crs.
> Problem in adding more crs at the beginning could be when we have to
> roll over from NON_IOPS criteria to IOPS allocation criteria. 
> 
> Thoughts?
> 

Hi Ritesh, Andreas.

So I'm not sure if I'm convinced with the way we are handling CRs in
current implementation. This changes the behavior of how other
ext4_mb_choose_*_cr0/1() functions work that is by updating the cr if we fail
to find a suitable group. The new functions instead return true or false
without updating the CR which, as Ritesh pointed out, leaves some
unhandled edge cases that could cause silent behavior changes.

I like the original way of handling CRs where the logic to update
the CR is mostly in the ext4_mb_choose_*_cr0/1() functions and I'd rather not
move it in the ext4_mb_choose_next_group() like in this patch.

That being said, @Andreas, my thoughts on the 2 ways you've proposed:

> > - update *new_cr based on the scan in the IOPS groups (in which case the
> >   fallback to non-IOPS groups would start at a higher CR than necessary)
> 

1 So the way I see it, each CR represents the algorithm
to find a good group rather than the data structures we use for them.
Hence, I feel that since the algo of CR0/1 remains the same whether its
IOPS or not, we should not add a new CR for IOPS.

> > - update *new_cr based on the scan in the IOPS groups (in which case the
> >   fallback to non-IOPS groups would start at a higher CR than necessary)

2. I would actually prefer this way of doing it. I think this is also
somewhat similar to how we were doing it in PATCH v1. We should keep
using the existing ext4_mb_choose_*_cr0/1() functions but update the CR
based on if its a metadata allocation or not.

I actually like Ritesh's proposal of using a scan state which will then
lead to our psuedo-code looking something like:

  ext4_mb_choose_next_group_cr0()
	  new_cr = 1
  ext4_mb_choose_next_group_cr1()
	  new_cr = 2
  /* cr 2 search in outer loop */
		if (not found in cr 2) {
		  if (ac->scan_state == IOPS_SCAN) {
			  ac->scan_state == NON_IOPS_SCAN;
			  new_cr = 0;
		  } else {
			  ac->scan_state == IOPS_SCAN;
			  new_cr = 0;
			}
			goto repeat;
		}

With the patch I was working on to shift CR2 to order list [1] and then
have a ext4_mb_choose_next_group_cr2() functions instead of using the
linear loop, we can then maintain an IOPS lists like we do for cr0/1
here and further simplify the above psuedo code for CR2.

[1]
https://lore.kernel.org/linux-ext4/cover.1693911548.git.ojaswin@linux.ibm.com/

(In the above discussion i used the older cr0/1/2 notation for
simplicity)

Also, I didn't completely understand this particular statement:

> in which case the fallback to non-IOPS groups would start at a higher
> CR than necessary

I think we can always reset the cr to 0 when we reach the end in IOPS
allocation right like in the psuedo code above, or am I missing
something? 

Regards,
ojaswin

> >
> > Ojaswin, do you have any input here?  You've been doing somework on the
> > mballoc code recently, and it would be good to get this aligned with what
> > you are doing/planning.
> >
> >>>>> 	if (*new_cr == 0) {
> >>>>> 		ext4_mb_choose_next_group_cr0(ac, new_cr, group, ngroups);
> >>>>> 	} else if (*new_cr == 1) {
> >>>>> 		ext4_mb_choose_next_group_cr1(ac, new_cr, group, ngroups);
> >>>>> 	} else {
> >>>>> +		/*
> >>>>> +		 * Cannot get data group from slow storage, try IOPS storage
> >>>>> +		 */
> >>>>> +		if (sbi->s_es->s_flags & EXT2_FLAGS_HAS_IOPS &&
> >>>>> +		    !alloc_metadata && sbi->s_mb_enable_iops_data &&
> >>>>> +		    *new_cr == 3) {
> >>>>> +			if (ac->ac_2order)
> >>>>> +				ret = ext4_mb_choose_next_iops_group_cr0(ac,
> >>>>> +									 group);
> >>>>> +			if (!ret)
> >>>>> +				ext4_mb_choose_next_iops_group_cr1(ac, group);
> >>>>> +		}
> >>>> 
> >>>> We might never come here in this else case because
> >>>> should_optimize_scan() which we check in the beginning of this function
> >>>> will return 0 and we will chose a next linear group for CR >= 2.
> >>> 
> >>> Hmm, you are right.  Just off the bottom of this hunk is a "WARN_ON(1)"
> >>> that this code block should never be entered.
> >> 
> >> right.
> >> 
> >>> 
> >>> Really, the fallback to IOPS groups for regular files should only happen
> >>> in case of if *new_cr >= CR_GOAL_ANY_FREE.  We don't want "normal" block
> >>> allocation to fill up the IOPS groups just because the filesystem is
> >>> fragmented and low on space, but only if out of non-IOPS space.
> >>> 
> >> 
> >> Sure, I have added some comments later on this policy part...
> >> 
> >>>>> 
> >>>>> @@ -2498,6 +2629,10 @@ static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
> >>>>> 		goto out;
> >>>>> 	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(grp)))
> >>>>> 		goto out;
> >>>>> +	if (sbi->s_es->s_flags & EXT2_FLAGS_HAS_IOPS &&
> >>>>> +	    (ac->ac_flags & EXT4_MB_HINT_DATA) && EXT4_MB_GRP_TEST_IOPS(grp) &&
> >>>>> +	    !sbi->s_mb_enable_iops_data)
> >>>>> +		goto out;
> >>>> 
> >>>> since we already have a grp information here. Then checking for s_flags
> >>>> and is redundant here right?
> >>> 
> >>> This is intended to stop regular data allocations in IOPS groups that are
> >>> found by next_linear_group().
> >> 
> >> What I meant is EXT4_MB_GRP_TEST_IOPS(grp), will only be true when we
> >> have sbi->s_es->s_flags & EXT2_FLAGS_HAS_IOPS as true right?
> >> So do we still need to keep both conditions here?
> >
> > Well, EXT2_FLAGS_HAS_IOPS determines whether this functionality is enabled
> > or not, while the GRP_TEST_IOPS check is for the individual group.  So if
> > the feature is totally disabled (no EXT2_FLAGS_HAS_IOPS) then the per-group
> > bit should be ignored.
> >
> 
> Ok, thanks for clarification.
> 
> >>> With the change to allow regular data to be allocated in IOPS groups,
> >>> there might need to be an extra check added here to see what allocation
> >>> phase this is.  Should we add *higher* CR_ phases above CR_ANY_FREE to
> >>> allow distinguishing between IOPS->regular fallback and regular->IOPS
> >>> fallback?
> >>> 
> >>> 
> >>> It seems like most of the complexity/issues here have crept in since the
> >>> addition of the fallback for regular data allocations in IOPS groups...
> >>> I'm not sure if we want to defer that functionality to a separate patch,
> >>> or if you have any suggestions on how to clarify this without adding a
> >>> lot of complexity?
> >> 
> >> I agree that the separation is not clear. I think it would have been
> >> better if we would have split that functionality in 2 separate patches.
> >> The 1st patch just adds the functionality that you intended i.e.
> >> 
> >> 1. metadata allocations should happen via IOPS group and only if there
> >> is no space left in IOPS group it will fallback to non-IOPS group.
> >> This 1st patch also have data allocations coming only from non-iops group.
> >> 
> >> and the second patch can have details of...
> >> 2. adding a knob which can allow users to fallback data allocations to IOPS group too.
> >
> > Sure, I would be happy with that.  My main goal is to reserve these flags
> > and get this feature working in a basic fashion, and then more elaborate
> > policy decisions can be added once there is a demand for it.
> >
> 
> Sure make sense.
> 
> >> If you think you would like to defer the second patch to later to avoid
> >> the complexity, I am fine with that too. The reason is we should still
> >> think upon what should be the fallback critera for that. Should we do it
> >> when we absolutely have no space in non-IOPS group (cr >= CR_ANY_FREE)
> >> or is it ok to fallback even earlier. I guess it will also depend upon
> >> the information of how many groups are IOPS v/s non-IOPS.
> >> 
> >> I don't think we are keeping that information anywhere on disk right?
> >> (no. of IOPS v/s non-IOPS groups). That means we might have to do that
> >> at runtime. Once we have that information, the filesystem can better
> >> decide on when should the fallback happen.
> >
> > Mount already scans all of the groups at mount to set the IOPS flags in
> > the in-memory group_info, so the count of IOPS groups vs. non-IOPS could
> > be easily determined, if there is a use for this.
> >
> 
> Yup.
> 
> 
> >> So I agree, we need to more discussion and think it through. I guess Ted
> >> was also suggesting the same on the call. Feel free to defer the
> >> fallback of data allocations to non-IOPS group for a later time (If
> >> we don't have a strong objection from others on this).
> >
> > Great, thanks for your review and feedback.
> 
> Thanks for helping with the queries.
> 
> -ritesh
