Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27A0A154FF6
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Feb 2020 02:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgBGBR5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 Feb 2020 20:17:57 -0500
Received: from smtp-out-so.shaw.ca ([64.59.136.137]:60362 "EHLO
        smtp-out-so.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbgBGBR4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 Feb 2020 20:17:56 -0500
Received: from cabot.adilger.int ([70.77.216.213])
        by shaw.ca with ESMTP
        id zs9SiRcpt17ZDzs9ViUgmJ; Thu, 06 Feb 2020 18:09:49 -0700
X-Authority-Analysis: v=2.3 cv=ZsqT1OzG c=1 sm=1 tr=0
 a=BQvS1EmAg2ttxjPVUuc1UQ==:117 a=BQvS1EmAg2ttxjPVUuc1UQ==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=ySfo2T4IAAAA:8 a=MibfodXGP-9BpqaglkUA:9
 a=FEiqe_euQQipOCMP:21 a=hakJWXg_8sb5otpz:21 a=ZUkhVnNHqyo2at-WnAgH:22
From:   Andreas Dilger <adilger@whamcloud.com>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org, Andreas Dilger <adilger@whamcloud.com>
Subject: [PATCH 4/9] e2fsck: reduce memory usage for many directories
Date:   Thu,  6 Feb 2020 18:09:41 -0700
Message-Id: <1581037786-62789-4-git-send-email-adilger@whamcloud.com>
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1581037786-62789-1-git-send-email-adilger@whamcloud.com>
References: <1581037786-62789-1-git-send-email-adilger@whamcloud.com>
X-CMAE-Envelope: MS4wfOHde0K32nLEvijb8mfmFT8kM7/76GliIsZ0QklZEDTiCBP3plZrFh+ygqz9JZ9dzd7TT4iPv6zdz9tutrPzHTllYuuCwyqbgvzUBfXKi5NSDi/wtFVh
 cyl3TSNRlCCpPjAkWAaQD5+62iWHbSyQDz8gwOAFnPenbIKXKdh9iXUbnttlRQ5A+JhCw/pjzywvgS/w+lb8rUFRMPu5l8J4yXgmc9w+65qxRxqkNhoNRyM8
 dBH54cfy15ZcTQJgFAnJtA==
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Pack struct dx_dir_info and dx_dirblock_info properly in memory, to
avoid holes, and fields are not larger than necessary.  This reduces
the memory needed for each hashed dir, according to pahole(1) from:

    struct dx_dir_info {
        /* size: 32, cachelines: 1, members: 6 */
        /* sum members: 26, holes: 1, sum holes: 2 */
        /* padding: 4 */
    };
    struct dx_dirblock_info {
        /* size: 56, cachelines: 1, members: 9 */
        /* sum members: 48, holes: 2, sum holes: 8 */
        /* last cacheline: 56 bytes */
    };

to 8 bytes less for each directory and directory block, and leaves
space for future use if needed (e.g. larger numblocks):

    struct dx_dir_info {
        /* size: 24, cachelines: 1, members: 6 */
        /* sum members: 20, holes: 1, sum holes: 4 */
        /* bit holes: 1, sum bit holes: 7 bits */
    };
    struct dx_dirblock_info {
        /* size: 48, cachelines: 1, members: 9 */
    };

Signed-off-by: Andreas Dilger <adilger@whamcloud.com>
Lustre-bug-id: https://jira.whamcloud.com/browse/LU-13197
---
 e2fsck/dx_dirinfo.c |  3 +--
 e2fsck/e2fsck.h     | 14 +++++++-------
 e2fsck/pass2.c      | 12 ++++++------
 3 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/e2fsck/dx_dirinfo.c b/e2fsck/dx_dirinfo.c
index f0f6084..caca3e3 100644
--- a/e2fsck/dx_dirinfo.c
+++ b/e2fsck/dx_dirinfo.c
@@ -73,11 +73,10 @@ void e2fsck_add_dx_dir(e2fsck_t ctx, ext2_ino_t ino, struct ext2_inode *inode,
 	dir->ino = ino;
 	dir->numblocks = num_blocks;
 	dir->hashversion = 0;
-	dir->casefolded_hash = inode->i_flags & EXT4_CASEFOLD_FL;
+	dir->casefolded_hash = !!(inode->i_flags & EXT4_CASEFOLD_FL);
 	dir->dx_block = e2fsck_allocate_memory(ctx, num_blocks
 				       * sizeof (struct dx_dirblock_info),
 				       "dx_block info array");
-
 }
 
 /*
diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index 5e7db42..feb605c 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -104,12 +104,12 @@ struct dir_info {
  * directories which contain a hash tree index.
  */
 struct dx_dir_info {
-	ext2_ino_t		ino; 		/* Inode number */
-	int			numblocks;	/* number of blocks */
-	int			hashversion;
-	short			depth;		/* depth of tree */
-	struct dx_dirblock_info	*dx_block; 	/* Array of size numblocks */
-	int			casefolded_hash;
+	ext2_ino_t		ino;		/* Inode number */
+	short			depth;		/* depth of tree (15 bits) */
+	__u8			hashversion;
+	__u8			casefolded_hash:1;
+	blk_t			numblocks;	/* number of blocks in dir */
+	struct dx_dirblock_info	*dx_block;	/* Array of size numblocks */
 };
 
 #define DX_DIRBLOCK_ROOT	1
@@ -120,8 +120,8 @@ struct dx_dir_info {
 
 struct dx_dirblock_info {
 	int		type;
-	blk64_t		phys;
 	int		flags;
+	blk64_t		phys;
 	blk64_t		parent;
 	blk64_t		previous;
 	ext2_dirhash_t	min_hash;
diff --git a/e2fsck/pass2.c b/e2fsck/pass2.c
index 5c3f7b8..0fa6233 100644
--- a/e2fsck/pass2.c
+++ b/e2fsck/pass2.c
@@ -71,8 +71,8 @@ static int allocate_dir_block(e2fsck_t ctx,
 			      struct ext2_db_entry2 *dir_blocks_info,
 			      char *buf, struct problem_context *pctx);
 static void clear_htree(e2fsck_t ctx, ext2_ino_t ino);
-static int htree_depth(struct dx_dir_info *dx_dir,
-		       struct dx_dirblock_info *dx_db);
+static short htree_depth(struct dx_dir_info *dx_dir,
+			 struct dx_dirblock_info *dx_db);
 static EXT2_QSORT_TYPE special_dir_block_cmp(const void *a, const void *b);
 
 struct check_dir_struct {
@@ -132,7 +132,7 @@ void e2fsck_pass2(e2fsck_t ctx)
 	struct dx_dirblock_info	*dx_db;
 	int			b;
 	ext2_ino_t		i;
-	int			depth;
+	short			depth;
 	problem_t		code;
 	int			bad_dir;
 	int (*check_dir_func)(ext2_filsys fs,
@@ -311,10 +311,10 @@ cleanup:
 }
 
 #define MAX_DEPTH 32000
-static int htree_depth(struct dx_dir_info *dx_dir,
-		       struct dx_dirblock_info *dx_db)
+static short htree_depth(struct dx_dir_info *dx_dir,
+			 struct dx_dirblock_info *dx_db)
 {
-	int	depth = 0;
+	short depth = 0;
 
 	while (dx_db->type != DX_DIRBLOCK_ROOT && depth < MAX_DEPTH) {
 		dx_db = &dx_dir->dx_block[dx_db->parent];
-- 
1.8.0

