Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1D903E8E62
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Aug 2021 12:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237036AbhHKKUC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 Aug 2021 06:20:02 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47624 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236948AbhHKKTu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 Aug 2021 06:19:50 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 343F7221D0;
        Wed, 11 Aug 2021 10:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628677166; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XLfJd4IWlN3FHLeRI73iOcudvyQk3hkmEJBjPl6p2Dc=;
        b=Y5O5AQUmqD5qhMiTpM0FBoUork5R9pKEhU59S//Y5g4pKPrhBsRg5Xy+pix4mJg9oB4/Ky
        HCF/sSGuY/beQtmboWkyvxXdKDhWK3jyu5UODBHE8183akJX3hHqj46lUN5vt8L2Ibul5e
        N69S3AieQFuPutVtq1qQGXfkwOv3DJs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628677166;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XLfJd4IWlN3FHLeRI73iOcudvyQk3hkmEJBjPl6p2Dc=;
        b=YZFW1dqEHHW5sXLPjrXIGz45jsmUE7V/0MC2GkX6Fjyp1unenH+hGxLLcqotVr7gi+lr8V
        o0bq7LNZ0fGtdYDQ==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 2007AA3C01;
        Wed, 11 Aug 2021 10:19:26 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D68761F2B76; Wed, 11 Aug 2021 12:19:25 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        Andreas Dilger <adilger@dilger.ca>
Subject: [PATCH 2/5] ext4: Move orphan inode handling into a separate file
Date:   Wed, 11 Aug 2021 12:19:12 +0200
Message-Id: <20210811101925.6973-2-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210811101006.2033-1-jack@suse.cz>
References: <20210811101006.2033-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=29079; h=from:subject; bh=F8scXl/c0cq4BwGQacngeFfZc7uzoDht7jduvVtJ7DY=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBhE6Qfhi9QCE/LdJhB80BXeM4Oyf+I/aFAGWaic/g6 LC9iLwSJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYROkHwAKCRCcnaoHP2RA2eMYB/ 9nBnqAmZCyf/jeCxO5JN+gyY3IHodiNuhL7n4Sg2VfXKX/tkYvPewarsvefgPJV7QNqC/3zCHzF5o4 fN16OsRg79rzthQmhNAnqJcCpsn5pAxUdFBsuYq+vU6AqwqtwEH6kkwnWV1Xwn2EcUqThxwrb6mchS smz5tE/fQquHlPLlEc117M65i3dxMV5PtdR/fzQJCWxtt5se/yhhqT3NxxlpP+dd7Q9u4yzCBVrV4f C35pmVN7aCjEAScWl65rWjK4S7sSuONOUR7GKC8L74KU6a/I6LOaXR1O0lAtDiif6RuqiZG2Hb/1KI 0ROXIdCCAppmP6mzOLpJGnuAjHyxBL
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Move functions for handling orphan inodes into a new file
fs/ext4/orphan.c to have them in one place and somewhat reduce size of
other files. No code changes.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Reviewed-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/Makefile |   2 +-
 fs/ext4/ext4.h   |  11 +-
 fs/ext4/namei.c  | 182 ------------------------
 fs/ext4/orphan.c | 363 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/ext4/super.c  | 180 +----------------------
 5 files changed, 375 insertions(+), 363 deletions(-)
 create mode 100644 fs/ext4/orphan.c

diff --git a/fs/ext4/Makefile b/fs/ext4/Makefile
index 49e7af6cc93f..7d89142e1421 100644
--- a/fs/ext4/Makefile
+++ b/fs/ext4/Makefile
@@ -10,7 +10,7 @@ ext4-y	:= balloc.o bitmap.o block_validity.o dir.o ext4_jbd2.o extents.o \
 		indirect.o inline.o inode.o ioctl.o mballoc.o migrate.o \
 		mmp.o move_extent.o namei.o page-io.o readpage.o resize.o \
 		super.o symlink.o sysfs.o xattr.o xattr_hurd.o xattr_trusted.o \
-		xattr_user.o fast_commit.o
+		xattr_user.o fast_commit.o orphan.o
 
 ext4-$(CONFIG_EXT4_FS_POSIX_ACL)	+= acl.o
 ext4-$(CONFIG_EXT4_FS_SECURITY)		+= xattr_security.o
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index c3cd7faa6cf2..b8194ea85fff 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2168,6 +2168,8 @@ static inline bool ext4_has_incompat_features(struct super_block *sb)
 	return (EXT4_SB(sb)->s_es->s_feature_incompat != 0);
 }
 
+extern int ext4_feature_set_ok(struct super_block *sb, int readonly);
+
 /*
  * Superblock flags
  */
@@ -3028,8 +3030,6 @@ extern int ext4_init_new_dir(handle_t *handle, struct inode *dir,
 			     struct inode *inode);
 extern int ext4_dirblock_csum_verify(struct inode *inode,
 				     struct buffer_head *bh);
-extern int ext4_orphan_add(handle_t *, struct inode *);
-extern int ext4_orphan_del(handle_t *, struct inode *);
 extern int ext4_htree_fill_tree(struct file *dir_file, __u32 start_hash,
 				__u32 start_minor_hash, __u32 *next_hash);
 extern int ext4_search_dir(struct buffer_head *bh,
@@ -3498,6 +3498,7 @@ static inline bool ext4_is_quota_journalled(struct super_block *sb)
 	return (ext4_has_feature_quota(sb) ||
 		sbi->s_qf_names[USRQUOTA] || sbi->s_qf_names[GRPQUOTA]);
 }
+int ext4_enable_quotas(struct super_block *sb);
 #endif
 
 /*
@@ -3759,6 +3760,12 @@ extern void ext4_stop_mmpd(struct ext4_sb_info *sbi);
 /* verity.c */
 extern const struct fsverity_operations ext4_verityops;
 
+/* orphan.c */
+extern int ext4_orphan_add(handle_t *, struct inode *);
+extern int ext4_orphan_del(handle_t *, struct inode *);
+extern void ext4_orphan_cleanup(struct super_block *sb,
+				struct ext4_super_block *es);
+
 /*
  * Add new method to test whether block and inode bitmaps are properly
  * initialized. With uninit_bg reading the block from disk is not enough
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index dfb3ae61dfe8..da7698341d7d 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -3054,188 +3054,6 @@ bool ext4_empty_dir(struct inode *inode)
 	return true;
 }
 
-/*
- * ext4_orphan_add() links an unlinked or truncated inode into a list of
- * such inodes, starting at the superblock, in case we crash before the
- * file is closed/deleted, or in case the inode truncate spans multiple
- * transactions and the last transaction is not recovered after a crash.
- *
- * At filesystem recovery time, we walk this list deleting unlinked
- * inodes and truncating linked inodes in ext4_orphan_cleanup().
- *
- * Orphan list manipulation functions must be called under i_mutex unless
- * we are just creating the inode or deleting it.
- */
-int ext4_orphan_add(handle_t *handle, struct inode *inode)
-{
-	struct super_block *sb = inode->i_sb;
-	struct ext4_sb_info *sbi = EXT4_SB(sb);
-	struct ext4_iloc iloc;
-	int err = 0, rc;
-	bool dirty = false;
-
-	if (!sbi->s_journal || is_bad_inode(inode))
-		return 0;
-
-	WARN_ON_ONCE(!(inode->i_state & (I_NEW | I_FREEING)) &&
-		     !inode_is_locked(inode));
-	/*
-	 * Exit early if inode already is on orphan list. This is a big speedup
-	 * since we don't have to contend on the global s_orphan_lock.
-	 */
-	if (!list_empty(&EXT4_I(inode)->i_orphan))
-		return 0;
-
-	/*
-	 * Orphan handling is only valid for files with data blocks
-	 * being truncated, or files being unlinked. Note that we either
-	 * hold i_mutex, or the inode can not be referenced from outside,
-	 * so i_nlink should not be bumped due to race
-	 */
-	ASSERT((S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
-		  S_ISLNK(inode->i_mode)) || inode->i_nlink == 0);
-
-	BUFFER_TRACE(sbi->s_sbh, "get_write_access");
-	err = ext4_journal_get_write_access(handle, sb, sbi->s_sbh,
-					    EXT4_JTR_NONE);
-	if (err)
-		goto out;
-
-	err = ext4_reserve_inode_write(handle, inode, &iloc);
-	if (err)
-		goto out;
-
-	mutex_lock(&sbi->s_orphan_lock);
-	/*
-	 * Due to previous errors inode may be already a part of on-disk
-	 * orphan list. If so skip on-disk list modification.
-	 */
-	if (!NEXT_ORPHAN(inode) || NEXT_ORPHAN(inode) >
-	    (le32_to_cpu(sbi->s_es->s_inodes_count))) {
-		/* Insert this inode at the head of the on-disk orphan list */
-		NEXT_ORPHAN(inode) = le32_to_cpu(sbi->s_es->s_last_orphan);
-		lock_buffer(sbi->s_sbh);
-		sbi->s_es->s_last_orphan = cpu_to_le32(inode->i_ino);
-		ext4_superblock_csum_set(sb);
-		unlock_buffer(sbi->s_sbh);
-		dirty = true;
-	}
-	list_add(&EXT4_I(inode)->i_orphan, &sbi->s_orphan);
-	mutex_unlock(&sbi->s_orphan_lock);
-
-	if (dirty) {
-		err = ext4_handle_dirty_metadata(handle, NULL, sbi->s_sbh);
-		rc = ext4_mark_iloc_dirty(handle, inode, &iloc);
-		if (!err)
-			err = rc;
-		if (err) {
-			/*
-			 * We have to remove inode from in-memory list if
-			 * addition to on disk orphan list failed. Stray orphan
-			 * list entries can cause panics at unmount time.
-			 */
-			mutex_lock(&sbi->s_orphan_lock);
-			list_del_init(&EXT4_I(inode)->i_orphan);
-			mutex_unlock(&sbi->s_orphan_lock);
-		}
-	} else
-		brelse(iloc.bh);
-
-	jbd_debug(4, "superblock will point to %lu\n", inode->i_ino);
-	jbd_debug(4, "orphan inode %lu will point to %d\n",
-			inode->i_ino, NEXT_ORPHAN(inode));
-out:
-	ext4_std_error(sb, err);
-	return err;
-}
-
-/*
- * ext4_orphan_del() removes an unlinked or truncated inode from the list
- * of such inodes stored on disk, because it is finally being cleaned up.
- */
-int ext4_orphan_del(handle_t *handle, struct inode *inode)
-{
-	struct list_head *prev;
-	struct ext4_inode_info *ei = EXT4_I(inode);
-	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
-	__u32 ino_next;
-	struct ext4_iloc iloc;
-	int err = 0;
-
-	if (!sbi->s_journal && !(sbi->s_mount_state & EXT4_ORPHAN_FS))
-		return 0;
-
-	WARN_ON_ONCE(!(inode->i_state & (I_NEW | I_FREEING)) &&
-		     !inode_is_locked(inode));
-	/* Do this quick check before taking global s_orphan_lock. */
-	if (list_empty(&ei->i_orphan))
-		return 0;
-
-	if (handle) {
-		/* Grab inode buffer early before taking global s_orphan_lock */
-		err = ext4_reserve_inode_write(handle, inode, &iloc);
-	}
-
-	mutex_lock(&sbi->s_orphan_lock);
-	jbd_debug(4, "remove inode %lu from orphan list\n", inode->i_ino);
-
-	prev = ei->i_orphan.prev;
-	list_del_init(&ei->i_orphan);
-
-	/* If we're on an error path, we may not have a valid
-	 * transaction handle with which to update the orphan list on
-	 * disk, but we still need to remove the inode from the linked
-	 * list in memory. */
-	if (!handle || err) {
-		mutex_unlock(&sbi->s_orphan_lock);
-		goto out_err;
-	}
-
-	ino_next = NEXT_ORPHAN(inode);
-	if (prev == &sbi->s_orphan) {
-		jbd_debug(4, "superblock will point to %u\n", ino_next);
-		BUFFER_TRACE(sbi->s_sbh, "get_write_access");
-		err = ext4_journal_get_write_access(handle, inode->i_sb,
-						    sbi->s_sbh, EXT4_JTR_NONE);
-		if (err) {
-			mutex_unlock(&sbi->s_orphan_lock);
-			goto out_brelse;
-		}
-		lock_buffer(sbi->s_sbh);
-		sbi->s_es->s_last_orphan = cpu_to_le32(ino_next);
-		ext4_superblock_csum_set(inode->i_sb);
-		unlock_buffer(sbi->s_sbh);
-		mutex_unlock(&sbi->s_orphan_lock);
-		err = ext4_handle_dirty_metadata(handle, NULL, sbi->s_sbh);
-	} else {
-		struct ext4_iloc iloc2;
-		struct inode *i_prev =
-			&list_entry(prev, struct ext4_inode_info, i_orphan)->vfs_inode;
-
-		jbd_debug(4, "orphan inode %lu will point to %u\n",
-			  i_prev->i_ino, ino_next);
-		err = ext4_reserve_inode_write(handle, i_prev, &iloc2);
-		if (err) {
-			mutex_unlock(&sbi->s_orphan_lock);
-			goto out_brelse;
-		}
-		NEXT_ORPHAN(i_prev) = ino_next;
-		err = ext4_mark_iloc_dirty(handle, i_prev, &iloc2);
-		mutex_unlock(&sbi->s_orphan_lock);
-	}
-	if (err)
-		goto out_brelse;
-	NEXT_ORPHAN(inode) = 0;
-	err = ext4_mark_iloc_dirty(handle, inode, &iloc);
-out_err:
-	ext4_std_error(inode->i_sb, err);
-	return err;
-
-out_brelse:
-	brelse(iloc.bh);
-	goto out_err;
-}
-
 static int ext4_rmdir(struct inode *dir, struct dentry *dentry)
 {
 	int retval;
diff --git a/fs/ext4/orphan.c b/fs/ext4/orphan.c
new file mode 100644
index 000000000000..1f2fa2ef53bd
--- /dev/null
+++ b/fs/ext4/orphan.c
@@ -0,0 +1,363 @@
+/*
+ * Ext4 orphan inode handling
+ */
+#include <linux/fs.h>
+#include <linux/quotaops.h>
+#include <linux/buffer_head.h>
+
+#include "ext4.h"
+#include "ext4_jbd2.h"
+
+/*
+ * ext4_orphan_add() links an unlinked or truncated inode into a list of
+ * such inodes, starting at the superblock, in case we crash before the
+ * file is closed/deleted, or in case the inode truncate spans multiple
+ * transactions and the last transaction is not recovered after a crash.
+ *
+ * At filesystem recovery time, we walk this list deleting unlinked
+ * inodes and truncating linked inodes in ext4_orphan_cleanup().
+ *
+ * Orphan list manipulation functions must be called under i_mutex unless
+ * we are just creating the inode or deleting it.
+ */
+int ext4_orphan_add(handle_t *handle, struct inode *inode)
+{
+	struct super_block *sb = inode->i_sb;
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct ext4_iloc iloc;
+	int err = 0, rc;
+	bool dirty = false;
+
+	if (!sbi->s_journal || is_bad_inode(inode))
+		return 0;
+
+	WARN_ON_ONCE(!(inode->i_state & (I_NEW | I_FREEING)) &&
+		     !inode_is_locked(inode));
+	/*
+	 * Exit early if inode already is on orphan list. This is a big speedup
+	 * since we don't have to contend on the global s_orphan_lock.
+	 */
+	if (!list_empty(&EXT4_I(inode)->i_orphan))
+		return 0;
+
+	/*
+	 * Orphan handling is only valid for files with data blocks
+	 * being truncated, or files being unlinked. Note that we either
+	 * hold i_mutex, or the inode can not be referenced from outside,
+	 * so i_nlink should not be bumped due to race
+	 */
+	ASSERT((S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
+		  S_ISLNK(inode->i_mode)) || inode->i_nlink == 0);
+
+	BUFFER_TRACE(sbi->s_sbh, "get_write_access");
+	err = ext4_journal_get_write_access(handle, sb, sbi->s_sbh,
+					    EXT4_JTR_NONE);
+	if (err)
+		goto out;
+
+	err = ext4_reserve_inode_write(handle, inode, &iloc);
+	if (err)
+		goto out;
+
+	mutex_lock(&sbi->s_orphan_lock);
+	/*
+	 * Due to previous errors inode may be already a part of on-disk
+	 * orphan list. If so skip on-disk list modification.
+	 */
+	if (!NEXT_ORPHAN(inode) || NEXT_ORPHAN(inode) >
+	    (le32_to_cpu(sbi->s_es->s_inodes_count))) {
+		/* Insert this inode at the head of the on-disk orphan list */
+		NEXT_ORPHAN(inode) = le32_to_cpu(sbi->s_es->s_last_orphan);
+		lock_buffer(sbi->s_sbh);
+		sbi->s_es->s_last_orphan = cpu_to_le32(inode->i_ino);
+		ext4_superblock_csum_set(sb);
+		unlock_buffer(sbi->s_sbh);
+		dirty = true;
+	}
+	list_add(&EXT4_I(inode)->i_orphan, &sbi->s_orphan);
+	mutex_unlock(&sbi->s_orphan_lock);
+
+	if (dirty) {
+		err = ext4_handle_dirty_metadata(handle, NULL, sbi->s_sbh);
+		rc = ext4_mark_iloc_dirty(handle, inode, &iloc);
+		if (!err)
+			err = rc;
+		if (err) {
+			/*
+			 * We have to remove inode from in-memory list if
+			 * addition to on disk orphan list failed. Stray orphan
+			 * list entries can cause panics at unmount time.
+			 */
+			mutex_lock(&sbi->s_orphan_lock);
+			list_del_init(&EXT4_I(inode)->i_orphan);
+			mutex_unlock(&sbi->s_orphan_lock);
+		}
+	} else
+		brelse(iloc.bh);
+
+	jbd_debug(4, "superblock will point to %lu\n", inode->i_ino);
+	jbd_debug(4, "orphan inode %lu will point to %d\n",
+			inode->i_ino, NEXT_ORPHAN(inode));
+out:
+	ext4_std_error(sb, err);
+	return err;
+}
+
+/*
+ * ext4_orphan_del() removes an unlinked or truncated inode from the list
+ * of such inodes stored on disk, because it is finally being cleaned up.
+ */
+int ext4_orphan_del(handle_t *handle, struct inode *inode)
+{
+	struct list_head *prev;
+	struct ext4_inode_info *ei = EXT4_I(inode);
+	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+	__u32 ino_next;
+	struct ext4_iloc iloc;
+	int err = 0;
+
+	if (!sbi->s_journal && !(sbi->s_mount_state & EXT4_ORPHAN_FS))
+		return 0;
+
+	WARN_ON_ONCE(!(inode->i_state & (I_NEW | I_FREEING)) &&
+		     !inode_is_locked(inode));
+	/* Do this quick check before taking global s_orphan_lock. */
+	if (list_empty(&ei->i_orphan))
+		return 0;
+
+	if (handle) {
+		/* Grab inode buffer early before taking global s_orphan_lock */
+		err = ext4_reserve_inode_write(handle, inode, &iloc);
+	}
+
+	mutex_lock(&sbi->s_orphan_lock);
+	jbd_debug(4, "remove inode %lu from orphan list\n", inode->i_ino);
+
+	prev = ei->i_orphan.prev;
+	list_del_init(&ei->i_orphan);
+
+	/* If we're on an error path, we may not have a valid
+	 * transaction handle with which to update the orphan list on
+	 * disk, but we still need to remove the inode from the linked
+	 * list in memory. */
+	if (!handle || err) {
+		mutex_unlock(&sbi->s_orphan_lock);
+		goto out_err;
+	}
+
+	ino_next = NEXT_ORPHAN(inode);
+	if (prev == &sbi->s_orphan) {
+		jbd_debug(4, "superblock will point to %u\n", ino_next);
+		BUFFER_TRACE(sbi->s_sbh, "get_write_access");
+		err = ext4_journal_get_write_access(handle, inode->i_sb,
+						    sbi->s_sbh, EXT4_JTR_NONE);
+		if (err) {
+			mutex_unlock(&sbi->s_orphan_lock);
+			goto out_brelse;
+		}
+		lock_buffer(sbi->s_sbh);
+		sbi->s_es->s_last_orphan = cpu_to_le32(ino_next);
+		ext4_superblock_csum_set(inode->i_sb);
+		unlock_buffer(sbi->s_sbh);
+		mutex_unlock(&sbi->s_orphan_lock);
+		err = ext4_handle_dirty_metadata(handle, NULL, sbi->s_sbh);
+	} else {
+		struct ext4_iloc iloc2;
+		struct inode *i_prev =
+			&list_entry(prev, struct ext4_inode_info, i_orphan)->vfs_inode;
+
+		jbd_debug(4, "orphan inode %lu will point to %u\n",
+			  i_prev->i_ino, ino_next);
+		err = ext4_reserve_inode_write(handle, i_prev, &iloc2);
+		if (err) {
+			mutex_unlock(&sbi->s_orphan_lock);
+			goto out_brelse;
+		}
+		NEXT_ORPHAN(i_prev) = ino_next;
+		err = ext4_mark_iloc_dirty(handle, i_prev, &iloc2);
+		mutex_unlock(&sbi->s_orphan_lock);
+	}
+	if (err)
+		goto out_brelse;
+	NEXT_ORPHAN(inode) = 0;
+	err = ext4_mark_iloc_dirty(handle, inode, &iloc);
+out_err:
+	ext4_std_error(inode->i_sb, err);
+	return err;
+
+out_brelse:
+	brelse(iloc.bh);
+	goto out_err;
+}
+
+#ifdef CONFIG_QUOTA
+static int ext4_quota_on_mount(struct super_block *sb, int type)
+{
+	return dquot_quota_on_mount(sb,
+		rcu_dereference_protected(EXT4_SB(sb)->s_qf_names[type],
+					  lockdep_is_held(&sb->s_umount)),
+		EXT4_SB(sb)->s_jquota_fmt, type);
+}
+#endif
+
+/* ext4_orphan_cleanup() walks a singly-linked list of inodes (starting at
+ * the superblock) which were deleted from all directories, but held open by
+ * a process at the time of a crash.  We walk the list and try to delete these
+ * inodes at recovery time (only with a read-write filesystem).
+ *
+ * In order to keep the orphan inode chain consistent during traversal (in
+ * case of crash during recovery), we link each inode into the superblock
+ * orphan list_head and handle it the same way as an inode deletion during
+ * normal operation (which journals the operations for us).
+ *
+ * We only do an iget() and an iput() on each inode, which is very safe if we
+ * accidentally point at an in-use or already deleted inode.  The worst that
+ * can happen in this case is that we get a "bit already cleared" message from
+ * ext4_free_inode().  The only reason we would point at a wrong inode is if
+ * e2fsck was run on this filesystem, and it must have already done the orphan
+ * inode cleanup for us, so we can safely abort without any further action.
+ */
+void ext4_orphan_cleanup(struct super_block *sb, struct ext4_super_block *es)
+{
+	unsigned int s_flags = sb->s_flags;
+	int ret, nr_orphans = 0, nr_truncates = 0;
+#ifdef CONFIG_QUOTA
+	int quota_update = 0;
+	int i;
+#endif
+	if (!es->s_last_orphan) {
+		jbd_debug(4, "no orphan inodes to clean up\n");
+		return;
+	}
+
+	if (bdev_read_only(sb->s_bdev)) {
+		ext4_msg(sb, KERN_ERR, "write access "
+			"unavailable, skipping orphan cleanup");
+		return;
+	}
+
+	/* Check if feature set would not allow a r/w mount */
+	if (!ext4_feature_set_ok(sb, 0)) {
+		ext4_msg(sb, KERN_INFO, "Skipping orphan cleanup due to "
+			 "unknown ROCOMPAT features");
+		return;
+	}
+
+	if (EXT4_SB(sb)->s_mount_state & EXT4_ERROR_FS) {
+		/* don't clear list on RO mount w/ errors */
+		if (es->s_last_orphan && !(s_flags & SB_RDONLY)) {
+			ext4_msg(sb, KERN_INFO, "Errors on filesystem, "
+				  "clearing orphan list.\n");
+			es->s_last_orphan = 0;
+		}
+		jbd_debug(1, "Skipping orphan recovery on fs with errors.\n");
+		return;
+	}
+
+	if (s_flags & SB_RDONLY) {
+		ext4_msg(sb, KERN_INFO, "orphan cleanup on readonly fs");
+		sb->s_flags &= ~SB_RDONLY;
+	}
+#ifdef CONFIG_QUOTA
+	/*
+	 * Turn on quotas which were not enabled for read-only mounts if
+	 * filesystem has quota feature, so that they are updated correctly.
+	 */
+	if (ext4_has_feature_quota(sb) && (s_flags & SB_RDONLY)) {
+		int ret = ext4_enable_quotas(sb);
+
+		if (!ret)
+			quota_update = 1;
+		else
+			ext4_msg(sb, KERN_ERR,
+				"Cannot turn on quotas: error %d", ret);
+	}
+
+	/* Turn on journaled quotas used for old sytle */
+	for (i = 0; i < EXT4_MAXQUOTAS; i++) {
+		if (EXT4_SB(sb)->s_qf_names[i]) {
+			int ret = ext4_quota_on_mount(sb, i);
+
+			if (!ret)
+				quota_update = 1;
+			else
+				ext4_msg(sb, KERN_ERR,
+					"Cannot turn on journaled "
+					"quota: type %d: error %d", i, ret);
+		}
+	}
+#endif
+
+	while (es->s_last_orphan) {
+		struct inode *inode;
+
+		/*
+		 * We may have encountered an error during cleanup; if
+		 * so, skip the rest.
+		 */
+		if (EXT4_SB(sb)->s_mount_state & EXT4_ERROR_FS) {
+			jbd_debug(1, "Skipping orphan recovery on fs with errors.\n");
+			es->s_last_orphan = 0;
+			break;
+		}
+
+		inode = ext4_orphan_get(sb, le32_to_cpu(es->s_last_orphan));
+		if (IS_ERR(inode)) {
+			es->s_last_orphan = 0;
+			break;
+		}
+
+		list_add(&EXT4_I(inode)->i_orphan, &EXT4_SB(sb)->s_orphan);
+		dquot_initialize(inode);
+		if (inode->i_nlink) {
+			if (test_opt(sb, DEBUG))
+				ext4_msg(sb, KERN_DEBUG,
+					"%s: truncating inode %lu to %lld bytes",
+					__func__, inode->i_ino, inode->i_size);
+			jbd_debug(2, "truncating inode %lu to %lld bytes\n",
+				  inode->i_ino, inode->i_size);
+			inode_lock(inode);
+			truncate_inode_pages(inode->i_mapping, inode->i_size);
+			ret = ext4_truncate(inode);
+			if (ret) {
+				/*
+				 * We need to clean up the in-core orphan list
+				 * manually if ext4_truncate() failed to get a
+				 * transaction handle.
+				 */
+				ext4_orphan_del(NULL, inode);
+				ext4_std_error(inode->i_sb, ret);
+			}
+			inode_unlock(inode);
+			nr_truncates++;
+		} else {
+			if (test_opt(sb, DEBUG))
+				ext4_msg(sb, KERN_DEBUG,
+					"%s: deleting unreferenced inode %lu",
+					__func__, inode->i_ino);
+			jbd_debug(2, "deleting unreferenced inode %lu\n",
+				  inode->i_ino);
+			nr_orphans++;
+		}
+		iput(inode);  /* The delete magic happens here! */
+	}
+
+#define PLURAL(x) (x), ((x) == 1) ? "" : "s"
+
+	if (nr_orphans)
+		ext4_msg(sb, KERN_INFO, "%d orphan inode%s deleted",
+		       PLURAL(nr_orphans));
+	if (nr_truncates)
+		ext4_msg(sb, KERN_INFO, "%d truncate%s cleaned up",
+		       PLURAL(nr_truncates));
+#ifdef CONFIG_QUOTA
+	/* Turn off quotas if they were enabled for orphan cleanup */
+	if (quota_update) {
+		for (i = 0; i < EXT4_MAXQUOTAS; i++) {
+			if (sb_dqopt(sb)->files[i])
+				dquot_quota_off(sb, i);
+		}
+	}
+#endif
+	sb->s_flags = s_flags; /* Restore SB_RDONLY status */
+}
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 61fcea9dce3d..a7081d525faa 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -80,7 +80,6 @@ static struct dentry *ext4_mount(struct file_system_type *fs_type, int flags,
 		       const char *dev_name, void *data);
 static inline int ext2_feature_set_ok(struct super_block *sb);
 static inline int ext3_feature_set_ok(struct super_block *sb);
-static int ext4_feature_set_ok(struct super_block *sb, int readonly);
 static void ext4_destroy_lazyinit_thread(void);
 static void ext4_unregister_li_request(struct super_block *sb);
 static void ext4_clear_request_list(void);
@@ -1585,14 +1584,12 @@ static int ext4_mark_dquot_dirty(struct dquot *dquot);
 static int ext4_write_info(struct super_block *sb, int type);
 static int ext4_quota_on(struct super_block *sb, int type, int format_id,
 			 const struct path *path);
-static int ext4_quota_on_mount(struct super_block *sb, int type);
 static ssize_t ext4_quota_read(struct super_block *sb, int type, char *data,
 			       size_t len, loff_t off);
 static ssize_t ext4_quota_write(struct super_block *sb, int type,
 				const char *data, size_t len, loff_t off);
 static int ext4_quota_enable(struct super_block *sb, int type, int format_id,
 			     unsigned int flags);
-static int ext4_enable_quotas(struct super_block *sb);
 
 static struct dquot **ext4_get_dquots(struct inode *inode)
 {
@@ -2970,169 +2967,6 @@ static int ext4_check_descriptors(struct super_block *sb,
 	return 1;
 }
 
-/* ext4_orphan_cleanup() walks a singly-linked list of inodes (starting at
- * the superblock) which were deleted from all directories, but held open by
- * a process at the time of a crash.  We walk the list and try to delete these
- * inodes at recovery time (only with a read-write filesystem).
- *
- * In order to keep the orphan inode chain consistent during traversal (in
- * case of crash during recovery), we link each inode into the superblock
- * orphan list_head and handle it the same way as an inode deletion during
- * normal operation (which journals the operations for us).
- *
- * We only do an iget() and an iput() on each inode, which is very safe if we
- * accidentally point at an in-use or already deleted inode.  The worst that
- * can happen in this case is that we get a "bit already cleared" message from
- * ext4_free_inode().  The only reason we would point at a wrong inode is if
- * e2fsck was run on this filesystem, and it must have already done the orphan
- * inode cleanup for us, so we can safely abort without any further action.
- */
-static void ext4_orphan_cleanup(struct super_block *sb,
-				struct ext4_super_block *es)
-{
-	unsigned int s_flags = sb->s_flags;
-	int ret, nr_orphans = 0, nr_truncates = 0;
-#ifdef CONFIG_QUOTA
-	int quota_update = 0;
-	int i;
-#endif
-	if (!es->s_last_orphan) {
-		jbd_debug(4, "no orphan inodes to clean up\n");
-		return;
-	}
-
-	if (bdev_read_only(sb->s_bdev)) {
-		ext4_msg(sb, KERN_ERR, "write access "
-			"unavailable, skipping orphan cleanup");
-		return;
-	}
-
-	/* Check if feature set would not allow a r/w mount */
-	if (!ext4_feature_set_ok(sb, 0)) {
-		ext4_msg(sb, KERN_INFO, "Skipping orphan cleanup due to "
-			 "unknown ROCOMPAT features");
-		return;
-	}
-
-	if (EXT4_SB(sb)->s_mount_state & EXT4_ERROR_FS) {
-		/* don't clear list on RO mount w/ errors */
-		if (es->s_last_orphan && !(s_flags & SB_RDONLY)) {
-			ext4_msg(sb, KERN_INFO, "Errors on filesystem, "
-				  "clearing orphan list.\n");
-			es->s_last_orphan = 0;
-		}
-		jbd_debug(1, "Skipping orphan recovery on fs with errors.\n");
-		return;
-	}
-
-	if (s_flags & SB_RDONLY) {
-		ext4_msg(sb, KERN_INFO, "orphan cleanup on readonly fs");
-		sb->s_flags &= ~SB_RDONLY;
-	}
-#ifdef CONFIG_QUOTA
-	/*
-	 * Turn on quotas which were not enabled for read-only mounts if
-	 * filesystem has quota feature, so that they are updated correctly.
-	 */
-	if (ext4_has_feature_quota(sb) && (s_flags & SB_RDONLY)) {
-		int ret = ext4_enable_quotas(sb);
-
-		if (!ret)
-			quota_update = 1;
-		else
-			ext4_msg(sb, KERN_ERR,
-				"Cannot turn on quotas: error %d", ret);
-	}
-
-	/* Turn on journaled quotas used for old sytle */
-	for (i = 0; i < EXT4_MAXQUOTAS; i++) {
-		if (EXT4_SB(sb)->s_qf_names[i]) {
-			int ret = ext4_quota_on_mount(sb, i);
-
-			if (!ret)
-				quota_update = 1;
-			else
-				ext4_msg(sb, KERN_ERR,
-					"Cannot turn on journaled "
-					"quota: type %d: error %d", i, ret);
-		}
-	}
-#endif
-
-	while (es->s_last_orphan) {
-		struct inode *inode;
-
-		/*
-		 * We may have encountered an error during cleanup; if
-		 * so, skip the rest.
-		 */
-		if (EXT4_SB(sb)->s_mount_state & EXT4_ERROR_FS) {
-			jbd_debug(1, "Skipping orphan recovery on fs with errors.\n");
-			es->s_last_orphan = 0;
-			break;
-		}
-
-		inode = ext4_orphan_get(sb, le32_to_cpu(es->s_last_orphan));
-		if (IS_ERR(inode)) {
-			es->s_last_orphan = 0;
-			break;
-		}
-
-		list_add(&EXT4_I(inode)->i_orphan, &EXT4_SB(sb)->s_orphan);
-		dquot_initialize(inode);
-		if (inode->i_nlink) {
-			if (test_opt(sb, DEBUG))
-				ext4_msg(sb, KERN_DEBUG,
-					"%s: truncating inode %lu to %lld bytes",
-					__func__, inode->i_ino, inode->i_size);
-			jbd_debug(2, "truncating inode %lu to %lld bytes\n",
-				  inode->i_ino, inode->i_size);
-			inode_lock(inode);
-			truncate_inode_pages(inode->i_mapping, inode->i_size);
-			ret = ext4_truncate(inode);
-			if (ret) {
-				/*
-				 * We need to clean up the in-core orphan list
-				 * manually if ext4_truncate() failed to get a
-				 * transaction handle.
-				 */
-				ext4_orphan_del(NULL, inode);
-				ext4_std_error(inode->i_sb, ret);
-			}
-			inode_unlock(inode);
-			nr_truncates++;
-		} else {
-			if (test_opt(sb, DEBUG))
-				ext4_msg(sb, KERN_DEBUG,
-					"%s: deleting unreferenced inode %lu",
-					__func__, inode->i_ino);
-			jbd_debug(2, "deleting unreferenced inode %lu\n",
-				  inode->i_ino);
-			nr_orphans++;
-		}
-		iput(inode);  /* The delete magic happens here! */
-	}
-
-#define PLURAL(x) (x), ((x) == 1) ? "" : "s"
-
-	if (nr_orphans)
-		ext4_msg(sb, KERN_INFO, "%d orphan inode%s deleted",
-		       PLURAL(nr_orphans));
-	if (nr_truncates)
-		ext4_msg(sb, KERN_INFO, "%d truncate%s cleaned up",
-		       PLURAL(nr_truncates));
-#ifdef CONFIG_QUOTA
-	/* Turn off quotas if they were enabled for orphan cleanup */
-	if (quota_update) {
-		for (i = 0; i < EXT4_MAXQUOTAS; i++) {
-			if (sb_dqopt(sb)->files[i])
-				dquot_quota_off(sb, i);
-		}
-	}
-#endif
-	sb->s_flags = s_flags; /* Restore SB_RDONLY status */
-}
-
 /*
  * Maximal extent format file size.
  * Resulting logical blkno at s_maxbytes must fit in our on-disk
@@ -3312,7 +3146,7 @@ static unsigned long ext4_get_stripe_size(struct ext4_sb_info *sbi)
  * Returns 1 if this filesystem can be mounted as requested,
  * 0 if it cannot be.
  */
-static int ext4_feature_set_ok(struct super_block *sb, int readonly)
+int ext4_feature_set_ok(struct super_block *sb, int readonly)
 {
 	if (ext4_has_unknown_ext4_incompat_features(sb)) {
 		ext4_msg(sb, KERN_ERR,
@@ -6326,16 +6160,6 @@ static int ext4_write_info(struct super_block *sb, int type)
 	return ret;
 }
 
-/*
- * Turn on quotas during mount time - we need to find
- * the quota file and such...
- */
-static int ext4_quota_on_mount(struct super_block *sb, int type)
-{
-	return dquot_quota_on_mount(sb, get_qf_name(sb, EXT4_SB(sb), type),
-					EXT4_SB(sb)->s_jquota_fmt, type);
-}
-
 static void lockdep_set_quota_inode(struct inode *inode, int subclass)
 {
 	struct ext4_inode_info *ei = EXT4_I(inode);
@@ -6465,7 +6289,7 @@ static int ext4_quota_enable(struct super_block *sb, int type, int format_id,
 }
 
 /* Enable usage tracking for all quota types. */
-static int ext4_enable_quotas(struct super_block *sb)
+int ext4_enable_quotas(struct super_block *sb)
 {
 	int type, err = 0;
 	unsigned long qf_inums[EXT4_MAXQUOTAS] = {
-- 
2.26.2

