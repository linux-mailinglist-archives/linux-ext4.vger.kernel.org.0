Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2890D251476
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Aug 2020 10:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbgHYIlj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 25 Aug 2020 04:41:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:36642 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbgHYIlj (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 25 Aug 2020 04:41:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 72158B6CC;
        Tue, 25 Aug 2020 08:42:08 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 770601E1316; Tue, 25 Aug 2020 10:41:37 +0200 (CEST)
Date:   Tue, 25 Aug 2020 10:41:37 +0200
From:   Jan Kara <jack@suse.cz>
To:     yebin <yebin10@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, jack@suse.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 0/2] Fix race between do_invalidatepage and
 init_page_buffers
Message-ID: <20200825084137.GA32298@quack2.suse.cz>
References: <20200822082218.2228697-1-yebin10@huawei.com>
 <20200824155143.GH24877@quack2.suse.cz>
 <5F447351.6060207@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5F447351.6060207@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 25-08-20 10:11:29, yebin wrote:
> Your patch certainly can fix the problem with my testcases, but I don't
> think it's a good way. There are other paths that can call
> do_invalidatepage , for instance block ioctl to discard and zero_range.

OK, good point! So my patch is a cleanup that stands on its own and we
should do it regardless. But I agree we need more to completely fix this.
I don't quite like the callback you've added just for this special case
(furthermore it grows size of every buffer_head and there can be lots of
those). But I agree with the general idea that we shouldn't discard buffers
that the filesystem is working with.

In fact I believe that fallocate(2) and zeroout/discard ioctls should
return EBUSY if they are run against a mounted device because with 99%
probability something went wrong and you're accidentally discarding the
wrong device. But maybe I'm wrong. I'll run this idea through other fs
developers.

								Honza

> On 2020/8/24 23:51, Jan Kara wrote:
> > On Sat 22-08-20 16:22:16, Ye Bin wrote:
> > > Ye Bin (2):
> > >    ext4: Add comment to BUFFER_FLAGS_DISCARD for search code
> > >    jbd2: Fix race between do_invalidatepage and init_page_buffers
> > > 
> > >   fs/buffer.c                 | 12 +++++++++++-
> > >   fs/jbd2/journal.c           |  7 +++++++
> > >   include/linux/buffer_head.h |  2 ++
> > >   3 files changed, 20 insertions(+), 1 deletion(-)
> > Thanks for the good description of the problem and the analysis. I could
> > now easily understand what was really happening on your system. I think the
> > problem should be fixed differently through - it is a problem of
> > block_write_full_page() that it invalidates buffers while JBD2 is working
> > with them. Attached patch should also fix the problem. Can you please test
> > whether it fixes your testcase as well? Thanks!
> > 
> > 								Honza
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
