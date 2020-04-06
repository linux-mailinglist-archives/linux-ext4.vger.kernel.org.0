Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C32261A01A9
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Apr 2020 01:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgDFX1I (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 6 Apr 2020 19:27:08 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:11119 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgDFX1I (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 6 Apr 2020 19:27:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586215628; x=1617751628;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=X5Of+XNOiIABD5PHJhySeNSquylLNwYKPMHbC9s8oio=;
  b=L4yf5hYttTNiAxxWzwsEXYfhr3xA5x3JF8a0Ir3k9ivQ7SA6IXF1DTq+
   sXTLQxDXZaC0480kkXZt4nqz5NfkxD1iNu9A0tSqK++emVhtrqQN+eTdD
   TAiQQgxufPvFB19hSmwVXRHWOsVkL7mv6upl7SoEf/mOhF5hVK6XXe/9V
   JXI5GMMDkgI+nuRbQzzmRFpERggCF6eLkDhabXHUJFNWu7Csf84IMEYPx
   RyrhxCCngipZKxyPYT200xCaY28UNKUklROG+LajLKmGCuvSBGxupYjx/
   Tg6wIH5tRVOHUCHDDEUmvML72W9GJ4ThNS0syIbXgokf4lcllHo2CPEta
   w==;
IronPort-SDR: tj4qoymIBBq5d+oFKQmrh/xtEnw1SFHnMFHKeUYfiH/lp61vnT03EfTKiWkT84MvddaqMcLbD2
 0cv7TwEH8bG3zAA0oHD5O72cuoI4K50BC2St+SmZogEyccGK2ZjyZxUC6jDMFUuWHhsG6TkdAc
 p7tDSss0bZgDaAZQ25Urk5xMdFZjd4Ip62b9xm2HDTLvKYQl+6Bxk/vCVcNt47vaZuGfKsBmZd
 PJeXdjXth/HJUFSwj1AdAtbs4NXx4vN83G0+416kmDmEOyy73pBLGY8G9s8lQ5YR4pma5ac58C
 lbU=
X-IronPort-AV: E=Sophos;i="5.72,352,1580745600"; 
   d="scan'208";a="136175313"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Apr 2020 07:27:08 +0800
IronPort-SDR: TOdEYF0yJHJ7VDVlafhr2PV9YRRC6vsJVo7xnYQgNOdxRLcBNjf1mrQz0JXNez6eU5CXDqT68d
 nEk1PEcA0gDQc0/0mT0yKsPbgCzX0ePO90YlADTmXBqFgVmpb9sneBtb5DR+f60xyZOSg9r7Mw
 aHgK1yf6c/UGYtliZqyxBEuKWUtMSO3W1pt4NCxtypDjbEZsu6u4e5hGfZplHmHmJxE/cJ+YTA
 OpE34y2tigY7Fr1HyOorDmKftqgOx8aFf5I8xiIshM+sDqy7MCFMcNnQgjtFWmsyYAs/qp+XIV
 AWDSkUjZhZ657p7FQV3pL1tS
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2020 16:17:50 -0700
IronPort-SDR: vrJU7kzzj1UEUyxdi9Iw6zGX1leY374TAplZqDUH+i50LaUR6LiNMl7C6Aj7/l7wvWx9xYtw6Y
 omZd7E2//9ve2EU7lNX/R00vkIV0Vlh2iE/VHqEcmMd+zBYzHoPmk58scLmk+g82Bogth/rEgF
 9POgOL2O1P1aoeDGN7GV50LkCe1dHARnhtRJm6xBMPK17j3s433I+HglH8GBDRVsXdowQ/KIv8
 h6gDv07udQiN26GqfFBbi1FPo9uRDgGdUsj7MsRTbnceIfj1QvrZ0ych4y6zIloJtUChF4NVh3
 2dg=
WDCIronportException: Internal
Received: from ioprio.labspan.wdc.com (HELO ioprio.sc.wdc.com) ([10.6.139.89])
  by uls-op-cesaip01.wdc.com with ESMTP; 06 Apr 2020 16:27:07 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     hch@lst.de, martin.petersen@oracle.com
Cc:     darrick.wong@oracle.com, axboe@kernel.dk, tytso@mit.edu,
        adilger.kernel@dilger.ca, ming.lei@redhat.com, jthumshirn@suse.de,
        minwoo.im.dev@gmail.com, chaitanya.kulkarni@wdc.com,
        damien.lemoal@wdc.com, andrea.parri@amarulasolutions.com,
        hare@suse.com, tj@kernel.org, hannes@cmpxchg.org,
        khlebnikov@yandex-team.ru, ajay.joshi@wdc.com, bvanassche@acm.org,
        arnd@arndb.de, houtao1@huawei.com, asml.silence@gmail.com,
        ktkhai@virtuozzo.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: [PATCH V2 0/4] block: Add support for REQ_OP_ALLOCATE
Date:   Mon,  6 Apr 2020 15:21:44 -0700
Message-Id: <20200406222148.28365-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

This patch-series is based on the original RFC patch series:-
https://www.spinics.net/lists/linux-block/msg47933.html.

I've designed a rough testcase based on the information present
in the mailing list archive for original RFC, it may need
some corrections from the author.

If anyone is interested, test results are at the end of this patch.

Following is the original cover-letter :-

Information about continuous extent placement may be useful
for some block devices. Say, distributed network filesystems,
which provide block device interface, may use this information
for better blocks placement over the nodes in their cluster,
and for better performance. Block devices, which map a file
on another filesystem (loop), may request the same length extent
on underlining filesystem for less fragmentation and for batching
allocation requests. Also, hypervisors like QEMU may use this
information for optimization of cluster allocations.

This patchset introduces REQ_OP_ALLOCATE, which is going
to be used for forwarding user's fallocate(0) requests into
block device internals. It rather similar to existing
REQ_OP_DISCARD, REQ_OP_WRITE_ZEROES, etc. The corresponding
exported primitive is called blkdev_issue_allocate().
See [1/3] for the details.

Patch [2/3] teaches loop driver to handle REQ_OP_ALLOCATE
requests by calling fallocate(0).

Patch [3/3] makes ext4 to notify a block device about fallocate(0).

Here is a simple test I did:
https://gist.github.com/tkhai/5b788651cdb74c1dbff3500745878856

I attached a file on ext4 to loop. Then, created ext4 partition
on loop device and started the test in the partition. Direct-io
is enabled on loop.

The test fallocates 4G file and writes from some offset with
given step, then it chooses another offset and repeats. After
the test all the blocks in the file become written.

The results shows that batching extents-assigning requests improves
the performance:

Before patchset: real ~ 1min 27sec
After patchset:  real ~ 1min 16sec (18% better)

Ordinary fallocate() before writes improves the performance
by batching the requests. These results just show, the same
is in case of forwarding extents information to underlining
filesystem.

Regards,
Chaitanya

Changes from V1:-

1. Adjust series from using assign range or ASSIGN_RANGE to allocate or
   ALLOCATE. (Martin)
2. Add SECT_FROM_SB_BLK() and NSECTS_FROM_SB_NBLK() macros since it
   avoids weired line breaking and duplication of the code for
   sb_issue_discard(), sb_issue_zeroout() and sb_issue_allocate().
   Should there be a prep patch for this ?

Changes from RFC:-

1. Add missing plumbing for REQ_OP_ASSIGN_RANGE similar to write-zeores.
2. Add a prep patch to create a helper to submit payloadless bios.
3. Design a testcases around the description present in the
   cover-letter.

Chaitanya Kulkarni (1):
  block: create payloadless issue bio helper

Kirill Tkhai (3):
  block: Add support for REQ_OP_ALLOCATE
  loop: Forward REQ_OP_ALLOCATE into fallocate(0)
  ext4: Notify block device about alloc-assigned blk

 block/blk-core.c          |   5 ++
 block/blk-lib.c           | 115 +++++++++++++++++++++++++++++++-------
 block/blk-merge.c         |  21 +++++++
 block/blk-settings.c      |  19 +++++++
 block/blk-zoned.c         |   1 +
 block/bounce.c            |   1 +
 drivers/block/loop.c      |   5 ++
 fs/ext4/ext4.h            |   2 +
 fs/ext4/extents.c         |  12 +++-
 include/linux/bio.h       |   9 ++-
 include/linux/blk_types.h |   2 +
 include/linux/blkdev.h    |  55 ++++++++++++++----
 12 files changed, 210 insertions(+), 37 deletions(-)

-- 
2.22.0

