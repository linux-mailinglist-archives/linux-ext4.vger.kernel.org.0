Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABA65B8303
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Sep 2019 22:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732847AbfISU4r (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Sep 2019 16:56:47 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:44114 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732841AbfISU4r (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Sep 2019 16:56:47 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x8JKuf3T028218
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Sep 2019 16:56:42 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 65BE8420811; Thu, 19 Sep 2019 16:56:41 -0400 (EDT)
Date:   Thu, 19 Sep 2019 16:56:41 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [GIT PULL] ext4 updates for 5.4
Message-ID: <20190919205641.GA23449@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The following changes since commit d45331b00ddb179e291766617259261c112db872:

  Linux 5.3-rc4 (2019-08-11 13:26:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus

for you to fetch changes up to 040823b5372b445d1d9483811e85a24d71314d33:

  Merge tag 'unicode-next-v5.4' of https://git.kernel.org/pub/scm/linux/kernel/git/krisman/unicode into dev (2019-09-18 10:36:24 -0400)

----------------------------------------------------------------
Added new ext4 debugging ioctls to allow userspace to get information
about the state of the extent status cache.

Dropped workaround for pre-1970 dates which were encoded incorrectly
in pre-4.4 kernels.  Since both the kernel correctly generates, and
e2fsck detects and fixes this issue for the past four years, it'e time
to drop the workaround.  (Also, it's not like files with dates in the
distant past were all that common in the first place.)

A lot of miscellaneous bug fixes and cleanups, including some ext4
Documentation fixes.  Also included are two minor bug fixes in
fs/unicode.

----------------------------------------------------------------
Ayush Ranjan (2):
      ext4: documentation fixes
      ext4: add missing bigalloc documentation.

Chandan Rajendra (1):
      jbd2: flush_descriptor(): Do not decrease buffer head's ref count

Colin Ian King (2):
      ext4: set error return correctly when ext4_htree_store_dirent fails
      unicode: make array 'token' static const, makes object smaller

Eric Whitney (1):
      ext4: rework reserved cluster accounting when invalidating pages

Krzysztof Wilczynski (1):
      unicode: Move static keyword to the front of declarations

Rakesh Pandit (1):
      ext4: fix warning inside ext4_convert_unwritten_extents_endio

Shi Siyuan (1):
      ext4: remove unnecessary error check

Theodore Ts'o (7):
      ext4: add a new ioctl EXT4_IOC_CLEAR_ES_CACHE
      ext4: add a new ioctl EXT4_IOC_GETSTATE
      ext4: add new ioctl EXT4_IOC_GET_ES_CACHE
      ext4: drop legacy pre-1970 encoding workaround
      ext4: fix punch hole for inline_data file systems
      ext4: fix kernel oops caused by spurious casefold flag
      Merge tag 'unicode-next-v5.4' of https://git.kernel.org/.../krisman/unicode into dev

Xiaoguang Wang (1):
      jbd2: add missing tracepoint for reserved handle

Yang Guo (1):
      ext4: use percpu_counters for extent_status cache hits/misses

ZhangXiaoxu (1):
      ext4: treat buffers with write errors as containing valid data

yangerkun (1):
      ext4: fix warning when turn on dioread_nolock and inline_data

zhangyi (F) (2):
      ext4: fix potential use after free after remounting with noblock_validity
      ext4: fix integer overflow when calculating commit interval

 Documentation/filesystems/ext4/bigalloc.rst    |  32 ++-
 Documentation/filesystems/ext4/blockgroup.rst  |  10 +-
 Documentation/filesystems/ext4/blocks.rst      |   4 +-
 Documentation/filesystems/ext4/directory.rst   |   2 +-
 Documentation/filesystems/ext4/group_descr.rst |   9 +-
 Documentation/filesystems/ext4/inodes.rst      |   4 +-
 Documentation/filesystems/ext4/super.rst       |  20 +-
 fs/ext4/block_validity.c                       | 189 +++++++++++++-----
 fs/ext4/dir.c                                  |   7 +-
 fs/ext4/ext4.h                                 |  64 ++++--
 fs/ext4/extents.c                              |  98 +++++++++-
 fs/ext4/extents_status.c                       | 521 ++++++++++++++++++++++++++++++++++++++-----------
 fs/ext4/extents_status.h                       |   8 +-
 fs/ext4/file.c                                 |   2 -
 fs/ext4/hash.c                                 |   2 +-
 fs/ext4/inline.c                               |   2 +-
 fs/ext4/inode.c                                | 103 +++-------
 fs/ext4/ioctl.c                                |  98 ++++++++++
 fs/ext4/namei.c                                |   4 +-
 fs/ext4/super.c                                |   7 +
 fs/jbd2/revoke.c                               |   4 +-
 fs/jbd2/transaction.c                          |   3 +
 fs/unicode/utf8-core.c                         |   2 +-
 fs/unicode/utf8-selftest.c                     |   4 +-
 24 files changed, 890 insertions(+), 309 deletions(-)
