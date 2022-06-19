Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629395507B6
	for <lists+linux-ext4@lfdr.de>; Sun, 19 Jun 2022 02:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiFSAa5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 18 Jun 2022 20:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbiFSAa4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 18 Jun 2022 20:30:56 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401C6B482;
        Sat, 18 Jun 2022 17:30:54 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 25J0UnXF012112
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Jun 2022 20:30:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1655598651; bh=OpWQhaxI18E55DXpbcycgp3dTrJ631pLL69VZtGcPhc=;
        h=Date:From:To:Cc:Subject;
        b=NPX44t24cHMaAendlviGOKsNBvJ6YHwkF7lfXr9tzV4XEckWK1/jXUcszcXSGQbX5
         +SPqQO40+oeaOhVaJ+krz6Cau+unq6lC7weGUsjBZrz5UFp8H7srN0gvXQeu5+oqC6
         59/orNGQJi871SWC1aY5FM0InzUJZLjMV709Tf/pXPYZwrEZ7vPIjN048BJh/pFVCu
         Be1XaHyUahI+f3bmoAplfsTM7J8jS2DhYgvSlSuAq9A/Ke0NuMQYIwtqVZBcpbIKPk
         25KpNkYTEk5BGe3la9OfZGacNjXu7VTgrDd73HYL/qxNCgOk552V+DP98SuM6wfWTE
         R+Lh7aw4EaqJA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 64A3B15C430A; Sat, 18 Jun 2022 20:30:49 -0400 (EDT)
Date:   Sat, 18 Jun 2022 20:30:49 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ext4 fixes for 5.19-rc3
Message-ID: <Yq5uOVSUci3fv+Mw@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The following changes since commit b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3:

  Linux 5.19-rc2 (2022-06-12 16:11:37 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable

for you to fetch changes up to 1f3ddff3755915a2b38de92d53508594de432d3d:

  ext4: fix a doubled word "need" in a comment (2022-06-18 19:36:20 -0400)

----------------------------------------------------------------
Fix a variety of bugs, many of which were found by folks using fuzzing
or error injection.  Also fix up how test_dummy_encryption mount
option is handled for the new mount API.  Finally, fix/cleanup a
number of comments and ext4 Documentation files.

----------------------------------------------------------------
Baokun Li (2):
      ext4: fix bug_on ext4_mb_use_inode_pa
      ext4: correct the judgment of BUG in ext4_mb_normalize_request

Ding Xiang (1):
      ext4: make variable "count" signed

Eric Biggers (1):
      ext4: fix up test_dummy_encryption handling for new mount API

Jan Kara (1):
      ext4: improve write performance with disabled delalloc

Shuqi Zhang (1):
      ext4: use kmemdup() to replace kmalloc + memcpy

Wang Jianjian (2):
      ext4: fix incorrect comment in ext4_bio_write_page()
      ext4, doc: remove unnecessary escaping

Xiang wangx (1):
      ext4: fix a doubled word "need" in a comment

Yang Li (1):
      fs: fix jbd2_journal_try_to_free_buffers() kernel-doc comment

Ye Bin (1):
      ext4: fix super block checksum incorrect after mount

Zhang Yi (2):
      ext4: fix warning when submitting superblock in ext4_commit_super()
      ext4: add reserved GDT blocks check

 Documentation/filesystems/ext4/attributes.rst     |  68 +++---
 Documentation/filesystems/ext4/bigalloc.rst       |   2 +-
 Documentation/filesystems/ext4/bitmaps.rst        |   6 +-
 Documentation/filesystems/ext4/blockgroup.rst     |  30 +--
 Documentation/filesystems/ext4/blockmap.rst       |   2 +-
 Documentation/filesystems/ext4/checksums.rst      |  26 +--
 Documentation/filesystems/ext4/directory.rst      | 166 +++++++-------
 Documentation/filesystems/ext4/eainode.rst        |  10 +-
 Documentation/filesystems/ext4/group_descr.rst    | 126 +++++------
 Documentation/filesystems/ext4/ifork.rst          |  60 +++---
 Documentation/filesystems/ext4/inlinedata.rst     |   8 +-
 Documentation/filesystems/ext4/inodes.rst         | 306 +++++++++++++-------------
 Documentation/filesystems/ext4/journal.rst        | 214 +++++++++---------
 Documentation/filesystems/ext4/mmp.rst            |  36 ++--
 Documentation/filesystems/ext4/overview.rst       |   2 +-
 Documentation/filesystems/ext4/special_inodes.rst |   8 +-
 Documentation/filesystems/ext4/super.rst          | 550 +++++++++++++++++++++++------------------------
 fs/ext4/inode.c                                   |   2 +-
 fs/ext4/mballoc.c                                 |  26 ++-
 fs/ext4/migrate.c                                 |   2 +-
 fs/ext4/namei.c                                   |   3 +-
 fs/ext4/page-io.c                                 |   2 +-
 fs/ext4/resize.c                                  |  10 +
 fs/ext4/super.c                                   | 172 ++++++++-------
 fs/ext4/xattr.c                                   |   3 +-
 fs/jbd2/transaction.c                             |   2 +-
 26 files changed, 947 insertions(+), 895 deletions(-)
