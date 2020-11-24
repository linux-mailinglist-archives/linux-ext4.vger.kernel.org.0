Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D169D2C1B97
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Nov 2020 03:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbgKXCpJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Nov 2020 21:45:09 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45004 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728120AbgKXCpJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 23 Nov 2020 21:45:09 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0AO2j0ua009772
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Nov 2020 21:45:00 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id CF782420136; Mon, 23 Nov 2020 21:44:59 -0500 (EST)
Date:   Mon, 23 Nov 2020 21:44:59 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Saranya Muruganandam <saranyamohan@google.com>
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca,
        Wang Shilong <wshilong@ddn.com>
Subject: Re: [RFC PATCH v3 46/61] ext2fs: parallel bitmap loading
Message-ID: <20201124024459.GN132317@mit.edu>
References: <20201118153947.3394530-1-saranyamohan@google.com>
 <20201118153947.3394530-47-saranyamohan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118153947.3394530-47-saranyamohan@google.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Nov 18, 2020 at 07:39:32AM -0800, Saranya Muruganandam wrote:
> From: Wang Shilong <wshilong@ddn.com>
> 
> In our benchmarking for PiB size filesystem, pass5 takes
> 10446s to finish and 99.5% of time takes on reading bitmaps.
> 
> It makes sense to reading bitmaps using multiple threads,
> a quickly benchmark show 10446s to 626s with 64 threads.
> 
> Signed-off-by: Wang Shilong <wshilong@ddn.com>
> Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>

Note: This patch will *explode* with much hilarity if num_threads is
greater than the number of block groups.  That's because the
ext2fs_get_avg_group() will return 1 if fs_num_threads is greater than
group_desc_count.

This will result in the group start and end limits to go beyond the
array boundaries.... and then *boom*.  So there will probably need to
be some kind of safety checks if the caller has set fs_num_threads to
a value which is much larger than is appropriate for a given file
system.


Speaking of which, relying on fs_num_threads being set by e2fsck means
that we won't get the benefits of the parallel block bitmap reads for
debugfs and dumpe2fs.  So we should think about how the other tools
should trigger read bitmaps.  And this might be something that we want
to do independent of whether we are doing parallel fsck.

Suggested approach:

1) Create create ext2fs_is_device_rotational() which returns whether
or not a particular device is a HDD, or a non-rotational device (e.g.,
SSD, GCE PD, AWS EBS, etc.), using rotational as a proxy for "reading
using multiple threads is a good thing".

2) Create an ext2fs_get_num_procs() which calls
sysconf(_SC_NPROCESSOR_ONLN) if sysconf and _SC_NPROESSOR_ONLN is
available.  If not, there may be other OS-specific ways of determining
the number of CPU's available.

3) If HAVE_PTHREADS and the number of block groups is greater than the
number of CPU's * 2, a function that (for now) we drop in libsupport
will set fs->fs_num_threads to the number of processors as the
default.  There may not be a reason to change the default for debugfs
and dumpe2fs, but for e2fsck, this would be used for the default, but
it could be over-ridden via "-E multithread=<number of threads>".

   	    		    			       - Ted
