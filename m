Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA54C2A717
	for <lists+linux-ext4@lfdr.de>; Sat, 25 May 2019 23:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbfEYVHU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 25 May 2019 17:07:20 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:38253 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725951AbfEYVHT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 25 May 2019 17:07:19 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x4PL7FQ7012105
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 May 2019 17:07:15 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id ED30F420481; Sat, 25 May 2019 17:07:14 -0400 (EDT)
Date:   Sat, 25 May 2019 17:07:14 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [GIT PULL] ext4 fixes for 5.2-rc2
Message-ID: <20190525210714.GA18163@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The following changes since commit 2c1d0e3631e5732dba98ef49ac0bec1388776793:

  ext4: avoid panic during forced reboot due to aborted journal (2019-05-17 17:37:18 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable

for you to fetch changes up to 66883da1eee8ad4b38eeff7fa1c86a097d9670fc:

  ext4: fix dcache lookup of !casefolded directories (2019-05-24 23:48:23 -0400)

----------------------------------------------------------------
Bug fixes (including a regression fix) for ext4.

----------------------------------------------------------------
Gabriel Krisman Bertazi (1):
      ext4: fix dcache lookup of !casefolded directories

Jan Kara (2):
      ext4: wait for outstanding dio during truncate in nojournal mode
      ext4: do not delete unlinked inode from orphan list on failed truncate

Theodore Ts'o (1):
      ext4: don't perform block validity checks on the journal inode

 fs/ext4/dir.c     |  2 +-
 fs/ext4/extents.c | 12 ++++++++----
 fs/ext4/inode.c   | 23 ++++++++++-------------
 3 files changed, 19 insertions(+), 18 deletions(-)
