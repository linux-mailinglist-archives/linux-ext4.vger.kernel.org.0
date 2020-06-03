Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14C181EC999
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Jun 2020 08:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgFCGfu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 Jun 2020 02:35:50 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5844 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725878AbgFCGft (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 3 Jun 2020 02:35:49 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 366ABF0B45F2359AEEDA
        for <linux-ext4@vger.kernel.org>; Wed,  3 Jun 2020 14:35:47 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Wed, 3 Jun 2020
 14:35:38 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <jack@suse.cz>, <yi.zhang@huawei.com>
Subject: [PATCH v2 2/2] ext2: ext2_find_entry() return -ENOENT if no entry found
Date:   Wed, 3 Jun 2020 14:35:14 +0800
Message-ID: <20200603063514.3904811-2-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200603063514.3904811-1-yi.zhang@huawei.com>
References: <20200603063514.3904811-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
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
 fs/ext2/dir.c   | 11 ++++++++---
 fs/ext2/namei.c | 27 ++++++++-------------------
 2 files changed, 16 insertions(+), 22 deletions(-)

diff --git a/fs/ext2/dir.c b/fs/ext2/dir.c
index 95e4f0bd55a3..96c40fd7550e 100644
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
@@ -419,11 +419,16 @@ int ext2_inode_by_name(struct inode *dir, const struct qstr *child, ino_t *ino)
 	struct page *page;
 	
 	de = ext2_find_entry(dir, child, &page);
-	if (IS_ERR_OR_NULL(de))
+	if (IS_ERR(de))
 		return PTR_ERR(de);
 
-	*ino = le32_to_cpu(de->inode);
 	ext2_put_page(page);
+	if (!de->inode) {
+		ext2_error(dir->i_sb, __func__, "bad inode number: %u",
+			   le32_to_cpu(de->inode));
+		return -EFSCORRUPTED;
+	}
+	*ino = le32_to_cpu(de->inode);
 	return 0;
 }
 
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
2.25.4

