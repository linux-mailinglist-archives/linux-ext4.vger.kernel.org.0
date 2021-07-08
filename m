Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F6B3C1A86
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Jul 2021 22:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbhGHUaB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Jul 2021 16:30:01 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:42028 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230238AbhGHUaA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Jul 2021 16:30:00 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 168KRElU028290
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Jul 2021 16:27:14 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 2756A15C3DBB; Thu,  8 Jul 2021 16:27:14 -0400 (EDT)
Date:   Thu, 8 Jul 2021 16:27:14 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [GIT PULL] ext4 fixes for v5.14-rc1
Message-ID: <YOdfoq/0eBHtjTht@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The following changes since commit 16aa4c9a1fbe763c147a964cdc1f5be8ed98ed13:

  jbd2: export jbd2_journal_[un]register_shrinker() (2021-06-30 11:05:00 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable

for you to fetch changes up to 0705e8d1e2207ceeb83dc6e1751b6b82718b353a:

  ext4: inline jbd2_journal_[un]register_shrinker() (2021-07-08 08:37:31 -0400)

----------------------------------------------------------------
Ext4 regression and bug fixes for v5.14-rc1

----------------------------------------------------------------
Stephen Brennan (1):
      ext4: use ext4_grp_locked_error in mb_find_extent

Theodore Ts'o (4):
      Revert "ext4: consolidate checks for resize of bigalloc into ext4_resize_begin"
      ext4: fix possible UAF when remounting r/o a mmp-protected file system
      ext4: fix flags validity checking for EXT4_IOC_CHECKPOINT
      ext4: inline jbd2_journal_[un]register_shrinker()

Ye Bin (1):
      ext4: fix WARN_ON_ONCE(!buffer_uptodate) after an error writing the superblock

 fs/ext4/ext4_jbd2.c  |   2 +-
 fs/ext4/ioctl.c      |  16 ++++++-
 fs/ext4/mballoc.c    |   9 ++--
 fs/ext4/mmp.c        |  31 ++++++-------
 fs/ext4/resize.c     |   4 --
 fs/ext4/super.c      |  26 ++++++-----
 fs/jbd2/checkpoint.c |   4 +-
 fs/jbd2/journal.c    | 149 ++++++++++++++++++++++++-----------------------------------
 include/linux/jbd2.h |   6 +--
 9 files changed, 115 insertions(+), 132 deletions(-)
