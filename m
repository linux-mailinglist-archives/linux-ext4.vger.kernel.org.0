Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D10320FEA
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Feb 2021 05:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbhBVEAQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 21 Feb 2021 23:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbhBVEAP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 21 Feb 2021 23:00:15 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E39C061574
        for <linux-ext4@vger.kernel.org>; Sun, 21 Feb 2021 19:59:34 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id t11so26946600ejx.6
        for <linux-ext4@vger.kernel.org>; Sun, 21 Feb 2021 19:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r0kLs+AFPmQl7zJbX9+t0c5hMsso6BkSlYALFsByTKY=;
        b=RtUJSkzvprZe2p9b41bvvNPv+UWITEkp7p6fG+YtTW05Xnqmi7bDTznogZp72RHoKr
         UdUOijWGhyZqTgZzNAhDvd7UrhERryBnXYKwDQkWQN7hp7ixjgj51ylQGUCR7ab6KsaN
         T8DN8JnE99/BxQ4vuaowf3UEVmCw+KCuzE2EbZItK+bZBEWhw59cfdmoq5daqQCMJbtr
         siEdeomPpz4ybG94F4gUcrZ8OBaGtJDC5/aZD0/N5N6IHzfNUwBEChS5oV6A/0QKdyZW
         WtaYZ3OLtozRy0pu3qh04E46pgy4Ll2Ept8B6Oux+dco7o091lQ2gFTwPsDa0opkb/7I
         4wdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r0kLs+AFPmQl7zJbX9+t0c5hMsso6BkSlYALFsByTKY=;
        b=rYF5TGSVjEDrbOYIziX3ltKCGWRXSOQSa2tEfxNjEY6ewsEKNkOINGkFjePibLMxVS
         EfL+sXva4i6ZrpfhBe6KwjCCK2K/cL+6B34FfHBLfE0zxBeSTGurtPbiwZuPFcyXOU7C
         PzdDuQHwx+nRpsykGhUJKgnEu7bM23yWEJYqjLdmmmktl7HaDDHG8uoYPGtjW42yGpOZ
         VqHLON1P/zFlmayMrwuz78/uqriHWUtOaV/Uau21An8AQmJGkMnDZqD+UTYH86t+eULA
         kWCfY1cMNWLwI8N95MciFlPs8znh0O7UoLRfkHsr8lz9i1Kw9hdeNhyeU1MsRFM/XhBZ
         c9Hg==
X-Gm-Message-State: AOAM532aBw+wwtObUgsTphczdTTJdxdO4G88pPGDhNcmREun7y+BcgVT
        42QSEqyU+Dt7zdbjWzRaoyZnoZr0JwN3eDjanLs=
X-Google-Smtp-Source: ABdhPJwdZJBeB8jAVKtY3Md2DaxxXWi2dGkjHs9Ce4DQiqGQ13fCxCfKYVY2u8YOuQVNWIeFLy0RuWkmpvjRNsyPrng=
X-Received: by 2002:a17:907:948d:: with SMTP id dm13mr18725437ejc.545.1613966373400;
 Sun, 21 Feb 2021 19:59:33 -0800 (PST)
MIME-Version: 1.0
References: <20210209202857.4185846-1-harshadshirwadkar@gmail.com>
 <20210209202857.4185846-5-harshadshirwadkar@gmail.com> <BF6E7BBD-794A-4C02-9219-A302956F7BFA@gmail.com>
 <7659F518-07CD-4F37-BB6D-FE53458985D6@dilger.ca>
In-Reply-To: <7659F518-07CD-4F37-BB6D-FE53458985D6@dilger.ca>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Sun, 21 Feb 2021 19:59:22 -0800
Message-ID: <CAD+ocbwCEKjrSAuv8EKWRwq-tXva+w4=VxDwFJ2N3-VLaevp9Q@mail.gmail.com>
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

Thank you for all the feedback Andreas and Artem. Some comments below:

> >
> > Walk along the ngroups linked elements in worst case for every mb_free_blocks and mb_mark_used which are quite frequently executed actions.
> > If double-linked list is used for avg_fragments this function will make this change without iterating through the list:
> > 1. Check with previous element. If smaller, then commute
> > 2. Check with next element. If greater, then commute.
So given that groups are organized by avg_fragment_size in a tree, the
worst case for every mb_free_blocks() and mb_mark_used() is actually
log(ngroups). But I get your idea. Problem with doing that with
rb_tree though is that rb_next() and rb_prev() are not constant time
functions since these functions would need to traverse a part of the
tree to determine the next / previous element. So I think this
optimization may not result in performance improvement.
>
> I was wondering about the cost of the list/tree maintenance as well,
> especially since there was a post from "kernel test robot" that this
> patch introduced a performance regression.
Yeah, I'm pretty sure that the kernel test robot is complaining mainly
because of list/tree maintenance. I think if this optimization is
turned off, we probably should not even maintain the tree / lists.
That has one downside that is that we will have to disallow setting
this option during remount, which I guess is okay?
>
> The tree insertion/removal overhead I think Artem's proposal above would
> improve, since it may be that a group will not move in the tree much?
Like I mentioned above, given that we have an average fragment size
tree, checking neighboring groups is not a constant time operation. So
I don't think that will change performance much.
>
> It would also make sense for totally full groups to be kept out of the
> rb tree entirely, since they do not provide any value in that case (the
> full groups will never be selected for allocations), and they just add
> to the tree depth and potentially cause an imbalance if there are many
> of them.  That also has the benefit of the rbtree efficiency *improving*
> as the filesystem gets more full, which is right when it is most needed.
Ack
>
> It might also make sense to keep totally empty groups out of the rbtree,
> since they should always be found in cr0 already if the allocation is
> large enough to fill the whole group?  Having a smaller rbtree makes
> every insertion/removal that much more efficient.
Ack
>
> Those groups will naturally be re-added into the rbtree when they have
> blocks freed or allocated, so not much added complexity.
>
>
> Does it make sense to disable "mb_optimize_scan" if filesystems are
> smaller than a certain threshold?  Clearly, if there are only 1-2
> groups, maintaining a list and rbtree has no real value, and with
> only a handful of groups (< 16?) linear searching is probably as fast
> or faster than maintaining the two data structures.  That is similar
> to e.g. bubble sort vs. quicksort, where it is more efficient to sort
> a list of ~5-8 entries with a dumb/fast algorithm instead of a complex
> algorithm that is more efficient at larger scales.  That would also
> (likely) quiet the kernel test robot, if we think that its testing is
> not representative of real-world usage.
Ack, these are good optimizations. I'll add these in V3.

Besides the optimizations mentioned here, I also think we should add
"mb_optimize_linear_limit" or such sysfs tunable which will control
how many groups should mballoc search linearly before using tree /
lists for allocation? That would help us with the disk seek time
performance.

We discussed on our last call that we probably should consult with the
block device's request queue to check if the underlying block device
is rotational or not. However, we also discussed that for more complex
devices (such as DMs setup on top of HDD and SSD etc), whether the
device is rotational or not is not a binary answer and we would need a
more complex interface (such as logical range to "is_rotational"
table) to make intelligent choice in the file system. Also, in such
cases, it is not clear if such a table needs to be passed to the file
system during mkfs time? or at mount time? or at run time?

Given the number of unknowns in the above discussion, I propose that
we start simple and evolve later. So my proposal is that we add a
"mb_optimize_linear_limit" tunable that accepts an integer value. In
the kernel, for non-rotational devices, that value will be defaulted
to 0 (which means no linear scan) and for rotational devices, that
value will be defaulted to a reasonable value (-- not sure what that
value would be though - 4?). This default can be overridden using the
sysfs interface. We can later evolve this interface to accept more
complex input such as logical range to rotational status.

Does that sound reasonable?

Thanks,
Harshad

>
> > On Feb 11, 2021, at 3:30 AM, Andreas Dilger <adilger@dilger.ca> wrote:
>
> >> This function would be more efficient to do the list move under a single
> >> write lock if the order doesn't change.  The order loop would just
> >> save the largest free order, then grab the write lock, do the list_del(),
> >> set bb_largest_free_order, and list_add_tail():
> >>
> >> mb_set_largest_free_order(struct super_block *sb, struct ext4_group_info *grp)
> >> {
> >>      struct ext4_sb_info *sbi = EXT4_SB(sb);
> >>      int i, new_order = -1;
> >>
> >>      for (i = MB_NUM_ORDERS(sb) - 1; i >= 0; i--) {
> >>              if (grp->bb_counters[i] > 0) {
> >>                      new_order = i;
> >>                      break;
> >>              }
> >>      }
> >>      if (test_opt2(sb, MB_OPTIMIZE_SCAN) && grp->bb_largest_free_order >= 0) {
> >>              write_lock(&sbi->s_mb_largest_free_orders_locks[
> >>                                            grp->bb_largest_free_order]);
> >>              list_del_init(&grp->bb_largest_free_order_node);
> >>
> >>              if (new_order != grp->bb_largest_free_order) {
> >>                      write_unlock(&sbi->s_mb_largest_free_orders_locks[
> >>                                            grp->bb_largest_free_order]);
> >>                      grp->bb_largest_free_order = new_order;
> >>                      write_lock(&sbi->s_mb_largest_free_orders_locks[
> >>                                            grp->bb_largest_free_order]);
> >>              }
> >>              list_add_tail(&grp->bb_largest_free_order_node,
> >>                    &sbi->s_mb_largest_free_orders[grp->bb_largest_free_order]);
> >>              write_unlock(&sbi->s_mb_largest_free_orders_locks[
> >>                                            grp->bb_largest_free_order]);
> >>      }
> >> }
>
> In looking at my previous comment, I wonder if we could further reduce
> the list locking here by not moving an entry to the end of the *same*
> list if it is not currently at the head?  Since it was (presumably)
> just moved to the end of the list by a recent allocation, it is very
> likely that some other group will be chosen from the list head, so
> moving within the list to maintain strict LRU is probably just extra
> locking overhead that can be avoided...
>
> Also, it isn't clear if *freeing* blocks from a group should move it
> to the end of the same list, or just leave it as-is?  If there are
> more frees from the list it is likely to be added to a new list soon,
> and if there are no more frees, then it could stay in the same order.
>
>
> Cheers, Andreas
>
>
>
>
>
