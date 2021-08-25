Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7E813F7EC0
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Aug 2021 00:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhHYWso (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 25 Aug 2021 18:48:44 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53271 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229642AbhHYWsn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 25 Aug 2021 18:48:43 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 17PMlqB0028745
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Aug 2021 18:47:52 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id EB24215C3E69; Wed, 25 Aug 2021 18:47:51 -0400 (EDT)
Date:   Wed, 25 Aug 2021 18:47:51 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 0/5 v7] ext4: Speedup orphan file handling
Message-ID: <YSbIl0FfDCtPJyal@mit.edu>
References: <20210816093626.18767-1-jack@suse.cz>
 <YSUo4TBKjcdX7N/q@mit.edu>
 <20210825113016.GB14620@quack2.suse.cz>
 <20210825161331.GA14270@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210825161331.GA14270@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Aug 25, 2021 at 06:13:31PM +0200, Jan Kara wrote:
>
> Interestingly, I couldn't make generic/476
> fail for me either with or without my patches so that may be some random
> failure. I'm now running that test in a loop to see whether the failure
> will reproduce to investigate.

On my test infrastructure (using gce-xfstests, which uses 5gig test
and scratch partitions using PD-SSD as the device, 2CPU's, with 7.5 GB
of memory), it's failing 70% of the time in the 1k and orphan_file_1k
case.

Looking through my notes, that's a known failure:

generic/476	1k
   Run an all-writes fsstress run with multiple threads to shake out
   bugs in the write path.

   50% of the time.  fsck complaining corrupted file system block
   bitmap differences all negative.  Possible cause: races loading
   adjacent block bitmaps in a single 4k page, leading to bitmap
   updates getting lost?

   Eric Whitney reports that it's a punch hole bug, where we are
   leaking a block or a cluster (in bigalloc); with fixed seed he
   can repro reliably at 100%.

					- Ted


TESTRUNID: tytso-20210825172314
KERNEL:    kernel 5.14.0-rc2-xfstests-00019-g3e5533948c16 #326 SMP Mon Aug 23 22:27:25
EDT 2021 x86_64
CMDLINE:   --update-files -c 1k -C 10 generic/476
CPUS:      2
MEM:       7680

ext4/1k: 10 tests, 7 failures, 3399 seconds
  generic/476  Failed   327s
  generic/476  Failed   348s
  generic/476  Failed   344s
  generic/476  Pass     343s
  generic/476  Pass     335s
  generic/476  Failed   348s
  generic/476  Failed   341s
  generic/476  Failed   335s
  generic/476  Failed   345s
  generic/476  Pass     333s
Totals: 10 tests, 0 skipped, 7 failures, 0 errors, 3399s

FSTESTIMG: gce-xfstests/xfstests-202108232144
FSTESTPRJ: gce-xfstests
FSTESTVER: blktests 62ec9d6 (Tue, 1 Jun 2021 10:08:38 -0700)
FSTESTVER: e2fsprogs v1.46.4-5-g4cda2545-orphan_file (Sun, 22 Aug 2021 10:07:15 -0400)
FSTESTVER: fio  fio-3.27 (Wed, 26 May 2021 10:10:32 -0600)
FSTESTVER: fsverity v1.4 (Mon, 14 Jun 2021 16:14:52 -0700)
FSTESTVER: ima-evm-utils v1.3.2 (Wed, 28 Oct 2020 13:18:08 -0400)
FSTESTVER: nvme-cli v1.14-61-gf729e93 (Fri, 25 Jun 2021 10:21:17 -0600)
FSTESTVER: quota  v4.05-40-g25f16b1 (Tue, 16 Mar 2021 17:57:19 +0100)
FSTESTVER: util-linux v2.37 (Tue, 1 Jun 2021 09:52:10 +0200)
FSTESTVER: xfsprogs v5.12.0 (Fri, 21 May 2021 15:53:24 -0400)
FSTESTVER: xfstests-bld 779b6a0 (Mon, 23 Aug 2021 21:29:52 -0400)
FSTESTVER: xfstests linux-v3.8-3295-gddc09fff (Mon, 23 Aug 2021 20:54:57 -0400)
FSTESTCFG: 1k
FSTESTSET: generic/476
FSTESTOPT: count 10 aex
GCE ID:    2585249240830380583
