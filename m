Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAF64E5B02
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Mar 2022 23:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239283AbiCWWDL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 23 Mar 2022 18:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238850AbiCWWDL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 23 Mar 2022 18:03:11 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F898EB57;
        Wed, 23 Mar 2022 15:01:40 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 22NM1bbn031171
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Mar 2022 18:01:38 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id B629615C0038; Wed, 23 Mar 2022 18:01:37 -0400 (EDT)
Date:   Wed, 23 Mar 2022 18:01:37 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [GIT PULL] ext4 updates for 5.18-rc1
Message-ID: <YjuYwa2jhanwyryf@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The following changes since commit cfb92440ee71adcc2105b0890bb01ac3cddb8507:

  Linux 5.17-rc5 (2022-02-20 13:07:20 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus

for you to fetch changes up to 919adbfec29d5b89b3e45620653cbeeb0d42e6fd:

  ext4: fix kernel doc warnings (2022-03-15 17:45:36 -0400)

----------------------------------------------------------------
Fix some bugs in converting ext4 to use the new mount API, as well as
more bug fixes and clean ups in the ext4 fast_commit feature (most
notably, in the tracepoints).  In the jbd2 layer, the t_handle_lock
spinlock has been removed, with the last place where it was actually
needed replaced with an atomic cmpxchg.

----------------------------------------------------------------
Colin Ian King (1):
      ext4: remove redundant assignment to variable split_flag1

Jan Kara (1):
      ext4: warn when dirtying page w/o buffers in data=journal mode

Lukas Czerner (1):
      ext4: fix remount with 'abort' option

Ojaswin Mujoo (2):
      ext4: make mb_optimize_scan option work with set/unset mount cmd
      ext4: make mb_optimize_scan performance mount option work with extents

Ritesh Harjani (23):
      jbd2: fix use-after-free of transaction_t race
      jbd2: kill t_handle_lock transaction spinlock
      jbd2: remove CONFIG_JBD2_DEBUG to update t_max_wait
      ext4: correct cluster len and clusters changed accounting in ext4_mb_mark_bb
      ext4: fix ext4_mb_mark_bb() with flex_bg with fast_commit
      ext4: refactor ext4_free_blocks() to pull out ext4_mb_clear_bb()
      ext4: use in_range() for range checking in ext4_fc_replay_check_excluded
      ext4: rename ext4_set_bits to mb_set_bits
      ext4: no need to test for block bitmap bits in ext4_mb_mark_bb()
      ext4: add ext4_sb_block_valid() refactored out of ext4_inode_block_valid()
      ext4: add strict range checks while freeing blocks
      ext4: add extra check in ext4_mb_mark_bb() to prevent against possible corruption
      ext4: improve fast_commit performance and scalability
      ext4: remove unused enum EXT4_FC_COMMIT_FAILED
      ext4: fix ext4_fc_stats trace point
      ext4: convert ext4_fc_track_dentry type events to use event class
      ext4: do not call FC trace event in ext4_fc_commit() if FS does not support FC
      ext4: return early for non-eligible fast_commit track events
      ext4: add new trace event in ext4_fc_cleanup
      ext4: add transaction tid info in fc_track events
      ext4: add commit_tid info in jbd debug log
      ext4: add commit tid info in ext4_fc_commit_start/stop trace events
      ext4: fix remaining two trace events to use same printk convention

Theodore Ts'o (2):
      ext4: don't BUG if someone dirty pages without asking ext4 first
      ext4: fix kernel doc warnings

Wang Qing (1):
      ext4: use time_is_before_jiffies() instead of open coding it

Yang Li (1):
      ext4: fix ext4_mb_clear_bb() kernel-doc comment

Ye Bin (1):
      ext4: fix fs corruption when tring to remove a non-empty directory with IO error

Zhang Yi (1):
      ext4: fix underflow in ext4_max_bitmap_size()

lianzhi chang (1):
      doc: fixed a typo in ext4 documentation

 Documentation/filesystems/ext4/blocks.rst |   2 +-
 fs/ext4/balloc.c                          |   1 +
 fs/ext4/block_validity.c                  |  26 +++--
 fs/ext4/ext4.h                            |   7 +-
 fs/ext4/extents.c                         |   1 -
 fs/ext4/fast_commit.c                     | 173 ++++++++++++++++++++--------
 fs/ext4/fast_commit.h                     |   2 +-
 fs/ext4/inline.c                          |   9 +-
 fs/ext4/inode.c                           |  35 +++++-
 fs/ext4/ioctl.c                           |   6 +-
 fs/ext4/mballoc.c                         | 345 +++++++++++++++++++++++++++++++------------------------
 fs/ext4/namei.c                           |  25 ++--
 fs/ext4/resize.c                          |   7 +-
 fs/ext4/super.c                           |  99 ++++++++++------
 fs/jbd2/transaction.c                     |  70 ++++++-----
 include/linux/jbd2.h                      |   3 -
 include/trace/events/ext4.h               | 298 +++++++++++++++++++++++++++++------------------
 17 files changed, 696 insertions(+), 413 deletions(-)
