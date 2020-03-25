Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBA3E19244D
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Mar 2020 10:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgCYJhi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 25 Mar 2020 05:37:38 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44396 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgCYJhh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 25 Mar 2020 05:37:37 -0400
Received: by mail-pg1-f196.google.com with SMTP id 142so877546pgf.11
        for <linux-ext4@vger.kernel.org>; Wed, 25 Mar 2020 02:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eaEomXLRDACpwQrzJidFQbkz+0R89SFOBd6jq3j2lv4=;
        b=Vf3FsN0JY5MiydTvexNJ3CHTvWrkQnzNJDKV3xAfDkGOOuNgtfsK2DedM7upWoCNMR
         5EvCn46hxz1eJOp03XGewWsIS6zsdLrc2PKetPWOO1OKOGI1vW/s/0vwKXV/562UH/Sg
         O/0F769l9nYYqs7NVbqC6RCH4sr4/pBrpuQnwgwZmv7zUjWHL32jte86BppJG4Niae42
         xc9rndVnNEgUnGBVssO3Q0A+LN2Rpwp2HVghYuRRyDBRvs+0QZaAjG1pDaUeY6FKk7HI
         8GTPob9LfUXxo+xhwLeKoa6zCkKGi+t3OKAWKSn/6cmGu/6eca3tRb45dkVmShxGhFsQ
         YrQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eaEomXLRDACpwQrzJidFQbkz+0R89SFOBd6jq3j2lv4=;
        b=N49BBP+KhnacaqTXtCZQWfHg/U2vRrTXmXERjpJ2HFLpYl6z+63/L/WbBDPWLYtayU
         dz3csVN7rSN7pf+LZ6XwF3MIM0+n1xnmfBmp8Dh8A1bhApGt/zFDpX7/SxGemTKoYzu5
         YMSpBe/rGcFwGPZHsDKU0n18YDsWj5lrFoICc8nLjkMLfH6o7U6+F0Tg5YprHNBXlqWO
         dRrf3UE2U6ukogrWsN4KlXmhZpZ7brux6DLsq1ezWor8Ic1QZHOp84xQLlfYH+gN846I
         6ai+bjtP4hzjoYH06vJWW3guYwDcwctClshV/Nq5GNGLeW57lmclHZcC36jEimdL8u7O
         AOqg==
X-Gm-Message-State: ANhLgQ03RwsrfzzP6tZKObu7Y9bPZ/DuaVdW30BwHlX7mp4d/yOF0KUR
        Gmwemj0MevwwGLqUROw4lqrXQKfO
X-Google-Smtp-Source: ADFU+vv2TVrCkFBVxo/xr+xglvslsGtiThNl2QOqs4yrC9QKQOaGDznHxuJTHo1K9pAfcT9zI1kf8A==
X-Received: by 2002:a63:8e44:: with SMTP id k65mr2199276pge.452.1585129055534;
        Wed, 25 Mar 2020 02:37:35 -0700 (PDT)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id q43sm4289927pjc.40.2020.03.25.02.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 02:37:35 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 1/2] ext4: return lblk from ext4_find_entry
Date:   Wed, 25 Mar 2020 02:37:27 -0700
Message-Id: <20200325093728.204211-1-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch makes ext4_find_entry and related routines to return
logical block address of the dirent block. This logical block address
is used in the directory shrinking code to perform reverse lookup and
verify that the lookup was successful.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/namei.c | 54 +++++++++++++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 22 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index b05ea72f38fd..d567b9589875 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -295,7 +295,7 @@ static int ext4_htree_next_block(struct inode *dir, __u32 hash,
 				 __u32 *start_hash);
 static struct buffer_head * ext4_dx_find_entry(struct inode *dir,
 		struct ext4_filename *fname,
-		struct ext4_dir_entry_2 **res_dir);
+		struct ext4_dir_entry_2 **res_dir, ext4_lblk_t *lblk);
 static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
 			     struct inode *dir, struct inode *inode);
 
@@ -1443,7 +1443,7 @@ static int is_dx_internal_node(struct inode *dir, ext4_lblk_t block,
 static struct buffer_head *__ext4_find_entry(struct inode *dir,
 					     struct ext4_filename *fname,
 					     struct ext4_dir_entry_2 **res_dir,
-					     int *inlined)
+					     int *inlined, ext4_lblk_t *lblk)
 {
 	struct super_block *sb;
 	struct buffer_head *bh_use[NAMEI_RA_SIZE];
@@ -1485,7 +1485,7 @@ static struct buffer_head *__ext4_find_entry(struct inode *dir,
 		goto restart;
 	}
 	if (is_dx(dir)) {
-		ret = ext4_dx_find_entry(dir, fname, res_dir);
+		ret = ext4_dx_find_entry(dir, fname, res_dir, lblk);
 		/*
 		 * On success, or if the error was file not found,
 		 * return.  Otherwise, fall back to doing a search the
@@ -1588,7 +1588,8 @@ static struct buffer_head *__ext4_find_entry(struct inode *dir,
 static struct buffer_head *ext4_find_entry(struct inode *dir,
 					   const struct qstr *d_name,
 					   struct ext4_dir_entry_2 **res_dir,
-					   int *inlined)
+					   int *inlined,
+					   ext4_lblk_t *lblk)
 {
 	int err;
 	struct ext4_filename fname;
@@ -1600,7 +1601,7 @@ static struct buffer_head *ext4_find_entry(struct inode *dir,
 	if (err)
 		return ERR_PTR(err);
 
-	bh = __ext4_find_entry(dir, &fname, res_dir, inlined);
+	bh = __ext4_find_entry(dir, &fname, res_dir, inlined, lblk);
 
 	ext4_fname_free_filename(&fname);
 	return bh;
@@ -1620,7 +1621,7 @@ static struct buffer_head *ext4_lookup_entry(struct inode *dir,
 	if (err)
 		return ERR_PTR(err);
 
-	bh = __ext4_find_entry(dir, &fname, res_dir, NULL);
+	bh = __ext4_find_entry(dir, &fname, res_dir, NULL, NULL);
 
 	ext4_fname_free_filename(&fname);
 	return bh;
@@ -1628,7 +1629,8 @@ static struct buffer_head *ext4_lookup_entry(struct inode *dir,
 
 static struct buffer_head * ext4_dx_find_entry(struct inode *dir,
 			struct ext4_filename *fname,
-			struct ext4_dir_entry_2 **res_dir)
+			struct ext4_dir_entry_2 **res_dir,
+			ext4_lblk_t *lblk)
 {
 	struct super_block * sb = dir->i_sb;
 	struct dx_frame frames[EXT4_HTREE_LEVEL], *frame;
@@ -1675,6 +1677,8 @@ static struct buffer_head * ext4_dx_find_entry(struct inode *dir,
 errout:
 	dxtrace(printk(KERN_DEBUG "%s not found\n", fname->usr_fname->name));
 success:
+	if (lblk)
+		*lblk = block;
 	dx_release(frames);
 	return bh;
 }
@@ -1743,7 +1747,7 @@ struct dentry *ext4_get_parent(struct dentry *child)
 	struct ext4_dir_entry_2 * de;
 	struct buffer_head *bh;
 
-	bh = ext4_find_entry(d_inode(child), &dotdot, &de, NULL);
+	bh = ext4_find_entry(d_inode(child), &dotdot, &de, NULL, NULL);
 	if (IS_ERR(bh))
 		return ERR_CAST(bh);
 	if (!bh)
@@ -2495,7 +2499,7 @@ int ext4_generic_delete_entry(handle_t *handle,
 static int ext4_delete_entry(handle_t *handle,
 			     struct inode *dir,
 			     struct ext4_dir_entry_2 *de_del,
-			     struct buffer_head *bh)
+			     struct buffer_head *bh, ext4_lblk_t lblk)
 {
 	int err, csum_size = 0;
 
@@ -3091,6 +3095,7 @@ static int ext4_rmdir(struct inode *dir, struct dentry *dentry)
 	struct buffer_head *bh;
 	struct ext4_dir_entry_2 *de;
 	handle_t *handle = NULL;
+	ext4_lblk_t lblk;
 
 	if (unlikely(ext4_forced_shutdown(EXT4_SB(dir->i_sb))))
 		return -EIO;
@@ -3105,7 +3110,7 @@ static int ext4_rmdir(struct inode *dir, struct dentry *dentry)
 		return retval;
 
 	retval = -ENOENT;
-	bh = ext4_find_entry(dir, &dentry->d_name, &de, NULL);
+	bh = ext4_find_entry(dir, &dentry->d_name, &de, NULL, &lblk);
 	if (IS_ERR(bh))
 		return PTR_ERR(bh);
 	if (!bh)
@@ -3132,7 +3137,7 @@ static int ext4_rmdir(struct inode *dir, struct dentry *dentry)
 	if (IS_DIRSYNC(dir))
 		ext4_handle_sync(handle);
 
-	retval = ext4_delete_entry(handle, dir, de, bh);
+	retval = ext4_delete_entry(handle, dir, de, bh, lblk);
 	if (retval)
 		goto end_rmdir;
 	if (!EXT4_DIR_LINK_EMPTY(inode))
@@ -3178,6 +3183,7 @@ static int ext4_unlink(struct inode *dir, struct dentry *dentry)
 	struct buffer_head *bh;
 	struct ext4_dir_entry_2 *de;
 	handle_t *handle = NULL;
+	ext4_lblk_t lblk;
 
 	if (unlikely(ext4_forced_shutdown(EXT4_SB(dir->i_sb))))
 		return -EIO;
@@ -3193,7 +3199,7 @@ static int ext4_unlink(struct inode *dir, struct dentry *dentry)
 		return retval;
 
 	retval = -ENOENT;
-	bh = ext4_find_entry(dir, &dentry->d_name, &de, NULL);
+	bh = ext4_find_entry(dir, &dentry->d_name, &de, NULL, &lblk);
 	if (IS_ERR(bh))
 		return PTR_ERR(bh);
 	if (!bh)
@@ -3216,7 +3222,7 @@ static int ext4_unlink(struct inode *dir, struct dentry *dentry)
 	if (IS_DIRSYNC(dir))
 		ext4_handle_sync(handle);
 
-	retval = ext4_delete_entry(handle, dir, de, bh);
+	retval = ext4_delete_entry(handle, dir, de, bh, lblk);
 	if (retval)
 		goto end_unlink;
 	dir->i_ctime = dir->i_mtime = current_time(dir);
@@ -3564,19 +3570,20 @@ static int ext4_find_delete_entry(handle_t *handle, struct inode *dir,
 	int retval = -ENOENT;
 	struct buffer_head *bh;
 	struct ext4_dir_entry_2 *de;
+	ext4_lblk_t lblk;
 
-	bh = ext4_find_entry(dir, d_name, &de, NULL);
+	bh = ext4_find_entry(dir, d_name, &de, NULL, &lblk);
 	if (IS_ERR(bh))
 		return PTR_ERR(bh);
 	if (bh) {
-		retval = ext4_delete_entry(handle, dir, de, bh);
+		retval = ext4_delete_entry(handle, dir, de, bh, lblk);
 		brelse(bh);
 	}
 	return retval;
 }
 
 static void ext4_rename_delete(handle_t *handle, struct ext4_renament *ent,
-			       int force_reread)
+			       int force_reread, ext4_lblk_t lblk)
 {
 	int retval;
 	/*
@@ -3593,7 +3600,8 @@ static void ext4_rename_delete(handle_t *handle, struct ext4_renament *ent,
 		retval = ext4_find_delete_entry(handle, ent->dir,
 						&ent->dentry->d_name);
 	} else {
-		retval = ext4_delete_entry(handle, ent->dir, ent->de, ent->bh);
+		retval = ext4_delete_entry(handle, ent->dir, ent->de, ent->bh,
+					   lblk);
 		if (retval == -ENOENT) {
 			retval = ext4_find_delete_entry(handle, ent->dir,
 							&ent->dentry->d_name);
@@ -3679,6 +3687,7 @@ static int ext4_rename(struct inode *old_dir, struct dentry *old_dentry,
 	struct inode *whiteout = NULL;
 	int credits;
 	u8 old_file_type;
+	ext4_lblk_t lblk;
 
 	if (new.inode && new.inode->i_nlink == 0) {
 		EXT4_ERROR_INODE(new.inode,
@@ -3706,7 +3715,8 @@ static int ext4_rename(struct inode *old_dir, struct dentry *old_dentry,
 			return retval;
 	}
 
-	old.bh = ext4_find_entry(old.dir, &old.dentry->d_name, &old.de, NULL);
+	old.bh = ext4_find_entry(old.dir, &old.dentry->d_name, &old.de, NULL,
+				 &lblk);
 	if (IS_ERR(old.bh))
 		return PTR_ERR(old.bh);
 	/*
@@ -3720,7 +3730,7 @@ static int ext4_rename(struct inode *old_dir, struct dentry *old_dentry,
 		goto end_rename;
 
 	new.bh = ext4_find_entry(new.dir, &new.dentry->d_name,
-				 &new.de, &new.inlined);
+				 &new.de, &new.inlined, NULL);
 	if (IS_ERR(new.bh)) {
 		retval = PTR_ERR(new.bh);
 		new.bh = NULL;
@@ -3817,7 +3827,7 @@ static int ext4_rename(struct inode *old_dir, struct dentry *old_dentry,
 		/*
 		 * ok, that's it
 		 */
-		ext4_rename_delete(handle, &old, force_reread);
+		ext4_rename_delete(handle, &old, force_reread, lblk);
 	}
 
 	if (new.inode) {
@@ -3900,7 +3910,7 @@ static int ext4_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 		return retval;
 
 	old.bh = ext4_find_entry(old.dir, &old.dentry->d_name,
-				 &old.de, &old.inlined);
+				 &old.de, &old.inlined, NULL);
 	if (IS_ERR(old.bh))
 		return PTR_ERR(old.bh);
 	/*
@@ -3914,7 +3924,7 @@ static int ext4_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 		goto end_rename;
 
 	new.bh = ext4_find_entry(new.dir, &new.dentry->d_name,
-				 &new.de, &new.inlined);
+				 &new.de, &new.inlined, NULL);
 	if (IS_ERR(new.bh)) {
 		retval = PTR_ERR(new.bh);
 		new.bh = NULL;
-- 
2.25.1.696.g5e7596f4ac-goog

