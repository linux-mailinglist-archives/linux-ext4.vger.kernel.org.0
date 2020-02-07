Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94487154FFC
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Feb 2020 02:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbgBGBSA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 Feb 2020 20:18:00 -0500
Received: from smtp-out-so.shaw.ca ([64.59.136.139]:60368 "EHLO
        smtp-out-so.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbgBGBR5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 Feb 2020 20:17:57 -0500
Received: from cabot.adilger.int ([70.77.216.213])
        by shaw.ca with ESMTP
        id zs9SiRcpt17ZDzs9WiUgmi; Thu, 06 Feb 2020 18:09:50 -0700
X-Authority-Analysis: v=2.3 cv=ZsqT1OzG c=1 sm=1 tr=0
 a=BQvS1EmAg2ttxjPVUuc1UQ==:117 a=BQvS1EmAg2ttxjPVUuc1UQ==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=ySfo2T4IAAAA:8 a=ntvsM6-r5us1AxQOYP8A:9
 a=9yuAiqEzGmFQkQtd:21 a=znKOtqdyLwAs2zxQ:21 a=ZUkhVnNHqyo2at-WnAgH:22
From:   Andreas Dilger <adilger@whamcloud.com>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org, Andreas Dilger <adilger@whamcloud.com>
Subject: [PATCH 8/9] e2fsck: consistently use ext2fs_get_mem()
Date:   Thu,  6 Feb 2020 18:09:45 -0700
Message-Id: <1581037786-62789-8-git-send-email-adilger@whamcloud.com>
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1581037786-62789-1-git-send-email-adilger@whamcloud.com>
References: <1581037786-62789-1-git-send-email-adilger@whamcloud.com>
X-CMAE-Envelope: MS4wfCHFKYyVwTbMSdzILXV/ZzhITSbAJ1orY4M4amqh9Q6vQun2CxmuFZyZXL97gNl2y2ZZiJKkbNJ0ZfSuXxHFdVuxkHQCHGLfB86PTPP1JDBUexb7fH6+
 /OdoHj9ml1MEWa/aRhwYtJkkHTUOGqg1f2HD8sUN3BEXBqDauIpCNqN8dLNAioBp01URn+9SyMlgtp7lAhBQ7bhuX5jxt7w3S3brQovrKaDqV2Riw3YWMwta
 cXPILDXEqGXBAodnSeiHVw==
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Consistently use ext2fs_get_mem() and ext2fs_free_mem() instead of
calling malloc() and free() directly in e2fsck.  In several places
it is possible to use ext2fs_get_memzero() instead of explicitly
calling memset() on the memory afterward.

This is just a code cleanup, and does not fix any specific bugs.

Signed-off-by: Andreas Dilger <adilger@whamcloud.com>
Lustre-bug-id: https://jira.whamcloud.com/browse/LU-13197
---
 e2fsck/ea_refcount.c |  6 ++----
 e2fsck/emptydir.c    | 14 +++++++-------
 e2fsck/extend.c      |  9 +++++----
 e2fsck/extents.c     | 16 ++++++++--------
 e2fsck/pass1b.c      | 12 ++++++------
 e2fsck/region.c      | 18 ++++++++++--------
 6 files changed, 38 insertions(+), 37 deletions(-)

diff --git a/e2fsck/ea_refcount.c b/e2fsck/ea_refcount.c
index ecb1986..aa5d7d7 100644
--- a/e2fsck/ea_refcount.c
+++ b/e2fsck/ea_refcount.c
@@ -53,10 +53,9 @@ errcode_t ea_refcount_create(size_t size, ext2_refcount_t *ret)
 	errcode_t	retval;
 	size_t		bytes;
 
-	retval = ext2fs_get_mem(sizeof(struct ea_refcount), &refcount);
+	retval = ext2fs_get_memzero(sizeof(struct ea_refcount), &refcount);
 	if (retval)
 		return retval;
-	memset(refcount, 0, sizeof(struct ea_refcount));
 
 	if (!size)
 		size = 500;
@@ -66,10 +65,9 @@ errcode_t ea_refcount_create(size_t size, ext2_refcount_t *ret)
 	printf("Refcount allocated %zu entries, %zu bytes.\n",
 	       refcount->size, bytes);
 #endif
-	retval = ext2fs_get_mem(bytes, &refcount->list);
+	retval = ext2fs_get_memzero(bytes, &refcount->list);
 	if (retval)
 		goto errout;
-	memset(refcount->list, 0, bytes);
 
 	refcount->count = 0;
 	refcount->cursor = 0;
diff --git a/e2fsck/emptydir.c b/e2fsck/emptydir.c
index a3bfd46..7aea7b6 100644
--- a/e2fsck/emptydir.c
+++ b/e2fsck/emptydir.c
@@ -44,12 +44,11 @@ empty_dir_info init_empty_dir(e2fsck_t ctx)
 	empty_dir_info	edi;
 	errcode_t	retval;
 
-	edi = malloc(sizeof(struct empty_dir_info_struct));
-	if (!edi)
+	edi = e2fsck_allocate_memzero(ctx, sizeof(struct empty_dir_info_struct),
+				      "empty dir info");
+	if (retval)
 		return NULL;
 
-	memset(edi, 0, sizeof(struct empty_dir_info_struct));
-
 	retval = ext2fs_init_dblist(ctx->fs, &edi->empty_dblist);
 	if (retval)
 		goto errout;
@@ -83,7 +82,7 @@ void free_empty_dirblock(empty_dir_info edi)
 		ext2fs_free_inode_bitmap(edi->dir_map);
 
 	memset(edi, 0, sizeof(struct empty_dir_info_struct));
-	free(edi);
+	ext2fs_free_mem(&edi);
 }
 
 void add_empty_dirblock(empty_dir_info edi,
@@ -182,13 +181,14 @@ void process_empty_dirblock(e2fsck_t ctx, empty_dir_info edi)
 	if (!edi)
 		return;
 
-	edi->block_buf = malloc(ctx->fs->blocksize * 3);
+	retval = ext2f_get_mem(ctx, ctx->fs->blocksize * 3,
+			       &edi->block_buf);
 
 	if (edi->block_buf) {
 		(void) ext2fs_dblist_iterate2(edi->empty_dblist,
 					      fix_directory, &edi);
 	}
-	free(edi->block_buf);
+	ext2fs_free_mem(&edi->block_buf);
 	free_empty_dirblock(edi);
 }
 
diff --git a/e2fsck/extend.c b/e2fsck/extend.c
index bdb62c3..9d17e44 100644
--- a/e2fsck/extend.c
+++ b/e2fsck/extend.c
@@ -31,6 +31,7 @@ int main(int argc, char **argv)
 	int	nblocks, blocksize;
 	int	fd;
 	char	*block;
+	errcode_t retval;
 	int	ret;
 
 	if (argc != 4)
@@ -45,13 +46,12 @@ int main(int argc, char **argv)
 		exit(1);
 	}
 
-	block = malloc(blocksize);
-	if (block == 0) {
+	retval = ext2fs_get_memzero(blocksize, &block);
+	if (retval) {
 		fprintf(stderr, _("Couldn't allocate block buffer (size=%d)\n"),
 			blocksize);
 		exit(1);
 	}
-	memset(block, 0, blocksize);
 
 	fd = open(filename, O_RDWR);
 	if (fd < 0) {
@@ -78,5 +78,6 @@ int main(int argc, char **argv)
 		perror("read");
 		exit(1);
 	}
-	exit(0);
+	ext2fs_free_mem(&block);
+	return(0);
 }
diff --git a/e2fsck/extents.c b/e2fsck/extents.c
index 3073725..2c91c8c 100644
--- a/e2fsck/extents.c
+++ b/e2fsck/extents.c
@@ -327,7 +327,7 @@ err:
 /* Rebuild the extents immediately */
 static errcode_t e2fsck_rebuild_extents(e2fsck_t ctx, ext2_ino_t ino)
 {
-	struct extent_list	list;
+	struct extent_list list = { 0 };
 	errcode_t err;
 
 	if (!ext2fs_has_feature_extents(ctx->fs->super) ||
@@ -336,9 +336,8 @@ static errcode_t e2fsck_rebuild_extents(e2fsck_t ctx, ext2_ino_t ino)
 		return 0;
 
 	e2fsck_read_bitmaps(ctx);
-	memset(&list, 0, sizeof(list));
-	err = ext2fs_get_mem(sizeof(struct ext2fs_extent) * NUM_EXTENTS,
-				&list.extents);
+	err = ext2fs_get_array(NUM_EXTENTS, sizeof(struct ext2fs_extent),
+			       &list.extents);
 	if (err)
 		return err;
 	list.size = NUM_EXTENTS;
@@ -354,7 +353,7 @@ static void rebuild_extents(e2fsck_t ctx, const char *pass_name, int pr_header)
 #ifdef RESOURCE_TRACK
 	struct resource_track	rtrack;
 #endif
-	struct extent_list	list;
+	struct extent_list	list = { 0 };
 	int			first = 1;
 	ext2_ino_t		ino = 0;
 	errcode_t		retval;
@@ -374,10 +373,11 @@ static void rebuild_extents(e2fsck_t ctx, const char *pass_name, int pr_header)
 	clear_problem_context(&pctx);
 	e2fsck_read_bitmaps(ctx);
 
-	memset(&list, 0, sizeof(list));
-	retval = ext2fs_get_mem(sizeof(struct ext2fs_extent) * NUM_EXTENTS,
-				&list.extents);
 	list.size = NUM_EXTENTS;
+	retval = ext2fs_get_array(sizeof(struct ext2fs_extent),
+				  list.size, &list.extents);
+	if (retval)
+		return;
 	while (1) {
 		retval = ext2fs_find_first_set_inode_bitmap2(
 				ctx->inodes_to_rebuild, ino + 1,
diff --git a/e2fsck/pass1b.c b/e2fsck/pass1b.c
index 5693b9c..5a6007d 100644
--- a/e2fsck/pass1b.c
+++ b/e2fsck/pass1b.c
@@ -180,10 +180,10 @@ static void inode_dnode_free(dnode_t *node,
 	di = (struct dup_inode *) dnode_get(node);
 	for (p = di->cluster_list; p; p = next) {
 		next = p->next;
-		free(p);
+		ext2fs_free_mem(&p);
 	}
-	free(di);
-	free(node);
+	ext2fs_free_mem(&di);
+	ext2fs_free_mem(&node);
 }
 
 /*
@@ -198,10 +198,10 @@ static void cluster_dnode_free(dnode_t *node,
 	dc = (struct dup_cluster *) dnode_get(node);
 	for (p = dc->inode_list; p; p = next) {
 		next = p->next;
-		free(p);
+		ext2fs_free_mem(&p);
 	}
-	free(dc);
-	free(node);
+	ext2fs_free_mem(&dc);
+	ext2fs_free_mem(&node);
 }
 
 
diff --git a/e2fsck/region.c b/e2fsck/region.c
index d5b37df..788e0d0 100644
--- a/e2fsck/region.c
+++ b/e2fsck/region.c
@@ -36,11 +36,12 @@ struct region_struct {
 region_t region_create(region_addr_t min, region_addr_t max)
 {
 	region_t	region;
+	errcode_t	retval;
 
-	region = malloc(sizeof(struct region_struct));
-	if (!region)
+	retval = ext2fs_get_memzero(sizeof(struct region_struct), &region);
+	if (retval)
 		return NULL;
-	memset(region, 0, sizeof(struct region_struct));
+
 	region->min = min;
 	region->max = max;
 	region->last = NULL;
@@ -53,16 +54,17 @@ void region_free(region_t region)
 
 	for (r = region->allocated; r; r = next) {
 		next = r->next;
-		free(r);
+		ext2fs_free_mem(&r);
 	}
 	memset(region, 0, sizeof(struct region_struct));
-	free(region);
+	ext2fs_free_mem(&region);
 }
 
 int region_allocate(region_t region, region_addr_t start, int n)
 {
 	struct region_el	*r, *new_region, *prev, *next;
 	region_addr_t end;
+	errcode_t retval;
 
 	end = start+n;
 	if ((start < region->min) || (end > region->max))
@@ -105,7 +107,7 @@ int region_allocate(region_t region, region_addr_t start, int n)
 				if (end == next->start) {
 					r->end = next->end;
 					r->next = next->next;
-					free(next);
+					ext2fs_free_mem(&next);
 					if (!r->next)
 						region->last = r;
 					return 0;
@@ -121,8 +123,8 @@ int region_allocate(region_t region, region_addr_t start, int n)
 	 * Insert a new region element structure into the linked list
 	 */
 append_to_list:
-	new_region = malloc(sizeof(struct region_el));
-	if (!new_region)
+	retval = ext2fs_get_mem(sizeof(struct region_el), &new_region);
+	if (retval)
 		return -1;
 	new_region->start = start;
 	new_region->end = start + n;
-- 
1.8.0

