Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 987382E1061
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Dec 2020 23:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgLVWuA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 22 Dec 2020 17:50:00 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59072 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726329AbgLVWt7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 22 Dec 2020 17:49:59 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0BMMnA9N006812
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Dec 2020 17:49:10 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 15152420280; Tue, 22 Dec 2020 17:49:10 -0500 (EST)
Date:   Tue, 22 Dec 2020 17:49:10 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ext4 updates for v5.11-rc1
Message-ID: <X+J35oGDo2HnOuOP@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The following changes since commit 418baf2c28f3473039f2f7377760bd8f6897ae18:

  Linux 5.10-rc5 (2020-11-22 15:36:08 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus

for you to fetch changes up to be993933d2e997fdb72b8b1418d2a84df79b8962:

  ext4: remove unnecessary wbc parameter from ext4_bio_write_page (2020-12-22 13:08:45 -0500)

NOTE: The reason why the branch had recently changed was to add a
one-line fix which added flush_work() call to an error/cleanup patgh,
to address a syzbot reported failure.  See the thread at:

http://lore.kernel.org/r/0000000000001faff305b709b8ad@google.com

There were also some commit description updates to add some Cc:
stable@kernel.org tags.

This branch was tested and passes xfstests regression tests, and in
any case, it's all bug fixes and cleanups:

TESTRUNID: tytso-20201222152130
KERNEL:    5.10.0-rc5-xfstests-00029-gbe993933d2e9 #2064 SMP Tue Dec 22 15:19:12 EST 2020 x86_64
CMDLINE:   -c ext4/4k -g auto
CPUS:      2
MEM:       7680

ext4/4k: 520 tests, 43 skipped, 6608 seconds
Totals: 477 tests, 43 skipped, 0 failures, 0 errors, 6554s

----------------------------------------------------------------
Various bug fixes and cleanups for ext4; no new features this cycle.

----------------------------------------------------------------

Alexander Lochmann (1):
      Updated locking documentation for transaction_t

Chunguang Xu (7):
      ext4: use ASSERT() to replace J_ASSERT()
      ext4: remove redundant mb_regenerate_buddy()
      ext4: simplify the code of mb_find_order_for_block
      ext4: update ext4_data_block_valid related comments
      ext4: delete nonsensical (commented-out) code inside ext4_xattr_block_set()
      ext4: fix a memory leak of ext4_free_data
      ext4: avoid s_mb_prefetch to be zero in individual scenarios

Colin Ian King (1):
      ext4: remove redundant assignment of variable ex

Dan Carpenter (1):
      ext4: fix an IS_ERR() vs NULL check

Gustavo A. R. Silva (1):
      ext4: fix fall-through warnings for Clang

Harshad Shirwadkar (3):
      ext4: add docs about fast commit idempotence
      ext4: make fast_commit.h byte identical with e2fsprogs/fast_commit.h
      jbd2: add a helper to find out number of fast commit blocks

Jan Kara (8):
      ext4: fix deadlock with fs freezing and EA inodes
      ext4: don't remount read-only with errors=continue on reboot
      ext4: remove redundant sb checksum recomputation
      ext4: standardize error message in ext4_protect_reserved_inode()
      ext4: make ext4_abort() use __ext4_error()
      ext4: move functions in super.c
      ext4: simplify ext4 error translation
      ext4: defer saving error info from atomic context

Kaixu Xia (2):
      ext4: remove redundant operation that set bh to NULL
      ext4: remove the unused EXT4_CURRENT_REV macro

Lei Chen (1):
      ext4: remove unnecessary wbc parameter from ext4_bio_write_page

Roman Anufriev (2):
      ext4: add helpers for checking whether quota can be enabled/is journalled
      ext4: print quota journalling mode on (re-)mount

Theodore Ts'o (1):
      ext4: check for invalid block size early when mounting a file system

Xianting Tian (1):
      ext4: remove the null check of bio_vec page

 Documentation/filesystems/ext4/journal.rst |  50 ++++++
 fs/ext4/balloc.c                           |   2 +-
 fs/ext4/block_validity.c                   |  16 +-
 fs/ext4/ext4.h                             |  77 ++++++---
 fs/ext4/ext4_jbd2.c                        |   4 +-
 fs/ext4/ext4_jbd2.h                        |   9 +-
 fs/ext4/extents.c                          |   5 +-
 fs/ext4/fast_commit.c                      |  99 +++++++-----
 fs/ext4/fast_commit.h                      |  78 +++++++--
 fs/ext4/fsync.c                            |   2 +-
 fs/ext4/indirect.c                         |   4 +-
 fs/ext4/inode.c                            |  35 ++--
 fs/ext4/mballoc.c                          |  39 ++---
 fs/ext4/namei.c                            |  12 +-
 fs/ext4/page-io.c                          |   5 +-
 fs/ext4/super.c                            | 422 ++++++++++++++++++++++++-------------------------
 fs/ext4/xattr.c                            |   1 -
 fs/jbd2/journal.c                          |   8 +-
 include/linux/jbd2.h                       |  14 +-
 19 files changed, 504 insertions(+), 378 deletions(-)
