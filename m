Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4688F26CDB4
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Sep 2020 23:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgIPVEJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Sep 2020 17:04:09 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:55796 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728494AbgIPVD7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Sep 2020 17:03:59 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 08GL3rRr021813
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Sep 2020 17:03:53 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id D6E7242004D; Wed, 16 Sep 2020 17:03:52 -0400 (EDT)
Date:   Wed, 16 Sep 2020 17:03:52 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Wang Shilong <wangshilong1991@gmail.com>,
        saranyamohan@google.com, harshads@google.com
Subject: Re: Fwd: [PATCH] [RFC] ext2fs: parallel bitmap loading
Message-ID: <20200916210352.GD38283@mit.edu>
References: <CA+OwuSj-WjaPbfOSDpg5Mz2tm_W0p40N-L=meiWEDZ6j1ccq=Q@mail.gmail.com>
 <132401FE-6D25-41B3-99D1-50E7BC746237@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <132401FE-6D25-41B3-99D1-50E7BC746237@dilger.ca>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Sep 04, 2020 at 03:34:26PM -0600, Andreas Dilger wrote:
> This is a patch that is part of the parallel e2fsck series that Shilong is working on,
> and does not work by itself, but was requested during discussion on the ext4
> concall today.

Andreas, thanks for sending this patch.  (Also available at[1].)

[1] https://lore.kernel.org/linux-ext4/132401FE-6D25-41B3-99D1-50E7BC746237@dilger.ca/

I took look at it, and there are a number of issues with it.  First of
all, there seems to be an assumption that (a) the number of threads is
less than the number of block groups, and (b) the number of threads
can evenly divide the number of block groups.  So for example, if the
number of block groups is prime, or if you are trying to use say, 8 or
16 threads, and the number of block groups is odd, the code in
question will not do the right thing.

(a) meant that attempting to run the e2fsprogs regression test suite
caused most of the test cases to fail with e2fsck crashing due to
buffer overruns.  I fixed this by changing the number of threads to be
16, or if 16 was greater than the number of block groups, to be the
number of block groups, just for debugging purposes.  However, there
were still a few regression test failures.

I also then tried to use a file system that we had been using for
testing fragmentation issues.  The file system was creating a 10GB
virtual disk, and then running these commands:

   DEV=/dev/sdc
   mke2fs -t ext4 $DEV 10G
   mount $DEV /mnt
   pushd /mnt
   for t in $(seq 1 6144) ; do
       for i in $(seq 1 25) ; do
           fallocate tb$t-8mb-$i -l 8M
       done
       for i in $(seq 1 2) ; do
           fallocate tb$t-400mb-$i -l 400M
       done
   done
   popd
   umount /mnt

With the patch applied, all of the threads failed with error code 22
(EINVAL), except for one which failed with a bad block group checksum
error.  I haven't had a chance to dig into further; but I was hoping
that Shilong and/or Saranya might be able to take closer look at that.

But the other thing that we might want to consider is to add
demand-loading of the block (or inode) bitmap.  We got a complaint
that "e2fsck -E journal_only" was super-slow whereas running the
journal by mounting and unmounting the file system was much faster.
The reason, of course, was because the kernel was only reading those
bitmap blocks that are needed to be modified by the orphaned inode
processing, whereas with e2fsprogs, we have to read in all of the
bitmap blocks whether this is necessary or not.

So another idea that we've talked about is teaching libext2fs to be
able to demand load the bitmap, and then when we write out the block
bitmap, we only need to write out those blocks that were loaded.  This
would also speed up running debugfs to examine the file system, as
well as running fuse2fs.  Fortunately, we have abstractions in front
of all of the bitmap accessor functions, and the code paths that would
need to be changed to add demand-loading of bitmaps should be mostly
exclusive of the changes needed for parallel bitmap loading.  So if
Shilong has time to look at making the parallel bitmap loader more
robust, perhaps Saranya could work on the demand-loading idea.

Or if Shilong doesn't have time to try to polish this parallel bitmap
loading changes, we could have Saranya look at clean it up --- since
regardless of whether we implement demand-loading or not, parallel
bitmap reading is going to be useful for some use cases (e.g., a full
fsck, dumpe2fs, or e2image).

What do folks think?

						- Ted
