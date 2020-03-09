Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCF517D98C
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Mar 2020 08:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgCIHGG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 Mar 2020 03:06:06 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:47010 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgCIHGG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 9 Mar 2020 03:06:06 -0400
Received: by mail-pg1-f195.google.com with SMTP id y30so4271375pga.13
        for <linux-ext4@vger.kernel.org>; Mon, 09 Mar 2020 00:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vmTTEQNHzifmAcXjX5PQ/JzwDoLj9+iwiLrkqtne+mI=;
        b=KElInSOsj8a/Fulvy2cDySBPyr9snRRUmeHM8CzpLJ6YNJORkTWnHLrYtCHbLjUQcH
         6WBrC7mmb5lqUq/4ohhRLea9WfNlnrwGXZqZ0efGOofRklbATTk9x0D3dAINtf+CIcJk
         JvlNuqy63wLd0DaAfM0j1fDCZoi6yIRgTLFWSuhbfWGr96Fo9fhgw+bBdrorkhIrOK71
         S2N09EPGNhawwEm7eZ1fJ0VxXm8yRhsxYbIvtChwTd2IiaykDvKCe+oQtO2ZxkyGpWS5
         VG/mn3BLrMkDXTmALouFd8ATFoSEWmy6n9+xWLYSoG13DMAj5zg6XkY+YjOkusPFVrmB
         JZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vmTTEQNHzifmAcXjX5PQ/JzwDoLj9+iwiLrkqtne+mI=;
        b=mX7/P36tclY7B90JPLIZ3hDbZjpsmDhepm31kGIJocOP2WLhNvjORUZMreadxYpPcY
         bqKIPhSQlprmn4xIrvr/fvZKwAKg0Q1OCWAFg5bhLnkyirHi8ohPZEkzzQJarBbAsBGT
         AhdOu2b+M0DjHCwQxkAlG3yrE2xFA9nLydnCaTUh9xrTbaXZxTDFTgzkiSMt/f5JbpqG
         N+C+91wmSuB8aUgqqOHeDBfdH1pfsXvZTmt1MJjEoYrYSfMtvH5U4tmqYTfnmdl/9TGa
         wRwEfIc+2qM/v0J9m5ZyraF+EAVrK91XftAp/cNumX9O68mVphN7npkN5fR41a61yWLc
         AF/Q==
X-Gm-Message-State: ANhLgQ0D3v94pJrufSh+7NLoO1DC40BTx58YOvjGuHQtFPwsJnbt/ZIJ
        LlcDsL2zr6DrV8TU7nvcJOm2h4El
X-Google-Smtp-Source: ADFU+vv4wEi/mfJKWbylNZm2St0LlgFD1FJ+xUCcUplhbAg8cE25Mxm1kRcvKkA6urQECIEjJJ7ttg==
X-Received: by 2002:a62:a501:: with SMTP id v1mr16147397pfm.7.1583737563187;
        Mon, 09 Mar 2020 00:06:03 -0700 (PDT)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id 8sm3692593pfp.67.2020.03.09.00.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 00:06:02 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v5 10/20] ext4: break ext4_unlink() and ext4_link()
Date:   Mon,  9 Mar 2020 00:05:16 -0700
Message-Id: <20200309070526.218202-10-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
In-Reply-To: <20200309070526.218202-1-harshadshirwadkar@gmail.com>
References: <tytso@mit.edu>
 <20200309070526.218202-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Break ext4_link() and ext4_unlink() each into 2 parts in order to make
them usable in recovery path as well.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4.h  |   4 ++
 fs/ext4/namei.c | 139 +++++++++++++++++++++++++++++-------------------
 2 files changed, 88 insertions(+), 55 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 5cb7f923dbee..6cc3a93b0ce0 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3348,6 +3348,10 @@ extern int ext4_handle_dirty_dirblock(handle_t *handle, struct inode *inode,
 extern int ext4_ci_compare(const struct inode *parent,
 			   const struct qstr *fname,
 			   const struct qstr *entry, bool quick);
+extern int __ext4_unlink(struct inode *dir, const struct qstr *d_name,
+			 struct inode *inode);
+extern int __ext4_link(struct inode *dir, struct inode *inode,
+		       struct dentry *dentry);
 
 #define S_SHIFT 12
 static const unsigned char ext4_type_by_mode[(S_IFMT >> S_SHIFT) + 1] = {
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index b05ea72f38fd..5ee002cc0acd 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -3171,39 +3171,36 @@ static int ext4_rmdir(struct inode *dir, struct dentry *dentry)
 	return retval;
 }
 
-static int ext4_unlink(struct inode *dir, struct dentry *dentry)
+int __ext4_unlink(struct inode *dir, const struct qstr *d_name,
+		  struct inode *inode)
 {
-	int retval;
-	struct inode *inode;
 	struct buffer_head *bh;
 	struct ext4_dir_entry_2 *de;
 	handle_t *handle = NULL;
+	int retval = -ENOENT;
+	int skip_remove_dentry = 0;
 
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(dir->i_sb))))
-		return -EIO;
-
-	trace_ext4_unlink_enter(dir, dentry);
-	/* Initialize quotas before so that eventual writes go
-	 * in separate transaction */
-	retval = dquot_initialize(dir);
-	if (retval)
-		return retval;
-	retval = dquot_initialize(d_inode(dentry));
-	if (retval)
-		return retval;
-
-	retval = -ENOENT;
-	bh = ext4_find_entry(dir, &dentry->d_name, &de, NULL);
+	bh = ext4_find_entry(dir, d_name, &de, NULL);
 	if (IS_ERR(bh))
 		return PTR_ERR(bh);
-	if (!bh)
-		goto end_unlink;
 
-	inode = d_inode(dentry);
+	if (!bh) {
+		retval = -ENOENT;
+		goto end_unlink;
+	}
 
 	retval = -EFSCORRUPTED;
-	if (le32_to_cpu(de->inode) != inode->i_ino)
-		goto end_unlink;
+	if (le32_to_cpu(de->inode) != inode->i_ino) {
+		/*
+		 * It's okay if we find dont find dentry which matches
+		 * the inode. That's because it might have gotten
+		 * renamed to a different inode number
+		 */
+		if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
+			skip_remove_dentry = 1;
+		else
+			goto end_unlink;
+	}
 
 	handle = ext4_journal_start(dir, EXT4_HT_DIR,
 				    EXT4_DATA_TRANS_BLOCKS(dir->i_sb));
@@ -3216,15 +3213,20 @@ static int ext4_unlink(struct inode *dir, struct dentry *dentry)
 	if (IS_DIRSYNC(dir))
 		ext4_handle_sync(handle);
 
-	retval = ext4_delete_entry(handle, dir, de, bh);
-	if (retval)
-		goto end_unlink;
-	dir->i_ctime = dir->i_mtime = current_time(dir);
-	ext4_update_dx_flag(dir);
-	ext4_mark_inode_dirty(handle, dir);
+	if (!skip_remove_dentry) {
+		retval = ext4_delete_entry(handle, dir, de, bh);
+		if (retval)
+			goto end_unlink;
+		dir->i_ctime = dir->i_mtime = current_time(dir);
+		ext4_update_dx_flag(dir);
+		ext4_mark_inode_dirty(handle, dir);
+	} else {
+		retval = 0;
+	}
+
 	if (inode->i_nlink == 0)
 		ext4_warning_inode(inode, "Deleting file '%.*s' with no links",
-				   dentry->d_name.len, dentry->d_name.name);
+				   d_name->len, d_name->name);
 	else
 		drop_nlink(inode);
 	if (!inode->i_nlink)
@@ -3232,6 +3234,33 @@ static int ext4_unlink(struct inode *dir, struct dentry *dentry)
 	inode->i_ctime = current_time(inode);
 	ext4_mark_inode_dirty(handle, inode);
 
+end_unlink:
+	brelse(bh);
+	if (handle)
+		ext4_journal_stop(handle);
+	return retval;
+}
+
+static int ext4_unlink(struct inode *dir, struct dentry *dentry)
+{
+	int retval;
+
+	if (unlikely(ext4_forced_shutdown(EXT4_SB(dir->i_sb))))
+		return -EIO;
+
+	trace_ext4_unlink_enter(dir, dentry);
+	/*
+	 * Initialize quotas before so that eventual writes go
+	 * in separate transaction
+	 */
+	retval = dquot_initialize(dir);
+	if (retval)
+		return retval;
+	retval = dquot_initialize(d_inode(dentry));
+	if (retval)
+		return retval;
+
+	retval = __ext4_unlink(dir, &dentry->d_name, d_inode(dentry));
 #ifdef CONFIG_UNICODE
 	/* VFS negative dentries are incompatible with Encoding and
 	 * Case-insensitiveness. Eventually we'll want avoid
@@ -3242,11 +3271,6 @@ static int ext4_unlink(struct inode *dir, struct dentry *dentry)
 	if (IS_CASEFOLDED(dir))
 		d_invalidate(dentry);
 #endif
-
-end_unlink:
-	brelse(bh);
-	if (handle)
-		ext4_journal_stop(handle);
 	trace_ext4_unlink_exit(dentry, retval);
 	return retval;
 }
@@ -3380,29 +3404,10 @@ static int ext4_symlink(struct inode *dir,
 	return err;
 }
 
-static int ext4_link(struct dentry *old_dentry,
-		     struct inode *dir, struct dentry *dentry)
+int __ext4_link(struct inode *dir, struct inode *inode, struct dentry *dentry)
 {
 	handle_t *handle;
-	struct inode *inode = d_inode(old_dentry);
 	int err, retries = 0;
-
-	if (inode->i_nlink >= EXT4_LINK_MAX)
-		return -EMLINK;
-
-	err = fscrypt_prepare_link(old_dentry, dir, dentry);
-	if (err)
-		return err;
-
-	if ((ext4_test_inode_flag(dir, EXT4_INODE_PROJINHERIT)) &&
-	    (!projid_eq(EXT4_I(dir)->i_projid,
-			EXT4_I(old_dentry->d_inode)->i_projid)))
-		return -EXDEV;
-
-	err = dquot_initialize(dir);
-	if (err)
-		return err;
-
 retry:
 	handle = ext4_journal_start(dir, EXT4_HT_DIR,
 		(EXT4_DATA_TRANS_BLOCKS(dir->i_sb) +
@@ -3436,6 +3441,30 @@ static int ext4_link(struct dentry *old_dentry,
 	return err;
 }
 
+static int ext4_link(struct dentry *old_dentry,
+		     struct inode *dir, struct dentry *dentry)
+{
+	struct inode *inode = d_inode(old_dentry);
+	int err;
+
+	if (inode->i_nlink >= EXT4_LINK_MAX)
+		return -EMLINK;
+
+	err = fscrypt_prepare_link(old_dentry, dir, dentry);
+	if (err)
+		return err;
+
+	if ((ext4_test_inode_flag(dir, EXT4_INODE_PROJINHERIT)) &&
+	    (!projid_eq(EXT4_I(dir)->i_projid,
+			EXT4_I(old_dentry->d_inode)->i_projid)))
+		return -EXDEV;
+
+	err = dquot_initialize(dir);
+	if (err)
+		return err;
+	return __ext4_link(dir, inode, dentry);
+}
+
 
 /*
  * Try to find buffer head where contains the parent block.
-- 
2.25.1.481.gfbce0eb801-goog

