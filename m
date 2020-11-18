Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1592C2B80BC
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 16:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgKRPkA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 10:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgKRPkA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Nov 2020 10:40:00 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47629C0613D4
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:40:00 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id y8so1534833qvu.22
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=41UKsIEYeV6y2ggicG07cBFzO/H+g251HtkymAnH4dU=;
        b=bxvMgghjUCYmVTo+W5D4xQoNO/cJ8XwG8xoDyvFvpvWB8iPcGlPoX7RT9gFz78hHTb
         TBmiG4kH5/gpfzRanlEG4DCJlFtC5C6o7olnKD8kJL0gfZjIsbqgoHfXaruwiA5xxwRj
         vfGNGNsPQH2TZu5Z4iUCqLbNBCYzVnZp7WD8qpPY1ApZjkMdIY7qxNEkxzZ0Z4moTZzU
         cAY4N0NPriCyoM0kSJ76qqJvQZVPpPm4YtctMHFD6MKj/XNDIu8Nvu8ZZozw+yueuGuB
         mLemuhlr/rtYplcl/Ol29+aeq4kvldEP9deA+8TJA3SSLS9XjgOnUpsGAiFWGy9xQ9++
         Fy6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=41UKsIEYeV6y2ggicG07cBFzO/H+g251HtkymAnH4dU=;
        b=QYNAy/U/6BBn2suqUnmxkGRUF+1MlAos7qAzWumVfRj4MJQ/Cvv3R4VTQFQBQS5hQL
         iZMZ6h5T5Oi2asI/TxvZgcFAPdj/dRKwjIE0WaG+81A3V2cRUEKb4LEDvQakMwJr+fCW
         QaQmTsRRJxs+yBoc+9ySZqjkNHTef19z4ZhMqC99k28B5b5SKlm5rwtmLYzTkSlcL4r7
         bryHckJ/y2KmCQYFZgpWGm0YPo3c9fJf30uFebVD1EeFz5kSi5p8wh8wCW7UoYA09EC1
         OpJsEpFWhLbCZPT3CRkY3r3buC2jzH6phF47gVegWIi21NlYRMcgO0agymeAyYsaCIhu
         RULg==
X-Gm-Message-State: AOAM531iRTPQ1hVpXCeWhPMwPr+nilXDk6IaNDG8eycJkuWR/uFiZVqZ
        SAT6al4Ru9aXJRtXwRWCL0SDbTvLlsCh809KSE8ZEVceUVlEES2uCnAOEX0h1HxVKL5YeQhprb4
        EeZSvzC7k0ayCviC9iOF34XERIdIOIYk4Ju+K4qLygUZdILinnSFVoYtOykZ7kFo1ShMTuRokr/
        2PK2j7Llc=
X-Google-Smtp-Source: ABdhPJyOWXaQnyh2V2BVY/WM5MiOj3DK0z/eVFwtqRNaVmwDh40HwBR1Wcq0m80c8i5xmd10oZQiGPSAKbb5s/Pzn7g=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([100.116.76.178])
 (user=saranyamohan job=sendgmr) by 2002:a0c:f607:: with SMTP id
 r7mr5358818qvm.47.1605713999348; Wed, 18 Nov 2020 07:39:59 -0800 (PST)
Date:   Wed, 18 Nov 2020 07:38:46 -0800
Message-Id: <20201118153947.3394530-1-saranyamohan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH v3 00/61] Introduce parallel fsck to e2fsck pass1
From:   Saranya Muruganandam <saranyamohan@google.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     adilger.kernel@dilger.ca,
        Saranya Muruganandam <saranyamohan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

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

f_h_badroot f_multithread f_multithread_logfile f_multithread_no f_multithread_ok

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

Any review or comments are welcomed!

Thanks you very much!

changelog v2->v3:
1) Parallelize rw_bitmaps
2) Configuration to turn off parallel fsck.(default=on)
3) Add f_multithread_ok
4) Add annotations to e2fsck_struct instead of reshuffle
5) Fix memory leaks
6) Some more extra fixes

Andreas Dilger (2):
  e2fsck: fix f_multithread_ok test
  e2fsck: misc cleanups for pfsck

Li Xi (18):
  e2fsck: add -m option for multithread
  e2fsck: copy context when using multi-thread fsck
  e2fsck: copy fs when using multi-thread fsck
  e2fsck: add assert when copying context
  e2fsck: copy bitmaps when copying context
  e2fsck: open io-channel when copying fs
  e2fsck: create logs for mult-threads
  e2fsck: optionally configure one pfsck thread
  e2fsck: add start/end group for thread
  e2fsck: split groups to different threads
  e2fsck: print thread log properly
  e2fsck: do not change global variables
  e2fsck: optimize the inserting of dir_info_db
  e2fsck: merge dir_info after thread finishes
  e2fsck: merge icounts after thread finishes
  e2fsck: merge dblist after thread finishes
  e2fsck: add debug codes for multiple threads
  e2fsck: merge fs flags when threads finish

Saranya Muruganandam (2):
  e2fsck: propagate number of threads
  e2fsck: Annotating fields in e2fsck_struct

Wang Shilong (39):
  e2fsck: clear icache when using multi-thread fsck
  e2fsck: copy badblocks when copying fs
  e2fsck: merge bitmaps after thread completes
  e2fsck: rbtree bitmap for dir
  e2fsck: merge badblocks after thread finishes
  e2fsck: merge counts after threads finish
  e2fsck: merge dx_dir_info after threads finish
  e2fsck: merge dirs_to_hash when threads finish
  e2fsck: merge context flags properly
  e2fsck: merge quota context after threads finish
  e2fsck: serialize fix operations
  e2fsck: move some fixes out of parallel pthreads
  e2fsck: split and merge invalid bitmaps
  e2fsck: merge EA blocks properly
  e2fsck: kickoff mutex lock for block found map
  e2fsck: allow admin specify number of threads
  e2fsck: adjust number of threads
  e2fsck: fix readahead for pfsck of pass1
  e2fsck: merge options after threads finish
  e2fsck: reset lost_and_found after threads finish
  e2fsck: merge extent depth count after threads finish
  e2fsck: simplify e2fsck context merging codes
  e2fsck: set E2F_FLAG_ALLOC_OK after threads
  e2fsck: wait fix thread finish before checking
  e2fsck: cleanup e2fsck_pass1_thread_join()
  e2fsck: avoid too much memory allocation for pfsck
  e2fsck: make default smallest RA size to 1M
  ext2fs: parallel bitmap loading
  e2fsck: update mmp block in one thread
  e2fsck: reset @inodes_to_rebuild if restart
  e2fsck: fix build for make rpm
  e2fsck: move ext2fs_get_avg_group to rw_bitmaps.c
  configure: enable pfsck by default
  test: add pfsck test
  e2fsck: fix race in ext2fs_read_bitmaps()
  e2fsck: fix readahead for pass1 without pfsck
  e2fsck: fix memory leaks with pfsck enabled
  ext2fs: fix to set tail flags with pfsck enabled
  e2fsck: update mmp block race

 MCONFIG.in                              |    1 +
 configure                               |   90 +-
 configure.ac                            |   26 +
 e2fsck/Makefile.in                      |    9 +-
 e2fsck/dirinfo.c                        |  238 ++-
 e2fsck/dx_dirinfo.c                     |   64 +
 e2fsck/e2fsck.8.in                      |    8 +-
 e2fsck/e2fsck.c                         |   11 +
 e2fsck/e2fsck.h                         |  102 +-
 e2fsck/logfile.c                        |   13 +-
 e2fsck/pass1.c                          | 1766 ++++++++++++++++++++---
 e2fsck/problem.c                        |   11 +
 e2fsck/problem.h                        |    3 +
 e2fsck/readahead.c                      |    4 +
 e2fsck/unix.c                           |   59 +-
 e2fsck/util.c                           |  193 ++-
 lib/config.h.in                         |    3 +
 lib/ext2fs/badblocks.c                  |   85 +-
 lib/ext2fs/bitmaps.c                    |   10 +
 lib/ext2fs/bitops.h                     |    2 +
 lib/ext2fs/blkmap64_rb.c                |   65 +
 lib/ext2fs/bmap64.h                     |    4 +
 lib/ext2fs/dblist.c                     |   38 +
 lib/ext2fs/ext2_err.et.in               |    3 +
 lib/ext2fs/ext2_io.h                    |    2 +
 lib/ext2fs/ext2fs.h                     |   19 +-
 lib/ext2fs/ext2fsP.h                    |    1 -
 lib/ext2fs/gen_bitmap64.c               |   62 +
 lib/ext2fs/icount.c                     |  107 ++
 lib/ext2fs/openfs.c                     |   48 +-
 lib/ext2fs/rw_bitmaps.c                 |  301 +++-
 lib/ext2fs/undo_io.c                    |   19 +
 lib/ext2fs/unix_io.c                    |   24 +-
 lib/support/mkquota.c                   |   39 +
 lib/support/quotaio.h                   |    3 +
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
 tests/f_multithread_ok/expect.1         |    8 +
 tests/f_multithread_ok/image.gz         |  Bin 0 -> 796311 bytes
 tests/f_multithread_ok/name             |    1 +
 tests/f_multithread_ok/script           |   21 +
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
 tests/test_one.in                       |    8 +
 70 files changed, 3335 insertions(+), 393 deletions(-)
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
 create mode 100644 tests/f_multithread_ok/expect.1
 create mode 100644 tests/f_multithread_ok/image.gz
 create mode 100644 tests/f_multithread_ok/name
 create mode 100644 tests/f_multithread_ok/script
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
2.29.2.299.gdc1121823c-goog

