Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69DE487041
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Aug 2019 05:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405079AbfHIDqW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Aug 2019 23:46:22 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33552 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733140AbfHIDqV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Aug 2019 23:46:21 -0400
Received: by mail-pf1-f195.google.com with SMTP id g2so45275990pfq.0
        for <linux-ext4@vger.kernel.org>; Thu, 08 Aug 2019 20:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cWw3tq/UuLODm+8cU6ssl8vcc+qasLgnlhst3VdZZO4=;
        b=pPnQ6Dq6JZuDBeu5eGqyLdkmSboFXNn0z5S+odJhwToa4CFRvUqOYiuy2xLrZUvS3J
         mbv8Wpk+3NQBNOG5Q4Qo5OPu+l9bwIX/LW9XmAXWViZs+ozgO8Qnd0MCM3a0+wfBlXQj
         ABjYaAp65MDmEZgiK3kEK8kdWrhMkdU0/R0cS10wF/JvUghFy8WdQULqjiL7lA5K864M
         CIuZWLvtfDqewYf4qKH0jm5SfH57h8WPFn/nCbmEvZWtsYoiMfNKDnKRYHdq2KMotVZj
         zhXDrG0gXH7WbEZMZwMlDyX8BS1FTOzO6g4irPZlfsxPnbr6LixNmf7uRMRSVZUw30pe
         ZnrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cWw3tq/UuLODm+8cU6ssl8vcc+qasLgnlhst3VdZZO4=;
        b=cRxNppV8smTdgaLXywnJ08KKwemJolYKKpIEEg6dkbCfCMdMpfrmyC/DNO6z3ot68o
         dg0HYmn51AxusVEM+dvRLX12vMRp7IlExXDe5M2ePAda/sk0Q2mwtVjdJhZ5hGEJ0vRd
         F6Ev3wkr5yhgUF1N4O/2Kc0hz3f3LjLNhimLXqS/rXmejbrQZY1iqPwkjIv74qtC5SAs
         1bleTM+7IE2v3rh6hJM6swgVPyfy+noA2If9LYkcTyb8UKVQ/pqkBY4oxkSHvmwWClmX
         u4oOAIqxEld/5/BUNlB1VGTQNcPjyvUCM1RSofCP9Kv18Z38/pDUTZhVhFi348cgiFtO
         0alA==
X-Gm-Message-State: APjAAAWTIr69OKEmRhbwu7z0KQ8JnsJyq84+B7FOhHqkt/0R/fAP2DZq
        64AudOn5STKqgPTPQqA9lvR2fZa+
X-Google-Smtp-Source: APXvYqw70byQugvoKqKP7tm49Lwj6bKQlHvW660zM7EnRw1fmQkk7KXE6shqYLn8AfnwzXWcaiYQiQ==
X-Received: by 2002:a17:90a:9505:: with SMTP id t5mr7255775pjo.96.1565322380145;
        Thu, 08 Aug 2019 20:46:20 -0700 (PDT)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id s5sm80191085pfm.97.2019.08.08.20.46.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 20:46:19 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v2 00/12] ext4: add support fast commit
Date:   Thu,  8 Aug 2019 20:45:40 -0700
Message-Id: <20190809034552.148629-1-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
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
metadata update it commits all the changed blocks to the journal at
commit time. This is inefficient because updates to some blocks that
JBD2 commits are derivable from some other blocks. For example, if a
new extent is added to an inode, then corresponding updates to the
inode table, the block bitmap, the group descriptor and the superblock
can be derived based on just the extent information and the
corresponding inode information. So, if we take this relationship
between blocks into account and replay the journalled blocks smartly,
we could increase performance of file system commits significantly.

Fast commits introduced in this patch has two main contributions:

(1) Making JBD2 fast commit aware, so that clients of JBD2 can
    implement fast commits

(2) Add support in ext4 to use JBD2's new interfaces and implement
    fast commits

Testing
-------

e2fsprogs was updated to set fast commit feature flag and to ignore
fast commit blocks during e2fsck.

https://github.com/harshadjs/e2fsprogs.git

After applying all the patches in this series, following runs of
xfstests were performed:

- kvm-xfstest.sh -g log -c 4k
- kvm-xfstests.sh smoke

All the log tests were successful and smoke tests didn't introduce any
additional failures.

Performance Evaluation
----------------------

In order to evaluate fast commit performance we used fs_mark
benchmark. We updated fs_mark benchmark to send fsync() calls after
every write operation.

https://github.com/harshadjs/fs_mark.git

Following are the results that we got:

Write performance measured in MB/s with 4 parallel threads file sizes
(X) vs write unit sizes (Y).

Without Fast Commit:

|-----+------+------+------|
|     |  32k | 128k | 256k |
|-----+------+------+------|
| 4k  | 0.27 | 0.25 | 0.24 |
| 8k  | 0.45 | 0.51 | 0.46 |
| 32k | 2.15 | 2.23 | 2.28 |
|-----+------+------+------|

With Fast Commit:

|-----+------+------+------|
|     |  32k | 128k | 256k |
|-----+------+------+------|
| 4k  | 0.74 | 1.42 | 1.94 |
| 8k  | 1.52 | 1.88 | 2.48 |
| 32k |  1.8 | 4.29 | 7.38 |
|-----+------+------+------|

On an average, fast commits increased file system write performance by
280% on modified fs_mark benchmark.

Harshad Shirwadkar(13):
 docs: Add fast commit documentation
 ext4: fast-commit recovery path changes
 ext4: fast-commit commit path changes
 ext4: fast-commit commit range tracking
 ext4: track changed files for fast commit
 ext4: add fields that are needed to track changed files
 jbd2: fast-commit recovery path changes
 jbd2: fast-commit commit path new APIs
 jbd2: fast-commit commit path changes
 jbd2: fast commit setup and enable
 jbd2: add fast commit fields to journal_s structure
 ext4: add handling for extended mount options
 ext4: add support fast commit

 Documentation/filesystems/ext4/journal.rst |   78 ++
 Documentation/filesystems/journalling.rst  |   15
 fs/ext4/acl.c                              |    1
 fs/ext4/balloc.c                           |    7
 fs/ext4/ext4.h                             |   87 +++
 fs/ext4/ext4_jbd2.c                        |   92 +++
 fs/ext4/ext4_jbd2.h                        |   29 +
 fs/ext4/extents.c                          |   44 +
 fs/ext4/fsync.c                            |    2
 fs/ext4/ialloc.c                           |    1
 fs/ext4/inline.c                           |   17
 fs/ext4/inode.c                            |   62 +-
 fs/ext4/ioctl.c                            |    3
 fs/ext4/mballoc.c                          |   83 ++
 fs/ext4/mballoc.h                          |    2
 fs/ext4/migrate.c                          |    1
 fs/ext4/namei.c                            |   14
 fs/ext4/super.c                            |  538 ++++++++++++++++++-
 fs/ext4/xattr.c                            |    1
 fs/jbd2/checkpoint.c                       |    2
 fs/jbd2/commit.c                           |   85 ++-
 fs/jbd2/journal.c                          |  230 +++++++-
 fs/jbd2/recovery.c                         |   70 ++
 fs/jbd2/transaction.c                      |    6
 fs/ocfs2/alloc.c                           |    2
 fs/ocfs2/journal.c                         |    4
 fs/ocfs2/super.c                           |    2
 include/linux/jbd2.h                       |  106 +++
 include/trace/events/ext4.h                |   59 ++
 include/trace/events/jbd2.h                |    9
 30 files changed, 1561 insertions(+), 91 deletions(-)
-- 
2.23.0.rc1.153.gdeed80330f-goog

