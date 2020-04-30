Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF3C91BE893
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Apr 2020 22:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgD2Ude (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Apr 2020 16:33:34 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:46724 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726481AbgD2Udd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 29 Apr 2020 16:33:33 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 29 Apr 2020 13:33:30 -0700
Received: from localhost.localdomain (ashwinh-vm-1.vmware.com [10.110.19.225])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id D382440F67;
        Wed, 29 Apr 2020 13:33:29 -0700 (PDT)
From:   ashwin-h <ashwinh@vmware.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>
CC:     <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@kernel.org>, <srivatsab@vmware.com>,
        <srivatsa@csail.mit.edu>, <rostedt@goodmis.org>,
        <srostedt@vmware.com>, <gregkh@linuxfoundation.org>,
        <ashwin.hiranniah@gmail.com>, Ashwin H <ashwinh@vmware.com>
Subject: [PATCH 1/5] ext4: avoid declaring fs inconsistent due to invalid file handles
Date:   Thu, 30 Apr 2020 09:52:03 +0530
Message-ID: <dd3e907bdc2b647b15a0197b202dcecb13ae0293.1588189373.git.ashwinh@vmware.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1588189373.git.ashwinh@vmware.com>
References: <cover.1588189373.git.ashwinh@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-002.vmware.com: ashwinh@vmware.com does not
 designate permitted sender hosts)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Theodore Ts'o <tytso@mit.edu>

commit 8a363970d1dc38c4ec4ad575c862f776f468d057 upstream.

If we receive a file handle, either from NFS or open_by_handle_at(2),
and it points at an inode which has not been initialized, and the file
system has metadata checksums enabled, we shouldn't try to get the
inode, discover the checksum is invalid, and then declare the file
system as being inconsistent.

This can be reproduced by creating a test file system via "mke2fs -t
ext4 -O metadata_csum /tmp/foo.img 8M", mounting it, cd'ing into that
directory, and then running the following program.

struct handle {
	struct file_handle fh;
	unsigned char fid[MAX_HANDLE_SZ];
};

int main(int argc, char **argv)
{
	struct handle h = {{8, 1 }, { 12, }};

	open_by_handle_at(AT_FDCWD, &h.fh, O_RDONLY);
	return 0;
}

Google-Bug-Id: 120690101
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Ashwin H <ashwinh@vmware.com>
Cc: stable@kernel.org
---
 fs/ext4/ext4.h   | 15 +++++++++++++--
 fs/ext4/ialloc.c |  2 +-
 fs/ext4/inode.c  | 49 ++++++++++++++++++++++++++++++++++---------------
 fs/ext4/ioctl.c  |  2 +-
 fs/ext4/namei.c  |  4 ++--
 fs/ext4/resize.c |  5 +++--
 fs/ext4/super.c  | 19 +++++--------------
 fs/ext4/xattr.c  |  5 +++--
 8 files changed, 62 insertions(+), 39 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 4aa0f8f..6c5b430 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2509,8 +2509,19 @@ int do_journal_get_write_access(handle_t *handle,
 #define FALL_BACK_TO_NONDELALLOC 1
 #define CONVERT_INLINE_DATA	 2
 
-extern struct inode *ext4_iget(struct super_block *, unsigned long);
-extern struct inode *ext4_iget_normal(struct super_block *, unsigned long);
+typedef enum {
+	EXT4_IGET_NORMAL =	0,
+	EXT4_IGET_SPECIAL =	0x0001, /* OK to iget a system inode */
+	EXT4_IGET_HANDLE = 	0x0002	/* Inode # is from a handle */
+} ext4_iget_flags;
+
+extern struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
+				 ext4_iget_flags flags, const char *function,
+				 unsigned int line);
+
+#define ext4_iget(sb, ino, flags) \
+	__ext4_iget((sb), (ino), (flags), __func__, __LINE__)
+
 extern int  ext4_write_inode(struct inode *, struct writeback_control *);
 extern int  ext4_setattr(struct dentry *, struct iattr *);
 extern int  ext4_getattr(const struct path *, struct kstat *, u32, unsigned int);
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 2a480c0..2daef32 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -1239,7 +1239,7 @@ struct inode *ext4_orphan_get(struct super_block *sb, unsigned long ino)
 	if (!ext4_test_bit(bit, bitmap_bh->b_data))
 		goto bad_orphan;
 
-	inode = ext4_iget(sb, ino);
+	inode = ext4_iget(sb, ino, EXT4_IGET_NORMAL);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		ext4_error(sb, "couldn't read orphan inode %lu (err %d)",
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 5b0d5ca..07476c1 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4695,7 +4695,9 @@ int ext4_get_projid(struct inode *inode, kprojid_t *projid)
 	return 0;
 }
 
-struct inode *ext4_iget(struct super_block *sb, unsigned long ino)
+struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
+			  ext4_iget_flags flags, const char *function,
+			  unsigned int line)
 {
 	struct ext4_iloc iloc;
 	struct ext4_inode *raw_inode;
@@ -4709,6 +4711,18 @@ struct inode *ext4_iget(struct super_block *sb, unsigned long ino)
 	gid_t i_gid;
 	projid_t i_projid;
 
+	if (((flags & EXT4_IGET_NORMAL) &&
+	     (ino < EXT4_FIRST_INO(sb) && ino != EXT4_ROOT_INO)) ||
+	    (ino < EXT4_ROOT_INO) ||
+	    (ino > le32_to_cpu(EXT4_SB(sb)->s_es->s_inodes_count))) {
+		if (flags & EXT4_IGET_HANDLE)
+			return ERR_PTR(-ESTALE);
+		__ext4_error(sb, function, line,
+			     "inode #%lu: comm %s: iget: illegal inode #",
+			     ino, current->comm);
+		return ERR_PTR(-EFSCORRUPTED);
+	}
+
 	inode = iget_locked(sb, ino);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
@@ -4724,18 +4738,26 @@ struct inode *ext4_iget(struct super_block *sb, unsigned long ino)
 	raw_inode = ext4_raw_inode(&iloc);
 
 	if ((ino == EXT4_ROOT_INO) && (raw_inode->i_links_count == 0)) {
-		EXT4_ERROR_INODE(inode, "root inode unallocated");
+		ext4_error_inode(inode, function, line, 0,
+				 "iget: root inode unallocated");
 		ret = -EFSCORRUPTED;
 		goto bad_inode;
 	}
 
+	if ((flags & EXT4_IGET_HANDLE) &&
+	    (raw_inode->i_links_count == 0) && (raw_inode->i_mode == 0)) {
+		ret = -ESTALE;
+		goto bad_inode;
+	}
+
 	if (EXT4_INODE_SIZE(inode->i_sb) > EXT4_GOOD_OLD_INODE_SIZE) {
 		ei->i_extra_isize = le16_to_cpu(raw_inode->i_extra_isize);
 		if (EXT4_GOOD_OLD_INODE_SIZE + ei->i_extra_isize >
 			EXT4_INODE_SIZE(inode->i_sb) ||
 		    (ei->i_extra_isize & 3)) {
-			EXT4_ERROR_INODE(inode,
-					 "bad extra_isize %u (inode size %u)",
+			ext4_error_inode(inode, function, line, 0,
+					 "iget: bad extra_isize %u "
+					 "(inode size %u)",
 					 ei->i_extra_isize,
 					 EXT4_INODE_SIZE(inode->i_sb));
 			ret = -EFSCORRUPTED;
@@ -4757,7 +4779,8 @@ struct inode *ext4_iget(struct super_block *sb, unsigned long ino)
 	}
 
 	if (!ext4_inode_csum_verify(inode, raw_inode, ei)) {
-		EXT4_ERROR_INODE(inode, "checksum invalid");
+		ext4_error_inode(inode, function, line, 0,
+				 "iget: checksum invalid");
 		ret = -EFSBADCRC;
 		goto bad_inode;
 	}
@@ -4813,7 +4836,8 @@ struct inode *ext4_iget(struct super_block *sb, unsigned long ino)
 			((__u64)le16_to_cpu(raw_inode->i_file_acl_high)) << 32;
 	inode->i_size = ext4_isize(sb, raw_inode);
 	if ((size = i_size_read(inode)) < 0) {
-		EXT4_ERROR_INODE(inode, "bad i_size value: %lld", size);
+		ext4_error_inode(inode, function, line, 0,
+				 "iget: bad i_size value: %lld", size);
 		ret = -EFSCORRUPTED;
 		goto bad_inode;
 	}
@@ -4899,7 +4923,8 @@ struct inode *ext4_iget(struct super_block *sb, unsigned long ino)
 	ret = 0;
 	if (ei->i_file_acl &&
 	    !ext4_data_block_valid(EXT4_SB(sb), ei->i_file_acl, 1)) {
-		EXT4_ERROR_INODE(inode, "bad extended attribute block %llu",
+		ext4_error_inode(inode, function, line, 0,
+				 "iget: bad extended attribute block %llu",
 				 ei->i_file_acl);
 		ret = -EFSCORRUPTED;
 		goto bad_inode;
@@ -4954,7 +4979,8 @@ struct inode *ext4_iget(struct super_block *sb, unsigned long ino)
 		make_bad_inode(inode);
 	} else {
 		ret = -EFSCORRUPTED;
-		EXT4_ERROR_INODE(inode, "bogus i_mode (%o)", inode->i_mode);
+		ext4_error_inode(inode, function, line, 0,
+				 "iget: bogus i_mode (%o)", inode->i_mode);
 		goto bad_inode;
 	}
 	brelse(iloc.bh);
@@ -4969,13 +4995,6 @@ struct inode *ext4_iget(struct super_block *sb, unsigned long ino)
 	return ERR_PTR(ret);
 }
 
-struct inode *ext4_iget_normal(struct super_block *sb, unsigned long ino)
-{
-	if (ino < EXT4_FIRST_INO(sb) && ino != EXT4_ROOT_INO)
-		return ERR_PTR(-EFSCORRUPTED);
-	return ext4_iget(sb, ino);
-}
-
 static int ext4_inode_blocks_set(handle_t *handle,
 				struct ext4_inode *raw_inode,
 				struct ext4_inode_info *ei)
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 82e118e..9dbb554 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -111,7 +111,7 @@ static long swap_inode_boot_loader(struct super_block *sb,
 	if (!inode_owner_or_capable(inode) || !capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	inode_bl = ext4_iget(sb, EXT4_BOOT_LOADER_INO);
+	inode_bl = ext4_iget(sb, EXT4_BOOT_LOADER_INO, EXT4_IGET_SPECIAL);
 	if (IS_ERR(inode_bl))
 		return PTR_ERR(inode_bl);
 	ei_bl = EXT4_I(inode_bl);
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 3f7b383..161099f 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1597,7 +1597,7 @@ static struct dentry *ext4_lookup(struct inode *dir, struct dentry *dentry, unsi
 					 dentry);
 			return ERR_PTR(-EFSCORRUPTED);
 		}
-		inode = ext4_iget_normal(dir->i_sb, ino);
+		inode = ext4_iget(dir->i_sb, ino, EXT4_IGET_NORMAL);
 		if (inode == ERR_PTR(-ESTALE)) {
 			EXT4_ERROR_INODE(dir,
 					 "deleted inode referenced: %u",
@@ -1639,7 +1639,7 @@ struct dentry *ext4_get_parent(struct dentry *child)
 		return ERR_PTR(-EFSCORRUPTED);
 	}
 
-	return d_obtain_alias(ext4_iget_normal(child->d_sb, ino));
+	return d_obtain_alias(ext4_iget(child->d_sb, ino, EXT4_IGET_NORMAL));
 }
 
 /*
diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index d42f747..19af346 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -1652,7 +1652,7 @@ int ext4_group_add(struct super_block *sb, struct ext4_new_group_data *input)
 				     "No reserved GDT blocks, can't resize");
 			return -EPERM;
 		}
-		inode = ext4_iget(sb, EXT4_RESIZE_INO);
+		inode = ext4_iget(sb, EXT4_RESIZE_INO, EXT4_IGET_SPECIAL);
 		if (IS_ERR(inode)) {
 			ext4_warning(sb, "Error opening resize inode");
 			return PTR_ERR(inode);
@@ -1980,7 +1980,8 @@ int ext4_resize_fs(struct super_block *sb, ext4_fsblk_t n_blocks_count)
 		}
 
 		if (!resize_inode)
-			resize_inode = ext4_iget(sb, EXT4_RESIZE_INO);
+			resize_inode = ext4_iget(sb, EXT4_RESIZE_INO,
+						 EXT4_IGET_SPECIAL);
 		if (IS_ERR(resize_inode)) {
 			ext4_warning(sb, "Error opening resize inode");
 			return PTR_ERR(resize_inode);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 0ced133..086fcbe 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1126,20 +1126,11 @@ static struct inode *ext4_nfs_get_inode(struct super_block *sb,
 {
 	struct inode *inode;
 
-	if (ino < EXT4_FIRST_INO(sb) && ino != EXT4_ROOT_INO)
-		return ERR_PTR(-ESTALE);
-	if (ino > le32_to_cpu(EXT4_SB(sb)->s_es->s_inodes_count))
-		return ERR_PTR(-ESTALE);
-
-	/* iget isn't really right if the inode is currently unallocated!!
-	 *
-	 * ext4_read_inode will return a bad_inode if the inode had been
-	 * deleted, so we should be safe.
-	 *
+	/*
 	 * Currently we don't know the generation for parent directory, so
 	 * a generation of 0 means "accept any"
 	 */
-	inode = ext4_iget_normal(sb, ino);
+	inode = ext4_iget(sb, ino, EXT4_IGET_HANDLE);
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
 	if (generation && inode->i_generation != generation) {
@@ -4370,7 +4361,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	 * so we can safely mount the rest of the filesystem now.
 	 */
 
-	root = ext4_iget(sb, EXT4_ROOT_INO);
+	root = ext4_iget(sb, EXT4_ROOT_INO, EXT4_IGET_SPECIAL);
 	if (IS_ERR(root)) {
 		ext4_msg(sb, KERN_ERR, "get root inode failed");
 		ret = PTR_ERR(root);
@@ -4620,7 +4611,7 @@ static struct inode *ext4_get_journal_inode(struct super_block *sb,
 	 * happen if we iget() an unused inode, as the subsequent iput()
 	 * will try to delete it.
 	 */
-	journal_inode = ext4_iget(sb, journal_inum);
+	journal_inode = ext4_iget(sb, journal_inum, EXT4_IGET_SPECIAL);
 	if (IS_ERR(journal_inode)) {
 		ext4_msg(sb, KERN_ERR, "no journal found");
 		return NULL;
@@ -5693,7 +5684,7 @@ static int ext4_quota_enable(struct super_block *sb, int type, int format_id,
 	if (!qf_inums[type])
 		return -EPERM;
 
-	qf_inode = ext4_iget(sb, qf_inums[type]);
+	qf_inode = ext4_iget(sb, qf_inums[type], EXT4_IGET_SPECIAL);
 	if (IS_ERR(qf_inode)) {
 		ext4_error(sb, "Bad quota inode # %lu", qf_inums[type]);
 		return PTR_ERR(qf_inode);
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index f2fde3ac..b0873b8 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -383,7 +383,7 @@ static int ext4_xattr_inode_iget(struct inode *parent, unsigned long ea_ino,
 	struct inode *inode;
 	int err;
 
-	inode = ext4_iget(parent->i_sb, ea_ino);
+	inode = ext4_iget(parent->i_sb, ea_ino, EXT4_IGET_NORMAL);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		ext4_error(parent->i_sb,
@@ -1486,7 +1486,8 @@ ext4_xattr_inode_cache_find(struct inode *inode, const void *value,
 	}
 
 	while (ce) {
-		ea_inode = ext4_iget(inode->i_sb, ce->e_value);
+		ea_inode = ext4_iget(inode->i_sb, ce->e_value,
+				     EXT4_IGET_NORMAL);
 		if (!IS_ERR(ea_inode) &&
 		    !is_bad_inode(ea_inode) &&
 		    (EXT4_I(ea_inode)->i_flags & EXT4_EA_INODE_FL) &&
-- 
2.7.4

