Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A92B22754
	for <lists+linux-ext4@lfdr.de>; Sun, 19 May 2019 18:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725784AbfESQ5T (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 19 May 2019 12:57:19 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:48618 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725769AbfESQ5T (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 19 May 2019 12:57:19 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x4J5x94A021513
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 19 May 2019 01:59:10 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 77C90420027; Sun, 19 May 2019 01:58:48 -0400 (EDT)
Date:   Sun, 19 May 2019 01:58:48 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     torvalds@linux-foundation.org
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ext4 fixes for 5.1-rc1
Message-ID: <20190519055848.GA16693@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        torvalds@linux-foundation.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The following changes since commit db90f41916cf04c020062f8d8b0385942248283e:

  ext4: export /sys/fs/ext4/feature/casefold if Unicode support is present (2019-05-06 14:03:52 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable

for you to fetch changes up to 2c1d0e3631e5732dba98ef49ac0bec1388776793:

  ext4: avoid panic during forced reboot due to aborted journal (2019-05-17 17:37:18 -0400)

----------------------------------------------------------------
Some bug fixes, and an update to the URL's for the final version of
Unicode 12.1.0.

----------------------------------------------------------------
Chengguang Xu (1):
      jbd2: fix potential double free

Colin Ian King (1):
      ext4: unsigned int compared against zero

Jan Kara (1):
      ext4: avoid panic during forced reboot due to aborted journal

Lukas Czerner (1):
      ext4: fix data corruption caused by overlapping unaligned and aligned IO

Sahitya Tummala (1):
      ext4: fix use-after-free in dx_release()

Sriram Rajagopalan (1):
      ext4: zero out the unused memory region in the extent tree block

Theodore Ts'o (4):
      ext4: fix miscellaneous sparse warnings
      unicode: add missing check for an error return from utf8lookup()
      unicode: update to Unicode 12.1.0 final
      ext4: fix block validity checks for journal inodes using indirect blocks

 fs/ext4/block_validity.c   |  8 +++++++-
 fs/ext4/extents.c          | 17 +++++++++++++++--
 fs/ext4/file.c             |  7 +++++++
 fs/ext4/fsmap.c            |  2 +-
 fs/ext4/ioctl.c            |  2 +-
 fs/ext4/namei.c            |  5 ++++-
 fs/ext4/super.c            |  4 ++--
 fs/jbd2/journal.c          | 49 +++++++++++++++++++++++++++++++------------------
 fs/jbd2/revoke.c           | 32 ++++++++++++++++++++------------
 fs/jbd2/transaction.c      |  8 +++++---
 fs/unicode/README.utf8data | 28 +++++++---------------------
 fs/unicode/utf8-norm.c     |  2 ++
 include/linux/jbd2.h       |  8 +++++---
 13 files changed, 107 insertions(+), 65 deletions(-)
