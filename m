Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60F322D6436
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Dec 2020 18:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393007AbgLJR62 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Dec 2020 12:58:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392989AbgLJR5r (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Dec 2020 12:57:47 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E12C0611CB
        for <linux-ext4@vger.kernel.org>; Thu, 10 Dec 2020 09:56:51 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id 11so4823454pfu.4
        for <linux-ext4@vger.kernel.org>; Thu, 10 Dec 2020 09:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rQx0r6EJdwa89hSxY48/sioL6WDN/l+phmrotm7/LKA=;
        b=e85E3g+zPTqfwr/cIY05hjme4s8rjamrUfTFueWoUv67WN+TDUOrskT6h4xTAII7UH
         VygxeyvexNYBX1Kh9r+wckdvSpwitoDoKVI3FA5xuZHlj+CswyCv2gj5UH8Pa7X8zhkk
         GNkzlrrltsuSTB3qRcFHgTo4SBZSciIy6ZmGWADD+I4E07amY7Ydeb7T2xJiVxiYfHaZ
         6WmTGe+o7DVNM0UHHYz5ipGOsyerwvG2XMaLB8mZtAKHA9DN1Z7KSMTNeM4UBPGD5a+F
         lFrSu1A4Nh5RZHlnNvg73GBqcGB3fvWl+nqIQmZr/JgqYyy3MSztQBFNRMa5voR0Moka
         FuKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rQx0r6EJdwa89hSxY48/sioL6WDN/l+phmrotm7/LKA=;
        b=FO6r+JVMlvqFcbu+5INJejBHrKBRAkM8tzG5zGWlumZipnl+jbTqhdcn3qoH0hLLYe
         hFzZrEZQyGbF8hlZ6z/h/7KGg8bsFLuIOfxt2O4+CLDPOoX2N9VAiZ4+kCiLDhYjZmE8
         Zvq5gbMrIGiqIAqyUPFOE+XW7P4l2QLOd9aZJ1zzSG9FJtwP9/xUfE9KSPw/GRTk3Jr2
         mZaa5Oh3oteinKRvw/O5lE5CtVGebQRO4/2R0dywDYAMoPdAOYmrPIvY15R1dhk1e0Uy
         w2c6i76DyuCu1gIFK8IMLKCMKbuxQqLKeF12IlVgb+9hLXH+zTb0KGcpAmpmb1IEgpX4
         gTjQ==
X-Gm-Message-State: AOAM5323sTAlUC5PWVlSbl01wUnfSan2gkaqr3GCOW+SzfjMomyKfhu8
        OQSaTD/0Z20+SCvIVr/7P4Gpczo1vA0=
X-Google-Smtp-Source: ABdhPJwqGsCQwUwQd131LrY26+dBjQ/uxxbK0WcWR1vabuXQEsICBtDAEpcV8L3ZXVRHObbqesrneA==
X-Received: by 2002:a63:4c41:: with SMTP id m1mr7690689pgl.427.1607623010548;
        Thu, 10 Dec 2020 09:56:50 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id u24sm7433517pfm.81.2020.12.10.09.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 09:56:49 -0800 (PST)
From:   harshadshirwadkar@gmail.com
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v2 11/15] e2fsck: add fc replay for link, unlink, creat tags
Date:   Thu, 10 Dec 2020 09:56:04 -0800
Message-Id: <20201210175608.3265541-12-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
In-Reply-To: <20201210175608.3265541-1-harshadshirwadkar@gmail.com>
References: <20201210175608.3265541-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Add fast commit replay for directory entry updates.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 e2fsck/journal.c    | 93 +++++++++++++++++++++++++++++++++++++++++++++
 lib/ext2fs/ext2fs.h |  4 ++
 lib/ext2fs/unlink.c |  6 +--
 3 files changed, 100 insertions(+), 3 deletions(-)

diff --git a/e2fsck/journal.c b/e2fsck/journal.c
index 007c32c6..0f601384 100644
--- a/e2fsck/journal.c
+++ b/e2fsck/journal.c
@@ -380,6 +380,95 @@ static int ext4_fc_replay_scan(journal_t *j, struct buffer_head *bh,
 out_err:
 	return ret;
 }
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
+
+	tl_to_darg(&darg, tl);
+	ext2fs_unlink(ctx->fs, darg.parent_ino, darg.dname, darg.ino, 0);
+	/* It's okay if the above call fails */
+	free(darg.dname);
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
+	ret = ext2fs_read_inode(fs, darg.ino,
+					(struct ext2_inode *)&inode_large);
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
+	ret = ext2fs_link(fs, darg.parent_ino, darg.dname, darg.ino,
+				filetype);
+out:
+	free(darg.dname);
+	return ret;
+
+}
 /*
  * Main recovery path entry point. This function returns JBD2_FC_REPLAY_CONTINUE
  * to indicate that it is expecting more fast commit blocks. It returns
@@ -437,7 +526,11 @@ static int ext4_fc_replay(journal_t *journal, struct buffer_head *bh,
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
index eb2e6549..931cd569 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -1684,6 +1684,10 @@ extern errcode_t ext2fs_get_pathname(ext2_filsys fs, ext2_ino_t dir, ext2_ino_t
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
2.29.2.576.ga3fc446d84-goog

