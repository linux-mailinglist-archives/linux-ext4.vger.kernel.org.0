Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2D362B9738
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Nov 2020 17:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbgKSP6w (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Nov 2020 10:58:52 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45423 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728265AbgKSP6v (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Nov 2020 10:58:51 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0AJFwhDs024862
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Nov 2020 10:58:44 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 88C1E420107; Thu, 19 Nov 2020 10:58:43 -0500 (EST)
Date:   Thu, 19 Nov 2020 10:58:43 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Saranya Muruganandam <saranyamohan@google.com>
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca
Subject: Re: [RFC PATCH v3 00/61] Introduce parallel fsck to e2fsck pass1
Message-ID: <20201119155843.GB609857@mit.edu>
References: <20201118153947.3394530-1-saranyamohan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118153947.3394530-1-saranyamohan@google.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Nov 18, 2020 at 07:38:46AM -0800, Saranya Muruganandam wrote:
> Currently it has been popular that single disk could be more than TiB,
> etc 16Tib with only one single disk, with this trend, one single
> filesystem could be larger and larger and easily reach PiB with LUN system.
> 
> The journal filesystem like ext4 need be offline to do regular
> check and repair from time to time, however the problem is e2fsck
> still do this using single thread, this could be challenging at scale
> for two reasons:
> 
> 1) even with readahead, IO speed still limits several tens MiB per second.
> 2) could not utilize CPU cores.
> 
> It could be challenging to try multh-threads for all phase of e2fsck, but as
> first step, we might try this for most time-consuming pass1, according to
> our benchmarking it cost of 80% time for whole e2fck phase.
> 
> Pass1 is trying to scanning all valid inode of filesystem and check it one by
> one, and the patchset idea is trying to split these to different threads and
> trying to do this at the same time, we try to merge these inodes and corresponding
> inode's extent information after threads finish.
> 
> To simplify complexity and make it less error-prone, the fix is still serialized,
> since most of time there will be only minor errors for filesystem, what's important
> for us is parallel reading and checking.
> 
> Here is a benchmarking on our Lustre filesystem with 1.2 PiB OSD ext4 based
> filesystem:
> 
> DDN SFA18KE StorageServer
> DCR(DeClustering RAID) with 162 x HGST 10TB NL-SAS
> Tested Server
> A Virtual Machine running on SFA18KE
> 8 x CPU cores (Xeon(R) Gold 6140)
> 150GB memory
> CentoOS7.7 (Lustre patched kernel)

This introductory patch presumably came from the original patch
series; hence "our Lustre file system".  Just to make it clearer, it's
probably better to make it clear who did which benchmarks.  And
Saranya, you might want to include your benchmark results since it
will be easier for people to replicate.

> I've tested the whole patch series using 'make test' of e2fsck itself, and i
> manually set default threads to 4 which still pass almost of test suite,
> failure cases are below:
> 
> f_h_badroot f_multithread f_multithread_logfile f_multithread_no f_multithread_ok
> 
> h_h_badroot failed because out of order checking output, and others are because
> of extra multiple threads log output.

And this "I" is Saranya, yes?

> Andreas Dilger (2):
>   e2fsck: fix f_multithread_ok test
>   e2fsck: misc cleanups for pfsck
> 
> Li Xi (18):
>   e2fsck: add -m option for multithread
>   e2fsck: copy context when using multi-thread fsck
>   e2fsck: copy fs when using multi-thread fsck
>   e2fsck: add assert when copying context
>   e2fsck: copy bitmaps when copying context
>   e2fsck: open io-channel when copying fs
>   e2fsck: create logs for mult-threads
>   e2fsck: optionally configure one pfsck thread
>   e2fsck: add start/end group for thread
>   e2fsck: split groups to different threads
>   e2fsck: print thread log properly
>   e2fsck: do not change global variables
>   e2fsck: optimize the inserting of dir_info_db
>   e2fsck: merge dir_info after thread finishes
>   e2fsck: merge icounts after thread finishes
>   e2fsck: merge dblist after thread finishes
>   e2fsck: add debug codes for multiple threads
>   e2fsck: merge fs flags when threads finish

The fact that all of these patches are prefixed with e2fsck: hides the
fact that some of these changes include changes to libext2fs.  It's
probably better to separate out the changes to libext2fs so we can pay
special attention to issues of presering the ABI.

I'll talk more about this in the individual patches.

						- Ted
