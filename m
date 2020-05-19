Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C63001D9251
	for <lists+linux-ext4@lfdr.de>; Tue, 19 May 2020 10:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgESIpk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 May 2020 04:45:40 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35916 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgESIpk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 19 May 2020 04:45:40 -0400
Received: by mail-wr1-f65.google.com with SMTP id k13so12815342wrx.3;
        Tue, 19 May 2020 01:45:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VLlTscmlbpCKZ4nor9NSeLRkKjW9ch72hYbKNbV2XL8=;
        b=NfXM7akETbG7URg31ox9h9K/LBeQ+CVi20pudJwQP7mXavEN86P21iihMnby12++/N
         E2nDKFayhnaDUUQW7DT0ymnYMjuQJlHgFGQ1eaLeRgS3dmm2bQSgN+/KUNfHqQy8aWx6
         XX+SGglZRC2fu+vNYNYQiLi6EyqiVgcr6BszPP71J1qCGT7EUYEeErChicBrVuaMQoCC
         I11kLWXWQjXLgkKYBJboxJkeEpRyLIoimKTamuvPPWjzPofeLXTVABDfsuu3HNbMt/Fo
         KKEy7yMKE2aXHRmdP+ivr7SstvnulZaFw94K3JfSTIMFqSvadC9qXHjC4UttCtWgYZe2
         xzGw==
X-Gm-Message-State: AOAM531WUQnf1kbpPc7YUUjYzA8dvorXoavmjg+Ulk4xHZmaBQf3XtVp
        XQcSRXZ3ziv1jHVZe2K6bFw=
X-Google-Smtp-Source: ABdhPJwX9uniXfChgB/t9L9lwBsmYEKUSMJMO45yp0yCMYOVHIGMwp7lYEjNDLfh+Oj66I63vmhbKw==
X-Received: by 2002:adf:ed06:: with SMTP id a6mr23890678wro.8.1589877937465;
        Tue, 19 May 2020 01:45:37 -0700 (PDT)
Received: from localhost (ip-37-188-176-234.eurotel.cz. [37.188.176.234])
        by smtp.gmail.com with ESMTPSA id j2sm19737914wrp.47.2020.05.19.01.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 01:45:36 -0700 (PDT)
Date:   Tue, 19 May 2020 10:45:35 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
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
        Theodore Ts'o <tytso@mit.edu>, Chao Yu <chao@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Chao Yu <yuchao0@huawei.com>, lkft-triage@lists.linaro.org
Subject: Re: mm: mkfs.ext4 invoked oom-killer on i386 - pagecache_get_page
Message-ID: <20200519084535.GG32497@dhcp22.suse.cz>
References: <CA+G9fYu2ruH-8uxBHE0pdE6RgRTSx4QuQPAN=Nv3BCdRd2ouYA@mail.gmail.com>
 <20200501135806.4eebf0b92f84ab60bba3e1e7@linux-foundation.org>
 <CA+G9fYsiZ81pmawUY62K30B6ue+RXYod854RS91R2+F8ZO7Xvw@mail.gmail.com>
 <20200519075213.GF32497@dhcp22.suse.cz>
 <CAK8P3a2T_j-Ynvhsqe_FCqS2-ZdLbo0oMbHhHChzMbryE0izAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2T_j-Ynvhsqe_FCqS2-ZdLbo0oMbHhHChzMbryE0izAQ@mail.gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 19-05-20 10:11:25, Arnd Bergmann wrote:
> On Tue, May 19, 2020 at 9:52 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Mon 18-05-20 19:40:55, Naresh Kamboju wrote:
> > > Thanks for looking into this problem.
> > >
> > > On Sat, 2 May 2020 at 02:28, Andrew Morton <akpm@linux-foundation.org> wrote:
> > > >
> > > > On Fri, 1 May 2020 18:08:28 +0530 Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > > >
> > > > > mkfs -t ext4 invoked oom-killer on i386 kernel running on x86_64 device
> > > > > and started happening on linux -next master branch kernel tag next-20200430
> > > > > and next-20200501. We did not bisect this problem.
> > [...]
> > > Creating journal (131072 blocks): [   31.251333] mkfs.ext4 invoked
> > > oom-killer: gfp_mask=0x101cc0(GFP_USER|__GFP_WRITE), order=0,
> > > oom_score_adj=0
> > [...]
> > > [   31.500943] DMA free:187396kB min:22528kB low:28160kB high:33792kB
> > > reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB
> > > active_file:4736kB inactive_file:431688kB unevictable:0kB
> > > writepending:62020kB present:783360kB managed:668264kB mlocked:0kB
> > > kernel_stack:888kB pagetables:0kB bounce:0kB free_pcp:880kB
> > > local_pcp:216kB free_cma:163840kB
> >
> > This is really unexpected. You are saying this is a regular i386 and DMA
> > should be bottom 16MB while yours is 780MB and the rest of the low mem
> > is in the Normal zone which is completely missing here. How have you got
> > to that configuration? I have to say I haven't seen anything like that
> > on i386.
> 
> I think that line comes from an ARM32 beaglebone-X15 machine showing
> the same symptom. The i386 line from the log file that Naresh linked to at
> https://lkft.validation.linaro.org/scheduler/job/1406110#L1223  is less
> unusual:

OK, that makes more sense! At least for the memory layout.
 
> [   34.931663] Node 0 active_anon:21464kB inactive_anon:8688kB
> active_file:16604kB inactive_file:849976kB unevictable:0kB
> isolated(anon):0kB isolated(file):0kB mapped:25284kB dirty:58952kB
> writeback:27772kB shmem:8944kB writeback_tmp:0kB unstable:0kB
> all_unreclaimable? yes
> [   34.955523] DMA free:3356kB min:68kB low:84kB high:100kB
> reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB
> active_file:0kB inactive_file:11964kB unevictable:0kB
> writepending:11980kB present:15964kB managed:15876kB mlocked:0kB
> kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB
> free_cma:0kB
> [   34.983385] lowmem_reserve[]: 0 825 1947 825
> [   34.987678] Normal free:3948kB min:7732kB low:8640kB high:9548kB
> reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB
> active_file:1096kB inactive_file:786400kB unevictable:0kB
> writepending:65432kB present:884728kB managed:845576kB mlocked:0kB
> kernel_stack:1112kB pagetables:0kB bounce:0kB free_pcp:2908kB
> local_pcp:500kB free_cma:0kB

The lowmem is really low (way below the min watermark so even memory
reserves for high priority and atomic requests are depleted. There is
still 786MB of inactive page cache to be reclaimed. It doesn't seem to
be dirty or under the writeback but it still might be pinned by the
filesystem. I would suggest watching vmscan reclaim tracepoints and
check why the reclaim fails to reclaim anything.
-- 
Michal Hocko
SUSE Labs
