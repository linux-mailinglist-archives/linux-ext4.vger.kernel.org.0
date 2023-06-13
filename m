Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4683D72D705
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Jun 2023 03:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjFMBg5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Jun 2023 21:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjFMBg4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 12 Jun 2023 21:36:56 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D34E57;
        Mon, 12 Jun 2023 18:36:55 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QgB1F3PBmztQVH;
        Tue, 13 Jun 2023 09:34:25 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 09:36:53 +0800
Message-ID: <db478a24-39f5-3cef-8814-89406ce4d2ca@huawei.com>
Date:   Tue, 13 Jun 2023 09:36:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v4 10/12] ext4: make ext4_es_insert_delayed_block() return
 void
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>, <adilger.kernel@dilger.ca>,
        <jack@suse.cz>, <ritesh.list@gmail.com>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <yangerkun@huawei.com>, <yukuai3@huawei.com>,
        Baokun Li <libaokun1@huawei.com>
References: <20230424033846.4732-1-libaokun1@huawei.com>
 <20230424033846.4732-11-libaokun1@huawei.com>
 <20230610190319.GB1436857@mit.edu> <20230612030405.GH1436857@mit.edu>
 <9af2b8d7-8ad4-96bf-6a30-587ad23cff59@huawei.com>
 <20230612152640.GA1500045@mit.edu>
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20230612152640.GA1500045@mit.edu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2023/6/12 23:26, Theodore Ts'o wrote:
> On Mon, Jun 12, 2023 at 11:47:07AM +0800, Baokun Li wrote:
>> I'm very sorry, I didn't turn on encrypt or bigalloc when I tested it.
> For complex series, it's helpful if you could run the equivalent of:
>
>     {gce,kvm}-xfstests -c ext4/all -g auto
>
> It takes about 24 hours (plus or minus, depending on the speed of your
> storage device; it will also take about twice as long if
> CONFIG_LOCKDEP is enabled) if you use kvm-xfstests.  Using
> gce-xfstests with the ltm takes about around 1.75 hours (w/o LOCKDEP)
> since it runs the tests in parallel, using separate VM's for each file
> system config.
>
> There are a small number of failures (especially flaky test failures),
> however, (a) if a VM ever crashes, that's definitely a problem, and
> (b) the ext4/4k config should be failure-free.  For example, here's a
> current "good" test run that I'm checking the dev branch against.
> (Currently, we have some kind of issue with -c ext4/adv generic/475
> that I'm still chasing down.)
>
> 					- Ted
>
> The failures seen below are known failures that we need to work
> through.  Bill Whitney is working on the bigalloc_1k shared/298
> failure, for example.  If you would like to work on one of the test
> failures, especially if it's a file system config that you use in
> production, please feel free to do so.  :-)   Also, if you are
> interested in adapting the xfstests-bld codebase to support other
> cloud services beyond Google Cloud Engine, again, let me know.

It looks very good and I'll try to use it.

I'll try to locate some test case failures when I get free.

>
> The gce-xfstests run below was generated using:
>
> % gce-xfstests install-kconfig --lockdep
> % gce-xfstests kbuild --dpkg
> % gce-xfstests launch-ltm
> % gce-xfstests ltm full
>
> (Using the --dpkg is needed because is because there is a kexec bug
> showing up when running on a Google Cloud VM's that I haven't been
> able to fix, and it's been easier to just work around the kexec
> problem.  Kexec works just fine on kvm-xfstests, though, so there's no
> need to use kbuild --dpkg if you are just using kvm-xfstests.)
>
> TESTRUNID: ltm-20230611154922
> KERNEL:    kernel 6.4.0-rc5-xfstests-lockdep-00002-gdea9d8f7643f #170 SMP PREEMPT_DYNAMIC Sun Jun 11 15:21:52 EDT 2023 x86_64
> CMDLINE:   full
> CPUS:      2
> MEM:       7680
>
> ext4/4k: 549 tests, 51 skipped, 6895 seconds
> ext4/1k: 545 tests, 54 skipped, 10730 seconds
> ext4/ext3: 541 tests, 140 skipped, 8547 seconds
> ext4/encrypt: 527 tests, 3 failures, 158 skipped, 5783 seconds
>    Failures: generic/681 generic/682 generic/691
> ext4/nojournal: 544 tests, 3 failures, 119 skipped, 8394 seconds
>    Failures: ext4/301 ext4/304 generic/455
> ext4/ext3conv: 546 tests, 52 skipped, 9024 seconds
> ext4/adv: 546 tests, 2 failures, 59 skipped, 8454 seconds
>    Failures: generic/477
>    Flaky: generic/475: 60% (3/5)
> ext4/dioread_nolock: 547 tests, 51 skipped, 7883 seconds
> ext4/data_journal: 545 tests, 2 failures, 119 skipped, 7605 seconds
>    Failures: generic/455 generic/484
> ext4/bigalloc_4k: 521 tests, 56 skipped, 6650 seconds
> ext4/bigalloc_1k: 521 tests, 1 failures, 64 skipped, 8074 seconds
>    Failures: shared/298
> ext4/dax: 536 tests, 154 skipped, 5118 seconds
> Totals: 6512 tests, 1077 skipped, 53 failures, 0 errors, 82214s
>
> FSTESTIMG: gce-xfstests/xfstests-amd64-202305310154
> FSTESTPRJ: gce-xfstests
> FSTESTVER: blktests 676d42c (Thu, 2 Mar 2023 15:25:44 +0900)
> FSTESTVER: e2fsprogs 1.47.0-2-4-gd4745c4a (Tue, 30 May 2023 16:20:44 -0400)
> FSTESTVER: fio  fio-3.31 (Tue, 9 Aug 2022 14:41:25 -0600)
> FSTESTVER: fsverity v1.5-6-g5d6f7c4 (Mon, 30 Jan 2023 23:22:45 -0800)
> FSTESTVER: ima-evm-utils v1.3.2 (Wed, 28 Oct 2020 13:18:08 -0400)
> FSTESTVER: nvme-cli v1.16 (Thu, 11 Nov 2021 13:09:06 -0800)
> FSTESTVER: quota  v4.05-53-gd90b7d5 (Tue, 6 Dec 2022 12:59:03 +0100)
> FSTESTVER: util-linux v2.38.1 (Thu, 4 Aug 2022 11:06:21 +0200)
> FSTESTVER: xfsprogs v6.1.1 (Fri, 13 Jan 2023 19:06:37 +0100)
> FSTESTVER: xfstests-bld 6599baba-dirty (Wed, 19 Apr 2023 23:16:10 -0400)
> FSTESTVER: xfstests v2023.04.09-8-g2525b7af5-dirty (Wed, 19 Apr 2023 13:42:14 -0400)
> FSTESTVER: zz_build-distro bullseye
> FSTESTSET: -g auto
> FSTESTOPT: aex
>
I was using native xfstests for my previous tests, and I feel that

gce-xfstests is much easier to use and the results are very clear,

thanks for the great recommendation!

-- 
With Best Regards,
Baokun Li
.
