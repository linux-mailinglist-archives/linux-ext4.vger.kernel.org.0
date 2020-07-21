Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D70228448
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jul 2020 17:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbgGUPzj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 Jul 2020 11:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgGUPzi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 21 Jul 2020 11:55:38 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C9DC061794
        for <linux-ext4@vger.kernel.org>; Tue, 21 Jul 2020 08:55:38 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id md7so1887051pjb.1
        for <linux-ext4@vger.kernel.org>; Tue, 21 Jul 2020 08:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xaK/i37dt4Zmiz0SvKaQVParatgP1uJbhhFwmY+84S4=;
        b=s8cfSU2Qz3YqJmb/1CfiLEbeTOTCrst1Xn4g0V0JN2GPD5MxblhED1/kSO0ejK2NBa
         8M90Sweo363y1jDCm/BIzTrkaaGkYJOej3KWpgfYRQ9VvzJANCRTILzi6g8aQAenvunQ
         RkO/QnjebhXNTbKsaLIkHeJS0TXPRLiMaDexIkNr370tH2rT4SfElzE7HFDCnY9+B18c
         93Lgpa+b6hP510G5CgZs1oKU38QBvFkek5TNJRlVGsF0y/4oo4ZA3zwhEM/Jhnzz1Ju1
         TdCOMYqeuqbbtSZKTJG5CTHA2GCSXzVlz2bVB6lJ7M48Y/v3Qb1m+5UKujErs+dLc+G1
         FMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xaK/i37dt4Zmiz0SvKaQVParatgP1uJbhhFwmY+84S4=;
        b=PQSHlPLeBWmKyx5TSFGCfElG7ZX6q0DNczH6AO0RbR0EDCbcTq2avtXw0TQ8JpZIrs
         1k4SjuaAnP53myxAA/rYH/FPNPWGN4WfPGsBBPZEL+ohbTWd5/xujVFCll+0u06uyrWh
         e4g8dMAo2MYMfhTLwClmUiOf71dVZXsDWOQ0T52mx7v1LL7jcA81uGaTtxbxC+Rm2td6
         zs+B2vgd1PD1S0FeV/juCH05RK9kpfaW00M4md0ZmNxwo9Gl9a1kjmJrq9W6J7ihf8uX
         1NZWvDow8kUYKAfpEF+9wBeECpU0iuJ8Td2yVJKbQs121pMq78OxLLj8uI9p+i6PQCNl
         qx3A==
X-Gm-Message-State: AOAM532xnEmamtee2XLeJX1myW4pMlW6m+Ur6jxrlrRW3LgmzkJhMOAp
        0gd+RzuZHbrsTyjuKZmwEuxPzlyg
X-Google-Smtp-Source: ABdhPJyVuzk3CZFGVaeoLkiCEs9X76m7bdEoSaOFmbYzCQE6hnvVnrUa4jQwXESE/UGb8zkouLcHAw==
X-Received: by 2002:a17:90a:266f:: with SMTP id l102mr5392285pje.144.1595346937528;
        Tue, 21 Jul 2020 08:55:37 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id b8sm3657824pjm.31.2020.07.21.08.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 08:55:36 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v7 0/7] ext4: add fast commits feature
Date:   Tue, 21 Jul 2020 08:54:48 -0700
Message-Id: <20200721155455.1364597-1-harshadshirwadkar@gmail.com>
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

