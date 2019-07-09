Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8DE663E09
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Jul 2019 00:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbfGIWzy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 9 Jul 2019 18:55:54 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:37592 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726318AbfGIWzy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 9 Jul 2019 18:55:54 -0400
Received: from callcc.thunk.org ([199.116.118.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x69MtmBf005075
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 9 Jul 2019 18:55:50 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 0F1B042002E; Tue,  9 Jul 2019 18:55:48 -0400 (EDT)
Date:   Tue, 9 Jul 2019 18:55:48 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [GIT PULL] ext4 updates for 5.3-rc1
Message-ID: <20190709225547.GA27938@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The following changes since commit cd6c84d8f0cdc911df435bb075ba22ce3c605b07:

  Linux 5.2-rc2 (2019-05-26 16:49:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus

for you to fetch changes up to 96fcaf86c3cb9340015fb475d79ef0a6fcf858ed:

  ext4: fix coverity warning on error path of filename setup (2019-07-02 17:56:12 -0400)

----------------------------------------------------------------
Many bug fixes and cleanups, and an optimization for case-insensitive
lookups.

----------------------------------------------------------------
Colin Ian King (1):
      ext4: remove redundant assignment to node

Darrick J. Wong (1):
      ext4: don't allow any modifications to an immutable file

Gabriel Krisman Bertazi (2):
      ext4: optimize case-insensitive lookups
      ext4: fix coverity warning on error path of filename setup

Gaowei Pu (1):
      jbd2: fix some print format mistakes

Jan Kara (1):
      ext4: gracefully handle ext4_break_layouts() failure during truncate

Kimberly Brown (1):
      ext4: replace ktype default_attrs with default_groups

Liu Song (1):
      jbd2: fix typo in comment of journal_submit_inode_data_buffers

Ross Zwisler (3):
      mm: add filemap_fdatawait_range_keep_errors()
      jbd2: introduce jbd2_inode dirty range scoping
      ext4: use jbd2_inode dirty range scoping

Theodore Ts'o (7):
      ext4: enforce the immutable flag on open files
      ext4: clean up kerneldoc warnigns when building with W=1
      jbd2: drop declaration of journal_sync_buffer()
      ext4: allow directory holes
      ext4: rename "dirent_csum" functions to use "dirblock"
      ext4: refactor initialize_dirent_tail()
      ext4: rename htree_inline_dir_to_tree() to ext4_inlinedir_to_tree()

Wang Shilong (1):
      ext4: only set project inherit bit for directory

zhangjs (1):
      ext4: make __ext4_get_inode_loc plug

 fs/ext4/balloc.c         |   4 +-
 fs/ext4/dir.c            |  27 +++++-----
 fs/ext4/ext4.h           |  65 ++++++++++++++++++------
 fs/ext4/ext4_jbd2.h      |  12 ++---
 fs/ext4/extents.c        |   4 +-
 fs/ext4/extents_status.c |   1 -
 fs/ext4/file.c           |   4 ++
 fs/ext4/indirect.c       |  22 +++------
 fs/ext4/inline.c         |  21 ++++----
 fs/ext4/inode.c          |  93 ++++++++++++++++++++++-------------
 fs/ext4/ioctl.c          |  48 +++++++++++++++++-
 fs/ext4/mballoc.c        |   5 +-
 fs/ext4/move_extent.c    |  15 +++---
 fs/ext4/namei.c          | 213 +++++++++++++++++++++++++++++++++++++++++++++++++------------------------------
 fs/ext4/sysfs.c          |   6 ++-
 fs/jbd2/commit.c         |  25 +++++++---
 fs/jbd2/journal.c        |  25 +++++-----
 fs/jbd2/transaction.c    |  49 ++++++++++--------
 fs/unicode/utf8-core.c   |  28 +++++++++++
 include/linux/fs.h       |   2 +
 include/linux/jbd2.h     |  23 ++++++++-
 include/linux/unicode.h  |   3 ++
 mm/filemap.c             |  22 +++++++++
 23 files changed, 483 insertions(+), 234 deletions(-)
