Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B594C44CCF9
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Nov 2021 23:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233781AbhKJWsB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 10 Nov 2021 17:48:01 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:48909 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233725AbhKJWsA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 10 Nov 2021 17:48:00 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1AAMj8oZ020936
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Nov 2021 17:45:09 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 431B715C00B9; Wed, 10 Nov 2021 17:45:08 -0500 (EST)
Date:   Wed, 10 Nov 2021 17:45:08 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     torvalds@linux-foundation.org
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ext4 changes for 5.16-rc1
Message-ID: <YYxLdGu1Lkcl9HzP@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The following changes since commit 9e1ff307c779ce1f0f810c7ecce3d95bbae40896:

  Linux 5.15-rc4 (2021-10-03 14:08:47 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus

for you to fetch changes up to 124e7c61deb27d758df5ec0521c36cf08d417f7a:

  ext4: fix error code saved on super block during file system abort (2021-11-04 10:47:39 -0400)

----------------------------------------------------------------
Only bug fixes and cleanups for ext4 this merge window.  Of note are
fixes for the combination of the inline_data and fast_commit fixes,
and more accurately calculating when to schedule additional lazy inode
table init, especially when CONFIG_HZ is 100HZ.

----------------------------------------------------------------
Austin Kim (1):
      ext4: remove an unused variable warning with CONFIG_QUOTA=n

Eric Whitney (1):
      Revert "ext4: enforce buffer head state assertion in ext4_da_map_blocks"

Gabriel Krisman Bertazi (1):
      ext4: fix error code saved on super block during file system abort

Harshad Shirwadkar (2):
      ext4: commit inline data during fast commit
      ext4: inline data inode fast commit replay fixes

Jing Yangyang (1):
      ext4: fix boolreturn.cocci warnings in fs/ext4/name.c

Lukas Bulwahn (1):
      ext4: scope ret locally in ext4_try_to_trim_range()

Shaoying Xu (1):
      ext4: fix lazy initialization next schedule time computation in more granular unit

Xiyu Yang (1):
      ext4: convert from atomic_t to refcount_t on ext4_io_end->count

Zhang Yi (6):
      ext4: check for out-of-order index extents in ext4_valid_extent_entries()
      ext4: check for inconsistent extents between index and leaf block
      ext4: prevent partial update of the extent blocks
      ext4: factor out ext4_fill_raw_inode()
      ext4: move ext4_fill_raw_inode() related functions
      ext4: prevent getting empty inode buffer

yangerkun (3):
      ext4: correct the left/middle/right debug message for binsearch
      ext4: ensure enough credits in ext4_ext_shift_path_extents
      ext4: refresh the ext4_ext_path struct after dropping i_data_sem.

 fs/ext4/ext4.h        |   3 +-
 fs/ext4/extents.c     | 175 ++++++++++++++++------------
 fs/ext4/fast_commit.c |  11 +-
 fs/ext4/inode.c       | 331 +++++++++++++++++++++++++++--------------------------
 fs/ext4/mballoc.c     |   5 +-
 fs/ext4/namei.c       |   2 +-
 fs/ext4/page-io.c     |   8 +-
 fs/ext4/super.c       |  15 +--
 8 files changed, 300 insertions(+), 250 deletions(-)
