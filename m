Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2926F16C042
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Feb 2020 13:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730385AbgBYMIH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 25 Feb 2020 07:08:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:42428 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729390AbgBYMIH (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 25 Feb 2020 07:08:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DC428AFBF;
        Tue, 25 Feb 2020 12:08:05 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 491951E0EA2; Tue, 25 Feb 2020 13:08:05 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-ext4@vger.kernel.org>
Cc:     "J. R. Okajima" <hooanon05g@gmail.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH v2] ext2: Silence lockdep warning about reclaim under xattr_sem
Date:   Tue, 25 Feb 2020 13:08:03 +0100
Message-Id: <20200225120803.7901-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Lockdep complains about a chain:
  sb_internal#2 --> &ei->xattr_sem#2 --> fs_reclaim

and shrink_dentry_list -> ext2_evict_inode -> ext2_xattr_delete_inode ->
down_write(ei->xattr_sem) creating a locking cycle in the reclaim path.
This is however a false positive because when we are in
ext2_evict_inode() we are the only holder of the inode reference and
nobody else should touch xattr_sem of that inode. So we cannot ever
block on acquiring the xattr_sem in the reclaim path.

Silence the lockdep warning by using down_write_trylock() in
ext2_xattr_delete_inode() to not create false locking dependency.

Reported-by: "J. R. Okajima" <hooanon05g@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext2/xattr.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

Changes since v1:
- changed WARN_ON to WARN_ON_ONCE

diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
index 0456bc990b5e..9ad07c7ef0b3 100644
--- a/fs/ext2/xattr.c
+++ b/fs/ext2/xattr.c
@@ -790,7 +790,15 @@ ext2_xattr_delete_inode(struct inode *inode)
 	struct buffer_head *bh = NULL;
 	struct ext2_sb_info *sbi = EXT2_SB(inode->i_sb);
 
-	down_write(&EXT2_I(inode)->xattr_sem);
+	/*
+	 * We are the only ones holding inode reference. The xattr_sem should
+	 * better be unlocked! We could as well just not acquire xattr_sem at
+	 * all but this makes the code more futureproof. OTOH we need trylock
+	 * here to avoid false-positive warning from lockdep about reclaim
+	 * circular dependency.
+	 */
+	if (WARN_ON_ONCE(!down_write_trylock(&EXT2_I(inode)->xattr_sem)))
+		return;
 	if (!EXT2_I(inode)->i_file_acl)
 		goto cleanup;
 
-- 
2.16.4

