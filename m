Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A65956B9A6
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Jul 2022 14:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237475AbiGHM1d (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 8 Jul 2022 08:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237963AbiGHM1b (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 8 Jul 2022 08:27:31 -0400
Received: from root.slava.cc (root.slava.cc [168.119.137.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE942B251
        for <linux-ext4@vger.kernel.org>; Fri,  8 Jul 2022 05:27:30 -0700 (PDT)
From:   Slava Bacherikov <slava@bacher09.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bacher09.org;
        s=reg; t=1657283244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2pnT+cKJb0GEeSOBS2tVmeaQxBfZLnXtqNiRq6OYBTs=;
        b=a5mCG3cuixPbzeh1ahqsWJVSb+FFf2ulyT+NFVfEdf/3eoUQfgB93lPcSCMGnE/0UvVeNj
        xCjXRhJgN02mYVms+quMfO7WR7ZOWlbMrNRWhGK6LQcHWpLZu7I3hOlalXuXSuWftbAxjJ
        IEHI7kRQJgsHilzVn9daO5ioaMdD6t4=
To:     krisman@collabora.com
Cc:     ebiggers@kernel.org, tytso@mit.edu, linux-ext4@vger.kernel.org,
        Slava Bacherikov <slava@bacher09.org>
Subject: [PATCH v4] tune2fs: allow disabling casefold feature
Date:   Fri,  8 Jul 2022 15:26:58 +0300
Message-Id: <20220708122658.17907-1-slava@bacher09.org>
In-Reply-To: <87pmig39yb.fsf@collabora.com>
References: <87pmig39yb.fsf@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Casefold can be safely disabled if there are no directories with +F
attribute ( EXT4_CASEFOLD_FL ). This checks all inodes for that flag and in
case there isn't any, it disables casefold FS feature. When FS has
directories with +F attributes, user could convert these directories,
probably by mounting FS and executing some script or by doing it
manually. Afterwards, it would be possible to disable casefold FS flag
via tune2fs.

Signed-off-by: Slava Bacherikov <slava@bacher09.org>
Reviewed-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 misc/tune2fs.8.in |  6 ++++--
 misc/tune2fs.c    | 54 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/misc/tune2fs.8.in b/misc/tune2fs.8.in
index 628dcdc0..dcf108c1 100644
--- a/misc/tune2fs.8.in
+++ b/misc/tune2fs.8.in
@@ -593,8 +593,10 @@ Enable the file system to be larger than 2^32 blocks.
 .TP
 .B casefold
 Enable support for file system level casefolding.
-.B Tune2fs
-currently only supports setting this file system feature.
+The option can be cleared only if filesystem has no
+directories with
+.B F
+attribute.
 .TP
 .B dir_index
 Use hashed b-trees to speed up lookups for large directories.
diff --git a/misc/tune2fs.c b/misc/tune2fs.c
index 6c162ba5..a8355619 100644
--- a/misc/tune2fs.c
+++ b/misc/tune2fs.c
@@ -204,7 +204,8 @@ static __u32 clear_ok_features[3] = {
 		EXT4_FEATURE_INCOMPAT_FLEX_BG |
 		EXT4_FEATURE_INCOMPAT_MMP |
 		EXT4_FEATURE_INCOMPAT_64BIT |
-		EXT4_FEATURE_INCOMPAT_CSUM_SEED,
+		EXT4_FEATURE_INCOMPAT_CSUM_SEED |
+		EXT4_FEATURE_INCOMPAT_CASEFOLD,
 	/* R/O compat */
 	EXT2_FEATURE_RO_COMPAT_LARGE_FILE |
 		EXT4_FEATURE_RO_COMPAT_HUGE_FILE|
@@ -1020,6 +1021,41 @@ out:
 	return retval;
 }
 
+static int has_casefold_inode(ext2_filsys fs)
+{
+	int length = EXT2_INODE_SIZE(fs->super);
+	struct ext2_inode *inode = NULL;
+	ext2_inode_scan	scan;
+	errcode_t	retval;
+	ext2_ino_t	ino;
+	int found_casefold = 0;
+
+	retval = ext2fs_get_mem(length, &inode);
+	if (retval)
+		fatal_err(retval, "while allocating memory");
+
+	retval = ext2fs_open_inode_scan(fs, 0, &scan);
+	if (retval)
+		fatal_err(retval, "while opening inode scan");
+
+	do {
+		retval = ext2fs_get_next_inode_full(scan, &ino, inode, length);
+		if (retval)
+			fatal_err(retval, "while getting next inode");
+		if (!ino)
+			break;
+
+		if(inode->i_flags & EXT4_CASEFOLD_FL) {
+			found_casefold = 1;
+			break;
+		}
+	} while(1);
+
+	ext2fs_free_mem(&inode);
+	ext2fs_close_inode_scan(scan);
+	return found_casefold;
+}
+
 static errcode_t disable_uninit_bg(ext2_filsys fs, __u32 csum_feature_flag)
 {
 	struct ext2_group_desc *gd;
@@ -1554,6 +1590,22 @@ mmp_error:
 		enabling_casefold = 1;
 	}
 
+	if (FEATURE_OFF(E2P_FEATURE_INCOMPAT, EXT4_FEATURE_INCOMPAT_CASEFOLD)) {
+		if (mount_flags & EXT2_MF_MOUNTED) {
+			fputs(_("The casefold feature may only be disabled when "
+				"the filesystem is unmounted.\n"), stderr);
+			return 1;
+		}
+		if (has_casefold_inode(fs)) {
+			fputs(_("The casefold feature can't be cleared when "
+					"there are inodes with +F flag.\n"), stderr);
+			return 1;
+		}
+		fs->super->s_encoding = 0;
+		fs->super->s_encoding_flags = 0;
+		enabling_casefold = 0;
+	}
+
 	if (FEATURE_ON(E2P_FEATURE_INCOMPAT,
 		EXT4_FEATURE_INCOMPAT_CSUM_SEED)) {
 		if (!ext2fs_has_feature_metadata_csum(sb)) {
