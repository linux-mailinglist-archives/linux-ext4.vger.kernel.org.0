Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D442C2E54
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Oct 2019 09:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732953AbfJAHmE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 1 Oct 2019 03:42:04 -0400
Received: from mail-pf1-f177.google.com ([209.85.210.177]:39415 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728249AbfJAHmE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 1 Oct 2019 03:42:04 -0400
Received: by mail-pf1-f177.google.com with SMTP id v4so7301058pff.6
        for <linux-ext4@vger.kernel.org>; Tue, 01 Oct 2019 00:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pXj9qX4zwEp9vOKqWNSfk580fjJgOhzVTrplm2CaoDM=;
        b=tdifwMp+iV9Jy06tN4UGZZqXl045/gLOY8yy9kRBJkhhzzrNUXdPX9IDl0AtLmc7g/
         HGjn0+wK/2gNVfA4cpnC6V/TlaiG2nGKn/WwogXiE1n6TILibmYwJMxSqE4UU7SLUW1E
         /wVZUifXvAEuyhgFl1acxjYWQ8oBHFJ6oZPz4ECKwL+8UvnJj1fIsByfgi4Am8RG3yDJ
         L3BBcR/7yQW7qgIB0hvzSFM43xL5F4biivMzYtcr7PpKkooXxhSPwSLPKJhX6usv/Zhb
         qrnlIaqOY2MiVrFdvp9/CS5hujyoI7iSX2U6JPDWYpN/7TfIuaiMbouGzyJmlzDo9d6t
         /h7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pXj9qX4zwEp9vOKqWNSfk580fjJgOhzVTrplm2CaoDM=;
        b=pPrZK+Ub4NwCfk8YdgayF3yuc4hGJLPUXB0kWjRcw0EKw/6Oi9uo9N4HEA7dfP0OyL
         9QfzVffnal4VQWLIDDoALWUgOd5VcO1rNrokxf6IKrsvmonbAPGIciGPiu0Rv8mnLC9T
         I1pp/wK6t8pitf7oh+Xs3jBgPYRaa10s4g1ss0WeARx4Xe5jR0ihi7ecfWQtClsbjjIR
         kPm6ljt1f9POQWIKPecsmCI7RvQrLUTiEgEKM1RosnfbeFh0gz3zDC4pNPbQOxeTeWvS
         BvXCjpfwMj/7GYvfCZsQxcQc4y1fDuSGmRIF66qqOIZu6kdxPQef+dra1RBsQpBIaGVN
         7rew==
X-Gm-Message-State: APjAAAV4UJEWMXgqEZWVOc60oVOZP/5aj7pXqYxF9w4b8WgnioW6NxCi
        7pM0cSAMpC6cgZX2VC1SpRX5MPA98qI=
X-Google-Smtp-Source: APXvYqyOgvt+KnkiwlLmPmD9XheEhKNHXtsG6SXHV4Qs096CQwrGpLz37Y4+G+LT0dwguV4ak60/Rw==
X-Received: by 2002:a63:e658:: with SMTP id p24mr29844335pgj.61.1569915721511;
        Tue, 01 Oct 2019 00:42:01 -0700 (PDT)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id q13sm2287668pjq.0.2019.10.01.00.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 00:42:00 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v3 00/13] ext4: add fast commit support
Date:   Tue,  1 Oct 2019 00:40:49 -0700
Message-Id: <20191001074101.256523-1-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
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

Ext4 file system performance was tested with and without fast commit
using fs_mark benchmark. Following was the command used:

Command: ./fs_mark -t 8 -n 1024 -s 65536 -w 4096 -d /mnt

Results:
Without Fast Commit: 1501.2 files/sec
With Fast commits: 3055 files/sec
~103% write performance improvement

Changes since V2:

- Added ability to support new file creation in fast commits. This
  allows us to use fs_mark benchmark for performance testing

- Added support for asynchronous fast commits

- Many cleanups and bug fixes

- Re-organized the patch set, moved most of the new code to
  ext4_jbd2.c instead of super.c

- Handling of review comments on previous patchset

Harshad Shirwadkar(13):
 docs: Add fast commit documentation
 ext4: add support for asynchronous fast commits
 ext4: fast-commit recovery path changes
 ext4: fast-commit commit path changes
 ext4: fast-commit commit range tracking
 ext4: track changed files for fast commit
 ext4: add fields that are needed to track changed files
 jbd2: fast-commit recovery path changes
 jbd2: fast-commit commit path new APIs
 jbd2: fast-commit commit path changes
 jbd2: fast commit setup and enable
 ext4: add handling for extended mount options
 ext4: add fast commit support

 Documentation/filesystems/ext4/journal.rst |   98 +-
 Documentation/filesystems/journalling.rst  |   22
 fs/ext4/acl.c                              |    1
 fs/ext4/balloc.c                           |    7
 fs/ext4/ext4.h                             |   86 +
 fs/ext4/ext4_jbd2.c                        |  902 +++++++++++++++++++
 fs/ext4/ext4_jbd2.h                        |   98 ++
 fs/ext4/extents.c                          |   43
 fs/ext4/fsync.c                            |    7
 fs/ext4/ialloc.c                           |   60 -
 fs/ext4/inline.c                           |   14
 fs/ext4/inode.c                            |   77 +
 fs/ext4/ioctl.c                            |    9
 fs/ext4/mballoc.c                          |   83 +
 fs/ext4/mballoc.h                          |    2
 fs/ext4/migrate.c                          |    1
 fs/ext4/namei.c                            |   16
 fs/ext4/super.c                            |   55 +
 fs/ext4/xattr.c                            |    1
 fs/jbd2/commit.c                           |   98 ++
 fs/jbd2/journal.c                          |  343 ++++++-
 fs/jbd2/recovery.c                         |   63 +
 fs/jbd2/transaction.c                      |    3
 include/linux/jbd2.h                       |  117 ++
 include/trace/events/ext4.h                |   61 +
 include/trace/events/jbd2.h                |    9
 26 files changed, 2170 insertions(+), 106 deletions(-)
-- 
2.23.0.444.g18eeb5a265-goog

