Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E3234BE8A
	for <lists+linux-ext4@lfdr.de>; Sun, 28 Mar 2021 21:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhC1TZM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 28 Mar 2021 15:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbhC1TZH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 28 Mar 2021 15:25:07 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D495C061756
        for <linux-ext4@vger.kernel.org>; Sun, 28 Mar 2021 12:25:07 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id h20so3370024plr.4
        for <linux-ext4@vger.kernel.org>; Sun, 28 Mar 2021 12:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SlJwlGc3UW9Kop+4ytJ9ENlMpCbgpwSrbxhlN3RTkfg=;
        b=GFqAqB74qoL0jYxs4f6yMXqVitoVTNRYQDU3PWPrGvSVhfl2DrCFyo4BsJRGmATU8r
         DLOyyIb+wuN8LA8EA+SYQNZdgrGfoNnjKMZBCyvpLIziC8dyl3pS5sGZMGiRIEcF+jW0
         BplQ/7RPt7tMPPjdfxwrvhejZ7NjpyFZbb+q7B/ljePuThb0yXcMWKx7IgrzcsdMTNvF
         6x0lfZFoaXVt6u9b+JUf17Cgdeyb4PM5qzsw0bV9HLXbpz9fkAQyMGPpSS7fdNztntLf
         z9pcNrZUHR98M823drh9mwZZ89L4XFu8OTsraJFTpu+TvJIKGqVfLBqDlZ97JAhEZ4bD
         O55A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SlJwlGc3UW9Kop+4ytJ9ENlMpCbgpwSrbxhlN3RTkfg=;
        b=KA0JFSyGf6rwNz7enOofLqKozi9GR6voB6/fZehP4DtujBQuu57nEW8U/5mOFCr7w6
         KkxRdVXKvc9TXG9k7hEgB7xZq5Z4H/ZOVl6dacSbo9XLbyzLEx00TN2wNyqND3wjj3q2
         9D1ssSJgPSaSlQhwbTsp8gELg1TlOywLWFuRWs1hAgTyps0r8KYfBbT4ohYBS3aC+6R9
         w7eqbxrKY741MrxLGnaP2fQMg95jYk2OOIoEERRo7h/V3Cg1SZLm8/RolhOcGhHm1DbU
         gDRakYhNSBxhs1H+Li/KNQV8zsp6Y9p6wxAqe1wOej7ZtNzZp0qe655FzEr7X+3cYRIl
         SJXg==
X-Gm-Message-State: AOAM533s5E/68nEWHbkQGiGbePDBtxDty7T02PMj4iBHlb/2DhjKzNTY
        M9F44Eh0FaI+DbiCcg2iF4IxTKqdR3s=
X-Google-Smtp-Source: ABdhPJzAg1llaF16PbvhXAtP1KDwjFDvaYgZU79joBDGD7fMPYxL2Zmp5WDeeXbyJMAMab9QfM7p0w==
X-Received: by 2002:a17:90b:4d0f:: with SMTP id mw15mr23608387pjb.92.1616959507094;
        Sun, 28 Mar 2021 12:25:07 -0700 (PDT)
Received: from localhost ([122.182.250.63])
        by smtp.gmail.com with ESMTPSA id f15sm15144363pgr.90.2021.03.28.12.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 12:25:06 -0700 (PDT)
Date:   Mon, 29 Mar 2021 00:55:03 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: Block allocator improvements
Message-ID: <20210328192503.7a5iloagbtbymvx6@riteshh-domain>
References: <20210324231916.2515824-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324231916.2515824-1-harshadshirwadkar@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 21/03/24 04:19PM, Harshad Shirwadkar wrote:
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
> Changes from V4:
> ----------------
> - Only minor fixes, no significant changes
>
> Harshad Shirwadkar (6):
>   ext4: drop s_mb_bal_lock and convert protected fields to atomic
>   ext4: add ability to return parsed options from parse_options
>   ext4: add mballoc stats proc file
>   ext4: add MB_NUM_ORDERS macro
>   ext4: improve cr 0 / cr 1 group scanning
>   ext4: add proc files to monitor new structures
>
>  fs/ext4/ext4.h    |  30 ++-
>  fs/ext4/mballoc.c | 572 +++++++++++++++++++++++++++++++++++++++++++---
>  fs/ext4/mballoc.h |  22 +-
>  fs/ext4/super.c   |  79 +++++--
>  fs/ext4/sysfs.c   |   6 +
>  5 files changed, 652 insertions(+), 57 deletions(-)
>

Completed my review of this patch series.
Apart from the issue I mentioned in patch-5 of this v5 series. The rest
of the patches looks fine to me.

Please feel free to add:
Reviewed-by: Ritesh Harjani <ritesh.list@gmail.com>
