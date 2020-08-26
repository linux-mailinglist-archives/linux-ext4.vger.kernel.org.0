Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F094252FF1
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Aug 2020 15:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730286AbgHZNbk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 26 Aug 2020 09:31:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:53080 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730293AbgHZNbi (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 26 Aug 2020 09:31:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 86907B64A;
        Wed, 26 Aug 2020 13:31:49 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] ext4: Remove unused argument from ext4_(inc|dec)_count
Date:   Wed, 26 Aug 2020 16:31:16 +0300
Message-Id: <20200826133116.11592-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The 'handle' argument is not used for anything so simply remove it.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/ext4/namei.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 56738b538ddf..b411f843e469 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2546,7 +2546,7 @@ static int ext4_delete_entry(handle_t *handle,
  * for checking S_ISDIR(inode) (since the INODE_INDEX feature will not be set
  * on regular files) and to avoid creating huge/slow non-HTREE directories.
  */
-static void ext4_inc_count(handle_t *handle, struct inode *inode)
+static void ext4_inc_count(struct inode *inode)
 {
 	inc_nlink(inode);
 	if (is_dx(inode) &&
@@ -2558,7 +2558,7 @@ static void ext4_inc_count(handle_t *handle, struct inode *inode)
  * If a directory had nlink == 1, then we should let it be 1. This indicates
  * directory has >EXT4_LINK_MAX subdirs.
  */
-static void ext4_dec_count(handle_t *handle, struct inode *inode)
+static void ext4_dec_count(struct inode *inode)
 {
 	if (!S_ISDIR(inode->i_mode) || inode->i_nlink > 2)
 		drop_nlink(inode);
@@ -2817,7 +2817,7 @@ static int ext4_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 		iput(inode);
 		goto out_retry;
 	}
-	ext4_inc_count(handle, dir);
+	ext4_inc_count(dir);
 	ext4_update_dx_flag(dir);
 	err = ext4_mark_inode_dirty(handle, dir);
 	if (err)
@@ -3155,7 +3155,7 @@ static int ext4_rmdir(struct inode *dir, struct dentry *dentry)
 	retval = ext4_mark_inode_dirty(handle, inode);
 	if (retval)
 		goto end_rmdir;
-	ext4_dec_count(handle, dir);
+	ext4_dec_count(dir);
 	ext4_update_dx_flag(dir);
 	retval = ext4_mark_inode_dirty(handle, dir);

@@ -3422,7 +3422,7 @@ static int ext4_link(struct dentry *old_dentry,
 		ext4_handle_sync(handle);

 	inode->i_ctime = current_time(inode);
-	ext4_inc_count(handle, inode);
+	ext4_inc_count(inode);
 	ihold(inode);

 	err = ext4_add_entry(handle, dentry, inode);
@@ -3619,9 +3619,9 @@ static void ext4_update_dir_count(handle_t *handle, struct ext4_renament *ent)
 {
 	if (ent->dir_nlink_delta) {
 		if (ent->dir_nlink_delta == -1)
-			ext4_dec_count(handle, ent->dir);
+			ext4_dec_count(ent->dir);
 		else
-			ext4_inc_count(handle, ent->dir);
+			ext4_inc_count(ent->dir);
 		ext4_mark_inode_dirty(handle, ent->dir);
 	}
 }
@@ -3833,7 +3833,7 @@ static int ext4_rename(struct inode *old_dir, struct dentry *old_dentry,
 	}

 	if (new.inode) {
-		ext4_dec_count(handle, new.inode);
+		ext4_dec_count(new.inode);
 		new.inode->i_ctime = current_time(new.inode);
 	}
 	old.dir->i_ctime = old.dir->i_mtime = current_time(old.dir);
@@ -3843,14 +3843,14 @@ static int ext4_rename(struct inode *old_dir, struct dentry *old_dentry,
 		if (retval)
 			goto end_rename;

-		ext4_dec_count(handle, old.dir);
+		ext4_dec_count(old.dir);
 		if (new.inode) {
 			/* checked ext4_empty_dir above, can't have another
 			 * parent, ext4_dec_count() won't work for many-linked
 			 * dirs */
 			clear_nlink(new.inode);
 		} else {
-			ext4_inc_count(handle, new.dir);
+			ext4_inc_count(new.dir);
 			ext4_update_dx_flag(new.dir);
 			retval = ext4_mark_inode_dirty(handle, new.dir);
 			if (unlikely(retval))
--
2.17.1

