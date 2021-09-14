Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C380940B79E
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Sep 2021 21:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbhINTMt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Sep 2021 15:12:49 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:51812 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233045AbhINTMf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 14 Sep 2021 15:12:35 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 18EJBBCF024788
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Sep 2021 15:11:11 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 567DE15C3425; Tue, 14 Sep 2021 15:11:11 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 2/3] resize2fs: adjust new size of the file system to allow a successful resize
Date:   Tue, 14 Sep 2021 15:11:03 -0400
Message-Id: <20210914191104.2283033-2-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210914191104.2283033-1-tytso@mit.edu>
References: <20210914191104.2283033-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The previous commit in this series (commit 50088b1996cc: "resize2fs:
attempt to keep the # of inodes valid by removing the last bg") allows
a successful off-line resize of a file system with the default 16k
inode ratio to be grown to support a 64TB storage device by dropping
the last block group so the number of inodes is just below the maximum
2**32-1 number of inodes.

However, this is not a complete solution, for two reasons.  First,
this adjustment happens after resize2fs has started potentially making
changes to the file system in the off-line (unmounted) case, which
means resize2fs will do a lot of unnecessary work.  Secondly, in the
on-line resize case, passing the original requested size to the kernel
causes the kernel fail the online resize request.

So teach resize2fs to adjust the new size of the file system much
earlier, which avoids both problems.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 resize/main.c              | 16 +++++---
 resize/resize2fs.c         | 79 ++++++++++++++++++++++++++++++++++++++
 resize/resize2fs.h         |  1 +
 tests/r_move_itable/expect |  6 +--
 4 files changed, 93 insertions(+), 9 deletions(-)

diff --git a/resize/main.c b/resize/main.c
index 8621d101..bceaa167 100644
--- a/resize/main.c
+++ b/resize/main.c
@@ -611,12 +611,16 @@ int main (int argc, char ** argv)
 				"feature.\n"));
 			goto errout;
 		}
-	} else if (new_size == ext2fs_blocks_count(fs->super)) {
-		fprintf(stderr, _("The filesystem is already %llu (%dk) "
-			"blocks long.  Nothing to do!\n\n"),
-			(unsigned long long) new_size,
-			blocksize / 1024);
-		goto success_exit;
+	} else {
+		adjust_new_size(fs, &new_size);
+		if (new_size == ext2fs_blocks_count(fs->super)) {
+			fprintf(stderr, _("The filesystem is already "
+					  "%llu (%dk) blocks long.  "
+					  "Nothing to do!\n\n"),
+				(unsigned long long) new_size,
+				blocksize / 1024);
+			goto success_exit;
+		}
 	}
 	if ((flags & RESIZE_ENABLE_64BIT) &&
 	    ext2fs_has_feature_64bit(fs->super)) {
diff --git a/resize/resize2fs.c b/resize/resize2fs.c
index 770d2d06..5ed0c9ee 100644
--- a/resize/resize2fs.c
+++ b/resize/resize2fs.c
@@ -1028,6 +1028,85 @@ errout:
 	return (retval);
 }
 
+/*
+ * Replicate the first part of adjust_fs_info to determine what the
+ * new size of the file system should be.  This allows resize2fs to
+ * exit early if we aren't going to make any changes to the file
+ * system.
+ */
+void adjust_new_size(ext2_filsys fs, blk64_t *sizep)
+{
+	blk64_t		size, rem, overhead = 0;
+	unsigned long	desc_blocks;
+	dgrp_t		group_desc_count;
+	int		has_bg;
+	unsigned long long new_inodes;	/* u64 to check for overflow */
+
+	size = *sizep;
+retry:
+	group_desc_count = ext2fs_div64_ceil(size -
+					     fs->super->s_first_data_block,
+					     EXT2_BLOCKS_PER_GROUP(fs->super));
+	if (group_desc_count == 0)
+		return;
+	desc_blocks = ext2fs_div_ceil(group_desc_count,
+				      EXT2_DESC_PER_BLOCK(fs->super));
+
+	/*
+	 * Overhead is the number of bookkeeping blocks per group.  It
+	 * includes the superblock backup, the group descriptor
+	 * backups, the inode bitmap, the block bitmap, and the inode
+	 * table.
+	 */
+	overhead = (int) (2 + fs->inode_blocks_per_group);
+
+	has_bg = 0;
+	if (ext2fs_has_feature_sparse_super2(fs->super)) {
+		/*
+		 * We have to do this manually since
+		 * super->s_backup_bgs hasn't been set up yet.
+		 */
+		if (group_desc_count == 2)
+			has_bg = fs->super->s_backup_bgs[0] != 0;
+		else
+			has_bg = fs->super->s_backup_bgs[1] != 0;
+	} else
+		has_bg = ext2fs_bg_has_super(fs, group_desc_count - 1);
+	if (has_bg)
+		overhead += 1 + desc_blocks +
+			fs->super->s_reserved_gdt_blocks;
+
+	/*
+	 * See if the last group is big enough to support the
+	 * necessary data structures.  If not, we need to get rid of
+	 * it.
+	 */
+	rem = (size - fs->super->s_first_data_block) %
+		fs->super->s_blocks_per_group;
+	if ((group_desc_count == 1) && rem && (rem < overhead))
+		return;
+	if ((group_desc_count > 1) && rem && (rem < overhead+50)) {
+		size -= rem;
+		goto retry;
+	}
+
+	/*
+	 * If we need to reduce the size by no more than a block
+	 * group to avoid overrunning the max inode limit, do it.
+	 */
+	new_inodes =(unsigned long long) fs->super->s_inodes_per_group * group_desc_count;
+	if (new_inodes > ~0U) {
+		new_inodes = (unsigned long long) fs->super->s_inodes_per_group * (group_desc_count - 1);
+		if (new_inodes > ~0U)
+			return;
+		size = ((unsigned long long) fs->super->s_blocks_per_group *
+			(group_desc_count - 1)) + fs->super->s_first_data_block;
+
+		goto retry;
+	}
+	*sizep = size;
+}
+
 /*
  * This routine adjusts the superblock and other data structures, both
  * in disk as well as in memory...
diff --git a/resize/resize2fs.h b/resize/resize2fs.h
index f9f58f20..96a878a7 100644
--- a/resize/resize2fs.h
+++ b/resize/resize2fs.h
@@ -150,6 +150,7 @@ extern errcode_t adjust_fs_info(ext2_filsys fs, ext2_filsys old_fs,
 				ext2fs_block_bitmap reserve_blocks,
 				blk64_t new_size);
 extern blk64_t calculate_minimum_resize_size(ext2_filsys fs, int flags);
+extern void adjust_new_size(ext2_filsys fs, blk64_t *sizep);
 
 
 /* extent.c */
diff --git a/tests/r_move_itable/expect b/tests/r_move_itable/expect
index b0a4873c..74a00fe0 100644
--- a/tests/r_move_itable/expect
+++ b/tests/r_move_itable/expect
@@ -61,7 +61,7 @@ Group 3: (Blocks 769-1023)
   Free blocks: 781-1023
   Free inodes: 97-128
 resize2fs -p test.img 10000
-Resizing the filesystem on test.img to 10000 (1k) blocks.
+Resizing the filesystem on test.img to 9985 (1k) blocks.
 Begin pass 1 (max = 35)
 Extending the inode table     ----------------------------------------XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 Begin pass 2 (max = 1)
@@ -354,7 +354,7 @@ Group 38: (Blocks 9729-9984)
   Free inodes: 1217-1248
 --------------------------------
 resize2fs -p test.img 20000
-Resizing the filesystem on test.img to 20000 (1k) blocks.
+Resizing the filesystem on test.img to 19969 (1k) blocks.
 Begin pass 1 (max = 39)
 Extending the inode table     ----------------------------------------XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 Begin pass 2 (max = 1)
@@ -884,7 +884,7 @@ Group 77: (Blocks 19713-19968)
   Free inodes: 2465-2496
 --------------------------------
 resize2fs -p test.img 30000
-Resizing the filesystem on test.img to 30000 (1k) blocks.
+Resizing the filesystem on test.img to 29953 (1k) blocks.
 Begin pass 1 (max = 39)
 Extending the inode table     ----------------------------------------XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 Begin pass 2 (max = 8)
-- 
2.31.0

