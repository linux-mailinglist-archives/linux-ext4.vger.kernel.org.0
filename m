Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED7852DF7F0
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Dec 2020 04:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725783AbgLUDF2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 20 Dec 2020 22:05:28 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:48694 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725497AbgLUDF2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 20 Dec 2020 22:05:28 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0BL34cO2026704
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 20 Dec 2020 22:04:39 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 911B5420280; Sun, 20 Dec 2020 22:04:38 -0500 (EST)
Date:   Sun, 20 Dec 2020 22:04:38 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: discard and data=writeback
Message-ID: <X+AQxkC9MbuxNVRm@mit.edu>
References: <CAFnufp2zSthSbrOQ5JE6rKEANeFqvunCR3W5Bx2VgN_Q3NbLVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFnufp2zSthSbrOQ5JE6rKEANeFqvunCR3W5Bx2VgN_Q3NbLVg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Dec 18, 2020 at 07:40:09PM +0100, Matteo Croce wrote:
> 
> I noticed a big slowdown on file removal, so I tried to remove the
> discard option, and it helped
> a lot.
> Obviously discarding blocks will have an overhead, but the strange
> thing is that it only
> does when using data=writeback:

If data=ordered mount option is enabled, when you have allocating
buffered writes pending, the data block writes are forced out *before*
we write out the journal blocks, followed by a cache flush, followed
by the commit block (which is either written with the Forced Unit
Attention bit set if the storage device supports this, or the commit
block is followed by another cache flush).  After the journal commit
block is written out, then if the discard mount option is enabled,
then all blocks that were released during the last joutnal transaction
are then discarded.

If data=writeback is enabled, then we do *not* flush out any dirty
pages in the page cache that were allocated during the previous
transaction.  This means that if you crash, it is possible that
freshly inodes that contain freshly allocated blocks may have stale
data in those new allocated blocks.  This blocks might include some
other users' e-mails, medical records, cryptographic keys, or other
PII.   Which is why data=ordered is the default.

So if data=ordered and data=writeback makes any difference, the first
question I'd have to ask is whether any dirty pages in the page cache,
or any background writes happening in parallel with the rm -rf
command.

> It seems that ext4_issue_discard() is called ~300 times with data=ordered
> and ~50k times with data=writeback.

ext4_issue_discard() gets called for each contiguous set of blocks
that were released in a particular jbd2 transaction.  So if you are
deleting 100 files, and all of those files are unlinked in a single
transaction, and all of those blocks belonging to those files belong
to a single contiguous block region, then ext4_issue_discard() will be
called only once.  If you delete a single file, but all of its blocks
are heavily fragmented, then ext4_issue_discard() be called a thousand
times.

If you delete 100 files, all of which are contiguous, but each file is
in a different part of the disk, then ext4_issue_discard() might be
called 100 times.

So that implies that your experiment may not be repeatable; did you
make sure the file system was freshly reformatted before you wrote out
the files in the directory you are deleting?  And was the directory
written out in exactly the same way?  And did you make sure all of the
writes were flushed out to disk before you tried timing the "rm -rf"
command?  And did you make sure that there weren't any other processes
running that might be issuing other file system operations (either
data or metadata heavy) that might be interfering with the "rm -rf"
operation?  What kind of storage device were you using?  (An SSD; a
USB thumb drive; some kind of Cloud emulated block device?)

Note that benchmarking the file system operations is *hard*.  When I
worked with a graduate student working on a paper describing a
prototype of a file system enhancement to ext4 to optimize ext4 for
drive-managed SMR drives[1], the graduate student spent *way* more
time getting reliable, repeatable benchmarks than making changes to
ext4 for the prototype.  (It turns out the SMR GC operations caused
variations in write speeds, which meant the writeback throughput
measurements would fluctuate wildly, which then influenced the
writeback cache ratio, which in turn massively influenced the how
aggressively the writeback threads would behave, which in turn
massively influenced the filebench and postmark numbers.)

[1] https://www.usenix.org/conference/fast17/technical-sessions/presentation/aghayev

So there can be variability caused by how blocks are allocated at the
file system; how the SSD is assigning blocks to flash erase blocks;
how the SSD's GC operation influences its write speed, which can in
turn influence the kernel's measured writeback throughput; different
SSD's or Cloud block devices can have very different discard
performance that can vary based on past write history, yadda, yadda,
yadda.

Cheers,

					- Ted
