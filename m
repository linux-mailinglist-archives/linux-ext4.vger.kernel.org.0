Return-Path: <linux-ext4+bounces-10470-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DBFBA7853
	for <lists+linux-ext4@lfdr.de>; Sun, 28 Sep 2025 23:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBF8D3B75F6
	for <lists+linux-ext4@lfdr.de>; Sun, 28 Sep 2025 21:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158E0299950;
	Sun, 28 Sep 2025 21:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="QLPJ/Rcj"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01D326B761
	for <linux-ext4@vger.kernel.org>; Sun, 28 Sep 2025 21:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759094631; cv=none; b=PkhUUqi8mA/jJd8wMFlOERoQW33UppaKDr5g+x/GSedJjXC85RIblFFfVbIzST2JDKk4ZgERBkAGIvIWThF83JWkAB5pJkrY9WwwRQVm+fLTvayXk6MBwMuZN/8ZudnW7gKruOtFG7MpzD/q4dRN3v6ZXRIIRwKTCUqdB1pf+d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759094631; c=relaxed/simple;
	bh=CR9OclwZIHWJ1nlR4/prFlGMAm87L2w3lPvy84rYYRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r+7CLm0DDk15auYaUvpkYXQUAWCnPO8Qbnn/r+zMJGxteuX+dvDD6a/QnCAq/ug1Gf+YHZxZV6lH6uviAVrK+/JmBb/HvJuix0SiJCwChRYpxp5sqNuqaWuCSnzKhLqesKzjdu+VfD8Aez/859W2E2mW0J2GXWKlfCtFGSz56Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=QLPJ/Rcj; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-115-162.bstnma.fios.verizon.net [173.48.115.162])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 58SLNg2M000910
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 28 Sep 2025 17:23:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1759094624; bh=szzwXWgsfewmKecCXcbpdTY4RCPoheL56kXej34MPP8=;
	h=From:Subject:Date:Message-ID:MIME-Version;
	b=QLPJ/Rcjf6UdnHSWXXgtvj9nMHMWgCXqxWcDtxlrosNQqJ/ovNuSMu1z5NUmj/zG/
	 WTjLmDONlvwWAPSE+TlLFAnLYjrBQw18wXWB9Pz2VnDdY09yCGk/PKOuH1u/tSgKBC
	 w/UVWxo8vogjrf0ZY1UyoKwXTR/CNgXrTIq+2wqtmVaIqzaKye4w2oEC0CTUq0OF1e
	 EDL/ygEm/8GhoCcel9XPovIoms7UrfQWgw2iPfNghDi3tYAVuXgpH6gkAemVI5LQ4s
	 OMch5sZRipd7a2RIufXZWQTsLj1nyqo1oSKYLQene/lS+oO7IAo5B88p01CwoX0aGk
	 OaLUvfE3kOsvw==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 739252E00D9; Sun, 28 Sep 2025 17:23:42 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc: sunjunchao2870@gmail.com, Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>, "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 1/2] ext4: return lblk from ext4_find_entry
Date: Sun, 28 Sep 2025 17:23:17 -0400
Message-ID: <20250928212318.281605-1-tytso@mit.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250928210231.GB274922@mit.edu>
References: <20250928210231.GB274922@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

This patch makes ext4_find_entry and related routines to return
logical block address of the dirent block. This logical block address
is used in the directory shrinking code to perform reverse lookup and
verify that the lookup was successful.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Message-ID: <20200407064616.221459-1-harshadshirwadkar@gmail.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/namei.c | 55 ++++++++++++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 23 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 2cd36f59c9e3..9a6d8b87492f 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -293,7 +293,7 @@ struct dx_tail {
 
 static struct buffer_head * ext4_dx_find_entry(struct inode *dir,
 		struct ext4_filename *fname,
-		struct ext4_dir_entry_2 **res_dir);
+		struct ext4_dir_entry_2 **res_dir, ext4_lblk_t *lblk);
 static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
 			     struct inode *dir, struct inode *inode);
 
@@ -1517,7 +1517,7 @@ static int is_dx_internal_node(struct inode *dir, ext4_lblk_t block,
 static struct buffer_head *__ext4_find_entry(struct inode *dir,
 					     struct ext4_filename *fname,
 					     struct ext4_dir_entry_2 **res_dir,
-					     int *inlined)
+					     int *inlined, ext4_lblk_t *lblk)
 {
 	struct super_block *sb;
 	struct buffer_head *bh_use[NAMEI_RA_SIZE];
@@ -1558,7 +1558,7 @@ static struct buffer_head *__ext4_find_entry(struct inode *dir,
 		goto restart;
 	}
 	if (is_dx(dir)) {
-		ret = ext4_dx_find_entry(dir, fname, res_dir);
+		ret = ext4_dx_find_entry(dir, fname, res_dir, lblk);
 		/*
 		 * On success, or if the error was file not found,
 		 * return.  Otherwise, fall back to doing a search the
@@ -1668,7 +1668,8 @@ static struct buffer_head *__ext4_find_entry(struct inode *dir,
 static struct buffer_head *ext4_find_entry(struct inode *dir,
 					   const struct qstr *d_name,
 					   struct ext4_dir_entry_2 **res_dir,
-					   int *inlined)
+					   int *inlined,
+					   ext4_lblk_t *lblk)
 {
 	int err;
 	struct ext4_filename fname;
@@ -1680,7 +1681,7 @@ static struct buffer_head *ext4_find_entry(struct inode *dir,
 	if (err)
 		return ERR_PTR(err);
 
-	bh = __ext4_find_entry(dir, &fname, res_dir, inlined);
+	bh = __ext4_find_entry(dir, &fname, res_dir, inlined, lblk);
 
 	ext4_fname_free_filename(&fname);
 	return bh;
@@ -1700,7 +1701,7 @@ static struct buffer_head *ext4_lookup_entry(struct inode *dir,
 	if (err)
 		return ERR_PTR(err);
 
-	bh = __ext4_find_entry(dir, &fname, res_dir, NULL);
+	bh = __ext4_find_entry(dir, &fname, res_dir, NULL, NULL);
 
 	ext4_fname_free_filename(&fname);
 	return bh;
@@ -1708,7 +1709,8 @@ static struct buffer_head *ext4_lookup_entry(struct inode *dir,
 
 static struct buffer_head * ext4_dx_find_entry(struct inode *dir,
 			struct ext4_filename *fname,
-			struct ext4_dir_entry_2 **res_dir)
+			struct ext4_dir_entry_2 **res_dir,
+			ext4_lblk_t *lblk)
 {
 	struct super_block * sb = dir->i_sb;
 	struct dx_frame frames[EXT4_HTREE_LEVEL], *frame;
@@ -1755,6 +1757,8 @@ static struct buffer_head * ext4_dx_find_entry(struct inode *dir,
 errout:
 	dxtrace(printk(KERN_DEBUG "%s not found\n", fname->usr_fname->name));
 success:
+	if (lblk)
+		*lblk = block;
 	dx_release(frames);
 	return bh;
 }
@@ -1821,7 +1825,7 @@ struct dentry *ext4_get_parent(struct dentry *child)
 	struct ext4_dir_entry_2 * de;
 	struct buffer_head *bh;
 
-	bh = ext4_find_entry(d_inode(child), &dotdot_name, &de, NULL);
+	bh = ext4_find_entry(d_inode(child), &dotdot_name, &de, NULL, NULL);
 	if (IS_ERR(bh))
 		return ERR_CAST(bh);
 	if (!bh)
@@ -2702,7 +2706,7 @@ int ext4_generic_delete_entry(struct inode *dir,
 static int ext4_delete_entry(handle_t *handle,
 			     struct inode *dir,
 			     struct ext4_dir_entry_2 *de_del,
-			     struct buffer_head *bh)
+			     struct buffer_head *bh, ext4_lblk_t lblk)
 {
 	int err, csum_size = 0;
 
@@ -3135,6 +3139,7 @@ static int ext4_rmdir(struct inode *dir, struct dentry *dentry)
 	struct buffer_head *bh;
 	struct ext4_dir_entry_2 *de;
 	handle_t *handle = NULL;
+	ext4_lblk_t lblk;
 
 	retval = ext4_emergency_state(dir->i_sb);
 	if (unlikely(retval))
@@ -3150,7 +3155,7 @@ static int ext4_rmdir(struct inode *dir, struct dentry *dentry)
 		return retval;
 
 	retval = -ENOENT;
-	bh = ext4_find_entry(dir, &dentry->d_name, &de, NULL);
+	bh = ext4_find_entry(dir, &dentry->d_name, &de, NULL, &lblk);
 	if (IS_ERR(bh))
 		return PTR_ERR(bh);
 	if (!bh)
@@ -3177,7 +3182,7 @@ static int ext4_rmdir(struct inode *dir, struct dentry *dentry)
 	if (IS_DIRSYNC(dir))
 		ext4_handle_sync(handle);
 
-	retval = ext4_delete_entry(handle, dir, de, bh);
+	retval = ext4_delete_entry(handle, dir, de, bh, lblk);
 	if (retval)
 		goto end_rmdir;
 	if (!EXT4_DIR_LINK_EMPTY(inode))
@@ -3227,12 +3232,13 @@ int __ext4_unlink(struct inode *dir, const struct qstr *d_name,
 	struct ext4_dir_entry_2 *de;
 	handle_t *handle;
 	int skip_remove_dentry = 0;
+	ext4_lblk_t lblk;
 
 	/*
 	 * Keep this outside the transaction; it may have to set up the
 	 * directory's encryption key, which isn't GFP_NOFS-safe.
 	 */
-	bh = ext4_find_entry(dir, d_name, &de, NULL);
+	bh = ext4_find_entry(dir, d_name, &de, NULL, &lblk);
 	if (IS_ERR(bh))
 		return PTR_ERR(bh);
 
@@ -3262,7 +3268,7 @@ int __ext4_unlink(struct inode *dir, const struct qstr *d_name,
 		ext4_handle_sync(handle);
 
 	if (!skip_remove_dentry) {
-		retval = ext4_delete_entry(handle, dir, de, bh);
+		retval = ext4_delete_entry(handle, dir, de, bh, lblk);
 		if (retval)
 			goto out_handle;
 		inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
@@ -3669,7 +3675,7 @@ static void ext4_resetent(handle_t *handle, struct ext4_renament *ent,
 	 * before reset old inode info.
 	 */
 	old.bh = ext4_find_entry(old.dir, &old.dentry->d_name, &old.de,
-				 &old.inlined);
+				 &old.inlined, NULL);
 	if (IS_ERR(old.bh))
 		retval = PTR_ERR(old.bh);
 	if (!old.bh)
@@ -3689,19 +3695,20 @@ static int ext4_find_delete_entry(handle_t *handle, struct inode *dir,
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
@@ -3718,7 +3725,8 @@ static void ext4_rename_delete(handle_t *handle, struct ext4_renament *ent,
 		retval = ext4_find_delete_entry(handle, ent->dir,
 						&ent->dentry->d_name);
 	} else {
-		retval = ext4_delete_entry(handle, ent->dir, ent->de, ent->bh);
+		retval = ext4_delete_entry(handle, ent->dir, ent->de, ent->bh,
+					   lblk);
 		if (retval == -ENOENT) {
 			retval = ext4_find_delete_entry(handle, ent->dir,
 							&ent->dentry->d_name);
@@ -3806,6 +3814,7 @@ static int ext4_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	struct inode *whiteout = NULL;
 	int credits;
 	u8 old_file_type;
+	ext4_lblk_t lblk;
 
 	if (new.inode && new.inode->i_nlink == 0) {
 		EXT4_ERROR_INODE(new.inode,
@@ -3837,7 +3846,7 @@ static int ext4_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	}
 
 	old.bh = ext4_find_entry(old.dir, &old.dentry->d_name, &old.de,
-				 &old.inlined);
+				 &old.inlined, &lblk);
 	if (IS_ERR(old.bh))
 		return PTR_ERR(old.bh);
 
@@ -3852,7 +3861,7 @@ static int ext4_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		goto release_bh;
 
 	new.bh = ext4_find_entry(new.dir, &new.dentry->d_name,
-				 &new.de, &new.inlined);
+				 &new.de, &new.inlined, NULL);
 	if (IS_ERR(new.bh)) {
 		retval = PTR_ERR(new.bh);
 		new.bh = NULL;
@@ -3952,7 +3961,7 @@ static int ext4_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		/*
 		 * ok, that's it
 		 */
-		ext4_rename_delete(handle, &old, force_reread);
+		ext4_rename_delete(handle, &old, force_reread, lblk);
 	}
 
 	if (new.inode) {
@@ -4073,7 +4082,7 @@ static int ext4_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 		return retval;
 
 	old.bh = ext4_find_entry(old.dir, &old.dentry->d_name,
-				 &old.de, &old.inlined);
+				 &old.de, &old.inlined, NULL);
 	if (IS_ERR(old.bh))
 		return PTR_ERR(old.bh);
 	/*
@@ -4087,7 +4096,7 @@ static int ext4_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 		goto end_rename;
 
 	new.bh = ext4_find_entry(new.dir, &new.dentry->d_name,
-				 &new.de, &new.inlined);
+				 &new.de, &new.inlined, NULL);
 	if (IS_ERR(new.bh)) {
 		retval = PTR_ERR(new.bh);
 		new.bh = NULL;
-- 
2.51.0


