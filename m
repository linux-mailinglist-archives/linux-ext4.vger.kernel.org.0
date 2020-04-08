Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 022D61A2BA3
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Apr 2020 23:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgDHVzy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Apr 2020 17:55:54 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46340 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbgDHVzx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Apr 2020 17:55:53 -0400
Received: by mail-pl1-f194.google.com with SMTP id x2so415599plv.13
        for <linux-ext4@vger.kernel.org>; Wed, 08 Apr 2020 14:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X6Cdy/diJgY3l1SwROJcGixlj3eqYx1Ab0GaummoDv4=;
        b=FpSVh7zyT21wLHrJL3I9lgDXsz6YbLVbU+HAFw1hSMlYz3VH5OmcN/JHvmw3s5dIoZ
         GtcMzBVcp0X2FVkjS3Nj/gYzHEtPxKoLwHXTVuqrWC8J9AkYIMN1ZA/mgqoWgdGOxv7o
         ILmTFXk6+Kl5g93jgO0QsVz3HwCWf+grTMG6GfEdhK74GWZe9aSbc43Lpn9nuhslynic
         lA1yMlZFVmkmUN4/cA0odNRveRlf0zngCJoiloEzJ/JkZ8ffD+2KsXCLjZ6iInAyjjzx
         vLTDWjLciHz7urE7DuPAGUzyd9fkWjYDio2AVSkzyI9N+Lnabgno2wIsxkXYVJxeRcWA
         ygNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X6Cdy/diJgY3l1SwROJcGixlj3eqYx1Ab0GaummoDv4=;
        b=jyx+ScS6Nra7FesS5ZtHb0rMIgZRV6zHQWga9utoX7ZL2Cx3MHCykGhYH717APPJTm
         nbXSzTOFowK9W1hzFg/oJy9Y75VUqB7j9/1AKwqicKcwlPQxs5UtP2Kdnq0RyX8sxU0Z
         LIBvVGO4e6IF+45sKnZB2KHuBGIkKLHKbvPYIcAzJ5nbMBv9j666eB1qXAJvFTHUUniM
         3CSen50U3S3d9V+fpeWJR7KYIlfDHGUvuKrvnRr8NCQeYddp8CO4d1NkirTCRVBZ+jsc
         VEBdiK2LLFfTNZyRO25q0DongIEdpbtPdaT8pJuvH996fDhSVqfTw4FgQ3Lm0N/qa9a2
         yUTw==
X-Gm-Message-State: AGi0Pua/NU/nAZkZTqGZKd4RSDWyFEdO7xfF7Jv8ipzIJy3omd7UIXgo
        VgSy3Km2llJ6Ebhc9iWrC/2GpfUS
X-Google-Smtp-Source: APiQypKkeCj8laEgMf3ohT/qHXDCmbibD96X6RQaIkha+ccQiG9VYnboZbjeMcCNKgQmTGoFs5TZ8Q==
X-Received: by 2002:a17:902:8d86:: with SMTP id v6mr9331911plo.57.1586382951757;
        Wed, 08 Apr 2020 14:55:51 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:6271:607:aca0:b6f7])
        by smtp.googlemail.com with ESMTPSA id z7sm450929pju.37.2020.04.08.14.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 14:55:51 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v6 10/20] ext4: break ext4_unlink() and ext4_link()
Date:   Wed,  8 Apr 2020 14:55:20 -0700
Message-Id: <20200408215530.25649-10-harshads@google.com>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
In-Reply-To: <20200408215530.25649-1-harshads@google.com>
References: <20200408215530.25649-1-harshads@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Break ext4_link() and ext4_unlink() each into 2 parts in order to make
them usable in recovery path as well.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4.h  |   4 ++
 fs/ext4/namei.c | 139 +++++++++++++++++++++++++++++-------------------
 2 files changed, 88 insertions(+), 55 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index e9c82f555b6d..c39966facf86 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3365,6 +3365,10 @@ extern int ext4_handle_dirty_dirblock(handle_t *handle, struct inode *inode,
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
index a8aca4772aaa..77fc136fe718 100644
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
2.26.0.110.g2183baf09c-goog

