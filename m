Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C75C0118E59
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Dec 2019 17:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbfLJQ5G (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 10 Dec 2019 11:57:06 -0500
Received: from relay.sw.ru ([185.231.240.75]:36456 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727577AbfLJQ5F (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 10 Dec 2019 11:57:05 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104] helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1ieinq-0006xy-Up; Tue, 10 Dec 2019 19:56:03 +0300
Subject: [PATCH RFC 0/3] block,ext4: Introduce REQ_OP_ASSIGN_RANGE to reflect
 extents allocation in block device internals
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Cc:     axboe@kernel.dk, tytso@mit.edu, adilger.kernel@dilger.ca,
        ming.lei@redhat.com, osandov@fb.com, jthumshirn@suse.de,
        minwoo.im.dev@gmail.com, damien.lemoal@wdc.com,
        ktkhai@virtuozzo.com, andrea.parri@amarulasolutions.com,
        hare@suse.com, tj@kernel.org, ajay.joshi@wdc.com, sagi@grimberg.me,
        dsterba@suse.com, chaitanya.kulkarni@wdc.com, bvanassche@acm.org,
        dhowells@redhat.com, asml.silence@gmail.com
Date:   Tue, 10 Dec 2019 19:56:02 +0300
Message-ID: <157599668662.12112.10184894900037871860.stgit@localhost.localdomain>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Information about continuous extent placement may be useful
for some block devices. Say, distributed network filesystems,
which provide block device interface, may use this information
for better blocks placement over the nodes in their cluster,
and for better performance. Block devices, which map a file
on another filesystem (loop), may request the same length extent
on underlining filesystem for less fragmentation and for batching
allocation requests. Also, hypervisors like QEMU may use this
information for optimization of cluster allocations.

This patchset introduces REQ_OP_ASSIGN_RANGE, which is going
to be used for forwarding user's fallocate(0) requests into
block device internals. It rather similar to existing
REQ_OP_DISCARD, REQ_OP_WRITE_ZEROES, etc. The corresponding
exported primitive is called blkdev_issue_assign_range().
See [1/3] for the details.

Patch [2/3] teaches loop driver to handle REQ_OP_ASSIGN_RANGE
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
---

Kirill Tkhai (3):
      block: Add support for REQ_OP_ASSIGN_RANGE operation
      loop: Forward REQ_OP_ASSIGN_RANGE into fallocate(0)
      ext4: Notify block device about fallocate(0)-assigned blocks


 block/blk-core.c          |    4 +++
 block/blk-lib.c           |   70 +++++++++++++++++++++++++++++++++++++++++++++
 block/blk-merge.c         |   21 ++++++++++++++
 block/bounce.c            |    1 +
 drivers/block/loop.c      |    5 +++
 fs/ext4/ext4.h            |    1 +
 fs/ext4/extents.c         |   11 ++++++-
 include/linux/bio.h       |    3 ++
 include/linux/blk_types.h |    2 +
 include/linux/blkdev.h    |   29 +++++++++++++++++++
 10 files changed, 145 insertions(+), 2 deletions(-)

--
Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>

