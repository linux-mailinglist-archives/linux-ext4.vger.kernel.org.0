Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 060AE1D91CB
	for <lists+linux-ext4@lfdr.de>; Tue, 19 May 2020 10:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgESILt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 May 2020 04:11:49 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:32807 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgESILs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 19 May 2020 04:11:48 -0400
Received: from mail-qk1-f180.google.com ([209.85.222.180]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MMG6Y-1jJyQo3ZBe-00JIG7; Tue, 19 May 2020 10:11:45 +0200
Received: by mail-qk1-f180.google.com with SMTP id g185so13774114qke.7;
        Tue, 19 May 2020 01:11:44 -0700 (PDT)
X-Gm-Message-State: AOAM530DaOx6VGD4hAtL1MtDchRPiAqc8ofyewQS4diTO0MnWW+lLrUg
        4oN4bcjyKAHfcf+Wz1vur9k4+YZZBgETN85Y6iQ=
X-Google-Smtp-Source: ABdhPJx6XgbSzoT+qvNjdY9pWlEyJs3vEhdbk/bed0qIGoM1ay/d49G6y8ZoK1QmCZ9OPzgrrkMiO8yQSdyKoKqOetU=
X-Received: by 2002:a37:aa82:: with SMTP id t124mr18447360qke.3.1589875903344;
 Tue, 19 May 2020 01:11:43 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYu2ruH-8uxBHE0pdE6RgRTSx4QuQPAN=Nv3BCdRd2ouYA@mail.gmail.com>
 <20200501135806.4eebf0b92f84ab60bba3e1e7@linux-foundation.org>
 <CA+G9fYsiZ81pmawUY62K30B6ue+RXYod854RS91R2+F8ZO7Xvw@mail.gmail.com> <20200519075213.GF32497@dhcp22.suse.cz>
In-Reply-To: <20200519075213.GF32497@dhcp22.suse.cz>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 19 May 2020 10:11:25 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2T_j-Ynvhsqe_FCqS2-ZdLbo0oMbHhHChzMbryE0izAQ@mail.gmail.com>
Message-ID: <CAK8P3a2T_j-Ynvhsqe_FCqS2-ZdLbo0oMbHhHChzMbryE0izAQ@mail.gmail.com>
Subject: Re: mm: mkfs.ext4 invoked oom-killer on i386 - pagecache_get_page
To:     Michal Hocko <mhocko@kernel.org>
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
        "Theodore Ts'o" <tytso@mit.edu>, Chao Yu <chao@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Chao Yu <yuchao0@huawei.com>, lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:2/mAmEdLTn1HGgMYfMHYI+jtPMkkNSk61dkTTHTMQH78jKNjHU0
 /MgCf92uJ27qRjxKmEqcmyBuW+bQhtuYlH4oo+3kZVwSbR9mwCoXoDGR9yg5IiFN02jdIf+
 MW7go5jPQhVxGK34JppEJKAwvA3tJhq55I3YPzfRPY9AHeVt1GJel0JEkN/uBcFXRtHvEco
 ab9CQEc7l/7/7HkRM9OWA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6KykcjFhjmQ=:LLXV0qw1dXrPKBJyO7uXLI
 S7ohXmM68ZCBLiT1sDMs0CPPwQRzxCCPtR8DzAJizCdb/qwlOFkjz6GUN74SObx0g6xGgmM+a
 x3xjIMoAAs9Ec8LvidgLlDzvronTa/nKK9TKZDCcVYnbIJrKd1NORcRfG0BLKfFb1hJMnykH1
 a+ilOJpLl99n7nH3klZJL3NppTKLUJJAvEc+sO+BzRxe3pIpIkzrfGZFT8kGUhO6SMwRB9TIH
 miiuWcNCBUwJ7nsoL7IhQzrZrVoEipUHOsGpNGx8UzMaZkM1Xnbhq4iPazBu0hBuy09i8VogG
 Jc04uj9CcVfJJqRJ1N+bCV8xuZo9M6thWI8hl1NPE+EU71PsNCdkqEXhFNZDv1UXqU9Vrfry5
 O8tWru8gdILfzQBi7OdHEOrFeUeQEIfZ2lI6vczGDRNbgmCXKJ4+UH5zJcheDuWoRqRuiP4J1
 M6bI7uqJiZbsLk71SpW2XJFtKqh9P3kmZcwUZq6YxQBxxPm2fq9xKAu4PYI60SsdLUiNp82ea
 yhWlGasyUUTAO7k1Jb73KuoL0Aumoj75/mxfrkO6fFEA30+oSNEDB7c5ZGnW4iogqi8/1vlt9
 XwIjSBExYqCIj7PqUj2ue6SDJbfjUwrUQclmDfomglAJ0j8JeowbDbhLKuAxPP6pyl7oLUZUq
 UCdaxwDKOGx6EZIb8Fu2vw13sgG/Rsjs5m44IqCCBsxvLjQUYo/FfIjAHPE4plVh41VHpFJpT
 GAhWuw+qNbtM4q6w/rlx3DsWI7oospXsSTkOsASShFRdsG0SiNBv1ueb29mn4UKwunXUpwQD0
 HMhCgPFcf3IaVVGWzRM8lee5MUz1ThcGaCRjrCdOZ3RAgjx+U4=
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, May 19, 2020 at 9:52 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Mon 18-05-20 19:40:55, Naresh Kamboju wrote:
> > Thanks for looking into this problem.
> >
> > On Sat, 2 May 2020 at 02:28, Andrew Morton <akpm@linux-foundation.org> wrote:
> > >
> > > On Fri, 1 May 2020 18:08:28 +0530 Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > >
> > > > mkfs -t ext4 invoked oom-killer on i386 kernel running on x86_64 device
> > > > and started happening on linux -next master branch kernel tag next-20200430
> > > > and next-20200501. We did not bisect this problem.
> [...]
> > Creating journal (131072 blocks): [   31.251333] mkfs.ext4 invoked
> > oom-killer: gfp_mask=0x101cc0(GFP_USER|__GFP_WRITE), order=0,
> > oom_score_adj=0
> [...]
> > [   31.500943] DMA free:187396kB min:22528kB low:28160kB high:33792kB
> > reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB
> > active_file:4736kB inactive_file:431688kB unevictable:0kB
> > writepending:62020kB present:783360kB managed:668264kB mlocked:0kB
> > kernel_stack:888kB pagetables:0kB bounce:0kB free_pcp:880kB
> > local_pcp:216kB free_cma:163840kB
>
> This is really unexpected. You are saying this is a regular i386 and DMA
> should be bottom 16MB while yours is 780MB and the rest of the low mem
> is in the Normal zone which is completely missing here. How have you got
> to that configuration? I have to say I haven't seen anything like that
> on i386.

I think that line comes from an ARM32 beaglebone-X15 machine showing
the same symptom. The i386 line from the log file that Naresh linked to at
https://lkft.validation.linaro.org/scheduler/job/1406110#L1223  is less
unusual:

[   34.931663] Node 0 active_anon:21464kB inactive_anon:8688kB
active_file:16604kB inactive_file:849976kB unevictable:0kB
isolated(anon):0kB isolated(file):0kB mapped:25284kB dirty:58952kB
writeback:27772kB shmem:8944kB writeback_tmp:0kB unstable:0kB
all_unreclaimable? yes
[   34.955523] DMA free:3356kB min:68kB low:84kB high:100kB
reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB
active_file:0kB inactive_file:11964kB unevictable:0kB
writepending:11980kB present:15964kB managed:15876kB mlocked:0kB
kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB
free_cma:0kB
[   34.983385] lowmem_reserve[]: 0 825 1947 825
[   34.987678] Normal free:3948kB min:7732kB low:8640kB high:9548kB
reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB
active_file:1096kB inactive_file:786400kB unevictable:0kB
writepending:65432kB present:884728kB managed:845576kB mlocked:0kB
kernel_stack:1112kB pagetables:0kB bounce:0kB free_pcp:2908kB
local_pcp:500kB free_cma:0kB
[   35.017427] lowmem_reserve[]: 0 0 8980 0
[   35.021362] HighMem free:1049496kB min:512kB low:1748kB high:2984kB
reserved_highatomic:0KB active_anon:21464kB inactive_anon:8688kB
active_file:15508kB inactive_file:51612kB unevictable:0kB
writepending:0kB present:1149540kB managed:1149540kB mlocked:0kB
kernel_stack:0kB pagetables:712kB bounce:0kB free_pcp:1524kB
local_pcp:292kB free_cma:0kB
[   35.051717] lowmem_reserve[]: 0 0 0 0
[   35.055374] DMA: 8*4kB (UE) 1*8kB (E) 1*16kB (E) 0*32kB 0*64kB
0*128kB 1*256kB (E) 0*512kB 1*1024kB (E) 1*2048kB (E) 0*4096kB =
3384kB
[   35.067446] Normal: 27*4kB (U) 23*8kB (U) 12*16kB (UE) 12*32kB (U)
4*64kB (UE) 2*128kB (U) 2*256kB (UE) 1*512kB (E) 0*1024kB 1*2048kB (U)
0*4096kB = 4452kB
[   35.081347] HighMem: 2*4kB (UM) 0*8kB 1*16kB (M) 2*32kB (UM) 1*64kB
(U) 0*128kB 1*256kB (M) 1*512kB (M) 0*1024kB 0*2048kB 256*4096kB (M) =
1049496kB

        Arnd
