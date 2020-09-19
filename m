Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2445A27098A
	for <lists+linux-ext4@lfdr.de>; Sat, 19 Sep 2020 02:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgISAzJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Sep 2020 20:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgISAzJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 18 Sep 2020 20:55:09 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CCEC0613CE
        for <linux-ext4@vger.kernel.org>; Fri, 18 Sep 2020 17:55:09 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id fa1so4059184pjb.0
        for <linux-ext4@vger.kernel.org>; Fri, 18 Sep 2020 17:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0VzDZdmhYWxivoll+pczMd4wScWUM7kC+79l22crOJ4=;
        b=pWa5l8ZuYieZgtDw2ZbskaVroWWj27R44hwmFkWT9s9URdezkmmliP3ZxHYDZqz+GZ
         wgv0+WdyPNLiw8mpizwo2vDKdqXn61tuhG6u2qDam0CMsLNw0pxBAfbTdu7CD7t+7H83
         lJ2ZkTolPrZYuIGIaAxUE+v9uEhvwnDV6FKfTlSPwaNjpE7PeOZqMCHt6tHsg0Gg2qje
         hgFQ3Cvbrqe/yFw7WFSlAE8K4zX6Q0+hyBWm28IC874WZloIuYEMpsWd+dnZtIQ7rlA8
         a1UhP+/VZrtnRJ7vpiSMEQgshwB2U3P1n3nbyD2OTIq/QTtpf78H6AqMqfrceSppAL8D
         kYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0VzDZdmhYWxivoll+pczMd4wScWUM7kC+79l22crOJ4=;
        b=iwi5ompEec2YndHRWHY2T1c4THB1aonWI+ryOxZuaYQG1dw9kpPluClZgznJ5imMLM
         a94OoDnOixmfrR6cKM1znO7cEjA0k9+w49czjb7+RMyEg8o484yg/OqpwYRLgzy/B0BI
         a4m9X0r1H1EbzfGGAzB0mifRkp8iv9pU2J4+OdI2PfphDlDmxlNRo60kn+JY5IevzMCz
         sgYCnOnb5dm+O/vJfWMG8dbAzEfstyS/PLThmGr0VqV4nG4JtA1U1c0uKzrBQN7XKmyQ
         5w3t1EPzMfPMl7kpKfTy52qfEr9BU6L85xwz9gnLcVjCP5pc+knhgaDnKRp3KRxc+uQR
         jQlA==
X-Gm-Message-State: AOAM532ca2FAtgGlI5aa3BXEYH0BLHTKgpH6HJhIA+fn3OIDcnG1bXR5
        71zdkT5A5qseY3qVWA/Pg5r8a5CDfqQ=
X-Google-Smtp-Source: ABdhPJxE/cA7l/GlLBHMglTKXJt2nJZ5JlA9jGPMipEJzx7E4aZ5bvrK99jc2XZecOotZJPro529Jw==
X-Received: by 2002:a17:902:8bc2:b029:d0:cbe1:e709 with SMTP id r2-20020a1709028bc2b02900d0cbe1e709mr34508160plo.23.1600476908086;
        Fri, 18 Sep 2020 17:55:08 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id f28sm4621953pfq.191.2020.09.18.17.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 17:55:05 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v9 0/9] ext4: add fast commits feature
Date:   Fri, 18 Sep 2020 17:54:42 -0700
Message-Id: <20200919005451.3899779-1-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch series adds support for fast commits which is a simplified
version of the scheme proposed by Park and Shin, in their paper,
"iJournaling: Fine-Grained Journaling for Improving the Latency of
Fsync System Call"[1]. The basic idea of fast commits is to make JBD2
give the client file system an opportunity to perform a faster
commit. Only if the file system cannot perform such a commit
operation, then JBD2 should fall back to traditional commits.

Because JBD2 operates at block granularity, for every file system
metadata update it commits all the changed blocks are written to the
journal at commit time. This is inefficient because updates to some
blocks that JBD2 commits are derivable from some other blocks. For
example, if a new extent is added to an inode, then corresponding
updates to the inode table, the block bitmap, the group descriptor and
the superblock can be derived based on just the extent information and
the corresponding inode information. So, if we take this relationship
between blocks into account and replay the journalled blocks smartly,
we could increase performance of file system commits significantly.

Fast commits introduced in this patch have two main contributions:

(1) Making JBD2 fast commit aware, so that clients of JBD2 can
    implement fast commits

(2) Add support in ext4 to use JBD2's new interfaces and implement
    fast commits

Fast commit operation
---------------------

The new fast commit operation works by tracking file system deltas
since last commit in memory and committing these deltas to disk during
fsync(). Ext4 maintains directory entry updates in an in-memory
queue. Also, the inodes that have changed since last commit are
maintained in an in-memory queue. These queues are flushed to disk
during the commit time in a log-structured way. Fast commit area is
organized as a log of TAG-LENGTH-VALUE tuples with a special "tail"
tag marking the end of a commit. If certain operation prevents fast
commit from happening, the commit code falls back to JBD2 full commit
operation and thus invalidating all the fast commits since last full
commit. JBD2 provides new jbd2_fc_start() and jbd2_fc_stop() functions
to co-ordinate between JBD2's full commits and client file system's
fast commits.

Recovery operation
------------------

During recovery, JBD2 lets the client file system handle fast commit
blocks as it wants. After performing transaction replay, JBD2 invokes
client file system's recovery path handler. During the scan phase,
Ext4's recovery path handler determines the validity of fast commit
log by making sure CRC and TID of fast commits are valid. During the
replay phase, the recovery handler replays tags one by one. These
replay handlers are idempotent. Thus, if we crash in the middle of
recovery, Ext4 can restart the log replay and reach the identical
final state.

Testing
-------

e2fsprogs was updated to set fast commit feature flag and to ignore
fast commit blocks during e2fsck.

https://github.com/harshadjs/e2fsprogs.git

No regressions were introduced in smoke tests.

How to Use this feature?
-----------------------

This feature should not be used in production until corresponding
e2fsprogs changes are ready. These changes are being worked on at -
https://github.com/harshadjs/e2fsprogs.git. This feature can be set at
mkfs time. For testing purposes, this feature can also be enabled by
passing a mount time flag "fc_debug_force". This mount flag should
only be used for testing purposes and never for production.

Once enabled, fast commit information can be viewed in
/proc/fs/ext4/<dev>/fc_info.

Performance Evaluation
----------------------

Ext4 performance was compared with and without fast commits using
fsmark, dbench and filebench benchmarks with local file system and
over NFS. This is the summary of results:

|-----------+-------------------+----------------+----------------+--------|
| Benchmark | Config            | No FC          | FC             | % diff |
|-----------+-------------------+----------------+----------------+--------|
| Fsmark    | Local, 8 threads  | 1475.1 files/s | 4309.8 files/s | +192.2 |
| Fsmark    | NFS, 4 threads    | 299.4 files/s  | 409.45 files/s |  +36.8 |
|-----------+-------------------+----------------+----------------+--------|
| Dbench    | Local, 2 procs    | 33.32 MB/s     | 70.87 MB/s     | +112.7 |
| Dbench    | NFS, 2 procs      | 8.84 MB/s      | 11.88 MB/s     |  +34.4 |
|-----------+-------------------+----------------+----------------+--------|
| Dbench    | Local, 10 procs   | 90.48 MB/s     | 110.12 MB/s    |  +21.7 |
| Dbench    | NFS, 10 procs     | 34.62 MB/s     | 52.83 MB/s     |  +52.6 |
|-----------+-------------------+----------------+----------------+--------|
| FileBench | Local, 16 threads | 10442.3 ops/s  | 18617.8 ops/s  |  +78.3 |
|           | (Varmail)         |                |                |        |
| FileBench | NFS, 16 threads   | 1531.3 ops/s   | 2681.5 ops/s   |  +75.1 |
|           | (Varmail)         |                |                |        |
|-----------+-------------------+----------------+----------------+--------|

NFS Performance Evaluation
--------------------------

NFS performs commit_metadata operation very frequently which resulted
in a linux kernel untar operation resulting in over ~180 journal
commits / second. The same untar operation results in 2.5 commits /
second. However, as the above table shows, the benefits that NFS sees
aren't as great as the local disk. The reason for that is the network
latency. Before fast commits, NFS was bottlenecked on journal commit
performance. However, with fast commits reducing that time
significantly, NFS performance now gets bottlenecked on network
latency. NFS running on networks with lower latency (< 300 us) will
see better performance than the NFS numbers reported above.

DAX Support
-----------

Fast commits helps improve Ext4 performance on DAX devices
too. However, there as an opportunity to do even better. Collaborating
with Rohan Kadekodi (rak@cs.utexas.edu) from UT Austin and Saurabh
Kadekodi (saukad@cs.cmu.edu) from CMU, we have added synchronous fast
commits which write at byte granularity (instead of block
granularity). This is WIP available at -
https://github.com/harshadjs/linux/tree/fc-pmem-renewed. Doing this
way, we get stronger guarantees than current Ext4 very cheaply on
persistent memory devices.

Changes since V8
----------------

* Added procfs tracking for fast commits
* Improved recovery path
* Added mount option to turn fast commits on for testing purpose
* A few bugfixes
* Rebased on top of ext4 dev branch

[1] iJournaling: Fine-Grained Journaling for Improving the Latency of
Fsync System Call
https://www.usenix.org/conference/atc17/technical-sessions/presentation/park

Harshad Shirwadkar (9):
  doc: update ext4 and journalling docs to include fast commit feature
  ext4: add fast_commit feature and handling for extended mount options
  ext4 / jbd2: add fast commit initialization
  jbd2: add fast commit machinery
  ext4: main fast-commit commit path
  jbd2: fast commit recovery path
  ext4: fast commit recovery path
  ext4: add a mount opt to forcefully turn fast commits on
  ext4: add fast commit stats in procfs

 Documentation/filesystems/ext4/journal.rst |   66 +
 Documentation/filesystems/journalling.rst  |   28 +
 fs/ext4/Makefile                           |    2 +-
 fs/ext4/acl.c                              |    2 +
 fs/ext4/balloc.c                           |    7 +-
 fs/ext4/ext4.h                             |   95 +
 fs/ext4/ext4_jbd2.c                        |    2 +-
 fs/ext4/extents.c                          |  309 ++-
 fs/ext4/extents_status.c                   |   24 +
 fs/ext4/fast_commit.c                      | 2149 ++++++++++++++++++++
 fs/ext4/fast_commit.h                      |  160 ++
 fs/ext4/file.c                             |   10 +-
 fs/ext4/fsync.c                            |    2 +-
 fs/ext4/ialloc.c                           |  165 +-
 fs/ext4/inode.c                            |  130 +-
 fs/ext4/ioctl.c                            |   22 +-
 fs/ext4/mballoc.c                          |  208 +-
 fs/ext4/namei.c                            |  185 +-
 fs/ext4/super.c                            |   81 +-
 fs/ext4/sysfs.c                            |    2 +
 fs/ext4/xattr.c                            |    3 +
 fs/jbd2/commit.c                           |   61 +
 fs/jbd2/journal.c                          |  238 ++-
 fs/jbd2/recovery.c                         |   59 +-
 include/linux/jbd2.h                       |   91 +-
 include/trace/events/ext4.h                |  228 ++-
 26 files changed, 4164 insertions(+), 165 deletions(-)
 create mode 100644 fs/ext4/fast_commit.c
 create mode 100644 fs/ext4/fast_commit.h

-- 
2.28.0.681.g6f77f65b4e-goog

