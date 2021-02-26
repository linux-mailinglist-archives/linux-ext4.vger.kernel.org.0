Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 174D7325C54
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Feb 2021 05:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhBZEHA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 25 Feb 2021 23:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhBZEG7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 25 Feb 2021 23:06:59 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688E5C061788
        for <linux-ext4@vger.kernel.org>; Thu, 25 Feb 2021 20:06:19 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id hs11so12511937ejc.1
        for <linux-ext4@vger.kernel.org>; Thu, 25 Feb 2021 20:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=csO8+FTNEiBS6OXoy+vCCK4/3Dnhy7bxDYawNlLxBJU=;
        b=R3WxFPOhRjvWz3DY+2v79w4vAI+A0MFQ51Xbf+TtnBP039nPz6uetDZw7PofRWHomG
         0uskmsj2A7yK5KBTy/uwFC0T0F5o+gl5qEmLNAFrUycH7VFvqBFY+KQtyuYFSxlJLVDT
         wDyKhe4v5vEUmpA/BBpFs34I3bNqmSaZIhGUjefCHqi4Us7CHk7N5tWNoeVsniYtenml
         PT6/e881HkgP4vTP2hGDYpd0iyXb3AHEUKZJ5tYE52fSZi6ty4SYk4+QL8F5SwDsM+4x
         voLEDdvAHNDZc1kj7ayQQRb3W2HShadIpldgYJJ4Px3ZZD9Xki3HaNurZ/TqwBWw2SiN
         phmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=csO8+FTNEiBS6OXoy+vCCK4/3Dnhy7bxDYawNlLxBJU=;
        b=cvjULE3ziuJgVncF46KeWG8r7JbWhp4aHesjuyeu0c30LKxDl+/QWXtIPomPZ1osiq
         niDJlKiZgOG4/9esNEjDc60krPGmCVSKO9PRaVgPtm+WSXtfntYk2PB+b/HFoNV/KmeN
         009HutI6bCNGn7xZLK3JuJ9Okj25pXnhOs/mXjnjQ91VUIauOiomxhqt9oJtG+E+okDQ
         Gu/cgY8SDlS0/+VvNd6eF9N1B32hEoaJqLtkEbRUbvk1CD8SeP5Bu5laIR/sph6VXBwp
         XaWAVmTwq1ibjKdrWKLDmQ0TWIc9xabPTUEgs2tPMf0gYr3uotqFruVa89THqhrRTKgl
         gl+A==
X-Gm-Message-State: AOAM533HHvq7tm/Qx6qAnvdNSoYp8qZaEjNbs8Gjb4Se7IalHmTzcM2Q
        hJQtf0fFejUY9Sm+yv5aiExCN2cG2MLIEYQTuOw=
X-Google-Smtp-Source: ABdhPJz7kkXk+yht15du3lNT7BrHpWhbf4C6uMv6kYFSbhWlvpaU3PVsplbt1UL+WFO6EFVQIIMNWW5IyVW+M95ka2E=
X-Received: by 2002:a17:906:c210:: with SMTP id d16mr1101341ejz.187.1614312378120;
 Thu, 25 Feb 2021 20:06:18 -0800 (PST)
MIME-Version: 1.0
References: <20210209202857.4185846-1-harshadshirwadkar@gmail.com>
 <20210209202857.4185846-5-harshadshirwadkar@gmail.com> <BF6E7BBD-794A-4C02-9219-A302956F7BFA@gmail.com>
 <7659F518-07CD-4F37-BB6D-FE53458985D6@dilger.ca> <CAD+ocbwCEKjrSAuv8EKWRwq-tXva+w4=VxDwFJ2N3-VLaevp9Q@mail.gmail.com>
 <E51E6ECE-469D-45A6-8255-2474CCF0A734@dilger.ca>
In-Reply-To: <E51E6ECE-469D-45A6-8255-2474CCF0A734@dilger.ca>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Thu, 25 Feb 2021 20:06:07 -0800
Message-ID: <CAD+ocbyV24pFH1xAacjOUXb6jnuDtxFNDXVp7CwB0hRMebQLVQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] ext4: improve cr 0 / cr 1 group scanning
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     =?UTF-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Alex Zhuravlev <bzzz@whamcloud.com>,
        Shuichi Ihara <sihara@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Andreas,

On Thu, Feb 25, 2021 at 7:43 PM Andreas Dilger <adilger@dilger.ca> wrote:
>
> On Feb 21, 2021, at 8:59 PM, harshad shirwadkar <harshadshirwadkar@gmail.com> wrote:
> >
> > Thank you for all the feedback Andreas and Artem. Some comments below:
>
> Thank you for working on this.  It is definitely an area that can use
> this improvement.
>
> >> I was wondering about the cost of the list/tree maintenance as well,
> >> especially since there was a post from "kernel test robot" that this
> >> patch introduced a performance regression.
> >
> > Yeah, I'm pretty sure that the kernel test robot is complaining mainly
> > because of list/tree maintenance. I think if this optimization is
> > turned off, we probably should not even maintain the tree / lists.
> > That has one downside that is that we will have to disallow setting
> > this option during remount, which I guess is okay?
>
> I think it is reasonable to not be able to change this at runtime.
> This would only make a difference for a limited number of testers,
> and virtually all users will never know it exists at all.
>
> >> It would also make sense for totally full groups to be kept out of the
> >> rb tree entirely, since they do not provide any value in that case (the
> >> full groups will never be selected for allocations), and they just add
> >> to the tree depth and potentially cause an imbalance if there are many
> >> of them.  That also has the benefit of the rbtree efficiency *improving*
> >> as the filesystem gets more full, which is right when it is most needed.
> >
> > Ack
> >
> >> It might also make sense to keep totally empty groups out of the rbtree,
> >> since they should always be found in cr0 already if the allocation is
> >> large enough to fill the whole group?  Having a smaller rbtree makes
> >> every insertion/removal that much more efficient.
> >
> > Ack
> >
> >> Those groups will naturally be re-added into the rbtree when they have
> >> blocks freed or allocated, so not much added complexity.
> >>
> >>
> >> Does it make sense to disable "mb_optimize_scan" if filesystems are
> >> smaller than a certain threshold?  Clearly, if there are only 1-2
> >> groups, maintaining a list and rbtree has no real value, and with
> >> only a handful of groups (< 16?) linear searching is probably as fast
> >> or faster than maintaining the two data structures.  That is similar
> >> to e.g. bubble sort vs. quicksort, where it is more efficient to sort
> >> a list of ~5-8 entries with a dumb/fast algorithm instead of a complex
> >> algorithm that is more efficient at larger scales.  That would also
> >> (likely) quiet the kernel test robot, if we think that its testing is
> >> not representative of real-world usage.
> >
> > Ack, these are good optimizations. I'll add these in V3.
>
> For testing purposes it should be possible to have "mb_optimize_scan=1"
> force the use of this option, even if the filesystem is small.
Ack
>
> > Besides the optimizations mentioned here, I also think we should add
> > "mb_optimize_linear_limit" or such sysfs tunable which will control
> > how many groups should mballoc search linearly before using tree /
> > lists for allocation? That would help us with the disk seek time
> > performance.
>
> There is already a linear search threshold parameters for mballoc,
> namely mb_min_to_scan and mb_max_to_scan that could be used for this.
> I think we could use "mb_min_to_scan=10" (the current default), or
> maybe shrink this a bit (4?) if "mb_optimize_scan" is enabled.
>
> > We discussed on our last call that we probably should consult with the
> > block device's request queue to check if the underlying block device
> > is rotational or not. However, we also discussed that for more complex
> > devices (such as DMs setup on top of HDD and SSD etc), whether the
> > device is rotational or not is not a binary answer and we would need a
> > more complex interface (such as logical range to "is_rotational"
> > table) to make intelligent choice in the file system. Also, in such
> > cases, it is not clear if such a table needs to be passed to the file
> > system during mkfs time? or at mount time? or at run time?
>
> I don't think the hybrid case is very important yet.  By far the
> most common case is going to be "rotational=1" or "rotational=0"
> for the whole device, so we should start by only optimizing for
> those cases.  DM looks like it returns "rotational=0" correctly
> when a composite device it is made of entirely non-rotational
> devices and "rotational=1" as it should when it is a hybrid
> HDD/SSD device (which I have in my local system).
Ack
>
> > Given the number of unknowns in the above discussion, I propose that
> > we start simple and evolve later. So my proposal is that we add a
> > "mb_optimize_linear_limit" tunable that accepts an integer value. In
> > the kernel, for non-rotational devices, that value will be defaulted
> > to 0 (which means no linear scan) and for rotational devices, that
> > value will be defaulted to a reasonable value (-- not sure what that
> > value would be though - 4?). This default can be overridden using the
> > sysfs interface. We can later evolve this interface to accept more
> > complex input such as logical range to rotational status.
> >
> > Does that sound reasonable?
>
> Yes, modulo using the existing "mb_min_to_scan" parameter for this.
> I think 4 or 8 or 10 groups is reasonable (512MB, 1GB, 1.25GB),
> since if it needs a seek anyway then we may as well find a good
> group for this.
If I understand it right, the meaning of mb_min_to_scan is the number
of *extents* that the allocator should try to find before choosing the
best one. However, what we want here is the number of *groups* that
the allocator should travel linearly before trying to optimize the
search. So, even if mb_min_to_scan is set to 1, by the current
definition of it, it means that the allocator may still traverse the
entire file system if it doesn't find a match. Is my understanding
right?

Thanks,
Harshad
>
> Cheers, Andreas
>
> >
> >>
> >>> On Feb 11, 2021, at 3:30 AM, Andreas Dilger <adilger@dilger.ca> wrote:
> >>
> >>>> This function would be more efficient to do the list move under a single
> >>>> write lock if the order doesn't change.  The order loop would just
> >>>> save the largest free order, then grab the write lock, do the list_del(),
> >>>> set bb_largest_free_order, and list_add_tail():
> >>>>
> >>>> mb_set_largest_free_order(struct super_block *sb, struct ext4_group_info *grp)
> >>>> {
> >>>>     struct ext4_sb_info *sbi = EXT4_SB(sb);
> >>>>     int i, new_order = -1;
> >>>>
> >>>>     for (i = MB_NUM_ORDERS(sb) - 1; i >= 0; i--) {
> >>>>             if (grp->bb_counters[i] > 0) {
> >>>>                     new_order = i;
> >>>>                     break;
> >>>>             }
> >>>>     }
> >>>>     if (test_opt2(sb, MB_OPTIMIZE_SCAN) && grp->bb_largest_free_order >= 0) {
> >>>>             write_lock(&sbi->s_mb_largest_free_orders_locks[
> >>>>                                           grp->bb_largest_free_order]);
> >>>>             list_del_init(&grp->bb_largest_free_order_node);
> >>>>
> >>>>             if (new_order != grp->bb_largest_free_order) {
> >>>>                     write_unlock(&sbi->s_mb_largest_free_orders_locks[
> >>>>                                           grp->bb_largest_free_order]);
> >>>>                     grp->bb_largest_free_order = new_order;
> >>>>                     write_lock(&sbi->s_mb_largest_free_orders_locks[
> >>>>                                           grp->bb_largest_free_order]);
> >>>>             }
> >>>>             list_add_tail(&grp->bb_largest_free_order_node,
> >>>>                   &sbi->s_mb_largest_free_orders[grp->bb_largest_free_order]);
> >>>>             write_unlock(&sbi->s_mb_largest_free_orders_locks[
> >>>>                                           grp->bb_largest_free_order]);
> >>>>     }
> >>>> }
> >>
> >> In looking at my previous comment, I wonder if we could further reduce
> >> the list locking here by not moving an entry to the end of the *same*
> >> list if it is not currently at the head?  Since it was (presumably)
> >> just moved to the end of the list by a recent allocation, it is very
> >> likely that some other group will be chosen from the list head, so
> >> moving within the list to maintain strict LRU is probably just extra
> >> locking overhead that can be avoided...
> >>
> >> Also, it isn't clear if *freeing* blocks from a group should move it
> >> to the end of the same list, or just leave it as-is?  If there are
> >> more frees from the list it is likely to be added to a new list soon,
> >> and if there are no more frees, then it could stay in the same order.
> >>
> >>
> >> Cheers, Andreas
> >>
> >>
> >>
> >>
> >>
>
>
> Cheers, Andreas
>
>
>
>
>
