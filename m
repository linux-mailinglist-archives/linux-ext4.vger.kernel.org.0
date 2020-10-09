Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C89032899C7
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Oct 2020 22:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387723AbgJIUac (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Oct 2020 16:30:32 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:57835 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732521AbgJIUac (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Oct 2020 16:30:32 -0400
X-Originating-IP: 67.5.25.97
Received: from localhost (unknown [67.5.25.97])
        (Authenticated sender: josh@joshtriplett.org)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id A49D0E0002;
        Fri,  9 Oct 2020 20:30:25 +0000 (UTC)
Date:   Fri, 9 Oct 2020 13:30:22 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org
Subject: Re: ext4 regression in v5.9-rc2 from e7bfb5c9bb3d on ro fs with
 overlapped bitmaps
Message-ID: <20201009203022.GD4649@localhost>
References: <20201006025110.GJ49559@magnolia>
 <20201006031834.GA5797@mit.edu>
 <20201006050306.GA8098@localhost>
 <20201006133533.GC5797@mit.edu>
 <20201007080304.GB1112@localhost>
 <20201007143211.GA235506@mit.edu>
 <20201007201424.GB15049@localhost>
 <20201008021017.GD235506@mit.edu>
 <20201008222259.GA45658@localhost>
 <20201009143732.GJ235506@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009143732.GJ235506@mit.edu>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Oct 09, 2020 at 10:37:32AM -0400, Theodore Y. Ts'o wrote:
> That being said, on the ext4 weekly video chat, we did discuss other
> uses of an incompat feature flag that would allow the allocation
> bitmap blocks and inode table block fields in the superblock to be
> zero, which would mean that they are unallocated.

What do you mean by "allocation bitmap blocks and inode table block
fields in the superblock"? Those are in the group descriptor, not the
superblock. Or am I missing something there?

> This would allow us
> to dynamically grow the inode table by adding an extra block group
> descriptor.  In fact, I'd probably use this as an opportunity to make
> some other changes, such using inodes to store locations of the block
> group descriptors, inode tables, and allocation bitmaps at the same
> time.  Those details can be discussed later, but the point is that
> this is why it's good to discuss format changes from a requirements
> perspective, so that if we do need to make an incompat change, we can
> kill multiple birds with a single stone.

I would be quite interested in that.

> On Thu, Oct 08, 2020 at 03:22:59PM -0700, Josh Triplett wrote:
> > It's an arbitrary filesystem hierarchy, including directories, files of
> > various sizes (hence using inline_data), and permissions. The problem
> > isn't to get data from point A to point B; the problem is (in part) to
> > turn a representation of a filesystem into an actual mounted filesystem
> > as efficiently as possible, live-serving individual blocks on demand
> > rather than generating the whole image in advance.
> 
> Ah, so you want to be able to let the other side "look at" the file
> system in parallel with it being generated on demand?  The cache
> coherency problems would seem to be... huge.  For example, how can you
> add a file to directory after the reader has looked at the directory
> inode and directory blocks?

I don't. While the data is computed on demand for performance reasons,
the nature and size of all the data is fully known in advance. I never
add data to a filesystem, only create new filesystem images. The kernel
*is* looking at the filesystem in parallel with it being generated,
insofar as blocks aren't constructed until the kernel asks for them
(which is a massive performance win, especially since the kernel may
only want a small subset of the filesystem). But the block contents are
fixed in advance, even if they haven't been generated yet. So the kernel
can read ahead and cache any blocks it wants to, and they'll be valid.
(Excessive readahead might be a performance problem, but not a
correctness one.)

I briefly considered ideas around adding new data after the filesystem
was mounted, and dismissed those ideas just as quickly, for exactly
these reasons (disk caching, filesystem caching, readahead). That would
require a filesystem with at least some subset of cluster features. I
don't plan to go there if I don't have to.

If I do end up needing that, I'd consider proposing an ext4 change along
the lines of making the root directory into a "super-root" directory
under which multiple filesystem roots could live, and supporting a way
to re-read that root to discover new filesystem roots and new block
groups; then, it'd be possible to add a new root whose contents are
*mostly* references to existing inodes (that the kernel would already
have cached), and any modified directories or new/modified files would
have new inodes added. That would isolate the "don't read ahead and
cache" problem to the new inodes, which could potentially be isolated to
new block groups for simplicity, and the "discover new roots" mechanism
could also discover the newly added block groups and inode tables.

But again, I'm not curently looking to do that, and *if* I were, I'd
bring it up for architectural discussion and design on linux-ext4 first.
There's also a balance there between a simple version that'd work for an
append-only read-only filesystem, and a complex version that'd work for
a writable filesystem, and I'd hope more for the former than the latter,
but that'd be a topic for discussion.

- Josh Triplett
