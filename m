Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29AB335A379
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Apr 2021 18:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbhDIQgU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Apr 2021 12:36:20 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52831 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232395AbhDIQgT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Apr 2021 12:36:19 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 139Ga3CO013045
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Apr 2021 12:36:04 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6CEF015C3B12; Fri,  9 Apr 2021 12:36:03 -0400 (EDT)
Date:   Fri, 9 Apr 2021 12:36:03 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH v6 0/7] Block Allocator Improvements
Message-ID: <YHCCc5UKANOd2VbQ@mit.edu>
References: <20210401172129.189766-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401172129.189766-1-harshadshirwadkar@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks, I've applied this patch series into the ext4 git tree.

	     	     	  	- Ted

On Thu, Apr 01, 2021 at 10:21:22AM -0700, Harshad Shirwadkar wrote:
> This patch series improves cr 0 and cr 1 passes of the allocator
> signficantly. Currently, at cr 0 and 1, we perform linear lookups to
> find the matching groups. That's very inefficient for large file
> systems where there are millions of block groups. At cr 0, we only
> care about the groups that have the largest free order >= the
> request's order and at cr 1 we only care about groups where average
> fragment size > the request size. so, this patchset introduces new
> data structures that allow us to perform cr 0 lookup in constant time
> and cr 1 lookup in log (number of groups) time instead of linear.
> 
> For cr 0, we add a list for each order and all the groups are enqueued
> to the appropriate list based on the largest free order in its buddy
> bitmap. This allows us to lookup a match at cr 0 in constant time.
> 
> For cr 1, we add a new rb tree of groups sorted by largest fragment
> size. This allows us to lookup a match for cr 1 in log (num groups)
> time.
> 
> These optimizations can be enabled by passing "mb_optimize_scan" mount
> option.
> 
> These changes may result in allocations to be spread across the block
> device. While that would not matter some block devices (such as flash)
> it may be a cause of concern for other block devices that benefit from
> storing related content togetther such as disk. However, it can be
> argued that in high fragmentation scenrio, especially for large disks,
> it's still worth optimizing the scanning since in such cases, we get
> cpu bound on group scanning instead of getting IO bound. Perhaps, in
> future, we could dynamically turn this new optimization on based on
> fragmentation levels for such devices.
> 
> Verified that there are no regressions in smoke tests (-g quick -c 4k).
> 
> Also, to demonstrate the effectiveness for the patch series, following
> experiment was performed:
> 
> Created a highly fragmented disk of size 65TB. The disk had no
> contiguous 2M regions. Following command was run consecutively for 3
> times:
> 
> time dd if=/dev/urandom of=file bs=2M count=10
> 
> Here are the results with and without cr 0/1 optimizations:
> 
> |---------+------------------------------+---------------------------|
> |         | Without CR 0/1 Optimizations | With CR 0/1 Optimizations |
> |---------+------------------------------+---------------------------|
> | 1st run | 5m1.871s                     | 2m47.642s                 |
> | 2nd run | 2m28.390s                    | 0m0.611s                  |
> | 3rd run | 2m26.530s                    | 0m1.255s                  |
> |---------+------------------------------+---------------------------|
> 
> The patch [3/6] "ext4: add mballoc stats proc file" is a modified
> version of the patch originally written by Artem Blagodarenko
> (artem.blagodarenko@gmail.com). With that patch, I ran following
> command with and without optimizations.
> 
> dd if=/dev/zero of=/mnt/file bs=2M count=2 conv=fsync
> 
> Without optimizations:
> 
> useless_c0_loops: 3
> useless_c1_loops: 39
> useless_c2_loops: 0
> useless_c3_loops: 0
> 
> With optimizations:
> 
> useless_c0_loops: 0
> useless_c1_loops: 0
> useless_c2_loops: 0
> useless_c3_loops: 0
> 
> This shows that CR0 and CR1 optimizations get rid of useless CR0 and
> CR1 loops altogether thereby significantly reducing the number of
> groups that get considered.
> 
> Changes from V5:
> ----------------
> - Turned block bitmap prefetching on by default
> - Fixed a bug where for cr >= 2, we were skipping first group without
>   searching in it
> - Renamed mb_linear_limit to mb_max_linear_groups
> 
> Harshad Shirwadkar (7):
>   ext4: drop s_mb_bal_lock and convert protected fields to atomic
>   ext4: add ability to return parsed options from parse_options
>   ext4: add mballoc stats proc file
>   ext4: add MB_NUM_ORDERS macro
>   ext4: improve cr 0 / cr 1 group scanning
>   ext4: add proc files to monitor new structures
>   ext4: make prefetch_block_bitmaps default
> 
>  fs/ext4/ext4.h    |  34 ++-
>  fs/ext4/mballoc.c | 590 +++++++++++++++++++++++++++++++++++++++++++---
>  fs/ext4/mballoc.h |  22 +-
>  fs/ext4/super.c   |  92 +++++---
>  fs/ext4/sysfs.c   |   6 +
>  5 files changed, 680 insertions(+), 64 deletions(-)
> 
> -- 
> 2.31.0.291.g576ba9dcdaf-goog
> 
