Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B09512E0D6C
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Dec 2020 17:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbgLVQe5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 22 Dec 2020 11:34:57 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57639 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727590AbgLVQe5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 22 Dec 2020 11:34:57 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0BMGY6pj012553
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Dec 2020 11:34:07 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 6AC5A420280; Tue, 22 Dec 2020 11:34:06 -0500 (EST)
Date:   Tue, 22 Dec 2020 11:34:06 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: discard and data=writeback
Message-ID: <X+If/kAwiaMdaBtF@mit.edu>
References: <CAFnufp2zSthSbrOQ5JE6rKEANeFqvunCR3W5Bx2VgN_Q3NbLVg@mail.gmail.com>
 <X+AQxkC9MbuxNVRm@mit.edu>
 <CAFnufp1N-k+MWWsC0G1EhGvzRjiQn3G8qPw=6uqE1wjwnPgmqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFnufp1N-k+MWWsC0G1EhGvzRjiQn3G8qPw=6uqE1wjwnPgmqA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Dec 22, 2020 at 03:59:29PM +0100, Matteo Croce wrote:
> 
> I'm issuing sync + sleep(10) after the extraction, so the writes
> should all be flushed.
> Also, I repeated the test three times, with very similar results:

So that means the problem is not due to page cache writeback
interfering with the discards.  So it's most likely that the problem
is due to how the blocks are allocated and laid out when using
data=ordered vs data=writeback.

Some experiments to try next.  After extracting the files with
data=ordered and data=writeback on a freshly formatted file system,
use "e2freefrag" to see how the free space is fragmented.  This will
tell us how the file system is doing from a holistic perspective, in
terms of blocks allocated to the extracted files.  (E2freefrag is
showing you the blocks *not* allocated, of course, but that's a mirror
image dual of the blocks that *are* allocated, especially if you start
from an identical known state; hence the use of a freshly formatted
file system.)

Next, we can see how individual files look like with respect to
fragmentation.  This can be done via using filefrag on all of the
files, e.g:

       find . -type f -print0  | xargs -0 filefrag

Another way to get similar (although not identical) information is via
running "e2fsck -E fragcheck" on a file system.  How they differ is
especially more of a big deal on ext3 file systems without extents and
flex_bg, since filefrag tries to take into account metadata blocks
such as indirect blocks and extent tree blocks, and e2fsck -E
fragcheck does not; but it's good enough for getting a good gestalt
for the files' overall fragmentation --- and note that as long as the
average fragment size is at least a megabyte or two, some
fragmentation really isn't that much of a problem from a real-world
performance perspective.  People can get way too invested in trying to
get to perfection with 100% fragmentation-free files.  The problem
with doing this at the expense of all else is that you can end up
making the overall free space fragmentation worse as the file system
ages, at which point the file system performance really dives through
the floor as the file system approaches 100%, or even 80-90% full,
especially on HDD's.  For SSD's fragmentation doesn't matter quite so
much, unless the average fragment size is *really* small, and when you
are discarded freed blocks.

Even if the files are showing no substantial difference in
fragmentation, and the free space is equally A-OK with respect to
fragmentation, the other possibility is the *layout* of the blocks are
such that the order in which they are deleted using rm -rf ends up
being less friendly from a discard perspective.  This can happen if
the directory hierarchy is big enough, and/or the journal size is
small enough, that the rm -rf requires multiple journal transactions
to complete.  That's because with mount -o discard, we do the discards
after each transaction commit, and it might be that even though the
used blocks are perfectly contiguous, because of the order in which
the files end up getting deleted, we end up needing to discard them in
smaller chunks.

For example, one could imagine a case where you have a million 4k
files, and they are allocated contiguously, but if you get
super-unlucky, such that in the first transaction you delete all of
the odd-numbered files, and in second transaction you delete all of
the even-numbered files, you might need to do a million 4k discards
--- but if all of the deletes could fit into a single transaction, you
would only need to do a single million block discard operation.

Finally, you may want to consider whether or not mount -o discard
really makes sense or not.  For most SSD's, especially high-end SSD's,
it probably doesn't make that much difference.  That's because when
you overwrite a sector, the SSD knows (or should know; this might not
be some really cheap, crappy low-end flash devices; but on those
devices, discard might not be making uch of a difference anyway), that
the old contents of the sector is no longer needed.  Hence an
overwrite effectively is an "implied discard".  So long as there is a
sufficient number of free erase blocks, the SSD might be able to keep
up doing the GC for those "implied discards", and so accelerating the
process by sending explicit discards after every journal transaction
might not be necessary.  Or, maybe it's sufficient to run "fstrim"
every week at Sunday 3am local time; or maybe even fstrim once a night
or fstrim once a month --- your mileage may vary.

It's going to vary from SSD to SSD and from workload to workload, but
you might find that mount -o discard isn't buying you all that much
--- if you run a random write workload, and you don't notice any
performance degradation, and you don't notice an increase in the SSD's
write amplification numbers (if they are provided by your SSD), then
you might very well find that it's not worth it to use mount -o
discard.

I personally don't bother using mount -o discard, and instead
periodically run fstrim, on my personal machines.  Part of that is
because I'm mostly just reading and replying to emails, building
kernels and editing text files, and that is not nearly as stressful on
the FTL as a full-blown random write workload (for example, if you
were running a database supporting a transaction processing workload).

Cheers,

						- Ted
