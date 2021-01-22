Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFD62FFC55
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Jan 2021 06:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbhAVFqW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 22 Jan 2021 00:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbhAVFqK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 22 Jan 2021 00:46:10 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F97C06178B
        for <linux-ext4@vger.kernel.org>; Thu, 21 Jan 2021 21:45:26 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id m6so2984724pfm.6
        for <linux-ext4@vger.kernel.org>; Thu, 21 Jan 2021 21:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C8gczVJwVOIq7YaRWe1R24U1NCeNSseRB7yWMSFZ6pU=;
        b=Gm5JI3OeJcOHdu87eAZemRdPx/3Wf5rurzn0nXGHmlZUPZtGqphnoqR/w0xUT95sn6
         41bLxC2QlWePBAiqmQnjp+5mPaHC+rVLnm47jrzv9hWJK4ET+spRMx0YyYUfhYvXGO3A
         UCeI8OKQ3WZAezHzb6GKehfzHaGRbLXXf5GQEGkVMUKjYATowdA18AuWEdsIV8xqeYDJ
         21y0FrkXThJ9Sw6Z6DYop2T36g5Hdy1+roR4YC9NM+P8Cg68AL9RHyV8u60DVQy3kxjG
         HXjhDyNODQVk0XL25DMtcJHL/ZILLhXqk+sFkWD1YMnx6xg+E2sbuRXjgMs7/jDWotGC
         5wxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C8gczVJwVOIq7YaRWe1R24U1NCeNSseRB7yWMSFZ6pU=;
        b=mw94nGkMStPgIVMlyNHbLKEaxoYHkM1pYoVPX5UGsYplnA8GUqRU8CZxtfiJMo7jBh
         7bU6vXeeVMA9Fnt9KVqffJiWZvQv6x/DWWaV4R39Wi89TWDfZpifM2OMISo82YeGkznr
         9lk7Pnaz954HPbK/DHmlVnIGzU6lNFfW2TQwIupKrad5OSMKExnd4qMBOYz4pmFuv/0d
         dx75YL2wd25ETUUQD/aOoNzI9g5u/Rv1Lxh3VSNGNR2gMY/5lTmWTN4FGqEXDfECMwv8
         SVJyPwFhPfX2Fr7FNIs4scICi//Rfd682KtMLVEEkiNgtbRoQesmnNc0cEmlUWYfgs7z
         My2A==
X-Gm-Message-State: AOAM5330eyk1nHWkUhT2l8P0HCL9N5tfRs/GdjIEWMUndWyx7dVaj24Y
        h0tH4xz5YBTS2o6LyU1xWEi/4wEOuLo=
X-Google-Smtp-Source: ABdhPJxi0gy7BvEXAoUuYJbvGNpUL6lWemNMsD7iLAXqOiZKVXDmLAXIsr7bBCWBJ7dG8vc0rYVIXg==
X-Received: by 2002:a62:ee18:0:b029:1b3:b9d2:6d7b with SMTP id e24-20020a62ee180000b02901b3b9d26d7bmr3161191pfi.32.1611294325308;
        Thu, 21 Jan 2021 21:45:25 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id gg6sm12245827pjb.2.2021.01.21.21.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 21:45:24 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <--global>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v4 6/8] e2fsck: add fc replay for link, unlink, creat tags
Date:   Thu, 21 Jan 2021 21:45:02 -0800
Message-Id: <20210122054504.1498532-7-user@harshads-520.kir.corp.google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
In-Reply-To: <20210122054504.1498532-1-user@harshads-520.kir.corp.google.com>
References: <20210122054504.1498532-1-user@harshads-520.kir.corp.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Add fast commit replay for directory entry updates.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 e2fsck/journal.c    | 112 ++++++++++++++++++++++++++++++++++++++++++++
 lib/ext2fs/ext2fs.h |   4 ++
 lib/ext2fs/unlink.c |   6 +--
 3 files changed, 119 insertions(+), 3 deletions(-)

diff --git a/e2fsck/journal.c b/e2fsck/journal.c
index 007c32c6..2afe0929 100644
--- a/e2fsck/journal.c
+++ b/e2fsck/journal.c
@@ -380,6 +380,114 @@ static int ext4_fc_replay_scan(journal_t *j, struct buffer_head *bh,
 out_err:
 	return ret;
 }
+
+static int __errcode_to_errno(errcode_t err, const char *func, int line)
+{
+	if (err == 0)
+		return 0;
+	fprintf(stderr, "Error \"%s\" encountered in function %s at line %d\n",
+		error_message(err), func, line);
+	if (err <= 256)
+		return -err;
+	return -EFAULT;
+}
+
+#define errcode_to_errno(err)	__errcode_to_errno(err, __func__, __LINE__)
+
+/* Helper struct for dentry replay routines */
+struct dentry_info_args {
+	int parent_ino, dname_len, ino, inode_len;
+	char *dname;
+};
+
+static inline void tl_to_darg(struct dentry_info_args *darg,
+				struct  ext4_fc_tl *tl)
+{
+	struct ext4_fc_dentry_info *fcd;
+	int tag = le16_to_cpu(tl->fc_tag);
+
+	fcd = (struct ext4_fc_dentry_info *)ext4_fc_tag_val(tl);
+
+	darg->parent_ino = le32_to_cpu(fcd->fc_parent_ino);
+	darg->ino = le32_to_cpu(fcd->fc_ino);
+	darg->dname = fcd->fc_dname;
+	darg->dname_len = ext4_fc_tag_len(tl) -
+			sizeof(struct ext4_fc_dentry_info);
+	darg->dname = malloc(darg->dname_len + 1);
+	memcpy(darg->dname, fcd->fc_dname, darg->dname_len);
+	darg->dname[darg->dname_len] = 0;
+	jbd_debug(1, "%s: %s, ino %d, parent %d\n",
+		tag == EXT4_FC_TAG_CREAT ? "create" :
+		(tag == EXT4_FC_TAG_LINK ? "link" :
+		(tag == EXT4_FC_TAG_UNLINK ? "unlink" : "error")),
+		darg->dname, darg->ino, darg->parent_ino);
+}
+
+static int ext4_fc_handle_unlink(e2fsck_t ctx, struct ext4_fc_tl *tl)
+{
+	struct ext2_inode inode;
+	struct dentry_info_args darg;
+	ext2_filsys fs = ctx->fs;
+	int ret;
+
+	tl_to_darg(&darg, tl);
+	ret = errcode_to_errno(
+		       ext2fs_unlink(ctx->fs, darg.parent_ino,
+				     darg.dname, darg.ino, 0));
+	/* It's okay if the above call fails */
+	free(darg.dname);
+	return ret;
+}
+
+static int ext4_fc_handle_link_and_create(e2fsck_t ctx, struct ext4_fc_tl *tl)
+{
+	struct dentry_info_args darg;
+	ext2_filsys fs = ctx->fs;
+	struct ext2_inode_large inode_large;
+	int ret, filetype, mode;
+
+	tl_to_darg(&darg, tl);
+	ret = errcode_to_errno(ext2fs_read_inode(fs, darg.ino,
+						 (struct ext2_inode *)&inode_large));
+	if (ret)
+		goto out;
+
+	mode = inode_large.i_mode;
+
+	if (LINUX_S_ISREG(mode))
+		filetype = EXT2_FT_REG_FILE;
+	else if (LINUX_S_ISDIR(mode))
+		filetype = EXT2_FT_DIR;
+	else if (LINUX_S_ISCHR(mode))
+		filetype = EXT2_FT_CHRDEV;
+	else if (LINUX_S_ISBLK(mode))
+		filetype = EXT2_FT_BLKDEV;
+	else if (LINUX_S_ISLNK(mode))
+		return EXT2_FT_SYMLINK;
+	else if (LINUX_S_ISFIFO(mode))
+		filetype = EXT2_FT_FIFO;
+	else if (LINUX_S_ISSOCK(mode))
+		filetype = EXT2_FT_SOCK;
+	else {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/*
+	 * Forcefully unlink if the same name is present and ignore the error
+	 * if any, since this dirent might not exist
+	 */
+	ext2fs_unlink(fs, darg.parent_ino, darg.dname, darg.ino,
+			EXT2FS_UNLINK_FORCE);
+
+	ret = errcode_to_errno(
+		       ext2fs_link(fs, darg.parent_ino, darg.dname, darg.ino,
+				   filetype));
+out:
+	free(darg.dname);
+	return ret;
+
+}
 /*
  * Main recovery path entry point. This function returns JBD2_FC_REPLAY_CONTINUE
  * to indicate that it is expecting more fast commit blocks. It returns
@@ -437,7 +545,11 @@ static int ext4_fc_replay(journal_t *journal, struct buffer_head *bh,
 		switch (le16_to_cpu(tl->fc_tag)) {
 		case EXT4_FC_TAG_CREAT:
 		case EXT4_FC_TAG_LINK:
+			ret = ext4_fc_handle_link_and_create(ctx, tl);
+			break;
 		case EXT4_FC_TAG_UNLINK:
+			ret = ext4_fc_handle_unlink(ctx, tl);
+			break;
 		case EXT4_FC_TAG_ADD_RANGE:
 		case EXT4_FC_TAG_DEL_RANGE:
 		case EXT4_FC_TAG_INODE:
diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index 7a25e0e5..b1752ac7 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -1693,6 +1693,10 @@ extern errcode_t ext2fs_get_pathname(ext2_filsys fs, ext2_ino_t dir, ext2_ino_t
 			       char **name);
 
 /* link.c */
+#define EXT2FS_UNLINK_FORCE		0x1	/* Forcefully unlink even if
+						 * the inode number doesn't
+						 * match the dirent
+						 */
 errcode_t ext2fs_link(ext2_filsys fs, ext2_ino_t dir, const char *name,
 		      ext2_ino_t ino, int flags);
 errcode_t ext2fs_unlink(ext2_filsys fs, ext2_ino_t dir, const char *name,
diff --git a/lib/ext2fs/unlink.c b/lib/ext2fs/unlink.c
index 8ab27ee2..3ec04cfb 100644
--- a/lib/ext2fs/unlink.c
+++ b/lib/ext2fs/unlink.c
@@ -49,7 +49,7 @@ static int unlink_proc(struct ext2_dir_entry *dirent,
 		if (strncmp(ls->name, dirent->name, ext2fs_dirent_name_len(dirent)))
 			return 0;
 	}
-	if (ls->inode) {
+	if (!(ls->flags & EXT2FS_UNLINK_FORCE) && ls->inode) {
 		if (dirent->inode != ls->inode)
 			return 0;
 	} else {
@@ -70,7 +70,7 @@ static int unlink_proc(struct ext2_dir_entry *dirent,
 #endif
 errcode_t ext2fs_unlink(ext2_filsys fs, ext2_ino_t dir,
 			const char *name, ext2_ino_t ino,
-			int flags EXT2FS_ATTR((unused)))
+			int flags)
 {
 	errcode_t	retval;
 	struct link_struct ls;
@@ -86,7 +86,7 @@ errcode_t ext2fs_unlink(ext2_filsys fs, ext2_ino_t dir,
 	ls.name = name;
 	ls.namelen = name ? strlen(name) : 0;
 	ls.inode = ino;
-	ls.flags = 0;
+	ls.flags = flags;
 	ls.done = 0;
 	ls.prev = 0;
 
-- 
2.30.0.280.ga3ce27912f-goog

