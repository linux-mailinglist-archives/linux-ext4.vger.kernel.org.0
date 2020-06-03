Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76C6F1EC998
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Jun 2020 08:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgFCGft (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 Jun 2020 02:35:49 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5845 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725855AbgFCGft (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 3 Jun 2020 02:35:49 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3A14D1A3D55755178FAE
        for <linux-ext4@vger.kernel.org>; Wed,  3 Jun 2020 14:35:47 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Wed, 3 Jun 2020
 14:35:38 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <jack@suse.cz>, <yi.zhang@huawei.com>
Subject: [PATCH v2 1/2] ext2: propagate errors up to ext2_find_entry()'s callers
Date:   Wed, 3 Jun 2020 14:35:13 +0800
Message-ID: <20200603063514.3904811-1-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The same to commit <36de928641ee4> (ext4: propagate errors up to
ext4_find_entry()'s callers') in ext4, also return error instead of NULL
pointer in case of some error happens in ext2_find_entry() (e.g. -ENOMEM
or -EIO). This could avoid a negative dentry cache entry installed even
it failed to read directory block due to IO error.

Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
---
Changes since v1:
 - Remove ret parameter in ext2_find_entry().

 fs/ext2/dir.c   | 53 ++++++++++++++++++++++++-------------------------
 fs/ext2/ext2.h  |  3 ++-
 fs/ext2/namei.c | 32 +++++++++++++++++++++++------
 3 files changed, 54 insertions(+), 34 deletions(-)

diff --git a/fs/ext2/dir.c b/fs/ext2/dir.c
index 13318e255ebf..95e4f0bd55a3 100644
--- a/fs/ext2/dir.c
+++ b/fs/ext2/dir.c
@@ -348,7 +348,6 @@ struct ext2_dir_entry_2 *ext2_find_entry (struct inode *dir,
 	struct page *page = NULL;
 	struct ext2_inode_info *ei = EXT2_I(dir);
 	ext2_dirent * de;
-	int dir_has_error = 0;
 
 	if (npages == 0)
 		goto out;
@@ -362,25 +361,25 @@ struct ext2_dir_entry_2 *ext2_find_entry (struct inode *dir,
 	n = start;
 	do {
 		char *kaddr;
-		page = ext2_get_page(dir, n, dir_has_error);
-		if (!IS_ERR(page)) {
-			kaddr = page_address(page);
-			de = (ext2_dirent *) kaddr;
-			kaddr += ext2_last_byte(dir, n) - reclen;
-			while ((char *) de <= kaddr) {
-				if (de->rec_len == 0) {
-					ext2_error(dir->i_sb, __func__,
-						"zero-length directory entry");
-					ext2_put_page(page);
-					goto out;
-				}
-				if (ext2_match (namelen, name, de))
-					goto found;
-				de = ext2_next_entry(de);
+		page = ext2_get_page(dir, n, 0);
+		if (IS_ERR(page))
+			return ERR_CAST(page);
+
+		kaddr = page_address(page);
+		de = (ext2_dirent *) kaddr;
+		kaddr += ext2_last_byte(dir, n) - reclen;
+		while ((char *) de <= kaddr) {
+			if (de->rec_len == 0) {
+				ext2_error(dir->i_sb, __func__,
+					"zero-length directory entry");
+				ext2_put_page(page);
+				goto out;
 			}
-			ext2_put_page(page);
-		} else
-			dir_has_error = 1;
+			if (ext2_match(namelen, name, de))
+				goto found;
+			de = ext2_next_entry(de);
+		}
+		ext2_put_page(page);
 
 		if (++n >= npages)
 			n = 0;
@@ -414,18 +413,18 @@ struct ext2_dir_entry_2 * ext2_dotdot (struct inode *dir, struct page **p)
 	return de;
 }
 
-ino_t ext2_inode_by_name(struct inode *dir, const struct qstr *child)
+int ext2_inode_by_name(struct inode *dir, const struct qstr *child, ino_t *ino)
 {
-	ino_t res = 0;
 	struct ext2_dir_entry_2 *de;
 	struct page *page;
 	
-	de = ext2_find_entry (dir, child, &page);
-	if (de) {
-		res = le32_to_cpu(de->inode);
-		ext2_put_page(page);
-	}
-	return res;
+	de = ext2_find_entry(dir, child, &page);
+	if (IS_ERR_OR_NULL(de))
+		return PTR_ERR(de);
+
+	*ino = le32_to_cpu(de->inode);
+	ext2_put_page(page);
+	return 0;
 }
 
 static int ext2_prepare_chunk(struct page *page, loff_t pos, unsigned len)
diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
index 8178bd38a9d6..a321ff9bf1b4 100644
--- a/fs/ext2/ext2.h
+++ b/fs/ext2/ext2.h
@@ -738,7 +738,8 @@ extern void ext2_rsv_window_add(struct super_block *sb, struct ext2_reserve_wind
 
 /* dir.c */
 extern int ext2_add_link (struct dentry *, struct inode *);
-extern ino_t ext2_inode_by_name(struct inode *, const struct qstr *);
+extern int ext2_inode_by_name(struct inode *dir,
+			      const struct qstr *child, ino_t *ino);
 extern int ext2_make_empty(struct inode *, struct inode *);
 extern struct ext2_dir_entry_2 * ext2_find_entry (struct inode *,const struct qstr *, struct page **);
 extern int ext2_delete_entry (struct ext2_dir_entry_2 *, struct page *);
diff --git a/fs/ext2/namei.c b/fs/ext2/namei.c
index ccfbbf59e2fc..4b38e558d477 100644
--- a/fs/ext2/namei.c
+++ b/fs/ext2/namei.c
@@ -56,12 +56,15 @@ static inline int ext2_add_nondir(struct dentry *dentry, struct inode *inode)
 static struct dentry *ext2_lookup(struct inode * dir, struct dentry *dentry, unsigned int flags)
 {
 	struct inode * inode;
-	ino_t ino;
+	ino_t ino = 0;
+	int res;
 	
 	if (dentry->d_name.len > EXT2_NAME_LEN)
 		return ERR_PTR(-ENAMETOOLONG);
 
-	ino = ext2_inode_by_name(dir, &dentry->d_name);
+	res = ext2_inode_by_name(dir, &dentry->d_name, &ino);
+	if (res)
+		return ERR_PTR(res);
 	inode = NULL;
 	if (ino) {
 		inode = ext2_iget(dir->i_sb, ino);
@@ -78,7 +81,12 @@ static struct dentry *ext2_lookup(struct inode * dir, struct dentry *dentry, uns
 struct dentry *ext2_get_parent(struct dentry *child)
 {
 	struct qstr dotdot = QSTR_INIT("..", 2);
-	unsigned long ino = ext2_inode_by_name(d_inode(child), &dotdot);
+	ino_t ino = 0;
+	int res;
+
+	res = ext2_inode_by_name(d_inode(child), &dotdot, &ino);
+	if (res)
+		return ERR_PTR(res);
 	if (!ino)
 		return ERR_PTR(-ENOENT);
 	return d_obtain_alias(ext2_iget(child->d_sb, ino));
@@ -276,7 +284,11 @@ static int ext2_unlink(struct inode * dir, struct dentry *dentry)
 	if (err)
 		goto out;
 
-	de = ext2_find_entry (dir, &dentry->d_name, &page);
+	de = ext2_find_entry(dir, &dentry->d_name, &page);
+	if (IS_ERR(de)) {
+		err = PTR_ERR(de);
+		goto out;
+	}
 	if (!de) {
 		err = -ENOENT;
 		goto out;
@@ -332,7 +344,11 @@ static int ext2_rename (struct inode * old_dir, struct dentry * old_dentry,
 	if (err)
 		goto out;
 
-	old_de = ext2_find_entry (old_dir, &old_dentry->d_name, &old_page);
+	old_de = ext2_find_entry(old_dir, &old_dentry->d_name, &old_page);
+	if (IS_ERR(old_de)) {
+		err = PTR_ERR(old_de);
+		goto out;
+	}
 	if (!old_de) {
 		err = -ENOENT;
 		goto out;
@@ -354,7 +370,11 @@ static int ext2_rename (struct inode * old_dir, struct dentry * old_dentry,
 			goto out_dir;
 
 		err = -ENOENT;
-		new_de = ext2_find_entry (new_dir, &new_dentry->d_name, &new_page);
+		new_de = ext2_find_entry(new_dir, &new_dentry->d_name, &new_page);
+		if (IS_ERR(new_de)) {
+			err = PTR_ERR(new_de);
+			goto out_dir;
+		}
 		if (!new_de)
 			goto out_dir;
 		ext2_set_link(new_dir, new_de, new_page, old_inode, 1);
-- 
2.25.4

