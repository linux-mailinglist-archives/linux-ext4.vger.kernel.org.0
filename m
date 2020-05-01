Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF4C1C1F2E
	for <lists+linux-ext4@lfdr.de>; Fri,  1 May 2020 23:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgEAU6I (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 1 May 2020 16:58:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:57804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbgEAU6H (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 1 May 2020 16:58:07 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A53E3216FD;
        Fri,  1 May 2020 20:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588366687;
        bh=PHAeuAjto7YSPUcW9IpDpIz6jTr+6+rE49PpUYBb17o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iBbqAgH/8G5kCVKRHKmsayQJh12Ske4yDZYyRWiSbMac1qjEi90aavUHh0afBsqR2
         9b2wMVEluTKDUehCxsaBSkmWlBZUqA3R2Tgc4CVEM8Y4zm0ooqXv/G256MzCeXWp/V
         sn5RY0Y6djNBT/M7VKJ6c65X4E7PnY5aH0OcUQz8=
Date:   Fri, 1 May 2020 13:58:06 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Chao Yu <chao@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-f2fs-devel@lists.sourceforge.net,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Chao Yu <yuchao0@huawei.com>, lkft-triage@lists.linaro.org
Subject: Re: mm: mkfs.ext4 invoked oom-killer on i386 - pagecache_get_page
Message-Id: <20200501135806.4eebf0b92f84ab60bba3e1e7@linux-foundation.org>
In-Reply-To: <CA+G9fYu2ruH-8uxBHE0pdE6RgRTSx4QuQPAN=Nv3BCdRd2ouYA@mail.gmail.com>
References: <CA+G9fYu2ruH-8uxBHE0pdE6RgRTSx4QuQPAN=Nv3BCdRd2ouYA@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, 1 May 2020 18:08:28 +0530 Naresh Kamboju <naresh.kamboju@linaro.org> wrote:

> mkfs -t ext4 invoked oom-killer on i386 kernel running on x86_64 device
> and started happening on linux -next master branch kernel tag next-20200430
> and next-20200501. We did not bisect this problem.

It would be wonderful if you could do so, please.  I can't immediately see
any MM change in this area which might cause this.

> metadata
>   git branch: master
>   git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>   git commit: e4a08b64261ab411b15580c369a3b8fbed28bbc1
>   git describe: next-20200430
>   make_kernelversion: 5.7.0-rc3
>   kernel-config:
> https://builds.tuxbuild.com/1YrE_XUQ6odA52tSBM919w/kernel.config
> 
> Steps to reproduce: (always reproducible)

Reproducibility helps!

> oom-killer: gfp_mask=0x101cc0(GFP_USER|__GFP_WRITE), order=0,

> [   34.793430]  pagecache_get_page+0xae/0x260

> [   34.897923] active_anon:5366 inactive_anon:2172 isolated_anon:0
> [   34.897923]  active_file:4151 inactive_file:212494 isolated_file:0
> [   34.897923]  unevictable:0 dirty:16505 writeback:6520 unstable:0

> [ 34.987678] Normal free:3948kB min:7732kB low:8640kB high:9548kB
> reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB
> active_file:1096kB inactive_file:786400kB unevictable:0kB
> writepending:65432kB present:884728kB managed:845576kB mlocked:0kB
> kernel_stack:1112kB pagetables:0kB bounce:0kB free_pcp:2908kB
> local_pcp:500kB free_cma:0kB

ZONE_NORMAL has a huge amount of clean pagecache stuck on the
inactive list, not being reclaimed.
