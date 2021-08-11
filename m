Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5391C3E8E9F
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Aug 2021 12:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237156AbhHKKbg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 Aug 2021 06:31:36 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51262 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237036AbhHKKbg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 Aug 2021 06:31:36 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0CF812014B;
        Wed, 11 Aug 2021 10:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628677872; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uZQEbjJirFAUW6cxysJ1woaNz+YB82ZLBLHoAUJ9ATk=;
        b=aBiNsaJcOhstxsc7oSYYZiFRkRUldEdzWzUARhyTp5NZzcgy4kdcUJC4NeknmilApmPAXt
        tslV5MNarkpwwzL4vYamkUKPfAHc5XgVfQf4QvgoIHBt6ugrba58ms2qrIrswfESWZuYrJ
        B4ihVLrDn9wCS3oRm2Mlh+UnYlmI22s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628677872;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uZQEbjJirFAUW6cxysJ1woaNz+YB82ZLBLHoAUJ9ATk=;
        b=DeRZuKWP1raZjZ8fVU+YSpyBp93Agt9qM0cMINBzYD68apuswl2c0GueAgwe4fxgDv2smO
        B8MNKOUnDHKsUxBA==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 01ECEA3C01;
        Wed, 11 Aug 2021 10:31:12 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id DD1631F2B76; Wed, 11 Aug 2021 12:31:11 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 2/5] mke2fs: Add support for orphan_file feature
Date:   Wed, 11 Aug 2021 12:30:51 +0200
Message-Id: <20210811103054.7896-3-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210811103054.7896-1-jack@suse.cz>
References: <20210811103054.7896-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4275; h=from:subject; bh=+uc4hJRJyXZeQrDeeAPRIPkTXJwy94Ibvj0HDePX+Tc=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBhE6baIIjuAnHWAMNm1sdu7uYYANC7m+c1w6GZsSBr DenVJlOJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYROm2gAKCRCcnaoHP2RA2S6YB/ 4sowHOdymvVn9ezh2sAEH8TGBhWLJZK2QAVYfMriJRr2VEf6skKQkvUmmQMD94kc7uguaEq9O9CI+c BRcXELphMqtU8Ya5gA1BzjQcuCJ/fV8Sy2SeMATjeuqD15/car7mmG5x6mnPKk4xHCGWnstKpsKW2s eNXTn3aQ8f6vPRztC+EREwnLb5OTF2LCHGEqB+QtScE/VtajCyLJ0GmkZX3AayZRnTVVliVrz56Upz euwPK+R8tvXJkoTpr9ioiDDKc25mrzqflLDXGs2RE+wHnEP+23CN1+UGsiLwwRFB8o18Gve71Tr3MP XkJZIRxF/OY1Aew5GaBXQihmutivhd
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Signed-off-by: Jan Kara <jack@suse.cz>
---
 misc/mke2fs.8.in |  5 +++++
 misc/mke2fs.c    | 53 +++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/misc/mke2fs.8.in b/misc/mke2fs.8.in
index 84248ffc9e1d..3747c93a02bf 100644
--- a/misc/mke2fs.8.in
+++ b/misc/mke2fs.8.in
@@ -403,6 +403,11 @@ filesystem to change based on the user running \fBmke2fs\fR.
 Set a flag in the filesystem superblock indicating that it may be
 mounted using experimental kernel code, such as the ext4dev filesystem.
 .TP
+.BI orphan_file_size= size
+Set size of the file for tracking unlinked but still open inodes and inodes
+with truncate in progress. Larger file allows for better scalability, reserving
+a few blocks per cpu is ideal.
+.TP
 .B discard
 Attempt to discard blocks at mkfs time (discarding blocks initially is useful
 on solid state devices and sparse / thin-provisioned storage). When the device
diff --git a/misc/mke2fs.c b/misc/mke2fs.c
index 92003e119558..579d6d18474c 100644
--- a/misc/mke2fs.c
+++ b/misc/mke2fs.c
@@ -94,6 +94,7 @@ static gid_t	root_gid;
 int	journal_size;
 int	journal_flags;
 int	journal_fc_size;
+static e2_blkcnt_t	orphan_file_blocks;
 static int	lazy_itable_init;
 static int	packed_meta_blocks;
 int		no_copy_xattrs;
@@ -1089,6 +1090,21 @@ static void parse_extended_opts(struct ext2_super_block *param,
 				continue;
 			}
 			encoding_flags = arg;
+		} else if (!strcmp(token, "orphan_file_size")) {
+			if (!arg) {
+				r_usage++;
+				badopt = token;
+				continue;
+			}
+			orphan_file_blocks = parse_num_blocks2(arg,
+						fs_param.s_log_block_size);
+			if (orphan_file_blocks == 0) {
+				fprintf(stderr,
+					_("Invalid size of orphan file %s\n"),
+					arg);
+				r_usage++;
+				continue;
+			}
 		} else {
 			r_usage++;
 			badopt = token;
@@ -1156,7 +1172,8 @@ static __u32 ok_features[3] = {
 		EXT2_FEATURE_COMPAT_EXT_ATTR |
 		EXT4_FEATURE_COMPAT_SPARSE_SUPER2 |
 		EXT4_FEATURE_COMPAT_FAST_COMMIT |
-		EXT4_FEATURE_COMPAT_STABLE_INODES,
+		EXT4_FEATURE_COMPAT_STABLE_INODES |
+		EXT4_FEATURE_COMPAT_ORPHAN_FILE,
 	/* Incompat */
 	EXT2_FEATURE_INCOMPAT_FILETYPE|
 		EXT3_FEATURE_INCOMPAT_EXTENTS|
@@ -1551,6 +1568,7 @@ static void PRS(int argc, char *argv[])
 	int		lsector_size = 0, psector_size = 0;
 	int		show_version_only = 0, is_device = 0;
 	unsigned long long num_inodes = 0; /* unsigned long long to catch too-large input */
+	int		default_orphan_file = 0;
 	errcode_t	retval;
 	char *		oldpath = getenv("PATH");
 	char *		extended_opts = 0;
@@ -2098,8 +2116,20 @@ profile_error:
 		ext2fs_clear_feature_ea_inode(&fs_param);
 		ext2fs_clear_feature_casefold(&fs_param);
 	}
-	edit_feature(fs_features ? fs_features : tmp,
-		     &fs_param.s_feature_compat);
+	if (!fs_features && tmp)
+		edit_feature(tmp, &fs_param.s_feature_compat);
+	/*
+	 * Now all the defaults are incorporated in fs_param. Check the state
+	 * of orphan_file feature so that we know whether we should silently
+	 * disabled in case journal gets disabled.
+	 */
+	if (ext2fs_has_feature_orphan_file(&fs_param))
+		default_orphan_file = 1;
+	if (fs_features)
+		edit_feature(fs_features, &fs_param.s_feature_compat);
+	/* Silently disable orphan_file if user chose fs without journal */
+	if (default_orphan_file && !ext2fs_has_feature_journal(&fs_param))
+		ext2fs_clear_feature_orphan_file(&fs_param);
 	if (tmp)
 		free(tmp);
 	(void) ext2fs_free_mem(&fs_features);
@@ -3456,6 +3486,23 @@ no_journal:
 		fix_cluster_bg_counts(fs);
 	if (ext2fs_has_feature_quota(&fs_param))
 		create_quota_inodes(fs);
+	if (ext2fs_has_feature_orphan_file(&fs_param)) {
+		if (!ext2fs_has_feature_journal(&fs_param)) {
+			com_err(program_name, 0, _("cannot set orphan_file "
+				"feature without a journal."));
+			exit(1);
+		}
+		if (!orphan_file_blocks) {
+			orphan_file_blocks =
+				ext2fs_default_orphan_file_blocks(fs);
+		}
+		retval = ext2fs_create_orphan_file(fs, orphan_file_blocks);
+		if (retval) {
+			com_err(program_name, retval,
+				_("while creating orphan file"));
+			exit(1);
+		}
+	}
 
 	retval = mk_hugefiles(fs, device_name);
 	if (retval)
-- 
2.26.2

