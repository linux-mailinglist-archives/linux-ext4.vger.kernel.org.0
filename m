Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B96783F7E39
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Aug 2021 00:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbhHYWMe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 25 Aug 2021 18:12:34 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60646 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbhHYWMd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 25 Aug 2021 18:12:33 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 94CC01FE45;
        Wed, 25 Aug 2021 22:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629929506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aHeZMHiiP0PVVjcLn86Q2O8XQXGrVd/5SuY6AKE7Gnc=;
        b=DL6NJ8uC4eaAJyuAJHmvnirwWZpWK9eyp8VLfbbwGE3LW36MF/gbo5H28YSmYmatHUFhtU
        BRN5yGOx9bcWhwgyA8tmalodH3px8fYIVMVCzTJdjZZqTedQE9svjTumKwsf7r+wap7ijx
        5UKQp14TmV/P6TELbvRr8ycTpwYJeRU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629929506;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aHeZMHiiP0PVVjcLn86Q2O8XQXGrVd/5SuY6AKE7Gnc=;
        b=yfYcPoP6lI3fO+S4KDKHWBdmxJ2irxLhJZGQzTh8ql3Xd5CNq9kVGUFjc9akgjz9g0HhNn
        IEPD0F8tMZSu7PDQ==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 841A4A3B8B;
        Wed, 25 Aug 2021 22:11:46 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E1D361E0BD5; Thu, 26 Aug 2021 00:11:43 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 2/5] mke2fs: Add support for orphan_file feature
Date:   Thu, 26 Aug 2021 00:11:31 +0200
Message-Id: <20210825221143.30705-2-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210825220922.4157-1-jack@suse.cz>
References: <20210825220922.4157-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4278; h=from:subject; bh=t6gUqPu1WTe4vJAIJsa5AbSGstdE6v1LNZj0p9U4jxw=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBhJsAT9WElGctlkiPV8hGviZxil/v8DNZYMD87U1o4 6Esb5XKJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYSbAEwAKCRCcnaoHP2RA2YRnCA Df07uY7ViNjBu+19Ww0nJq9obbdiC2QMFwlw74Urje9g5K1djVf1sHQOUzL3R4XUdLUkNr++g4FhGs DhDUvSZ4wiqoXJMqEWLp+dXZeDErZD0YjqcycT2uk5fS9fjIwkeQfyOh5vJdO5jN8YmrmnvGpI2cVi UX+kE+b6W0ethpxgH080hnl/6+U3K49YRctP7srdxjRVqpnFBIi0ZVKsmU5XCNyqidpsuVFfRyZIe3 +trT7lHCDXS8mIgN0jk8Fu7XdipoRJwhHQYQ6l4nJx1E9uRbskDsltONdyJEFpa2vczOAG7cihR9l4 tfq9D4gbKssOd+Jii4w2SUsGQOc8XI
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
index c0b5324569a1..b378e4d7c5e1 100644
--- a/misc/mke2fs.8.in
+++ b/misc/mke2fs.8.in
@@ -403,6 +403,11 @@ file system to change based on the user running \fBmke2fs\fR.
 Set a flag in the file system superblock indicating that it may be
 mounted using experimental kernel code, such as the ext4dev file system.
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
index 04b2fbce638a..c955b318e960 100644
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
@@ -2101,8 +2119,20 @@ profile_error:
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
@@ -3471,6 +3501,23 @@ no_journal:
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

