Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 194CD1DCF46
	for <lists+linux-ext4@lfdr.de>; Thu, 21 May 2020 16:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729531AbgEUONX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 21 May 2020 10:13:23 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:42325 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726973AbgEUONX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 21 May 2020 10:13:23 -0400
Received: from callcc.thunk.org (pool-100-0-195-244.bstnma.fios.verizon.net [100.0.195.244])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 04LEChtF018113
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 May 2020 10:12:44 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 6527F420304; Thu, 21 May 2020 10:12:43 -0400 (EDT)
Date:   Thu, 21 May 2020 10:12:43 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-ext4@vger.kernel.org, Ritesh Harjani <riteshh@linux.ibm.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [GIT PULL] fixes for 5.7
Message-ID: <20200521141243.GA2942212@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The following changes since commit 0e698dfa282211e414076f9dc7e83c1c288314fd:

  Linux 5.7-rc4 (2020-05-03 14:56:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/fiemap-regression-fix

for you to fetch changes up to 959f7584512941a614113bfddb41b6812214169d:

  ext4: fix fiemap size checks for bitmap files (2020-05-19 15:03:37 -0400)

----------------------------------------------------------------
Fix regression in ext4's FIEMAP handling introduced in v5.7-rc1

----------------------------------------------------------------
Christoph Hellwig (1):
      ext4: fix fiemap size checks for bitmap files

Ritesh Harjani (1):
      ext4: fix EXT4_MAX_LOGICAL_BLOCK macro

 fs/ext4/ext4.h    |  2 +-
 fs/ext4/extents.c | 31 +++++++++++++++++++++++++++++++
 fs/ext4/ioctl.c   | 33 ++-------------------------------
 3 files changed, 34 insertions(+), 32 deletions(-)
