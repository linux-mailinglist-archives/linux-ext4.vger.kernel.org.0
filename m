Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6E1B3ED0FC
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Aug 2021 11:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235365AbhHPJXz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Aug 2021 05:23:55 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:40618 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235290AbhHPJXp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 Aug 2021 05:23:45 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D4CFD1FEA1;
        Mon, 16 Aug 2021 09:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629105792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nHoz1sgwoFPBePUUiNS0MBNwsiOTV6j9pbBJUxnAH3U=;
        b=LQ2ReZ2u+3fWSKkmGOeTx9FnZ6QutNCUEWeXh7KVNaDZEIOUdd+RRjvYpDoY6IfGc+orJs
        +ks/A3MVn95fRSqNnHKDEWkGdgB+5iAbksEheZa5m/HPxLPhm6Nx/zd8zSjnMxWgGbv5LY
        g3NTu2VEr2DqqQa+OJcyaRO5IkKoRrE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629105792;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nHoz1sgwoFPBePUUiNS0MBNwsiOTV6j9pbBJUxnAH3U=;
        b=GlN6Mwdcqt21eQZ9lV8QrrFT9tLNK/gzCKSXHCZ8ZZ3jNCYUD/l0hJ8jBrE+lmnmQNj5I1
        x+RqhMkSrRRQBjDg==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id C1BC1A3B8F;
        Mon, 16 Aug 2021 09:23:12 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9DECC1E0948; Mon, 16 Aug 2021 11:23:09 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 3/5] ext4: Speedup ext4 orphan inode handling
Date:   Mon, 16 Aug 2021 11:23:01 +0200
Message-Id: <20210816092309.26842-3-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210816091810.16994-1-jack@suse.cz>
References: <20210816091810.16994-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=26880; h=from:subject; bh=vWs7YJ3XX4LN9hSqFFaWUwTn2OcuHRfSN+5sy+W2dJM=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBhGi51qM341uNZnJzR+cWuK43Ln4JEI2C5Ny59YaQR WEbrcVyJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYRoudQAKCRCcnaoHP2RA2aeFB/ 9L3gELrjz0LdNr90MC5JpHn5iJMm4wIgaVj3CN/egwRbkPGI82yq8gs4gXMhRYdDt+hjM/yCToeKBd iemBGJot027+AUfsoOb2002tihHIcB8IDYU4fi8LdpG2IdcltcoXwN5xwv0nZuuaWPDRoI0A2+XfUD pygPc+nnVuG+cO3EFNY4fLO68ShOyxzmBhxkyTA7ELiUUQrrh7lrPLbq/XQ0wjKLXijQpGj7+iCXXJ vox0b5d42prhWOonDC6NWX2In9XgGoiqGwgqYwQ3f0TCi+sDuWJ9+HHaKi3JpaNK94ftbJcdsHi1FA 2ivK/GdgcvCu4WD788rjOJB3l0bCif
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Ext4 orphan inode handling is a bottleneck for workloads which heavily
truncate / unlink small files since it contends on the global
s_orphan_mutex lock (and generally it's difficult to improve scalability
of the ondisk linked list of orphaned inodes).

This patch implements new way of handling orphan inodes. Instead of
linking orphaned inode into a linked list, we store it's inode number in
a new special file which we call "orphan file". Only if there's no more
space in the orphan file (too many inodes are currently orphaned) we
fall back to using old style linked list. Currently we protect
operations in the orphan file with a spinlock for simplicity but even in
this setting we can substantially reduce the length of the critical
section and thus speedup some workloads. In the next patch we improve
this by making orphan handling lockless.

Note that the change is backwards compatible when the filesystem is
clean - the existence of the orphan file is a compat feature, we set
another ro-compat feature indicating orphan file needs scanning for
orphaned inodes when mounting filesystem read-write. This ro-compat
feature gets cleared on unmount / remount read-only.

Some performance data from 80 CPU Xeon Server with 512 GB of RAM,
filesystem located on SSD, average of 5 runs:

stress-orphan (microbenchmark truncating files byte-by-byte from N
processes in parallel)

Threads Time            Time
        Vanilla         Patched
  1       1.057200        0.945600
  2       1.680400        1.331800
  4       2.547000        1.995000
  8       7.049400        6.424200
 16      14.827800       14.937600
 32      40.948200       33.038200
 64      87.787400       60.823600
128     206.504000      122.941400

So we can see significant wins all over the board.

Reviewed-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ext4.h   |  69 +++++++++-
 fs/ext4/orphan.c | 340 +++++++++++++++++++++++++++++++++++++++++------
 fs/ext4/super.c  |  34 ++++-
 3 files changed, 392 insertions(+), 51 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index b8194ea85fff..456d6efe6613 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1034,7 +1034,14 @@ struct ext4_inode_info {
 	 */
 	struct rw_semaphore xattr_sem;
 
-	struct list_head i_orphan;	/* unlinked but open inodes */
+	/*
+	 * Inodes with EXT4_STATE_ORPHAN_FILE use i_orphan_idx. Otherwise
+	 * i_orphan is used.
+	 */
+	union {
+		struct list_head i_orphan;	/* unlinked but open inodes */
+		unsigned int i_orphan_idx;	/* Index in orphan file */
+	};
 
 	/* Fast commit related info */
 
@@ -1428,7 +1435,8 @@ struct ext4_super_block {
 	__u8    s_last_error_errcode;
 	__le16  s_encoding;		/* Filename charset encoding */
 	__le16  s_encoding_flags;	/* Filename charset encoding flags */
-	__le32	s_reserved[95];		/* Padding to the end of the block */
+	__le32  s_orphan_file_inum;	/* Inode for tracking orphan inodes */
+	__le32	s_reserved[94];		/* Padding to the end of the block */
 	__le32	s_checksum;		/* crc32c(superblock) */
 };
 
@@ -1449,6 +1457,7 @@ struct ext4_super_block {
 
 /* Types of ext4 journal triggers */
 enum ext4_journal_trigger_type {
+	EXT4_JTR_ORPHAN_FILE,
 	EXT4_JTR_NONE	/* This must be the last entry for indexing to work! */
 };
 
@@ -1465,6 +1474,36 @@ static inline struct ext4_journal_trigger *EXT4_TRIGGER(
 	return container_of(trigger, struct ext4_journal_trigger, tr_triggers);
 }
 
+#define EXT4_ORPHAN_BLOCK_MAGIC 0x0b10ca04
+
+/* Structure at the tail of orphan block */
+struct ext4_orphan_block_tail {
+	__le32 ob_magic;
+	__le32 ob_checksum;
+};
+
+static inline int ext4_inodes_per_orphan_block(struct super_block *sb)
+{
+	return (sb->s_blocksize - sizeof(struct ext4_orphan_block_tail)) /
+			sizeof(u32);
+}
+
+struct ext4_orphan_block {
+	int ob_free_entries;	/* Number of free orphan entries in block */
+	struct buffer_head *ob_bh;	/* Buffer for orphan block */
+};
+
+/*
+ * Info about orphan file.
+ */
+struct ext4_orphan_info {
+	spinlock_t of_lock;
+	int of_blocks;			/* Number of orphan blocks in a file */
+	__u32 of_csum_seed;		/* Checksum seed for orphan file */
+	struct ext4_orphan_block *of_binfo;	/* Array with info about orphan
+						 * file blocks */
+};
+
 /*
  * fourth extended-fs super-block data in memory
  */
@@ -1519,9 +1558,11 @@ struct ext4_sb_info {
 
 	/* Journaling */
 	struct journal_s *s_journal;
-	struct list_head s_orphan;
-	struct mutex s_orphan_lock;
 	unsigned long s_ext4_flags;		/* Ext4 superblock flags */
+	struct mutex s_orphan_lock;	/* Protects on disk list changes */
+	struct list_head s_orphan;	/* List of orphaned inodes in on disk
+					   list */
+	struct ext4_orphan_info s_orphan_info;
 	unsigned long s_commit_interval;
 	u32 s_max_batch_time;
 	u32 s_min_batch_time;
@@ -1856,6 +1897,7 @@ enum {
 	EXT4_STATE_LUSTRE_EA_INODE,	/* Lustre-style ea_inode */
 	EXT4_STATE_VERITY_IN_PROGRESS,	/* building fs-verity Merkle tree */
 	EXT4_STATE_FC_COMMITTING,	/* Fast commit ongoing */
+	EXT4_STATE_ORPHAN_FILE,		/* Inode orphaned in orphan file */
 };
 
 #define EXT4_INODE_BIT_FNS(name, field, offset)				\
@@ -1957,6 +1999,7 @@ static inline bool ext4_verity_in_progress(struct inode *inode)
  */
 #define EXT4_FEATURE_COMPAT_FAST_COMMIT		0x0400
 #define EXT4_FEATURE_COMPAT_STABLE_INODES	0x0800
+#define EXT4_FEATURE_COMPAT_ORPHAN_FILE		0x1000	/* Orphan file exists */
 
 #define EXT4_FEATURE_RO_COMPAT_SPARSE_SUPER	0x0001
 #define EXT4_FEATURE_RO_COMPAT_LARGE_FILE	0x0002
@@ -1977,6 +2020,8 @@ static inline bool ext4_verity_in_progress(struct inode *inode)
 #define EXT4_FEATURE_RO_COMPAT_READONLY		0x1000
 #define EXT4_FEATURE_RO_COMPAT_PROJECT		0x2000
 #define EXT4_FEATURE_RO_COMPAT_VERITY		0x8000
+#define EXT4_FEATURE_RO_COMPAT_ORPHAN_PRESENT	0x10000 /* Orphan file may be
+							   non-empty */
 
 #define EXT4_FEATURE_INCOMPAT_COMPRESSION	0x0001
 #define EXT4_FEATURE_INCOMPAT_FILETYPE		0x0002
@@ -2060,6 +2105,7 @@ EXT4_FEATURE_COMPAT_FUNCS(dir_index,		DIR_INDEX)
 EXT4_FEATURE_COMPAT_FUNCS(sparse_super2,	SPARSE_SUPER2)
 EXT4_FEATURE_COMPAT_FUNCS(fast_commit,		FAST_COMMIT)
 EXT4_FEATURE_COMPAT_FUNCS(stable_inodes,	STABLE_INODES)
+EXT4_FEATURE_COMPAT_FUNCS(orphan_file,		ORPHAN_FILE)
 
 EXT4_FEATURE_RO_COMPAT_FUNCS(sparse_super,	SPARSE_SUPER)
 EXT4_FEATURE_RO_COMPAT_FUNCS(large_file,	LARGE_FILE)
@@ -2074,6 +2120,7 @@ EXT4_FEATURE_RO_COMPAT_FUNCS(metadata_csum,	METADATA_CSUM)
 EXT4_FEATURE_RO_COMPAT_FUNCS(readonly,		READONLY)
 EXT4_FEATURE_RO_COMPAT_FUNCS(project,		PROJECT)
 EXT4_FEATURE_RO_COMPAT_FUNCS(verity,		VERITY)
+EXT4_FEATURE_RO_COMPAT_FUNCS(orphan_present,	ORPHAN_PRESENT)
 
 EXT4_FEATURE_INCOMPAT_FUNCS(compression,	COMPRESSION)
 EXT4_FEATURE_INCOMPAT_FUNCS(filetype,		FILETYPE)
@@ -2107,7 +2154,8 @@ EXT4_FEATURE_INCOMPAT_FUNCS(casefold,		CASEFOLD)
 					 EXT4_FEATURE_RO_COMPAT_LARGE_FILE| \
 					 EXT4_FEATURE_RO_COMPAT_BTREE_DIR)
 
-#define EXT4_FEATURE_COMPAT_SUPP	EXT4_FEATURE_COMPAT_EXT_ATTR
+#define EXT4_FEATURE_COMPAT_SUPP	(EXT4_FEATURE_COMPAT_EXT_ATTR| \
+					 EXT4_FEATURE_COMPAT_ORPHAN_FILE)
 #define EXT4_FEATURE_INCOMPAT_SUPP	(EXT4_FEATURE_INCOMPAT_FILETYPE| \
 					 EXT4_FEATURE_INCOMPAT_RECOVER| \
 					 EXT4_FEATURE_INCOMPAT_META_BG| \
@@ -2132,7 +2180,8 @@ EXT4_FEATURE_INCOMPAT_FUNCS(casefold,		CASEFOLD)
 					 EXT4_FEATURE_RO_COMPAT_METADATA_CSUM|\
 					 EXT4_FEATURE_RO_COMPAT_QUOTA |\
 					 EXT4_FEATURE_RO_COMPAT_PROJECT |\
-					 EXT4_FEATURE_RO_COMPAT_VERITY)
+					 EXT4_FEATURE_RO_COMPAT_VERITY |\
+					 EXT4_FEATURE_RO_COMPAT_ORPHAN_PRESENT)
 
 #define EXTN_FEATURE_FUNCS(ver) \
 static inline bool ext4_has_unknown_ext##ver##_compat_features(struct super_block *sb) \
@@ -2182,7 +2231,6 @@ static inline int ext4_forced_shutdown(struct ext4_sb_info *sbi)
 	return test_bit(EXT4_FLAGS_SHUTDOWN, &sbi->s_ext4_flags);
 }
 
-
 /*
  * Default values for user and/or group using reserved blocks
  */
@@ -3765,6 +3813,13 @@ extern int ext4_orphan_add(handle_t *, struct inode *);
 extern int ext4_orphan_del(handle_t *, struct inode *);
 extern void ext4_orphan_cleanup(struct super_block *sb,
 				struct ext4_super_block *es);
+extern void ext4_release_orphan_info(struct super_block *sb);
+extern int ext4_init_orphan_info(struct super_block *sb);
+extern int ext4_orphan_file_empty(struct super_block *sb);
+extern void ext4_orphan_file_block_trigger(
+				struct jbd2_buffer_trigger_type *triggers,
+				struct buffer_head *bh,
+				void *data, size_t size);
 
 /*
  * Add new method to test whether block and inode bitmaps are properly
diff --git a/fs/ext4/orphan.c b/fs/ext4/orphan.c
index 1f2fa2ef53bd..019719c0ac12 100644
--- a/fs/ext4/orphan.c
+++ b/fs/ext4/orphan.c
@@ -8,6 +8,52 @@
 #include "ext4.h"
 #include "ext4_jbd2.h"
 
+static int ext4_orphan_file_add(handle_t *handle, struct inode *inode)
+{
+	int i, j;
+	struct ext4_orphan_info *oi = &EXT4_SB(inode->i_sb)->s_orphan_info;
+	int ret = 0;
+	__le32 *bdata;
+	int inodes_per_ob = ext4_inodes_per_orphan_block(inode->i_sb);
+
+	spin_lock(&oi->of_lock);
+	for (i = 0; i < oi->of_blocks && !oi->of_binfo[i].ob_free_entries; i++);
+	if (i == oi->of_blocks) {
+		spin_unlock(&oi->of_lock);
+		/*
+		 * For now we don't grow or shrink orphan file. We just use
+		 * whatever was allocated at mke2fs time. The additional
+		 * credits we would have to reserve for each orphan inode
+		 * operation just don't seem worth it.
+		 */
+		return -ENOSPC;
+	}
+	oi->of_binfo[i].ob_free_entries--;
+	spin_unlock(&oi->of_lock);
+
+	/*
+	 * Get access to orphan block. We have dropped of_lock but since we
+	 * have decremented number of free entries we are guaranteed free entry
+	 * in our block.
+	 */
+	ret = ext4_journal_get_write_access(handle, inode->i_sb,
+				oi->of_binfo[i].ob_bh, EXT4_JTR_ORPHAN_FILE);
+	if (ret)
+		return ret;
+
+	bdata = (__le32 *)(oi->of_binfo[i].ob_bh->b_data);
+	spin_lock(&oi->of_lock);
+	/* Find empty slot in a block */
+	for (j = 0; j < inodes_per_ob && bdata[j]; j++);
+	BUG_ON(j == inodes_per_ob);
+	bdata[j] = cpu_to_le32(inode->i_ino);
+	EXT4_I(inode)->i_orphan_idx = i * inodes_per_ob + j;
+	ext4_set_inode_state(inode, EXT4_STATE_ORPHAN_FILE);
+	spin_unlock(&oi->of_lock);
+
+	return ext4_handle_dirty_metadata(handle, NULL, oi->of_binfo[i].ob_bh);
+}
+
 /*
  * ext4_orphan_add() links an unlinked or truncated inode into a list of
  * such inodes, starting at the superblock, in case we crash before the
@@ -34,10 +80,10 @@ int ext4_orphan_add(handle_t *handle, struct inode *inode)
 	WARN_ON_ONCE(!(inode->i_state & (I_NEW | I_FREEING)) &&
 		     !inode_is_locked(inode));
 	/*
-	 * Exit early if inode already is on orphan list. This is a big speedup
-	 * since we don't have to contend on the global s_orphan_lock.
+	 * Inode orphaned in orphan file or in orphan list?
 	 */
-	if (!list_empty(&EXT4_I(inode)->i_orphan))
+	if (ext4_test_inode_state(inode, EXT4_STATE_ORPHAN_FILE) ||
+	    !list_empty(&EXT4_I(inode)->i_orphan))
 		return 0;
 
 	/*
@@ -49,6 +95,16 @@ int ext4_orphan_add(handle_t *handle, struct inode *inode)
 	ASSERT((S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
 		  S_ISLNK(inode->i_mode)) || inode->i_nlink == 0);
 
+	if (sbi->s_orphan_info.of_blocks) {
+		err = ext4_orphan_file_add(handle, inode);
+		/*
+		 * Fallback to normal orphan list of orphan file is
+		 * out of space
+		 */
+		if (err != -ENOSPC)
+			return err;
+	}
+
 	BUFFER_TRACE(sbi->s_sbh, "get_write_access");
 	err = ext4_journal_get_write_access(handle, sb, sbi->s_sbh,
 					    EXT4_JTR_NONE);
@@ -103,6 +159,39 @@ int ext4_orphan_add(handle_t *handle, struct inode *inode)
 	return err;
 }
 
+static int ext4_orphan_file_del(handle_t *handle, struct inode *inode)
+{
+	struct ext4_orphan_info *oi = &EXT4_SB(inode->i_sb)->s_orphan_info;
+	__le32 *bdata;
+	int blk, off;
+	int inodes_per_ob = ext4_inodes_per_orphan_block(inode->i_sb);
+	int ret = 0;
+
+	if (!handle)
+		goto out;
+	blk = EXT4_I(inode)->i_orphan_idx / inodes_per_ob;
+	off = EXT4_I(inode)->i_orphan_idx % inodes_per_ob;
+	if (WARN_ON_ONCE(blk >= oi->of_blocks))
+		goto out;
+
+	ret = ext4_journal_get_write_access(handle, inode->i_sb,
+				oi->of_binfo[blk].ob_bh, EXT4_JTR_ORPHAN_FILE);
+	if (ret)
+		goto out;
+
+	bdata = (__le32 *)(oi->of_binfo[blk].ob_bh->b_data);
+	spin_lock(&oi->of_lock);
+	bdata[off] = 0;
+	oi->of_binfo[blk].ob_free_entries++;
+	spin_unlock(&oi->of_lock);
+	ret = ext4_handle_dirty_metadata(handle, NULL, oi->of_binfo[blk].ob_bh);
+out:
+	ext4_clear_inode_state(inode, EXT4_STATE_ORPHAN_FILE);
+	INIT_LIST_HEAD(&EXT4_I(inode)->i_orphan);
+
+	return ret;
+}
+
 /*
  * ext4_orphan_del() removes an unlinked or truncated inode from the list
  * of such inodes stored on disk, because it is finally being cleaned up.
@@ -121,6 +210,9 @@ int ext4_orphan_del(handle_t *handle, struct inode *inode)
 
 	WARN_ON_ONCE(!(inode->i_state & (I_NEW | I_FREEING)) &&
 		     !inode_is_locked(inode));
+	if (ext4_test_inode_state(inode, EXT4_STATE_ORPHAN_FILE))
+		return ext4_orphan_file_del(handle, inode);
+
 	/* Do this quick check before taking global s_orphan_lock. */
 	if (list_empty(&ei->i_orphan))
 		return 0;
@@ -200,6 +292,46 @@ static int ext4_quota_on_mount(struct super_block *sb, int type)
 }
 #endif
 
+static void ext4_process_orphan(struct inode *inode,
+				int *nr_truncates, int *nr_orphans)
+{
+	struct super_block *sb = inode->i_sb;
+	int ret;
+
+	dquot_initialize(inode);
+	if (inode->i_nlink) {
+		if (test_opt(sb, DEBUG))
+			ext4_msg(sb, KERN_DEBUG,
+				"%s: truncating inode %lu to %lld bytes",
+				__func__, inode->i_ino, inode->i_size);
+		jbd_debug(2, "truncating inode %lu to %lld bytes\n",
+			  inode->i_ino, inode->i_size);
+		inode_lock(inode);
+		truncate_inode_pages(inode->i_mapping, inode->i_size);
+		ret = ext4_truncate(inode);
+		if (ret) {
+			/*
+			 * We need to clean up the in-core orphan list
+			 * manually if ext4_truncate() failed to get a
+			 * transaction handle.
+			 */
+			ext4_orphan_del(NULL, inode);
+			ext4_std_error(inode->i_sb, ret);
+		}
+		inode_unlock(inode);
+		(*nr_truncates)++;
+	} else {
+		if (test_opt(sb, DEBUG))
+			ext4_msg(sb, KERN_DEBUG,
+				"%s: deleting unreferenced inode %lu",
+				__func__, inode->i_ino);
+		jbd_debug(2, "deleting unreferenced inode %lu\n",
+			  inode->i_ino);
+		(*nr_orphans)++;
+	}
+	iput(inode);  /* The delete magic happens here! */
+}
+
 /* ext4_orphan_cleanup() walks a singly-linked list of inodes (starting at
  * the superblock) which were deleted from all directories, but held open by
  * a process at the time of a crash.  We walk the list and try to delete these
@@ -220,12 +352,17 @@ static int ext4_quota_on_mount(struct super_block *sb, int type)
 void ext4_orphan_cleanup(struct super_block *sb, struct ext4_super_block *es)
 {
 	unsigned int s_flags = sb->s_flags;
-	int ret, nr_orphans = 0, nr_truncates = 0;
+	int nr_orphans = 0, nr_truncates = 0;
+	struct inode *inode;
+	int i, j;
 #ifdef CONFIG_QUOTA
 	int quota_update = 0;
-	int i;
 #endif
-	if (!es->s_last_orphan) {
+	__le32 *bdata;
+	struct ext4_orphan_info *oi = &EXT4_SB(sb)->s_orphan_info;
+	int inodes_per_ob = ext4_inodes_per_orphan_block(sb);
+
+	if (!es->s_last_orphan && !oi->of_blocks) {
 		jbd_debug(4, "no orphan inodes to clean up\n");
 		return;
 	}
@@ -289,8 +426,6 @@ void ext4_orphan_cleanup(struct super_block *sb, struct ext4_super_block *es)
 #endif
 
 	while (es->s_last_orphan) {
-		struct inode *inode;
-
 		/*
 		 * We may have encountered an error during cleanup; if
 		 * so, skip the rest.
@@ -308,38 +443,21 @@ void ext4_orphan_cleanup(struct super_block *sb, struct ext4_super_block *es)
 		}
 
 		list_add(&EXT4_I(inode)->i_orphan, &EXT4_SB(sb)->s_orphan);
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
+		ext4_process_orphan(inode, &nr_truncates, &nr_orphans);
+	}
+
+	for (i = 0; i < oi->of_blocks; i++) {
+		bdata = (__le32 *)(oi->of_binfo[i].ob_bh->b_data);
+		for (j = 0; j < inodes_per_ob; j++) {
+			if (!bdata[j])
+				continue;
+			inode = ext4_orphan_get(sb, le32_to_cpu(bdata[j]));
+			if (IS_ERR(inode))
+				continue;
+			ext4_set_inode_state(inode, EXT4_STATE_ORPHAN_FILE);
+			EXT4_I(inode)->i_orphan_idx = i * inodes_per_ob + j;
+			ext4_process_orphan(inode, &nr_truncates, &nr_orphans);
 		}
-		iput(inode);  /* The delete magic happens here! */
 	}
 
 #define PLURAL(x) (x), ((x) == 1) ? "" : "s"
@@ -361,3 +479,147 @@ void ext4_orphan_cleanup(struct super_block *sb, struct ext4_super_block *es)
 #endif
 	sb->s_flags = s_flags; /* Restore SB_RDONLY status */
 }
+
+void ext4_release_orphan_info(struct super_block *sb)
+{
+	int i;
+	struct ext4_orphan_info *oi = &EXT4_SB(sb)->s_orphan_info;
+
+	if (!oi->of_blocks)
+		return;
+	for (i = 0; i < oi->of_blocks; i++)
+		brelse(oi->of_binfo[i].ob_bh);
+	kfree(oi->of_binfo);
+}
+
+static struct ext4_orphan_block_tail *ext4_orphan_block_tail(
+						struct super_block *sb,
+						struct buffer_head *bh)
+{
+	return (struct ext4_orphan_block_tail *)(bh->b_data + sb->s_blocksize -
+				sizeof(struct ext4_orphan_block_tail));
+}
+
+static int ext4_orphan_file_block_csum_verify(struct super_block *sb,
+					      struct buffer_head *bh)
+{
+	__u32 calculated;
+	int inodes_per_ob = ext4_inodes_per_orphan_block(sb);
+	struct ext4_orphan_info *oi = &EXT4_SB(sb)->s_orphan_info;
+	struct ext4_orphan_block_tail *ot;
+	__le64 dsk_block_nr = cpu_to_le64(bh->b_blocknr);
+
+	if (!ext4_has_metadata_csum(sb))
+		return 1;
+
+	ot = ext4_orphan_block_tail(sb, bh);
+	calculated = ext4_chksum(EXT4_SB(sb), oi->of_csum_seed,
+				 (__u8 *)&dsk_block_nr, sizeof(dsk_block_nr));
+	calculated = ext4_chksum(EXT4_SB(sb), calculated, (__u8 *)bh->b_data,
+				 inodes_per_ob * sizeof(__u32));
+	return le32_to_cpu(ot->ob_checksum) == calculated;
+}
+
+/* This gets called only when checksumming is enabled */
+void ext4_orphan_file_block_trigger(struct jbd2_buffer_trigger_type *triggers,
+				    struct buffer_head *bh,
+				    void *data, size_t size)
+{
+	struct super_block *sb = EXT4_TRIGGER(triggers)->sb;
+	__u32 csum;
+	int inodes_per_ob = ext4_inodes_per_orphan_block(sb);
+	struct ext4_orphan_info *oi = &EXT4_SB(sb)->s_orphan_info;
+	struct ext4_orphan_block_tail *ot;
+	__le64 dsk_block_nr = cpu_to_le64(bh->b_blocknr);
+
+	csum = ext4_chksum(EXT4_SB(sb), oi->of_csum_seed,
+			   (__u8 *)&dsk_block_nr, sizeof(dsk_block_nr));
+	csum = ext4_chksum(EXT4_SB(sb), csum, (__u8 *)data,
+			   inodes_per_ob * sizeof(__u32));
+	ot = ext4_orphan_block_tail(sb, bh);
+	ot->ob_checksum = cpu_to_le32(csum);
+}
+
+int ext4_init_orphan_info(struct super_block *sb)
+{
+	struct ext4_orphan_info *oi = &EXT4_SB(sb)->s_orphan_info;
+	struct inode *inode;
+	int i, j;
+	int ret;
+	int free;
+	__le32 *bdata;
+	int inodes_per_ob = ext4_inodes_per_orphan_block(sb);
+	struct ext4_orphan_block_tail *ot;
+	ino_t orphan_ino = le32_to_cpu(EXT4_SB(sb)->s_es->s_orphan_file_inum);
+
+	spin_lock_init(&oi->of_lock);
+
+	if (!ext4_has_feature_orphan_file(sb))
+		return 0;
+
+	inode = ext4_iget(sb, orphan_ino, EXT4_IGET_NORMAL);
+	if (IS_ERR(inode)) {
+		ext4_msg(sb, KERN_ERR, "get orphan inode failed");
+		return PTR_ERR(inode);
+	}
+	oi->of_blocks = inode->i_size >> sb->s_blocksize_bits;
+	oi->of_csum_seed = EXT4_I(inode)->i_csum_seed;
+	oi->of_binfo = kmalloc(oi->of_blocks*sizeof(struct ext4_orphan_block),
+			       GFP_KERNEL);
+	if (!oi->of_binfo) {
+		ret = -ENOMEM;
+		goto out_put;
+	}
+	for (i = 0; i < oi->of_blocks; i++) {
+		oi->of_binfo[i].ob_bh = ext4_bread(NULL, inode, i, 0);
+		if (IS_ERR(oi->of_binfo[i].ob_bh)) {
+			ret = PTR_ERR(oi->of_binfo[i].ob_bh);
+			goto out_free;
+		}
+		if (!oi->of_binfo[i].ob_bh) {
+			ret = -EIO;
+			goto out_free;
+		}
+		ot = ext4_orphan_block_tail(sb, oi->of_binfo[i].ob_bh);
+		if (le32_to_cpu(ot->ob_magic) != EXT4_ORPHAN_BLOCK_MAGIC) {
+			ext4_error(sb, "orphan file block %d: bad magic", i);
+			ret = -EIO;
+			goto out_free;
+		}
+		if (!ext4_orphan_file_block_csum_verify(sb,
+						oi->of_binfo[i].ob_bh)) {
+			ext4_error(sb, "orphan file block %d: bad checksum", i);
+			ret = -EIO;
+			goto out_free;
+		}
+		bdata = (__le32 *)(oi->of_binfo[i].ob_bh->b_data);
+		free = 0;
+		for (j = 0; j < inodes_per_ob; j++)
+			if (bdata[j] == 0)
+				free++;
+		oi->of_binfo[i].ob_free_entries = free;
+	}
+	iput(inode);
+	return 0;
+out_free:
+	for (i--; i >= 0; i--)
+		brelse(oi->of_binfo[i].ob_bh);
+	kfree(oi->of_binfo);
+out_put:
+	iput(inode);
+	return ret;
+}
+
+int ext4_orphan_file_empty(struct super_block *sb)
+{
+	struct ext4_orphan_info *oi = &EXT4_SB(sb)->s_orphan_info;
+	int i;
+	int inodes_per_ob = ext4_inodes_per_orphan_block(sb);
+
+	if (!ext4_has_feature_orphan_file(sb))
+		return 1;
+	for (i = 0; i < oi->of_blocks; i++)
+		if (oi->of_binfo[i].ob_free_entries != inodes_per_ob)
+			return 0;
+	return 1;
+}
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index a7081d525faa..0715f5a5bb88 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1174,6 +1174,7 @@ static void ext4_put_super(struct super_block *sb)
 
 	flush_work(&sbi->s_error_work);
 	destroy_workqueue(sbi->rsv_conversion_wq);
+	ext4_release_orphan_info(sb);
 
 	/*
 	 * Unregister sysfs before destroying jbd2 journal.
@@ -1199,6 +1200,7 @@ static void ext4_put_super(struct super_block *sb)
 
 	if (!sb_rdonly(sb) && !aborted) {
 		ext4_clear_feature_journal_needs_recovery(sb);
+		ext4_clear_feature_orphan_present(sb);
 		es->s_state = cpu_to_le16(sbi->s_mount_state);
 	}
 	if (!sb_rdonly(sb))
@@ -2684,8 +2686,11 @@ static int ext4_setup_super(struct super_block *sb, struct ext4_super_block *es,
 		es->s_max_mnt_count = cpu_to_le16(EXT4_DFL_MAX_MNT_COUNT);
 	le16_add_cpu(&es->s_mnt_count, 1);
 	ext4_update_tstamp(es, s_mtime);
-	if (sbi->s_journal)
+	if (sbi->s_journal) {
 		ext4_set_feature_journal_needs_recovery(sb);
+		if (ext4_has_feature_orphan_file(sb))
+			ext4_set_feature_orphan_present(sb);
+	}
 
 	err = ext4_commit_super(sb);
 done:
@@ -3960,6 +3965,8 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 		silent = 1;
 		goto cantfind_ext4;
 	}
+	ext4_setup_csum_trigger(sb, EXT4_JTR_ORPHAN_FILE,
+				ext4_orphan_file_block_trigger);
 
 	/* Load the checksum driver */
 	sbi->s_chksum_driver = crypto_alloc_shash("crc32c", 0, 0);
@@ -4624,6 +4631,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_root = NULL;
 
 	needs_recovery = (es->s_last_orphan != 0 ||
+			  ext4_has_feature_orphan_present(sb) ||
 			  ext4_has_feature_journal_needs_recovery(sb));
 
 	if (ext4_has_feature_mmp(sb) && !sb_rdonly(sb))
@@ -4914,12 +4922,15 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	if (err)
 		goto failed_mount7;
 
+	err = ext4_init_orphan_info(sb);
+	if (err)
+		goto failed_mount8;
 #ifdef CONFIG_QUOTA
 	/* Enable quota usage during mount. */
 	if (ext4_has_feature_quota(sb) && !sb_rdonly(sb)) {
 		err = ext4_enable_quotas(sb);
 		if (err)
-			goto failed_mount8;
+			goto failed_mount9;
 	}
 #endif  /* CONFIG_QUOTA */
 
@@ -4938,7 +4949,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 		ext4_msg(sb, KERN_INFO, "recovery complete");
 		err = ext4_mark_recovery_complete(sb, es);
 		if (err)
-			goto failed_mount8;
+			goto failed_mount9;
 	}
 	if (EXT4_SB(sb)->s_journal) {
 		if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA)
@@ -4984,6 +4995,8 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 		ext4_msg(sb, KERN_ERR, "VFS: Can't find ext4 filesystem");
 	goto failed_mount;
 
+failed_mount9:
+	ext4_release_orphan_info(sb);
 failed_mount8:
 	ext4_unregister_sysfs(sb);
 	kobject_put(&sbi->s_kobj);
@@ -5494,8 +5507,15 @@ static int ext4_mark_recovery_complete(struct super_block *sb,
 	if (err < 0)
 		goto out;
 
-	if (ext4_has_feature_journal_needs_recovery(sb) && sb_rdonly(sb)) {
+	if (sb_rdonly(sb) && (ext4_has_feature_journal_needs_recovery(sb) ||
+	    ext4_has_feature_orphan_present(sb))) {
+		if (!ext4_orphan_file_empty(sb)) {
+			ext4_error(sb, "Orphan file not empty on read-only fs.");
+			err = -EFSCORRUPTED;
+			goto out;
+		}
 		ext4_clear_feature_journal_needs_recovery(sb);
+		ext4_clear_feature_orphan_present(sb);
 		ext4_commit_super(sb);
 	}
 out:
@@ -5638,6 +5658,8 @@ static int ext4_freeze(struct super_block *sb)
 
 		/* Journal blocked and flushed, clear needs_recovery flag. */
 		ext4_clear_feature_journal_needs_recovery(sb);
+		if (ext4_orphan_file_empty(sb))
+			ext4_clear_feature_orphan_present(sb);
 	}
 
 	error = ext4_commit_super(sb);
@@ -5660,6 +5682,8 @@ static int ext4_unfreeze(struct super_block *sb)
 	if (EXT4_SB(sb)->s_journal) {
 		/* Reset the needs_recovery flag before the fs is unlocked. */
 		ext4_set_feature_journal_needs_recovery(sb);
+		if (ext4_has_feature_orphan_file(sb))
+			ext4_set_feature_orphan_present(sb);
 	}
 
 	ext4_commit_super(sb);
@@ -5863,7 +5887,7 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 			 * around from a previously readonly bdev mount,
 			 * require a full umount/remount for now.
 			 */
-			if (es->s_last_orphan) {
+			if (es->s_last_orphan || !ext4_orphan_file_empty(sb)) {
 				ext4_msg(sb, KERN_WARNING, "Couldn't "
 				       "remount RDWR because of unprocessed "
 				       "orphan inode list.  Please "
-- 
2.26.2

