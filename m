Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6CE2B7EE
	for <lists+linux-ext4@lfdr.de>; Mon, 27 May 2019 16:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbfE0Oxc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 May 2019 10:53:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:46218 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726279AbfE0Oxc (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 27 May 2019 10:53:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2F5C6AE74;
        Mon, 27 May 2019 14:53:31 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 52B0D1E3C2F; Mon, 27 May 2019 16:53:29 +0200 (CEST)
Date:   Mon, 27 May 2019 16:53:29 +0200
From:   Jan Kara <jack@suse.cz>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH 3/3] ext4: Gracefully handle ext4_break_layouts() failure
 during truncate
Message-ID: <20190527145329.GG20440@quack2.suse.cz>
References: <20190522090317.28716-1-jack@suse.cz>
 <20190522090317.28716-4-jack@suse.cz>
 <20190525033235.GB4225@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190525033235.GB4225@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 24-05-19 23:32:35, Theodore Ts'o wrote:
> On Wed, May 22, 2019 at 11:03:17AM +0200, Jan Kara wrote:
> > ext4_break_layouts() may fail e.g. due to a signal being delivered.
> > Thus we need to handle its failure gracefully and not by taking the
> > filesystem down. Currently ext4_break_layouts() failure is rare but it
> > may become more common once RDMA uses layout leases for handling
> > long-term page pins for DAX mappings.
> > 
> > To handle the failure we need to move ext4_break_layouts() earlier
> > during setattr handling before we do hard to undo changes such as
> > modifying inode size. To be able to do that we also have to move some
> > other checks which are better done without holding i_mmap_sem earlier.
> > 
> > Reported-and-tested-by: Ira Weiny <ira.weiny@intel.com>
> > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Jan Kara <jack@suse.cz>
> 
> When doing some final testing before sending a pull request to Linus,
> I found a regression.  After bisecting, this patch fails reliably
> under gce-xfstests:
> 
> TESTRUNID: tytso-20190524230226
> KERNEL:    kernel 5.1.0-rc3-xfstests-00039-g079f9927c7bf #1016 SMP Fri May 24 23:00:47 EDT 2019 x86_64
> CMDLINE:   -c 4k generic/092
> CPUS:      2
> MEM:       7680
> 
> ext4/4k: 1 tests, 1 failures, 2 seconds
>   generic/092  Failed   1s
> Totals: 1 tests, 0 skipped, 1 failures, 0 errors, 1s
> 
> FSTESTPRJ: gce-xfstests
> FSTESTVER: fio  fio-3.2 (Fri, 3 Nov 2017 15:23:49 -0600)
> FSTESTVER: quota  62661bd (Tue, 2 Apr 2019 17:04:37 +0200)
> FSTESTVER: xfsprogs v5.0.0 (Fri, 3 May 2019 12:14:36 -0500)
> FSTESTVER: xfstests-bld 9582562 (Sun, 12 May 2019 00:38:51 -0400)
> FSTESTVER: xfstests linux-v3.8-2390-g64233614 (Thu, 16 May 2019 00:12:52 -0400)
> FSTESTCFG: 4k
> FSTESTSET: generic/092
> FSTESTOPT: aex
> GCE ID:    343197219467628221
> 
> generic/092 0s ... 	[23:05:07] [23:05:08]- output mismatch (see /results/ext4/results-4k/generic/092
> .out.bad)
> % diff -u /tmp/results-tytso-20190524230226/ext4/results-4k/generic/092.out.bad /usr/projects/xfstests-bld/build-64/xfstests-dev/tests/generic/092.out 
> --- /tmp/results-tytso-20190524230226/ext4/results-4k/generic/092.out.bad	2019-05-24 23:05:08.000000000 -0400
> +++ /usr/projects/xfstests-bld/build-64/xfstests-dev/tests/generic/092.out	2018-02-13 23:37:20.330097382 -0500
> @@ -2,6 +2,5 @@
>  wrote 5242880/5242880 bytes at offset 0
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  0: [0..10239]: data
> -1: [10240..20479]: unwritten
>  0: [0..10239]: data
>  1: [10240..20479]: unwritten
> 
> 
> Dropping this patch makes the test failure go away.  So I'm going to
> drop it for now.  Jan, can you take a look?  Thanks!!

Ah, right. I wonder how I missed that failure in my test run. Anyway I see
what is the problem. I'll send updated patch.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
