Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F5753322F
	for <lists+linux-ext4@lfdr.de>; Tue, 24 May 2022 22:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241302AbiEXUKH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 24 May 2022 16:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbiEXUKH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 24 May 2022 16:10:07 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1325AA59;
        Tue, 24 May 2022 13:10:05 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 24OKA056012902
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 May 2022 16:10:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1653423001; bh=Vd8vq/pLcOdhWRR7zgoxMLwiycDlEMPCG5I4M2AmTg0=;
        h=Date:From:To:Cc:Subject;
        b=Oxo83WryZc4HfOK/myGHx2mfN9lIjgWJ8V4UAZxqdjg3JD5IRn0OxVPYlbACUIqKg
         Qvl4WvFkA4vptxvpMkcnaC+fulnT7TIYgJFGNrlO858XHnQJJ2SlUM8Ad49mjkbxur
         9oOO0/4wVwaRg8GrRgz5BHVaPrwvBMbfrQheSxKZGOdXLWNUd4uPbTcmysTXSlRFfS
         G3fg1ORj+C3LU/zmlcJq2PETFSx0bP0nJBnOVXeGy8vHp0sEGmGoh9E/T7TJwwhIiv
         MAyKRjYyl5Sn0DKSW1fP+z12lEHDnFjXLWuTl56RxNEsWV/EtIDHm3SKa7WTx/LQid
         GTIxLqR4nT4ag==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 528B415C3399; Tue, 24 May 2022 16:10:00 -0400 (EDT)
Date:   Tue, 24 May 2022 16:10:00 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [GIT PULL] ext4 updates for v5.19-rc1
Message-ID: <Yo07mIe2Hc6GYFrX@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The following changes since commit 672c0c5173427e6b3e2a9bbb7be51ceeec78093a:

  Linux 5.18-rc5 (2022-05-01 13:57:58 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus

for you to fetch changes up to 5f41fdaea63ddf96d921ab36b2af4a90ccdb5744:

  ext4: only allow test_dummy_encryption when supported (2022-05-24 15:34:27 -0400)

----------------------------------------------------------------
Various bug fixes and cleanups for ext4.  In particular, move the
crypto related fucntions from fs/ext4/super.c into a new
fs/ext4/crypto.c, and fix a number of bugs found by fuzzers and error
injection tools.

----------------------------------------------------------------
Baokun Li (2):
      ext4: fix race condition between ext4_write and ext4_convert_inline_data
      ext4: fix bug_on in __es_tree_search

Chin Yik Ming (1):
      ext4: fix spelling errors in comments

Dmitry Monakhov (1):
      ext4: mark group as trimmed only if it was fully scanned

Eric Biggers (3):
      ext4: reject the 'commit' option on ext2 filesystems
      ext4: fix memory leak in parse_apply_sb_mount_options()
      ext4: only allow test_dummy_encryption when supported

Jan Kara (2):
      ext4: verify dir block before splitting it
      ext4: avoid cycles in directory h-tree

Jinke Han (1):
      ext4: remove unnecessary code in __mb_check_buddy

Lv Ruyi (1):
      ext4: remove unnecessary conditionals

Ojaswin Mujoo (2):
      ext4: get rid of unused DEFAULT_MB_OPTIMIZE_SCAN
      ext4: fix journal_ioprio mount option handling

Ritesh Harjani (3):
      ext4: move ext4 crypto code to its own file crypto.c
      ext4: cleanup function defs from ext4.h into crypto.c
      ext4: refactor and move ext4_ioctl_get_encryption_pwsalt()

Theodore Ts'o (1):
      ext4: filter out EXT4_FC_REPLAY from on-disk superblock field s_state

Yang Li (1):
      ext4: remove duplicated #include of dax.h in inode.c

Ye Bin (3):
      ext4: fix warning in ext4_handle_inode_extension
      ext4: fix use-after-free in ext4_rename_dir_prepare
      ext4: fix bug_on in ext4_writepages

Yu Zhe (1):
      ext4: remove unnecessary type castings

Zhang Yi (3):
      ext4: add unmount filesystem message
      ext4: add nowait mode for ext4_getblk()
      ext4: convert symlink external data block mapping to bdev

 fs/ext4/Makefile      |   1 +
 fs/ext4/crypto.c      | 246 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/ext4/dir.c         |   6 +-
 fs/ext4/ext4.h        |  84 +++++--------------------
 fs/ext4/extents.c     |  20 +++---
 fs/ext4/fast_commit.c |  13 ++--
 fs/ext4/inline.c      |  18 +++++-
 fs/ext4/inode.c       |  37 ++++++-----
 fs/ext4/ioctl.c       |  59 +-----------------
 fs/ext4/mballoc.c     |  25 ++++----
 fs/ext4/mmp.c         |   2 +-
 fs/ext4/namei.c       | 214 ++++++++++++++++++++++++++++++++++++---------------------------
 fs/ext4/super.c       | 217 ++++++++++++++++++----------------------------------------------
 fs/ext4/symlink.c     |  51 ++++++++++++---
 14 files changed, 564 insertions(+), 429 deletions(-)
 create mode 100644 fs/ext4/crypto.c
