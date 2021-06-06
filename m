Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF78F39CF7C
	for <lists+linux-ext4@lfdr.de>; Sun,  6 Jun 2021 16:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhFFOXB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 6 Jun 2021 10:23:01 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:41444 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230106AbhFFOW6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 6 Jun 2021 10:22:58 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 156EL3VJ022752
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 6 Jun 2021 10:21:04 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 4D4B815C3C40; Sun,  6 Jun 2021 10:21:03 -0400 (EDT)
Date:   Sun, 6 Jun 2021 10:21:03 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [GIT PULL] ext4 fixes for v5.13
Message-ID: <YLzZz/Mh2HQQd80+@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The following changes since commit 6c0912739699d8e4b6a87086401bf3ad3c59502d:

  ext4: wipe ext4_dir_entry2 upon file deletion (2021-04-22 16:51:23 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable

for you to fetch changes up to e71f99f2dfb45f4e7203a0732e85f71ef1d04dab:

  ext4: Only advertise encrypted_casefold when encryption and unicode are enabled (2021-06-06 10:10:23 -0400)

----------------------------------------------------------------
Miscellaneous ext4 bug fixes for v5.13

----------------------------------------------------------------
Alexey Makhalov (1):
      ext4: fix memory leak in ext4_fill_super

Daniel Rosenberg (2):
      ext4: fix no-key deletion for encrypt+casefold
      ext4: Only advertise encrypted_casefold when encryption and unicode are enabled

Harshad Shirwadkar (1):
      ext4: fix fast commit alignment issues

Phillip Potter (1):
      ext4: fix memory leak in ext4_mb_init_backend on error path.

Ritesh Harjani (1):
      ext4: fix accessing uninit percpu counter variable with fast_commit

Ye Bin (1):
      ext4: fix bug on in ext4_es_cache_extent as ext4_split_extent_at failed

 fs/ext4/extents.c     |  43 ++++++++-------
 fs/ext4/fast_commit.c | 170 +++++++++++++++++++++++++++++++---------------------------
 fs/ext4/fast_commit.h |  19 -------
 fs/ext4/ialloc.c      |   6 ++-
 fs/ext4/mballoc.c     |   2 +-
 fs/ext4/namei.c       |   6 ++-
 fs/ext4/super.c       |  11 +++-
 fs/ext4/sysfs.c       |   4 ++
 8 files changed, 135 insertions(+), 126 deletions(-)
