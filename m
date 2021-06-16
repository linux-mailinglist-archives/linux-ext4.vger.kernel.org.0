Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B65E3A9851
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Jun 2021 12:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbhFPK75 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Jun 2021 06:59:57 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:35826 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbhFPK7x (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Jun 2021 06:59:53 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id ECA311FD83;
        Wed, 16 Jun 2021 10:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623841065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=whp0qX1mVlnCabp4mvghIfzu6AhzRtxMM9JEx7Yp6N8=;
        b=n6naESjjmtw9UYjTG9VkL/aRtZQWeiV3izjhXZeKEf3upX7dc13S8Mbzb114KTlhdR25zc
        oWL+qwY9GT/Syj2SymxrbHVtCaYpSlPoSYgUyohCgPKIpm68BHW4eVrxiB37kF3wQSQIZG
        JqsdlmGVhFQnye30pdbnnuIKKfFGqxo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623841065;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=whp0qX1mVlnCabp4mvghIfzu6AhzRtxMM9JEx7Yp6N8=;
        b=UH2HXk37yenkH6gTFcuGezzBBPpZdTrn6s194P0VeEgTWK5F1XyyUAlU7GlFjw/Ggg2GJJ
        QLdLSnI7YBn/x1Ag==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id B34ABA3B81;
        Wed, 16 Jun 2021 10:57:45 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6B7EA1F2CBD; Wed, 16 Jun 2021 12:57:45 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 5/9] mke2fs: Add support for orphan_file feature
Date:   Wed, 16 Jun 2021 12:57:31 +0200
Message-Id: <20210616105735.5424-6-jack@suse.cz>
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
 misc/mke2fs.8.in |  5 +++++
 misc/mke2fs.c    | 36 +++++++++++++++++++++++++++++++++++-
 2 files changed, 40 insertions(+), 1 deletion(-)

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
index afbcf486bad2..8a5cf9b920e6 100644
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
@@ -1087,6 +1088,21 @@ static void parse_extended_opts(struct ext2_super_block *param,
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
@@ -1154,7 +1170,8 @@ static __u32 ok_features[3] = {
 		EXT2_FEATURE_COMPAT_EXT_ATTR |
 		EXT4_FEATURE_COMPAT_SPARSE_SUPER2 |
 		EXT4_FEATURE_COMPAT_FAST_COMMIT |
-		EXT4_FEATURE_COMPAT_STABLE_INODES,
+		EXT4_FEATURE_COMPAT_STABLE_INODES |
+		EXT4_FEATURE_COMPAT_ORPHAN_FILE,
 	/* Incompat */
 	EXT2_FEATURE_INCOMPAT_FILETYPE|
 		EXT3_FEATURE_INCOMPAT_EXTENTS|
@@ -3438,6 +3455,23 @@ no_journal:
 		fix_cluster_bg_counts(fs);
 	if (ext2fs_has_feature_quota(&fs_param))
 		create_quota_inodes(fs);
+	if (ext2fs_has_feature_orphan_file(&fs_param)) {
+		if (!ext2fs_has_feature_journal(&fs_param)) {
+			com_err(program_name, 0, _("cannot set orphan_file "
+				"flag without a journal."));
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

