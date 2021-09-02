Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8513FEFCB
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Sep 2021 17:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345686AbhIBPE3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 2 Sep 2021 11:04:29 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:55921 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1345673AbhIBPE1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 2 Sep 2021 11:04:27 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 182F3Jgn005560
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 2 Sep 2021 11:03:20 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6FFC315C33F9; Thu,  2 Sep 2021 11:03:19 -0400 (EDT)
Date:   Thu, 2 Sep 2021 11:03:19 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [GIT PULL] ext4 changes for 5.15
Message-ID: <YTDnt5RzyL+gOoHK@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The following changes since commit 877ba3f729fd3d8ef0e29bc2a55e57cfa54b2e43:

  ext4: fix potential htree corruption when growing large_dir directories (2021-08-06 13:00:49 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus

for you to fetch changes up to baaae979b112642a41b71c71c599d875c067d257:

  ext4: make the updating inode data procedure atomic (2021-08-30 23:36:51 -0400)

----------------------------------------------------------------
In addition to some ext4 bug fixes and cleanups, this cycle we add the
orphan_file feature, which eliminates bottlenecks when doing a large
number of parallel truncates and file deletions, and move the discard
operation out of the jbd2 commit thread when using the discard mount
option, to better support devices with slow discard operations.

----------------------------------------------------------------
Guoqing Jiang (1):
      ext4: reduce arguments of ext4_fc_add_dentry_tlv

Jan Kara (7):
      ext4: fix e2fsprogs checksum failure for mounted filesystem
      ext4: Make sure quota files are not grabbed accidentally
      ext4: Support for checksumming from journal triggers
      ext4: Move orphan inode handling into a separate file
      ext4: Speedup ext4 orphan inode handling
      ext4: Orphan file documentation
      ext4: Improve scalability of ext4 orphan file handling

Theodore Ts'o (7):
      jbd2: fix portability problems caused by unaligned accesses
      jbd2: fix clang warning in recovery.c
      jbd2: clean up two gcc -Wall warnings in recovery.c
      ext4: if zeroout fails fall back to splitting the extent node
      ext4: fix sparse warnings
      jbd2: add sparse annotations for add_transaction_credits()
      ext4: fix race writing to an inline_data file while its xattrs are changing

Wang Jianchao (5):
      ext4: remove the 'group' parameter of ext4_trim_extent
      ext4: add new helper interface ext4_try_to_trim_range()
      ext4: remove the repeated comment of ext4_trim_all_free
      ext4: get discard out of jbd2 commit kthread contex
      ext4: flush background discard kwork when retry allocation

Zhang Yi (3):
      ext4: move inode eio simulation behind io completeion
      ext4: remove an unnecessary if statement in __ext4_get_inode_loc()
      ext4: make the updating inode data procedure atomic

 Documentation/filesystems/ext4/globals.rst        |   1 +
 Documentation/filesystems/ext4/inodes.rst         |  10 +-
 Documentation/filesystems/ext4/orphan.rst         |  52 +++
 Documentation/filesystems/ext4/special_inodes.rst |  17 +
 Documentation/filesystems/ext4/super.rst          |  15 +-
 fs/ext4/Makefile                                  |   2 +-
 fs/ext4/balloc.c                                  |   8 +-
 fs/ext4/ext4.h                                    | 108 ++++-
 fs/ext4/ext4_extents.h                            |   5 +-
 fs/ext4/ext4_jbd2.c                               |  43 +-
 fs/ext4/ext4_jbd2.h                               |  18 +-
 fs/ext4/extents.c                                 |  17 +-
 fs/ext4/fast_commit.c                             |  27 +-
 fs/ext4/file.c                                    |   3 +-
 fs/ext4/ialloc.c                                  |  19 +-
 fs/ext4/indirect.c                                |  15 +-
 fs/ext4/inline.c                                  |  32 +-
 fs/ext4/inode.c                                   | 301 +++++++-------
 fs/ext4/ioctl.c                                   |   4 +-
 fs/ext4/mballoc.c                                 | 259 ++++++++----
 fs/ext4/namei.c                                   | 214 +---------
 fs/ext4/orphan.c                                  | 652 ++++++++++++++++++++++++++++++
 fs/ext4/resize.c                                  |  38 +-
 fs/ext4/super.c                                   | 238 +++--------
 fs/ext4/xattr.c                                   |  26 +-
 fs/jbd2/recovery.c                                |  29 +-
 fs/jbd2/transaction.c                             |  21 +-
 27 files changed, 1443 insertions(+), 731 deletions(-)
 create mode 100644 Documentation/filesystems/ext4/orphan.rst
 create mode 100644 fs/ext4/orphan.c
