Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0BD816DD0
	for <lists+linux-ext4@lfdr.de>; Wed,  8 May 2019 01:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfEGX2a (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 May 2019 19:28:30 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:41306 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726256AbfEGX2a (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 May 2019 19:28:30 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-109.corp.google.com [104.133.0.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x47NSN2r013232
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 May 2019 19:28:26 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 6FB15420024; Tue,  7 May 2019 19:28:23 -0400 (EDT)
Date:   Tue, 7 May 2019 19:28:23 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [GIT PULL] ext4 changes for 5.2
Message-ID: <20190507232823.GA28416@mit.edu>
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

The following changes since commit 79a3aaa7b82e3106be97842dedfd8429248896e6:

  Linux 5.1-rc3 (2019-03-31 14:39:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus

for you to fetch changes up to db90f41916cf04c020062f8d8b0385942248283e:

  ext4: export /sys/fs/ext4/feature/casefold if Unicode support is present (2019-05-06 14:03:52 -0400)

----------------------------------------------------------------
Add as a feature case-insensitive directories (the casefold feature)
using Unicode 12.1.  Also, the usual largish number of cleanups and bug
fixes.

----------------------------------------------------------------
Arnd Bergmann (1):
      ext4: use BUG() instead of BUG_ON(1)

Barret Rhoden (1):
      ext4: fix use-after-free race with debug_want_extra_isize

Debabrata Banerjee (1):
      ext4: fix ext4_show_options for file systems w/o journal

Eric Biggers (1):
      ext4: remove incorrect comment for NEXT_ORPHAN()

Gabriel Krisman Bertazi (8):
      unicode: introduce UTF-8 character database
      unicode: implement higher level API for string handling
      unicode: introduce test module for normalized utf8 implementation
      unicode: update unicode database unicode version 12.1.0
      MAINTAINERS: add Unicode subsystem entry
      ext4: include charset encoding information in the superblock
      ext4: Support case-insensitive file name lookups
      docs: ext4.rst: document case-insensitive directories

Jan Kara (1):
      ext4: make sanity check in mballoc more strict

Jiufei Xue (1):
      jbd2: check superblock mapped prior to committing

Khazhismel Kumykov (1):
      ext4: cond_resched in work-heavy group loops

Kirill Tkhai (1):
      ext4: actually request zeroing of inode table after grow

Liu Song (1):
      jbd2: remove repeated assignments in __jbd2_log_wait_for_space()

Liu Xiang (1):
      ext4: fix prefetchw of NULL page

Masahiro Yamada (1):
      unicode: refactor the rule for regenerating utf8data.h

Olaf Weber (2):
      unicode: introduce code for UTF-8 normalization
      unicode: reduce the size of utf8data[]

Pan Bian (1):
      ext4: avoid drop reference to iloc.bh twice

Theodore Ts'o (3):
      ext4: protect journal inode's blocks using block_validity
      ext4: ignore e_value_offs for xattrs with value-in-ea-inode
      ext4: export /sys/fs/ext4/feature/casefold if Unicode support is present

 Documentation/admin-guide/ext4.rst |   38 +
 Documentation/dontdiff             |    2 +
 MAINTAINERS                        |    6 +
 fs/Kconfig                         |    1 +
 fs/Makefile                        |    1 +
 fs/ext4/block_validity.c           |   49 +
 fs/ext4/dir.c                      |   48 +
 fs/ext4/ext4.h                     |   45 +-
 fs/ext4/extents_status.c           |    4 +-
 fs/ext4/hash.c                     |   34 +-
 fs/ext4/ialloc.c                   |    2 +-
 fs/ext4/inline.c                   |    2 +-
 fs/ext4/inode.c                    |   12 +-
 fs/ext4/ioctl.c                    |   20 +-
 fs/ext4/mballoc.c                  |    4 +-
 fs/ext4/namei.c                    |  107 +-
 fs/ext4/readpage.c                 |    3 +-
 fs/ext4/resize.c                   |    1 +
 fs/ext4/super.c                    |  151 ++-
 fs/ext4/sysfs.c                    |    6 +
 fs/ext4/xattr.c                    |    2 +-
 fs/jbd2/checkpoint.c               |    1 -
 fs/jbd2/journal.c                  |    4 +
 fs/unicode/.gitignore              |    2 +
 fs/unicode/Kconfig                 |   13 +
 fs/unicode/Makefile                |   38 +
 fs/unicode/README.utf8data         |   71 ++
 fs/unicode/mkutf8data.c            | 3419 ++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/unicode/utf8-core.c             |  187 +++
 fs/unicode/utf8-norm.c             |  799 ++++++++++++
 fs/unicode/utf8-selftest.c         |  320 +++++
 fs/unicode/utf8data.h_shipped      | 4109 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/unicode/utf8n.h                 |  117 ++
 include/linux/fs.h                 |    2 +
 include/linux/unicode.h            |   30 +
 35 files changed, 9591 insertions(+), 59 deletions(-)
 create mode 100644 fs/unicode/.gitignore
 create mode 100644 fs/unicode/Kconfig
 create mode 100644 fs/unicode/Makefile
 create mode 100644 fs/unicode/README.utf8data
 create mode 100644 fs/unicode/mkutf8data.c
 create mode 100644 fs/unicode/utf8-core.c
 create mode 100644 fs/unicode/utf8-norm.c
 create mode 100644 fs/unicode/utf8-selftest.c
 create mode 100644 fs/unicode/utf8data.h_shipped
 create mode 100644 fs/unicode/utf8n.h
 create mode 100644 include/linux/unicode.h
