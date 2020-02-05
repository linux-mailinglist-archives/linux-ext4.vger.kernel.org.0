Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7547B1533D4
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Feb 2020 16:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgBEPYt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Feb 2020 10:24:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:57586 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726678AbgBEPYt (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 5 Feb 2020 10:24:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0A34DAC52;
        Wed,  5 Feb 2020 15:24:46 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 765881E0E31; Wed,  5 Feb 2020 16:24:46 +0100 (CET)
Date:   Wed, 5 Feb 2020 16:24:46 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 0/3] e2fsprogs: Better handling of indexed directories
Message-ID: <20200205152446.GA17316@quack2.suse.cz>
References: <20200205100138.30053-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
In-Reply-To: <20200205100138.30053-1-jack@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

thinking a bit more about the problem I've realized tune2fs also needs
improvement so that it does not corrupt the filesystem when clearing
dir_index feature. Patch attached.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--AqsLC8rIMeq19msA
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-tune2fs-Update-dir-checksums-when-clearing-dir_index.patch"

From ebb4d6ab362f051dee7793947932958f589301b2 Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Wed, 5 Feb 2020 14:13:22 +0100
Subject: [PATCH 4/3] tune2fs: Update dir checksums when clearing dir_index feature

When clearing dir_index feature while metadata_csum is enabled, we have
to rewrite checksums of all indexed directories to update checksums of
internal tree nodes.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 misc/tune2fs.c | 143 ++++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 95 insertions(+), 48 deletions(-)

diff --git a/misc/tune2fs.c b/misc/tune2fs.c
index a0448f63d1d5..254246fd858b 100644
--- a/misc/tune2fs.c
+++ b/misc/tune2fs.c
@@ -508,7 +508,8 @@ struct rewrite_dir_context {
 	char *buf;
 	errcode_t errcode;
 	ext2_ino_t dir;
-	int is_htree;
+	int is_htree:1;
+	int clear_htree:1;
 };
 
 static int rewrite_dir_block(ext2_filsys fs,
@@ -527,8 +528,13 @@ static int rewrite_dir_block(ext2_filsys fs,
 	if (ctx->errcode)
 		return BLOCK_ABORT;
 
-	/* if htree node... */
-	if (ctx->is_htree)
+	/*
+	 * if htree node... Note that if we are clearing htree structures from
+	 * the directory, we treat the htree internal block as an ordinary leaf.
+	 * The code below will do the right thing and make space for checksum
+	 * there.
+	 */
+	if (ctx->is_htree && !ctx->clear_htree)
 		ext2fs_get_dx_countlimit(fs, (struct ext2_dir_entry *)ctx->buf,
 					 &dcl, &dcl_offset);
 	if (dcl) {
@@ -657,7 +663,8 @@ static errcode_t rewrite_directory(ext2_filsys fs, ext2_ino_t dir,
 	if (retval)
 		return retval;
 
-	ctx.is_htree = (inode->i_flags & EXT2_INDEX_FL);
+	ctx.is_htree = !!(inode->i_flags & EXT2_INDEX_FL);
+	ctx.clear_htree = !ext2fs_has_feature_dir_index(fs->super);
 	ctx.dir = dir;
 	ctx.errcode = 0;
 	retval = ext2fs_block_iterate3(fs, dir, BLOCK_FLAG_READ_ONLY |
@@ -668,6 +675,13 @@ static errcode_t rewrite_directory(ext2_filsys fs, ext2_ino_t dir,
 	if (retval)
 		return retval;
 
+	if (ctx.is_htree && ctx.clear_htree) {
+		inode->i_flags &= ~EXT2_INDEX_FL;
+		retval = ext2fs_write_inode(fs, dir, inode);
+		if (retval)
+			return retval;
+	}
+
 	return ctx.errcode;
 }
 
@@ -822,28 +836,67 @@ static void rewrite_one_inode(struct rewrite_context *ctx, ext2_ino_t ino,
 		fatal_err(retval, "while rewriting extended attribute");
 }
 
-/*
- * Forcibly set checksums in all inodes.
- */
-static void rewrite_inodes(ext2_filsys fs)
+#define REWRITE_EA_FL		0x01	/* Rewrite EA inodes */
+#define REWRITE_DIR_FL		0x02	/* Rewrite directories */
+#define REWRITE_NONDIR_FL	0x04	/* Rewrite other inodes */
+#define REWRITE_ALL (REWRITE_EA_FL | REWRITE_DIR_FL | REWRITE_NONDIR_FL)
+
+static void rewrite_inodes_pass(struct rewrite_context *ctx, unsigned int flags)
 {
 	ext2_inode_scan	scan;
 	errcode_t	retval;
 	ext2_ino_t	ino;
 	struct ext2_inode *inode;
-	int pass;
+	int rewrite;
+
+	retval = ext2fs_get_mem(ctx->inode_size, &inode);
+	if (retval)
+		fatal_err(retval, "while allocating memory");
+
+	retval = ext2fs_open_inode_scan(ctx->fs, 0, &scan);
+	if (retval)
+		fatal_err(retval, "while opening inode scan");
+
+	do {
+		retval = ext2fs_get_next_inode_full(scan, &ino, inode,
+						    ctx->inode_size);
+		if (retval)
+			fatal_err(retval, "while getting next inode");
+		if (!ino)
+			break;
+
+		rewrite = 0;
+		if (inode->i_flags & EXT4_EA_INODE_FL) {
+			if (flags & REWRITE_EA_FL)
+				rewrite = 1;
+		} else if (LINUX_S_ISDIR(inode->i_mode)) {
+			if (flags & REWRITE_DIR_FL)
+				rewrite = 1;
+		} else {
+			if (flags & REWRITE_NONDIR_FL)
+				rewrite = 1;
+		}
+		if (rewrite)
+			rewrite_one_inode(ctx, ino, inode);
+	} while (ino);
+	ext2fs_close_inode_scan(scan);
+	ext2fs_free_mem(&inode);
+}
+
+/*
+ * Forcibly rewrite checksums in inodes specified by 'flags'
+ */
+static void rewrite_inodes(ext2_filsys fs, unsigned int flags)
+{
 	struct rewrite_context ctx = {
 		.fs = fs,
 		.inode_size = EXT2_INODE_SIZE(fs->super),
 	};
+	errcode_t retval;
 
 	if (fs->super->s_creator_os == EXT2_OS_HURD)
 		return;
 
-	retval = ext2fs_get_mem(ctx.inode_size, &inode);
-	if (retval)
-		fatal_err(retval, "while allocating memory");
-
 	retval = ext2fs_get_memzero(ctx.inode_size, &ctx.zero_inode);
 	if (retval)
 		fatal_err(retval, "while allocating memory");
@@ -862,39 +915,16 @@ static void rewrite_inodes(ext2_filsys fs)
 	 *
 	 * pass 2: go over other inodes to update their checksums.
 	 */
-	if (ext2fs_has_feature_ea_inode(fs->super))
-		pass = 1;
-	else
-		pass = 2;
-	for (;pass <= 2; pass++) {
-		retval = ext2fs_open_inode_scan(fs, 0, &scan);
-		if (retval)
-			fatal_err(retval, "while opening inode scan");
-
-		do {
-			retval = ext2fs_get_next_inode_full(scan, &ino, inode,
-							    ctx.inode_size);
-			if (retval)
-				fatal_err(retval, "while getting next inode");
-			if (!ino)
-				break;
-
-			if (((pass == 1) &&
-			     (inode->i_flags & EXT4_EA_INODE_FL)) ||
-			    ((pass == 2) &&
-			     !(inode->i_flags & EXT4_EA_INODE_FL)))
-				rewrite_one_inode(&ctx, ino, inode);
-		} while (ino);
-
-		ext2fs_close_inode_scan(scan);
-	}
+	if (ext2fs_has_feature_ea_inode(fs->super) && (flags & REWRITE_EA_FL))
+		rewrite_inodes_pass(&ctx, REWRITE_EA_FL);
+	flags &= ~REWRITE_EA_FL;
+	rewrite_inodes_pass(&ctx, flags);
 
 	ext2fs_free_mem(&ctx.zero_inode);
 	ext2fs_free_mem(&ctx.ea_buf);
-	ext2fs_free_mem(&inode);
 }
 
-static void rewrite_metadata_checksums(ext2_filsys fs)
+static void rewrite_metadata_checksums(ext2_filsys fs, unsigned int flags)
 {
 	errcode_t retval;
 	dgrp_t i;
@@ -906,7 +936,7 @@ static void rewrite_metadata_checksums(ext2_filsys fs)
 	retval = ext2fs_read_bitmaps(fs);
 	if (retval)
 		fatal_err(retval, "while reading bitmaps");
-	rewrite_inodes(fs);
+	rewrite_inodes(fs, flags);
 	ext2fs_mark_ib_dirty(fs);
 	ext2fs_mark_bb_dirty(fs);
 	ext2fs_mmp_update2(fs, 1);
@@ -1205,6 +1235,23 @@ mmp_error:
 			uuid_generate((unsigned char *) sb->s_hash_seed);
 	}
 
+	if (FEATURE_OFF(E2P_FEATURE_COMPAT, EXT2_FEATURE_COMPAT_DIR_INDEX) &&
+	    ext2fs_has_feature_metadata_csum(sb)) {
+		check_fsck_needed(fs,
+			_("Disabling directory index on filesystem with "
+			  "checksums could take some time."));
+		if (mount_flags & EXT2_MF_MOUNTED) {
+			fputs(_("Cannot disable dir_index on a mounted "
+				"filesystem!\n"), stderr);
+			exit(1);
+		}
+		/*
+		 * Clearing dir_index on checksummed filesystem requires
+		 * rewriting all directories to update checksums.
+		 */
+		rewrite_checksums |= REWRITE_DIR_FL;
+	}
+
 	if (FEATURE_OFF(E2P_FEATURE_INCOMPAT, EXT4_FEATURE_INCOMPAT_FLEX_BG)) {
 		if (ext2fs_check_desc(fs)) {
 			fputs(_("Clearing the flex_bg flag would "
@@ -1248,7 +1295,7 @@ mmp_error:
 				 "The larger fields afforded by this feature "
 				 "enable full-strength checksumming.  "
 				 "Run resize2fs -b to rectify.\n"));
-		rewrite_checksums = 1;
+		rewrite_checksums = REWRITE_ALL;
 		/* metadata_csum supersedes uninit_bg */
 		ext2fs_clear_feature_gdt_csum(fs->super);
 
@@ -1276,7 +1323,7 @@ mmp_error:
 				"filesystem!\n"), stderr);
 			exit(1);
 		}
-		rewrite_checksums = 1;
+		rewrite_checksums = REWRITE_ALL;
 
 		/* Enable uninit_bg unless the user expressly turned it off */
 		memcpy(test_features, old_features, sizeof(test_features));
@@ -1458,7 +1505,7 @@ mmp_error:
 			}
 			check_fsck_needed(fs, _("Recalculating checksums "
 						"could take some time."));
-			rewrite_checksums = 1;
+			rewrite_checksums = REWRITE_ALL;
 		}
 	}
 
@@ -3196,7 +3243,7 @@ _("Warning: The journal is dirty. You may wish to replay the journal like:\n\n"
 			check_fsck_needed(fs,
 				_("Setting the UUID on this "
 				  "filesystem could take some time."));
-			rewrite_checksums = 1;
+			rewrite_checksums = REWRITE_ALL;
 		}
 
 		if (ext2fs_has_group_desc_csum(fs)) {
@@ -3307,7 +3354,7 @@ _("Warning: The journal is dirty. You may wish to replay the journal like:\n\n"
 		if (retval == 0) {
 			printf(_("Setting inode size %lu\n"),
 							new_inode_size);
-			rewrite_checksums = 1;
+			rewrite_checksums = REWRITE_ALL;
 		} else {
 			printf("%s", _("Failed to change inode size\n"));
 			rc = 1;
@@ -3316,7 +3363,7 @@ _("Warning: The journal is dirty. You may wish to replay the journal like:\n\n"
 	}
 
 	if (rewrite_checksums)
-		rewrite_metadata_checksums(fs);
+		rewrite_metadata_checksums(fs, rewrite_checksums);
 
 	if (l_flag)
 		list_super(sb);
-- 
2.16.4


--AqsLC8rIMeq19msA--
