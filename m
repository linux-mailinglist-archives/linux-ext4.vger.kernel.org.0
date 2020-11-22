Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2962BC85C
	for <lists+linux-ext4@lfdr.de>; Sun, 22 Nov 2020 20:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbgKVTHq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 22 Nov 2020 14:07:46 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57428 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727888AbgKVTHq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 22 Nov 2020 14:07:46 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0AMJ7hJt030622
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 22 Nov 2020 14:07:44 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 507D3420136; Sun, 22 Nov 2020 14:07:43 -0500 (EST)
Date:   Sun, 22 Nov 2020 14:07:43 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ext4 bug fixes for 5.10-rc
Message-ID: <20201122190743.GA198093@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The following changes since commit 09162bc32c880a791c6c0668ce0745cf7958f576:

  Linux 5.10-rc4 (2020-11-15 16:44:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_fixes2

for you to fetch changes up to f902b216501094495ff75834035656e8119c537f:

  ext4: fix bogus warning in ext4_update_dx_flag() (2020-11-19 22:41:10 -0500)

----------------------------------------------------------------
A final set of miscellaneous bug fixes for ext4

----------------------------------------------------------------
Jan Kara (1):
      ext4: fix bogus warning in ext4_update_dx_flag()

Mauro Carvalho Chehab (1):
      jbd2: fix kernel-doc markups

Theodore Ts'o (1):
      ext4: drop fast_commit from /proc/mounts

 fs/ext4/ext4.h        |  3 ++-
 fs/ext4/super.c       |  4 ----
 fs/jbd2/journal.c     | 34 ++++++++++++++++++----------------
 fs/jbd2/transaction.c | 31 ++++++++++++++++---------------
 include/linux/jbd2.h  |  2 +-
 5 files changed, 37 insertions(+), 37 deletions(-)
