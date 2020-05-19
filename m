Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68F4C1D916A
	for <lists+linux-ext4@lfdr.de>; Tue, 19 May 2020 09:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbgESHwU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 May 2020 03:52:20 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39573 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728629AbgESHwT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 19 May 2020 03:52:19 -0400
Received: by mail-wm1-f66.google.com with SMTP id w64so2277900wmg.4;
        Tue, 19 May 2020 00:52:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q9ehllzv4GXD6PHjLq8rxZ0NEvwuAG+BryL3jyLoW3I=;
        b=chvmaXWeCwO9URC7bdzrRLP5/Vu52UyX28eW8PAQ8pbRq1UGeAotyEqrbEJ5HKJluP
         JQbPbdGkf7gj+aNSJb89lfoo4XXHAdWXYTvNUSuNatsg+BIEF50WECDfNHY6xDQXv5H1
         ieS1Zf/uYr+pcYxnf6d9Np+y6t5sLVxZo+xs9rJkZ1k4ehaBCjotIfBeyU0os1J4I9Ku
         fAorVWvtyMLjsFaE0QB3OkKkL0yWjBPA1Gy1BPO11yMi1vAH7Y9F3DyQ1EedO7+9Jzme
         ixvhXBvAD+Ofj1QHAGhI6dHtPmbcnuhpvQdsVdJcHLldBX1jvjAOKDyc2MYjVmYp5Zkz
         clWQ==
X-Gm-Message-State: AOAM532PkB5sFKSGodo0LPZuB6od53JDXNPlJYpj8Ss22JzSvlyD+tvL
        3nZQOhYgiIu2A0YpThE8mHY=
X-Google-Smtp-Source: ABdhPJzhMPJJ+bOTnb0XzxprTwcOOTMoZpRkuCsUFILfWTJFhfoKhfdBOE3Io5xf2x700pgQq1fN2w==
X-Received: by 2002:a1c:1902:: with SMTP id 2mr3881648wmz.178.1589874736792;
        Tue, 19 May 2020 00:52:16 -0700 (PDT)
Received: from localhost (ip-37-188-176-234.eurotel.cz. [37.188.176.234])
        by smtp.gmail.com with ESMTPSA id q2sm19274851wrx.60.2020.05.19.00.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 00:52:15 -0700 (PDT)
Date:   Tue, 19 May 2020 09:52:13 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, Chao Yu <chao@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Chao Yu <yuchao0@huawei.com>, lkft-triage@lists.linaro.org
Subject: Re: mm: mkfs.ext4 invoked oom-killer on i386 - pagecache_get_page
Message-ID: <20200519075213.GF32497@dhcp22.suse.cz>
References: <CA+G9fYu2ruH-8uxBHE0pdE6RgRTSx4QuQPAN=Nv3BCdRd2ouYA@mail.gmail.com>
 <20200501135806.4eebf0b92f84ab60bba3e1e7@linux-foundation.org>
 <CA+G9fYsiZ81pmawUY62K30B6ue+RXYod854RS91R2+F8ZO7Xvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYsiZ81pmawUY62K30B6ue+RXYod854RS91R2+F8ZO7Xvw@mail.gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 18-05-20 19:40:55, Naresh Kamboju wrote:
> Thanks for looking into this problem.
> 
> On Sat, 2 May 2020 at 02:28, Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Fri, 1 May 2020 18:08:28 +0530 Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> >
> > > mkfs -t ext4 invoked oom-killer on i386 kernel running on x86_64 device
> > > and started happening on linux -next master branch kernel tag next-20200430
> > > and next-20200501. We did not bisect this problem.
[...]
> Creating journal (131072 blocks): [   31.251333] mkfs.ext4 invoked
> oom-killer: gfp_mask=0x101cc0(GFP_USER|__GFP_WRITE), order=0,
> oom_score_adj=0
[...]
> [   31.500943] DMA free:187396kB min:22528kB low:28160kB high:33792kB
> reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB
> active_file:4736kB inactive_file:431688kB unevictable:0kB
> writepending:62020kB present:783360kB managed:668264kB mlocked:0kB
> kernel_stack:888kB pagetables:0kB bounce:0kB free_pcp:880kB
> local_pcp:216kB free_cma:163840kB

This is really unexpected. You are saying this is a regular i386 and DMA
should be bottom 16MB while yours is 780MB and the rest of the low mem
is in the Normal zone which is completely missing here. How have you got
to that configuration? I have to say I haven't seen anything like that
on i386.

The failing request is GFP_USER so highmem is not really allowed but
free pages are way above watermarks so the allocation should have just
succeeded.

-- 
Michal Hocko
SUSE Labs
