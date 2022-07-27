Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71F858322D
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Jul 2022 20:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbiG0Sj1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Jul 2022 14:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234134AbiG0SjF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Jul 2022 14:39:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B819C116EC4
        for <linux-ext4@vger.kernel.org>; Wed, 27 Jul 2022 10:36:13 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3D5AD3831F;
        Wed, 27 Jul 2022 17:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658943371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jZj0ir5x8I6+Ky+gYPWT2LdsscH9PDsYnHuC++RfyQs=;
        b=hjW1GmChc3G3GLOsLqNNJMboLYoMx/mvlbvkGEcpoM0x0+Kss1dRiHoL6OchEJR852P9Mf
        iYPWnzgpk0w0yNMbWA/bZQLDwJUkqSVcNVNKOxmrYC+ta4lKdWLmktxKTO07b62xyiL9Sz
        PXqkbo9eMPwfvhPl8i5HnZv+HoR/wa8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658943371;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jZj0ir5x8I6+Ky+gYPWT2LdsscH9PDsYnHuC++RfyQs=;
        b=hCJgaJXV5wuezFjp89Y7IzQW9EzTT3pRAb3gdCaWWNJw+kvf/1uLbRd4c0kLE3B0BM+Rc1
        h2xxt+ZBkkTg5RDA==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 13B4E2C141;
        Wed, 27 Jul 2022 17:36:11 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 95862A0662; Wed, 27 Jul 2022 19:36:09 +0200 (CEST)
Date:   Wed, 27 Jul 2022 19:36:09 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        Ted Tso <tytso@mit.edu>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>
Subject: Re: Ext4 mballoc behavior with mb_optimize_scan=1
Message-ID: <20220727173609.xcfy6u4b3kvw5p2k@quack3>
References: <20220727105123.ckwrhbilzrxqpt24@quack3>
 <20220727170704.h4zli4ujer6a5cp2@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727170704.h4zli4ujer6a5cp2@riteshh-domain>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 27-07-22 22:37:04, Ritesh Harjani wrote:
> On 22/07/27 12:51PM, Jan Kara wrote:
> > Hello,
> >
> > before going on vacation I was tracking down why reaim benchmark regresses
> > (10-20%) with larger number of processes with the new mb_optimize_scan
> > strategy of mballoc. After a while I have reproduced the regression with a
> > simple benchmark that just creates, fsyncs, and deletes lots of small files
> > (22k) from 16 processes, each process has its own directory. The immediate
> > reason for the slow down is that with mb_optimize_scan=1 the file blocks
> > are spread among more block groups and thus we have more bitmaps to update
> > in each transaction.
> 
> To add a little more info to why maybe this regression is getting noticed this late
> is that initially the patch series had a bug where the optimization was never
> getting enabled for files with extents until it got fixed by this patch.
> 
> https://lore.kernel.org/linux-ext4/fc9a48f7f8dcfc83891a8b21f6dd8cdf056ed810.1646732698.git.ojaswin@linux.ibm.com/#t

Yes. Also it took me quite some time to get to analyzing the regression
reported by our automated testing and understand what's going on...

> > So the question is why mballoc with mb_optimize_scan=1 spreads allocations
> > more among block groups. The situation is somewhat obscured by group
> > preallocation feature of mballoc where each *CPU* holds a preallocation and
> > small (below 64k) allocations on that CPU are allocated from this
> > preallocation. If I trace creating of these group preallocations I can see
> > that the block groups they are taken from look like:
> >
> > mb_optimize_scan=0:
> > 49 81 113 97 17 33 113 49 81 33 97 113 81 1 17 33 33 81 1 113 97 17 113 113
> > 33 33 97 81 49 81 17 49
> >
> > mb_optimize_scan=1:
> > 127 126 126 125 126 127 125 126 127 124 123 124 122 122 121 120 119 118 117
> > 116 115 116 114 113 111 110 109 108 107 106 105 104 104
> >
> > So we can see that while with mb_optimize_scan=0 the preallocation is
> > always take from one of a few groups (among which we jump mostly randomly)
> > which mb_optimize_scan=1 we consistently drift from higher block groups to
> > lower block groups.
> >
> > The mb_optimize_scan=0 behavior is given by the fact that search for free
> > space always starts in the same block group where the inode is allocated
> > and the inode is always allocated in the same block group as its parent
> > directory. So the create-delete benchmark generally keeps all inodes for
> > one process in the same block group and thus allocations are always
> > starting in that block group. Because files are small, we always succeed in
> > finding free space in the starting block group and thus allocations are
> > generally restricted to the several block groups where parent directories
> > were originally allocated.
> >
> > With mb_optimize_scan=1 the block group to allocate from is selected by
> > ext4_mb_choose_next_group_cr0() so in this mode we completely ignore the
> > "pack inode with data in the same group" rule. The reason why we keep
> > drifting among block groups is that whenever free space in a block group is
> > updated (blocks allocated / freed) we recalculate largest free order (see
> > mb_mark_used() and mb_free_blocks()) and as a side effect that removes
> > group from the bb_largest_free_order_node list and reinserts the group at
> > the tail.
> 
> One thing which comes to mind is maybe to cache the last block group from
> which the allocation was satisfied and only if that fails, we could then try
> the largest_free_order() bg.

Yes, this sounds like a reasonable heuristic to me.

> > I have two questions about the mb_optimize_scan=1 strategy:
> >
> > 1) Shouldn't we respect the initial goal group and try to allocate from it
> > in ext4_mb_regular_allocator() before calling ext4_mb_choose_next_group()?
> 
> I remember discussing this problem and I think the argument that time was...
> 
> """ ...snip from the cover letter.
> These changes may result in allocations to be spread across the block
> device. While that would not matter some block devices (such as flash)
> it may be a cause of concern for other block devices that benefit from
> storing related content togetther such as disk. However, it can be
> argued that in high fragmentation scenrio, especially for large disks,
> it's still worth optimizing the scanning since in such cases, we get
> cpu bound on group scanning instead of getting IO bound. Perhaps, in
> future, we could dynamically turn this new optimization on based on
> fragmentation levels for such devices.
> """
> 
> ...but maybe more explainations can be added by others.

But this reasoning seems to be explaining that selecting group by the
largest free order may spread allocations more (as the group fill up,
group's largest free order will decrease and we'll get to next group) and
that faster allocation is worth the spreading. But I don't think it
justifies why is it good to rotate among groups that have the same largest
free order...

> > 2) The rotation of groups in mb_set_largest_free_order() seems a bit
> > undesirable to me. In particular it seems pointless if the largest free
> > order does not change. Was there some rationale behind it?
> 
> Agree.
> 
> Also,
> I am wondering on whether there is a bot which does reaim benchmark
> testing too on any of the performance patches. For e.g. [1].
> 
> [1]: https://github.com/intel/lkp-tests/blob/3fece75132266f680047f4e1740b39c5b3faabbf/tests/reaim
> 
> Can submitter of a patch also trigger this performance benchmark testing?
> I have generally seen some kernel test bot reports with performace score
> results, but I am not sure if there is a easy way to trigger this like
> how we have for syzbot. Any idea?

I don't think there's a way to trigger this from the outside.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
