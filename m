Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDB95175087
	for <lists+linux-ext4@lfdr.de>; Sun,  1 Mar 2020 23:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgCAWHM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 1 Mar 2020 17:07:12 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56881 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726050AbgCAWHL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 1 Mar 2020 17:07:11 -0500
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 021M78Ha029007
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 1 Mar 2020 17:07:08 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 355AB42045B; Sun,  1 Mar 2020 17:07:08 -0500 (EST)
Date:   Sun, 1 Mar 2020 17:07:08 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [GIT PULL] more ext4 bug fixes for 5.6
Message-ID: <20200301220708.GA91502@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The following changes since commit f8788d86ab28f61f7b46eb6be375f8a726783636:

  Linux 5.6-rc3 (2020-02-23 16:17:42 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable

for you to fetch changes up to 37b0b6b8b99c0e1c1f11abbe7cf49b6d03795b3f:

  ext4: potential crash on allocation error in ext4_alloc_flex_bg_array() (2020-02-29 17:48:08 -0500)

----------------------------------------------------------------
Two more bug fixes (including a regression) for 5.6

----------------------------------------------------------------
Dan Carpenter (1):
      ext4: potential crash on allocation error in ext4_alloc_flex_bg_array()

Qian Cai (1):
      jbd2: fix data races at struct journal_head

 fs/ext4/super.c       | 6 +++---
 fs/jbd2/transaction.c | 8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)
