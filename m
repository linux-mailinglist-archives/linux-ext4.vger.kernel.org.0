Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E34F326013
	for <lists+linux-ext4@lfdr.de>; Wed, 22 May 2019 11:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbfEVJD3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 22 May 2019 05:03:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:42782 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728536AbfEVJD3 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 22 May 2019 05:03:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 247D5B052;
        Wed, 22 May 2019 09:03:27 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 71C591E3C81; Wed, 22 May 2019 11:03:27 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 3/3] ext4: Gracefully handle ext4_break_layouts() failure during truncate
Date:   Wed, 22 May 2019 11:03:17 +0200
Message-Id: <20190522090317.28716-4-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190522090317.28716-1-jack@suse.cz>
References: <20190522090317.28716-1-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

ext4_break_layouts() may fail e.g. due to a signal being delivered.
Thus we need to handle its failure gracefully and not by taking the
filesystem down. Currently ext4_break_layouts() failure is rare but it
may become more common once RDMA uses layout leases for handling
long-term page pins for DAX mappings.

To handle the failure we need to move ext4_break_layouts() earlier
during setattr handling before we do hard to undo changes such as
modifying inode size. To be able to do that we also have to move some
other checks which are better done without holding i_mmap_sem earlier.

Reported-and-tested-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 60 ++++++++++++++++++++++++++++-----------------------------
 1 file changed, 29 insertions(+), 31 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index c7f77c643008..33411ba4546a 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5571,7 +5571,7 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
 	if (attr->ia_valid & ATTR_SIZE) {
 		handle_t *handle;
 		loff_t oldsize = inode->i_size;
-		int shrink = (attr->ia_size <= inode->i_size);
+		int shrink = (attr->ia_size < inode->i_size);
 
 		if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))) {
 			struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
@@ -5585,18 +5585,35 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
 		if (IS_I_VERSION(inode) && attr->ia_size != inode->i_size)
 			inode_inc_iversion(inode);
 
-		if (ext4_should_order_data(inode) &&
-		    (attr->ia_size < inode->i_size)) {
-			error = ext4_begin_ordered_truncate(inode,
+		if (shrink) {
+			if (ext4_should_order_data(inode)) {
+				error = ext4_begin_ordered_truncate(inode,
 							    attr->ia_size);
-			if (error)
-				goto err_out;
+				if (error)
+					goto err_out;
+			}
+			/*
+			 * Blocks are going to be removed from the inode. Wait
+			 * for dio in flight.
+			 */
+			inode_dio_wait(inode);
+		} else {
+			pagecache_isize_extended(inode, oldsize, inode->i_size);
 		}
+
+		down_write(&EXT4_I(inode)->i_mmap_sem);
+
+		rc = ext4_break_layouts(inode);
+		if (rc) {
+			up_write(&EXT4_I(inode)->i_mmap_sem);
+			return rc;
+		}
+
 		if (attr->ia_size != inode->i_size) {
 			handle = ext4_journal_start(inode, EXT4_HT_INODE, 3);
 			if (IS_ERR(handle)) {
 				error = PTR_ERR(handle);
-				goto err_out;
+				goto out_mmap_sem;
 			}
 			if (ext4_handle_valid(handle) && shrink) {
 				error = ext4_orphan_add(handle, inode);
@@ -5624,32 +5641,12 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
 				i_size_write(inode, attr->ia_size);
 			up_write(&EXT4_I(inode)->i_data_sem);
 			ext4_journal_stop(handle);
-			if (error) {
-				if (orphan && inode->i_nlink)
-					ext4_orphan_del(NULL, inode);
-				goto err_out;
-			}
-		}
-		if (!shrink) {
-			pagecache_isize_extended(inode, oldsize, inode->i_size);
-		} else {
-			/*
-			 * Blocks are going to be removed from the inode. Wait
-			 * for dio in flight.
-			 */
-			inode_dio_wait(inode);
-		}
-		if (orphan && ext4_should_journal_data(inode))
-			ext4_wait_for_tail_page_commit(inode);
-		down_write(&EXT4_I(inode)->i_mmap_sem);
-
-		rc = ext4_break_layouts(inode);
-		if (rc) {
-			up_write(&EXT4_I(inode)->i_mmap_sem);
-			error = rc;
-			goto err_out;
+			if (error)
+				goto out_mmap_sem;
 		}
 
+		if (shrink && ext4_should_journal_data(inode))
+			ext4_wait_for_tail_page_commit(inode);
 		/*
 		 * Truncate pagecache after we've waited for commit
 		 * in data=journal mode to make pages freeable.
@@ -5660,6 +5657,7 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
 			if (rc)
 				error = rc;
 		}
+out_mmap_sem:
 		up_write(&EXT4_I(inode)->i_mmap_sem);
 	}
 
-- 
2.16.4

