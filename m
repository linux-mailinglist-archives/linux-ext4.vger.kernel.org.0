Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE86218C57F
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Mar 2020 03:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgCTCxQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Mar 2020 22:53:16 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:50031 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725856AbgCTCxQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Mar 2020 22:53:16 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 02K2r1gl016094
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Mar 2020 22:53:02 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id C18CD420EBB; Thu, 19 Mar 2020 22:53:01 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 2/2] writeback, xfs: call dirty_inode() with I_DIRTY_TIME_EXPIRED when appropriate
Date:   Thu, 19 Mar 2020 22:52:55 -0400
Message-Id: <20200320025255.1705972-2-tytso@mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200320025255.1705972-1-tytso@mit.edu>
References: <20200320024639.GH1067245@mit.edu>
 <20200320025255.1705972-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Use the flag I_DIRTY_TIME_EXPIRED passed to dirty_inode() to signal to
the file system that it is time to flush the inode's timestamps to
stable storage.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/fs-writeback.c  | 2 +-
 fs/xfs/xfs_super.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 867454997c9d..32101349ba97 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1506,7 +1506,7 @@ __writeback_single_inode(struct inode *inode, struct writeback_control *wbc)
 
 	/* This was a lazytime expiration; we need to tell the file system */
 	if (dirty & I_DIRTY_TIME_EXPIRED && inode->i_sb->s_op->dirty_inode)
-		inode->i_sb->s_op->dirty_inode(inode, I_DIRTY_SYNC);
+		inode->i_sb->s_op->dirty_inode(inode, I_DIRTY_TIME_EXPIRED);
 	/* Don't write the inode if only I_DIRTY_PAGES was set */
 	if (dirty & ~I_DIRTY_PAGES) {
 		int err = write_inode(inode, wbc);
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 2094386af8ac..f27b9b205f81 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -622,7 +622,8 @@ xfs_fs_dirty_inode(
 
 	if (!(inode->i_sb->s_flags & SB_LAZYTIME))
 		return;
-	if (flag != I_DIRTY_SYNC || !(inode->i_state & I_DIRTY_TIME))
+	if ((flag != I_DIRTY_SYNC && flag != I_DIRTY_TIME_EXPIRED) ||
+	    !(inode->i_state & I_DIRTY_TIME))
 		return;
 
 	if (xfs_trans_alloc(mp, &M_RES(mp)->tr_fsyncts, 0, 0, 0, &tp))
-- 
2.24.1

