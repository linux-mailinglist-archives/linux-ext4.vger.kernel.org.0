Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36ACF54FFC0
	for <lists+linux-ext4@lfdr.de>; Sat, 18 Jun 2022 00:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbiFQWNH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Jun 2022 18:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiFQWNG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Jun 2022 18:13:06 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36271583A
        for <linux-ext4@vger.kernel.org>; Fri, 17 Jun 2022 15:13:04 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 25HMCx6x005489
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Jun 2022 18:13:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1655503981; bh=0qG0rEHST3v7Ah5XGrvY4q38LuQC2HkW2cczR1aEVHY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=n2rkGDxbSCMm8qqPIPXVJ9s+hRKlAa02jwzNNpH18m3IjsKlXw3kRetrDt5t//bCD
         PEAdNsZFjK23d+ann8zxtiCQr6Tn0AYjo5ayN6+BS/jPEiRvN5eansbPR15UoKw+Lf
         udscb6CJwUGbaCROTGL7LGEWxY+ShTFlvKNczsa3/YNwxGTsmiaMhF1b1HKmdEcDQm
         phHDR+qtb92eNbpUsSSRTUoEqTJ6iTj3lSLU4AWZy/mQdiBn3Dm1rkpXFOrBL96YKU
         3RVFkYRfFCLZB+ByvVbgI/8KQNlUSiV55RSIeA4dfnijSjhlNyhB1hBK/2AFsx/Jdo
         uDIOTjiYiR22w==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 8A1EA15C42F3; Fri, 17 Jun 2022 18:12:59 -0400 (EDT)
Date:   Fri, 17 Jun 2022 18:12:59 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Santosh S <santosh.letterz@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: Overwrite faster than fallocate
Message-ID: <Yqz8a0ggTjIU3h7T@mit.edu>
References: <CAGQ4T_Jne-bxdP9rMNBzqXw16a4kD4FM=F5VuGgUbczj5WgCLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGQ4T_Jne-bxdP9rMNBzqXw16a4kD4FM=F5VuGgUbczj5WgCLA@mail.gmail.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jun 17, 2022 at 12:38:20PM -0400, Santosh S wrote:
> Dear ext4 developers,
> 
> This is my test - preallocate a large file (2G) and then do sequential
> 4K direct-io writes to that file, with fdatasync after every write.
> I am preallocating using fallocate mode 0. I noticed that if the 2G
> file is pre-written rather than fallocate'd I get more than twice the
> throughput. I could reproduce this with fio. The storage is nvme.
> Kernel version is 5.3.18 on Suse.
>
> Am I doing something wrong or is this difference expected? Any
> suggestion to get a better throughput without actually pre-writing the
> file.

This is, alas, expected.  The reason for this is because when you use
fallocate, the extent is marked as uninitialized, so that when you
read from the those newly allocated blocks, you don't see previously
written data belonging to deleted files.  These files could contain
someone else's e-mail, or medical information, etc.  So if we didn't
do this, it would be a walking, talking HIPPA or PCI violation.

So when you write to an fallocated region, and then call fdatasync(2),
we need to update the metadata blocks to clear the uninitialized bit
so that when you read from the file after a crash, you actually get
the data that was written.  So the fdatasync(2) operation is quite the
heavyweight operation, since it requries journal commit because of the
required metadata update.  When you do an overwrite, there is no need
to force a metadata update and journal update, which is why write(2)
plus fdatasync(2) is much lighter weight when you do an overwrite.

What enterprise databases (e.g., Oracle Enterprise Database and IBM's
Informix DB) tend to do is to use fallocate a chunk of space (say,
16MB or 32MB), because for Legacy Unix OS's, this tends enable some
file system's block allocators to be more likely to allocate a
contiguous block range, and then immediate write zero's on that 16 or
32MB, plus a fdatasync(2).  This fdatasync(2) would update the extent
tree once to make that 16MB or 32MB to be marked initialized to the
database's tablespace file, so you only pay the metadata update once,
instead of every few dozen kilobytes as you write each database commit
into the tablespace file.

There is also an old, out of tree patch which enables an fallocate
mode called "no hide stale", which marks the extent tree blcoks which
are allocated using fallocate(2) as initialized.  This substantially
speeds things up, but it is potentially a walking, talking, HIPPA or
PCI violation in that revealing previously written data is considered
a horrible security violation by most file system developers.

If you know, say, that a cluster file system is the only user of the
file system, and all data is written encrypted at rest using a
per-user key, such that exposing stale data is not a security
disaster, the "no hide stale" flag could be "safe" in that highly
specialized user case.

But that assumes that file system authors can trust application
writers not to do something stupid and insecure, and historically,
file system authors (possibly with good reason, given bitter past
experience) don't trust application writesr to do something which is
very easy, and gooses performance, even if it has terrible side
effects on either data robustness or data security.

Effectively, the no hide stale flag could be considered an "Attractive
Nuisance"[1] and so support for this feature has never been accepted
into the mainline kernel, and never to any distro kernels, since the
distribution companies don't want to be held liable for making an
"acctive nuisance" that might enable application authors from shooting
themselves in the foot.

[1] https://en.wikipedia.org/wiki/Attractive_nuisance_doctrine

In any case, the technique of fallocatE(2) plus zero-fill-write plus
fdatasync(2) isn't *that* slow, and is only needed when you are first
extending the tablespace file.  In the steady state, most database
applications tend to be overwriting space, so this isn't an issue.

In any case, if you need to get that last 5% or so of performance ---
say, if you are are an enterprise database company interested in
taking a full page advertisement on the back cover of Business Week
Magazine touting how your enterprise database benchmarks are better
than the competition --- the simple solution is to use a raw block
device.  Of course, most end users want the convenience of the file
system, but that's not the point if you are engaging in
benchmarketing.   :-)

Cheers,

						- Ted
