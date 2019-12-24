Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75620129ED7
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Dec 2019 09:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbfLXIO6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 24 Dec 2019 03:14:58 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34905 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfLXIO5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 24 Dec 2019 03:14:57 -0500
Received: by mail-pl1-f195.google.com with SMTP id g6so8204318plt.2
        for <linux-ext4@vger.kernel.org>; Tue, 24 Dec 2019 00:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/PsSttgmW58rnVxkCA05Y27TJ9yPqaOCT9anx0+KH6E=;
        b=dyi476oNCYEI1u76ZF+oagbfWPIWlAlxwhQM06w0YPyvcR875D+Kkyw2F2tYzcB9q4
         /bG470QVm9yl2VflvPik+8j44BdBTOCwlBvyFE9/8n3XgCA+a41uKoynsvg44v8g0BFJ
         Kqie3xqBgCuLZU/oT6gKq55qrx4lxRSpYpvP8L9V3Cvn37VwG2rT20ITLpKWJoGwdvS6
         uEas8vv1hqLjSZO/yr4IrOcHJnYP/l4tT30yIMkhSy83YfkSaAUdRdfY1XzqgG+hY2VN
         LTqVJViy2yuGiCIV0pFryhxQOoTCpxZlDiQ5OJOv3HLMXj92RAH3jSc0ZpncNgj+bdMY
         c+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/PsSttgmW58rnVxkCA05Y27TJ9yPqaOCT9anx0+KH6E=;
        b=QKH4ByoYEYxBHQ3aCFeDilR7yHROYpLUGvM/7N3OS15wTZE+gU3orPlaqPttlBmXk/
         hw4C3unHBTonyc5EVIOEaDkt+YFU+GTzGllr95c02KdljMOm/JujJN/HgQ8A1AU9Uaob
         AwatLB4Kj1xtKhpmH+pVYjhbZc6X0C918Gd6CRB7Fe7lHPlDhck5m0bAxaZ9xkdAy8Pi
         qxAG/wThlHVNVi8LnwuRSNIKLPS76ok7scJ8AWbMO6Ggih30T3Fj1gjQASZcqnyWa03S
         09aFTSbhnM4yDihTnszZG1rTWjUWki3NfaSyEqXa4DujMUYnRhxcbusK0wyjT1krIR1q
         V9CQ==
X-Gm-Message-State: APjAAAWK90MDMDRJRmfq3D5s4gQfS4DTEWYMjwc1LIcnqd++Lb8wPRQV
        x0XVD6L3f7iA0t76H5j7eTxjzCHc
X-Google-Smtp-Source: APXvYqwexemOmRwefR/GJi/3AE8nV+nKIsD0x1YgPXJa0J1QunnZ8HtO802y0xNJi24E5XUHIcDtUg==
X-Received: by 2002:a17:90a:d0c1:: with SMTP id y1mr4266701pjw.126.1577175296435;
        Tue, 24 Dec 2019 00:14:56 -0800 (PST)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id f8sm27370781pfn.2.2019.12.24.00.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 00:14:56 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v4 10/20] ext4: break ext4_unlink() and ext4_link()
Date:   Tue, 24 Dec 2019 00:13:14 -0800
Message-Id: <20191224081324.95807-10-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20191224081324.95807-1-harshadshirwadkar@gmail.com>
References: <20191224081324.95807-1-harshadshirwadkar@gmail.com>
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
 fs/ext4/namei.c | 138 +++++++++++++++++++++++++++++-------------------
 2 files changed, 87 insertions(+), 55 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index b4c32f02071f..cc3a1489eae4 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3262,6 +3262,10 @@ extern int ext4_handle_dirty_dirblock(handle_t *handle, struct inode *inode,
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
index a427d2031a8d..a405564ae02f 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -3137,39 +3137,36 @@ static int ext4_rmdir(struct inode *dir, struct dentry *dentry)
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
@@ -3184,21 +3181,52 @@ static int ext4_unlink(struct inode *dir, struct dentry *dentry)
 
 	if (inode->i_nlink == 0) {
 		ext4_warning_inode(inode, "Deleting file '%.*s' with no links",
-				   dentry->d_name.len, dentry->d_name.name);
+				   d_name->len, d_name->name);
 		set_nlink(inode, 1);
 	}
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
 	drop_nlink(inode);
 	if (!inode->i_nlink)
 		ext4_orphan_add(handle, inode);
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
@@ -3209,11 +3237,6 @@ static int ext4_unlink(struct inode *dir, struct dentry *dentry)
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
@@ -3348,29 +3371,10 @@ static int ext4_symlink(struct inode *dir,
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
@@ -3404,6 +3408,30 @@ static int ext4_link(struct dentry *old_dentry,
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
2.24.1.735.g03f4e72817-goog

