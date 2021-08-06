Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84BAE3E2ED5
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Aug 2021 19:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241061AbhHFRTI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 6 Aug 2021 13:19:08 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:34326 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S241053AbhHFRTI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 6 Aug 2021 13:19:08 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 176HImi1009575
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 6 Aug 2021 13:18:48 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 4334F15C3E1B; Fri,  6 Aug 2021 13:18:48 -0400 (EDT)
Date:   Fri, 6 Aug 2021 13:18:48 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [GIT PULL] ext4 fixes for v5.14-rc5
Message-ID: <YQ1u+Acar/N3aUpm@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The following changes since commit 2734d6c1b1a089fb593ef6a23d4b70903526fe0c:

  Linux 5.14-rc2 (2021-07-18 14:13:49 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable

for you to fetch changes up to 877ba3f729fd3d8ef0e29bc2a55e57cfa54b2e43:

  ext4: fix potential htree corruption when growing large_dir directories (2021-08-06 13:00:49 -0400)

----------------------------------------------------------------
A Regression fix, bug fix, and a comment cleanup for ext4.

----------------------------------------------------------------
Guoqing Jiang (1):
      ext4: remove conflicting comment from __ext4_forget

Theodore Ts'o (1):
      ext4: fix potential htree corruption when growing large_dir directories

Ye Bin (1):
      ext4: fix potential uninitialized access to retval in kmmpd

 fs/ext4/ext4_jbd2.c | 3 ---
 fs/ext4/mmp.c       | 2 +-
 fs/ext4/namei.c     | 2 +-
 3 files changed, 2 insertions(+), 5 deletions(-)
