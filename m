Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8F1154FF4
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Feb 2020 02:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgBGBR4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 Feb 2020 20:17:56 -0500
Received: from smtp-out-so.shaw.ca ([64.59.136.138]:60352 "EHLO
        smtp-out-so.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbgBGBR4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 Feb 2020 20:17:56 -0500
X-Greylist: delayed 487 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Feb 2020 20:17:55 EST
Received: from cabot.adilger.int ([70.77.216.213])
        by shaw.ca with ESMTP
        id zs9SiRcpt17ZDzs9TiUglz; Thu, 06 Feb 2020 18:09:47 -0700
X-Authority-Analysis: v=2.3 cv=ZsqT1OzG c=1 sm=1 tr=0
 a=BQvS1EmAg2ttxjPVUuc1UQ==:117 a=BQvS1EmAg2ttxjPVUuc1UQ==:17 a=ySfo2T4IAAAA:8
 a=lB0dNpNiAAAA:8 a=C-CyL1Y4a80PmgHQpMUA:9 a=ttwSxyGnxULQJk_7:21
 a=vGe2sljOHrG3OYsp:21 a=ZUkhVnNHqyo2at-WnAgH:22 a=c-ZiYqmG3AbHTdtsH08C:22
From:   Andreas Dilger <adilger@whamcloud.com>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org, Andreas Dilger <adilger@whamcloud.com>
Subject: [PATCH 1/9] e2fsck: fix e2fsck_allocate_memory() overflow
Date:   Thu,  6 Feb 2020 18:09:38 -0700
Message-Id: <1581037786-62789-1-git-send-email-adilger@whamcloud.com>
X-Mailer: git-send-email 1.8.0
X-CMAE-Envelope: MS4wfLK7gBrgKJNGOHfX1CHZbneT2U9JJA3dxlDPySRMNgC2ASvzZ47PYyF9unL9nZncZPi3XguckEEosvJM1QBdXWH3UzpF+FNyFUh+p3zQClhbuVUyWMWj
 r4758mVEYxSdKoglu+n2OEZjyK4CbDjP8BgVE2CiErEqgEvqCKDIlipahXeqVSWRmmPttdLURfZmT1slREN/D8kISyKXnlJ5rjNuZjytzuYrMBC7t/tzAVOX
 DMYVjjJBp0FP4kYY8PSUXg==
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

e2fsck_allocate_memory() takes an "unsigned int size" argument, which
will overflow for allocations above 4GB.  This happens for dir_info
and dx_dir_info arrays when there are more than 350M directories in a
filesystem, and for the dblist array above 180M directories.

There is also a risk of overflow during the binary search in both
e2fsck_get_dir_info() and e2fsck_get_dx_dir_info() when the midpoint
of the array is calculated, if there would be more than 2B directories
in the filesystem and working above the half way point.

Also, in some places inode numbers are "int" instead of "ext2_ino_t",
which can also cause problems with the array size calculations, and
makes it hard to identify where inode numbers are used.

Fix e2fsck_allocate_memory() to take an "unsigned long" argument to
match ext2fs_get_mem(), so that it can do single memory allocations
over 4GB.

Fix e2fsck_get_dir_info() and e2fsck_get_dx_dir_info() to temporarily
use an unsigned long long value to calculate the midpoint (which will
always fit into an ext2_ino_t again afterward).

Change variables that hold inode numbers to be ext2_ino_t, and print
them as unsigned values instead of printing negative inode numbers.

Signed-off-by: Andreas Dilger <adilger@whamcloud.com>
Reviewed-by: Shilong Wang <wshilong@ddn.com>
Lustre-bug-id: https://jira.whamcloud.com/browse/LU-13197
---
 e2fsck/dirinfo.c    | 37 +++++++++++++++++++------------------
 e2fsck/dx_dirinfo.c | 11 ++++++-----
 e2fsck/e2fsck.h     |  8 ++++----
 e2fsck/logfile.c    |  2 +-
 e2fsck/pass2.c      | 11 ++++++-----
 e2fsck/util.c       |  7 +++----
 6 files changed, 39 insertions(+), 37 deletions(-)

diff --git a/e2fsck/dirinfo.c b/e2fsck/dirinfo.c
index cceadac..49d624c 100644
--- a/e2fsck/dirinfo.c
+++ b/e2fsck/dirinfo.c
@@ -17,8 +17,8 @@
 #include <ext2fs/tdb.h>
 
 struct dir_info_db {
-	int		count;
-	int		size;
+	ext2_ino_t	count;
+	ext2_ino_t	size;
 	struct dir_info *array;
 	struct dir_info *last_lookup;
 #ifdef CONFIG_TDB
@@ -28,7 +28,7 @@ struct dir_info_db {
 };
 
 struct dir_info_iter {
-	int	i;
+	ext2_ino_t	i;
 #ifdef CONFIG_TDB
 	TDB_DATA	tdb_iter;
 #endif
@@ -46,7 +46,7 @@ static void e2fsck_put_dir_info(e2fsck_t ctx, struct dir_info *dir);
 static void setup_tdb(e2fsck_t ctx, ext2_ino_t num_dirs)
 {
 	struct dir_info_db	*db = ctx->dir_info;
-	unsigned int		threshold;
+	ext2_ino_t		threshold;
 	errcode_t		retval;
 	mode_t			save_umask;
 	char			*tdb_dir, uuid[40];
@@ -130,12 +130,12 @@ static void setup_db(e2fsck_t ctx)
 void e2fsck_add_dir_info(e2fsck_t ctx, ext2_ino_t ino, ext2_ino_t parent)
 {
 	struct dir_info		*dir, *old_array;
-	int			i, j;
+	ext2_ino_t		i, j;
 	errcode_t		retval;
 	unsigned long		old_size;
 
 #ifdef DIRINFO_DEBUG
-	printf("add_dir_info for inode (%lu, %lu)...\n", ino, parent);
+	printf("add_dir_info for inode (%u, %u)...\n", ino, parent);
 #endif
 	if (!ctx->dir_info)
 		setup_db(ctx);
@@ -149,7 +149,7 @@ void e2fsck_add_dir_info(e2fsck_t ctx, ext2_ino_t ino, ext2_ino_t parent)
 					   &ctx->dir_info->array);
 		if (retval) {
 			fprintf(stderr, "Couldn't reallocate dir_info "
-				"structure to %d entries\n",
+				"structure to %u entries\n",
 				ctx->dir_info->size);
 			fatal_error(ctx, 0);
 			ctx->dir_info->size -= 10;
@@ -204,13 +204,13 @@ void e2fsck_add_dir_info(e2fsck_t ctx, ext2_ino_t ino, ext2_ino_t parent)
 static struct dir_info *e2fsck_get_dir_info(e2fsck_t ctx, ext2_ino_t ino)
 {
 	struct dir_info_db	*db = ctx->dir_info;
-	int			low, high, mid;
+	ext2_ino_t low, high, mid;
 
 	if (!db)
 		return 0;
 
 #ifdef DIRINFO_DEBUG
-	printf("e2fsck_get_dir_info %d...", ino);
+	printf("e2fsck_get_dir_info %u...", ino);
 #endif
 
 #ifdef CONFIG_TDB
@@ -235,7 +235,7 @@ static struct dir_info *e2fsck_get_dir_info(e2fsck_t ctx, ext2_ino_t ino)
 		ret_dir_info.dotdot = buf->dotdot;
 		ret_dir_info.parent = buf->parent;
 #ifdef DIRINFO_DEBUG
-		printf("(%d,%d,%d)\n", ino, buf->dotdot, buf->parent);
+		printf("(%u,%u,%u)\n", ino, buf->dotdot, buf->parent);
 #endif
 		free(data.dptr);
 		return &ret_dir_info;
@@ -246,10 +246,10 @@ static struct dir_info *e2fsck_get_dir_info(e2fsck_t ctx, ext2_ino_t ino)
 		return db->last_lookup;
 
 	low = 0;
-	high = ctx->dir_info->count-1;
+	high = ctx->dir_info->count - 1;
 	if (ino == ctx->dir_info->array[low].ino) {
 #ifdef DIRINFO_DEBUG
-		printf("(%d,%d,%d)\n", ino,
+		printf("(%u,%u,%u)\n", ino,
 		       ctx->dir_info->array[low].dotdot,
 		       ctx->dir_info->array[low].parent);
 #endif
@@ -257,7 +257,7 @@ static struct dir_info *e2fsck_get_dir_info(e2fsck_t ctx, ext2_ino_t ino)
 	}
 	if (ino == ctx->dir_info->array[high].ino) {
 #ifdef DIRINFO_DEBUG
-		printf("(%d,%d,%d)\n", ino,
+		printf("(%u,%u,%u)\n", ino,
 		       ctx->dir_info->array[high].dotdot,
 		       ctx->dir_info->array[high].parent);
 #endif
@@ -265,12 +265,13 @@ static struct dir_info *e2fsck_get_dir_info(e2fsck_t ctx, ext2_ino_t ino)
 	}
 
 	while (low < high) {
-		mid = (low+high)/2;
+		/* sum may overflow, but result will fit into mid again */
+		mid = (unsigned long long)(low + high) / 2;
 		if (mid == low || mid == high)
 			break;
 		if (ino == ctx->dir_info->array[mid].ino) {
 #ifdef DIRINFO_DEBUG
-			printf("(%d,%d,%d)\n", ino,
+			printf("(%u,%u,%u)\n", ino,
 			       ctx->dir_info->array[mid].dotdot,
 			       ctx->dir_info->array[mid].parent);
 #endif
@@ -294,7 +295,7 @@ static void e2fsck_put_dir_info(e2fsck_t ctx EXT2FS_NO_TDB_UNUSED,
 #endif
 
 #ifdef DIRINFO_DEBUG
-	printf("e2fsck_put_dir_info (%d, %d, %d)...", dir->ino, dir->dotdot,
+	printf("e2fsck_put_dir_info (%u, %u, %u)...", dir->ino, dir->dotdot,
 	       dir->parent);
 #endif
 
@@ -329,7 +330,7 @@ void e2fsck_free_dir_info(e2fsck_t ctx)
 			if (unlink(ctx->dir_info->tdb_fn) < 0)
 				com_err("e2fsck_free_dir_info", errno,
 					_("while freeing dir_info tdb file"));
-			free(ctx->dir_info->tdb_fn);
+			ext2fs_free_mem(&ctx->dir_info->tdb_fn);
 		}
 #endif
 		if (ctx->dir_info->array)
@@ -412,7 +413,7 @@ struct dir_info *e2fsck_dir_info_iter(e2fsck_t ctx, struct dir_info_iter *iter)
 		return 0;
 
 #ifdef DIRINFO_DEBUG
-	printf("iter(%d, %d, %d)...", ctx->dir_info->array[iter->i].ino,
+	printf("iter(%u, %u, %u)...", ctx->dir_info->array[iter->i].ino,
 	       ctx->dir_info->array[iter->i].dotdot,
 	       ctx->dir_info->array[iter->i].parent);
 #endif
diff --git a/e2fsck/dx_dirinfo.c b/e2fsck/dx_dirinfo.c
index c0b0e9a..89672b7 100644
--- a/e2fsck/dx_dirinfo.c
+++ b/e2fsck/dx_dirinfo.c
@@ -17,7 +17,7 @@ void e2fsck_add_dx_dir(e2fsck_t ctx, ext2_ino_t ino, struct ext2_inode *inode,
 		       int num_blocks)
 {
 	struct dx_dir_info *dir;
-	int		i, j;
+	ext2_ino_t	i, j;
 	errcode_t	retval;
 	unsigned long	old_size;
 
@@ -41,7 +41,7 @@ void e2fsck_add_dx_dir(e2fsck_t ctx, ext2_ino_t ino, struct ext2_inode *inode,
 					   &ctx->dx_dir_info);
 		if (retval) {
 			fprintf(stderr, "Couldn't reallocate dx_dir_info "
-				"structure to %d entries\n",
+				"structure to %u entries\n",
 				ctx->dx_dir_info_size);
 			fatal_error(ctx, 0);
 			ctx->dx_dir_info_size -= 10;
@@ -86,7 +86,7 @@ void e2fsck_add_dx_dir(e2fsck_t ctx, ext2_ino_t ino, struct ext2_inode *inode,
  */
 struct dx_dir_info *e2fsck_get_dx_dir_info(e2fsck_t ctx, ext2_ino_t ino)
 {
-	int	low, high, mid;
+	ext2_ino_t low, high, mid;
 
 	low = 0;
 	high = ctx->dx_dir_info_count-1;
@@ -98,7 +98,8 @@ struct dx_dir_info *e2fsck_get_dx_dir_info(e2fsck_t ctx, ext2_ino_t ino)
 		return &ctx->dx_dir_info[high];
 
 	while (low < high) {
-		mid = (low+high)/2;
+		/* sum may overflow, but result will fit into mid again */
+		mid = (unsigned long long)(low + high) / 2;
 		if (mid == low || mid == high)
 			break;
 		if (ino == ctx->dx_dir_info[mid].ino)
@@ -116,8 +117,8 @@ struct dx_dir_info *e2fsck_get_dx_dir_info(e2fsck_t ctx, ext2_ino_t ino)
  */
 void e2fsck_free_dx_dir_info(e2fsck_t ctx)
 {
-	int	i;
 	struct dx_dir_info *dir;
+	ext2_ino_t i;
 
 	if (ctx->dx_dir_info) {
 		dir = ctx->dx_dir_info;
diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index 2d359b3..253f8b5 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -318,9 +318,9 @@ struct e2fsck_struct {
 	/*
 	 * Indexed directory information
 	 */
-	int		dx_dir_info_count;
-	int		dx_dir_info_size;
-	struct dx_dir_info *dx_dir_info;
+	ext2_ino_t		dx_dir_info_count;
+	ext2_ino_t		dx_dir_info_size;
+	struct dx_dir_info	*dx_dir_info;
 
 	/*
 	 * Directories to hash
@@ -595,7 +595,7 @@ int check_backup_super_block(e2fsck_t ctx);
 void check_resize_inode(e2fsck_t ctx);
 
 /* util.c */
-extern void *e2fsck_allocate_memory(e2fsck_t ctx, unsigned int size,
+extern void *e2fsck_allocate_memory(e2fsck_t ctx, unsigned long size,
 				    const char *description);
 extern int ask(e2fsck_t ctx, const char * string, int def);
 extern int ask_yn(e2fsck_t ctx, const char * string, int def);
diff --git a/e2fsck/logfile.c b/e2fsck/logfile.c
index 3eeefd1..63e9a12 100644
--- a/e2fsck/logfile.c
+++ b/e2fsck/logfile.c
@@ -353,7 +353,7 @@ void set_up_logging(e2fsck_t ctx)
 					    ctx->problem_log_fn);
 }
 #else
-void *e2fsck_allocate_memory(e2fsck_t ctx, unsigned int size,
+void *e2fsck_allocate_memory(e2fsck_t ctx, unsigned long size,
 			     const char *description)
 {
 	void *ret;
diff --git a/e2fsck/pass2.c b/e2fsck/pass2.c
index 8b40e93..5c3f7b8 100644
--- a/e2fsck/pass2.c
+++ b/e2fsck/pass2.c
@@ -131,7 +131,8 @@ void e2fsck_pass2(e2fsck_t ctx)
 	struct dx_dir_info	*dx_dir;
 	struct dx_dirblock_info	*dx_db;
 	int			b;
-	int			i, depth;
+	ext2_ino_t		i;
+	int			depth;
 	problem_t		code;
 	int			bad_dir;
 	int (*check_dir_func)(ext2_filsys fs,
@@ -586,10 +587,10 @@ static void parse_int_node(ext2_filsys fs,
 #ifdef DX_DEBUG
 		printf("Root node dump:\n");
 		printf("\t Reserved zero: %u\n", root->reserved_zero);
-		printf("\t Hash Version: %d\n", root->hash_version);
-		printf("\t Info length: %d\n", root->info_length);
-		printf("\t Indirect levels: %d\n", root->indirect_levels);
-		printf("\t Flags: %d\n", root->unused_flags);
+		printf("\t Hash Version: %u\n", root->hash_version);
+		printf("\t Info length: %u\n", root->info_length);
+		printf("\t Indirect levels: %u\n", root->indirect_levels);
+		printf("\t Flags: %x\n", root->unused_flags);
 #endif
 
 		ent = (struct ext2_dx_entry *) (block_buf + 24 + root->info_length);
diff --git a/e2fsck/util.c b/e2fsck/util.c
index db6a1cc..300993d 100644
--- a/e2fsck/util.c
+++ b/e2fsck/util.c
@@ -116,7 +116,7 @@ void log_err(e2fsck_t ctx, const char *fmt, ...)
 	}
 }
 
-void *e2fsck_allocate_memory(e2fsck_t ctx, unsigned int size,
+void *e2fsck_allocate_memory(e2fsck_t ctx, unsigned long size,
 			     const char *description)
 {
 	void *ret;
@@ -125,13 +125,12 @@ void *e2fsck_allocate_memory(e2fsck_t ctx, unsigned int size,
 #ifdef DEBUG_ALLOCATE_MEMORY
 	printf("Allocating %u bytes for %s...\n", size, description);
 #endif
-	ret = malloc(size);
-	if (!ret) {
+	if (ext2fs_get_memzero(size, &ret)) {
 		sprintf(buf, "Can't allocate %u bytes for %s\n",
 			size, description);
 		fatal_error(ctx, buf);
 	}
-	memset(ret, 0, size);
+
 	return ret;
 }
 
-- 
1.8.0

