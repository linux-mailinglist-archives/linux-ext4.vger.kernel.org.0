Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC6E1BE897
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Apr 2020 22:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgD2Udl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Apr 2020 16:33:41 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:13796 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726481AbgD2Udk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 29 Apr 2020 16:33:40 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 29 Apr 2020 13:33:37 -0700
Received: from localhost.localdomain (ashwinh-vm-1.vmware.com [10.110.19.225])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id CBEEA40F33;
        Wed, 29 Apr 2020 13:33:36 -0700 (PDT)
From:   ashwin-h <ashwinh@vmware.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>
CC:     <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@kernel.org>, <srivatsab@vmware.com>,
        <srivatsa@csail.mit.edu>, <rostedt@goodmis.org>,
        <srostedt@vmware.com>, <gregkh@linuxfoundation.org>,
        <ashwin.hiranniah@gmail.com>, Ashwin H <ashwinh@vmware.com>
Subject: [PATCH 3/5] ext4: don't perform block validity checks on the journal inode
Date:   Thu, 30 Apr 2020 09:52:05 +0530
Message-ID: <dd3e2d975dc3c01cfa89466cea5a51a978826a8e.1588189373.git.ashwinh@vmware.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1588189373.git.ashwinh@vmware.com>
References: <cover.1588189373.git.ashwinh@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-001.vmware.com: ashwinh@vmware.com does not
 designate permitted sender hosts)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Theodore Ts'o <tytso@mit.edu>

commit 0a944e8a6c66ca04c7afbaa17e22bf208a8b37f0 upstream.

Since the journal inode is already checked when we added it to the
block validity's system zone, if we check it again, we'll just trigger
a failure.

This was causing failures like this:

[   53.897001] EXT4-fs error (device sda): ext4_find_extent:909: inode
#8: comm jbd2/sda-8: pblk 121667583 bad header/extent: invalid extent entries - magic f30a, entries 8, max 340(340), depth 0(0)
[   53.931430] jbd2_journal_bmap: journal block not found at offset 49 on sda-8
[   53.938480] Aborting journal on device sda-8.

... but only if the system was under enough memory pressure that
logical->physical mapping for the journal inode gets pushed out of the
extent cache.  (This is why it wasn't noticed earlier.)

Fixes: 345c0dbf3a30 ("ext4: protect journal inode's blocks using block_validity")
Reported-by: Dan Rue <dan.rue@linaro.org>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Ashwin H <ashwinh@vmware.com>
---
 fs/ext4/extents.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index fa6ae90..100eb91 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -530,10 +530,14 @@ __read_extent_tree_block(const char *function, unsigned int line,
 	}
 	if (buffer_verified(bh) && !(flags & EXT4_EX_FORCE_CACHE))
 		return bh;
-	err = __ext4_ext_check(function, line, inode,
-			       ext_block_hdr(bh), depth, pblk);
-	if (err)
-		goto errout;
+	if (!ext4_has_feature_journal(inode->i_sb) ||
+	    (inode->i_ino !=
+	     le32_to_cpu(EXT4_SB(inode->i_sb)->s_es->s_journal_inum))) {
+		err = __ext4_ext_check(function, line, inode,
+				       ext_block_hdr(bh), depth, pblk);
+		if (err)
+			goto errout;
+	}
 	set_buffer_verified(bh);
 	/*
 	 * If this is a leaf block, cache all of its entries
-- 
2.7.4

