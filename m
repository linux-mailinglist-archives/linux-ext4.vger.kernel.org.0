Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F38504C97
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Apr 2022 08:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235672AbiDRGZ4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 18 Apr 2022 02:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbiDRGZz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 18 Apr 2022 02:25:55 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAAF18B20
        for <linux-ext4@vger.kernel.org>; Sun, 17 Apr 2022 23:23:16 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KhcL02fXYz1GCXr;
        Mon, 18 Apr 2022 14:22:32 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 18 Apr
 2022 14:23:13 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>, <yebin10@huawei.com>
Subject: [RFC PATCH v3] ext4: convert symlink external data block mapping to bdev
Date:   Mon, 18 Apr 2022 14:37:35 +0800
Message-ID: <20220418063735.2067766-1-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Symlink's external data block is one kind of metadata block, and now
that almost all ext4 metadata block's page cache (e.g. directory blocks,
quota blocks...) belongs to bdev backing inode except the symlink. It
is essentially worked in data=journal mode like other regular file's
data block because probably in order to make it simple for generic VFS
code handling symlinks or some other historical reasons, but the logic
of creating external data block in ext4_symlink() is complicated. and it
also make things confused if user do not want to let the filesystem
worked in data=journal mode. This patch convert the final exceptional
case and make things clean, move the mapping of the symlink's external
data block to bdev like any other metadata block does.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
v3-v2:
 - Retry if it fail in close-to-ENOSPC conditions.
 - Use ext4_add_nondir() to add dir entry for no-fast symlink.
 - Fix RCU walking for symlinks.
 - Ensure nul-terminate when in ext4_get_link().
v2->v1:
 - Add comment to explain the credits of creating symlink.

[v2]: https://lore.kernel.org/linux-ext4/20220412083941.2242143-1-yi.zhang@huawei.com/
[v1]: https://lore.kernel.org/linux-ext4/20220406084503.1961686-1-yi.zhang@huawei.com/

 fs/ext4/inode.c   |   9 +---
 fs/ext4/namei.c   | 123 +++++++++++++++++++++-------------------------
 fs/ext4/symlink.c |  54 +++++++++++++++++---
 3 files changed, 103 insertions(+), 83 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 13740f2d0e61..a6339cefbb1e 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -199,8 +199,7 @@ void ext4_evict_inode(struct inode *inode)
 		 */
 		if (inode->i_ino != EXT4_JOURNAL_INO &&
 		    ext4_should_journal_data(inode) &&
-		    (S_ISLNK(inode->i_mode) || S_ISREG(inode->i_mode)) &&
-		    inode->i_data.nrpages) {
+		    S_ISREG(inode->i_mode) && inode->i_data.nrpages) {
 			journal_t *journal = EXT4_SB(inode->i_sb)->s_journal;
 			tid_t commit_tid = EXT4_I(inode)->i_datasync_tid;
 
@@ -2944,8 +2943,7 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
 
 	index = pos >> PAGE_SHIFT;
 
-	if (ext4_nonda_switch(inode->i_sb) || S_ISLNK(inode->i_mode) ||
-	    ext4_verity_in_progress(inode)) {
+	if (ext4_nonda_switch(inode->i_sb) || ext4_verity_in_progress(inode)) {
 		*fsdata = (void *)FALL_BACK_TO_NONDELALLOC;
 		return ext4_write_begin(file, mapping, pos,
 					len, flags, pagep, fsdata);
@@ -4977,7 +4975,6 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 		}
 		if (IS_ENCRYPTED(inode)) {
 			inode->i_op = &ext4_encrypted_symlink_inode_operations;
-			ext4_set_aops(inode);
 		} else if (ext4_inode_is_fast_symlink(inode)) {
 			inode->i_link = (char *)ei->i_data;
 			inode->i_op = &ext4_fast_symlink_inode_operations;
@@ -4985,9 +4982,7 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 				sizeof(ei->i_data) - 1);
 		} else {
 			inode->i_op = &ext4_symlink_inode_operations;
-			ext4_set_aops(inode);
 		}
-		inode_nohighmem(inode);
 	} else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode) ||
 	      S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
 		inode->i_op = &ext4_special_inode_operations;
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index e37da8d5cd0c..dbb6294914bc 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -3249,6 +3249,32 @@ static int ext4_unlink(struct inode *dir, struct dentry *dentry)
 	return retval;
 }
 
+static int ext4_init_symlink_block(handle_t *handle, struct inode *inode,
+				   struct fscrypt_str *disk_link)
+{
+	struct buffer_head *bh;
+	char *kaddr;
+	int err = 0;
+
+	bh = ext4_bread(handle, inode, 0, EXT4_GET_BLOCKS_CREATE);
+	if (IS_ERR(bh))
+		return PTR_ERR(bh);
+
+	BUFFER_TRACE(bh, "get_write_access");
+	err = ext4_journal_get_write_access(handle, inode->i_sb, bh, EXT4_JTR_NONE);
+	if (err)
+		goto out;
+
+	kaddr = (char *)bh->b_data;
+	memcpy(kaddr, disk_link->name, disk_link->len);
+	inode->i_size = disk_link->len - 1;
+	EXT4_I(inode)->i_disksize = inode->i_size;
+	err = ext4_handle_dirty_metadata(handle, inode, bh);
+out:
+	brelse(bh);
+	return err;
+}
+
 static int ext4_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 			struct dentry *dentry, const char *symname)
 {
@@ -3257,6 +3283,7 @@ static int ext4_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 	int err, len = strlen(symname);
 	int credits;
 	struct fscrypt_str disk_link;
+	int retries = 0;
 
 	if (unlikely(ext4_forced_shutdown(EXT4_SB(dir->i_sb))))
 		return -EIO;
@@ -3270,26 +3297,15 @@ static int ext4_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 	if (err)
 		return err;
 
-	if ((disk_link.len > EXT4_N_BLOCKS * 4)) {
-		/*
-		 * For non-fast symlinks, we just allocate inode and put it on
-		 * orphan list in the first transaction => we need bitmap,
-		 * group descriptor, sb, inode block, quota blocks, and
-		 * possibly selinux xattr blocks.
-		 */
-		credits = 4 + EXT4_MAXQUOTAS_INIT_BLOCKS(dir->i_sb) +
-			  EXT4_XATTR_TRANS_BLOCKS;
-	} else {
-		/*
-		 * Fast symlink. We have to add entry to directory
-		 * (EXT4_DATA_TRANS_BLOCKS + EXT4_INDEX_EXTRA_TRANS_BLOCKS),
-		 * allocate new inode (bitmap, group descriptor, inode block,
-		 * quota blocks, sb is already counted in previous macros).
-		 */
-		credits = EXT4_DATA_TRANS_BLOCKS(dir->i_sb) +
-			  EXT4_INDEX_EXTRA_TRANS_BLOCKS + 3;
-	}
-
+	/*
+	 * EXT4_INDEX_EXTRA_TRANS_BLOCKS for addition of entry into the
+	 * directory. +3 for inode, inode bitmap, group descriptor allocation.
+	 * EXT4_DATA_TRANS_BLOCKS for the data block allocation and
+	 * modification.
+	 */
+	credits = EXT4_DATA_TRANS_BLOCKS(dir->i_sb) +
+		  EXT4_INDEX_EXTRA_TRANS_BLOCKS + 3;
+retry:
 	inode = ext4_new_inode_start_handle(mnt_userns, dir, S_IFLNK|S_IRWXUGO,
 					    &dentry->d_name, 0, NULL,
 					    EXT4_HT_DIR, credits);
@@ -3297,7 +3313,8 @@ static int ext4_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 	if (IS_ERR(inode)) {
 		if (handle)
 			ext4_journal_stop(handle);
-		return PTR_ERR(inode);
+		err = PTR_ERR(inode);
+		goto out_retry;
 	}
 
 	if (IS_ENCRYPTED(inode)) {
@@ -3305,75 +3322,45 @@ static int ext4_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 		if (err)
 			goto err_drop_inode;
 		inode->i_op = &ext4_encrypted_symlink_inode_operations;
+	} else {
+		if ((disk_link.len > EXT4_N_BLOCKS * 4)) {
+			inode->i_op = &ext4_symlink_inode_operations;
+		} else {
+			inode->i_op = &ext4_fast_symlink_inode_operations;
+			inode->i_link = (char *)&EXT4_I(inode)->i_data;
+		}
 	}
 
 	if ((disk_link.len > EXT4_N_BLOCKS * 4)) {
-		if (!IS_ENCRYPTED(inode))
-			inode->i_op = &ext4_symlink_inode_operations;
-		inode_nohighmem(inode);
-		ext4_set_aops(inode);
-		/*
-		 * We cannot call page_symlink() with transaction started
-		 * because it calls into ext4_write_begin() which can wait
-		 * for transaction commit if we are running out of space
-		 * and thus we deadlock. So we have to stop transaction now
-		 * and restart it when symlink contents is written.
-		 *
-		 * To keep fs consistent in case of crash, we have to put inode
-		 * to orphan list in the mean time.
-		 */
-		drop_nlink(inode);
-		err = ext4_orphan_add(handle, inode);
-		if (handle)
-			ext4_journal_stop(handle);
-		handle = NULL;
-		if (err)
-			goto err_drop_inode;
-		err = __page_symlink(inode, disk_link.name, disk_link.len, 1);
-		if (err)
-			goto err_drop_inode;
-		/*
-		 * Now inode is being linked into dir (EXT4_DATA_TRANS_BLOCKS
-		 * + EXT4_INDEX_EXTRA_TRANS_BLOCKS), inode is also modified
-		 */
-		handle = ext4_journal_start(dir, EXT4_HT_DIR,
-				EXT4_DATA_TRANS_BLOCKS(dir->i_sb) +
-				EXT4_INDEX_EXTRA_TRANS_BLOCKS + 1);
-		if (IS_ERR(handle)) {
-			err = PTR_ERR(handle);
-			handle = NULL;
-			goto err_drop_inode;
-		}
-		set_nlink(inode, 1);
-		err = ext4_orphan_del(handle, inode);
+		/* alloc symlink block and fill it */
+		err = ext4_init_symlink_block(handle, inode, &disk_link);
 		if (err)
 			goto err_drop_inode;
 	} else {
 		/* clear the extent format for fast symlink */
 		ext4_clear_inode_flag(inode, EXT4_INODE_EXTENTS);
-		if (!IS_ENCRYPTED(inode)) {
-			inode->i_op = &ext4_fast_symlink_inode_operations;
-			inode->i_link = (char *)&EXT4_I(inode)->i_data;
-		}
 		memcpy((char *)&EXT4_I(inode)->i_data, disk_link.name,
 		       disk_link.len);
 		inode->i_size = disk_link.len - 1;
+		EXT4_I(inode)->i_disksize = inode->i_size;
 	}
-	EXT4_I(inode)->i_disksize = inode->i_size;
 	err = ext4_add_nondir(handle, dentry, &inode);
 	if (handle)
 		ext4_journal_stop(handle);
 	if (inode)
 		iput(inode);
-	goto out_free_encrypted_link;
+	goto out_retry;
 
 err_drop_inode:
-	if (handle)
-		ext4_journal_stop(handle);
 	clear_nlink(inode);
+	ext4_orphan_add(handle, inode);
 	unlock_new_inode(inode);
+	if (handle)
+		ext4_journal_stop(handle);
 	iput(inode);
-out_free_encrypted_link:
+out_retry:
+	if (err == -ENOSPC && ext4_should_retry_alloc(dir->i_sb, &retries))
+		goto retry;
 	if (disk_link.name != (unsigned char *)symname)
 		kfree(disk_link.name);
 	return err;
diff --git a/fs/ext4/symlink.c b/fs/ext4/symlink.c
index 69109746e6e2..af9a613ed3b2 100644
--- a/fs/ext4/symlink.c
+++ b/fs/ext4/symlink.c
@@ -27,7 +27,7 @@ static const char *ext4_encrypted_get_link(struct dentry *dentry,
 					   struct inode *inode,
 					   struct delayed_call *done)
 {
-	struct page *cpage = NULL;
+	struct buffer_head *bh = NULL;
 	const void *caddr;
 	unsigned int max_size;
 	const char *paddr;
@@ -39,16 +39,19 @@ static const char *ext4_encrypted_get_link(struct dentry *dentry,
 		caddr = EXT4_I(inode)->i_data;
 		max_size = sizeof(EXT4_I(inode)->i_data);
 	} else {
-		cpage = read_mapping_page(inode->i_mapping, 0, NULL);
-		if (IS_ERR(cpage))
-			return ERR_CAST(cpage);
-		caddr = page_address(cpage);
+		bh = ext4_bread(NULL, inode, 0, 0);
+		if (IS_ERR(bh))
+			return ERR_CAST(bh);
+		if (!bh) {
+			EXT4_ERROR_INODE(inode, "bad symlink.");
+			return ERR_PTR(-EFSCORRUPTED);
+		}
+		caddr = bh->b_data;
 		max_size = inode->i_sb->s_blocksize;
 	}
 
 	paddr = fscrypt_get_symlink(inode, caddr, max_size, done);
-	if (cpage)
-		put_page(cpage);
+	brelse(bh);
 	return paddr;
 }
 
@@ -62,6 +65,41 @@ static int ext4_encrypted_symlink_getattr(struct user_namespace *mnt_userns,
 	return fscrypt_symlink_getattr(path, stat);
 }
 
+static void ext4_free_link(void *bh)
+{
+	brelse(bh);
+}
+
+static const char *ext4_get_link(struct dentry *dentry, struct inode *inode,
+				 struct delayed_call *callback)
+{
+	struct buffer_head *bh;
+
+	if (!dentry) {
+		bh = ext4_getblk(NULL, inode, 0, 0);
+		if (!bh || IS_ERR(bh))
+			goto error_out;
+		if (!ext4_buffer_uptodate(bh))
+			return ERR_PTR(-ECHILD);
+	} else {
+		bh = ext4_bread(NULL, inode, 0, 0);
+		if (!bh || IS_ERR(bh))
+			goto error_out;
+	}
+
+	set_delayed_call(callback, ext4_free_link, bh);
+	nd_terminate_link(bh->b_data, inode->i_size,
+			  inode->i_sb->s_blocksize - 1);
+	return bh->b_data;
+
+error_out:
+	if (!bh) {
+		EXT4_ERROR_INODE(inode, "bad symlink.");
+		return ERR_PTR(-EFSCORRUPTED);
+	}
+	return ERR_CAST(bh);
+}
+
 const struct inode_operations ext4_encrypted_symlink_inode_operations = {
 	.get_link	= ext4_encrypted_get_link,
 	.setattr	= ext4_setattr,
@@ -70,7 +108,7 @@ const struct inode_operations ext4_encrypted_symlink_inode_operations = {
 };
 
 const struct inode_operations ext4_symlink_inode_operations = {
-	.get_link	= page_get_link,
+	.get_link	= ext4_get_link,
 	.setattr	= ext4_setattr,
 	.getattr	= ext4_getattr,
 	.listxattr	= ext4_listxattr,
-- 
2.31.1

