Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5B028FA2D
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Oct 2020 22:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730559AbgJOUiM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Oct 2020 16:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729735AbgJOUiM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Oct 2020 16:38:12 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCB5C061755
        for <linux-ext4@vger.kernel.org>; Thu, 15 Oct 2020 13:38:11 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id g16so89373pjv.3
        for <linux-ext4@vger.kernel.org>; Thu, 15 Oct 2020 13:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6+MlawTaCOrxfACK4vEIl/tMsEy8gC+O0xtd2MvsEGg=;
        b=kb2m5f9eFa1b0RUe7hwhj0Xbyg5J5rvz1N3A+n7l2BFKd+zwkD6i4/IrLAdIer6jtu
         Wb5RmX+qg4zOoSfvu212vVTrUzTTq4hKgxf1Bbn9uOZc8fMsYjdDWemep1zoV8QfmMRj
         aQKqBfj9QXBXWXhbWT9q2YnZ4DBllYdpTHjdrzLBEicyFv+02i4u3VtK90fJNIOoq8cZ
         MkH9ItBEgad7CHm5cy4Mk0vCVD4yUY1aNt47/LfuKf5l8XZLwJb4RUAKkR496jNiQKiG
         L3dh+3lPeLDgMYBL6cWk6czB9bM4p17umNLkvlkjqS4CFwny5/bJlfkTQ5vJ6KFBGB6J
         zvgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6+MlawTaCOrxfACK4vEIl/tMsEy8gC+O0xtd2MvsEGg=;
        b=YDbeyC+Hdbpa9tlVX+BC8zavW69P+By3repH4Q9ZdOLmnTlD5FYD8cWO7s5jIirrrS
         l9r2xKd4D3B5JoL3bnYD57qZ7S9VHcOBKHpFsagZrWVMtIk9MwAut+MXTAJxShJlyC2a
         E0xNBd0fVbPf/ZIpswci5aLD4KHQpjrrkcCWrcfMexhTLk8nGNgIkGscQwS2u+vvVEzD
         ksr/5hCKZ90mSBK9z0EsQJ2Ixnraxcwe9ybG2bayVTwkfz31/1Vy/UoPP+XfyZpcz53d
         l4mIq7OUBDRNnhRTZXcSQvTCMUWxk4CLiBbiaypKLaq5N9OqIw2G7o2NDkM3XGQgg/ug
         BwQQ==
X-Gm-Message-State: AOAM532qE/UueiJ81eP151KgIqd1zEzgbh2iXKpIRKizN1Q6MNyyHNzD
        cs3wD4MrApbk/loBPztnnp31XeHdqZ0=
X-Google-Smtp-Source: ABdhPJyaUxnNbCHQROWJ8kr3elmUH8wE/dAcy80lQTxMLqAil7ErFMlrZjwyMroG/hDrSEX4SUJV6Q==
X-Received: by 2002:a17:90a:8684:: with SMTP id p4mr473971pjn.232.1602794289939;
        Thu, 15 Oct 2020 13:38:09 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id j8sm136860pfr.121.2020.10.15.13.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 13:38:09 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v10 0/9] Add fast commits in Ext4 file system
Date:   Thu, 15 Oct 2020 13:37:52 -0700
Message-Id: <20201015203802.3597742-1-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
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

Changes since V9
----------------

* Removed "PARTIAL_INODE" tag and now only using "FULL_INODE" tag for
  replay.
* A few bugfixes as pointed out by Ritesh and Ted.
* Readability improvements: added more comments and made naming of
  variables more consistent
* Documentation updates

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
 Documentation/filesystems/journalling.rst  |   33 +
 fs/ext4/Makefile                           |    2 +-
 fs/ext4/acl.c                              |    2 +
 fs/ext4/balloc.c                           |    7 +-
 fs/ext4/ext4.h                             |  101 +
 fs/ext4/ext4_jbd2.c                        |    2 +-
 fs/ext4/extents.c                          |  309 ++-
 fs/ext4/extents_status.c                   |   24 +
 fs/ext4/fast_commit.c                      | 2128 ++++++++++++++++++++
 fs/ext4/fast_commit.h                      |  159 ++
 fs/ext4/file.c                             |   10 +-
 fs/ext4/fsync.c                            |    2 +-
 fs/ext4/ialloc.c                           |  168 +-
 fs/ext4/inode.c                            |  130 +-
 fs/ext4/ioctl.c                            |   22 +-
 fs/ext4/mballoc.c                          |  206 +-
 fs/ext4/namei.c                            |  186 +-
 fs/ext4/super.c                            |   84 +-
 fs/ext4/sysfs.c                            |    2 +
 fs/ext4/xattr.c                            |    3 +
 fs/jbd2/commit.c                           |   44 +
 fs/jbd2/journal.c                          |  243 ++-
 fs/jbd2/recovery.c                         |   57 +-
 include/linux/jbd2.h                       |   91 +-
 include/trace/events/ext4.h                |  228 ++-
 26 files changed, 4144 insertions(+), 165 deletions(-)
 create mode 100644 fs/ext4/fast_commit.c
 create mode 100644 fs/ext4/fast_commit.h

-- 
2.29.0.rc1.297.gfa9743e501-goog

