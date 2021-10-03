Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8EB84202B1
	for <lists+linux-ext4@lfdr.de>; Sun,  3 Oct 2021 18:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbhJCQdA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 3 Oct 2021 12:33:00 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:46332 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230426AbhJCQc7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 3 Oct 2021 12:32:59 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 193GV7wK030923
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 3 Oct 2021 12:31:07 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 1F34115C34C3; Sun,  3 Oct 2021 12:31:07 -0400 (EDT)
Date:   Sun, 3 Oct 2021 12:31:07 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [GIT PULL] ext4 fixes for 5.15-rc4
Message-ID: <YVnay/TJEr8K64+U@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The following changes since commit baaae979b112642a41b71c71c599d875c067d257:

  ext4: make the updating inode data procedure atomic (2021-08-30 23:36:51 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable

for you to fetch changes up to f2c77973507fd116c3657df1dc048864a2b16a1c:

  ext4: recheck buffer uptodate bit under buffer lock (2021-10-01 00:10:28 -0400)

----------------------------------------------------------------
Fix a number of ext4 bugs in fast_commit, inline data, and delayed
allocation.  Also fix error handling code paths in ext4_dx_readdir()
and ext4_fill_super().  Finally, avoid a grabbing a journal head in
the delayed allocation write in the common cases where we are
overwriting an pre-existing block or appending to an inode.

----------------------------------------------------------------
Eric Whitney (2):
      ext4: remove extent cache entries when truncating inline data
      ext4: enforce buffer head state assertion in ext4_da_map_blocks

Hou Tao (1):
      ext4: limit the number of blocks in one ADD_RANGE TLV

Jeffle Xu (1):
      ext4: fix reserved space counter leakage

Ritesh Harjani (1):
      ext4: fix loff_t overflow in ext4_max_bitmap_size()

Theodore Ts'o (2):
      ext4: add error checking to ext4_ext_replay_set_iblocks()
      Merge branch 'delalloc-buffer-write' into dev

Zhang Yi (5):
      ext4: check and update i_disksize properly
      ext4: correct the error path of ext4_write_inline_data_end()
      ext4: factor out write end code of inline file
      ext4: drop unnecessary journal handle in delalloc write
      ext4: recheck buffer uptodate bit under buffer lock

yangerkun (2):
      ext4: flush s_error_work before journal destroy in ext4_fill_super
      ext4: fix potential infinite loop in ext4_dx_readdir()

 fs/ext4/dir.c         |   6 +-
 fs/ext4/ext4.h        |   3 -
 fs/ext4/extents.c     |  19 ++++--
 fs/ext4/fast_commit.c |   6 ++
 fs/ext4/inline.c      | 150 +++++++++++++++++++++++++--------------------
 fs/ext4/inode.c       | 176 ++++++++++++++++++-----------------------------------
 fs/ext4/super.c       |  21 +++++--
 7 files changed, 182 insertions(+), 199 deletions(-)
