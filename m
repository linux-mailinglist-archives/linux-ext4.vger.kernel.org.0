Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBB877DE32
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Aug 2023 12:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243730AbjHPKKA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Aug 2023 06:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243732AbjHPKJe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Aug 2023 06:09:34 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B8DE3
        for <linux-ext4@vger.kernel.org>; Wed, 16 Aug 2023 03:09:32 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6887c3aac15so534110b3a.2
        for <linux-ext4@vger.kernel.org>; Wed, 16 Aug 2023 03:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692180571; x=1692785371;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sXMJQEoCc4hk0HZNb1uhVXwafZRVLZPgHSpvbsQMLvs=;
        b=P7M83prttWXiZUjw/+K3yezQZYMWYA+pHOuyqeDyaKp3glYcSJY3bSdD/UnKj+H82Q
         aCefNl5txW6vDR/6ffJ8b5DF6boYPLmVXLyR/eUurYZnV/IpANBhFRv27cAJFHpeM6/I
         T1fMtNheglwFtKiMkDpf2ohxdhwFC8BXmBLHqIHQkwk+yWNHbMtvvNhso8ub1zU/0qP/
         jwtwHw6Y4H+CeZpKjNEUVv9WoQM4qvuMlkgPIcw+7A/Oq+ejL+F8kbBEdnKK7gxK9dMK
         OMZ2i8Qq2ikCpIbRFgPHJI3Qw/Vtp9kHF5bciYnn7Csa4fPQb5714gi/N3s2v4pZVAzW
         zsxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692180571; x=1692785371;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sXMJQEoCc4hk0HZNb1uhVXwafZRVLZPgHSpvbsQMLvs=;
        b=F25uVVhVsyqQw/m1vrMQhAEIPhmEuW+0LTxPKrHNq+AECe/Vs/86NTh1jYCuHTMylq
         b85tu1j0dvhcu4GNNOC2WlWyPxpg+A4HHNtuvBd66mBpwV9Hz3KB5/F4mAxBVo4Ok/+T
         LVHOu18jbxVqNiKFkkiUt1LyAwvHWL5hjCwZaYt5g/gVSD/VW96JmuQxYjLPuDxNGn8f
         Kn9q3Tuaj47VV5nyP1i7MPiA4PWcbjc9f1sB6LShoROmInivKCt1oU3rvU0HU6zSqxJb
         kGl/IGeW7v0gLSl2Olwd3pcV1Mcj2uwRFBr4rbJDO4g0fWXG2lsLSjTPDZWKdxF2TKAR
         5jow==
X-Gm-Message-State: AOJu0YyDe2zq3ZFC9Ur7lfh9Zt8dG2CRvxUqk5pKf0yhvNkGvdg7GMuF
        8FJAOxiKWMknJACPJgPXgb68TRRp0q4=
X-Google-Smtp-Source: AGHT+IEohv9HMSbOje9eaun+oEDgLxPI2leg3Mc7uVbvE1i3rjwWfzNHHsr9iwLBdLyjXJIhkQuoIA==
X-Received: by 2002:a05:6a00:248e:b0:687:22ce:365f with SMTP id c14-20020a056a00248e00b0068722ce365fmr1925942pfv.29.1692180571204;
        Wed, 16 Aug 2023 03:09:31 -0700 (PDT)
Received: from dw-tp ([49.207.232.207])
        by smtp.gmail.com with ESMTPSA id n26-20020a638f1a000000b00565009a97f0sm11467027pgd.17.2023.08.16.03.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 03:09:30 -0700 (PDT)
Date:   Wed, 16 Aug 2023 15:39:21 +0530
Message-Id: <871qg347u6.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Bobi Jam <bobijam@hotmail.com>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/2] ext4: optimize metadata allocation for hybrid LUNs
In-Reply-To: <8AF0F706-B25F-4365-B9F2-8CA1BB336EC3@dilger.ca>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Andreas Dilger <adilger@dilger.ca> writes:

> On Aug 3, 2023, at 6:10 AM, Ritesh Harjani (IBM) <ritesh.list@gmail.com> wrote:
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
>>> cr 0 on largest free order IOPS group list
>>> cr 1 on average fragment size IOPS group list
>>> cr 0 on largest free order non-IOPS group list
>>> cr 1 on average fragment size non-IOPS group list
>>> cr >= 2 perform the linear search as before
>
> Hi Ritesh,
> thanks for the review and the discussion about the patch.
>
>> Yes. The implementation looks straight forward to me.
>> 
>
>>> Non-metadata block allocation does not allocate from the IOPS groups.
>>> 
>>> Add for mke2fs an option to mark which blocks are in the IOPS region
>>> of storage at format time:
>>> 
>>>  -E iops=0-1024G,4096-8192G
>> 
>
>> However few things to discuss here are -
>
> As Ted requested on the call, this should be done as two separate calls
> to the allocator, rather than embedding the policy in mballoc group
> selection itself.  Presumably this would be in ext4_mb_new_blocks()
> calling ext4_mb_regular_allocator() twice with different allocation
> flags (first with EXT4_MB_HINT_METADATA, then without, though I don't
> actually see this was used anywhere in the code before this patch?)
>
> Metadata allocations should try only IOPS groups on the first call,
> but would go through all allocation phases.  If IOPS allocation fails,
> then the allocator should do a full second pass to allocate from the
> non-IOPS groups. Non-metadata allocations would only allocate from
> non-IOPS groups.
>
>> 1. What happens when the hdd space for data gets fully exhausted? AFAICS,
>> the allocation for data blocks will still succeed, however we won't be
>> able to make use of optimized scanning any more. Because we search within
>> iops lists only when EXT4_MB_HINT_METADATA is set in ac->ac_flags.
>
> The intention for our usage is that data allocations should *only* come
> from the HDD region of the device, and *not* from the IOPS (flash) region
> of the device.  The IOPS region will be comparatively small (0.5-1.0% of
> the total device size) so using or not using this space will be mostly
> meaningless to the overall filesystem usage, especially with a 1-5%
> reserved blocks percentage that is the default for new filesystems.
>

Yes, but when we give this functionality to non-enterprise users,
everyone would like to take advantage of a faster performing ext4 using
1 ssd and few hdds or a smaller spare ssd and larger hdds. Then it could
be that the space of iops region might not strictly be less than 1-2%
and could be anywhere between 10-50% ;)  

Shouldn't we still support this class of usecase as well? ^^^ 
So if the HDD gets full then the allocation should fallback to ssd for
data blocks no?

Or we can have a policy knob i.e. fallback_data_to_iops_region_thresh.
So if the free space %age in the iops region is above 1% (can be changed
by user) then the data allocations can fallback to iops region if it is
unable to allocate data blocks from hdd region.

      echo %age_threshold > fallback_data_to_iops_region_thresh (default 1%)

        Fallback data allocations to iops region as long as we have free space
        %age of iops region above %age_threshold.

> As you mentioned on the call, it seems this is a defect in the current
> patch, that non-metadata allocations may eventually fall back to scan
> all block groups for free space including IOPS groups.  They need to
> explicitly skip groups that have the IOPS flags set.
>
>> 2. Similarly what happens when the ssd space for metadata gets full?
>> In this case we keep falling back to cr2 for allocation and we don't
>> utilize optimize_scanning to find the block groups from hdd space to
>> allocate from.
>
> In the case when the IOPS groups are full then the metadata allocations
> should fall back to using non-IOPS groups.  That avoids ENOSPC when the
> metadata space is accidentally formatted too small, or unexpected usage
> such as large xattrs or many directories are consuming more IOPS space.
>
>> 3. So it seems after a period of time, these iops lists can have block
>> groups belonging to differnt ssds. Could this cause the metadata
>> allocation of related inodes to come from different ssds.
>> Will this be optimal? Checking on this...
>>     ...On checking further on this, we start with a goal group and we
>> at least scan s_mb_max_linear_groups (4) linearly. So it's unlikely that
>> we frequently allocate metadata blocks from different SSDs.
>
> In our usage will typically be only a single IOPS region at the start of
> the device, but the ability to allow multiple IOPS regions was added for
> completeness and flexibility in the future (e.g. resize of filesystem).

I am interested in knowing what do you think will be challenges in
supporting resize with hybrid devices? Like if someone would like to add
an additional ssd and do a resize, do you think all later metadata
allocations can be fullfilled from this iops region?

And what happens when someone adds hdds to existing ssds.
I guess adding an hdd followed by resize operation can still allocate, bgdt, block/inode
bitmaps and inode tables etc for these block groups to sit on the resized hdd right. 
Are there any other challenges as well for such usecase? 


> In our case, the IOPS region would itself be RAIDed, so "different SSDs"
> is not really a concern.
>
>> 4. Ok looking into this, do we even require the iops lists for metadata
>> allocations? Do we allocate more than 1 blocks for metadata? If not then
>> maintaining these iops lists for metadata allocation isn't really
>> helpful. On the other hand it does make sense to maintain it when we
>> allow data allocations from these ssds when hdds gets full.
>
> I don't think we *need* to use the same mballoc code for IOPS allocation
> in most cases, though large xattr inode allocations should also be using
> the IOPS groups for allocating blocks, and these might be up to 64KB.
> I don't think that is actually implemented properly in this patch yet.
>
> Also, the mballoc list/array make it easy to find groups with free space
> in a full filesystem instead of having to scan for them, even if we
> don't need the full "allocate order-N" functionality.  Having one list
> of free groups or order-N lists doesn't make it more expensive (and it
> actually improves scalability to have multiple list heads).
>
> One of the future enhancements might be to allow small files (of some
> configurable size) to also be allocated from the IOPS groups, so it is
> probably easier IMHO to just stick with the same allocator for both.
>
>> 5. Did we run any benchmarks with this yet? What kind of gains we are
>> looking for? Do we have any numbers for this?
>
> We're working on that.  I just wanted to get the initial patches out for
> review sooner rather than later, both to get feedback on implementation
> (like this, thanks), and also to reserve the EXT4_BG_IOPS field so it
> doesn't get used in a conflicting manner.
>
>> 6. I couldn't stop but start to think of...
>> Should there also be a provision from the user to pass hot/cold data
>> types which we can use as a hint within the filesystem to allocate from
>> ssd v/s hdd? Does it even make sense to think in this direction?
>
> Yes, I also had the same idea, but then left it out of my email to avoid
> getting distracted from the initial goal.  There are a number of possible
> improvements that could be done with a mechanism like this:
> - have fast/slow regions within a single HDD (i.e. last 20% of spindle is
>   in "slow" region due to reduced linear velocity/bandwidth on inner tracks)
>   to avoid using the slow region unless the fast region is (mostly) full
> - have several regions across an HDD to *intentionally* allocate some
>   extents in the "slow" groups to reduce *peak* bandwidth but keep
>   *average* bandwidth higher as the disk becomes more full since there
>   would still be free space in the faster groups.
>

Interesting! 

> Cheers, Andreas
>

Thanks
-ritesh
