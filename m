Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8251DB269
	for <lists+linux-ext4@lfdr.de>; Wed, 20 May 2020 13:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbgETL4c (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 20 May 2020 07:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbgETL4b (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 20 May 2020 07:56:31 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD08C061A0F
        for <linux-ext4@vger.kernel.org>; Wed, 20 May 2020 04:56:31 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id h188so2124405lfd.7
        for <linux-ext4@vger.kernel.org>; Wed, 20 May 2020 04:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c8qp29x57Bnw83ildG5bfYkgdHVhrczJ6/NyvfJLqdw=;
        b=qlgXHVmEwhlw8sQKewHDsuWMSreqtLqu7J0G2FobOqDX6oBRZuV/ovWE3ANMJBrQ/R
         VHSrnEzZvSTDxoGM3/zD4+VTvhNG0yaVzAa7lwGqABFXOzXetvh0ERA4i6G5tYAoy+YR
         Qr6jPv+xDkynFLCazHC8VGxm8nKlCbFmrG5Kj91mWASiJARiWqfoR7ILN0Zk3nndZglm
         xfojJ2HA3S+ljjrJhP5FQNxiCPqhXs7R18c5zKgCMh12Zewow13rinQNy8sr0PEtMvmD
         gPqjH0dG3srB+Q4snOOPhnSigEJYiArkGSq8les+OJeIhHLgVWpVkJPP+TTaSgnYuQhJ
         AIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c8qp29x57Bnw83ildG5bfYkgdHVhrczJ6/NyvfJLqdw=;
        b=JECMAiaAIKvn69NQBBhNsFmVgppSJyFq4UMw5t+3ow9SWWq+wXU4dYZU7bPqs8hRnl
         9NuuVow6w3tRJiNUrU5PaEdrhPIrr0qWiFCiJ3GHjhp1FFxHvn1pHOIG7atOmMSIfXB8
         qciH6RzhCXo39DAM2ZWddmpBEHtls6mnMRFBiFsHXyTP3DfdsTh2BvOJZaySBS4L5fGi
         92330CMHxvoOkic3DG9mgin7m2bgjn2359hCbc8pkZ7/jqaWEbfvAnub7r11pTQgEVL1
         dYcQsf2UqctbU/dEsogABPnzaYIpFU00/tzrSAP08G9RfMGiVcCfoJRyK5/mCScomjc4
         GBbA==
X-Gm-Message-State: AOAM530TGAsy1v6V2/4UJGgh73Kbola9+NH7A2IzPOl/Z8S3Nw2dma4Z
        l7V4dAO/dfCkgXWO1yFz7V8Wpf+YbQVVcrbxmDoHiQ==
X-Google-Smtp-Source: ABdhPJwm4d8MeeXVBkReCSgeKef0/TrHxDY6JMkbe05871VEuSEJIfm5/eJuCpE32/mb9LC8RnbJH+gDczs7BL2boVk=
X-Received: by 2002:a19:8453:: with SMTP id g80mr2422388lfd.167.1589975789287;
 Wed, 20 May 2020 04:56:29 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYu2ruH-8uxBHE0pdE6RgRTSx4QuQPAN=Nv3BCdRd2ouYA@mail.gmail.com>
 <20200501135806.4eebf0b92f84ab60bba3e1e7@linux-foundation.org>
 <CA+G9fYsiZ81pmawUY62K30B6ue+RXYod854RS91R2+F8ZO7Xvw@mail.gmail.com>
 <20200519075213.GF32497@dhcp22.suse.cz> <CAK8P3a2T_j-Ynvhsqe_FCqS2-ZdLbo0oMbHhHChzMbryE0izAQ@mail.gmail.com>
 <20200519084535.GG32497@dhcp22.suse.cz>
In-Reply-To: <20200519084535.GG32497@dhcp22.suse.cz>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 20 May 2020 17:26:17 +0530
Message-ID: <CA+G9fYvzLm7n1BE7AJXd8_49fOgPgWWTiQ7sXkVre_zoERjQKg@mail.gmail.com>
Subject: Re: mm: mkfs.ext4 invoked oom-killer on i386 - pagecache_get_page
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Linux F2FS DEV, Mailing List" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Chao Yu <chao@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Chao Yu <yuchao0@huawei.com>, lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

FYI,

This issue is specific on 32-bit architectures i386 and arm on linux-next tree.
As per the test results history this problem started happening from
Bad : next-20200430
Good : next-20200429

steps to reproduce:
dd if=/dev/disk/by-id/ata-SanDisk_SSD_PLUS_120GB_190504A00573
of=/dev/null bs=1M count=2048
or
mkfs -t ext4 /dev/disk/by-id/ata-SanDisk_SSD_PLUS_120GB_190804A00BE5


Problem:
[   38.802375] dd invoked oom-killer: gfp_mask=0x100cc0(GFP_USER),
order=0, oom_score_adj=0

i386 crash log:  https://pastebin.com/Hb8U89vU
arm crash log: https://pastebin.com/BD9t3JTm

On Tue, 19 May 2020 at 14:15, Michal Hocko <mhocko@kernel.org> wrote:
>
> On Tue 19-05-20 10:11:25, Arnd Bergmann wrote:
> > On Tue, May 19, 2020 at 9:52 AM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > On Mon 18-05-20 19:40:55, Naresh Kamboju wrote:
> > > > Thanks for looking into this problem.
> > > >
> > > > On Sat, 2 May 2020 at 02:28, Andrew Morton <akpm@linux-foundation.org> wrote:
> > > > >
> > > > > On Fri, 1 May 2020 18:08:28 +0530 Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > > > >
> > > > > > mkfs -t ext4 invoked oom-killer on i386 kernel running on x86_64 device
> > > > > > and started happening on linux -next master branch kernel tag next-20200430
> > > > > > and next-20200501. We did not bisect this problem.
> > > [...]
> > > > Creating journal (131072 blocks): [   31.251333] mkfs.ext4 invoked
> > > > oom-killer: gfp_mask=0x101cc0(GFP_USER|__GFP_WRITE), order=0,
> > > > oom_score_adj=0
> > > [...]
> > > > [   31.500943] DMA free:187396kB min:22528kB low:28160kB high:33792kB
> > > > reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB
> > > > active_file:4736kB inactive_file:431688kB unevictable:0kB
> > > > writepending:62020kB present:783360kB managed:668264kB mlocked:0kB
> > > > kernel_stack:888kB pagetables:0kB bounce:0kB free_pcp:880kB
> > > > local_pcp:216kB free_cma:163840kB
> > >
> > > This is really unexpected. You are saying this is a regular i386 and DMA
> > > should be bottom 16MB while yours is 780MB and the rest of the low mem
> > > is in the Normal zone which is completely missing here. How have you got
> > > to that configuration? I have to say I haven't seen anything like that
> > > on i386.
> >
> > I think that line comes from an ARM32 beaglebone-X15 machine showing
> > the same symptom. The i386 line from the log file that Naresh linked to at
> > https://lkft.validation.linaro.org/scheduler/job/1406110#L1223  is less
> > unusual:
>
> OK, that makes more sense! At least for the memory layout.
>
> > [   34.931663] Node 0 active_anon:21464kB inactive_anon:8688kB
> > active_file:16604kB inactive_file:849976kB unevictable:0kB
> > isolated(anon):0kB isolated(file):0kB mapped:25284kB dirty:58952kB
> > writeback:27772kB shmem:8944kB writeback_tmp:0kB unstable:0kB
> > all_unreclaimable? yes
> > [   34.955523] DMA free:3356kB min:68kB low:84kB high:100kB
> > reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB
> > active_file:0kB inactive_file:11964kB unevictable:0kB
> > writepending:11980kB present:15964kB managed:15876kB mlocked:0kB
> > kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB
> > free_cma:0kB
> > [   34.983385] lowmem_reserve[]: 0 825 1947 825
> > [   34.987678] Normal free:3948kB min:7732kB low:8640kB high:9548kB
> > reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB
> > active_file:1096kB inactive_file:786400kB unevictable:0kB
> > writepending:65432kB present:884728kB managed:845576kB mlocked:0kB
> > kernel_stack:1112kB pagetables:0kB bounce:0kB free_pcp:2908kB
> > local_pcp:500kB free_cma:0kB
>
> The lowmem is really low (way below the min watermark so even memory
> reserves for high priority and atomic requests are depleted. There is
> still 786MB of inactive page cache to be reclaimed. It doesn't seem to
> be dirty or under the writeback but it still might be pinned by the
> filesystem. I would suggest watching vmscan reclaim tracepoints and
> check why the reclaim fails to reclaim anything.
> --
> Michal Hocko
> SUSE Labs
