Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30CD93F7E3A
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Aug 2021 00:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbhHYWMf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 25 Aug 2021 18:12:35 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38772 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbhHYWMd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 25 Aug 2021 18:12:33 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 94C8222200;
        Wed, 25 Aug 2021 22:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629929506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gM+UDGqEvtQX0Y9r09YBa0v43GimKUr857gDYhqnHuk=;
        b=M0Q4kPfTk29IQ8Q0akPIeuKeQmlqAyMP4YiBO8Pfpibxdsj+sPF5s0epl3QlB38XE/Jrgv
        bbdZthReYE0C49azzyHiYNGsjtThPD3IIH+Im+SkjotwkODySwUcxmiI0HiDf4AkIi7OIL
        SOGFlID8AXzZysQWgvyB7wv/Ov8ajgo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629929506;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gM+UDGqEvtQX0Y9r09YBa0v43GimKUr857gDYhqnHuk=;
        b=TzGTdt/LesE8KQL1T0l0SLfcLK0/qEvoNDI7TgHv9OG3x8Ac1yIftRhaHAivH+niIdfw6z
        o/rM9rSlwFAiwwDw==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 809DDA3B89;
        Wed, 25 Aug 2021 22:11:46 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id EBC101F2BA4; Thu, 26 Aug 2021 00:11:43 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 4/5] tune2fs: Add support for orphan_file feature
Date:   Thu, 26 Aug 2021 00:11:33 +0200
Message-Id: <20210825221143.30705-4-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210825220922.4157-1-jack@suse.cz>
References: <20210825220922.4157-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4971; h=from:subject; bh=nLrZhdW7vTixM3VpIGdcy3kONzYrMIujX6N1ddXRg5U=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBhJsAVYnN/6w1dUGK1+uMNNeFUrSCTBsT92OAoKBcR zcwLJsSJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYSbAFQAKCRCcnaoHP2RA2cErB/ 0U5RALDTd+bmKX+L3V8DdqaVNxPaoVxI/46dTUJXxMTqG9qjL9C3macMtJ6Qn2NUsnSXKgCReydIHL Ktzy2epc+9Whx8Y99Qtu/J5ZRBmch9SwxxGqGSRI67PMyeXaOxse0UrzQScbnOQTIyM6d6FBUCRFqR rf4+fNZzZKULZbgBL4+Wt9SECm6i/TpsnGbCEI2NoFsiTDivGyeZbS5ik9+dojpD9T4a8DTpiYxMT2 WSELL8Q3lEU/NzNC4geeTRyYL+Zex/p9x3aDg05YkAtg5O4eAmAMn4T/EnP5zGyHknnC3s/FpX5ddo 4dM1Cjjel0lQgsFMpPARNAkNzd+1HZ
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Signed-off-by: Jan Kara <jack@suse.cz>
---
 misc/tune2fs.8.in |  5 +++
 misc/tune2fs.c    | 90 +++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 93 insertions(+), 2 deletions(-)

diff --git a/misc/tune2fs.8.in b/misc/tune2fs.8.in
index 979f6c5f258f..1e026e5f5d1f 100644
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
 Set a flag in the file system superblock indicating that errors have been found.
 This will force fsck to run at the next mount.
diff --git a/misc/tune2fs.c b/misc/tune2fs.c
index 4200104ee0b1..c2b18d2fbf61 100644
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
@@ -1145,6 +1148,56 @@ static int update_feature_set(ext2_filsys fs, char *features)
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
+			fputs(_("The orphan_present feature is set. Please "
+				"run e2fsck before clearing orphan_file "
+				"feature.\n"),
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
+			fputs(_("orphan_file feature can be set only for "
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
@@ -2268,6 +2321,21 @@ static int parse_extended_opts(ext2_filsys fs, const char *opts)
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
@@ -3253,6 +3321,24 @@ _("Warning: The journal is dirty. You may wish to replay the journal like:\n\n"
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

