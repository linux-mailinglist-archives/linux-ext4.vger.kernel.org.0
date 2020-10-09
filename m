Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFCC288B79
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Oct 2020 16:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387978AbgJIOhq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Oct 2020 10:37:46 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:40611 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1733112AbgJIOhq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Oct 2020 10:37:46 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 099EbWwa005346
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Oct 2020 10:37:32 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 1D13C420107; Fri,  9 Oct 2020 10:37:32 -0400 (EDT)
Date:   Fri, 9 Oct 2020 10:37:32 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org
Subject: Re: ext4 regression in v5.9-rc2 from e7bfb5c9bb3d on ro fs with
 overlapped bitmaps
Message-ID: <20201009143732.GJ235506@mit.edu>
References: <20201006003216.GB6553@localhost>
 <20201006025110.GJ49559@magnolia>
 <20201006031834.GA5797@mit.edu>
 <20201006050306.GA8098@localhost>
 <20201006133533.GC5797@mit.edu>
 <20201007080304.GB1112@localhost>
 <20201007143211.GA235506@mit.edu>
 <20201007201424.GB15049@localhost>
 <20201008021017.GD235506@mit.edu>
 <20201008222259.GA45658@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201008222259.GA45658@localhost>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Oct 08, 2020 at 03:22:59PM -0700, Josh Triplett wrote:
> 
> I wasn't trying to make a *new* general principle or policy. I was under
> the impression that this *was* the policy, because it never occurred to
> me that it could be otherwise. It seemed like a natural aspect of the
> kernel/userspace boundary, to the point that the idea of it *not* being
> part of the kernel's stability guarantees didn't cross my mind. 

From our perspective (and Darrick and I discussed this on this week's
ext4 video conference, so it represents the ext4 and xfs maintainer's
position) is that the file system format is different.  First, the
on-disk format is not an ABI, and it is several orders more complex
than a system call interface.  Second, we make no guarantees about
what the file system created by malicious tools will do.  For example,
XFS developers reject bug reports from file system fuzzers, because
the v5 format has CRC checks, so randomly corrupted file systems won't
crash the kernel.  Yes, this doesn't protect against maliciously
created file systems where the attacker makes sure the checksums are
valid, but only crazy people who think containers are just as secure
as VM's and that unprivileged users should be allowed to make the
kernel mount potentially maliciously created file systems would be
exposing the kernel to such maliciously created images.

> Finally, I think there's also some clarification needed in the role of
> what some of the incompat and ro_compat flags mean. For instance,
> "RO_COMPAT_READONLY" is documented as:
> >     - Read-only filesystem image; the kernel will not mount this image
> >       read-write and most tools will refuse to write to the image.
> Is it reasonable to interpret this as "this can never, ever become
> writable", such that no kernel should ever "understand" that flag in
> ro_compat?

Yes.  However...

> I'd assumed so, but this discussion is definitely leading me
> to want to confirm any such assumptions. Is this a flag that e2fsck
> could potentially use to determine that it shouldn't check
> read-write-specific data structures, or should that be a different flag?

Just because it won't be modifiable, shouldn't mean that e2fsck won't
check to make sure that such structures are valid.  "Won't be changed"
and "valid" are two different concepts.  And certainly, today we *do*
check to make sure the bitmaps are valid and don't overlap, and we
can't go back in time to change that.

That being said, on the ext4 weekly video chat, we did discuss other
uses of an incompat feature flag that would allow the allocation
bitmap blocks and inode table block fields in the superblock to be
zero, which would mean that they are unallocated.  This would allow us
to dynamically grow the inode table by adding an extra block group
descriptor.  In fact, I'd probably use this as an opportunity to make
some other changes, such using inodes to store locations of the block
group descriptors, inode tables, and allocation bitmaps at the same
time.  Those details can be discussed later, but the point is that
this is why it's good to discuss format changes from a requirements
perspective, so that if we do need to make an incompat change, we can
kill multiple birds with a single stone.

> It's an arbitrary filesystem hierarchy, including directories, files of
> various sizes (hence using inline_data), and permissions. The problem
> isn't to get data from point A to point B; the problem is (in part) to
> turn a representation of a filesystem into an actual mounted filesystem
> as efficiently as possible, live-serving individual blocks on demand
> rather than generating the whole image in advance.

Ah, so you want to be able to let the other side "look at" the file
system in parallel with it being generated on demand?  The cache
coherency problems would seem to be... huge.  For example, how can you
add a file to directory after the reader has looked at the directory
inode and directory blocks?  Or for that matter, looked at a portion
of the inode table block?  Or are you using 4k inodes so there is only
one inode per block?  What about the fact that we sometimes do
readahead of inode table blocks?

I can think of all sorts of implementation level changes in terms of
caching, readahead behavior, etc., that we might make in the future
that might break you if you are doing some quite as outré are that.
Again, the fact that you're being cagey about what you are doing, and
potentially complaining about changes we might make that would break
you, is ***really*** scaring me now.

Can you go into more details here?  I'm sorry if you're working for
some startup who might want to patent these ideas, but if you want to
guarantee future compatibility, I'm really going to have to insist.

	  	 		    	   - Ted
					 
