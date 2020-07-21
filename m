Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2751322887B
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jul 2020 20:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730128AbgGUSpT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 Jul 2020 14:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbgGUSpS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 21 Jul 2020 14:45:18 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075F3C061794
        for <linux-ext4@vger.kernel.org>; Tue, 21 Jul 2020 11:45:18 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id s189so12333539pgc.13
        for <linux-ext4@vger.kernel.org>; Tue, 21 Jul 2020 11:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8F0I47SalSu7tWceHPLl8k2zKpbw4YBTOmjye/4dLdU=;
        b=tDnGbeQOxePZ7EmwjkJUHNCZ9bMZ5z+QOYyOOwzPEtIqqV39mTYCFAL7F7clljnATJ
         FyZ4VvLCsqf2RHKSiOncCYXkHxPuVEfCfXB+hrXw9lJIadh9jCZ4goMslmgfR/LFOTc3
         eyZsYR+tTT1cTEKiZg4GkUnkuWp75pn7U6r+NJBnGVhlIm12/0YADf1pSXldRlnB4ebN
         /YRCMcMGFLgoAXowBYDI2tf42iFGJHaN8sDP0uaUM9AW8iyRjfFSyWX7ichc2IpEwqtX
         YKBWpypny1zFMV/J4ix5T89Pz1U76keuPvlvH/yfrXmXaHd9Jm5cCNsYhrAgicsEKtVW
         +j7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8F0I47SalSu7tWceHPLl8k2zKpbw4YBTOmjye/4dLdU=;
        b=c7G3mMdP1d401ANjYtfLR9BTkfBL5r/nhb2uqDCou0SIuBivMLPJERVFhb6Z8MjLFE
         n8x2W7AkJS3TGp2VfA+xCfmoqzVKMqRL0wJGId9qApHYilNMiulxAF3jQJRhjCJEltiM
         vAU1j+YVKR44B5l0N1mL7d5QD5wmVVoZHESVG+RxMpdYs9sC26fkTwDhWBD35BVOiz6a
         kvEaiNWzi9SKlg1WWbD0MRrujd99222mglW2AHwu0TDYyCevaeE05Sgn8k5jBHXZGPNz
         FzcQHs/eO1PTS1V40ADv0LgDj6kBr0Zv93ANVh0gw3hajpdslO5ebmN3XXjf5a65/pHl
         EoZA==
X-Gm-Message-State: AOAM532RtUjessF1OslplD7lS6NxcDkVFDmAiaNWSplZQBYGj4AKWdTU
        zdkhH5fS5sE+Yc48UbPm5Dcx2GxB
X-Google-Smtp-Source: ABdhPJwXqjbRfybV4P1W/pAHK3vB5WTgWVykyMU5uij53PPFvaKjJ3ar3tgq0dCz3XQZNRYogepfYA==
X-Received: by 2002:a63:338c:: with SMTP id z134mr23163147pgz.245.1595357116787;
        Tue, 21 Jul 2020 11:45:16 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id b13sm4179890pjl.7.2020.07.21.11.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 11:45:15 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v8 0/7] ext4: add fast commits feature
Date:   Tue, 21 Jul 2020 11:43:48 -0700
Message-Id: <20200721184355.1616986-1-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
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

Performance Evaluation
----------------------

Ext4 performance was compared with and without fast commits using
fsmark, dbench and filebench benchmarks with local file system and
over NFS. This is the summary of results:

|-----------+-------------------+----------------+----------------+------------|
| Benchmark | Config            | No FC          | FC             | % increase |
|-----------+-------------------+----------------+----------------+------------|
| Fsmark    | Local, 8 threads  | 1475.1 files/s | 4309.8 files/s |      192.2 |
| Fsmark    | NFS, 4 threads    | 299.4 files/s  | 409.45 files/s |       36.8 |
|-----------+-------------------+----------------+----------------+------------|
| Dbench    | Local, 2 procs    | 33.32 MB/s     | 70.87 MB/s     |      112.7 |
| Dbench    | NFS, 2 procs      | 8.84 MB/s      | 11.88 MB/s     |       34.4 |
|-----------+-------------------+----------------+----------------+------------|
| Dbench    | Local, 10 procs   | 90.48 MB/s     | 110.12 MB/s    |       21.7 |
| Dbench    | NFS, 10 procs     | 34.62 MB/s     | 52.83 MB/s     |       52.6 |
|-----------+-------------------+----------------+----------------+------------|
| FileBench | Local, 16 threads | 10442.3 ops/s  | 18617.8 ops/s  |       78.3 |
|           | (Varmail)         |                |                |            |
| FileBench | NFS, 16 threads   | 1531.3 ops/s   | 2681.5 ops/s   |       75.1 |
|           | (Varmail)         |                |                |            |
|-----------+-------------------+----------------+----------------+------------|

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---

Changes since V7:
 - Fixed compilation errors for (patch 5/7) "ext4: main fast-commit
   commit path"

Changes since V6:
 - Rebased on top of v5.7
 - Re-designed the on-disk format
 - Handled extent tree splitting during recovery (by adding a simple allocator)
 - Handled inode deletion case in fast commits
 - Added more documentation in the code

Harshad Shirwadkar (7):
 doc: update ext4 and journalling docs to include fast commit feature
 ext4: add fast_commit feature and handling for extended mount options
 ext4 / jbd2: add fast commit initialization
 jbd2: add fast commit machinery
 ext4: main fast-commit commit path
 jbd2: fast commit recovery path
 ext4: fast commit recovery path

 Documentation/filesystems/ext4/journal.rst |   66 +
 Documentation/filesystems/journalling.rst  |   28 +
 fs/ext4/Makefile                           |    3 +-
 fs/ext4/acl.c                              |    2 +
 fs/ext4/balloc.c                           |    7 +-
 fs/ext4/ext4.h                             |   88 ++
 fs/ext4/ext4_jbd2.c                        |    2 +-
 fs/ext4/extents.c                          |  258 +++-
 fs/ext4/extents_status.c                   |   24 +
 fs/ext4/fast_commit.c                      | 2064 ++++++++++++++++++++++++++++
 fs/ext4/fast_commit.h                      |  159 +++
 fs/ext4/file.c                             |   10 +-
 fs/ext4/fsync.c                            |    2 +-
 fs/ext4/ialloc.c                           |  165 ++-
 fs/ext4/inode.c                            |  130 +-
 fs/ext4/ioctl.c                            |   22 +-
 fs/ext4/mballoc.c                          |  225 ++-
 fs/ext4/mballoc.h                          |    2 +
 fs/ext4/namei.c                            |  179 ++-
 fs/ext4/super.c                            |   73 +-
 fs/ext4/xattr.c                            |    3 +
 fs/jbd2/commit.c                           |   60 +
 fs/jbd2/journal.c                          |  238 +++-
 fs/jbd2/recovery.c                         |   56 +-
 include/linux/jbd2.h                       |   91 +-
 include/trace/events/ext4.h                |  228 ++-
-- 
2.28.0.rc0.105.gf9edc3c819-goog

