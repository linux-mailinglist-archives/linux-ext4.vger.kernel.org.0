Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18A8A3E3DCE
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Aug 2021 03:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbhHIBv4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 8 Aug 2021 21:51:56 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:51939 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230076AbhHIBvz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 8 Aug 2021 21:51:55 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1791pNjW019581
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 8 Aug 2021 21:51:24 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id B2A7715C3E25; Sun,  8 Aug 2021 21:51:23 -0400 (EDT)
Date:   Sun, 8 Aug 2021 21:51:23 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     ValdikSS <iam@valdikss.org.ru>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: ext4lazyinit reads HDD data on mount since 5.13
Message-ID: <YRCKG1V/OBuble40@mit.edu>
References: <015c7506-7f33-3967-772a-1285b0f1052f@valdikss.org.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <015c7506-7f33-3967-772a-1285b0f1052f@valdikss.org.ru>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Aug 09, 2021 at 01:13:03AM +0300, ValdikSS wrote:
> Hello,
> After updating to kernel 5.13, my ext4 partition is read for ~20 seconds
> upon mounting by ext4lazyinit. It does not write anything, only reads
> (inspected with iotop), and it does so only on mount and only for relatively
> short amount of time.
> 
> My partition is several years old and have been fully initialized long ago.
> Mounting with `init_itable=0` did not change anything: ext4lazyinit does not
> write anything to begin with.
> 
> 5.12.15 does not have such behavior. Did I miss a configuration change? Is
> that a regression or a new feature?

It's a new feature which optimizes block allocations for very large
file systems.  The work being done by ext4lazyinit is to read the
block allocation bitmaps so we can cache the buddy bitmaps and how
fragmented (or not) various block groups are, which is used to
optimize the block allocator.

Quoting from the commit description for 196e402adf2e:

    With this patchset, following experiment was performed:
    
    Created a highly fragmented disk of size 65TB. The disk had no
    contiguous 2M regions. Following command was run consecutively for 3
    times:
    
    time dd if=/dev/urandom of=file bs=2M count=10
    
    Here are the results with and without cr 0/1 optimizations introduced
    in this patch:
    
    |---------+------------------------------+---------------------------|
    |         | Without CR 0/1 Optimizations | With CR 0/1 Optimizations |
    |---------+------------------------------+---------------------------|
    | 1st run | 5m1.871s                     | 2m47.642s                 |
    | 2nd run | 2m28.390s                    | 0m0.611s                  |
    | 3rd run | 2m26.530s                    | 0m1.255s                  |
    |---------+------------------------------+---------------------------|

The timings are done with a freshly mounted file system; the
prefetched block bitmaps plus the mballoc optimizations more than
doubles the time to allocate a 20 MiB file on a highly fragmented file
system.

Cheers,

					- Ted
