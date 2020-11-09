Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F252AC28C
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Nov 2020 18:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732327AbgKIRiO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 Nov 2020 12:38:14 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:33430 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731430AbgKIRiO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 9 Nov 2020 12:38:14 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0A9Hc9d9019854
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 Nov 2020 12:38:10 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 73309420107; Mon,  9 Nov 2020 12:38:09 -0500 (EST)
Date:   Mon, 9 Nov 2020 12:38:09 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [GIT PULL] ext4 cleanups for 5.10-rc4
Message-ID: <20201109173809.GA2916982@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

(Resent with missing cc's, sorry.)

The following changes since commit 3cea11cd5e3b00d91caf0b4730194039b45c5891:

  Linux 5.10-rc2 (2020-11-01 14:43:51 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_cleanups

for you to fetch changes up to 05d5233df85e9621597c5838e95235107eb624a2:

  jbd2: fix up sparse warnings in checkpoint code (2020-11-07 00:09:08 -0500)

----------------------------------------------------------------
More fixes and cleanups for the new fast_commit features, but also a
few other miscellaneous bug fixes and a cleanup for the MAINTAINERS
file.

----------------------------------------------------------------
Chao Yu (1):
      MAINTAINERS: add missing file in ext4 entry

Dan Carpenter (1):
      ext4: silence an uninitialized variable warning

Harshad Shirwadkar (22):
      ext4: describe fast_commit feature flags
      ext4: mark fc ineligible if inode gets evictied due to mem pressure
      ext4: drop redundant calls ext4_fc_track_range
      ext4: fixup ext4_fc_track_* functions' signature
      jbd2: rename j_maxlen to j_total_len and add jbd2_journal_max_txn_bufs
      ext4: clean up the JBD2 API that initializes fast commits
      jbd2: drop jbd2_fc_init documentation
      jbd2: don't use state lock during commit path
      jbd2: don't pass tid to jbd2_fc_end_commit_fallback()
      jbd2: add todo for a fast commit performance optimization
      jbd2: don't touch buffer state until it is filled
      jbd2: don't read journal->j_commit_sequence without taking a lock
      ext4: dedpulicate the code to wait on inode that's being committed
      ext4: fix code documentatioon
      ext4: mark buf dirty before submitting fast commit buffer
      ext4: remove unnecessary fast commit calls from ext4_file_mmap
      ext4: fix inode dirty check in case of fast commits
      ext4: disable fast commit with data journalling
      ext4: issue fsdev cache flush before starting fast commit
      ext4: make s_mount_flags modifications atomic
      jbd2: don't start fast commit on aborted journal
      ext4: cleanup fast commit mount options

Joseph Qi (1):
      ext4: unlock xattr_sem properly in ext4_inline_data_truncate()

Kaixu Xia (1):
      ext4: correctly report "not supported" for {usr,grp}jquota when !CONFIG_QUOTA

Theodore Ts'o (2):
      ext4: fix sparse warnings in fast_commit code
      jbd2: fix up sparse warnings in checkpoint code

 Documentation/filesystems/ext4/journal.rst |   6 ++
 Documentation/filesystems/ext4/super.rst   |   7 +++
 Documentation/filesystems/journalling.rst  |   6 +-
 MAINTAINERS                                |   1 +
 fs/ext4/ext4.h                             |  66 ++++++++++++++------
 fs/ext4/extents.c                          |   7 +--
 fs/ext4/fast_commit.c                      | 174 +++++++++++++++++++++++++++--------------------------
 fs/ext4/fast_commit.h                      |   6 +-
 fs/ext4/file.c                             |   6 +-
 fs/ext4/fsmap.c                            |   2 +-
 fs/ext4/fsync.c                            |   2 +-
 fs/ext4/inline.c                           |   1 +
 fs/ext4/inode.c                            |  19 +++---
 fs/ext4/mballoc.c                          |   6 +-
 fs/ext4/namei.c                            |  61 +++++++++----------
 fs/ext4/super.c                            |  47 ++++++++-------
 fs/jbd2/checkpoint.c                       |   2 +
 fs/jbd2/commit.c                           |  11 +++-
 fs/jbd2/journal.c                          | 138 +++++++++++++++++++++++-------------------
 fs/jbd2/recovery.c                         |   6 +-
 fs/jbd2/transaction.c                      |   4 +-
 fs/ocfs2/journal.c                         |   2 +-
 include/linux/jbd2.h                       |  23 ++++---
 include/trace/events/ext4.h                |  10 +--
 24 files changed, 342 insertions(+), 271 deletions(-)
