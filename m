Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC7C71F8A72
	for <lists+linux-ext4@lfdr.de>; Sun, 14 Jun 2020 22:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgFNUAk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 14 Jun 2020 16:00:40 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:34687 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726648AbgFNUAk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 14 Jun 2020 16:00:40 -0400
Received: from callcc.thunk.org (pool-100-0-195-244.bstnma.fios.verizon.net [100.0.195.244])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 05EK0Y1h027920
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 14 Jun 2020 16:00:35 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 2C2F342026D; Sun, 14 Jun 2020 16:00:34 -0400 (EDT)
Date:   Sun, 14 Jun 2020 16:00:34 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     torvalds@linux-foundation.org
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ext4 changes part 2 for 5.8
Message-ID: <20200614200034.GA3294624@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The following changes since commit 6b8ed62008a49751fc71fefd2a4f89202a7c2d4d:

  ext4: avoid unnecessary transaction starts during writeback (2020-06-03 23:16:56 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4-for-linus-5.8-rc1-2

for you to fetch changes up to 7b97d868b7ab2448859668de9222b8af43f76e78:

  ext4, jbd2: ensure panic by fix a race between jbd2 abort and ext4 error handlers (2020-06-12 14:51:41 -0400)

----------------------------------------------------------------
This is the second round of ext4 commits for 5.8 merge window.  It
includes the per-inode DAX support, which was dependant on the DAX
infrastructure which came in via the XFS tree, and a number of
regression and bug fixes; most notably the "BUG: using
smp_processor_id() in preemptible code in ext4_mb_new_blocks" reported
by syzkaller.

----------------------------------------------------------------
Eric Biggers (1):
      ext4: avoid utf8_strncasecmp() with unstable name

Ira Weiny (14):
      fs: Remove unneeded IS_DAX() check in io_is_direct()
      fs/stat: Define DAX statx attribute
      Documentation/dax: Update Usage section
      fs: Lift XFS_IDONTCACHE to the VFS layer
      fs: Introduce DCACHE_DONTCACHE
      fs/ext4: Narrow scope of DAX check in setflags
      fs/ext4: Disallow verity if inode is DAX
      fs/ext4: Change EXT4_MOUNT_DAX to EXT4_MOUNT_DAX_ALWAYS
      fs/ext4: Update ext4_should_use_dax()
      fs/ext4: Only change S_DAX on inode load
      fs/ext4: Make DAX mount option a tri-state
      fs/ext4: Remove jflag variable
      fs/ext4: Introduce DAX inode flag
      Documentation/dax: Update DAX enablement for ext4

Jan (janneke) Nieuwenhuizen (1):
      ext4: support xattr gnu.* namespace for the Hurd

Jeffle Xu (1):
      ext4: fix partial cluster initialization when splitting extent

Ritesh Harjani (1):
      ext4: mballoc: Use this_cpu_read instead of this_cpu_ptr

Theodore Ts'o (2):
      Enable ext4 support for per-file/directory dax operations
      ext4: avoid race conditions when remounting with options that change dax

yangerkun (1):
      ext4: stop overwrite the errcode in ext4_setup_super

zhangyi (F) (1):
      ext4, jbd2: ensure panic by fix a race between jbd2 abort and ext4 error handlers

 Documentation/filesystems/dax.txt         | 142 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 Documentation/filesystems/ext4/verity.rst |   3 ++
 drivers/block/loop.c                      |   6 +--
 fs/dcache.c                               |  19 ++++++++
 fs/ext4/Makefile                          |   3 +-
 fs/ext4/dir.c                             |  16 ++++++
 fs/ext4/ext4.h                            |  27 ++++++++---
 fs/ext4/extents.c                         |   2 +-
 fs/ext4/ialloc.c                          |   2 +-
 fs/ext4/inode.c                           |  26 +++++++---
 fs/ext4/ioctl.c                           |  65 ++++++++++++++++++++-----
 fs/ext4/mballoc.c                         |   2 +-
 fs/ext4/super.c                           | 124 +++++++++++++++++++++++++++++++++--------------
 fs/ext4/verity.c                          |   5 +-
 fs/ext4/xattr.c                           |   2 +
 fs/ext4/xattr.h                           |   1 +
 fs/ext4/xattr_hurd.c                      |  51 ++++++++++++++++++++
 fs/jbd2/journal.c                         |  17 +++++--
 fs/stat.c                                 |   3 ++
 fs/xfs/xfs_icache.c                       |   4 +-
 fs/xfs/xfs_inode.h                        |   3 +-
 fs/xfs/xfs_super.c                        |   2 +-
 include/linux/dcache.h                    |   2 +
 include/linux/fs.h                        |  14 +++---
 include/linux/jbd2.h                      |   6 ++-
 include/uapi/linux/fs.h                   |   1 +
 include/uapi/linux/stat.h                 |   1 +
 include/uapi/linux/xattr.h                |   4 ++
 28 files changed, 465 insertions(+), 88 deletions(-)
 create mode 100644 fs/ext4/xattr_hurd.c
