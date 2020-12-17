Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 066FE2DD658
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Dec 2020 18:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbgLQRgi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Dec 2020 12:36:38 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54762 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgLQRgg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Dec 2020 12:36:36 -0500
Received: from xps.home (unknown [IPv6:2a01:e35:2fb5:1510:779a:3a80:1322:d34a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aferraris)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id B0DD41F45D15;
        Thu, 17 Dec 2020 17:35:53 +0000 (GMT)
From:   Arnaud Ferraris <arnaud.ferraris@collabora.com>
To:     linux-ext4@vger.kernel.org
Cc:     drosen@google.com, krisman@collabora.com, ebiggers@kernel.org,
        tytso@mit.edu, Arnaud Ferraris <arnaud.ferraris@collabora.com>
Subject: [PATCH v3 07/12] e2fsck: Support casefold directories when rehashing
Date:   Thu, 17 Dec 2020 18:35:39 +0100
Message-Id: <20201217173544.52953-8-arnaud.ferraris@collabora.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201217173544.52953-1-arnaud.ferraris@collabora.com>
References: <20201217173544.52953-1-arnaud.ferraris@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Gabriel Krisman Bertazi <krisman@collabora.com>

When rehashing a +F directory, the casefold comparison needs to be
performed, in order to identify duplicated filenames.  Like the -F
version, This is done in two steps, first adapt the qsort comparison to
consider casefolded directories, and then iterate over the sorted list
fixing dups.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
---
Changes in v3:
  - removed extra lines

 e2fsck/rehash.c | 85 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 69 insertions(+), 16 deletions(-)

diff --git a/e2fsck/rehash.c b/e2fsck/rehash.c
index 30e510a6..0fbf4cbd 100644
--- a/e2fsck/rehash.c
+++ b/e2fsck/rehash.c
@@ -214,6 +214,22 @@ static EXT2_QSORT_TYPE ino_cmp(const void *a, const void *b)
 	return (he_a->ino - he_b->ino);
 }
 
+struct name_cmp_ctx
+{
+	int casefold;
+	const struct ext2fs_nls_table *tbl;
+};
+
+static int same_name(const struct name_cmp_ctx *cmp_ctx, char *s1,
+		     int len1, char *s2, int len2)
+{
+	if (!cmp_ctx->casefold)
+		return (len1 == len2 &&	!memcmp(s1, s2, len1));
+	else
+		return !ext2fs_casefold_cmp(cmp_ctx->tbl,
+					    s1, len1, s2, len2);
+}
+
 /* Used for sorting the hash entry */
 static EXT2_QSORT_TYPE name_cmp(const void *a, const void *b)
 {
@@ -240,9 +256,34 @@ static EXT2_QSORT_TYPE name_cmp(const void *a, const void *b)
 	return ret;
 }
 
+static EXT2_QSORT_TYPE name_cf_cmp(const struct name_cmp_ctx *ctx,
+				   const void *a, const void *b)
+{
+	const struct hash_entry *he_a = (const struct hash_entry *) a;
+	const struct hash_entry *he_b = (const struct hash_entry *) b;
+	unsigned int he_a_len, he_b_len, min_len;
+	int ret;
+
+	he_a_len = ext2fs_dirent_name_len(he_a->dir);
+	he_b_len = ext2fs_dirent_name_len(he_b->dir);
+
+	ret = ext2fs_casefold_cmp(ctx->tbl, he_a->dir->name, he_a_len,
+				  he_b->dir->name, he_b_len);
+	if (ret == 0) {
+		if (he_a_len > he_b_len)
+			ret = 1;
+		else if (he_a_len < he_b_len)
+			ret = -1;
+		else
+			ret = he_b->dir->inode - he_a->dir->inode;
+	}
+	return ret;
+}
+
 /* Used for sorting the hash entry */
-static EXT2_QSORT_TYPE hash_cmp(const void *a, const void *b)
+static EXT2_QSORT_TYPE hash_cmp(const void *a, const void *b, void *arg)
 {
+	const struct name_cmp_ctx *ctx = (struct name_cmp_ctx *) arg;
 	const struct hash_entry *he_a = (const struct hash_entry *) a;
 	const struct hash_entry *he_b = (const struct hash_entry *) b;
 	int	ret;
@@ -256,8 +297,12 @@ static EXT2_QSORT_TYPE hash_cmp(const void *a, const void *b)
 			ret = 1;
 		else if (he_a->minor_hash < he_b->minor_hash)
 			ret = -1;
-		else
-			ret = name_cmp(a, b);
+		else {
+			if (ctx->casefold)
+				ret = name_cf_cmp(ctx, a, b);
+			else
+				ret = name_cmp(a, b);
+		}
 	}
 	return ret;
 }
@@ -380,7 +425,8 @@ static void mutate_name(char *str, unsigned int *len)
 
 static int duplicate_search_and_fix(e2fsck_t ctx, ext2_filsys fs,
 				    ext2_ino_t ino,
-				    struct fill_dir_struct *fd)
+				    struct fill_dir_struct *fd,
+				    const struct name_cmp_ctx *cmp_ctx)
 {
 	struct problem_context	pctx;
 	struct hash_entry	*ent, *prev;
@@ -403,10 +449,10 @@ static int duplicate_search_and_fix(e2fsck_t ctx, ext2_filsys fs,
 		ent = fd->harray + i;
 		prev = ent - 1;
 		if (!ent->dir->inode ||
-		    (ext2fs_dirent_name_len(ent->dir) !=
-		     ext2fs_dirent_name_len(prev->dir)) ||
-		    memcmp(ent->dir->name, prev->dir->name,
-			     ext2fs_dirent_name_len(ent->dir)))
+		    !same_name(cmp_ctx, ent->dir->name,
+			       ext2fs_dirent_name_len(ent->dir),
+			       prev->dir->name,
+			       ext2fs_dirent_name_len(prev->dir)))
 			continue;
 		pctx.dirent = ent->dir;
 		if ((ent->dir->inode == prev->dir->inode) &&
@@ -426,10 +472,11 @@ static int duplicate_search_and_fix(e2fsck_t ctx, ext2_filsys fs,
 		mutate_name(new_name, &new_len);
 		for (j=0; j < fd->num_array; j++) {
 			if ((i==j) ||
-			    (new_len !=
-			     (unsigned) ext2fs_dirent_name_len(fd->harray[j].dir)) ||
-			    memcmp(new_name, fd->harray[j].dir->name, new_len))
+			    !same_name(cmp_ctx, new_name, new_len,
+				       fd->harray[j].dir->name,
+				       ext2fs_dirent_name_len(fd->harray[j].dir))) {
 				continue;
+			}
 			mutate_name(new_name, &new_len);
 
 			j = -1;
@@ -894,6 +941,7 @@ errcode_t e2fsck_rehash_dir(e2fsck_t ctx, ext2_ino_t ino,
 	struct fill_dir_struct	fd = { NULL, NULL, 0, 0, 0, NULL,
 				       0, 0, 0, 0, 0, 0 };
 	struct out_dir		outdir = { 0, 0, 0, 0 };
+	struct name_cmp_ctx name_cmp_ctx = {0, NULL};
 
 	e2fsck_read_inode(ctx, ino, &inode, "rehash_dir");
 
@@ -921,6 +969,11 @@ errcode_t e2fsck_rehash_dir(e2fsck_t ctx, ext2_ino_t ino,
 		fd.compress = 1;
 	fd.parent = 0;
 
+	if (fs->encoding && (inode.i_flags & EXT4_CASEFOLD_FL)) {
+		name_cmp_ctx.casefold = 1;
+		name_cmp_ctx.tbl = fs->encoding;
+	}
+
 retry_nohash:
 	/* Read in the entire directory into memory */
 	retval = ext2fs_block_iterate3(fs, ino, 0, 0,
@@ -949,16 +1002,16 @@ retry_nohash:
 	/* Sort the list */
 resort:
 	if (fd.compress && fd.num_array > 1)
-		qsort(fd.harray+2, fd.num_array-2, sizeof(struct hash_entry),
-		      hash_cmp);
+		qsort_r(fd.harray+2, fd.num_array-2, sizeof(struct hash_entry),
+			hash_cmp, &name_cmp_ctx);
 	else
-		qsort(fd.harray, fd.num_array, sizeof(struct hash_entry),
-		      hash_cmp);
+		qsort_r(fd.harray, fd.num_array, sizeof(struct hash_entry),
+			hash_cmp, &name_cmp_ctx);
 
 	/*
 	 * Look for duplicates
 	 */
-	if (duplicate_search_and_fix(ctx, fs, ino, &fd))
+	if (duplicate_search_and_fix(ctx, fs, ino, &fd, &name_cmp_ctx))
 		goto resort;
 
 	if (ctx->options & E2F_OPT_NO) {
-- 
2.29.2

