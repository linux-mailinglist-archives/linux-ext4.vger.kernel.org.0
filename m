Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40DCD35B771
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Apr 2021 01:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235722AbhDKXi6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 11 Apr 2021 19:38:58 -0400
Received: from mail108.syd.optusnet.com.au ([211.29.132.59]:56257 "EHLO
        mail108.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235229AbhDKXi6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 11 Apr 2021 19:38:58 -0400
Received: from dread.disaster.area (pa49-181-239-12.pa.nsw.optusnet.com.au [49.181.239.12])
        by mail108.syd.optusnet.com.au (Postfix) with ESMTPS id BC4801AEC4C;
        Mon, 12 Apr 2021 09:38:39 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1lVjf4-003gwC-PB; Mon, 12 Apr 2021 09:38:38 +1000
Date:   Mon, 12 Apr 2021 09:38:38 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Leah Rumancik <leah.rumancik@gmail.com>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ext4: wipe filename upon file deletion
Message-ID: <20210411233838.GO1990290@dread.disaster.area>
References: <20210407154202.1527941-1-leah.rumancik@gmail.com>
 <20210407154202.1527941-2-leah.rumancik@gmail.com>
 <YG4lG2B9Wf4t6IfA@gmail.com>
 <YG59GE+8bhtVLOQr@mit.edu>
 <20210408052155.GK1990290@dread.disaster.area>
 <YG9YqkHfslwAdh2/@mit.edu>
 <20210409000207.GJ22091@magnolia>
 <YG/BHfB3arzT4x6W@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG/BHfB3arzT4x6W@mit.edu>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Tu+Yewfh c=1 sm=1 tr=0 cx=a_idp_f
        a=gO82wUwQTSpaJfP49aMSow==:117 a=gO82wUwQTSpaJfP49aMSow==:17
        a=kj9zAlcOel0A:10 a=3YhXtTcJ-WEA:10 a=7-415B0cAAAA:8
        a=Zwx9kvhYuoj3QZT2xbMA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Apr 08, 2021 at 10:51:09PM -0400, Theodore Ts'o wrote:
> On Thu, Apr 08, 2021 at 05:02:07PM -0700, Darrick J. Wong wrote:
> > > In the ideal world, sure, all or most of them would agree that they
> > > *shouldn't* be storing any kind of PII at rest unencrypted, but they
> > > can't be sure, and so from the perspective of keeping their audit and
> > > I/T compliance committees happy, this requirement is desirable from a
> > > "belt and suspenders" perspective.
> > > 
> > > > This seems like a better fit for FITRIM than anything else.
> > > > 
> > > > Ooohh. We sure do suck at APIs, don't we? FITRIM has no flags field,
> > > > so we can't extend that.
> > > 
> > > I don't have any serious objections to defining FITRIM2; OTOH, for
> > 
> > Er, are we talking about the directory name wiping, or the journal
> > discarding?
> 
> Sorry, I was talking about journal wiping.  The conflation is because
> the reason why we want to wipe the journal is because of the directory
> names in the journal, so the two are very much connected for our use
> case, but yes, directory names in directories is very from directory
> names in the journal.
> 
> We don't actually need any kind of interface for wiping names in
> directories, since it doesn't cost us anything to unconditionally wipe
> the directory entries as opposed to just setting the inode number to
> zero.
> 
> > I didn't think it was any more difficult than changing xfs_removename to
> > zero out the name and ftype fields at the same time it adds the whiteout
> > to the dirent.  But TBH I haven't thought through this too deeply.
> > 
> > I /do/ think that if you ever want to add "secure" deletion to XFS, I'd
> > want to do it by implementing FS_SECRM_FL for XFS, and not by adding
> > more mount options.
> 
> The original meaning of FS_SECRM_FL was that the data blocks would be
> zero'ed --- when the inode was deleted.

Sure, if discard is Good Enough(tm) for the journal, then we just
treat this flag like "-o discard" was enabled for this file. Let the
hardware do the "zeroing" in the background once we mark the extent
as free. And if the hardware supports secure erase in place of
discard, then even better.

In the case of XFS, if we are to implement this directory entry
zeroing then we actually need to discard the directory blocks. We
may elide writeback of the directory block altogether if it is
removed from the directory entirely between journal checkpoints. In
that situation, we just write a whiteout for the block to the
journal (we cancel the buffer) and we never actually write that
buffer's contents to disk as it has been marked free by the journal
commit.

And, similarly short form directories aren't in blocks and can't be
discarded, and we can elide inode writeback in the case where the
inode clusters are freed. Hence zeroing dirents held inline in the
inodes are not guaranteed to hit the disk, either. So we'd need to
discard inode clusters as well.

IOWs, we can do "rm -rf" of a directory with tens of thousands of
entries, and the only thing that ends up hitting stable storage
is a few hundred buffer invalidations in the journal. They remain
unmodified in free space after the journal commit.

This is why I said "good luck" to fixing XFS not to leak directory
entries to disk. It's a pretty major undertaking to audit, fix and
verify all the paths that remove directory entries to ensure that we
do not leak dirent names anywhere.

And I haven't even touched on PII in extended attributes :/

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
