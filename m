Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6084AAFF2
	for <lists+linux-ext4@lfdr.de>; Sun,  6 Feb 2022 15:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240690AbiBFO30 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 6 Feb 2022 09:29:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbiBFO3Z (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 6 Feb 2022 09:29:25 -0500
X-Greylist: delayed 122 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 06:29:23 PST
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4549C06173B;
        Sun,  6 Feb 2022 06:29:23 -0800 (PST)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 216ERGDR006394
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 6 Feb 2022 09:27:17 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 88FFE15C0040; Sun,  6 Feb 2022 09:27:16 -0500 (EST)
Date:   Sun, 6 Feb 2022 09:27:16 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [GIT PULL] ext4 fixes for v5.17-rc3
Message-ID: <Yf/axKTEyQQM1mfm@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The following changes since commit 6eeaf88fd586f05aaf1d48cb3a139d2a5c6eb055:

  ext4: don't use the orphan list when migrating an inode (2022-01-10 13:25:56 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable

for you to fetch changes up to f340b3d9027485945d59f9c04f1e33070b02cae2:

  fs/ext4: fix comments mentioning i_mutex (2022-02-03 10:57:53 -0500)

----------------------------------------------------------------
Various bug fixes for ext4 fast commit and inline data handling.  Also
fix regression introduced as part of moving to the new mount API.

----------------------------------------------------------------
Lukas Czerner (1):
      ext4: fix potential NULL pointer dereference in ext4_fill_super()

Ritesh Harjani (5):
      ext4: fix error handling in ext4_restore_inline_data()
      ext4: remove redundant max inline_size check in ext4_da_write_inline_data_begin()
      ext4: fix error handling in ext4_fc_record_modified_inode()
      jbd2: cleanup unused functions declarations from jbd2.h
      jbd2: refactor wait logic for transaction updates into a common function

Xin Yin (5):
      ext4: prevent used blocks from being allocated during fast commit replay
      ext4: modify the logic of ext4_mb_new_blocks_simple
      ext4: fast commit may not fallback for ineligible commit
      ext4: fast commit may miss file actions
      ext4: fix incorrect type issue during replay_del_range

Yang Li (1):
      jbd2: fix kernel-doc descriptions for jbd2_journal_shrink_{scan,count}()

hongnanli (1):
      fs/ext4: fix comments mentioning i_mutex

 fs/ext4/acl.c         |   8 ++--
 fs/ext4/ext4.h        |  17 ++++----
 fs/ext4/ext4_jbd2.h   |   2 +-
 fs/ext4/extents.c     |  16 ++++---
 fs/ext4/fast_commit.c | 133 +++++++++++++++++++++++++++++++++-----------------------
 fs/ext4/indirect.c    |   2 +-
 fs/ext4/inline.c      |  23 +++++-----
 fs/ext4/inode.c       |  12 ++---
 fs/ext4/ioctl.c       |   4 +-
 fs/ext4/mballoc.c     |  26 +++++++----
 fs/ext4/migrate.c     |   2 +-
 fs/ext4/namei.c       |   4 +-
 fs/ext4/orphan.c      |   4 +-
 fs/ext4/super.c       |   4 +-
 fs/ext4/xattr.c       |   6 +--
 fs/jbd2/commit.c      |  21 ++-------
 fs/jbd2/journal.c     |   6 ++-
 fs/jbd2/transaction.c |  53 +++++++++++++---------
 include/linux/jbd2.h  |  13 ++----
 19 files changed, 196 insertions(+), 160 deletions(-)
