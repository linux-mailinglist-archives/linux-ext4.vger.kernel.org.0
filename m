Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 502922C111D
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Nov 2020 17:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731921AbgKWQyx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Nov 2020 11:54:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:54938 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730595AbgKWQyw (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 23 Nov 2020 11:54:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4D959AC24;
        Mon, 23 Nov 2020 16:54:51 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4D4D21E130F; Mon, 23 Nov 2020 17:54:50 +0100 (CET)
Date:   Mon, 23 Nov 2020 17:54:50 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, yebin <yebin10@huawei.com>, jack@suse.com,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 0/2] Fix race between do_invalidatepage and
 init_page_buffers
Message-ID: <20201123165450.GL27294@quack2.suse.cz>
References: <20200822082218.2228697-1-yebin10@huawei.com>
 <20200824155143.GH24877@quack2.suse.cz>
 <5F447351.6060207@huawei.com>
 <20200825084137.GA32298@quack2.suse.cz>
 <20201120033600.GA695373@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120033600.GA695373@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 19-11-20 22:36:00, Theodore Y. Ts'o wrote:
> On Tue, Aug 25, 2020 at 10:41:37AM +0200, Jan Kara wrote:
> > On Tue 25-08-20 10:11:29, yebin wrote:
> > > Your patch certainly can fix the problem with my testcases, but I don't
> > > think it's a good way. There are other paths that can call
> > > do_invalidatepage , for instance block ioctl to discard and zero_range.
> > 
> > OK, good point! So my patch is a cleanup that stands on its own and we
> > should do it regardless. But I agree we need more to completely fix this.
> > I don't quite like the callback you've added just for this special case
> > (furthermore it grows size of every buffer_head and there can be lots of
> > those). But I agree with the general idea that we shouldn't discard buffers
> > that the filesystem is working with.
> > 
> > In fact I believe that fallocate(2) and zeroout/discard ioctls should
> > return EBUSY if they are run against a mounted device because with 99%
> > probability something went wrong and you're accidentally discarding the
> > wrong device. But maybe I'm wrong. I'll run this idea through other fs
> > developers.
> 
> I'm going through old patches, and I'm trying to figure out where did
> we end up on this issue?   Did we come to a conclusion on this?

Yes, it is fixed by 384d87ef2c95 ("block: Do not discard buffers under a
mounted filesystem"). Also the block_write_full_page() got fixed up by
6dbf7bb555981 ("fs: Don't invalidate page buffers in
block_write_full_page()"). So we should be all set.

> One other thing which I noticed when looking at the original patch was
> shouldn't lvreduce not be allowed to run on a LV which has a mounted
> file system on its block device?

No, that is IMO working by design. The expectation is you can online-shrink
the fs and then lvreduce the device...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
