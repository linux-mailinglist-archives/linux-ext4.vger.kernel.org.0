Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 782FB129ED1
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Dec 2019 09:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbfLXIOw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 24 Dec 2019 03:14:52 -0500
Received: from mail-pl1-f182.google.com ([209.85.214.182]:36008 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbfLXIOw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 24 Dec 2019 03:14:52 -0500
Received: by mail-pl1-f182.google.com with SMTP id a6so7464091plm.3
        for <linux-ext4@vger.kernel.org>; Tue, 24 Dec 2019 00:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DPCbq/qvO4eQwzr7fqFKslP3zLFJWQd+L6VgVsWEa2U=;
        b=vZdwXnGyjSkt4RPiMD3TbK4LTPc3TX/FbbLqKW0t4/udy+LBtqAbu3TFFqZsSKsHYp
         oHL3zMNgtGPgeMFMPoRH6iWLxQjsaHFLJYIr7vzFdRpzgoadNU1riPGnzWxH2ZdenFe5
         oe4Zv9XKdT3+oUmEHVI5AVPib/kbQCnmaSpMS1NZwjLfoyrRPoVQbLfcm36ZXTItZgea
         j9Qz7yf5XAlp+2e0c3sGD6803z740TQBKsZEMkwOFhkGTfPzrXX4donsCkXPEH7QdisS
         Xpj60bdYgciRF5uR9nt9NTD3X92oUSvsfph5J3mVuNzV6FvhjXQSX1RXo7/Z1HocePdj
         BOKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DPCbq/qvO4eQwzr7fqFKslP3zLFJWQd+L6VgVsWEa2U=;
        b=eEqjfh7scjEmN9UQBUlfTvMnkGfzEmqTbhIkOx0i3DuYLCwR4Mu1PJCR00/Wy2BUXy
         zWRAnbtfpN7ZGNucuFWe5JajCpEQx+I/rVyK7VvCT1VqPz1DTvQA+ysSi/P7mJt0U+GQ
         MgEF4n/R1jD/n356UfAK4bxyPSyenI3VBwCGSxp0OHaLrFbo+7zYvzCIjSU9RCISJMdR
         YeCZpXANs1QJpQyKj77Jf4SZaG2tkANN/y+YdVl87fs1Jp4dZo9asWnqeMNBq9zFASsf
         RylPfFLQLEg/8xicz6ua9Rgxoew7WoVElvqdKpfuqZjhK2RG9tOntDVOZSpIAz8ip1gF
         6HVA==
X-Gm-Message-State: APjAAAX3bL639RKlzL0Ru6NBsIEznkT97RVoEDTrf619SQQjVQ6dXahm
        Hs+6GkCxXWmuAYxiykHfin8eeDjR
X-Google-Smtp-Source: APXvYqwvaobzaXeyi13wQWwH6n/lQEYu6Hd8FiMRguGbT2OcXh7SWTw/+WuCROxqBTw5qd3fUuIlIg==
X-Received: by 2002:a17:902:6b06:: with SMTP id o6mr14083603plk.138.1577175290973;
        Tue, 24 Dec 2019 00:14:50 -0800 (PST)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id f8sm27370781pfn.2.2019.12.24.00.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 00:14:50 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v4 01/20] ext4: update docs for fast commit feature
Date:   Tue, 24 Dec 2019 00:13:05 -0800
Message-Id: <20191224081324.95807-1-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
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
    fast commits.

Ext4 supports two modes of fast commits: 1) fast commits with hard
consistency guarantees 2) fast commits with soft consistency guarantees

When hard consistency is enabled, fast commit guarantees that all the
updates will be committed. After a successful replay of fast commits
blocks in hard consistency mode, the entire file system would be in
the same state as that when fsync() returned before crash. This
guarantee is similar to what jbd2 gives with full commits.

With soft consistency, file system only guarantees consistency for the
inode in question. In this mode, file system will try to write as less
data to the backend as possible during the commit time. To be precise,
file system records all the data updates for the inode in question and
directory updates that are required for guaranteeing consistency of the
inode in question.

In our evaluations, fast commits with hard consistency performed
better than fast commits with soft consistency. That's because with
hard consistency, a fast commit often ends up committing other inodes
together, while with soft consistency commits get serialized. Future
work can look at creating hybrid approach between the two extremes
that are there in this patchset.

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

Ext4 file system performance was tested with full commits, with fast
commits with soft consistency and with fast commits with hard
consistency. fs_mark benchmark showed that depending on the file size,
performance improvement was seen up to 50%. Soft fast commits performed
slightly worse than hard fast commits. But soft fast commits ended up
writing slightly lesser number of blocks on disk.

Changes since V3:

- Removed invocation of fast commits from the jbd2 thread.

- Removed sub transaction ID from journal_t.

- Added rename, truncate, punch hole support.

- Added soft consistency mode and hard consistency mode.

- More bug fixes and refactoring.

- Added better debugging support: more tracepoints and debug mount
  options.

Harshad Shirwadkar(20):
 ext4: add debug mount option to test fast commit replay
 ext4: add fast commit replay path
 ext4: disable certain features in replay path
 ext4: add idempotent helpers to manipulate bitmaps
 ext4: fast commit recovery path preparation
 jbd2: add fast commit recovery path support
 ext4: main commit routine for fast commits
 jbd2: add new APIs for commit path of fast commits
 ext4: add fast commit on-disk format structs and helpers
 ext4: add fast commit track points
 ext4: break ext4_unlink() and ext4_link()
 ext4: add inode tracking and ineligible marking routines
 ext4: add directory entry tracking routines
 ext4: add generic diff tracking routines and range tracking
 jbd2: fast commit main commit path changes
 jbd2: disable fast commits if journal is empty
 jbd2: add fast commit block tracker variables
 ext4, jbd2: add fast commit initialization routines
 ext4: add handling for extended mount options
 ext4: update docs for fast commit feature

 Documentation/filesystems/ext4/journal.rst |  127 ++-
 Documentation/filesystems/journalling.rst  |   18 +
 fs/ext4/acl.c                              |    1 +
 fs/ext4/balloc.c                           |   10 +-
 fs/ext4/ext4.h                             |  127 +++
 fs/ext4/ext4_jbd2.c                        | 1484 +++++++++++++++++++++++++++-
 fs/ext4/ext4_jbd2.h                        |   71 ++
 fs/ext4/extents.c                          |    5 +
 fs/ext4/extents_status.c                   |   24 +
 fs/ext4/fsync.c                            |    2 +-
 fs/ext4/ialloc.c                           |  165 +++-
 fs/ext4/inline.c                           |    3 +
 fs/ext4/inode.c                            |   77 +-
 fs/ext4/ioctl.c                            |    9 +-
 fs/ext4/mballoc.c                          |  157 ++-
 fs/ext4/mballoc.h                          |    2 +
 fs/ext4/migrate.c                          |    1 +
 fs/ext4/namei.c                            |  172 ++--
 fs/ext4/super.c                            |   72 +-
 fs/ext4/xattr.c                            |    6 +
 fs/jbd2/commit.c                           |   61 ++
 fs/jbd2/journal.c                          |  217 +++-
 fs/jbd2/recovery.c                         |   67 +-
 include/linux/jbd2.h                       |   83 +-
 include/trace/events/ext4.h                |  208 +++-
 25 files changed, 3037 insertions(+), 132 deletions(-)
---
 Documentation/filesystems/ext4/journal.rst | 127 ++++++++++++++++++++-
 Documentation/filesystems/journalling.rst  |  18 +++
 2 files changed, 139 insertions(+), 6 deletions(-)

diff --git a/Documentation/filesystems/ext4/journal.rst b/Documentation/filesystems/ext4/journal.rst
index ea613ee701f5..f94e66f2f8c4 100644
--- a/Documentation/filesystems/ext4/journal.rst
+++ b/Documentation/filesystems/ext4/journal.rst
@@ -29,10 +29,10 @@ safest. If ``data=writeback``, dirty data blocks are not flushed to the
 disk before the metadata are written to disk through the journal.
 
 The journal inode is typically inode 8. The first 68 bytes of the
-journal inode are replicated in the ext4 superblock. The journal itself
-is normal (but hidden) file within the filesystem. The file usually
-consumes an entire block group, though mke2fs tries to put it in the
-middle of the disk.
+journal inode are replicated in the ext4 superblock. The journal
+itself is normal (but hidden) file within the filesystem. The file
+usually consumes an entire block group, though mke2fs tries to put it
+in the middle of the disk.
 
 All fields in jbd2 are written to disk in big-endian order. This is the
 opposite of ext4.
@@ -42,22 +42,74 @@ NOTE: Both ext4 and ocfs2 use jbd2.
 The maximum size of a journal embedded in an ext4 filesystem is 2^32
 blocks. jbd2 itself does not seem to care.
 
+Fast Commits
+~~~~~~~~~~~~
+
+Ext4 also implements fast commits and integrates it with JBD2 journalling.
+Fast commits store metadata changes made to the file system as inode level
+diff. In other words, each fast commit block identifies updates made to
+a particular inode and collectively they represent total changes made to
+the file system.
+
+A fast commit is valid only if there is no full commit after that particular
+fast commit. Because of this feature, fast commit blocks can be reused by
+the following transactions.
+
+Each fast commit block stores updates to 1 particular inode. Updates in each
+fast commit block are one of the 2 types:
+- Data updates (add range / delete range)
+- Directory entry updates (Add / remove links)
+
+Fast commit blocks must be replayed in the order in which they appear on disk.
+That's because directory entry updates are written in fast commit blocks
+in the order in which they are applied on the file system before crash.
+Changing the order of replaying for directory entry updates may result
+in inconsistent file system. Note that only directory entry updates need
+ordering, data updates, since they apply to only one inode, do not require
+ordered replay. Also, fast commits guarantee that file system is in consistent
+state after replay of each fast commit block as long as order of replay has
+been followed.
+
+Note that directory inode updates are never directly recorded in fast commits.
+Just like other file system level metaata, updates to directories are always
+implied based on directory entry updates stored in fast commit blocks.
+
+Based on which directory entry updates are committed with an inode, fast
+commits have two modes of operation:
+
+- Hard Consistency (default)
+- Soft Consistency (can be enabled by setting mount flag "fc_soft_consistency")
+
+When hard consistency is enabled, fast commit guarantees that all the updates
+will be committed. After a successful replay of fast commits blocks
+in hard consistency mode, the entire file system would be in the same state as
+that when fsync() returned before crash. This guarantee is similar to what
+jbd2 gives.
+
+With soft consistency, file system only guarantees consistency for the
+inode in question. In this mode, file system will try to write as less data
+to the backed as possible during the commit time. To be precise, file system
+records all the data updates for the inode in question and directory updates
+that are required for guaranteeing consistency of the inode in question.
+
 Layout
 ~~~~~~
 
 Generally speaking, the journal has this format:
 
 .. list-table::
-   :widths: 16 48 16
+   :widths: 16 48 16 18
    :header-rows: 1
 
    * - Superblock
      - descriptor\_block (data\_blocks or revocation\_block) [more data or
        revocations] commmit\_block
      - [more transactions...]
+     - [Fast commits...]
    * - 
      - One transaction
      -
+     -
 
 Notice that a transaction begins with either a descriptor and some data,
 or a block revocation list. A finished transaction always ends with a
@@ -76,7 +128,7 @@ The journal superblock will be in the next full block after the
 superblock.
 
 .. list-table::
-   :widths: 12 12 12 32 12
+   :widths: 12 12 12 32 12 12
    :header-rows: 1
 
    * - 1024 bytes of padding
@@ -85,11 +137,13 @@ superblock.
      - descriptor\_block (data\_blocks or revocation\_block) [more data or
        revocations] commmit\_block
      - [more transactions...]
+     - [Fast commits...]
    * - 
      -
      -
      - One transaction
      -
+     -
 
 Block Header
 ~~~~~~~~~~~~
@@ -609,3 +663,64 @@ bytes long (but uses a full block):
      - h\_commit\_nsec
      - Nanoseconds component of the above timestamp.
 
+Fast Commit Block
+~~~~~~~~~~~~~~~~~
+
+The fast commit block indicates an append to the last commit block
+that was written to the journal. One fast commit block records updates
+to one inode. So, typically you would find as many fast commit blocks
+as the number of inodes that got changed since the last commit. A fast
+commit block is valid only if there is no commit block present with
+transaction ID greater than that of the fast commit block. If such a
+block a present, then there is no need to replay the fast commit
+block.
+
+.. list-table::
+   :widths: 8 8 24 40
+   :header-rows: 1
+
+   * - Offset
+     - Type
+     - Name
+     - Descriptor
+   * - 0x0
+     - journal\_header\_s
+     - (open coded)
+     - Common block header.
+   * - 0xC
+     - \_\_le32
+     - fc\_magic
+     - Magic value which should be set to 0xE2540090. This identifies
+       that this block is a fast commit block.
+   * - 0x10
+     - \_\_u8
+     - fc\_features
+     - Features used by this fast commit block.
+   * - 0x11
+     - \_\_le16
+     - fc_num_tlvs
+     - Number of TLVs contained in this fast commit block
+   * - 0x13
+     - \_\_le32
+     - \_\_fc\_len
+     - Length of the fast commit block in terms of number of blocks
+   * - 0x17
+     - \_\_le32
+     - fc\_ino
+     - Inode number of the inode that will be recovered using this fast commit
+   * - 0x2B
+     - struct ext4\_inode
+     - inode
+     - On-disk copy of the inode at the commit time
+   * - <Variable based on inode size>
+     - struct ext4\_fc\_tl
+     - Array of struct ext4\_fc\_tl
+     - The actual delta with the last commit. Starting at this offset,
+       there is an array of TLVs that indicates which all extents
+       should be present in the corresponding inode. Currently,
+       following tags are supported: EXT4\_FC\_TAG\_EXT (extent that
+       should be present in the inode), EXT4\_FC\_TAG\_HOLE (extent
+       that should be removed from the inode), EXT4\_FC\_TAG\_ADD\_DENTRY
+       (dentry that should be linked), EXT4\_FC\_TAG\_DEL\_DENTRY
+       (dentry that should be unlinked), EXT4\_FC\_TAG\_CREATE\_DENTRY
+       (dentry that for the file that should be created for the first time).
diff --git a/Documentation/filesystems/journalling.rst b/Documentation/filesystems/journalling.rst
index 58ce6b395206..1cb116ab27ab 100644
--- a/Documentation/filesystems/journalling.rst
+++ b/Documentation/filesystems/journalling.rst
@@ -115,6 +115,24 @@ called after each transaction commit. You can also use
 ``transaction->t_private_list`` for attaching entries to a transaction
 that need processing when the transaction commits.
 
+JBD2 also allows client file systems to implement file system specific
+commits which are called as ``fast commits``. Fast commits are
+asynchronous in nature i.e. file systems can call their own commit
+functions at any time. In order to avoid the race with kjournald
+thread and other possible fast commits that may be happening in
+parallel, file systems should first call
+:c:func:`jbd2_start_async_fc()`. File system can call
+:c:func:`jbd2_map_fc_buf()` to get buffers reserved for fast
+commits. Once a fast commit is completed, file system should call
+:c:func:`jbd2_stop_async_fc()` to indicate and unblock other
+committers and the kjournald thread.  After performing either a fast
+or a full commit, JBD2 calls ``journal->j_fc_cleanup_cb`` to allow
+file systems to perform cleanups for their internal fast commit
+related data structures. At the replay time, JBD2 passes each and
+every fast commit block to the file system via
+``journal->j_fc_replay_cb``. Ext4 effectively uses this fast commit
+mechanism to improve journal commit performance.
+
 JBD2 also provides a way to block all transaction updates via
 :c:func:`jbd2_journal_lock_updates()` /
 :c:func:`jbd2_journal_unlock_updates()`. Ext4 uses this when it wants a
-- 
2.24.1.735.g03f4e72817-goog

