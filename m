Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C361F11A5
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Jun 2020 05:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbgFHDNU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 7 Jun 2020 23:13:20 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55164 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728065AbgFHDNU (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 7 Jun 2020 23:13:20 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5FB26F1A88578CC055FB
        for <linux-ext4@vger.kernel.org>; Mon,  8 Jun 2020 11:13:18 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Mon, 8 Jun 2020
 11:13:07 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <jack@suse.cz>, <yi.zhang@huawei.com>
Subject: [PATCH v3 2/2] ext2: ext2_find_entry() return -ENOENT if no entry found
Date:   Mon, 8 Jun 2020 11:40:43 +0800
Message-ID: <20200608034043.10451-2-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200608034043.10451-1-yi.zhang@huawei.com>
References: <20200608034043.10451-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Almost all callers of ext2_find_entry() transform NULL return value to
-ENOENT, so just let ext2_find_entry() retuen -ENOENT instead of NULL
if no valid entry found, and also switch to check the return value of
ext2_inode_by_name() in ext2_lookup() and ext2_get_parent().

Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
Suggested-by: Jan Kara <jack@suse.cz>
---
v2 -> v3:
 - Remove "de->inode == 0" checking.

 fs/ext2/dir.c   |  4 ++--
 fs/ext2/namei.c | 27 ++++++++-------------------
 2 files changed, 10 insertions(+), 21 deletions(-)

diff --git a/fs/ext2/dir.c b/fs/ext2/dir.c
index 95e4f0bd55a3..70355ab6740e 100644
--- a/fs/ext2/dir.c
+++ b/fs/ext2/dir.c
@@ -393,7 +393,7 @@ struct ext2_dir_entry_2 *ext2_find_entry (struct inode *dir,
 		}
 	} while (n != start);
 out:
-	return NULL;
+	return ERR_PTR(-ENOENT);
 
 found:
 	*res_page = page;
@@ -419,7 +419,7 @@ int ext2_inode_by_name(struct inode *dir, const struct qstr *child, ino_t *ino)
 	struct page *page;
 	
 	de = ext2_find_entry(dir, child, &page);
-	if (IS_ERR_OR_NULL(de))
+	if (IS_ERR(de))
 		return PTR_ERR(de);
 
 	*ino = le32_to_cpu(de->inode);
diff --git a/fs/ext2/namei.c b/fs/ext2/namei.c
index 4b38e558d477..9601d469c5b1 100644
--- a/fs/ext2/namei.c
+++ b/fs/ext2/namei.c
@@ -56,17 +56,18 @@ static inline int ext2_add_nondir(struct dentry *dentry, struct inode *inode)
 static struct dentry *ext2_lookup(struct inode * dir, struct dentry *dentry, unsigned int flags)
 {
 	struct inode * inode;
-	ino_t ino = 0;
+	ino_t ino;
 	int res;
 	
 	if (dentry->d_name.len > EXT2_NAME_LEN)
 		return ERR_PTR(-ENAMETOOLONG);
 
 	res = ext2_inode_by_name(dir, &dentry->d_name, &ino);
-	if (res)
-		return ERR_PTR(res);
-	inode = NULL;
-	if (ino) {
+	if (res) {
+		if (res != -ENOENT)
+			return ERR_PTR(res);
+		inode = NULL;
+	} else {
 		inode = ext2_iget(dir->i_sb, ino);
 		if (inode == ERR_PTR(-ESTALE)) {
 			ext2_error(dir->i_sb, __func__,
@@ -81,14 +82,13 @@ static struct dentry *ext2_lookup(struct inode * dir, struct dentry *dentry, uns
 struct dentry *ext2_get_parent(struct dentry *child)
 {
 	struct qstr dotdot = QSTR_INIT("..", 2);
-	ino_t ino = 0;
+	ino_t ino;
 	int res;
 
 	res = ext2_inode_by_name(d_inode(child), &dotdot, &ino);
 	if (res)
 		return ERR_PTR(res);
-	if (!ino)
-		return ERR_PTR(-ENOENT);
+
 	return d_obtain_alias(ext2_iget(child->d_sb, ino));
 } 
 
@@ -289,10 +289,6 @@ static int ext2_unlink(struct inode * dir, struct dentry *dentry)
 		err = PTR_ERR(de);
 		goto out;
 	}
-	if (!de) {
-		err = -ENOENT;
-		goto out;
-	}
 
 	err = ext2_delete_entry (de, page);
 	if (err)
@@ -349,10 +345,6 @@ static int ext2_rename (struct inode * old_dir, struct dentry * old_dentry,
 		err = PTR_ERR(old_de);
 		goto out;
 	}
-	if (!old_de) {
-		err = -ENOENT;
-		goto out;
-	}
 
 	if (S_ISDIR(old_inode->i_mode)) {
 		err = -EIO;
@@ -369,14 +361,11 @@ static int ext2_rename (struct inode * old_dir, struct dentry * old_dentry,
 		if (dir_de && !ext2_empty_dir (new_inode))
 			goto out_dir;
 
-		err = -ENOENT;
 		new_de = ext2_find_entry(new_dir, &new_dentry->d_name, &new_page);
 		if (IS_ERR(new_de)) {
 			err = PTR_ERR(new_de);
 			goto out_dir;
 		}
-		if (!new_de)
-			goto out_dir;
 		ext2_set_link(new_dir, new_de, new_page, old_inode, 1);
 		new_inode->i_ctime = current_time(new_inode);
 		if (dir_de)
-- 
2.21.3

