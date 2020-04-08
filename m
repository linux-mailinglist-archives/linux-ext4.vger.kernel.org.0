Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 321FD1A1EEA
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Apr 2020 12:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbgDHKp0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Apr 2020 06:45:26 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39508 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgDHKp0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Apr 2020 06:45:26 -0400
Received: by mail-pl1-f193.google.com with SMTP id k18so2373077pll.6
        for <linux-ext4@vger.kernel.org>; Wed, 08 Apr 2020 03:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lMIySLkaXQrrL3akcnnK6/c55KAu5V0pdrr4J963awY=;
        b=HyFz5qIlN8zviIOc8iJ7NDZQq0nJd9ys/b87A4FaOyHth5sBb8/B++x37tokVCh+qC
         +T1BRpVS6n50u2gwm8zB+o1pM8cI0gDXQ5LKGFZlRL9udCmN3FKlD3QF/bHgEJh9iH+f
         Jpvt1kNfUW3qO1omN/7A4JGM1gtTaihJYdlSsvGZ1b/N4b2vKWVdDeO8Y/BmwHDUQurZ
         W6wnDPn0XFpAZgq0xKAPgWAOdmMlyoeY/geUAcMjviAIO6JmjZ6RGVoWz/sp4kAWcERZ
         KFJlswEl3PtQRVYmmhSzGT/Trf8gq4ccKZHeHgqvBqZhE470ucvqYgzcdRmMk+WqxYE4
         LArw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lMIySLkaXQrrL3akcnnK6/c55KAu5V0pdrr4J963awY=;
        b=CKUpmnHjfhfBTgKms5ulH/eac2gvTA1MY54dcDG09pd15hsQ0WgOWyo9BsIFmjxUXi
         dtpnd57x1LdXiwYYn4k0HkLvBWGCsNi7P+EJT7XarxgNqpQaxJAyEzikSP72ecOC9Rq1
         f0/l7CmPzY2zgkQB2SPTkjboFH3NyAMNjic1f4oGxHJd8WLU+RHaXUXn2goiv4tEiMG1
         HwbXBi7sgq8FZZcK3NzcP4iCIVxV5COV3yxz4R/D5ASgnRSVDykcArae5efNicmacMeg
         S2LL+EGqrzaGW90w1tfyYGLjOXfl0NZeoM9rKWdGlQkTU9uKxfDKD9R0fJkV5xj+Hlj1
         U3Lw==
X-Gm-Message-State: AGi0Pua+HUn8/RPzlZqVOMQXKwfZ2dHQZpO0ftIQ8AT9JQJT37UwVk84
        r3RsJDlaQR9JPXZJ7QT3tNZDxX5JFPM=
X-Google-Smtp-Source: APiQypLYLXKuX620i1GvJgxYtZsvHA22/ksnj0CuTbwUP5+q7GqGkjJlya50W5HM0DeJVbioG/b1HA==
X-Received: by 2002:a17:902:8647:: with SMTP id y7mr6597223plt.87.1586342724378;
        Wed, 08 Apr 2020 03:45:24 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y17sm16177024pfl.104.2020.04.08.03.45.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Apr 2020 03:45:23 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, sihara@ddn.com,
        Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH 00/46] introduce parallel fsck to e2fsck pass1
Date:   Wed,  8 Apr 2020 19:44:28 +0900
Message-Id: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

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

So the whole series is reasonably stable if you are intrested testing it on
different platforms, i've pushed it to github:

https://github.com/wangshilong/e2fsprogs pfsck_pass1_v1

It is definitely in early stage, but i'd like to send it for early
review for any comments or testing etc.

Thanks you very much!
Shilong

Li Dongyang (1):
  libext2fs: optimize ext2fs_convert_subcluster_bitmap()

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

Wang Shilong (20):
  e2fsck: cleanup struct e2fsck_struct
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

 configure.ac                            |    6 +
 e2fsck/dirinfo.c                        |  220 ++-
 e2fsck/dx_dirinfo.c                     |   67 +
 e2fsck/e2fsck.h                         |  336 +++--
 e2fsck/encrypted_files.c                |  175 ++-
 e2fsck/logfile.c                        |   12 +-
 e2fsck/pass1.c                          | 1692 ++++++++++++++++++++---
 e2fsck/problem.c                        |    9 +
 e2fsck/problem.h                        |    3 +
 e2fsck/unix.c                           |   33 +-
 e2fsck/util.c                           |   56 +-
 lib/ext2fs/badblocks.c                  |   75 +-
 lib/ext2fs/bitmaps.c                    |    8 +
 lib/ext2fs/bitops.h                     |    2 +
 lib/ext2fs/blkmap64_rb.c                |   51 +
 lib/ext2fs/bmap64.h                     |    3 +
 lib/ext2fs/dblist.c                     |   36 +
 lib/ext2fs/ext2_err.et.in               |    3 +
 lib/ext2fs/ext2_io.h                    |    2 +
 lib/ext2fs/ext2fs.h                     |   11 +
 lib/ext2fs/ext2fsP.h                    |    1 -
 lib/ext2fs/gen_bitmap64.c               |   89 +-
 lib/ext2fs/icount.c                     |  102 ++
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
 57 files changed, 2858 insertions(+), 455 deletions(-)
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
2.25.2

