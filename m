Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBAB128E86
	for <lists+linux-ext4@lfdr.de>; Sun, 22 Dec 2019 15:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbfLVO0J (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 22 Dec 2019 09:26:09 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:44541 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725852AbfLVO0J (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 22 Dec 2019 09:26:09 -0500
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xBMEQ3AH013577
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 22 Dec 2019 09:26:04 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 7E9C1420822; Sun, 22 Dec 2019 09:26:03 -0500 (EST)
Date:   Sun, 22 Dec 2019 09:26:03 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [GIT PULL] ext4 fixes for 5.5-rc3
Message-ID: <20191222142603.GA357248@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


The following changes since commit dfdeeb41fb08fbe11d3cfefba9c0fcd00c95a36d:

  Merge branch 'tt/misc' into dev (2019-11-19 12:25:42 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable

for you to fetch changes up to 23f6b02405343103791c6a9533d73716cdf0c672:

  ext4: clarify impact of 'commit' mount option (2019-12-21 21:36:53 -0500)

----------------------------------------------------------------
Ext4 bug fixes (including a regression fix) for 5.5

----------------------------------------------------------------
Dan Carpenter (1):
      ext4: unlock on error in ext4_expand_extra_isize()

Jan Kara (3):
      ext4: fix ext4_empty_dir() for directories with holes
      ext4: check for directory entries too close to block end
      ext4: clarify impact of 'commit' mount option

Phong Tran (1):
      ext4: use RCU API in debug_print_tree

Randy Dunlap (1):
      jbd2: fix kernel-doc notation warning

Theodore Ts'o (2):
      ext4: optimize __ext4_check_dir_entry()
      ext4: validate the debug_want_extra_isize mount option at parse time

Yunfeng Ye (1):
      ext4: fix unused-but-set-variable warning in ext4_add_entry()

yangerkun (1):
      ext4: reserve revoke credits in __ext4_new_inode

 Documentation/admin-guide/ext4.rst |  19 +++++----
 fs/ext4/block_validity.c           |   6 ++-
 fs/ext4/dir.c                      |   6 ++-
 fs/ext4/ialloc.c                   |   4 +-
 fs/ext4/inode.c                    |   4 +-
 fs/ext4/namei.c                    |  36 +++++++++--------
 fs/ext4/super.c                    | 143 +++++++++++++++++++++++++++++++++-----------------------------------
 include/linux/jbd2.h               |   2 +-
 8 files changed, 116 insertions(+), 104 deletions(-)
