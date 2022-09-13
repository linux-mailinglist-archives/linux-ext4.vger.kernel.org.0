Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5275B6DCC
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Sep 2022 14:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbiIMM5Q (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 13 Sep 2022 08:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbiIMM5P (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 13 Sep 2022 08:57:15 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FAE1E3FD
        for <linux-ext4@vger.kernel.org>; Tue, 13 Sep 2022 05:57:13 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id v16so27259448ejr.10
        for <linux-ext4@vger.kernel.org>; Tue, 13 Sep 2022 05:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=mLMzYqurkouaHk7HWBs1VyLI0kIoAGbkDSgc4TxTB3k=;
        b=edLLOO0P4NfvQ046CQsKRduRVNz9aLSsWSsCJo/XEeu883d9QUtP3ugATKtbi/pzCO
         4DhM2mMmLa8DDGRLjDlnP+rBkt7LozrUhX+A5lDmbzBsaVxmOidK/WWIsSgPp9XxIjuy
         lgzaTIKaIRxOEro4j8gDha+1FTiNvoMraK4qTZLIL0sV8sq+xtrpG73TqFCZPFcK3Q8v
         ki5JSAVsVYfpwFg4zbnYXANTFzrHkPbY/SzqrRurAGzZCFD5fJ5zmuQPmIFQuBwjB7Rx
         fXJxcYm17m9DRKIQ5do6pIHTBWVNgDaJ+AhTC9eEil0b32ymVfrKMEFgLTZVtszSxvVG
         Zrqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=mLMzYqurkouaHk7HWBs1VyLI0kIoAGbkDSgc4TxTB3k=;
        b=FsGeI46AWFJz/+LhjpDzMlWJwVShUT6gunMiPVousmcTnKM4y6J7Vw73w/PRii/rDN
         p6nufit2s1Gw9vNV1/p+3jSwEXqsoKsnWXaR4gv7tMBYx0FP3yQdjispzga1GrAm4veK
         +hHRwURB1cXu34xbQ4ODj/WL9uGBB/2gRl/AwJLt+Wd0iUKAyjDUiW0FUnarzUhNEjZG
         sWfb3fXO+xIFV1NVhvY08u8rRcLmc/E4AOCfHIiw5Q/1/HZjrmT+TnHH7w/Zy3TuI4lr
         A1Yf5kW++I5khpKJkC4RTxaZtN5TrL0YG7OqrHX31zgRui0IDIegLXXxhyxyVjqQxFFa
         3r7Q==
X-Gm-Message-State: ACgBeo3rzDTkP0C5K/JNnNqBhMdpBHM/pmeGQIDEejmUvYN5ZRFRL152
        +zsW6qTlIXuz+pdLnzZTPoGB22iDjUGSD3qnuc06K7f8iJab2RlL
X-Google-Smtp-Source: AA6agR7sCC/06YZvjHm8EBamzTVJc00aA2HNE0IceY3LSdZa/KwJ3reErOrj70xQqYfIXpBdjX43BEJA+NCI8DG1GWg=
X-Received: by 2002:a17:907:97c1:b0:780:12db:8ebc with SMTP id
 js1-20020a17090797c100b0078012db8ebcmr739109ejc.618.1663073832009; Tue, 13
 Sep 2022 05:57:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAHB1NahK6LMggGEcoCfhun6rAWiyrANnNR5+d93c07WsZk6Kvg@mail.gmail.com>
 <Yx9fUHiiZaKXeLUw@mit.edu>
In-Reply-To: <Yx9fUHiiZaKXeLUw@mit.edu>
From:   JunChao Sun <sunjunchao2870@gmail.com>
Date:   Tue, 13 Sep 2022 20:57:00 +0800
Message-ID: <CAHB1NajdeXGbjv+WzDHWSDH98dYoJRMUhFopfuD+VjKuJK-FAg@mail.gmail.com>
Subject: Re: How does newbie find bugs in ext4?
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks a lot for your suggestions and patience . It is a great
guidance for a newbie of ext4!



On Tue, Sep 13, 2022 at 12:33 AM Theodore Ts'o <tytso@mit.edu> wrote:
>
> Hi,
>
> So first of all, I would recommend that you learn how to use
> kvm-xfstests.  The reason for this is that kvm-xfstests is very useful
> for testing any changes that you make.  The same test appliance can be
> used for testing file systems for Android and using Google Compute
> Engine VM's (which is one of the best ways to use it).  Please take a
> look at these references:
>
>       https://thunk.org/gce-xfstests
>       https://github.com/tytso/xfstests-bld/blob/master/Documentation/what-is-xfstests.md
>       https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-quickstart.md
>       https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-xfstests.md
>
> In addition to using this as a way of a quick "playground" where you
> can test patches, this can also be a good way to (for example) test
> syzbot reports.
>
> Another thing which you could potentially do is to manual backporting
> of ext4 patches which didn't automatically get applied because the
> patch required some adjustments (or required backporting some
> additional commits, etc.) to fix a particular problem.  So for
> example, you could try running xfstests using the latest 5.10.y or
> 5.15.y stable kernels, since as we fix bugs, we often add tests to
> check for regressions.  For example, if you look at the header of the
> test ext4/058, you'll find:
>
> # Set 256 blocks in a block group, then inject I/O pressure,
> # it will trigger off kernel BUG in ext4_mb_mark_diskspace_used
> #
> # Regression test for commit
> # a08f789d2ab5 ext4: fix bug_on ext4_mb_use_inode_pa
>
> So if you find out that a particular test fails on an LTS kernel
> (e.g., 5.15.y or 5.10.y), but it passes on upstream, it could be that
> a missing commit needs to be backported.  We don't currently have
> anyone doing this on a regular basis for the LTS kernels (I maybe will
> do this once every few months, when I have time), so this could be a
> good way for you to contribute and also learn more about ext4 as you
> go.
>
> Finally, I'll note that although I do run xfstests regularly, and will
> reject patches that cause regressions, but there are still some tests
> that fail.  For example, here is my latest test report:
>
> TESTRUNID: ltm-20220912073217
> KERNEL:    kernel 6.0.0-rc4-xfstests #760 SMP PREEMPT_DYNAMIC Mon Sep 12 07:23:13 EDT 2022 x86_64
> CMDLINE:   full --kernel gs://gce-xfstests/kernel.deb
> CPUS:      4
> MEM:       7680
>
> ext4/4k: 515 tests, 27 skipped, 4093 seconds
> ext4/1k: 511 tests, 2 failures, 40 skipped, 5095 seconds
>   Flaky: generic/475: 40% (2/5)   generic/476: 40% (2/5)
> ext4/ext3: 507 tests, 115 skipped, 3514 seconds
> ext4/encrypt: 493 tests, 3 failures, 129 skipped, 2583 seconds
>   Failures: generic/681 generic/682 generic/691
> ext4/nojournal: 510 tests, 4 failures, 94 skipped, 3610 seconds
>   Failures: ext4/301 ext4/304 generic/455
>   Flaky: generic/077: 40% (2/5)
> ext4/ext3conv: 512 tests, 27 skipped, 3650 seconds
> ext4/adv: 512 tests, 3 failures, 34 skipped, 3860 seconds
>   Failures: generic/475 generic/477
>   Flaky: generic/455: 80% (4/5)
> ext4/dioread_nolock: 513 tests, 27 skipped, 4235 seconds
> ext4/data_journal: 511 tests, 2 failures, 87 skipped, 3647 seconds
>   Failures: generic/231 generic/455
> ext4/bigalloc: 489 tests, 2 failures, 34 skipped, 3904 seconds
>   Failures: generic/455 shared/298
> ext4/bigalloc_1k: 488 tests, 2 failures, 51 skipped, 3826 seconds
>   Failures: generic/455 shared/298
> ext4/dax: 502 tests, 127 skipped, 2520 seconds
> Totals: 6135 tests, 792 skipped, 80 failures, 0 errors, 44288s
>
> (This was done by using gce-xfstests, which is a cloud VM variant of
> kvm-xfstests.  The equivalant would take roughly 12 to 24 hours using
> kvm-xfstests, whichj gets run on multiple VM times, so the wall clock
> time needed is perhaps two to two and a half hours.)
>
> In general, I try very hard to make sure that ext4/4k (ext4 with the
> default 4k block size) to be free of failures hen running the xfstests
> "auto" group.  However, you'll see that there are other configs where
> there are failures, some of which have been around for a while.
> However, the challenge is that these are bugs that often, more senior
> ext4 developers have tried looking at for, say, an hour or two, and
> then said, "I have higher priority fires to fight".  But these might
> not be the best tests failures to ask a ext4 newbie to debug.  That
> being said, if you don't mind a bit (or a lot) of frustration, it
> could be that you might be able root cause soe of these failed tests.
>
> (But starting with testing the LTS kernels might be a better place to
> start.)
>
> Cheers,
>
>                                         - Ted
