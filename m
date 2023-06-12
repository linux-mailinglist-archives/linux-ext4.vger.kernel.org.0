Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FBC72CA08
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Jun 2023 17:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbjFLP13 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Jun 2023 11:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236249AbjFLP11 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 12 Jun 2023 11:27:27 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B69610E4
        for <linux-ext4@vger.kernel.org>; Mon, 12 Jun 2023 08:27:13 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-82-39.bstnma.fios.verizon.net [173.48.82.39])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 35CFQfBB030671
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 11:26:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1686583603; bh=nt5gRE6liSz7s7nIQeg36RvcEWwDdz0B5DJ+0V1yeGA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Awdt5/nEKUtru729Jj0OFFU4Zbpc66dnHdmiUZfJflHh4RQt6oxNkwHusI+kH9T1e
         ObnFJoru9f3TNfH7n5aNyMANBu3b0BZdYu+f7Wk1FxC+/dhCzhEuU93lEOd2/AADVP
         ge78NeEK3FOWLlX2DU09DJCMDTlxlrd6A5EvMIE5wca+d+inTVd6/BL/1VSxsDQ9L+
         eKQ/THsfTJFKUsylFawuVUK0rVuD+nPQVQ8q8XVoIrZUOnYIptkheLhtUFRPr83Ekr
         MncvNdLVx98lxKWfFtWoRShgwDU2F+VlPRyTJ3Cij2UAe6jcICctHKnjYTJkhm8gma
         8wt6QiWbabq1Q==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id E607D15C00B0; Mon, 12 Jun 2023 11:26:40 -0400 (EDT)
Date:   Mon, 12 Jun 2023 11:26:40 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
        ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v4 10/12] ext4: make ext4_es_insert_delayed_block()
 return void
Message-ID: <20230612152640.GA1500045@mit.edu>
References: <20230424033846.4732-1-libaokun1@huawei.com>
 <20230424033846.4732-11-libaokun1@huawei.com>
 <20230610190319.GB1436857@mit.edu>
 <20230612030405.GH1436857@mit.edu>
 <9af2b8d7-8ad4-96bf-6a30-587ad23cff59@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9af2b8d7-8ad4-96bf-6a30-587ad23cff59@huawei.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jun 12, 2023 at 11:47:07AM +0800, Baokun Li wrote:
> I'm very sorry, I didn't turn on encrypt or bigalloc when I tested it.

For complex series, it's helpful if you could run the equivalent of:

   {gce,kvm}-xfstests -c ext4/all -g auto

It takes about 24 hours (plus or minus, depending on the speed of your
storage device; it will also take about twice as long if
CONFIG_LOCKDEP is enabled) if you use kvm-xfstests.  Using
gce-xfstests with the ltm takes about around 1.75 hours (w/o LOCKDEP)
since it runs the tests in parallel, using separate VM's for each file
system config.

There are a small number of failures (especially flaky test failures),
however, (a) if a VM ever crashes, that's definitely a problem, and
(b) the ext4/4k config should be failure-free.  For example, here's a
current "good" test run that I'm checking the dev branch against.
(Currently, we have some kind of issue with -c ext4/adv generic/475
that I'm still chasing down.)

					- Ted

The failures seen below are known failures that we need to work
through.  Bill Whitney is working on the bigalloc_1k shared/298
failure, for example.  If you would like to work on one of the test
failures, especially if it's a file system config that you use in
production, please feel free to do so.  :-)   Also, if you are
interested in adapting the xfstests-bld codebase to support other
cloud services beyond Google Cloud Engine, again, let me know.

The gce-xfstests run below was generated using:

% gce-xfstests install-kconfig --lockdep
% gce-xfstests kbuild --dpkg
% gce-xfstests launch-ltm
% gce-xfstests ltm full

(Using the --dpkg is needed because is because there is a kexec bug
showing up when running on a Google Cloud VM's that I haven't been
able to fix, and it's been easier to just work around the kexec
problem.  Kexec works just fine on kvm-xfstests, though, so there's no
need to use kbuild --dpkg if you are just using kvm-xfstests.)

TESTRUNID: ltm-20230611154922
KERNEL:    kernel 6.4.0-rc5-xfstests-lockdep-00002-gdea9d8f7643f #170 SMP PREEMPT_DYNAMIC Sun Jun 11 15:21:52 EDT 2023 x86_64
CMDLINE:   full
CPUS:      2
MEM:       7680

ext4/4k: 549 tests, 51 skipped, 6895 seconds
ext4/1k: 545 tests, 54 skipped, 10730 seconds
ext4/ext3: 541 tests, 140 skipped, 8547 seconds
ext4/encrypt: 527 tests, 3 failures, 158 skipped, 5783 seconds
  Failures: generic/681 generic/682 generic/691
ext4/nojournal: 544 tests, 3 failures, 119 skipped, 8394 seconds
  Failures: ext4/301 ext4/304 generic/455
ext4/ext3conv: 546 tests, 52 skipped, 9024 seconds
ext4/adv: 546 tests, 2 failures, 59 skipped, 8454 seconds
  Failures: generic/477
  Flaky: generic/475: 60% (3/5)
ext4/dioread_nolock: 547 tests, 51 skipped, 7883 seconds
ext4/data_journal: 545 tests, 2 failures, 119 skipped, 7605 seconds
  Failures: generic/455 generic/484
ext4/bigalloc_4k: 521 tests, 56 skipped, 6650 seconds
ext4/bigalloc_1k: 521 tests, 1 failures, 64 skipped, 8074 seconds
  Failures: shared/298
ext4/dax: 536 tests, 154 skipped, 5118 seconds
Totals: 6512 tests, 1077 skipped, 53 failures, 0 errors, 82214s

FSTESTIMG: gce-xfstests/xfstests-amd64-202305310154
FSTESTPRJ: gce-xfstests
FSTESTVER: blktests 676d42c (Thu, 2 Mar 2023 15:25:44 +0900)
FSTESTVER: e2fsprogs 1.47.0-2-4-gd4745c4a (Tue, 30 May 2023 16:20:44 -0400)
FSTESTVER: fio  fio-3.31 (Tue, 9 Aug 2022 14:41:25 -0600)
FSTESTVER: fsverity v1.5-6-g5d6f7c4 (Mon, 30 Jan 2023 23:22:45 -0800)
FSTESTVER: ima-evm-utils v1.3.2 (Wed, 28 Oct 2020 13:18:08 -0400)
FSTESTVER: nvme-cli v1.16 (Thu, 11 Nov 2021 13:09:06 -0800)
FSTESTVER: quota  v4.05-53-gd90b7d5 (Tue, 6 Dec 2022 12:59:03 +0100)
FSTESTVER: util-linux v2.38.1 (Thu, 4 Aug 2022 11:06:21 +0200)
FSTESTVER: xfsprogs v6.1.1 (Fri, 13 Jan 2023 19:06:37 +0100)
FSTESTVER: xfstests-bld 6599baba-dirty (Wed, 19 Apr 2023 23:16:10 -0400)
FSTESTVER: xfstests v2023.04.09-8-g2525b7af5-dirty (Wed, 19 Apr 2023 13:42:14 -0400)
FSTESTVER: zz_build-distro bullseye
FSTESTSET: -g auto
FSTESTOPT: aex
