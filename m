Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A8D343410
	for <lists+linux-ext4@lfdr.de>; Sun, 21 Mar 2021 19:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbhCUSbl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 21 Mar 2021 14:31:41 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52686 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230042AbhCUSbV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 21 Mar 2021 14:31:21 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 12LIVHRX016263
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 Mar 2021 14:31:18 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id BB29615C39CA; Sun, 21 Mar 2021 14:31:17 -0400 (EDT)
Date:   Sun, 21 Mar 2021 14:31:17 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ext4 fixes for v5.12
Message-ID: <YFeQ9eBFn5JELyYo@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable

for you to fetch changes up to 64395d950bc476106b39341e42ebfd4d2eb71d2c:

  ext4: initialize ret to suppress smatch warning (2021-03-21 00:45:37 -0400)

----------------------------------------------------------------
Miscellaneous ext4 bug fixes for v5.12.

----------------------------------------------------------------
Eric Biggers (1):
      ext4: fix error handling in ext4_end_enable_verity()

Eric Whitney (1):
      ext4: shrink race window in ext4_should_retry_alloc()

Harshad Shirwadkar (1):
      ext4: fix rename whiteout with fast commit

Jan Kara (2):
      ext4: add reclaim checks to xattr code
      ext4: fix timer use-after-free on failed mount

Pan Bian (1):
      ext4: stop inode update before return

Sabyrzhan Tasbolatov (1):
      fs/ext4: fix integer overflow in s_log_groups_per_flex

Shijie Luo (1):
      ext4: fix potential error in ext4_do_update_inode

Theodore Ts'o (1):
      ext4: initialize ret to suppress smatch warning

Zhaolong Zhang (1):
      ext4: fix bh ref count on error paths

zhangyi (F) (3):
      ext4: find old entry again if failed to rename whiteout
      ext4: do not iput inode under running transaction in ext4_rename()
      ext4: do not try to set xattr into ea_inode if value is empty

 fs/ext4/balloc.c      | 38 +++++++++++++++++--------
 fs/ext4/ext4.h        |  3 ++
 fs/ext4/extents.c     |  2 +-
 fs/ext4/fast_commit.c |  9 ++++--
 fs/ext4/inode.c       | 18 ++++++------
 fs/ext4/mballoc.c     | 11 ++++++--
 fs/ext4/namei.c       | 50 +++++++++++++++++++++++++--------
 fs/ext4/super.c       |  7 ++++-
 fs/ext4/sysfs.c       |  7 +++++
 fs/ext4/verity.c      | 89 ++++++++++++++++++++++++++++++++++++-----------------------
 fs/ext4/xattr.c       |  6 +++-
 11 files changed, 168 insertions(+), 72 deletions(-)
