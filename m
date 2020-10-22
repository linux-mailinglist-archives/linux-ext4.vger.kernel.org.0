Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD4B6296327
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Oct 2020 18:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2902152AbgJVQy4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 22 Oct 2020 12:54:56 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:48702 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2902149AbgJVQy4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 22 Oct 2020 12:54:56 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 09MGsou6025003
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Oct 2020 12:54:51 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 84F72420107; Thu, 22 Oct 2020 12:54:50 -0400 (EDT)
Date:   Thu, 22 Oct 2020 12:54:50 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [GIT PULL] ext4 changes for 5.10
Message-ID: <20201022165450.GA1172314@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The following changes since commit a1b8638ba1320e6684aa98233c15255eb803fac7:

  Linux 5.9-rc7 (2020-09-27 14:38:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus

for you to fetch changes up to 1322181170bb01bce3c228b82ae3d5c6b793164f:

  ext4: fix invalid inode checksum (2020-10-21 23:22:38 -0400)

----------------------------------------------------------------
The siginificant new ext4 feature this time around is Harshad's new
fast_commit mode.  In addition, thanks to Mauricio for fixing a race
where mmap'ed pages that are being changed in parallel with a
data=journal transaction commit could result in bad checksums in the
failure that could cause journal replays to fail.  Also notable is
Ritesh's buffered write optimization which can result in significant
improvements on parallel write workloads.  (The kernel test robot
reported a 330.6% improvement on fio.write_iops on a 96 core system
using DAX[1].)

Besides that, we have the usual miscellaneous cleanups and bug fixes.

[1] https://lore.kernel.org/r/20200925071217.GO28663@shao2-debian

----------------------------------------------------------------
Chunguang Xu (4):
      ext4: rename journal_dev to s_journal_dev inside ext4_sb_info
      ext4: rename system_blks to s_system_blks inside ext4_sb_info
      ext4: delete invalid comments near mb_buddy_adjust_border
      ext4: make mb_check_counter per group

Constantine Sapuntzakis (1):
      ext4: fix superblock checksum calculation race

Darrick J. Wong (1):
      ext4: limit entries returned when counting fsmap records

Dinghao Liu (1):
      ext4: fix error handling code in add_new_gdb

Eric Biggers (1):
      ext4: fix leaking sysfs kobject after failed mount

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

Hui Su (1):
      jbd2: fix the comment of struct jbd2_journal_handle

Jan Kara (2):
      ext4: discard preallocations before releasing group lock
      ext4: Detect already used quota file early

Jens Axboe (1):
      ext4: flag as supporting buffered async reads

Kaixu Xia (1):
      ext4: use the normal helper to get the actual inode

Luo Meng (1):
      ext4: fix invalid inode checksum

Mauricio Faria de Oliveira (4):
      jbd2: introduce/export functions jbd2_journal_submit|finish_inode_data_buffers()
      jbd2, ext4, ocfs2: introduce/use journal callbacks j_submit|finish_inode_data_buffers()
      ext4: data=journal: fixes for ext4_page_mkwrite()
      ext4: data=journal: write-protect pages on j_submit_inode_data_buffers()

Nikolay Borisov (1):
      ext4: remove unused argument from ext4_(inc|dec)_count

Petr Malat (1):
      ext4: do not interpret high bytes if 64bit feature is disabled

Randy Dunlap (1):
      ext4: delete duplicated words + other fixes

Ritesh Harjani (3):
      ext4: implement swap_activate aops using iomap
      ext4: optimize file overwrites
      ext4: fix bs < ps issue reported with dioread_nolock mount opt

Tian Tao (1):
      ext4: remove unused including <linux/version.h>

Xiao Yang (1):
      ext4: disallow modifying DAX inode flag if inline_data has been set

Ye Bin (1):
      ext4: fix dead loop in ext4_mb_new_blocks

Zhang Qilong (1):
      ext4: add trace exit in exception path.

Zhang Xiaoxu (1):
      ext4: fix bdev write error check failed when mount fs with ro

changfengnan (1):
      jbd2: avoid transaction reuse after reformatting

zhangyi (F) (7):
      ext4: clear buffer verified flag if read meta block from disk
      ext4: introduce new metadata buffer read helpers
      ext4: use common helpers in all places reading metadata buffers
      ext4: use ext4_buffer_uptodate() in __ext4_get_inode_loc()
      ext4: introduce ext4_sb_breadahead_unmovable() to replace sb_breadahead_unmovable()
      ext4: use ext4_sb_bread() instead of sb_bread()
      ext4: introduce ext4_sb_bread_unmovable() to replace sb_bread_unmovable()

 Documentation/filesystems/ext4/journal.rst |   66 ++
 Documentation/filesystems/journalling.rst  |   33 +
 fs/ext4/Makefile                           |    2 +-
 fs/ext4/acl.c                              |    2 +
 fs/ext4/balloc.c                           |   14 +-
 fs/ext4/block_validity.c                   |   10 +-
 fs/ext4/dir.c                              |    4 +-
 fs/ext4/ext4.h                             |  136 +++-
 fs/ext4/ext4_jbd2.c                        |    2 +-
 fs/ext4/extents.c                          |  315 +++++++-
 fs/ext4/extents_status.c                   |   24 +
 fs/ext4/fast_commit.c                      | 2139 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/ext4/fast_commit.h                      |  159 ++++
 fs/ext4/file.c                             |   12 +-
 fs/ext4/fsmap.c                            |   11 +-
 fs/ext4/fsync.c                            |    4 +-
 fs/ext4/ialloc.c                           |  173 ++++-
 fs/ext4/indirect.c                         |   13 +-
 fs/ext4/inline.c                           |    2 +-
 fs/ext4/inode.c                            |  290 +++++--
 fs/ext4/ioctl.c                            |   22 +-
 fs/ext4/mballoc.c                          |  257 ++++++-
 fs/ext4/mmp.c                              |   10 +-
 fs/ext4/move_extent.c                      |    2 +-
 fs/ext4/namei.c                            |  206 +++--
 fs/ext4/resize.c                           |   14 +-
 fs/ext4/super.c                            |  352 +++++++--
 fs/ext4/sysfs.c                            |    2 +
 fs/ext4/xattr.c                            |    3 +
 fs/jbd2/commit.c                           |  106 ++-
 fs/jbd2/journal.c                          |  245 +++++-
 fs/jbd2/recovery.c                         |  135 +++-
 fs/ocfs2/journal.c                         |    4 +
 include/linux/jbd2.h                       |  124 ++-
 include/trace/events/ext4.h                |  228 +++++-
 35 files changed, 4725 insertions(+), 396 deletions(-)
 create mode 100644 fs/ext4/fast_commit.c
 create mode 100644 fs/ext4/fast_commit.h
