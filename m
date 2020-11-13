Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 120842B152F
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Nov 2020 05:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgKME6w (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Nov 2020 23:58:52 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:37066 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726054AbgKME6w (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 12 Nov 2020 23:58:52 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0AD4wmdn023755
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Nov 2020 23:58:49 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 9B01A420107; Thu, 12 Nov 2020 23:58:48 -0500 (EST)
Date:   Thu, 12 Nov 2020 23:58:48 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] more ext4 fixes for v5.10-rc4
Message-ID: <20201113045848.GA3987678@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The following changes since commit 52d1998d09af92d44ffce7454637dd3fd1afdc7d:

  Merge tag 'fscrypt-for-linus' of git://git.kernel.org/pub/scm/fs/fscrypt/fscrypt (2020-11-10 10:05:37 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_bugfixes

for you to fetch changes up to d196e229a80c39254f4adbc312f55f5198e98941:

  Revert "ext4: fix superblock checksum calculation race" (2020-11-11 14:24:18 -0500)

----------------------------------------------------------------
Two ext4 bug fixes, one via a revert of a commit sent during the merge window.

----------------------------------------------------------------
Harshad Shirwadkar (1):
      ext4: handle dax mount option collision

Theodore Ts'o (1):
      Revert "ext4: fix superblock checksum calculation race"

 fs/ext4/ext4.h  |  6 +++---
 fs/ext4/super.c | 11 -----------
 2 files changed, 3 insertions(+), 14 deletions(-)
