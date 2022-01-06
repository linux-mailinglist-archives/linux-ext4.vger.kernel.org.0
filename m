Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 778F448600F
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Jan 2022 06:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiAFFFO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 Jan 2022 00:05:14 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:41760 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229585AbiAFFFO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 Jan 2022 00:05:14 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 206557th009110
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Jan 2022 00:05:08 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 7FFDF15C00E1; Thu,  6 Jan 2022 00:05:07 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     lczerner@redhat.com, jack@suse.cz, "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] ext4: don't use the orphan list when migrating an inode
Date:   Thu,  6 Jan 2022 00:05:05 -0500
Message-Id: <20220106050505.474719-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

We probably want to remove the indirect block to extents migration
feature after a deprecation window, but until then, let's fix a
potential data loss problem caused by the fact that we put the
tmp_inode on the orphan list.  In the unlikely case where we crash and
do a journal recovery, the data blocks belonging to the inode inode
being migrated are also represented in the tmp_inode on the orphan
list --- and so its data blocks will get marked unallocated, and
available for reuse.

Instead, we stop putting the tmp_inode on the oprhan list.  So in the
case where we crash while migrating the inode, we'll leak an inode,
which is not a disaster.  It will be easily fixed the next time we run
fsck, and it's better than potentially having blocks getting claimed
by two different files, and losing data as a result.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/migrate.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/fs/ext4/migrate.c b/fs/ext4/migrate.c
index 36dfc88ce05b..ff8916e1d38e 100644
--- a/fs/ext4/migrate.c
+++ b/fs/ext4/migrate.c
@@ -437,12 +437,12 @@ int ext4_ext_migrate(struct inode *inode)
 	percpu_down_write(&sbi->s_writepages_rwsem);
 
 	/*
-	 * Worst case we can touch the allocation bitmaps, a bgd
-	 * block, and a block to link in the orphan list.  We do need
-	 * need to worry about credits for modifying the quota inode.
+	 * Worst case we can touch the allocation bitmaps and a block
+	 * group descriptor block.  We do need need to worry about
+	 * credits for modifying the quota inode.
 	 */
 	handle = ext4_journal_start(inode, EXT4_HT_MIGRATE,
-		4 + EXT4_MAXQUOTAS_TRANS_BLOCKS(inode->i_sb));
+		3 + EXT4_MAXQUOTAS_TRANS_BLOCKS(inode->i_sb));
 
 	if (IS_ERR(handle)) {
 		retval = PTR_ERR(handle);
@@ -463,10 +463,6 @@ int ext4_ext_migrate(struct inode *inode)
 	 * Use the correct seed for checksum (i.e. the seed from 'inode').  This
 	 * is so that the metadata blocks will have the correct checksum after
 	 * the migration.
-	 *
-	 * Note however that, if a crash occurs during the migration process,
-	 * the recovery process is broken because the tmp_inode checksums will
-	 * be wrong and the orphans cleanup will fail.
 	 */
 	ei = EXT4_I(inode);
 	EXT4_I(tmp_inode)->i_csum_seed = ei->i_csum_seed;
@@ -478,7 +474,6 @@ int ext4_ext_migrate(struct inode *inode)
 	clear_nlink(tmp_inode);
 
 	ext4_ext_tree_init(handle, tmp_inode);
-	ext4_orphan_add(handle, tmp_inode);
 	ext4_journal_stop(handle);
 
 	/*
@@ -503,12 +498,6 @@ int ext4_ext_migrate(struct inode *inode)
 
 	handle = ext4_journal_start(inode, EXT4_HT_MIGRATE, 1);
 	if (IS_ERR(handle)) {
-		/*
-		 * It is impossible to update on-disk structures without
-		 * a handle, so just rollback in-core changes and live other
-		 * work to orphan_list_cleanup()
-		 */
-		ext4_orphan_del(NULL, tmp_inode);
 		retval = PTR_ERR(handle);
 		goto out_tmp_inode;
 	}
-- 
2.31.0

