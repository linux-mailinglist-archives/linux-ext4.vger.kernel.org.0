Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98FB93252E9
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Feb 2021 17:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbhBYQBE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 25 Feb 2021 11:01:04 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45896 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232949AbhBYQBD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 25 Feb 2021 11:01:03 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 11PG0E1T006232
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Feb 2021 11:00:14 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id EBED515C343C; Thu, 25 Feb 2021 11:00:13 -0500 (EST)
Date:   Thu, 25 Feb 2021 11:00:13 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ext4 changes for v5.12
Message-ID: <YDfJjd0JEhAHoC2n@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The following changes since commit 1048ba83fb1c00cd24172e23e8263972f6b5d9ac:

  Linux 5.11-rc6 (2021-01-31 13:50:09 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus

for you to fetch changes up to 0a76945fd1ba2ab44da7b578b311efdfedf92e6c:

  ext4: add .kunitconfig fragment to enable ext4-specific tests (2021-02-11 23:16:30 -0500)

----------------------------------------------------------------
Miscellaneous ext4 cleanups and bug fixes.  Pretty boring this
cycle...

----------------------------------------------------------------
Daejun Park (1):
      ext4: Change list_for_each* to list_for_each_entry*

Daniel Latypov (1):
      ext4: add .kunitconfig fragment to enable ext4-specific tests

Eric Whitney (1):
      ext4: reset retry counter when ext4_alloc_file_blocks() makes progress

Geert Uytterhoeven (1):
      ext: EXT4_KUNIT_TESTS should depend on EXT4_FS instead of selecting it

Theodore Ts'o (2):
      ext4: don't try to processed freed blocks until mballoc is initialized
      ext4: fix potential htree index checksum corruption

Vinicius Tinti (1):
      ext4: factor out htree rep invariant check

Zheng Yongjun (1):
      ext4: use DEFINE_MUTEX() for mutex lock

 fs/ext4/.kunitconfig  |  3 +++
 fs/ext4/Kconfig       |  3 +--
 fs/ext4/extents.c     | 16 ++++++++--------
 fs/ext4/fast_commit.c | 29 +++++++++++------------------
 fs/ext4/namei.c       | 45 +++++++++++++++++++++++++++------------------
 fs/ext4/super.c       | 12 +++++++++---
 6 files changed, 59 insertions(+), 49 deletions(-)
 create mode 100644 fs/ext4/.kunitconfig
