Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC863A984C
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Jun 2021 12:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbhFPK7y (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Jun 2021 06:59:54 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:35810 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbhFPK7w (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Jun 2021 06:59:52 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D69EC1FD70;
        Wed, 16 Jun 2021 10:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623841065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9//VL3jBOGhKr9yJAsWh0HMkNbxa5TY9gnH+hhZMqX4=;
        b=bsAZVVBHxMsfIAqBnnB9OJJUpwlwy0I3Z0HoybD0ppSEb57/561vFKQD5kTT479CHoflwv
        tzVq7nANn6ULJvaQjYUZcsGmTsgeR3Bram8d6gkrTh2eYAt3BlLJxUNfKOjrSNEZe0kXw8
        BrPusAmSTSwXhwJGbecS4GCJbID9O4w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623841065;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9//VL3jBOGhKr9yJAsWh0HMkNbxa5TY9gnH+hhZMqX4=;
        b=zMetrdtuxtWZeyxz172GcAhRjstQkrsug0Dq9+AvFcSm3SSYBQ1ZdOb6L5UVv9P7TAI6/6
        NcniPBpF5YCQFFCw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id B66FBA3BA1;
        Wed, 16 Jun 2021 10:57:45 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 72C461F2CC0; Wed, 16 Jun 2021 12:57:45 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 7/9] tune2fs: Add support for orphan_file feature
Date:   Wed, 16 Jun 2021 12:57:33 +0200
Message-Id: <20210616105735.5424-8-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210616105735.5424-1-jack@suse.cz>
References: <20210616105735.5424-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Signed-off-by: Jan Kara <jack@suse.cz>
---
 misc/tune2fs.8.in |  5 +++
 misc/tune2fs.c    | 89 +++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 92 insertions(+), 2 deletions(-)

diff --git a/misc/tune2fs.8.in b/misc/tune2fs.8.in
index b963f30edef3..849f94b68d6e 100644
--- a/misc/tune2fs.8.in
+++ b/misc/tune2fs.8.in
@@ -257,6 +257,11 @@ program.
 This superblock setting is only honored in 2.6.35+ kernels;
 and not at all by the ext2 and ext3 file system drivers.
 .TP
+.BI orphan_file_size= size
+Set size of the file for tracking unlinked but still open inodes and inodes
+with truncate in progress. Larger file allows for better scalability, reserving
+a few blocks per cpu is ideal.
+.TP
 .B force_fsck
 Set a flag in the filesystem superblock indicating that errors have been found.
 This will force fsck to run at the next mount.
diff --git a/misc/tune2fs.c b/misc/tune2fs.c
index f739f16cd62b..4d4cf5a13384 100644
--- a/misc/tune2fs.c
+++ b/misc/tune2fs.c
@@ -106,6 +106,7 @@ int enabling_casefold;
 int journal_size, journal_fc_size, journal_flags;
 char *journal_device;
 static blk64_t journal_location = ~0LL;
+static e2_blkcnt_t orphan_file_blocks;
 
 static struct list_head blk_move_list;
 
@@ -152,7 +153,8 @@ static __u32 ok_features[3] = {
 	EXT3_FEATURE_COMPAT_HAS_JOURNAL |
 		EXT2_FEATURE_COMPAT_DIR_INDEX |
 		EXT4_FEATURE_COMPAT_FAST_COMMIT |
-		EXT4_FEATURE_COMPAT_STABLE_INODES,
+		EXT4_FEATURE_COMPAT_STABLE_INODES |
+		EXT4_FEATURE_COMPAT_ORPHAN_FILE,
 	/* Incompat */
 	EXT2_FEATURE_INCOMPAT_FILETYPE |
 		EXT3_FEATURE_INCOMPAT_EXTENTS |
@@ -183,7 +185,8 @@ static __u32 clear_ok_features[3] = {
 	EXT3_FEATURE_COMPAT_HAS_JOURNAL |
 		EXT2_FEATURE_COMPAT_RESIZE_INODE |
 		EXT2_FEATURE_COMPAT_DIR_INDEX |
-		EXT4_FEATURE_COMPAT_FAST_COMMIT,
+		EXT4_FEATURE_COMPAT_FAST_COMMIT |
+		EXT4_FEATURE_COMPAT_ORPHAN_FILE,
 	/* Incompat */
 	EXT2_FEATURE_INCOMPAT_FILETYPE |
 		EXT4_FEATURE_INCOMPAT_FLEX_BG |
@@ -1143,6 +1146,55 @@ static int update_feature_set(ext2_filsys fs, char *features)
 		}
 	}
 
+	if (FEATURE_OFF(E2P_FEATURE_COMPAT, EXT4_FEATURE_COMPAT_ORPHAN_FILE)) {
+		ext2_ino_t ino;
+
+		if (mount_flags & EXT2_MF_MOUNTED) {
+			fputs(_("The orphan_file feature may only be cleared "
+				"when the filesystem is unmounted.\n"), stderr);
+			return 1;
+		}
+		if (ext2fs_has_feature_orphan_present(sb) && f_flag < 2) {
+			fputs(_("The orphan_present flag is set. Please run "
+				"e2fsck before clearing orphan_file flag.\n"),
+			      stderr);
+			return 1;
+		}
+		err = ext2fs_read_bitmaps(fs);
+		if (err) {
+			com_err(program_name, err, "%s",
+				_("while loading bitmaps"));
+			return 1;
+		}
+		err = ext2fs_truncate_orphan_file(fs);
+		if (err) {
+			com_err(program_name, err,
+				_("\n\twhile trying to delete orphan file\n"));
+			return 1;
+		}
+		ino = sb->s_orphan_file_inum;
+		sb->s_orphan_file_inum = 0;
+		ext2fs_inode_alloc_stats2(fs, ino, -1, 0);
+		ext2fs_clear_feature_orphan_file(sb);
+		ext2fs_clear_feature_orphan_present(sb);
+		ext2fs_mark_super_dirty(fs);
+	}
+
+	if (FEATURE_ON(E2P_FEATURE_COMPAT, EXT4_FEATURE_COMPAT_ORPHAN_FILE)) {
+		if (!ext2fs_has_feature_journal(sb)) {
+			fputs(_("orphan_file flag can be set only for "
+				"filesystems with journal.\n"), stderr);
+			return 1;
+		}
+		/*
+		 * If adding an orphan file, let the create orphan file
+		 * code below handle setting the flag and creating it.
+		 * We supply a default size if necessary.
+		 */
+		orphan_file_blocks = ext2fs_default_orphan_file_blocks(fs);
+		ext2fs_set_feature_orphan_file(sb);
+	}
+
 	if (FEATURE_ON(E2P_FEATURE_RO_INCOMPAT,
 		EXT2_FEATURE_RO_COMPAT_SPARSE_SUPER)) {
 		if (ext2fs_has_feature_meta_bg(sb)) {
@@ -2262,6 +2314,21 @@ static int parse_extended_opts(ext2_filsys fs, const char *opts)
 				continue;
 			}
 			encoding_flags = arg;
+		} else if (!strcmp(token, "orphan_file_size")) {
+			if (!arg) {
+				r_usage++;
+				continue;
+			}
+			orphan_file_blocks = parse_num_blocks2(arg,
+						 fs->super->s_log_block_size);
+
+			if (orphan_file_blocks < 1) {
+				fprintf(stderr,
+					_("Invalid size of orphan file %s\n"),
+					arg);
+				r_usage++;
+				continue;
+			}
 		} else
 			r_usage++;
 	}
@@ -3247,6 +3314,24 @@ _("Warning: The journal is dirty. You may wish to replay the journal like:\n\n"
 		if (rc)
 			goto closefs;
 	}
+	if (orphan_file_blocks) {
+		errcode_t err;
+
+		err = ext2fs_read_bitmaps(fs);
+		if (err) {
+			com_err(program_name, err, "%s",
+				_("while loading bitmaps"));
+			rc = 1;
+			goto closefs;
+		}
+		err = ext2fs_create_orphan_file(fs, orphan_file_blocks);
+		if (err) {
+			com_err(program_name, err, "%s",
+				_("while creating orphan file"));
+			rc = 1;
+			goto closefs;
+		}
+	}
 
 	if (Q_flag) {
 		if (mount_flags & EXT2_MF_MOUNTED) {
-- 
2.26.2

