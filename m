Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4126A524F
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Feb 2023 05:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjB1EZf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 Feb 2023 23:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjB1EZe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 27 Feb 2023 23:25:34 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930D81F5C3
        for <linux-ext4@vger.kernel.org>; Mon, 27 Feb 2023 20:25:32 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 31S4PRsf013175
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Feb 2023 23:25:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1677558329; bh=Lp8Z5+z1Eqg0l7nzuxwWdkxw2feaaHoh3SzrVRHC6YU=;
        h=Date:From:To:Cc:Subject;
        b=QXA3m3M9rLBA5wd6ex9RB5StqnFnYBXDyEVjyQsH+HL05ZyG2CVgjcnYWbBCgZWQV
         4yegwXIHD9fsC8MRI/2oqOmgX2aCoMqXojYcYcGy8kd7TX+DAxMoJy7KLqJwezNU/G
         m/+uAQ2TMu4SW1Cc6jHqyog838FWfEoptZwzTY4v9/XsZfJRSEozMiHyh12v0q2VCR
         PJtHSllgLc/Jkn3h/ijQuKwv499fGtCtvMP61me6XGAate1lB7sjP0Ly9T6yHYMxEo
         k9jLmLYeusjox56i5eRpsrBXBco/jj9sXTBAHHjP/7J2VD081efPeUJmKt020goLYb
         zdGtE1p7t1kzA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 91B5F15C5823; Mon, 27 Feb 2023 23:25:27 -0500 (EST)
Date:   Mon, 27 Feb 2023 23:25:27 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ext4 changes for 6.3, part I
Message-ID: <Y/2CN+FpmGsfzgdE@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The following changes since commit 2241ab53cbb5cdb08a6b2d4688feb13971058f65:

  Linux 6.2-rc5 (2023-01-21 16:27:01 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus

for you to fetch changes up to e3645d72f8865ffe36f9dc811540d40aa3c848d3:

  ext4: fix incorrect options show of original mount_opt and extend mount_opt2 (2023-02-25 15:39:08 -0500)

----------------------------------------------------------------
Improve performance for ext4 by allowing multiple process to perform
direct I/O writes to preallocated blocks by using a shared inode lock
instead of taking an exclusive lock.

In addition, multiple bug fixes and cleanups.

----------------------------------------------------------------
Baokun Li (3):
      ext4: fail ext4_iget if special inode unallocated
      ext4: update s_journal_inum if it changes after journal replay
      ext4: fix task hung in ext4_xattr_delete_inode

Eric Biggers (1):
      ext4: use ext4_fc_tl_mem in fast-commit replay path

Jan Kara (1):
      ext4: Fix possible corruption when moving a directory

Jun Nie (2):
      ext4: optimize ea_inode block expansion
      ext4: refuse to create ea block when umounted

Kees Cook (1):
      ext4: fix function prototype mismatch for ext4_feat_ktype

Tanmay Bhushan (1):
      ext4: remove dead code in updating backup sb

Theodore Ts'o (1):
      ext4: improve xattr consistency checking and error reporting

Wang Jianjian (1):
      ext4: don't show commit interval if it is zero

XU pengfei (1):
      ext4: remove unnecessary variable initialization

Ye Bin (1):
      ext4: init error handle resource before init group descriptors

Zhang Yi (2):
      ext4: dio take shared inode lock when overwriting preallocated blocks
      ext4: fix incorrect options show of original mount_opt and extend mount_opt2

Zhihao Cheng (1):
      jbd2: fix data missing when reusing bh which is ready to be checkpointed

zhanchengbin (1):
      ext4: fix inode tree inconsistency caused by ENOMEM

 fs/ext4/ext4.h        |   1 +
 fs/ext4/extents.c     |   2 +-
 fs/ext4/fast_commit.c |  44 +++++++++++++++-----------
 fs/ext4/file.c        |  34 +++++++++++++-------
 fs/ext4/inode.c       |  20 ++++++------
 fs/ext4/ioctl.c       |   3 --
 fs/ext4/namei.c       |  11 ++++++-
 fs/ext4/super.c       |  56 +++++++++++++++++++-------------
 fs/ext4/sysfs.c       |   7 +++-
 fs/ext4/xattr.c       | 172 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------------
 fs/jbd2/transaction.c |  50 +++++++++++++++++------------
 11 files changed, 253 insertions(+), 147 deletions(-)
