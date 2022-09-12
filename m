Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA8C5B5E4B
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Sep 2022 18:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiILQd0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Sep 2022 12:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiILQdZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 12 Sep 2022 12:33:25 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C7E1D0C6
        for <linux-ext4@vger.kernel.org>; Mon, 12 Sep 2022 09:33:24 -0700 (PDT)
Received: from letrec.thunk.org ([185.122.133.20])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 28CGXK10012981
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Sep 2022 12:33:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1663000402; bh=RcmKQ1oUq86NGMt5DT+r6zQ6gcil2DxrxqDAHJbW/zg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=oX9yQuEatWjAVDmG3khDD2TYfqHaLLXUuSiqJocgBBkaFddFA7BEyh2v/qYQwFCzr
         hb1AZFdR66GSombbSkbYqotAvGsu4/poroO9armNVVszC9a/BRLlkqEwJAMfRk8lic
         Fo9xZvjTc8lvMkyk6Cyh4rZFxoukgqh4gsg0MBdVnW9KrLOPTLFywfcPDg0V4uzNXK
         n0dCOzpvsCniFWhkG2MtVFDs6f87K9uh1pi7OR5BViqKSJl+POn/WxytaZtf76WpOQ
         4RajO/ZzJUNTpn9wbnBHxhCwgbP0np2/X2GQu9zPjO8XzDzwh9YuB3Agt9RYqhXo2Z
         LVNkiPatIqAIA==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 9C5D18C3EB0; Mon, 12 Sep 2022 12:33:20 -0400 (EDT)
Date:   Mon, 12 Sep 2022 12:33:20 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     JunChao Sun <sunjunchao2870@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: How does newbie find bugs in ext4?
Message-ID: <Yx9fUHiiZaKXeLUw@mit.edu>
References: <CAHB1NahK6LMggGEcoCfhun6rAWiyrANnNR5+d93c07WsZk6Kvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHB1NahK6LMggGEcoCfhun6rAWiyrANnNR5+d93c07WsZk6Kvg@mail.gmail.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

So first of all, I would recommend that you learn how to use
kvm-xfstests.  The reason for this is that kvm-xfstests is very useful
for testing any changes that you make.  The same test appliance can be
used for testing file systems for Android and using Google Compute
Engine VM's (which is one of the best ways to use it).  Please take a
look at these references:

      https://thunk.org/gce-xfstests
      https://github.com/tytso/xfstests-bld/blob/master/Documentation/what-is-xfstests.md
      https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-quickstart.md
      https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-xfstests.md

In addition to using this as a way of a quick "playground" where you
can test patches, this can also be a good way to (for example) test
syzbot reports.

Another thing which you could potentially do is to manual backporting
of ext4 patches which didn't automatically get applied because the
patch required some adjustments (or required backporting some
additional commits, etc.) to fix a particular problem.  So for
example, you could try running xfstests using the latest 5.10.y or
5.15.y stable kernels, since as we fix bugs, we often add tests to
check for regressions.  For example, if you look at the header of the
test ext4/058, you'll find:

# Set 256 blocks in a block group, then inject I/O pressure,
# it will trigger off kernel BUG in ext4_mb_mark_diskspace_used
#
# Regression test for commit
# a08f789d2ab5 ext4: fix bug_on ext4_mb_use_inode_pa

So if you find out that a particular test fails on an LTS kernel
(e.g., 5.15.y or 5.10.y), but it passes on upstream, it could be that
a missing commit needs to be backported.  We don't currently have
anyone doing this on a regular basis for the LTS kernels (I maybe will
do this once every few months, when I have time), so this could be a
good way for you to contribute and also learn more about ext4 as you
go.

Finally, I'll note that although I do run xfstests regularly, and will
reject patches that cause regressions, but there are still some tests
that fail.  For example, here is my latest test report:

TESTRUNID: ltm-20220912073217
KERNEL:    kernel 6.0.0-rc4-xfstests #760 SMP PREEMPT_DYNAMIC Mon Sep 12 07:23:13 EDT 2022 x86_64
CMDLINE:   full --kernel gs://gce-xfstests/kernel.deb
CPUS:      4
MEM:       7680

ext4/4k: 515 tests, 27 skipped, 4093 seconds
ext4/1k: 511 tests, 2 failures, 40 skipped, 5095 seconds
  Flaky: generic/475: 40% (2/5)   generic/476: 40% (2/5)
ext4/ext3: 507 tests, 115 skipped, 3514 seconds
ext4/encrypt: 493 tests, 3 failures, 129 skipped, 2583 seconds
  Failures: generic/681 generic/682 generic/691
ext4/nojournal: 510 tests, 4 failures, 94 skipped, 3610 seconds
  Failures: ext4/301 ext4/304 generic/455
  Flaky: generic/077: 40% (2/5)
ext4/ext3conv: 512 tests, 27 skipped, 3650 seconds
ext4/adv: 512 tests, 3 failures, 34 skipped, 3860 seconds
  Failures: generic/475 generic/477
  Flaky: generic/455: 80% (4/5)
ext4/dioread_nolock: 513 tests, 27 skipped, 4235 seconds
ext4/data_journal: 511 tests, 2 failures, 87 skipped, 3647 seconds
  Failures: generic/231 generic/455
ext4/bigalloc: 489 tests, 2 failures, 34 skipped, 3904 seconds
  Failures: generic/455 shared/298
ext4/bigalloc_1k: 488 tests, 2 failures, 51 skipped, 3826 seconds
  Failures: generic/455 shared/298
ext4/dax: 502 tests, 127 skipped, 2520 seconds
Totals: 6135 tests, 792 skipped, 80 failures, 0 errors, 44288s

(This was done by using gce-xfstests, which is a cloud VM variant of
kvm-xfstests.  The equivalant would take roughly 12 to 24 hours using
kvm-xfstests, whichj gets run on multiple VM times, so the wall clock
time needed is perhaps two to two and a half hours.)

In general, I try very hard to make sure that ext4/4k (ext4 with the
default 4k block size) to be free of failures hen running the xfstests
"auto" group.  However, you'll see that there are other configs where
there are failures, some of which have been around for a while.
However, the challenge is that these are bugs that often, more senior
ext4 developers have tried looking at for, say, an hour or two, and
then said, "I have higher priority fires to fight".  But these might
not be the best tests failures to ask a ext4 newbie to debug.  That
being said, if you don't mind a bit (or a lot) of frustration, it
could be that you might be able root cause soe of these failed tests.

(But starting with testing the LTS kernels might be a better place to
start.)

Cheers,

					- Ted
