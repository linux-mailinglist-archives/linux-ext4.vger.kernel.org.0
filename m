Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 658CA160175
	for <lists+linux-ext4@lfdr.de>; Sun, 16 Feb 2020 03:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgBPC62 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 15 Feb 2020 21:58:28 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:60767 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726533AbgBPC62 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 15 Feb 2020 21:58:28 -0500
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 01G2wNRn028608
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 15 Feb 2020 21:58:23 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id EAF2842032C; Sat, 15 Feb 2020 21:58:22 -0500 (EST)
Date:   Sat, 15 Feb 2020 21:58:22 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     torvalds@linux-foundation.org
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ext4 bug fixes for 5.6-rc2
Message-ID: <20200216025822.GA721338@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The following changes since commit e5da4c933c50d98d7990a7c1ca0bbf8946e80c4a:

  Merge tag 'ext4_for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4 (2020-01-30 15:17:05 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable

for you to fetch changes up to d65d87a07476aa17df2dcb3ad18c22c154315bec:

  ext4: improve explanation of a mount failure caused by a misconfigured kernel (2020-02-15 09:53:45 -0500)

----------------------------------------------------------------
Miscellaneous ext4 bug fixes (all stable fodder)

----------------------------------------------------------------
Andreas Dilger (1):
      ext4: don't assume that mmp_nodename/bdevname have NUL

Jan Kara (2):
      ext4: simplify checking quota limits in ext4_statfs()
      ext4: fix checksum errors with indexed dirs

Shijie Luo (1):
      ext4: add cond_resched() to ext4_protect_reserved_inode

Theodore Ts'o (2):
      ext4: fix support for inode sizes > 1024 bytes
      ext4: improve explanation of a mount failure caused by a misconfigured kernel

zhangyi (F) (2):
      jbd2: move the clearing of b_modified flag to the journal_unmap_buffer()
      jbd2: do not clear the BH_Mapped flag when forgetting a metadata buffer

 fs/ext4/block_validity.c |  1 +
 fs/ext4/dir.c            | 14 ++++++++------
 fs/ext4/ext4.h           |  5 ++++-
 fs/ext4/inode.c          | 12 ++++++++++++
 fs/ext4/mmp.c            | 12 +++++++-----
 fs/ext4/namei.c          |  7 +++++++
 fs/ext4/super.c          | 42 ++++++++++++++++--------------------------
 fs/jbd2/commit.c         | 46 +++++++++++++++++++++++++---------------------
 fs/jbd2/transaction.c    | 10 ++++++----
 9 files changed, 86 insertions(+), 63 deletions(-)
