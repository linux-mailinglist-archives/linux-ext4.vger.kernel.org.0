Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0370729E3BE
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Oct 2020 08:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbgJ2HVP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Oct 2020 03:21:15 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:37982 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725949AbgJ2HUr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 29 Oct 2020 03:20:47 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 09T4Otbv032668
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Oct 2020 00:24:56 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 72E2E420107; Thu, 29 Oct 2020 00:24:55 -0400 (EDT)
Date:   Thu, 29 Oct 2020 00:24:55 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: GIT PULL] ext4 fixes for 5.10-rc2
Message-ID: <20201029042455.GA1241260@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The following changes since commit 96485e4462604744d66bf4301557d996d80b85eb:

  Merge tag 'ext4_for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4 (2020-10-22 10:31:08 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_fixes

for you to fetch changes up to 6694875ef8045cdb1e6712ee9b68fe08763507d8:

  ext4: indicate that fast_commit is available via /sys/fs/ext4/feature/... (2020-10-28 13:43:22 -0400)

----------------------------------------------------------------
Bug fixes for the new ext4 fast commit feature, plus a fix for the
data=journal bug fix.  Also use the generic casefolding support which
has now landed in fs/libfs.c for 5.10.

----------------------------------------------------------------
Andrea Righi (1):
      ext4: properly check for dirty state in ext4_inode_datasync_dirty()

Daniel Rosenberg (1):
      ext4: use generic casefolding support

Harshad Shirwadkar (4):
      ext4: fix double locking in ext4_fc_commit_dentry_updates()
      ext4: make num of fast commit blocks configurable
      ext4: use s_mount_flags instead of s_mount_state for fast commit state
      ext4: use IS_ERR() for error checking of path

Jan Kara (1):
      ext4: fix mmap write protection for data=journal mode

Mauro Carvalho Chehab (1):
      jbd2: fix a kernel-doc markup

Theodore Ts'o (1):
      ext4: indicate that fast_commit is available via /sys/fs/ext4/feature/...

yangerkun (1):
      ext4: do not use extent after put_bh

 fs/ext4/dir.c         | 64 ++--------------------------------------------------------------
 fs/ext4/ext4.h        | 20 ++++----------------
 fs/ext4/extents.c     | 30 +++++++++++++++---------------
 fs/ext4/fast_commit.c | 37 ++++++++++++++++++++++++-------------
 fs/ext4/hash.c        |  2 +-
 fs/ext4/inode.c       | 15 +++++++++------
 fs/ext4/namei.c       | 20 ++++++++------------
 fs/ext4/super.c       | 16 ++++++++--------
 fs/ext4/sysfs.c       |  2 ++
 include/linux/jbd2.h  |  7 +++++--
 10 files changed, 78 insertions(+), 135 deletions(-)
