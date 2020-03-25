Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1AA319327A
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Mar 2020 22:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbgCYVSi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 25 Mar 2020 17:18:38 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39576 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbgCYVSi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 25 Mar 2020 17:18:38 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id DBF1528ACCC
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH e2fsprogs 05/11] e2fsck: Fix entries with invalid encoded characters
Date:   Wed, 25 Mar 2020 17:18:05 -0400
Message-Id: <20200325211812.2971787-6-krisman@collabora.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200325211812.2971787-1-krisman@collabora.com>
References: <20200325211812.2971787-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On strict mode, invalid Unicode sequences are not permited.  This patch
adds a verification step to pass2 to detect and modify the entries with
the same replacement char used for non-encoding directories '.'.

After the encoding test, we still want to check the name for usual
problems, '\0', '/' in the middle of the sequence.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 e2fsck/e2fsck.c |  4 ++++
 e2fsck/e2fsck.h |  1 +
 e2fsck/pass1.c  | 17 +++++++++++++++++
 e2fsck/pass2.c  | 43 ++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/e2fsck/e2fsck.c b/e2fsck/e2fsck.c
index d8be566fbe97..dc4b45e25657 100644
--- a/e2fsck/e2fsck.c
+++ b/e2fsck/e2fsck.c
@@ -75,6 +75,10 @@ errcode_t e2fsck_reset_context(e2fsck_t ctx)
 		ext2fs_free_block_bitmap(ctx->block_found_map);
 		ctx->block_found_map = 0;
 	}
+	if (ctx->inode_casefold_map) {
+		ext2fs_free_block_bitmap(ctx->inode_casefold_map);
+		ctx->inode_casefold_map = 0;
+	}
 	if (ctx->inode_link_info) {
 		ext2fs_free_icount(ctx->inode_link_info);
 		ctx->inode_link_info = 0;
diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index 954bc9822ed2..335a5e4c6dca 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -262,6 +262,7 @@ struct e2fsck_struct {
 	ext2fs_inode_bitmap inode_bb_map; /* Inodes which are in bad blocks */
 	ext2fs_inode_bitmap inode_imagic_map; /* AFS inodes */
 	ext2fs_inode_bitmap inode_reg_map; /* Inodes which are regular files*/
+	ext2fs_inode_bitmap inode_casefold_map; /* Inodes which are casefolded */
 
 	ext2fs_block_bitmap block_found_map; /* Blocks which are in use */
 	ext2fs_block_bitmap block_dup_map; /* Blks referenced more than once */
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index a57c1c0670e6..8e61f110fd7a 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -1270,6 +1270,20 @@ void e2fsck_pass1(e2fsck_t ctx)
 		ctx->flags |= E2F_FLAG_ABORT;
 		return;
 	}
+	if (casefold_fs) {
+		pctx.errcode =
+			e2fsck_allocate_inode_bitmap(fs,
+						     _("inode casefold map"),
+						     EXT2FS_BMAP64_RBTREE,
+						     "inode_casefold_map",
+						     &ctx->inode_casefold_map);
+		if (pctx.errcode) {
+			pctx.num = 1;
+			fix_problem(ctx, PR_1_ALLOCATE_IBITMAP_ERROR, &pctx);
+			ctx->flags |= E2F_FLAG_ABORT;
+			return;
+		}
+	}
 	pctx.errcode = e2fsck_setup_icount(ctx, "inode_link_info", 0, NULL,
 					   &ctx->inode_link_info);
 	if (pctx.errcode) {
@@ -1888,6 +1902,9 @@ void e2fsck_pass1(e2fsck_t ctx)
 		    add_encrypted_file(ctx, &pctx) < 0)
 			goto clear_inode;
 
+		if (casefold_fs && inode->i_flags & EXT4_CASEFOLD_FL)
+			ext2fs_mark_inode_bitmap2(ctx->inode_casefold_map, ino);
+
 		if (LINUX_S_ISDIR(inode->i_mode)) {
 			ext2fs_mark_inode_bitmap2(ctx->inode_dir_map, ino);
 			e2fsck_add_dir_info(ctx, ino, 0);
diff --git a/e2fsck/pass2.c b/e2fsck/pass2.c
index d3f21017234c..c85ece1ce817 100644
--- a/e2fsck/pass2.c
+++ b/e2fsck/pass2.c
@@ -36,11 +36,13 @@
  * 	- The inode_bad_map bitmap
  * 	- The inode_dir_map bitmap
  * 	- The encrypted_file_info
+ *	- The inode_casefold_map bitmap
  *
  * Pass 2 frees the following data structures
  * 	- The inode_bad_map bitmap
  * 	- The inode_reg_map bitmap
  * 	- The encrypted_file_info
+ *	- The inode_casefold_map bitmap
  */
 
 #define _GNU_SOURCE 1 /* get strnlen() */
@@ -286,6 +288,10 @@ void e2fsck_pass2(e2fsck_t ctx)
 		ext2fs_free_inode_bitmap(ctx->inode_reg_map);
 		ctx->inode_reg_map = 0;
 	}
+	if (ctx->inode_casefold_map) {
+		ext2fs_free_inode_bitmap(ctx->inode_casefold_map);
+		ctx->inode_casefold_map = 0;
+	}
 	destroy_encrypted_file_info(ctx);
 
 	clear_problem_context(&pctx);
@@ -514,6 +520,30 @@ static int encrypted_check_name(e2fsck_t ctx,
 	return 0;
 }
 
+static int encoded_check_name(e2fsck_t ctx,
+			      struct ext2_dir_entry *dirent,
+			      struct problem_context *pctx)
+{
+	const struct ext2fs_nls_table *tbl = ctx->fs->encoding;
+	int ret;
+	int len = ext2fs_dirent_name_len(dirent);
+	char *pos, *end;
+
+	ret = ext2fs_check_encoded_name(tbl, dirent->name, len, &pos);
+	if (ret < 0) {
+		fatal_error(ctx, _("NLS is broken."));
+	} else if(ret > 0) {
+		ret = fix_problem(ctx, PR_2_BAD_NAME, pctx);
+		if (ret) {
+			end = &dirent->name[len];
+			for (; *pos && pos != end; pos++)
+				*pos = '.';
+		}
+	}
+
+	return (ret || check_name(ctx, dirent, pctx));
+}
+
 /*
  * Check the directory filetype (if present)
  */
@@ -997,11 +1027,18 @@ static int check_dir_block(ext2_filsys fs,
 	size_t	max_block_size;
 	int	hash_flags = 0;
 	static char *eop_read_dirblock = NULL;
+	int cf_dir = 0;
 
 	cd = (struct check_dir_struct *) priv_data;
 	ibuf = buf = cd->buf;
 	ctx = cd->ctx;
 
+	/* We only want filename encoding verification on strict
+	 * mode. */
+	if (ext2fs_test_inode_bitmap2(ctx->inode_casefold_map, ino) &&
+	    (ctx->fs->super->s_encoding_flags & EXT4_ENC_STRICT_MODE_FL))
+		cf_dir = 1;
+
 	if (ctx->flags & E2F_FLAG_RUN_RETURN)
 		return DIRENT_ABORT;
 
@@ -1482,7 +1519,11 @@ skip_checksum:
 		if (check_filetype(ctx, dirent, ino, &cd->pctx))
 			dir_modified++;
 
-		if (dir_encpolicy_id == NO_ENCRYPTION_POLICY) {
+		if (cf_dir) {
+			/* casefolded directory */
+			if (encoded_check_name(ctx, dirent, &cd->pctx))
+				dir_modified++;
+		} else if (dir_encpolicy_id == NO_ENCRYPTION_POLICY) {
 			/* Unencrypted directory */
 			if (check_name(ctx, dirent, &cd->pctx))
 				dir_modified++;
-- 
2.25.0

