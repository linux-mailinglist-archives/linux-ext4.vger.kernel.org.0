Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0E921FF69D
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jun 2020 17:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731383AbgFRP2H (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Jun 2020 11:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727841AbgFRP2G (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Jun 2020 11:28:06 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334D6C06174E
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:28:06 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id e9so3043848pgo.9
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nXl3Y5csoeDvOzerAWZShFP+gtRrjetyUvHdAVUsd8w=;
        b=sszorWsrIODgTOK0DQeVMZuY1emtHPgmwJqVgRa60C1+8+92BTTwseXtr0YfqJciXA
         1tSfbypqi1a4ASrmRmIpk2ZmMjW1CItlvmj10cl19ZStp6CDxz4N45EvK5e/jqsfGs4a
         emNjTMvXtAJaA43aRU3V6OhqfAb40UvtXV7nGv9iSU7e3Jj29A/5pIcID8hOayO4BIQ1
         3FXqLLCUMgDq69h/t+6gKHVzuOqpkB6OQCrDyMkMJqPu8TruH+pFZ+iF7DE4w1ydtaE7
         VSvO8PSAevptrbEAVTX+/L3USweadxwdiI2vUg2I9IjYyMm/qFSZQ7+IEzydNzDa1ZG+
         R2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nXl3Y5csoeDvOzerAWZShFP+gtRrjetyUvHdAVUsd8w=;
        b=auO7kE4/JLUcDaK7q0c8l+qqrJXw1rBtVr0ch+QBLThERjQ1WL2g9zf9vhxdD7RJn3
         kCmHKXj5zR6u4guWCa+jnHUaVNEaAyN0y9mQmLA1+7tl1JGse9/5WWkiMlWY0vT4DqsQ
         5YRuZTVSZgCSUL5pmZdFPuzTaeOaMx62QMbvDZxHyxRJTy6nh9zV8g3jMQFJpNUHGIop
         FhsX3lDUk6Zh5DMprdnOuAd7EcoOQjmJo5IRS3XNCZNlMnXpSh1jlFvx3KbziCWDTNYO
         p/KZjgUd78Rtr9H20/L+Jd/dHVpX5MIVC1HXIYa+yODTHhNnWrfLNFsZdPIkWt2JI8za
         XlfQ==
X-Gm-Message-State: AOAM531Z7ycbcDHgHGN75j3HUcWUZE5ce/32uAh2FBVPywze5y6TGXVv
        ZwtubqG0KqGJZpoIgNnMARK3QdvwMpE=
X-Google-Smtp-Source: ABdhPJziydRDVq9vz8kHUB5Sql1WP/0GZrPmq5LvJPWnhgaBCGk1c5CY7bJV4UyDMDhXas/6BADW6g==
X-Received: by 2002:aa7:859a:: with SMTP id w26mr3875562pfn.10.1592494085167;
        Thu, 18 Jun 2020 08:28:05 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y81sm3306650pfb.33.2020.06.18.08.28.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2020 08:28:04 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, wangshilong1991@gmail.com,
        sihara@ddn.com, Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH v2 00/51] introduce parallel fsck to e2fsck pass1
Date:   Fri, 19 Jun 2020 00:27:03 +0900
Message-Id: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

From: Wang Shilong <wshilong@ddn.com>

Currently it has been popular that single disk could be more than TiB,
etc 16Tib with only one single disk, with this trend, one single
filesystem could be larger and larger and easily reach PiB with LUN system.

The journal filesystem like ext4 need be offline to do regular
check and repair from time to time, however the problem is e2fsck
still do this using single thread, this could be challenging at scale
for two reasons:

1) even with readahead, IO speed still limits several tens MiB per second.
2) could not utilize CPU cores.

It could be challenging to try multh-threads for all phase of e2fsck, but as
first step, we might try this for most time-consuming pass1, according to
our benchmarking it cost of 80% time for whole e2fck phase.

Pass1 is trying to scanning all valid inode of filesystem and check it one by
one, and the patchset idea is trying to split these to different threads and
trying to do this at the same time, we try to merge these inodes and corresponding
inode's extent information after threads finish.

To simplify complexity and make it less error-prone, the fix is still serialized,
since most of time there will be only minor errors for filesystem, what's important
for us is parallel reading and checking.

Here is a benchmarking on our Lustre filesystem with 1.2 PiB OSD ext4 based
filesystem:

DDN SFA18KE StorageServer
DCR(DeClustering RAID) with 162 x HGST 10TB NL-SAS
Tested Server
A Virtual Machine running on SFA18KE
8 x CPU cores (Xeon(R) Gold 6140)
150GB memory
CentoOS7.7 (Lustre patched kernel)

Created 600 Million x 32K byte files.

Without Patch		With Patch  thr=64
pass1: 13079.66		488.57 seconds
Total: 15673.33		3188.42

We have 5x total time reduction of total time which is very inspiring.

I've tested the whole patch series using 'make test' of e2fsck itself, and i
manually set default threads to 4 which still pass almost of test suite,
failure cases are below:

f_h_badroot f_multithread f_multithread_logfile f_multithread_no 

h_h_badroot failed because out of order checking output, and others are because
of extra multiple threads log output.

The other test i've done to verify is:
1) filled a filesystem with different features enabled(encryption, shared xattr)
2) copied the above image out using e2image.
3) using e2fuzz to randomly corrupt above image, and then have another copy of
corrupted image.
4) running e2fsck with single thread(without patches) and multiple threads with
corrupted image respectively.
5) using valgrind to check any memory leak.
6) compare single thread and multiple threads fix results by mounting two images
back and compare the directores and files.(size and name match)

So the whole series is reasonably stable if you are intrested testing it on
different platforms, i've pushed it to github:

https://github.com/wangshilong/e2fsprogs pfsck_pass1_v2

It is definitely in early stage, any review or comments are welcomed!

Thanks you very much!
Shilong

changelog v1->v2:
1) fixed shared xattr handling merging.
2) fix serveral memory leaks problem which was detected by valgrind.
3) stop any checking while there is fixing thread active.
4) fix the OOM problem when runing 128 threads on 3TiB NVME filesystem.
5) limit multiple threads memory usage.
6) some other minor extra fixes

Li Xi (25):
  e2fsck: add -m option for multithread
  e2fsck: copy context when using multi-thread fsck
  e2fsck: copy fs when using multi-thread fsck
  e2fsck: copy dblist when using multi-thread fsck
  e2fsck: clear icache when using multi-thread fsck
  e2fsck: add assert when copying context
  e2fsck: copy bitmaps when copying context
  e2fsck: copy badblocks when copying fs
  e2fsck: open io-channel when copying fs
  e2fsck: create logs for mult-threads
  e2fsck: create one thread to fsck
  e2fsck: add start/end group for thread
  e2fsck: split groups to different threads
  e2fsck: print thread log properly
  e2fsck: merge bitmaps after thread completes
  e2fsck: do not change global variables
  e2fsck: optimize the inserting of dir_info_db
  e2fsck: merge dir_info after thread finishes
  e2fsck: rbtree bitmap for dir
  e2fsck: merge badblocks after thread finishes
  e2fsck: merge icounts after thread finishes
  e2fsck: merge dblist after thread finishes
  e2fsck: add debug codes for multiple threds
  e2fsck: merge counts when threads finish
  LU-8465 e2fsck: merge fs flags when threads finish

Wang Shilong (26):
  e2fsck: cleanup struct e2fsck_struct
  e2fsck: remove unused fs_ext_attr_inodes/blocks
  e2fsck: merge dx_dir_info
  e2fsck: make threads splitting aware of flex_bg
  e2fsck: merge dirs_to_hash when threads finish
  e2fsck: merge context flags properly
  e2fsck: split and merge quota context
  e2fsck: serialize fix operations
  e2fsck: move some fixes out of parallel pthreads
  e2fsck: split and merge invalid bitmaps
  e2fsck: fix to protect EA checking
  e2fsck: allow admin specify number of threads
  e2fsck: kickoff mutex lock for block found map
  e2fsck: fix readahead for pfsck of pass1
  e2fsck: kick off ea mutex lock from pfsck
  e2fsck: merge encrypted_files after threads finish
  e2fsck: merge inode_bad_map after threads finish
  e2fsck: simplify e2fsck context merging codes
  e2fsck: merge options after threads finish
  e2fsck: reset lost_and_found after threads finish
  LU-8465 e2fsck: merge extent depth count after threads finish
  e2fsck: only set E2F_FLAG_ALLOC_OK if all threads succeed
  e2fsck: only setup threads if -m option required
  e2fsck: wait fix thread finish before checking
  e2fsck: fix to free icache leak
  e2fsck: fix to avoid too much memory allocation for pfsck

 configure.ac                            |    6 +
 e2fsck/dirinfo.c                        |  237 ++-
 e2fsck/dx_dirinfo.c                     |   65 +
 e2fsck/e2fsck.h                         |  328 ++--
 e2fsck/encrypted_files.c                |  175 ++-
 e2fsck/logfile.c                        |   12 +-
 e2fsck/pass1.c                          | 1912 ++++++++++++++++++++---
 e2fsck/problem.c                        |    9 +
 e2fsck/problem.h                        |    3 +
 e2fsck/unix.c                           |   33 +-
 e2fsck/util.c                           |   56 +-
 lib/ext2fs/badblocks.c                  |   75 +-
 lib/ext2fs/bitmaps.c                    |   10 +
 lib/ext2fs/bitops.h                     |    2 +
 lib/ext2fs/blkmap64_rb.c                |   63 +
 lib/ext2fs/bmap64.h                     |    4 +
 lib/ext2fs/dblist.c                     |   38 +
 lib/ext2fs/ext2_err.et.in               |    3 +
 lib/ext2fs/ext2_io.h                    |    2 +
 lib/ext2fs/ext2fs.h                     |   16 +-
 lib/ext2fs/ext2fsP.h                    |    1 -
 lib/ext2fs/gen_bitmap64.c               |   74 +-
 lib/ext2fs/icount.c                     |  108 ++
 lib/ext2fs/undo_io.c                    |   19 +
 lib/ext2fs/unix_io.c                    |   24 +-
 lib/support/mkquota.c                   |   19 +
 lib/support/quotaio.h                   |    2 +
 tests/f_itable_collision/expect.1       |    3 -
 tests/f_multithread/expect.1            |   25 +
 tests/f_multithread/expect.2            |    7 +
 tests/f_multithread/image.gz            |    1 +
 tests/f_multithread/name                |    1 +
 tests/f_multithread/script              |    4 +
 tests/f_multithread_completion/expect.1 |    2 +
 tests/f_multithread_completion/expect.2 |   23 +
 tests/f_multithread_completion/image.gz |    1 +
 tests/f_multithread_completion/name     |    1 +
 tests/f_multithread_completion/script   |    4 +
 tests/f_multithread_logfile/expect.1    |   25 +
 tests/f_multithread_logfile/image.gz    |    1 +
 tests/f_multithread_logfile/name        |    1 +
 tests/f_multithread_logfile/script      |   32 +
 tests/f_multithread_no/expect.1         |   26 +
 tests/f_multithread_no/expect.2         |   23 +
 tests/f_multithread_no/image.gz         |    1 +
 tests/f_multithread_no/name             |    1 +
 tests/f_multithread_no/script           |    4 +
 tests/f_multithread_preen/expect.1      |   11 +
 tests/f_multithread_preen/expect.2      |   23 +
 tests/f_multithread_preen/image.gz      |    1 +
 tests/f_multithread_preen/name          |    1 +
 tests/f_multithread_preen/script        |    4 +
 tests/f_multithread_yes/expect.1        |    2 +
 tests/f_multithread_yes/expect.2        |   23 +
 tests/f_multithread_yes/image.gz        |    1 +
 tests/f_multithread_yes/name            |    1 +
 tests/f_multithread_yes/script          |    4 +
 57 files changed, 3049 insertions(+), 504 deletions(-)
 create mode 100644 tests/f_multithread/expect.1
 create mode 100644 tests/f_multithread/expect.2
 create mode 120000 tests/f_multithread/image.gz
 create mode 100644 tests/f_multithread/name
 create mode 100644 tests/f_multithread/script
 create mode 100644 tests/f_multithread_completion/expect.1
 create mode 100644 tests/f_multithread_completion/expect.2
 create mode 120000 tests/f_multithread_completion/image.gz
 create mode 100644 tests/f_multithread_completion/name
 create mode 100644 tests/f_multithread_completion/script
 create mode 100644 tests/f_multithread_logfile/expect.1
 create mode 120000 tests/f_multithread_logfile/image.gz
 create mode 100644 tests/f_multithread_logfile/name
 create mode 100644 tests/f_multithread_logfile/script
 create mode 100644 tests/f_multithread_no/expect.1
 create mode 100644 tests/f_multithread_no/expect.2
 create mode 120000 tests/f_multithread_no/image.gz
 create mode 100644 tests/f_multithread_no/name
 create mode 100644 tests/f_multithread_no/script
 create mode 100644 tests/f_multithread_preen/expect.1
 create mode 100644 tests/f_multithread_preen/expect.2
 create mode 120000 tests/f_multithread_preen/image.gz
 create mode 100644 tests/f_multithread_preen/name
 create mode 100644 tests/f_multithread_preen/script
 create mode 100644 tests/f_multithread_yes/expect.1
 create mode 100644 tests/f_multithread_yes/expect.2
 create mode 120000 tests/f_multithread_yes/image.gz
 create mode 100644 tests/f_multithread_yes/name
 create mode 100644 tests/f_multithread_yes/script

-- 
2.25.4

