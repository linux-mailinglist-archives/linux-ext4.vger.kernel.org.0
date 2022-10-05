Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4C25F4EFC
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Oct 2022 06:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiJEEDL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Oct 2022 00:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiJEEDK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Oct 2022 00:03:10 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323F438A1A;
        Tue,  4 Oct 2022 21:03:08 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2954346Y016346
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 5 Oct 2022 00:03:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1664942586; bh=N3HFCZ/oTNqAcXJpI/zlIBM/Py4SJWDHmTVs4uW72as=;
        h=Date:From:To:Cc:Subject;
        b=YtdieY1OT+GpFR9CCm1wXoWM8o6qvgF85ARYUvrbOlJCwLMMWFzbaQmqPp6SlA18y
         eYsfqSisQFZ7zLTulNLklA6hGdeVc6lm7gsQua9eX7gGFyf8NlwFr4bFhyms+Ksg/b
         lXucOf4DDAylHROKx+Kp6xzyW3w2yIrG4v8fOOYWiB3lPV6cwPsB1y0uSmA+XYLJ/p
         wWd96pWOo65engwcnTMFDkNJwWUgoEZ8hO7De/h4D9DGcGEAsMTyn3ekdftsuMenDx
         GHjgrH4/sA9rj/7lZGjABt+0fX3ym63f8uq7rkgDum0TtNPyeIDF2cwMjCepGGAIae
         xQLr3+IiTXcgQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 66CE815C35F2; Wed,  5 Oct 2022 00:03:04 -0400 (EDT)
Date:   Wed, 5 Oct 2022 00:03:04 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [GIT PULL] ext4 changes for 6.1
Message-ID: <Yz0B+L+vHKIARzKj@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The following changes since commit a078dff870136090b5779ca2831870a6c5539d36:

  ext4: fixup possible uninitialized variable access in ext4_mb_choose_next_group_cr1() (2022-09-26 13:21:05 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus

for you to fetch changes up to 1b45cc5c7b920fd8bf72e5a888ec7abeadf41e09:

  ext4: fix potential out of bound read in ext4_fc_replay_scan() (2022-09-30 23:46:54 -0400)

----------------------------------------------------------------
The first two changes that involve files outside of fs/ext4:

- submit_bh() can never return an error, so change it to return void,
  and remove the unused checks from its callers

- fix I_DIRTY_TIME handling so it will be set even if the inode
  already has I_DIRTY_INODE

Performance:

- Always enable i_version counter (as btrfs and xfs already do).
  Remove some uneeded i_version bumps to avoid unnecessary nfs cache
  invalidations.

- Wake up journal waters in FIFO order, to avoid some journal users
  from not getting a journal handle for an unfairly long time.

- In ext4_write_begin() allocate any necessary buffer heads before
  starting the journal handle.

- Don't try to prefetch the block allocation bitmaps for a read-only
  file system.

Bug Fixes:

- Fix a number of fast commit bugs, including resources leaks and out
  of bound references in various error handling paths and/or if the fast
  commit log is corrupted.

- Avoid stopping the online resize early when expanding a file system
  which is less than 16TiB to a size greater than 16TiB.

- Fix apparent metadata corruption caused by a race with a metadata
  buffer head getting migrated while it was trying to be read.

- Mark the lazy initialization thread freezable to prevent suspend
  failures.

- Other miscellaneous bug fixes.

Cleanups:

- Break up the incredibly long ext4_full_super() function by
  refactoring to move code into more understandable, smaller
  functions.

- Remove the deprecated (and ignored) noacl and nouser_attr mount
  option.

- Factor out some common code in fast commit handling.

- Other miscellaneous cleanups.

----------------------------------------------------------------
Andrew Perepechko (1):
      jbd2: wake up journal waiters in FIFO order, not LIFO

Baokun Li (1):
      ext4: fix null-ptr-deref in ext4_write_info

Eric Whitney (1):
      ext4: minor defrag code improvements

Gaosheng Cui (1):
      ext4: remove ext4_inline_data_fiemap() declaration

Guoqing Jiang (1):
      ext4: remove redundant checking in ext4_ioctl_checkpoint

Jan Kara (3):
      ext4: avoid crash when inline data creation follows DIO write
      ext4: fix check for block being out of directory size
      mbcache: Avoid nesting of cache->c_list_lock under bit locks

Jason Yan (16):
      ext4: goto right label 'failed_mount3a'
      ext4: remove cantfind_ext4 error handler
      ext4: factor out ext4_set_def_opts()
      ext4: factor out ext4_handle_clustersize()
      ext4: factor out ext4_fast_commit_init()
      ext4: factor out ext4_inode_info_init()
      ext4: factor out ext4_encoding_init()
      ext4: factor out ext4_init_metadata_csum()
      ext4: factor out ext4_check_feature_compatibility()
      ext4: factor out ext4_geometry_check()
      ext4: factor out ext4_group_desc_init() and ext4_group_desc_free()
      ext4: factor out ext4_load_and_init_journal()
      ext4: factor out ext4_journal_data_mode_check()
      ext4: unify the ext4 super block loading operation
      ext4: remove useless local variable 'blocksize'
      ext4: move DIOREAD_NOLOCK setting to ext4_set_def_opts()

Jeff Layton (2):
      ext4: unconditionally enable the i_version counter
      ext4: fix i_version handling in ext4

Jerry Lee 李修賢 (1):
      ext4: continue to expand file system when the target size doesn't reach

Jinke Han (1):
      ext4: place buffer head allocation before handle start

Josh Triplett (1):
      ext4: don't run ext4lazyinit for read-only filesystems

Lalith Rajendran (1):
      ext4: make ext4_lazyinit_thread freezable

Lukas Czerner (2):
      ext4: don't increase iversion counter for ea_inodes
      fs: record I_DIRTY_TIME even if inode already has I_DIRTY_INODE

Ritesh Harjani (IBM) (4):
      jbd2: drop useless return value of submit_bh
      fs/ntfs: drop useless return value of submit_bh from ntfs_submit_bh_for_read
      fs/buffer: drop useless return value of submit_bh
      fs/buffer: make submit_bh & submit_bh_wbc return type as void

Yang Xu (1):
      ext4: remove deprecated noacl/nouser_xattr options

Ye Bin (14):
      jbd2: fix potential buffer head reference count leak
      jbd2: fix potential use-after-free in jbd2_fc_wait_bufs
      ext4: fix miss release buffer head in ext4_fc_write_inode
      ext4: factor out ext4_fc_disabled()
      ext4: adjust fast commit disable judgement order in ext4_fc_track_inode
      jbd2: add miss release buffer head in fc_do_one_pass()
      ext4: fix potential memory leak in ext4_fc_record_modified_inode()
      ext4: fix potential memory leak in ext4_fc_record_regions()
      ext4: update 'state->fc_regions_size' after successful memory allocation
      ext4: remove unnecessary drop path references in mext_check_coverage()
      ext4: factor out ext4_free_ext_path()
      ext4: introduce EXT4_FC_TAG_BASE_LEN helper
      ext4: factor out ext4_fc_get_tl()
      ext4: fix potential out of bound read in ext4_fc_replay_scan()

Zhang Yi (1):
      ext4: ext4_read_bh_lock() should submit IO if the buffer isn't uptodate

Zhihao Cheng (1):
      ext4: fix dir corruption when ext4_dx_add_entry() fails

 Documentation/filesystems/vfs.rst |    3 +
 fs/buffer.c                       |   23 +-
 fs/ext4/ext4.h                    |    5 +-
 fs/ext4/extents.c                 |  107 ++--
 fs/ext4/extents_status.c          |    3 +-
 fs/ext4/fast_commit.c             |  210 +++++---
 fs/ext4/fast_commit.h             |    3 +
 fs/ext4/file.c                    |    6 +
 fs/ext4/inode.c                   |   17 +-
 fs/ext4/ioctl.c                   |    7 +-
 fs/ext4/migrate.c                 |    3 +-
 fs/ext4/move_extent.c             |   26 +-
 fs/ext4/namei.c                   |   17 +-
 fs/ext4/resize.c                  |    2 +-
 fs/ext4/super.c                   | 1253 ++++++++++++++++++++++++--------------------
 fs/ext4/verity.c                  |    6 +-
 fs/ext4/xattr.c                   |    1 +
 fs/fs-writeback.c                 |   37 +-
 fs/jbd2/commit.c                  |   12 +-
 fs/jbd2/journal.c                 |   19 +-
 fs/jbd2/recovery.c                |    1 +
 fs/jbd2/transaction.c             |    6 +-
 fs/mbcache.c                      |   17 +-
 fs/ntfs/file.c                    |    4 +-
 fs/xfs/xfs_super.c                |   10 +-
 include/linux/buffer_head.h       |    2 +-
 include/linux/fs.h                |    9 +-
 27 files changed, 998 insertions(+), 811 deletions(-)
