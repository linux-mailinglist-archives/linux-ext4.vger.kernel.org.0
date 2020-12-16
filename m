Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5605B2DBE87
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Dec 2020 11:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgLPKUO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Dec 2020 05:20:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:49054 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbgLPKUN (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 16 Dec 2020 05:20:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8429AAF2F;
        Wed, 16 Dec 2020 10:18:50 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E41911E136A; Wed, 16 Dec 2020 11:18:49 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        harshad shirwadkar <harshadshirwadkar@gmail.com>,
        Jan Kara <jack@suse.cz>, stable@vger.kernel.org,
        Tahsin Erdogan <tahsin@google.com>
Subject: [PATCH 6/8] ext4: Fix deadlock with fs freezing and EA inodes
Date:   Wed, 16 Dec 2020 11:18:42 +0100
Message-Id: <20201216101844.22917-7-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20201216101844.22917-1-jack@suse.cz>
References: <20201216101844.22917-1-jack@suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Xattr code using inodes with large xattr data can end up dropping last
inode reference (and thus deleting the inode) from places like
ext4_xattr_set_entry(). That function is called with transaction started
and so ext4_evict_inode() can deadlock against fs freezing like:

CPU1					CPU2

removexattr()				freeze_super()
  vfs_removexattr()
    ext4_xattr_set()
      handle = ext4_journal_start()
      ...
      ext4_xattr_set_entry()
        iput(old_ea_inode)
          ext4_evict_inode(old_ea_inode)
					  sb->s_writers.frozen = SB_FREEZE_FS;
					  sb_wait_write(sb, SB_FREEZE_FS);
					  ext4_freeze()
					    jbd2_journal_lock_updates()
					      -> blocks waiting for all
					         handles to stop
            sb_start_intwrite()
	      -> blocks as sb is already in SB_FREEZE_FS state

Generally it is advisable to delete inodes from a separate transaction
as it can consume quite some credits however in this case it would be
quite clumsy and furthermore the credits for inode deletion are quite
limited and already accounted for. So just tweak ext4_evict_inode() to
avoid freeze protection if we have transaction already started and thus
it is not really needed anyway.

CC: stable@vger.kernel.org
Fixes: dec214d00e0d ("ext4: xattr inode deduplication")
CC: Tahsin Erdogan <tahsin@google.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 72534319fae5..777eb08b29cd 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -175,6 +175,7 @@ void ext4_evict_inode(struct inode *inode)
 	 */
 	int extra_credits = 6;
 	struct ext4_xattr_inode_array *ea_inode_array = NULL;
+	bool freeze_protected = false;
 
 	trace_ext4_evict_inode(inode);
 
@@ -232,9 +233,14 @@ void ext4_evict_inode(struct inode *inode)
 
 	/*
 	 * Protect us against freezing - iput() caller didn't have to have any
-	 * protection against it
+	 * protection against it. When we are in a running transaction though,
+	 * we are already protected against freezing and we cannot grab further
+	 * protection due to lock ordering constraints.
 	 */
-	sb_start_intwrite(inode->i_sb);
+	if (!ext4_journal_current_handle()) {
+		sb_start_intwrite(inode->i_sb);
+		freeze_protected = true;
+	}
 
 	if (!IS_NOQUOTA(inode))
 		extra_credits += EXT4_MAXQUOTAS_DEL_BLOCKS(inode->i_sb);
@@ -253,7 +259,8 @@ void ext4_evict_inode(struct inode *inode)
 		 * cleaned up.
 		 */
 		ext4_orphan_del(NULL, inode);
-		sb_end_intwrite(inode->i_sb);
+		if (freeze_protected)
+			sb_end_intwrite(inode->i_sb);
 		goto no_delete;
 	}
 
@@ -294,7 +301,8 @@ void ext4_evict_inode(struct inode *inode)
 stop_handle:
 		ext4_journal_stop(handle);
 		ext4_orphan_del(NULL, inode);
-		sb_end_intwrite(inode->i_sb);
+		if (freeze_protected)
+			sb_end_intwrite(inode->i_sb);
 		ext4_xattr_inode_array_free(ea_inode_array);
 		goto no_delete;
 	}
@@ -323,7 +331,8 @@ void ext4_evict_inode(struct inode *inode)
 	else
 		ext4_free_inode(handle, inode);
 	ext4_journal_stop(handle);
-	sb_end_intwrite(inode->i_sb);
+	if (freeze_protected)
+		sb_end_intwrite(inode->i_sb);
 	ext4_xattr_inode_array_free(ea_inode_array);
 	return;
 no_delete:
-- 
2.16.4

