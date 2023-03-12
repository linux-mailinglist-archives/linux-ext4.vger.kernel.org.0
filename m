Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021BA6B6332
	for <lists+linux-ext4@lfdr.de>; Sun, 12 Mar 2023 05:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjCLEl2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 11 Mar 2023 23:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjCLEl1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 11 Mar 2023 23:41:27 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93B038B7C
        for <linux-ext4@vger.kernel.org>; Sat, 11 Mar 2023 20:41:23 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 32C4fG8t031509
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 11 Mar 2023 23:41:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1678596078; bh=MUTFrTJV2TG1PRFQ5UV72VyZiWZbhttWsOcRl7qYvuo=;
        h=Date:From:To:Cc:Subject;
        b=fSsgTgMOLSRvblisQ50uGYd0giPA+5GY1xJ1NgtVAXyj4cguEg42JnMDD/zddz2CO
         L4blTxMaq0zeP7LT8Vs0P7MmQycMTxmVXgYYmvmIUQJ7jioNdAA/1QDkIbvDMjAGSR
         8G4nG0bnC5Yba141Fsu9kYts84xszbPyBoIiyf8jVnffS+yznAvCxuXnEToqrbI/J0
         naJdF6nEVzv9wJzGW9bSImxWvLjS/YF6cfL+syMWOyxyUGFBHsbxTgQ6XY5JLWPz4I
         2/TF7l+uCkVYaA8asQK6Mu/4uuFf8E/tcgOx1fUxDvJ4f042SRAo3jg4XbLeCzeYmc
         uUSiJQSmqnXyw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 3DBF215C45B9; Sat, 11 Mar 2023 23:41:16 -0500 (EST)
Date:   Sat, 11 Mar 2023 23:41:16 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [GIT PULL] ext4 fixes for 6.3-rc2
Message-ID: <20230312044116.GA2694785@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The following changes since commit e3645d72f8865ffe36f9dc811540d40aa3c848d3:

  ext4: fix incorrect options show of original mount_opt and extend mount_opt2 (2023-02-25 15:39:08 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable

for you to fetch changes up to f5361da1e60d54ec81346aee8e3d8baf1be0b762:

  ext4: zero i_disksize when initializing the bootloader inode (2023-03-11 00:44:24 -0500)

----------------------------------------------------------------
Bug fixes and regressions for ext4, the most serious of which is a
potential deadlock during directory renames that was introduced during
the merge window discovered by a combination of syzbot and lockdep.

----------------------------------------------------------------
Darrick J. Wong (1):
      ext4: fix another off-by-one fsmap error on 1k block filesystems

Eric Biggers (1):
      ext4: fix cgroup writeback accounting with fs-layer encryption

Eric Whitney (1):
      ext4: fix RENAME_WHITEOUT handling for inline directories

Jan Kara (1):
      ext4: Fix deadlock during directory rename

Theodore Ts'o (1):
      ext4, jbd2: add an optimized bmap for the journal inode

Thomas Weiﬂschuh (1):
      ext4: make kobj_type structures constant

Tudor Ambarus (1):
      ext4: Fix comment about the 64BIT feature

Wu Bo (1):
      docs: ext4: modify the group desc size to 64

Ye Bin (4):
      ext4: move where set the MAY_INLINE_DATA flag is set
      ext4: fix WARNING in ext4_update_inline_data
      ext4: commit super block if fs record error when journal record without error
      ext4: make sure fs error flag setted before clear journal error

Zhihao Cheng (1):
      ext4: zero i_disksize when initializing the bootloader inode

 Documentation/filesystems/ext4/blockgroup.rst |  6 +++---
 fs/ext4/ext4.h                                |  2 +-
 fs/ext4/fsmap.c                               |  2 ++
 fs/ext4/inline.c                              |  1 -
 fs/ext4/inode.c                               |  7 +++++-
 fs/ext4/ioctl.c                               |  1 +
 fs/ext4/namei.c                               | 39 +++++++++++++++++++++-------------
 fs/ext4/page-io.c                             | 11 +++++-----
 fs/ext4/super.c                               | 38 +++++++++++++++++++++++++++++++--
 fs/ext4/sysfs.c                               |  4 ++--
 fs/ext4/xattr.c                               |  3 +++
 fs/jbd2/journal.c                             |  9 +++++---
 include/linux/jbd2.h                          |  8 +++++++
 13 files changed, 98 insertions(+), 33 deletions(-)
