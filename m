Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58C86495A48
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Jan 2022 08:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378762AbiAUHGO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 21 Jan 2022 02:06:14 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:46156 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233755AbiAUHGN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 21 Jan 2022 02:06:13 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=hongnan.li@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0V2QTrBf_1642748771;
Received: from localhost(mailfrom:hongnan.li@linux.alibaba.com fp:SMTPD_---0V2QTrBf_1642748771)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 21 Jan 2022 15:06:11 +0800
From:   hongnanli <hongnan.li@linux.alibaba.com>
To:     linux-ext4@vger.kernel.org
Cc:     adilger.kernel@dilger.ca, tytso@mit.edu
Subject: [PATCH] fs/ext4: fix comments mentioning i_mutex
Date:   Fri, 21 Jan 2022 15:06:11 +0800
Message-Id: <20220121070611.21618-1-hongnan.li@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

inode->i_mutex has been replaced with inode->i_rwsem long ago. Fix
comments still mentioning i_mutex.

Signed-off-by: hongnanli <hongnan.li@linux.alibaba.com>
---
 fs/ext4/acl.c       | 8 ++++----
 fs/ext4/ext4.h      | 6 +++---
 fs/ext4/ext4_jbd2.h | 2 +-
 fs/ext4/extents.c   | 8 ++++----
 fs/ext4/indirect.c  | 2 +-
 fs/ext4/inode.c     | 8 ++++----
 fs/ext4/migrate.c   | 2 +-
 fs/ext4/orphan.c    | 4 ++--
 8 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/fs/ext4/acl.c b/fs/ext4/acl.c
index 5a35768d6149..57e82e25f8e2 100644
--- a/fs/ext4/acl.c
+++ b/fs/ext4/acl.c
@@ -139,7 +139,7 @@ ext4_acl_to_disk(const struct posix_acl *acl, size_t *size)
 /*
  * Inode operation get_posix_acl().
  *
- * inode->i_mutex: don't care
+ * inode->i_rwsem: don't care
  */
 struct posix_acl *
 ext4_get_acl(struct inode *inode, int type, bool rcu)
@@ -183,7 +183,7 @@ ext4_get_acl(struct inode *inode, int type, bool rcu)
 /*
  * Set the access or default ACL of an inode.
  *
- * inode->i_mutex: down unless called from ext4_new_inode
+ * inode->i_rwsem: down unless called from ext4_new_inode
  */
 static int
 __ext4_set_acl(handle_t *handle, struct inode *inode, int type,
@@ -271,8 +271,8 @@ ext4_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
 /*
  * Initialize the ACLs of a new inode. Called from ext4_new_inode.
  *
- * dir->i_mutex: down
- * inode->i_mutex: up (access to inode is still exclusive)
+ * dir->i_rwsem: down
+ * inode->i_rwsem: up (access to inode is still exclusive)
  */
 int
 ext4_init_acl(handle_t *handle, struct inode *inode, struct inode *dir)
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 71a3cdceaa03..f3f206b11271 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1028,7 +1028,7 @@ struct ext4_inode_info {
 
 	/*
 	 * Extended attributes can be read independently of the main file
-	 * data. Taking i_mutex even when reading would cause contention
+	 * data. Taking i_rwsem even when reading would cause contention
 	 * between readers of EAs and writers of regular file data, so
 	 * instead we synchronize on xattr_sem when reading or changing
 	 * EAs.
@@ -3407,7 +3407,7 @@ do {								\
 #define EXT4_FREECLUSTERS_WATERMARK 0
 #endif
 
-/* Update i_disksize. Requires i_mutex to avoid races with truncate */
+/* Update i_disksize. Requires i_rwsem to avoid races with truncate */
 static inline void ext4_update_i_disksize(struct inode *inode, loff_t newsize)
 {
 	WARN_ON_ONCE(S_ISREG(inode->i_mode) &&
@@ -3418,7 +3418,7 @@ static inline void ext4_update_i_disksize(struct inode *inode, loff_t newsize)
 	up_write(&EXT4_I(inode)->i_data_sem);
 }
 
-/* Update i_size, i_disksize. Requires i_mutex to avoid races with truncate */
+/* Update i_size, i_disksize. Requires i_rwsem to avoid races with truncate */
 static inline int ext4_update_inode_size(struct inode *inode, loff_t newsize)
 {
 	int changed = 0;
diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
index 0e4fa644df01..db2ae4a2b38d 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -491,7 +491,7 @@ static inline int ext4_free_data_revoke_credits(struct inode *inode, int blocks)
 /*
  * This function controls whether or not we should try to go down the
  * dioread_nolock code paths, which makes it safe to avoid taking
- * i_mutex for direct I/O reads.  This only works for extent-based
+ * i_rwsem for direct I/O reads.  This only works for extent-based
  * files, and it doesn't work if data journaling is enabled, since the
  * dioread_nolock code uses b_private to pass information back to the
  * I/O completion handler, and this conflicts with the jbd's use of
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 74c91da585d7..69b4b06738e5 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -97,7 +97,7 @@ static int ext4_ext_trunc_restart_fn(struct inode *inode, int *dropped)
 	 * Drop i_data_sem to avoid deadlock with ext4_map_blocks.  At this
 	 * moment, get_block can be called only for blocks inside i_size since
 	 * page cache has been already dropped and writes are blocked by
-	 * i_mutex. So we can safely drop the i_data_sem here.
+	 * i_rwsem. So we can safely drop the i_data_sem here.
 	 */
 	BUG_ON(EXT4_JOURNAL(inode) == NULL);
 	ext4_discard_preallocations(inode, 0);
@@ -4572,7 +4572,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 
 	flags = EXT4_GET_BLOCKS_CREATE_UNWRIT_EXT;
 
-	/* Wait all existing dio workers, newcomers will block on i_mutex */
+	/* Wait all existing dio workers, newcomers will block on i_rwsem */
 	inode_dio_wait(inode);
 
 	/* Preallocate the range including the unaligned edges */
@@ -4738,7 +4738,7 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 			goto out;
 	}
 
-	/* Wait all existing dio workers, newcomers will block on i_mutex */
+	/* Wait all existing dio workers, newcomers will block on i_rwsem */
 	inode_dio_wait(inode);
 
 	ret = ext4_alloc_file_blocks(file, lblk, max_blocks, new_size, flags);
@@ -5571,7 +5571,7 @@ static int ext4_insert_range(struct inode *inode, loff_t offset, loff_t len)
  * stuff such as page-cache locking consistency, bh mapping consistency or
  * extent's data copying must be performed by caller.
  * Locking:
- * 		i_mutex is held for both inodes
+ *		i_rwsem is held for both inodes
  * 		i_data_sem is locked for write for both inodes
  * Assumptions:
  *		All pages from requested range are locked for both inodes
diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
index 89efa78ed4b2..07a8c75b65ed 100644
--- a/fs/ext4/indirect.c
+++ b/fs/ext4/indirect.c
@@ -696,7 +696,7 @@ static int ext4_ind_trunc_restart_fn(handle_t *handle, struct inode *inode,
 	 * Drop i_data_sem to avoid deadlock with ext4_map_blocks.  At this
 	 * moment, get_block can be called only for blocks inside i_size since
 	 * page cache has been already dropped and writes are blocked by
-	 * i_mutex. So we can safely drop the i_data_sem here.
+	 * i_rwsem. So we can safely drop the i_data_sem here.
 	 */
 	BUG_ON(EXT4_JOURNAL(inode) == NULL);
 	ext4_discard_preallocations(inode, 0);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 5f79d265d06a..340498dc768b 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1224,7 +1224,7 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 		/*
 		 * __block_write_begin may have instantiated a few blocks
 		 * outside i_size.  Trim these off again. Don't need
-		 * i_size_read because we hold i_mutex.
+		 * i_size_read because we hold i_rwsem.
 		 *
 		 * Add inode to orphan list in case we crash before
 		 * truncate finishes
@@ -3979,7 +3979,7 @@ int ext4_punch_hole(struct inode *inode, loff_t offset, loff_t length)
 
 	}
 
-	/* Wait all existing dio workers, newcomers will block on i_mutex */
+	/* Wait all existing dio workers, newcomers will block on i_rwsem */
 	inode_dio_wait(inode);
 
 	/*
@@ -4129,7 +4129,7 @@ int ext4_truncate(struct inode *inode)
 	/*
 	 * There is a possibility that we're either freeing the inode
 	 * or it's a completely new inode. In those cases we might not
-	 * have i_mutex locked because it's not necessary.
+	 * have i_rwsem locked because it's not necessary.
 	 */
 	if (!(inode->i_state & (I_NEW|I_FREEING)))
 		WARN_ON(!inode_is_locked(inode));
@@ -5271,7 +5271,7 @@ static void ext4_wait_for_tail_page_commit(struct inode *inode)
  * transaction are already on disk (truncate waits for pages under
  * writeback).
  *
- * Called with inode->i_mutex down.
+ * Called with inode->i_rwsem down.
  */
 int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		 struct iattr *attr)
diff --git a/fs/ext4/migrate.c b/fs/ext4/migrate.c
index ff8916e1d38e..7a5353a8cfd7 100644
--- a/fs/ext4/migrate.c
+++ b/fs/ext4/migrate.c
@@ -485,7 +485,7 @@ int ext4_ext_migrate(struct inode *inode)
 	 * when we add extents we extent the journal
 	 */
 	/*
-	 * Even though we take i_mutex we can still cause block
+	 * Even though we take i_rwsem we can still cause block
 	 * allocation via mmap write to holes. If we have allocated
 	 * new blocks we fail migrate.  New block allocation will
 	 * clear EXT4_STATE_EXT_MIGRATE flag.  The flag is updated
diff --git a/fs/ext4/orphan.c b/fs/ext4/orphan.c
index 53adc8f570a3..7de0612eb42d 100644
--- a/fs/ext4/orphan.c
+++ b/fs/ext4/orphan.c
@@ -93,7 +93,7 @@ static int ext4_orphan_file_add(handle_t *handle, struct inode *inode)
  * At filesystem recovery time, we walk this list deleting unlinked
  * inodes and truncating linked inodes in ext4_orphan_cleanup().
  *
- * Orphan list manipulation functions must be called under i_mutex unless
+ * Orphan list manipulation functions must be called under i_rwsem unless
  * we are just creating the inode or deleting it.
  */
 int ext4_orphan_add(handle_t *handle, struct inode *inode)
@@ -119,7 +119,7 @@ int ext4_orphan_add(handle_t *handle, struct inode *inode)
 	/*
 	 * Orphan handling is only valid for files with data blocks
 	 * being truncated, or files being unlinked. Note that we either
-	 * hold i_mutex, or the inode can not be referenced from outside,
+	 * hold i_rwsem, or the inode can not be referenced from outside,
 	 * so i_nlink should not be bumped due to race
 	 */
 	ASSERT((S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
-- 
2.19.1.6.gb485710b

