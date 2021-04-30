Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBFE36FECA
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Apr 2021 18:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbhD3Qm0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 30 Apr 2021 12:42:26 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:42292 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229720AbhD3QmZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 30 Apr 2021 12:42:25 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 13UGfYV9024275
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Apr 2021 12:41:34 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 07B2C15C39C4; Fri, 30 Apr 2021 12:41:34 -0400 (EDT)
Date:   Fri, 30 Apr 2021 12:41:33 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ext4 updates for 5.13
Message-ID: <YIwzPefeKM+Vuxn5@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The following changes since commit 0d02ec6b3136c73c09e7859f0d0e4e2c4c07b49b:

  Linux 5.12-rc4 (2021-03-21 14:56:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus

for you to fetch changes up to 6c0912739699d8e4b6a87086401bf3ad3c59502d:

  ext4: wipe ext4_dir_entry2 upon file deletion (2021-04-22 16:51:23 -0400)

----------------------------------------------------------------
New features for ext4 this cycle include support for encrypted
casefold, ensure that deleted file names are cleared in directory
blocks by zeroing directory entries when they are unlinked or moved as
part of a hash tree node split.  We also improve the block allocator's
performance on a freshly mounted file system by prefetching block
bitmaps.

There are also the usual cleanups and bug fixes, including fixing a
page cache invalidation race when there is mixed buffered and direct
I/O and the block size is less than page size, and allow the dax flag
to be set and cleared on inline directories.

----------------------------------------------------------------
Alexander Lochmann (2):
      ext4: updated locking documentation for journal_t
      Updated locking documentation for transaction_t

Arnd Bergmann (2):
      jbd2: avoid -Wempty-body warnings
      ext4: fix debug format string warning

Bhaskar Chowdhury (1):
      ext4: fix various seppling typos

Chaitanya Kulkarni (2):
      ext4: use memcpy_from_page() in pagecache_read()
      ext4: use memcpy_to_page() in pagecache_write()

Daniel Rosenberg (2):
      ext4: handle casefolding with encryption
      ext4: optimize match for casefolded encrypted dirs

Eric Whitney (1):
      ext4: delete some unused tracepoint definitions

Fengnan Chang (1):
      ext4: fix error code in ext4_commit_super

Harshad Shirwadkar (7):
      ext4: drop s_mb_bal_lock and convert protected fields to atomic
      ext4: add ability to return parsed options from parse_options
      ext4: add mballoc stats proc file
      ext4: add MB_NUM_ORDERS macro
      ext4: improve cr 0 / cr 1 group scanning
      ext4: add proc files to monitor new structures
      ext4: make prefetch_block_bitmaps default

Jack Qiu (1):
      ext4: fix trailing whitespace

Jan Kara (3):
      ext4: annotate data race in start_this_handle()
      ext4: annotate data race in jbd2_journal_dirty_metadata()
      ext4: Fix occasional generic/418 failure

Leah Rumancik (1):
      ext4: wipe ext4_dir_entry2 upon file deletion

Milan Djurovic (1):
      ext4: remove unnecessary braces in fs/ext4/dir.c

Theodore Ts'o (2):
      ext4: allow the dax flag to be set and cleared on inline directories
      fs: fix reporting supported extra file attributes for statx()

Xu Yihang (1):
      ext4: fix error return code in ext4_fc_perform_commit()

Yang Guo (1):
      ext4: delete redundant uptodate check for buffer

Ye Bin (2):
      ext4: always panic when errors=panic is specified
      ext4: fix ext4_error_err save negative errno into superblock

Zhang Yi (2):
      ext4: fix check to prevent false positive report of incorrect used inodes
      ext4: do not set SB_ACTIVE in ext4_orphan_cleanup()

 Documentation/filesystems/ext4/directory.rst |  27 ++
 fs/ext4/balloc.c                             |   2 +-
 fs/ext4/dir.c                                |  41 ++-
 fs/ext4/ext4.h                               | 107 +++++--
 fs/ext4/fast_commit.c                        |   8 +-
 fs/ext4/file.c                               |  25 +-
 fs/ext4/hash.c                               |  25 +-
 fs/ext4/ialloc.c                             |  51 ++-
 fs/ext4/indirect.c                           |   2 +-
 fs/ext4/inline.c                             |  27 +-
 fs/ext4/inode.c                              |   8 +-
 fs/ext4/ioctl.c                              |   6 +
 fs/ext4/mballoc.c                            | 592 +++++++++++++++++++++++++++++++++--
 fs/ext4/mballoc.h                            |  24 +-
 fs/ext4/migrate.c                            |   6 +-
 fs/ext4/mmp.c                                |   2 +-
 fs/ext4/namei.c                              | 245 +++++++++++----
 fs/ext4/super.c                              | 116 ++++---
 fs/ext4/sysfs.c                              |   8 +
 fs/ext4/verity.c                             |  10 +-
 fs/ext4/xattr.c                              |   2 +-
 fs/jbd2/recovery.c                           |   5 +-
 fs/jbd2/transaction.c                        |  15 +-
 fs/stat.c                                    |   8 +
 include/linux/jbd2.h                         |  33 +-
 include/trace/events/ext4.h                  | 176 -----------
 26 files changed, 1144 insertions(+), 427 deletions(-)
