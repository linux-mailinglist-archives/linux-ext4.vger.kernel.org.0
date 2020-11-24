Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 977172C1C54
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Nov 2020 04:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbgKXD4o (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Nov 2020 22:56:44 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53487 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727041AbgKXD4n (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 23 Nov 2020 22:56:43 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0AO3ub3X027745
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Nov 2020 22:56:38 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 7D19A420136; Mon, 23 Nov 2020 22:56:37 -0500 (EST)
Date:   Mon, 23 Nov 2020 22:56:37 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Saranya Muruganandam <saranyamohan@google.com>
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca
Subject: Re: [RFC PATCH v3 60/61] e2fsck: propagate number of threads
Message-ID: <20201124035637.GO132317@mit.edu>
References: <20201118153947.3394530-1-saranyamohan@google.com>
 <20201118153947.3394530-61-saranyamohan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118153947.3394530-61-saranyamohan@google.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Nov 18, 2020 at 07:39:46AM -0800, Saranya Muruganandam wrote:
> Sometimes, such as in orphan_inode case, e2fsck_pass1
> is called after reading the block bitmaps. This results in
> reading the block bitmap sequentially and multithreading
> only gets kicked in later. Fix the thread count earlier
> while setting up the file system.

I wonder if read_bitmaps() should be using a different way of
determining how many threads compared to how many threads are used by
e2fsck.

Also, looking more closely, it's not at all clear we should
fs_num_threads should be in the fs structure at all.  It's actually
used in three places.  (a) to influence the default size of a dblist,
if the size is not provided, (b) to influence the default size of an
icount structure, if the size is not provided, (c) to figure out how
many threads are needed in rw_bitmaps.c

(a) and (b) can be dealt with in e2fsck by having e2fsck pass in an
explicit size.  (In fact, for the dblist, we can do a better job by
summing the number of directories in the block group range for each
thread, instead of taking the total number of threads in the group,
and dividing by "the averge number of block groups").

As far as (c) is concerned, perhaps it would be better to make it be
explicit, via a new interface:

errcode_t ext2fs_rw_bitmaps(ext2_filsys fs, int flags, int num_threads);

Where flags is an OR of the following flags:

#define EXT2FS_BITMAPS_WRITE 	      0x0001
#define EXT2FS_BITMAPS_BLOCK 	      0x0002
#define EXT2FS_BITMAPS_INODE 	      0x0004

... and where num_threads is a hint that can be ignored if the
pthreads interface is not available (via a HAVE_PTHREADS autoconf
test).

If we do that, then there's no need to have fs->fs_num_threads at all,
and that can purely be something which is local matter by the
application (e.g., e2fsck, and maybe later other programs like
debugfs's ncheck/icheck commands).

See?  It's really, really important that we have well-defined
interfaces in libext2fs, because that's how we keep tech debt in
e2fsprogs down to a manageable level.

So it might be a good idea to separate out the rw_bitmaps patch() from
the rest of the series, and create a much smaller patch series that
has the autoconf test to see if pthreads are available, and if so, how
it should be linked in (this would also subsume the "fix build for
rpm" patch, except we would make sure that it works for all OS's,
instead of serendiptously when Linux shared libraries were in use, and
then adding a hack when it was noticed that the build configuration
that rpm happened to use wasn't working).

By breaking down the patch series, we can make sure each change is
done cleanly, and portably, and then we can use the individual pieces
to to parallelize e2fsck.  This will probably be better than trying to
deal with this whole patch series as a monolithic thing.

What do folks think?

					- Ted
