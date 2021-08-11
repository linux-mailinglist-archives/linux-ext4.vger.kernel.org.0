Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B08A53E8EA2
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Aug 2021 12:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237162AbhHKKbi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 Aug 2021 06:31:38 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48630 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237133AbhHKKbg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 Aug 2021 06:31:36 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 17FF8221D4;
        Wed, 11 Aug 2021 10:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628677872; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SkUMkRD2ibe1Pqqvll3AurFf9RTWP5dmf4U5XjJ+PaI=;
        b=SC232zMqJ2Xxom/5bxx0k7LYA2iAwskI/BlOiR7zHeZMIw0HRhYcfMhnea+VJjgui/9UuX
        jnpvw+yKtg+3AVqAA22QBYjmQh65NxL3fXNIlnRZkuIFSF8oY07PVNGFEi7+m0HCIUJpUv
        3q2BAwFvt0u8WcHa/BnspF4SkN3ONeg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628677872;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SkUMkRD2ibe1Pqqvll3AurFf9RTWP5dmf4U5XjJ+PaI=;
        b=NdfMk0J/F3hWZUapkCj9+eP0Ju5XOZbQaBXhps+ItCiPgi23rEA+R+1dEfSbpf1FR7nK7U
        r5l4XR0pQFzThQAw==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 0B8CFA3C14;
        Wed, 11 Aug 2021 10:31:12 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E6E941F2BBE; Wed, 11 Aug 2021 12:31:11 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 4/5] tune2fs: Add support for orphan_file feature
Date:   Wed, 11 Aug 2021 12:30:53 +0200
Message-Id: <20210811103054.7896-5-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210811103054.7896-1-jack@suse.cz>
References: <20210811103054.7896-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4970; h=from:subject; bh=TtKlr+6gvOYQ0G9TptmBgpzyrVpHhYCjluCOeSNrHiU=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBhE6bcn1ZHldApYb0HnD7fQ47HlrNtHgxsSuEMFiW8 WieZeJqJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYROm3AAKCRCcnaoHP2RA2WZFB/ 4iI9pi9T0K8lKy65bACvi1hk4JRM/C0DQCCzUtxuKr3TZBOC0goCtjD5HyJslcKBmNQjOkpO57ICWk 8e6x8H0lwWu+AXXF82z4JkBg1RX24gqnVK/LYO+UUWxvOWOsNO8lz0WEHKRbs2hCz7W77LBcrl1Tes mWkGVhH6a6Tr4dagrYNZdTn42eD21W4ZDT5zSWU+fCbE8BPoYTy/9mJyF0ZAEIP5sJya+ZXF8+aC/8 oqbZqmxu5kmakOFVj7q7CmjQpi+g1QcosW/NTP9nRJ8xM6HaGMhhrU3fm+HCQ4jNCTJpeSf6WgxCbF rI5Y1d2LmtDQF960CIBqoTwGjoxfwf
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

