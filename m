Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1A014C10F
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Jan 2020 20:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgA1TeT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Jan 2020 14:34:19 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:49356 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726291AbgA1TeT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 28 Jan 2020 14:34:19 -0500
Received: from callcc.thunk.org (guestnat-104-133-9-100.corp.google.com [104.133.9.100] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 00SJYEKP026083
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jan 2020 14:34:15 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 73605420324; Tue, 28 Jan 2020 14:34:12 -0500 (EST)
Date:   Tue, 28 Jan 2020 14:34:12 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Colin Zou <colin.zou@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: Help: ext4 jbd2 IO requests slow down fsync
Message-ID: <20200128193412.GH115399@mit.edu>
References: <CACZyaBsCb7KxQce27C79WhD5BKekq4Gi4z_P4h_xYvQ8_zv26A@mail.gmail.com>
 <20200125015720.GJ147870@mit.edu>
 <CACZyaBvcMqZosWfvNwWJt2+dihRJGybe4O0_Q67a+wxn3ci4cA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACZyaBvcMqZosWfvNwWJt2+dihRJGybe4O0_Q67a+wxn3ci4cA@mail.gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jan 27, 2020 at 08:55:04PM -0800, Colin Zou wrote:
> Thanks for the information and analysis. I then did more tests. My app
> runs random 4KB workloads on SSD device, one write followed by one
> fsync. Here are the FIO test simulating the workload and the test
> results. Please help to take a look and let me know what you think.

What changed and didn't between the two tests?  I see you went between
the 3.2 kernel and the 4.4 kernel.  Was the hardware held constant?
What about the file system configuration?  Did you use a freshly
formated file systems before running each test?  What file system
configuration?  Ext4 tends to enable 64-bit support, and 256-byte
inodes, and journal checksums.  On much older versions of e2fsprogs,
an ext3 file system may be using 128-byte inodes.

I see that your test is one where you are using buffered I/O and
running an fsync after each 12k write.  With that sort of workload,
differences caused by ext4's use of delayed allocation would be
largely mooted; in both cases, data block writes would *have* to be
forced out as part of the fsync operation.

So something else is going on.  Looking at the output of dumpe2fs -h
on both file systems would be useful.  You can also try creating a
file system using mke2fs -t ext3 and mounting it with -t ext3 (making
sure CONFIG_FS_EXT3 is enabled on the 4.4 kernel) and see what sort of
results you see from that.  Although the ext3 code was removed from
the 4.4 kernels, we do have an ext3 emulation mode that disables all
of the ext4 optimizations and uses the ext3 style algorithms.

Note that with newer versions of e2fsprogs, the default inode size is
now 256 bytes, even if you create the file system using "mke2fs -t
ext3" or "mkfs.ext3".  The decision to go to a larger inode size was
to optimize SELinux performance, but if you're using a really ancient
distro, you might have an equally ancient version of e2fsprogs that is
using a 128 byte inode.  A smaller inode means we can put more inodes
in a 4k block, and this can decrease the need for metadata updates.
This could very much be an issue with this workload, since you there
are 32 thread writing in parallel.

The other thing that could be going on is that ext3 had a really,
really stupid allocator that doens't try to keep files contiguous.
Combined with the lack of preallocation, and a workload which has 32
threads doing "write 32k, fsync", it's very likely that the files are
horribly fragmented.  Using a 4 file example:

         BLOCKS
File A:  100, 101, 102, 112, 113, 114, 124, 125, 126, ...
File B:  103, 104, 105, 115, 116, 117, 127, 128, 129, ...
File C:  106, 107, 108, 118, 119, 120, 130, 131, 132, ...
File D:  109, 110, 111, 121, 122, 123, 133, 134, 135, ...

But what it does mean is that workload could have a very sequential
I/O *pattern*.

100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, <CACHE FLUSH>
112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, <CACHE FLUSH>

With ext4 (and even ext4 in "ext3 emulation mode") the write patterns
will be less sequential, but the resulting files will be much more
contiguous.  And this could be causing the SSD to take more time to do
the write requests and the cache flush operations.

That could very well be what you are seeing.  Is your benchmark
workload of parallel, buffered writes with fsync's every 12k really
representative of what your workload is actually doing in production?

	       	       		   	    	     - Ted
